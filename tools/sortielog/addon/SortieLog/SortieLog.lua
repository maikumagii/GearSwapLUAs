--[[
SortieLog: logs weapon skill, melee and ranged damage against monsters, plus the
debuffs/buffs around each hit, so pDIF-cap status can be judged from damage spread.

Output:
  * CSV per session in <addon>/data/logs/<session>.csv
  * Optional live upload: batched HTTP POSTs to <url>/ingest/csv (//slog http on), or
    one JSON object per UDP datagram on a LAN.

Commands (//slog ...):
  status                      Show settings and current flags.
  http on|off                 Live upload to the server (plain http; uses the token as your key).
  url <http://host[:port]>    Server address for live upload.
  flush                       Send queued rows now.
  udp on|off                  Toggle live UDP push (LAN only).
  host <ip-or-name> [port]    Set the server address (default port 5140).
  token <key>|clear           Your player key (http upload, and UDP if the server requires it).
  flag <name> [on|off]        Manual context flags (frailty, aria, sv_aria, ...).
  flags                       List active flags.  "flag clear" removes all.
  note <text>                 Write a free-text note row.
  checkparam                  Measure Accuracy now (/checkparam, output shown).
  autocheck on|off            Run /checkparam automatically (hidden) for new buff/gear states.
  acc <main> [sub]            Set Accuracy by hand for the current buff/gear state.
  new                         Start a new session/CSV file.
  test                        Send a test row.
]]

_addon.name = 'SortieLog'
_addon.author = 'Kalali'
_addon.version = '0.3.0'
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
    -- Live upload straight from the game. Plain http only: Windower's Lua has no TLS.
    http = { enabled = false, url = 'http://sortie.eventmoogle.com' },
    token = '',     -- your player key (sent as X-Token)
    csv = true,
    autocheck = true,   -- run /checkparam (hidden) when buffs/gear reach an unmeasured state
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
    mob_tags = {},       -- [mob_id] = { [key] = { label, expires } } debuffs seen on each monster
    auras = {},          -- [key] = { label, expires } effects that follow a player (Indi-, Entrust)
    recent_ja = {},      -- [actor_id] = { [ability] = time } for Saboteur, Bolster, Blaze of Glory...
    geo = {},            -- [caster_id] = { spell, mob_id, label, t, seen } active Geo- bubbles
    acc_cache = {},      -- [signature] = { main, sub, t } Accuracy measured under that buff/gear state
    sig = nil,           -- current buff + gear signature
    sig_since = 0,
    last_autocheck = 0,
    check = nil,         -- open /checkparam capture window { sig, t, hide, parts }
    tick = 0,
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

-------------------------------------------------------------------------------
-- Live HTTP upload (non-blocking)
--
-- Rows are queued and POSTed as CSV to <url>/ingest/csv every few seconds. The socket is
-- non-blocking and advanced a little on every rendered frame, so the game never waits on
-- the network. Rows leave the queue only after the server answers 2xx; on failure they're
-- retried with backoff. Everything is also in the CSV, and the server ignores duplicates.
-------------------------------------------------------------------------------

local HTTP_FLUSH_SECONDS = 5
local HTTP_MAX_BATCH = 500
local HTTP_MAX_QUEUE = 20000
local HTTP_TIMEOUT = 15
local HTTP_RESOLVE_RETRY = 300

local http = {
    queue = {},        -- CSV lines waiting for upload, oldest first
    request = nil,     -- in-flight request state
    target = nil,      -- { host, port, base, ip }
    next_attempt = 0,
    last_send = 0,
    backoff = HTTP_FLUSH_SECONDS,
    last_resolve = 0,
    sent = 0,
    status = 'idle',
    warned = nil,
}

local function parse_http_url(url)
    local scheme, rest = tostring(url or ''):match('^(%a+)://(.+)$')
    if not scheme then return nil, 'url must look like http://host' end
    if scheme:lower() ~= 'http' then
        return nil, 'only http:// works from inside the game (Windower Lua has no TLS)'
    end
    local hostport, path = rest:match('^([^/]+)(.*)$')
    local host, port = hostport:match('^(.-):(%d+)$')
    host = host or hostport
    return { host = host, port = tonumber(port) or 80, base = (path or ''):gsub('/+$', '') }
end

local function http_resolve()
    http.last_resolve = socket.gettime()
    local target, err = parse_http_url(settings.http.url)
    if not target then
        http.target, http.status = nil, err
        return false
    end
    target.ip = socket.dns and socket.dns.toip and socket.dns.toip(target.host)   -- blocks briefly
    if not target.ip then
        http.target, http.status = nil, 'cannot resolve ' .. target.host
        return false
    end
    http.target = target
    return true
end

local function http_note(status, text)
    http.status = status
    if text and http.warned ~= status then
        windower.add_to_chat(167, 'SortieLog upload: ' .. text)
    end
    http.warned = text and status or nil
end

local function http_finish(ok, detail)
    local request = http.request
    http.request = nil
    if request and request.tcp then pcall(request.tcp.close, request.tcp) end
    local now = socket.gettime()
    if ok then
        local rest = {}
        for i = request.count + 1, #http.queue do rest[#rest + 1] = http.queue[i] end
        http.queue = rest
        http.sent = http.sent + request.count
        http.backoff = HTTP_FLUSH_SECONDS
        http.next_attempt = now
        if http.warned then windower.add_to_chat(207, 'SortieLog upload: working again') end
        http_note('ok', nil)
    else
        http.next_attempt = now + http.backoff
        http.backoff = math.min(http.backoff * 2, 120)
        http_note(detail, detail .. ' (retrying; rows are safe in the CSV)')
        if now - http.last_resolve > HTTP_RESOLVE_RETRY then http_resolve() end
    end
end

local function http_start()
    local target = http.target
    local count = math.min(#http.queue, HTTP_MAX_BATCH)
    local lines = {}
    for i = 1, count do lines[i] = http.queue[i] end
    local body = table.concat(COLUMNS, ',') .. '\n' .. table.concat(lines, '\n') .. '\n'
    local host = target.port == 80 and target.host or (target.host .. ':' .. target.port)
    local data = ('POST %s/ingest/csv HTTP/1.1\r\nHost: %s\r\nContent-Type: text/csv; charset=utf-8\r\n'
        .. 'X-Token: %s\r\nUser-Agent: SortieLog/%s\r\nContent-Length: %d\r\nConnection: close\r\n\r\n'):format(
        target.base, host, settings.token, _addon.version, #body) .. body
    local tcp = socket.tcp()
    tcp:settimeout(0)
    http.request = { tcp = tcp, data = data, sent = 0, buffer = '', count = count,
                     phase = 'connect', started = socket.gettime() }
    http.last_send = socket.gettime()
    local ok, err = tcp:connect(target.ip, target.port)
    if not ok and err ~= 'timeout' and err ~= 'Operation already in progress' then
        http_finish(false, 'connect failed: ' .. tostring(err))
    end
end

local function http_step()
    local request = http.request
    if socket.gettime() - request.started > HTTP_TIMEOUT then
        return http_finish(false, 'request timed out')
    end
    local tcp = request.tcp
    if request.phase == 'connect' then
        local _, writable = socket.select(nil, { tcp }, 0)
        if not writable or not writable[1] then return end
        request.phase = 'send'
    end
    if request.phase == 'send' then
        local last, err, partial = tcp:send(request.data, request.sent + 1)
        if last then
            request.sent = last
        elseif err == 'timeout' then
            request.sent = partial or request.sent
        else
            return http_finish(false, 'send failed: ' .. tostring(err))
        end
        if request.sent >= #request.data then request.phase = 'receive' end
        return
    end
    -- receive: only the status line matters
    local chunk, err, partial = tcp:receive(4096)
    request.buffer = request.buffer .. (chunk or partial or '')
    local code = tonumber(request.buffer:match('^HTTP/%d%.%d (%d%d%d)'))
    if code then
        if code >= 200 and code < 300 then return http_finish(true) end
        if code == 401 then return http_finish(false, 'server rejected the key (//slog token <key>)') end
        return http_finish(false, 'server answered HTTP ' .. code)
    end
    if err and err ~= 'timeout' then
        http_finish(false, 'connection ' .. tostring(err) .. ' before a reply')
    end
end

local function http_poll()
    if not settings.http.enabled then return end
    if http.request then return http_step() end
    if #http.queue == 0 then return end
    local now = socket.gettime()
    if now < http.next_attempt or now - http.last_send < HTTP_FLUSH_SECONDS then return end
    if not http.target and (now - http.last_resolve < 30 or not http_resolve()) then
        http.next_attempt = now + 30
        return
    end
    if settings.token == '' then
        http_note('no key', 'no key set (//slog token <key>)')
        http.next_attempt = now + 30
        return
    end
    http_start()
end

local function http_enqueue(line)
    local queue = http.queue
    queue[#queue + 1] = line
    if #queue > HTTP_MAX_QUEUE then
        local rest = {}
        for i = #queue - HTTP_MAX_QUEUE + 1, #queue do rest[#rest + 1] = queue[i] end
        http.queue = rest   -- oldest rows stay in the CSV only
    end
end

local function emit(row)
    state.seq = state.seq + 1
    row.v = SCHEMA_VERSION
    row.session = state.session
    row.seq = state.seq
    local line = csv_line(row)
    if state.file then
        state.file:write(line, '\n')
        state.file:flush()
    end
    if settings.http.enabled then http_enqueue(line) end
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

-------------------------------------------------------------------------------
-- Debuff tags on monsters
--
-- Each debuff is a tag with a label that keeps what affects its potency: the spell tier
-- ("Distract III"), modifiers ("+Saboteur", "+Bolster"), and daze levels ("Box Step lv3").
-- Potencies are not assumed; the server works out each tag's effect from the data later.
-------------------------------------------------------------------------------

local STEP_DAZE = { ['Quick Step'] = 'Lethargic Daze', ['Box Step'] = 'Sluggish Daze',
                    ['Stutter Step'] = 'Weakened Daze', ['Feather Step'] = 'Bewildered Daze' }
local DAZE_STEP = {}
for step, daze in pairs(STEP_DAZE) do DAZE_STEP[daze] = step end
local STEP_SECONDS = 60          -- daze lasts about a minute unless refreshed
local LIGHT_SHOT_SECONDS = 300   -- cleared earlier when Dia wears off
local INDI_SECONDS = 180
local TRACKED_JA = { Saboteur = 60, Bolster = 180, ['Blaze of Glory'] = 60, Entrust = 60,
                     ['Ecliptic Attrition'] = 60 }

local function recent(actor_id, ability)
    local used = state.recent_ja[actor_id] and state.recent_ja[actor_id][ability]
    return used and socket.gettime() - used <= (TRACKED_JA[ability] or 60)
end

local function consume(actor_id, ability)
    if state.recent_ja[actor_id] then state.recent_ja[actor_id][ability] = nil end
end

local function tag_labels(mob_id)
    local now = socket.gettime()
    local labels = {}
    local tags = state.mob_tags[mob_id]
    if tags then
        for key, tag in pairs(tags) do
            if tag.expires and tag.expires < now then
                tags[key] = nil
            else
                labels[#labels + 1] = tag.label
            end
        end
    end
    for key, aura in pairs(state.auras) do
        if aura.expires < now then state.auras[key] = nil else labels[#labels + 1] = aura.label end
    end
    table.sort(labels)
    return table.concat(labels, ';')
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
        mob_status = mob and tag_labels(mob.id) or nil,
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

local function set_tag(mob, key, label, expires, actor_id, actor_name, source)
    local tags = state.mob_tags[mob.id]
    if not tags then
        tags = {}
        state.mob_tags[mob.id] = tags
    end
    local old = tags[key]
    tags[key] = { label = label, expires = expires }
    if old and old.label == label then return end   -- refresh only
    local row = base_row('status_on', actor_id, actor_name, mob)
    row.detail = (source and source ~= label) and (label .. ' <- ' .. source) or label
    emit(row)
end

local function clear_tag(mob_id, key, actor_id)
    local tags = state.mob_tags[mob_id]
    local old = tags and tags[key]
    if not old then return end
    tags[key] = nil
    if key == 'status:Dia' then tags['ja:Light Shot'] = nil end   -- Light Shot rides on Dia
    local mob = windower.ffxi.get_mob_by_id(mob_id)
    local row = base_row('status_off', actor_id, '', mob)
    row.detail = old.label
    emit(row)
end

local function status_key(status)
    local daze = status:match('^(.-) %d+$') or status
    if DAZE_STEP[daze] then return 'step:' .. DAZE_STEP[daze], DAZE_STEP[daze], tonumber(status:match(' (%d+)$')) end
    return 'status:' .. status
end

-- A status landed on (or was removed from) a monster as the result of `source`.
local function apply_status(mob, status, applied, actor_id, actor_name, source, param)
    local key, step, level = status_key(status)
    if not applied then return clear_tag(mob.id, key, actor_id) end
    if step then
        local tags = state.mob_tags[mob.id]
        local previous = tags and tags[key] and tonumber(tags[key].label:match('lv(%d+)$'))
        level = level or ((param and param >= 1 and param <= 10) and param) or ((previous or 0) + 1)
        return set_tag(mob, key, step .. ' lv' .. level, socket.gettime() + STEP_SECONDS, actor_id, actor_name, source)
    end
    local label = source or status
    if res.spells and source and recent(actor_id, 'Saboteur') then
        label = label .. '+Saboteur'
        consume(actor_id, 'Saboteur')
    end
    set_tag(mob, key, label, nil, actor_id, actor_name, source)
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
        local now = socket.gettime()
        if category ~= CAT_SPELL and TRACKED_JA[name] then
            state.recent_ja[actor_id] = state.recent_ja[actor_id] or {}
            state.recent_ja[actor_id][name] = now
            local geo = state.geo[actor_id]
            if geo and (name == 'Ecliptic Attrition' or name == 'Bolster') then
                geo.label = geo.label .. (name == 'Bolster' and '+Bolster' or '+EA')
                local mob = geo.mob_id and windower.ffxi.get_mob_by_id(geo.mob_id)
                if mob then set_tag(mob, 'geo:' .. actor_id, geo.label, nil, actor_id, actor_name, name) end
            end
        end
        if category == CAT_SPELL and name:find('^Indi%-') and (name:find('Frailty') or name:find('Torpor')
            or name:find('Malaise') or name:find('Languor') or name:find('Wilt') or name:find('Slip')) then
            local label = name .. (recent(actor_id, 'Entrust') and '+Entrust' or '')
            state.auras['indi:' .. actor_id] = { label = label, expires = now + INDI_SECONDS }
        end
        for _, target in ipairs(act.targets) do
            local mob = monster_target(target.id)
            if mob and category == CAT_SPELL and name:find('^Geo%-') then
                local mods = (recent(actor_id, 'Bolster') and '+Bolster' or '')
                    .. (recent(actor_id, 'Blaze of Glory') and '+BoG' or '')
                consume(actor_id, 'Blaze of Glory')
                local old = state.geo[actor_id]
                if old and old.mob_id then clear_tag(old.mob_id, 'geo:' .. actor_id, actor_id) end
                state.geo[actor_id] = { spell = name, mob_id = mob.id, label = name .. mods, t = now, seen = false }
                set_tag(mob, 'geo:' .. actor_id, name .. mods, nil, actor_id, actor_name, 'luopan')
            end
            if mob then
                for _, action in ipairs(target.actions or {}) do
                    local status, applied = status_change(action.message, action.param)
                    local row = base_row('party_action', actor_id, actor_name, mob)
                    row.detail = name
                    row.msg = action.message
                    if not status then row.damage = action.param end
                    emit(row)
                    if status then
                        apply_status(mob, status, applied, actor_id, actor_name, name, action.param)
                    elseif category == CAT_STEP and STEP_DAZE[name] and action.param >= 1 and action.param <= 10 then
                        apply_status(mob, STEP_DAZE[name], true, actor_id, actor_name, name, action.param)
                    elseif name == 'Light Shot' and action.message ~= MSG_MELEE_MISS then
                        set_tag(mob, 'ja:Light Shot', 'Light Shot', now + LIGHT_SHOT_SECONDS, actor_id, actor_name, name)
                    end
                    if action.has_add_effect then
                        status, applied = status_change(action.add_effect_message, action.add_effect_param)
                        if status then apply_status(mob, status, applied, actor_id, actor_name, name) end
                    end
                end
            end
        end
    end
end

local function handle_action_message(actor_id, target_id, message_id, param_1)
    if MSG_DEFEAT[message_id] then
        state.mob_tags[target_id] = nil
        state.ws_history[target_id] = nil
        for caster, geo in pairs(state.geo) do
            if geo.mob_id == target_id then state.geo[caster] = nil end
        end
        return
    end
    if not state.mob_tags[target_id] then return end
    local status, applied = status_change(message_id, param_1)
    if not status then return end
    local mob = windower.ffxi.get_mob_by_id(target_id)
    if mob then apply_status(mob, status, applied, actor_id, '', nil) end
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

-------------------------------------------------------------------------------
-- Accuracy: /checkparam results remembered per buff + gear state
--
-- Accuracy isn't in any status packet, and it changes with every song, bubble, food or gear
-- piece. So each /checkparam result is stored under a signature of your current buffs and
-- equipped items. When you return to a known state it's reused; in an unknown state rows get
-- no Accuracy (never a stale one), and with autocheck on, /checkparam is run once the state
-- has settled, with its output hidden.
-------------------------------------------------------------------------------

local EQUIP_SLOTS = { 'main', 'sub', 'range', 'ammo', 'head', 'neck', 'left_ear', 'right_ear', 'body',
                      'hands', 'left_ring', 'right_ring', 'back', 'waist', 'legs', 'feet' }
local ACC_TTL = 600            -- remembered Accuracy expires after 10 minutes (potencies drift)
local AUTOCHECK_SETTLE = 3     -- seconds the state must be unchanged before an automatic check
local AUTOCHECK_GAP = 20       -- minimum seconds between automatic checks
local CHECK_WINDOW = 4         -- seconds after /checkparam during which results are captured

-- /checkparam result messages, found from Windower's message templates: anything that reports
-- a number next to Accuracy, Attack, Evasion or Defense.
local CHECK_MSG = {}
for id, message in pairs(res.action_messages or {}) do
    local text = message.en and message.en:lower()
    if text and text:find('${number}', 1, true) then
        local acc = text:find('accuracy', 1, true)
        if acc or text:find('attack', 1, true) or text:find('evasion', 1, true) or text:find('defense', 1, true) then
            local before = acc and text:sub(math.max(1, acc - 8), acc - 1) or ''
            local melee_acc = acc and not before:find('ranged', 1, true) and not before:find('magic', 1, true)
            local att = text:find('attack', 1, true)
            CHECK_MSG[id] = { melee_acc = melee_acc and true or false, acc_first = melee_acc and (not att or acc < att) }
        end
    end
end

local function signature()
    local player = windower.ffxi.get_player()
    if not player then return nil end
    local buffs = {}
    for _, id in ipairs(player.buffs or {}) do buffs[#buffs + 1] = id end
    table.sort(buffs)
    local gear = {}
    local equipment = windower.ffxi.get_items('equipment') or {}
    for i, slot in ipairs(EQUIP_SLOTS) do
        local index = equipment[slot]
        local item = index and index ~= 0 and windower.ffxi.get_items(equipment[slot .. '_bag'], index)
        gear[i] = item and item.id or 0
    end
    return table.concat(buffs, '.') .. '|' .. table.concat(gear, '.')
end

local function use_cached_accuracy()
    local known = state.sig and state.acc_cache[state.sig]
    if known and socket.gettime() - known.t <= ACC_TTL then
        state.accuracy, state.acc_sub = known.main, known.sub
    else
        state.accuracy, state.acc_sub = nil, nil
    end
end

local function open_check(hide)
    state.check = { sig = state.sig, t = socket.gettime(), hide = hide, parts = {} }
end

local function check_open()
    return state.check and socket.gettime() - state.check.t <= CHECK_WINDOW
end

local function record_accuracy(value, source)
    local check = state.check
    if not check or check.sig ~= state.sig then return end   -- state changed mid-check: discard
    check.parts[#check.parts + 1] = value
    local main, sub = check.parts[1], check.parts[2]
    state.acc_cache[check.sig] = { main = main, sub = sub, t = socket.gettime() }
    use_cached_accuracy()
    if not check.hide and #check.parts == 1 then
        windower.add_to_chat(207, ('SortieLog: accuracy %d recorded for this buff/gear state (%s)'):format(main, source))
    end
end

-- Pulls melee Accuracy numbers out of /checkparam chat text, skipping ranged and magic accuracy.
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
    return found
end

-- 0x029 message packets: capture (and, for automatic checks, hide) /checkparam results.
local function handle_check_packet(data)
    if not check_open() then return false end
    local packet = packets.parse('incoming', data)
    local info = packet and CHECK_MSG[packet.Message]
    if not info or packet.Actor ~= state.me_id then return false end
    state.check.via_packet = true
    if info.melee_acc then
        record_accuracy(info.acc_first and packet['Param 1'] or packet['Param 2'], 'checkparam')
    end
    return state.check.hide
end

-- Chat text fallback, and hiding of text lines from automatic checks.
local function handle_incoming_text(text)
    if not text or not check_open() then return false end
    local lower = text:lower()
    local is_check = lower:find('accuracy', 1, true) or lower:find('evasion', 1, true)
        or lower:find('defense', 1, true) or (lower:find('attack', 1, true) and lower:find('%d'))
    if not is_check then return false end
    local player = windower.ffxi.get_player()
    if not player or not text:find(player.name, 1, true) then return false end
    if not state.check.via_packet then
        for _, value in ipairs(parse_accuracy(text)) do record_accuracy(value, 'checkparam text') end
    end
    return state.check.hide
end

local function run_checkparam(hide)
    open_check(hide)
    state.last_autocheck = socket.gettime()
    windower.chat.input('/checkparam <me>')
end

-- Called a few times a second: signature changes, automatic checks, luopan lifetimes.
local function tick()
    local now = socket.gettime()
    if now - state.tick < 0.5 then return end
    state.tick = now
    local sig = signature()
    if sig and sig ~= state.sig then
        state.sig, state.sig_since = sig, now
        use_cached_accuracy()
    elseif state.accuracy and state.sig and state.acc_cache[state.sig]
        and now - state.acc_cache[state.sig].t > ACC_TTL then
        use_cached_accuracy()
    end
    local player = windower.ffxi.get_player()
    if settings.autocheck and player and player.status == 1 and sig and not state.accuracy
        and now - state.sig_since >= AUTOCHECK_SETTLE and now - state.last_autocheck >= AUTOCHECK_GAP
        and not check_open() then
        run_checkparam(true)
    end

    -- Geo bubbles last while the caster's luopan is alive.
    local party = windower.ffxi.get_party() or {}
    local pets = {}
    for key, member in pairs(party) do
        if type(member) == 'table' and type(key) == 'string' and key:match('^[pa]%d+$') and member.mob then
            pets[member.mob.id] = member.mob.pet_index
        end
    end
    for caster, geo in pairs(state.geo) do
        local index = pets[caster]
        local luopan = index and windower.ffxi.get_mob_by_index(index)
        local alive = luopan and luopan.name == 'Luopan' and (luopan.hpp or 0) > 0
        if alive then
            geo.seen = true
        elseif geo.seen or now - geo.t > 10 then
            state.geo[caster] = nil
            if geo.mob_id then clear_tag(geo.mob_id, 'geo:' .. caster, caster) end
        end
    end
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
    if id == 0x061 then
        local ok, err = pcall(handle_char_stats, data)
        if not ok then report_error(err) end
    elseif id == 0x029 then
        local ok, block = pcall(handle_check_packet, data)
        if not ok then report_error(block) elseif block then return true end
    end
end)

windower.register_event('incoming text', function(original)
    local ok, block = pcall(handle_incoming_text, original)
    if not ok then report_error(block) elseif block then return true end
end)

windower.register_event('outgoing text', function(original)
    if original and original:lower():find('^%s*/checkparam') and not check_open() then
        open_check(false)   -- a /checkparam you typed: capture it too, and show it
    end
end)

windower.register_event('zone change', function()
    state.mob_tags, state.auras, state.geo, state.recent_ja = {}, {}, {}, {}
    state.acc_cache, state.sig = {}, nil   -- new run: buff potencies may differ
    state.accuracy, state.acc_sub = nil, nil
    state.ws_history = {}
    refresh_party(true)
end)

local http_error_reported = false
local tick_error_reported = false
windower.register_event('prerender', function()
    local ok, err = pcall(http_poll)
    if not ok and not http_error_reported then
        http_error_reported = true
        report_error(err)
    end
    ok, err = pcall(tick)
    if not ok and not tick_error_reported then
        tick_error_reported = true
        report_error(err)
    end
end)

windower.register_event('load', 'login', function()
    resolve_host()
    if settings.http.enabled then http_resolve() end
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
    say(('http %s -> %s | key %s | queued %d | sent %d | %s'):format(
        settings.http.enabled and 'on' or 'off', tostring(settings.http.url), settings.token == '' and 'missing' or 'set',
        #http.queue, http.sent, tostring(http.status)))
    say('flags: ' .. (names_from_set(state.flags) ~= '' and names_from_set(state.flags) or 'none'))
    local cached = 0
    for _ in pairs(state.acc_cache) do cached = cached + 1 end
    say(('attack %s | accuracy %s / %s | weapon %s | autocheck %s | %d states measured'):format(
        tostring(state.attack), tostring(state.accuracy or 'unknown for this state'), tostring(state.acc_sub),
        tostring(state.weapon), settings.autocheck and 'on' or 'off', cached))
    say('debuffs on target: ' .. (function()
        local target = windower.ffxi.get_mob_by_target and windower.ffxi.get_mob_by_target('t')
        local labels = target and tag_labels(target.id) or ''
        return labels ~= '' and labels or 'none'
    end)())
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
    elseif command == 'http' then
        settings.http.enabled = (args[1] or ''):lower() == 'on'
        config.save(settings)
        if settings.http.enabled then http_resolve() end
        show_status()
    elseif command == 'url' and args[1] then
        local target, err = parse_http_url(args[1])
        if not target then
            say(err)
        else
            settings.http.url = args[1]
            config.save(settings)
            http_resolve()
            show_status()
        end
    elseif command == 'flush' then
        http.next_attempt, http.last_send, http.backoff = 0, 0, HTTP_FLUSH_SECONDS
        say(('sending %d queued rows'):format(#http.queue))
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
        if state.sig then
            state.acc_cache[state.sig] = { main = tonumber(args[1]), sub = tonumber(args[2]), t = socket.gettime() }
        end
        state.accuracy, state.acc_sub = tonumber(args[1]), tonumber(args[2])
        say(('accuracy main %d%s for this buff/gear state'):format(state.accuracy,
            state.acc_sub and (' sub ' .. state.acc_sub) or ''))
    elseif command == 'checkparam' then
        run_checkparam(false)
    elseif command == 'autocheck' then
        settings.autocheck = (args[1] or ''):lower() ~= 'off'
        config.save(settings)
        say('autocheck ' .. (settings.autocheck and 'on' or 'off'))
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
        say('commands: status, http on|off, url <http://host>, token <key>|clear, flush, checkparam, autocheck on|off, acc <main> [sub], udp on|off, host <ip> [port], token <t>|clear, targets <names>, flag <name> [on|off], flags, note <text>, new, test')
    end
end)
