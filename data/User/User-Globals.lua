--Place for your settings and custom functions that are meant to affect all of your jobs and characters.
latency                = .25
--If this is set to true it will prevent you from casting shadows when you have more up than that spell would generate.
conserveshadows        = false
--Display related settings.
display.mode_hud = display.mode_hud or {}
display.mode_hud.enabled = display.mode_hud.enabled ~= false
display.mode_hud.x = display.mode_hud.x or 24
display.mode_hud.y = display.mode_hud.y or 180
display.mode_hud.width = display.mode_hud.width or 210
display.mode_hud.line_height = display.mode_hud.line_height or 16
display.mode_hud.font = display.mode_hud.font or 'Arial'
display.mode_hud.size = display.mode_hud.size or 10
display.mode_hud.bg_alpha = display.mode_hud.bg_alpha or 120
display.mode_hud.extra_states = display.mode_hud.extra_states or {
    'HybridMode',
    'Kiting',
    'MagicBurstMode',
    'SkillchainMode',
    'UnlockWeapons',
}

--Options for automation.
state.ReEquip          = M(true, 'ReEquip Mode')        --Set this to false if you don't want to equip your current Weapon set when you aren't wearing any weapons.
state.AutoArts         = M(true, 'AutoArts')            --Set this to false if you don't want to automatically try to keep up Solace/Arts.
state.AutoLockstyle    = M(true, 'AutoLockstyle Mode')  --Set this to false if you don't want gearswap to automatically lockstyle on load and weapon change.
state.CancelStoneskin  = M(true, 'Cancel Stone Skin')   --Set this to false if you don't want to automatically cancel stoneskin when you're slept.
state.HoxneAmpullaMode = M(false, 'Hoxne Ampulla Mode') --Equips Hoxne Ampulla, uses it after 5 seconds, then keeps range/ammo locked until toggled off.
state.SkipProcWeapons  = M(true, 'Skip Proc Weapons')   --Set this to false if you want to display weapon sets fulltime rather than just Aby/Voidwatch.
state.NotifyBuffs      = M(false, 'Notify Buffs')       --Set this to true if you want to notify your party when you recieve a specific buff/debuff. (List Below)

--[[Binds you may want to change.
	Bind special characters.
	@ = Windows Key
	% = Works only when text bar not up.
	$ = Works only when text bar is up.
	^ = Control Key
	! = Alt Key
	~ = Shift Key
	# = Apps Key
]]
send_command('bind !@^f7 gs c toggle AutoWSMode')        --Turns auto-ws mode on and off.
send_command('bind !^f7 gs c toggle AutoFoodMode')       --Turns auto-ws mode on and off.
send_command('bind f7 gs c cycle Weapons')               --Cycle through weapons sets.
send_command('bind @f8 gs c toggle AutoNukeMode')        --Turns auto-nuke mode on and off.
send_command('bind ^f8 gs c toggle AutoStunMode')        --Turns auto-stun mode off and on.
send_command('bind !f8 gs c toggle AutoDefenseMode')     --Turns auto-defense mode off and on.
send_command('bind ^@!f8 gs c toggle AutoTrustMode')     --Summons trusts automatically.
send_command('bind @pause gs c cycle AutoBuffMode')      --Automatically keeps certain buffs up, job-dependant.
send_command('bind @scrolllock gs c cycle Passive')      --Changes offense settings such as accuracy.
send_command('bind f9 gs c cycle OffenseMode')           --Changes offense settings such as accuracy.
send_command('bind ^f9 gs c cycle HybridMode')           --Changes defense settings for melee such as PDT.
send_command('bind @f9 gs c cycle RangedMode')           --Changes ranged offense settings such as accuracy.
send_command('bind !f9 gs c cycle WeaponskillMode')      --Changes weaponskill offense settings such as accuracy.
send_command('bind f10 gs c set DefenseMode Physical')   --Turns your physical defense set on.
send_command('bind ^f10 gs c cycle PhysicalDefenseMode') --Changes your physical defense set.
send_command('bind !f10 gs c toggle Kiting')             --Keeps your kiting gear on..
send_command('bind f11 gs c set DefenseMode Magical')    --Turns your magical defense set on.
send_command('bind ^f11 gs c cycle MagicalDefenseMode')  --Changes your magical defense set.
send_command('bind @f11 gs c cycle CastingMode')         --Changes your castingmode options such as magic accuracy.
send_command('bind !f11 gs c cycle ExtraMeleeMode')      --Adds another set layered on top of your engaged set.
send_command('bind ^f12 gs c cycle ResistDefenseMode')   --Changes your resist defense set.
send_command('bind f12 gs c set DefenseMode Resist')     --Turns your resist defense set on.
send_command('bind @f12 gs c cycle IdleMode')            --Changes your idle mode options such as refresh.
send_command('bind !f12 gs c reset DefenseMode')         --Turns your defensive mode off.
send_command('bind ^@!f12 gs reload')                    --Reloads gearswap.
send_command('bind pause gs c update user')              --Runs a quick check to make sure you have the right gear on and checks variables.
send_command('bind ^@!pause gs org')                     --Runs organizer.
send_command('bind ^@!backspace gs c buffup')            --Buffup macro because buffs are love.

