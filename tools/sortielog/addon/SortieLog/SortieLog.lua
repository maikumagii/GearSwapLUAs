--[[
SortieLog: logs weapon skill, melee and ranged damage against monsters, plus the
debuffs/buffs around each hit, so pDIF-cap status can be judged from damage spread.

Output:
  * CSV per session in <addon>/data/logs/<session>.csv
  * Optional live push: one JSON object per UDP datagram to a SortieLog server.

Commands (//slog ...):
  status                      Show settings and current flags.
  udp on|off                  Toggle live UDP push.
  host <ip-or-name> [port]    Set the server address (default port 5140).
  token <text>|clear          Shared token the server expects (optional).
  flag <name> [on|off]        Manual context flags (frailty, aria, sv_aria, ...).
  flags                       List active flags.  "flag clear" removes all.
  note <text>                 Write a free-text note row.
  acc <main> [sub]            Set Accuracy by hand (normally read from /checkparam).
  new                         Start a new session/CSV file.
  test                        Send a test row.
]]

_addon.name = 'SortieLog'
_addon.author = 'Kalali'
_addon.version = '0.2.0'
_addon.commands = { 'slog', 'sortielog' }

local config = require('config')
local res = require('resources')
local packets = require('packets')
local socket = require('socket')

local SCHEMA_VERSION = 3
local COLUMNS = {
    'v', 't', 'session', 'seq', 'zone', 'kind', 'actor', 'actor_id', 'is_me', 'target', 'target_id',
    'target_hpp', 'ws', 'damage', 'crit', 'hand', 'msg', 'tp', 'job', 'buffs', 'mob_status',
    'flags', 'wall_same', 'wall_distinct', 'detail', 'attack', 'accuracy', 'acc_sub', 'weapon',
}

local defaults = {
    udp = { enabled = false, host = '192.168.1.50', port = 5140 },
    token = '',
    csv = true,
    log_party = true,
    log_melee = true,
    only_targets = '', -- comma-separated monster names; empty logs every monster
}
local settings = config.load(defaults)

-- Message IDs (Windower action_messages resource).
local MSG_MELEE_HIT, MSG_MELEE_CRIT, MSG_MELEE_MISS = 1, 67, 15
local MSG_RANGED = { [352] = 'hit', [353] = 'crit', [354] = 'miss', [576] = 'hit', [577] = 'hit' }
local MSG_WS_HIT, MSG_WS_MISS, MSG_WS_AOE = 185, 188, 264
local MSG_DEFEAT = { [6] = true, [20] = true, [97] = true, [113] = true, [406] = true, [605] = true, [646] = true }
local CAT_MELEE, CAT_RANGED, CAT_WS, CAT_SPELL, CAT_JA, CAT_STEP = 1, 2, 3, 4, 6, 14
local WALL_WINDOW = 6

local state = {
    me_id = nil,
    party = {},          -- [mob_id] = true for party/alliance members
    party_refreshed = 0,
    pending_ws = nil,    -- { tp, t, ws_id } captured from the outgoing WS packet
    mob_status = {},     -- [mob_id] = { [status name] = true }
    ws_history = {},     -- [mob_id] = { ws names, most recent last }
    flags = {},          -- [flag] = true
    attack = nil,        -- main-hand Attack from the 0x061 status packet
    accuracy = nil,      -- main/sub Accuracy from /checkparam or //slog acc
    acc_sub = nil,
    weapon = nil,        -- main weapon skill type, e.g. 'Club', 'Great Sword'
    session = nil,
    seq = 0,             -- per-session row counter; the server dedupes on (uploader, session, seq)
    file = nil,
    ip = nil,
}

local udp = socket.udp()
udp:settimeout(0)

-------------------------------------------------------------------------------
-- Encoding helpers
-------------------------------------------------------------------------------

local function json_escape(s)
    return (s:gsub('[%c"\\]', function(c)
        if c == '"' then return '\\"' end
        if c == '\\' then return '\\\\' end
        if c == '\n' then return '\\n' end
        if c == '\r' then return '\\r' end
        if c == '\t' then return '\\t' end
        return string.format('\\u%04x', c:byte())
    end))
end

local function json_encode(row)
    local parts = {}
    for _, key in ipairs(COLUMNS) do
        local value = row[key]
        if value ~= nil then
            local encoded
            if type(value) == 'number' then
                encoded = (value == math.floor(value) and math.abs(value) < 1e15)
                    and string.format('%d', value) or string.format('%.3f', value)
            elseif type(value) == 'boolean' then
                encoded = value and 'true' or 'false'
            else
                encoded = '"' .. json_escape(tostring(value)) .. '"'
            end
            parts[#parts + 1] = '"' .. key .. '":' .. encoded
        end
    end
    if settings.token ~= '' then
        parts[#parts + 1] = '"token":"' .. json_escape(settings.token) .. '"'
    end
    return '{' .. table.concat(parts, ',') .. '}'
end

local function csv_field(value)
    if value == nil then return '' end
    local s
    if type(value) == 'number' then
        s = (value == math.floor(value)) and string.format('%d', value) or string.format('%.3f', value)
    else
        s = tostring(value)
    end
    if s:find('[,"\r\n]') then
        s = '"' .. s:gsub('"', '""') .. '"'
    end
    return s
end

local function csv_line(row)
    local fields = {}
    for i, key in ipairs(COLUMNS) do fields[i] = csv_field(row[key]) end
    return table.concat(fields, ',')
end

-------------------------------------------------------------------------------
-- Output
-------------------------------------------------------------------------------

local function resolve_host()
    local ip = socket.dns and socket.dns.toip and socket.dns.toip(settings.udp.host)
    state.ip = ip or settings.udp.host
end

local function close_file()
    if state.file then
        state.file:close()
        state.file = nil
    end
end

local function open_session()
    close_file()
    state.session = os.date('%Y%m%d-%H%M%S')
    state.seq = 0
    if not settings.csv then return end
    local dir = windower.addon_path .. 'data/'
    if not windower.dir_exists(dir) then windower.create_dir(dir) end
    dir = dir .. 'logs/'
    if not windower.dir_exists(dir) then windower.create_dir(dir) end
    local file, err = io.open(dir .. state.session .. '.csv', 'a')
    if not file then
        windower.add_to_chat(167, 'SortieLog: cannot open CSV: ' .. tostring(err))
        return
    end
    file:write(table.concat(COLUMNS, ','), '\n')
    file:flush()
    state.file = file
end

local function emit(row)
    state.seq = state.seq + 1
    row.v = SCHEMA_VERSION
    row.session = state.session
    row.seq = state.seq
    if state.file then
        state.file:write(csv_line(row), '\n')
        state.file:flush()
    end
    if settings.udp.enabled and state.ip then
        pcall(udp.sendto, udp, json_encode(row), state.ip, settings.udp.port)
    end
end

-------------------------------------------------------------------------------
-- Context
-------------------------------------------------------------------------------

local function names_from_set(set)
    local list = {}
    for name in pairs(set) do list[#list + 1] = name end
    table.sort(list)
    return table.concat(list, ';')
end

local function refresh_party(force)
    local now = os.clock()
    if not force and now - state.party_refreshed < 5 then return end
    state.party_refreshed = now
    state.party = {}
    local player = windower.ffxi.get_player()
    if player then state.me_id = player.id end
    local party = windower.ffxi.get_party()
    if not party then return end
    for key, member in pairs(party) do
        if type(member) == 'table' and type(key) == 'string' and key:match('^[pa]%d+$') and member.mob then
            state.party[member.mob.id] = true
        end
    end
end

local function target_allowed(name)
    if settings.only_targets == '' then return true end
    for wanted in settings.only_targets:gmatch('[^,]+') do
        if wanted:match('^%s*(.-)%s*$'):lower() == name:lower() then return true end
    end
    return false
end

local function monster_target(id)
    if state.party[id] then return nil end
    local mob = windower.ffxi.get_mob_by_id(id)
    if not mob or not mob.is_npc or (mob.spawn_type and mob.spawn_type ~= 16) then return nil end
    if not target_allowed(mob.name or '') then return nil end
    return mob
end

local function player_context()
    local player = windower.ffxi.get_player()
    if not player then return {} end
    local buffs = {}
    for _, id in ipairs(player.buffs or {}) do
        local buff = res.buffs[id]
        if buff then buffs[#buffs + 1] = buff.en end
    end
    table.sort(buffs)
    local job = tostring(player.main_job or '') .. '/' .. tostring(player.sub_job or '')
    return { job = job, buffs = table.concat(buffs, ';') }
end

local function zone_name()
    local info = windower.ffxi.get_info()
    local zone = info and res.zones[info.zone]
    return zone and zone.en or (info and tostring(info.zone)) or ''
end

local function base_row(kind, actor_id, actor_name, mob)
    local row = {
        t = socket.gettime(),
        zone = zone_name(),
        kind = kind,
        actor = actor_name,
        actor_id = actor_id,
        is_me = (actor_id == state.me_id) and 1 or 0,
        target = mob and mob.name or nil,
        target_id = mob and mob.id or nil,
        target_hpp = mob and mob.hpp or nil,
        mob_status = mob and state.mob_status[mob.id] and names_from_set(state.mob_status[mob.id]) or nil,
        flags = names_from_set(state.flags),
    }
    if row.is_me == 1 then
        local ctx = player_context()
        row.job = ctx.job
        row.buffs = ctx.buffs
        row.attack = state.attack
        row.accuracy = state.accuracy
        row.acc_sub = state.acc_sub
        row.weapon = state.weapon
    end
    return row
end

-- Returns status name and whether it was applied (true) or removed (false).
local function status_change(message_id, param)
    local message = message_id and res.action_messages[message_id]
    if not message or not message.en or not message.en:find('${status}', 1, true) then return nil end
    local buff = res.buffs[param]
    if not buff then return nil end
    local text = message.en:lower()
    if text:find('no longer', 1, true) or text:find('wears off', 1, true)
        or text:find('dispel', 1, true) or text:find('remove', 1, true) then
        return buff.en, false
    end
    return buff.en, true
end

local function track_status(mob, name, applied, actor_id, actor_name, detail)
    local set = state.mob_status[mob.id]
    if applied then
        if not set then
            set = {}
            state.mob_status[mob.id] = set
        end
        set[name] = true
    elseif set then
        set[name] = nil
    end
    local row = base_row(applied and 'status_on' or 'status_off', actor_id, actor_name, mob)
    row.detail = detail and (name .. ' <- ' .. detail) or name
    emit(row)
end

local function wall_features(mob_id, ws_name)
    local history = state.ws_history[mob_id] or {}
    local same, distinct, seen = 0, 0, {}
    local first = math.max(1, #history - WALL_WINDOW + 1)
    for i = first, #history do
        local name = history[i]
        if name == ws_name then same = same + 1 end
        if not seen[name] then
            seen[name] = true
            distinct = distinct + 1
        end
    end
    return same, distinct
end

local function remember_ws(mob_id, ws_name)
    local history = state.ws_history[mob_id]
    if not history then
        history = {}
        state.ws_history[mob_id] = history
    end
    history[#history + 1] = ws_name
    while #history > WALL_WINDOW * 2 do table.remove(history, 1) end
end

-------------------------------------------------------------------------------
-- Action handling
-------------------------------------------------------------------------------

local function ability_name(category, param)
    if category == CAT_SPELL then
        local spell = res.spells[param]
        return spell and spell.en
    end
    local ability = res.job_abilities[param]
    return ability and ability.en
end

local function handle_action(act)
    refresh_party(false)
    local actor_id = act.actor_id
    local is_me = actor_id == state.me_id
    if not is_me and not (settings.log_party and state.party[actor_id]) then return end

    local category = act.category
    local actor = windower.ffxi.get_mob_by_id(actor_id)
    local actor_name = actor and actor.name or tostring(actor_id)

    if category == CAT_WS then
        local ws = res.weapon_skills[act.param]
        if not ws then return end
        local tp
        if is_me and state.pending_ws and state.pending_ws.ws_id == act.param
            and socket.gettime() - state.pending_ws.t < 8 then
            tp = state.pending_ws.tp
        end
        if is_me then state.pending_ws = nil end
        local remembered = {}
        for _, target in ipairs(act.targets) do
            local mob = monster_target(target.id)
            local action = mob and target.actions and target.actions[1]
            if action then
                local msg = action.message
                local kind = (msg == MSG_WS_HIT or msg == MSG_WS_AOE) and 'ws'
                    or (msg == MSG_WS_MISS and 'ws_miss') or 'ws_other'
                local same, distinct = wall_features(mob.id, ws.en)
                local row = base_row(kind, actor_id, actor_name, mob)
                row.ws = ws.en
                row.damage = action.param
                row.msg = msg
                row.tp = tp
                row.wall_same = same
                row.wall_distinct = distinct
                emit(row)
                if not remembered[mob.id] then
                    remember_ws(mob.id, ws.en)
                    remembered[mob.id] = true
                end
            end
        end
        return
    end

    if category == CAT_MELEE or category == CAT_RANGED then
        if not is_me or (category == CAT_MELEE and not settings.log_melee) then return end
        for _, target in ipairs(act.targets) do
            local mob = monster_target(target.id)
            if mob then
                for _, action in ipairs(target.actions or {}) do
                    local msg = action.message
                    local kind, crit
                    if category == CAT_MELEE then
                        if msg == MSG_MELEE_HIT or msg == MSG_MELEE_CRIT then
                            kind, crit = 'melee', (msg == MSG_MELEE_CRIT) and 1 or 0
                        elseif msg == MSG_MELEE_MISS then
                            kind, crit = 'melee_miss', 0
                        end
                    else
                        local outcome = MSG_RANGED[msg]
                        if outcome then
                            kind = outcome == 'miss' and 'ranged_miss' or 'ranged'
                            crit = (outcome == 'crit') and 1 or 0
                        end
                    end
                    if kind then
                        local row = base_row(kind, actor_id, actor_name, mob)
                        row.damage = action.param
                        row.crit = crit
                        row.hand = action.animation
                        row.msg = msg
                        emit(row)
                    end
                end
            end
        end
        return
    end

    if category == CAT_SPELL or category == CAT_JA or category == CAT_STEP then
        local name = ability_name(category, act.param) or ('#' .. tostring(act.param))
        for _, target in ipairs(act.targets) do
            local mob = monster_target(target.id)
            if mob then
                for _, action in ipairs(target.actions or {}) do
                    local status, applied = status_change(action.message, action.param)
                    local row = base_row('party_action', actor_id, actor_name, mob)
                    row.detail = name
                    row.msg = action.message
                    if not status then row.damage = action.param end
                    emit(row)
                    if status then track_status(mob, status, applied, actor_id, actor_name, name) end
                    if action.has_add_effect then
                        status, applied = status_change(action.add_effect_message, action.add_effect_param)
                        if status then track_status(mob, status, applied, actor_id, actor_name, name) end
                    end
                end
            end
        end
    end
end

local function handle_action_message(actor_id, target_id, message_id, param_1)
    if MSG_DEFEAT[message_id] then
        state.mob_status[target_id] = nil
        state.ws_history[target_id] = nil
        return
    end
    if not state.mob_status[target_id] then return end
    local status, applied = status_change(message_id, param_1)
    if not status then return end
    local mob = windower.ffxi.get_mob_by_id(target_id)
    if mob then track_status(mob, status, applied, actor_id, '', nil) end
end

-------------------------------------------------------------------------------
-- Stats: Attack (0x061), weapon type, Accuracy (/checkparam)
-------------------------------------------------------------------------------

local function refresh_weapon()
    local equipment = windower.ffxi.get_items('equipment')
    if not equipment or not equipment.main or equipment.main == 0 then
        state.weapon = 'Hand-to-Hand'
        return
    end
    local item = windower.ffxi.get_items(equipment.main_bag, equipment.main)
    local info = item and item.id and res.items[item.id]
    local skill = info and info.skill and res.skills[info.skill]
    state.weapon = skill and skill.en or nil
end

local function handle_char_stats(data)
    local packet = packets.parse('incoming', data)
    if packet and packet.Attack then
        state.attack = packet.Attack
    end
    refresh_weapon()
end

-- Pulls main/sub Accuracy out of /checkparam output, skipping ranged and magic accuracy.
local function parse_accuracy(text)
    local lower = text:lower():gsub(',', '')
    local found = {}
    local start = 1
    while true do
        local s, e = lower:find('accuracy', start, true)
        if not s then break end
        local before = lower:sub(math.max(1, s - 8), s - 1)
        if not before:find('ranged', 1, true) and not before:find('magic', 1, true) then
            local number = lower:match('^%D-(%d+)', e + 1)
            if number then found[#found + 1] = tonumber(number) end
        end
        start = e + 1
    end
    return found[1], found[2]
end

local function handle_incoming_text(text)
    if not text or not text:lower():find('accuracy', 1, true) then return end
    local player = windower.ffxi.get_player()
    if not player or not text:find(player.name, 1, true) then return end
    local main, sub = parse_accuracy(text)
    if not main then return end
    state.accuracy = main
    if sub then state.acc_sub = sub end
    windower.add_to_chat(207, ('SortieLog: accuracy main %d%s (from /checkparam)'):format(
        main, sub and (' sub ' .. sub) or ''))
end

-------------------------------------------------------------------------------
-- Events
-------------------------------------------------------------------------------

local function report_error(err)
    windower.add_to_chat(167, 'SortieLog error: ' .. tostring(err))
end

windower.register_event('action', function(act)
    local ok, err = pcall(handle_action, act)
    if not ok then report_error(err) end
end)

windower.register_event('action message', function(actor_id, target_id, actor_index, target_index, message_id, param_1)
    local ok, err = pcall(handle_action_message, actor_id, target_id, message_id, param_1)
    if not ok then report_error(err) end
end)

windower.register_event('outgoing chunk', function(id, data)
    if id ~= 0x01A then return end
    local ok, packet = pcall(packets.parse, 'outgoing', data)
    if not ok or not packet or packet.Category ~= 7 then return end
    local player = windower.ffxi.get_player()
    if player then
        state.pending_ws = { tp = player.vitals.tp, t = socket.gettime(), ws_id = packet.Param }
    end
end)

windower.register_event('incoming chunk', function(id, data)
    if id ~= 0x061 then return end
    local ok, err = pcall(handle_char_stats, data)
    if not ok then report_error(err) end
end)

windower.register_event('incoming text', function(original)
    local ok, err = pcall(handle_incoming_text, original)
    if not ok then report_error(err) end
end)

windower.register_event('zone change', function()
    state.mob_status = {}
    state.ws_history = {}
    refresh_party(true)
end)

windower.register_event('load', 'login', function()
    resolve_host()
    refresh_party(true)
    pcall(refresh_weapon)
    if not state.session then open_session() end
end)

windower.register_event('unload', 'logout', close_file)

-------------------------------------------------------------------------------
-- Commands
-------------------------------------------------------------------------------

local function say(text)
    windower.add_to_chat(207, 'SortieLog: ' .. text)
end

local function show_status()
    say(('session %s | csv %s | udp %s -> %s:%d | party %s | targets %s'):format(
        tostring(state.session), settings.csv and 'on' or 'off', settings.udp.enabled and 'on' or 'off',
        tostring(settings.udp.host), settings.udp.port, settings.log_party and 'on' or 'off',
        settings.only_targets == '' and 'all' or settings.only_targets))
    say('flags: ' .. (names_from_set(state.flags) ~= '' and names_from_set(state.flags) or 'none'))
    say(('attack %s | accuracy %s / %s | weapon %s'):format(tostring(state.attack), tostring(state.accuracy),
        tostring(state.acc_sub), tostring(state.weapon)))
end

windower.register_event('addon command', function(command, ...)
    local args = { ... }
    command = (command or 'status'):lower()
    if command == 'status' then
        show_status()
    elseif command == 'udp' then
        settings.udp.enabled = (args[1] or ''):lower() == 'on'
        config.save(settings)
        resolve_host()
        show_status()
    elseif command == 'host' and args[1] then
        settings.udp.host = args[1]
        if tonumber(args[2]) then settings.udp.port = tonumber(args[2]) end
        config.save(settings)
        resolve_host()
        show_status()
    elseif command == 'token' and args[1] then
        settings.token = args[1]:lower() == 'clear' and '' or args[1]
        config.save(settings)
        say(settings.token == '' and 'token cleared' or 'token set')
    elseif command == 'targets' then
        settings.only_targets = table.concat(args, ' ')
        config.save(settings)
        show_status()
    elseif command == 'flag' and args[1] then
        local name = args[1]:lower()
        if name == 'clear' then
            state.flags = {}
        else
            local mode = (args[2] or 'on'):lower()
            state.flags[name] = (mode ~= 'off') or nil
        end
        local row = base_row('flag', state.me_id, '', nil)
        row.detail = names_from_set(state.flags)
        emit(row)
        say('flags: ' .. (row.detail ~= '' and row.detail or 'none'))
    elseif command == 'acc' and tonumber(args[1]) then
        state.accuracy = tonumber(args[1])
        state.acc_sub = tonumber(args[2]) or state.acc_sub
        say(('accuracy main %d%s'):format(state.accuracy, state.acc_sub and (' sub ' .. state.acc_sub) or ''))
    elseif command == 'flags' then
        say('flags: ' .. (names_from_set(state.flags) ~= '' and names_from_set(state.flags) or 'none'))
    elseif command == 'note' then
        local row = base_row('note', state.me_id, '', nil)
        row.detail = table.concat(args, ' ')
        emit(row)
        say('note logged')
    elseif command == 'new' then
        open_session()
        say('new session ' .. state.session)
    elseif command == 'test' then
        local row = base_row('test', state.me_id, '', nil)
        row.detail = 'test row'
        emit(row)
        say('test row written' .. (settings.udp.enabled and (' and sent to ' .. tostring(state.ip)) or ''))
    else
        say('commands: status, acc <main> [sub], udp on|off, host <ip> [port], token <t>|clear, targets <names>, flag <name> [on|off], flags, note <text>, new, test')
    end
end)