NotifyBuffs = S { 'doom', 'petrification' }

local dual_wield_default_jobs = S { 'BLU', 'COR', 'BRD', 'RDM' }
local base_set_dual_wield = set_dual_wield

local function apply_dual_wield_weapon_defaults()
    if not dual_wield_default_jobs:contains(player.main_job) or not state or not state.Weapons or not sets or not sets.weapons then
        return
    end

    local weapon_set_name = can_dual_wield and 'Dual' or 'Default'

    if state.WeaponSets and weapon_sets and weapon_sets[weapon_set_name] and state.WeaponSets:contains(weapon_set_name) then
        local old_weapon_set = state.WeaponSets.value
        state.WeaponSets:set(weapon_set_name)

        if state_change then
            state_change('Weapon Sets', state.WeaponSets.value, old_weapon_set)
        else
            state.Weapons:options(unpack(weapon_sets[weapon_set_name]))
        end
    end

    local default_weapon = can_dual_wield and default_dual_weapons or default_weapons

    if default_weapon and default_weapon ~= '' and state.Weapons:contains(default_weapon) and sets.weapons[default_weapon] then
        local old_weapon = state.Weapons.value
        state.Weapons:set(default_weapon)

        if state_change then
            state_change('Weapons', state.Weapons.value, old_weapon)
        end
    end
end

function set_dual_wield()
    if base_set_dual_wield then
        base_set_dual_wield()
    else
        local traits = T(windower.ffxi.get_abilities().job_traits)
        can_dual_wield = traits:any(function(v) return gearswap.res.job_traits[v].english == 'Dual Wield' end)
    end

    apply_dual_wield_weapon_defaults:schedule(1)
end

local mode_hud = {
    texts = {},
    popout_texts = {},
    hitboxes = {},
    popout_hitboxes = {},
    popout_state = nil,
    popout_anchor = nil,
    registered = false,
    wrapped = false,
}

local mode_hud_labels = {
    AutoBuffMode = 'Auto Buff',
    AutoDefenseMode = 'Auto Defense',
    AutoFoodMode = 'Auto Food',
    AutoNukeMode = 'Auto Nuke',
    AutoRuneMode = 'Auto Rune',
    AutoSambaMode = 'Auto Samba',
    AutoShadowMode = 'Auto Shadows',
    AutoStunMode = 'Auto Stun',
    AutoTrustMode = 'Auto Trust',
    AutoWSMode = 'Auto WS',
    CastingMode = 'Casting',
    DefenseMode = 'Defense',
    ElementalMode = 'Element',
    HybridMode = 'Hybrid',
    IdleMode = 'Idle',
    MagicBurstMode = 'Magic Burst',
    OffenseMode = 'Offense',
    RangedMode = 'Ranged',
    SkillchainMode = 'Skillchain',
    TreasureMode = 'Treasure',
    UnlockWeapons = 'Unlock Weapons',
    Weapons = 'Weapons',
    WeaponskillMode = 'Weaponskill',
}

local function mode_hud_setting(name, default)
    if display and display.mode_hud and display.mode_hud[name] ~= nil then
        return display.mode_hud[name]
    end

    return default
end

local function mode_hud_label(name)
    if mode_hud_labels[name] then
        return mode_hud_labels[name]
    end

    if state[name] and state[name].description then
        return state[name].description:gsub(' Mode$', '')
    end

    return name
end

local function mode_hud_is_default(name, state_var)
    if state_var._type == 'boolean' then
        return state_var.value == state_var.default
    end

    local value = state_var.value
    return value == state_var.default or value == 'Off' or value == 'None' or value == 'Normal' or value == 'Match'
end

local function mode_hud_add_entry(entries, seen, name)
    if seen[name] or not state[name] or state[name]._class ~= 'mode' then
        return
    end

    seen[name] = true
    entries[#entries + 1] = name
end

local function mode_hud_entries()
    local entries = {}
    local seen = {}

    for _, name in ipairs(stateBool or {}) do
        mode_hud_add_entry(entries, seen, name)
    end

    for _, name in ipairs(stateList or {}) do
        mode_hud_add_entry(entries, seen, name)
    end

    for _, name in ipairs(mode_hud_setting('extra_states', {}) or {}) do
        mode_hud_add_entry(entries, seen, name)
    end

    return entries
end

local function mode_hud_popout_options(name)
    local state_var = state[name]
    local options = {}

    if not state_var then
        return options
    end

    if name == 'Weapons' and state.WeaponSets and weapon_sets and weapon_sets[state.WeaponSets.value] then
        for _, option in ipairs(weapon_sets[state.WeaponSets.value]) do
            if option == 'None' or (state_var.contains and state_var:contains(option)) then
                options[#options + 1] = option
            end
        end
    else
        for _, option in ipairs(state_var) do
            options[#options + 1] = option
        end
    end

    return options
end

local function mode_hud_close_popout()
    mode_hud.popout_state = nil
    mode_hud.popout_anchor = nil
    mode_hud.popout_hitboxes = {}

    for _, text in ipairs(mode_hud.popout_texts) do
        text:hide()
    end
end

local function mode_hud_hide()
    mode_hud.hitboxes = {}
    mode_hud_close_popout()

    for _, text in ipairs(mode_hud.texts) do
        text:hide()
    end
end

local function mode_hud_destroy()
    mode_hud.hitboxes = {}
    mode_hud.popout_hitboxes = {}
    mode_hud.popout_state = nil
    mode_hud.popout_anchor = nil

    for _, text in ipairs(mode_hud.texts) do
        text:destroy()
    end

    for _, text in ipairs(mode_hud.popout_texts) do
        text:destroy()
    end

    mode_hud.texts = {}
    mode_hud.popout_texts = {}
end

local function mode_hud_get_text(index)
    if mode_hud.texts[index] then
        return mode_hud.texts[index]
    end

    local text = texts.new()
    text:font(mode_hud_setting('font', 'Arial'))
    text:size(mode_hud_setting('size', 10))
    text:bold(true)
    text:bg_alpha(mode_hud_setting('bg_alpha', 120))
    text:stroke_width(2)
    text:stroke_transparency(180)
    mode_hud.texts[index] = text

    return text
end

local function mode_hud_get_popout_text(index)
    if mode_hud.popout_texts[index] then
        return mode_hud.popout_texts[index]
    end

    local text = texts.new()
    text:font(mode_hud_setting('font', 'Arial'))
    text:size(mode_hud_setting('size', 10))
    text:bold(true)
    text:bg_alpha(mode_hud_setting('bg_alpha', 120))
    text:stroke_width(2)
    text:stroke_transparency(180)
    mode_hud.popout_texts[index] = text

    return text
end

local function mode_hud_refresh_popout()
    if not mode_hud.popout_state or not mode_hud.popout_anchor then
        return
    end

    local state_var = state[mode_hud.popout_state]
    if not state_var then
        mode_hud_close_popout()
        return
    end

    local options = mode_hud_popout_options(mode_hud.popout_state)
    if #options == 0 then
        mode_hud_close_popout()
        return
    end

    local line_height = mode_hud_setting('line_height', 16)
    local width = mode_hud_setting('popout_width', 190)
    local x = mode_hud.popout_anchor.x2 + mode_hud_setting('popout_gap', 8)
    local y = mode_hud.popout_anchor.y1
    local colors = display.colors or {}
    local label_color = colors.White or '\\cs(255,255,255)'
    local active_color = colors.Yellow or '\\cs(255,192,0)'
    local default_color = colors.OffWhite or '\\cs(192,192,192)'

    mode_hud.popout_hitboxes = {}

    for index, option in ipairs(options) do
        local text = mode_hud_get_popout_text(index)
        local value_color = option == state_var.value and active_color or default_color

        text:clear()
        text:append(string.format('%s%s%s', value_color, option, label_color))
        text:pos(x, y + ((index - 1) * line_height))
        text:show()

        mode_hud.popout_hitboxes[#mode_hud.popout_hitboxes + 1] = {
            state = mode_hud.popout_state,
            value = option,
            x1 = x,
            y1 = y + ((index - 1) * line_height),
            x2 = x + width,
            y2 = y + line_height + ((index - 1) * line_height),
        }
    end

    for index = #options + 1, #mode_hud.popout_texts do
        mode_hud.popout_texts[index]:hide()
    end
end

local function mode_hud_open_popout(name, anchor)
    if mode_hud.popout_state == name then
        mode_hud_close_popout()
        return
    end

    mode_hud.popout_state = name
    mode_hud.popout_anchor = anchor
    mode_hud_refresh_popout()
end

local function mode_hud_refresh()
    if not mode_hud_setting('enabled', true) or (state.DisplayMode and not state.DisplayMode.value) then
        mode_hud_hide()
        return
    end

    local entries = mode_hud_entries()
    local x = mode_hud_setting('x', 24)
    local y = mode_hud_setting('y', 180)
    local width = mode_hud_setting('width', 210)
    local line_height = mode_hud_setting('line_height', 16)
    local colors = display.colors or {}
    local label_color = colors.White or '\\cs(255,255,255)'
    local default_color = colors.OffWhite or '\\cs(192,192,192)'
    local active_color = colors.Yellow or '\\cs(255,192,0)'
    local off_color = colors.Gray or '\\cs(96,96,96)'

    mode_hud.hitboxes = {}

    for index, name in ipairs(entries) do
        local state_var = state[name]
        local text = mode_hud_get_text(index)
        local value = tostring(state_var.current or state_var.value)
        local value_color = mode_hud_is_default(name, state_var) and default_color or active_color

        if state_var._type == 'boolean' and not state_var.value then
            value_color = off_color
        end

        text:clear()
        text:append(string.format('%s%-17s %s%s', label_color, mode_hud_label(name) .. ':', value_color, value))
        text:pos(x, y + ((index - 1) * line_height))
        text:show()

        mode_hud.hitboxes[#mode_hud.hitboxes + 1] = {
            name = name,
            x1 = x,
            y1 = y + ((index - 1) * line_height),
            x2 = x + width,
            y2 = y + line_height + ((index - 1) * line_height),
        }
    end

    for index = #entries + 1, #mode_hud.texts do
        mode_hud.texts[index]:hide()
    end

    if mode_hud.popout_state then
        mode_hud_refresh_popout()
    end
end

local function mode_hud_hit(x, y)
    for _, hitbox in ipairs(mode_hud.hitboxes) do
        if x >= hitbox.x1 and x <= hitbox.x2 and y >= hitbox.y1 and y <= hitbox.y2 then
            return hitbox
        end
    end
end

local function mode_hud_popout_hit(x, y)
    for _, hitbox in ipairs(mode_hud.popout_hitboxes) do
        if x >= hitbox.x1 and x <= hitbox.x2 and y >= hitbox.y1 and y <= hitbox.y2 then
            return hitbox
        end
    end
end

local function mode_hud_register_mouse()
    if mode_hud.registered then
        return
    end

    mode_hud.registered = true

    windower.register_event('mouse', function(type, x, y, delta, blocked)
        if blocked or not mode_hud_setting('enabled', true) then
            return
        end

        local popout_hitbox = mode_hud_popout_hit(x, y)
        if popout_hitbox then
            if type == 2 then
                send_command('gs c set ' .. popout_hitbox.state .. ' ' .. popout_hitbox.value)
                mode_hud_close_popout()
                return true
            elseif type == 1 or type == 4 or type == 5 then
                return true
            end
        end

        local hitbox = mode_hud_hit(x, y)
        if not hitbox then
            if type == 2 and mode_hud.popout_state then
                mode_hud_close_popout()
            end
            return
        end

        local name = hitbox.name

        if type == 2 then
            if name == 'Weapons' or name == 'ElementalMode' then
                mode_hud_open_popout(name, hitbox)
            else
                mode_hud_close_popout()
                send_command('gs c cycle ' .. name)
            end
            return true
        elseif type == 5 then
            if name == 'Weapons' or name == 'ElementalMode' then
                mode_hud_open_popout(name, hitbox)
            else
                mode_hud_close_popout()
                send_command('gs c cycleback ' .. name)
            end
            return true
        elseif type == 1 or type == 4 then
            return true
        end
    end)
end

local function mode_hud_setup()
    if mode_hud.wrapped then
        mode_hud_refresh()
        return
    end

    local base_update_job_states = update_job_states
    update_job_states = function(...)
        if base_update_job_states then
            base_update_job_states(...)
        end

        mode_hud_refresh()
    end

    local base_clear_job_states = clear_job_states
    clear_job_states = function(...)
        mode_hud_destroy()

        if base_clear_job_states then
            base_clear_job_states(...)
        end
    end

    mode_hud_register_mouse()
    mode_hud.wrapped = true
    mode_hud_refresh()
end

local function handle_mode_hud_command(commandArgs, eventArgs)
    local action = commandArgs[2] and commandArgs[2]:lower() or 'toggle'

    eventArgs.handled = true

    if action == 'on' then
        display.mode_hud.enabled = true
    elseif action == 'off' then
        display.mode_hud.enabled = false
    elseif action == 'reset' then
        display.mode_hud.x = 24
        display.mode_hud.y = 180
    else
        display.mode_hud.enabled = not display.mode_hud.enabled
    end

    mode_hud_refresh()
    add_to_chat(122, 'Mode HUD is now ' .. (display.mode_hud.enabled and 'on' or 'off') .. '.')
end

local hoxne_ampulla_name = 'Hoxne Ampulla'
local warp_ring_name = 'Warp Ring'
local warp_ring_wait_seconds = 9
local warp_ring_zone_timeout = 60
local warp_ring_state = {
    active = false,
    start_zone = nil,
    ready_deadline = 0,
    zone_deadline = 0,
}

local function set_hoxne_ampulla_mode(enabled)
    enable('range', 'ammo')

    if enabled then
        equip({ ammo = hoxne_ampulla_name })
        disable('range', 'ammo')
        send_command('gs c useitem ammo Hoxne Ampulla')
    else
        send_command('gs c update')
    end
end

local function reset_warp_ring_state()
    warp_ring_state.active = false
    warp_ring_state.start_zone = nil
    warp_ring_state.ready_deadline = 0
    warp_ring_state.zone_deadline = 0
end

local function finish_warp_ring()
    internal_enable_set('WarpRing')
    reset_warp_ring_state()
    send_command('gs c update')
end

local function warp_ring_accessible()
    return (player.inventory and player.inventory[warp_ring_name])
        or (player.wardrobe and player.wardrobe[warp_ring_name])
        or (player.wardrobe2 and player.wardrobe2[warp_ring_name])
        or (player.wardrobe3 and player.wardrobe3[warp_ring_name])
        or (player.wardrobe4 and player.wardrobe4[warp_ring_name])
        or (player.wardrobe5 and player.wardrobe5[warp_ring_name])
        or (player.wardrobe6 and player.wardrobe6[warp_ring_name])
        or (player.wardrobe7 and player.wardrobe7[warp_ring_name])
        or (player.wardrobe8 and player.wardrobe8[warp_ring_name])
end

local function monitor_warp_ring_zone_change()
    if not warp_ring_state.active then
        return
    end

    if world.area ~= warp_ring_state.start_zone then
        finish_warp_ring()
    elseif os.clock() >= warp_ring_state.zone_deadline then
        add_to_chat(123, 'Warp Ring did not change zones in time. Re-enabling ring1.')
        finish_warp_ring()
    else
        monitor_warp_ring_zone_change:schedule(1)
    end
end

local function use_warp_ring_when_ready()
    if not warp_ring_state.active then
        return
    end

    local warp_ring = get_usable_item(warp_ring_name)
    local ring_equipped = player.equipment and player.equipment.left_ring == warp_ring_name
    local ring_ready = warp_ring and warp_ring.usable and ring_equipped

    if ring_ready or os.clock() >= warp_ring_state.ready_deadline then
        warp_ring_state.zone_deadline = os.clock() + warp_ring_zone_timeout
        windower.chat.input('/item "' .. warp_ring_name .. '" <me>')
        monitor_warp_ring_zone_change:schedule(1)
    else
        use_warp_ring_when_ready:schedule(1)
    end
end

function user_state_change(stateField, newValue, oldValue)
    if stateField == 'Hoxne Ampulla Mode' then
        set_hoxne_ampulla_mode(newValue)
    end
end

function user_self_command(commandArgs, eventArgs)
    local command = commandArgs[1]:lower()

    if command == 'hud' or command == 'modehud' then
        handle_mode_hud_command(commandArgs, eventArgs)
        return
    end

    if command ~= 'warp' then
        return
    end

    eventArgs.handled = true

    if warp_ring_state.active then
        add_to_chat(123, 'Warp Ring automation is already in progress.')
        return
    end

    if not item_available(warp_ring_name) then
        add_to_chat(123, 'Warp Ring is not available.')
        return
    end

    if not warp_ring_accessible() then
        add_to_chat(123, 'Warp Ring must be in inventory or wardrobe to equip into ring1.')
        return
    end

    warp_ring_state.active = true
    warp_ring_state.start_zone = world.area
    warp_ring_state.ready_deadline = os.clock() + warp_ring_wait_seconds

    internal_disable_set({ ring1 = warp_ring_name }, 'WarpRing')
    equip({ ring1 = warp_ring_name })
    use_warp_ring_when_ready:schedule(1)
end

function user_zone_change(new_id, old_id)
    if warp_ring_state.active then
        finish_warp_ring()
    end
end

local base_extra_user_setup = extra_user_setup
function extra_user_setup()
    if base_extra_user_setup then
        base_extra_user_setup()
    end

    mode_hud_setup()
end
