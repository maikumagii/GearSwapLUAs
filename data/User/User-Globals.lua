--Place for your settings and custom functions that are meant to affect all of your jobs and characters.
latency                = .25
--If this is set to true it will prevent you from casting shadows when you have more up than that spell would generate.
conserveshadows        = false
--Display related settings.
display.mode_hud = display.mode_hud or {}
display.mode_hud.enabled = display.mode_hud.enabled ~= false
display.mode_hud.x = display.mode_hud.x or 24
display.mode_hud.y = display.mode_hud.y or 180
display.mode_hud.width = display.mode_hud.width or 260
display.mode_hud.line_height = display.mode_hud.line_height or 16
display.mode_hud.font = display.mode_hud.font or 'Courier New'
display.mode_hud.size = display.mode_hud.size or 10
display.mode_hud.bg_alpha = display.mode_hud.bg_alpha or 120
display.mode_hud.drag_threshold = display.mode_hud.drag_threshold or 5
display.mode_hud.label_width = display.mode_hud.label_width or 16
display.mode_hud.group_label_width = display.mode_hud.group_label_width or 14
display.mode_hud.value_width = display.mode_hud.value_width or 18
display.mode_hud.value_x_offset = display.mode_hud.value_x_offset or 150
display.mode_hud.value_padding = display.mode_hud.value_padding or 8
display.mode_hud.right_padding = display.mode_hud.right_padding or 0
display.mode_hud.extra_states = display.mode_hud.extra_states or {
    'WeaponSets',
    'HybridMode',
    'Kiting',
    'MagicBurstMode',
    'SkillchainMode',
    'UnlockWeapons',
}
display.mode_hud.group_states = display.mode_hud.group_states or {
    equipment = false,
    magic = false,
    combat = false,
    job = false,
    other = false,
}

repo_update = repo_update or {}
repo_update.enabled = repo_update.enabled ~= false
repo_update.git_command = repo_update.git_command or 'git'
repo_update.max_output_lines = repo_update.max_output_lines or 8
repo_update.debug = repo_update.debug ~= false

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
local dual_wield_sub_jobs = S { 'NIN', 'DNC' }
local base_set_dual_wield = set_dual_wield
local dual_wield_defaults_retry_count = 0

local function has_dual_wield_trait()
    if windower and windower.ffxi and windower.ffxi.get_abilities and gearswap and gearswap.res and gearswap.res.job_traits then
        local traits = T(windower.ffxi.get_abilities().job_traits)
        return traits:any(function(v)
            return gearswap.res.job_traits[v] and gearswap.res.job_traits[v].english == 'Dual Wield'
        end)
    end

    return false
end

local function player_can_dual_wield()
    return can_dual_wield or has_dual_wield_trait() or (player and player.sub_job and dual_wield_sub_jobs:contains(player.sub_job))
end

local function apply_dual_wield_weapon_defaults()
    if not player or not dual_wield_default_jobs:contains(player.main_job) then
        return
    end

    if not state or not state.Weapons or not sets or not sets.weapons then
        if dual_wield_defaults_retry_count < 5 then
            dual_wield_defaults_retry_count = dual_wield_defaults_retry_count + 1
            apply_dual_wield_weapon_defaults:schedule(1)
        end
        return
    end

    if not weapon_sets or not state.WeaponSets then
        if dual_wield_defaults_retry_count < 5 then
            dual_wield_defaults_retry_count = dual_wield_defaults_retry_count + 1
            apply_dual_wield_weapon_defaults:schedule(1)
        end
        return
    end

    can_dual_wield = player_can_dual_wield()

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

    dual_wield_defaults_retry_count = 0
end

function set_dual_wield()
    if base_set_dual_wield then
        base_set_dual_wield()
    else
        can_dual_wield = player_can_dual_wield()
    end

    can_dual_wield = player_can_dual_wield()

    apply_dual_wield_weapon_defaults:schedule(1)
end

local mode_hud = {
    text = nil,
    value_texts = {},
    popout_text = nil,
    hitboxes = {},
    popout_hitboxes = {},
    popout_state = nil,
    popout_anchor = nil,
    drag = nil,
    registered = false,
    wrapped = false,
}

local mode_hud_groups = {
    { id = 'equipment', label = 'Equipment' },
    { id = 'magic', label = 'Magic' },
    { id = 'combat', label = 'Combat' },
    { id = 'job', label = 'Job' },
    { id = 'other', label = 'Other' },
}

local mode_hud_labels = {
    AutoMagicBurst = 'Auto Magic Burst',
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
    WeaponSets = 'Weapon Sets',
    WeaponskillMode = 'Weaponskill',
}

local mode_hud_categories = {
    AutoDefenseMode = 'equipment',
    BuffWeaponsMode = 'equipment',
    DefenseMode = 'equipment',
    ExtraDefenseMode = 'equipment',
    ExtraMeleeMode = 'equipment',
    HybridMode = 'equipment',
    IdleMode = 'equipment',
    MagicalDefenseMode = 'equipment',
    OffenseMode = 'equipment',
    Passive = 'equipment',
    PhysicalDefenseMode = 'equipment',
    RangedMode = 'equipment',
    ResistDefenseMode = 'equipment',
    UnlockWeapons = 'equipment',
    WakeUpWeapons = 'equipment',
    Weapons = 'equipment',
    WeaponskillMode = 'equipment',
    WeaponSets = 'equipment',

    AutoMagicBurst = 'magic',
    AutoNukeMode = 'magic',
    AutoRuneMode = 'magic',
    AutoStunMode = 'magic',
    CastingMode = 'magic',
    DeathMode = 'magic',
    ElementalMode = 'magic',
    ElementalWheel = 'magic',
    MagicBurstMode = 'magic',
    RecoverMode = 'magic',
    RuneElement = 'magic',

    AutoEngageMode = 'combat',
    AutoFightMode = 'combat',
    AutoJumpMode = 'combat',
    AutoSambaMode = 'combat',
    AutoShadowMode = 'combat',
    AutoSuperJumpMode = 'combat',
    AutoTankMode = 'combat',
    AutoWSMode = 'combat',
    Kiting = 'combat',
    RngHelper = 'combat',
    SkillChainMode = 'combat',
    SkillchainMode = 'combat',

    AutoCallPet = 'job',
    AutoDummyMode = 'job',
    AutoPuppetMode = 'job',
    AutoReadyMode = 'job',
    AutoRepairMode = 'job',
    AutoRewardMode = 'job',
    CarnMode = 'job',
    CompensatorMode = 'job',
    ConquerorMode = 'job',
    DanceStance = 'job',
    DrainSwapWeaponMode = 'job',
    ExtraSongsMode = 'job',
    JugMode = 'job',
    LearningMode = 'job',
    LuzafRing = 'job',
    MainStep = 'job',
    AltStep = 'job',
    PactSpamMode = 'job',
    PetMode = 'job',
    PetWSGear = 'job',
    RewardMode = 'job',
    RngHelperQuickDraw = 'job',
    RollMode = 'job',
    Stance = 'job',
}

local function mode_hud_setting(name, default)
    if display and display.mode_hud and display.mode_hud[name] ~= nil then
        return display.mode_hud[name]
    end

    return default
end

local function mode_hud_number_setting(name, default)
    local value = tonumber(mode_hud_setting(name, default))

    return value or default
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

local function mode_hud_group_for(name)
    return mode_hud_categories[name] or 'other'
end

local function mode_hud_group_enabled(group_id)
    display.mode_hud.group_states[group_id] = display.mode_hud.group_states[group_id] ~= false
    return display.mode_hud.group_states[group_id]
end

local function mode_hud_toggle_group(group_id)
    display.mode_hud.group_states[group_id] = not mode_hud_group_enabled(group_id)
end

local function mode_hud_entry_names()
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

local function mode_hud_grouped_entries()
    local grouped = {}
    local rows = {}

    for _, group in ipairs(mode_hud_groups) do
        grouped[group.id] = {}
    end

    for _, name in ipairs(mode_hud_entry_names()) do
        local group_id = mode_hud_group_for(name)
        grouped[group_id][#grouped[group_id] + 1] = name
    end

    for _, group in ipairs(mode_hud_groups) do
        if #grouped[group.id] > 0 then
            rows[#rows + 1] = {
                kind = 'group',
                group = group.id,
                label = group.label,
            }

            if mode_hud_group_enabled(group.id) then
                for _, name in ipairs(grouped[group.id]) do
                    rows[#rows + 1] = {
                        kind = 'state',
                        name = name,
                        group = group.id,
                    }
                end
            end
        end
    end

    return rows
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

    if mode_hud.popout_text then
        mode_hud.popout_text:hide()
    end
end

local function mode_hud_hide()
    mode_hud.hitboxes = {}
    mode_hud.drag = nil
    mode_hud_close_popout()

    if mode_hud.text then
        mode_hud.text:hide()
    end

    for _, text in pairs(mode_hud.value_texts) do
        text:hide()
    end
end

local function mode_hud_destroy()
    mode_hud.hitboxes = {}
    mode_hud.popout_hitboxes = {}
    mode_hud.popout_state = nil
    mode_hud.popout_anchor = nil
    mode_hud.drag = nil

    if mode_hud.text then
        mode_hud.text:destroy()
    end

    for _, text in pairs(mode_hud.value_texts) do
        text:destroy()
    end

    if mode_hud.popout_text then
        mode_hud.popout_text:destroy()
    end

    mode_hud.text = nil
    mode_hud.value_texts = {}
    mode_hud.popout_text = nil
end

local function mode_hud_get_text()
    if mode_hud.text then
        return mode_hud.text
    end

    local text = texts.new()
    text:font(mode_hud_setting('font', 'Arial'))
    text:size(mode_hud_setting('size', 10))
    text:bold(true)
    text:bg_alpha(mode_hud_setting('bg_alpha', 120))
    text:stroke_width(2)
    text:stroke_transparency(180)
    if text.draggable then
        text:draggable(false)
    end
    mode_hud.text = text

    return text
end

local function mode_hud_get_value_text(index)
    if mode_hud.value_texts[index] then
        return mode_hud.value_texts[index]
    end

    local text = texts.new()
    text:font(mode_hud_setting('font', 'Arial'))
    text:size(mode_hud_setting('size', 10))
    text:bold(true)
    text:bg_alpha(0)
    text:stroke_width(2)
    text:stroke_transparency(180)
    if text.right_justified then
        text:right_justified(false)
    end
    if text.draggable then
        text:draggable(false)
    end
    mode_hud.value_texts[index] = text

    return text
end

local function mode_hud_get_popout_text()
    if mode_hud.popout_text then
        return mode_hud.popout_text
    end

    local text = texts.new()
    text:font(mode_hud_setting('font', 'Arial'))
    text:size(mode_hud_setting('size', 10))
    text:bold(true)
    text:bg_alpha(mode_hud_setting('bg_alpha', 120))
    text:stroke_width(2)
    text:stroke_transparency(180)
    if text.draggable then
        text:draggable(false)
    end
    mode_hud.popout_text = text

    return text
end

local function mode_hud_append_line(text, line)
    text:append(line)
    text:append('\n')
end

local function mode_hud_visible_length(line)
    local visible = line:gsub('\\cs%(%d+,%d+,%d+%)', '')

    return #visible
end

local function mode_hud_char_width()
    return mode_hud_number_setting('character_width', mode_hud_number_setting('size', 10) * 0.65)
end

local function mode_hud_columns_for_pixels(pixels)
    return math.ceil(pixels / math.max(mode_hud_char_width(), 1))
end

local function mode_hud_box_columns(columns)
    local configured_columns = tonumber(mode_hud_setting('box_columns', nil))

    if configured_columns then
        return configured_columns
    end

    return columns or mode_hud_columns_for_pixels(mode_hud_number_setting('width', 260))
end

local function mode_hud_append_box_line(text, line, columns)
    local padding = math.max(mode_hud_box_columns(columns) - mode_hud_visible_length(line), 0)

    mode_hud_append_line(text, line .. string.rep(' ', padding))
end

local function mode_hud_value_color(name, value, fallback_color)
    if not display.colors then
        return fallback_color
    end

    if name == 'ElementalMode' and display.colors[value] then
        return display.colors[value]
    end

    if name == 'RuneElement' and data and data.elements and data.elements.runes_lookup then
        local element = data.elements.runes_lookup[value]

        if element and display.colors[element] then
            return display.colors[element]
        end
    end

    return fallback_color
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

    local text = mode_hud_get_popout_text()
    local line_height = mode_hud_number_setting('line_height', 16)
    local width = mode_hud_number_setting('popout_width', 190)
    local x = mode_hud.popout_anchor.x2 + mode_hud_number_setting('popout_gap', 8)
    local y = mode_hud.popout_anchor.y1
    local colors = display.colors or {}
    local label_color = colors.White or '\\cs(255,255,255)'
    local active_color = colors.Yellow or '\\cs(255,192,0)'
    local default_color = colors.OffWhite or '\\cs(192,192,192)'

    mode_hud.popout_hitboxes = {}
    text:clear()
    text:pos(x, y)
    mode_hud_append_line(text, string.format('%s%s', label_color, mode_hud_label(mode_hud.popout_state)))

    for index, option in ipairs(options) do
        local value_color = option == state_var.value and active_color or default_color
        local marker = option == state_var.value and '> ' or '  '

        mode_hud_append_line(text, string.format('%s%s%s%s', value_color, marker, option, label_color))

        mode_hud.popout_hitboxes[#mode_hud.popout_hitboxes + 1] = {
            state = mode_hud.popout_state,
            value = option,
            x1 = x,
            y1 = y + (index * line_height),
            x2 = x + width,
            y2 = y + ((index + 1) * line_height),
        }
    end

    text:show()
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

    local rows = mode_hud_grouped_entries()
    local x = mode_hud_number_setting('x', 24)
    local y = mode_hud_number_setting('y', 180)
    local width = mode_hud_number_setting('width', 260)
    local line_height = mode_hud_number_setting('line_height', 16)
    local header_lines = 1
    local group_label_width = mode_hud_number_setting('group_label_width', 14)
    local colors = display.colors or {}
    local label_color = colors.White or '\\cs(255,255,255)'
    local default_color = colors.OffWhite or '\\cs(192,192,192)'
    local active_color = colors.Yellow or '\\cs(255,192,0)'
    local off_color = colors.Gray or '\\cs(96,96,96)'
    local text = mode_hud_get_text()
    local rendered_rows = {}
    local header = 'Modes'
    local max_label_columns = mode_hud_visible_length(header)
    local box_columns = max_label_columns

    for index, row in ipairs(rows) do
        if row.kind == 'group' then
            local enabled = mode_hud_group_enabled(row.group)
            local marker = enabled and '-' or '+'
            local label = string.format('[%s] %-' .. group_label_width .. 's', marker, row.label)

            rendered_rows[index] = {
                kind = 'group',
                row = row,
                label = label,
            }
            max_label_columns = math.max(max_label_columns, mode_hud_visible_length(label))
        else
            local name = row.name
            local state_var = state[name]
            local value = tostring(state_var.current or state_var.value)
            local value_color = mode_hud_is_default(name, state_var) and default_color or active_color

            if state_var._type == 'boolean' and not state_var.value then
                value_color = off_color
            end

            value_color = mode_hud_value_color(name, value, value_color)

            local label = '  ' .. mode_hud_label(name)

            rendered_rows[index] = {
                kind = 'state',
                row = row,
                name = name,
                label = label,
                value = value,
                value_color = value_color,
            }
            max_label_columns = math.max(max_label_columns, mode_hud_visible_length(label))
        end
    end

    local value_offset = mode_hud_number_setting('value_x_offset', 150)

    if mode_hud_setting('dynamic_value_x', true) ~= false then
        value_offset = math.ceil((max_label_columns + mode_hud_number_setting('value_padding', 2)) * mode_hud_char_width())
    end

    local value_x = x + value_offset
    local value_column = mode_hud_columns_for_pixels(value_offset)

    for _, rendered_row in ipairs(rendered_rows) do
        if rendered_row.kind == 'state' then
            box_columns = math.max(box_columns, value_column + mode_hud_visible_length(rendered_row.value))
        else
            box_columns = math.max(box_columns, mode_hud_visible_length(rendered_row.label))
        end
    end

    box_columns = box_columns + mode_hud_number_setting('right_padding', 0)

    if mode_hud_setting('dynamic_width', true) ~= false then
        width = math.max(mode_hud_number_setting('min_width', 0), math.ceil(box_columns * mode_hud_char_width()))
    else
        box_columns = mode_hud_box_columns()
    end

    mode_hud.hitboxes = {}
    text:hide()
    text:clear()
    text:pos(x, y)
    mode_hud_append_box_line(text, string.format('%s%s', label_color, header), box_columns)

    for _, value_text in pairs(mode_hud.value_texts) do
        value_text:hide()
    end

    mode_hud.hitboxes[#mode_hud.hitboxes + 1] = {
        kind = 'drag',
        x1 = x,
        y1 = y,
        x2 = x + width,
        y2 = y + line_height,
    }

    for index, rendered_row in ipairs(rendered_rows) do
        local row = rendered_row.row
        local row_y = y + ((index + header_lines - 1) * line_height)

        if rendered_row.kind == 'group' then
            mode_hud_append_box_line(text, string.format('%s%s', label_color, rendered_row.label), box_columns)
            mode_hud.hitboxes[#mode_hud.hitboxes + 1] = {
                kind = 'group',
                group = row.group,
                x1 = x,
                y1 = row_y,
                x2 = x + width,
                y2 = row_y + line_height,
            }
        else
            local value_text = mode_hud_get_value_text(index)

            mode_hud_append_box_line(text, string.format('%s%s', label_color, rendered_row.label), box_columns)
            value_text:clear()
            value_text:append(string.format('%s%s', rendered_row.value_color, rendered_row.value))
            value_text:pos(value_x, row_y)
            value_text:show()
            mode_hud.hitboxes[#mode_hud.hitboxes + 1] = {
                kind = 'state',
                name = rendered_row.name,
                x1 = x,
                y1 = row_y,
                x2 = x + width,
                y2 = row_y + line_height,
            }
        end
    end

    text:show()

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

local function mode_hud_update_drag(x, y)
    if not mode_hud.drag then
        return false
    end

    local dx = x - mode_hud.drag.start_x
    local dy = y - mode_hud.drag.start_y

    if math.abs(dx) < mode_hud_number_setting('drag_threshold', 5) and math.abs(dy) < mode_hud_number_setting('drag_threshold', 5) then
        return mode_hud.drag.moved
    end

    mode_hud.drag.moved = true
    display.mode_hud.x = mode_hud.drag.hud_x + dx
    display.mode_hud.y = mode_hud.drag.hud_y + dy
    mode_hud_close_popout()
    mode_hud_refresh()

    return true
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

        if mode_hud.drag and type == 0 then
            mode_hud_update_drag(x, y)
            return true
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
            if type == 2 and mode_hud.drag then
                mode_hud_update_drag(x, y)
                mode_hud.drag = nil
                return true
            end
            return
        end

        if type == 1 then
            mode_hud.drag = {
                start_x = x,
                start_y = y,
                hud_x = mode_hud_number_setting('x', 24),
                hud_y = mode_hud_number_setting('y', 180),
                moved = false,
            }
            return true
        end

        if type == 2 and mode_hud.drag then
            local was_dragged = mode_hud_update_drag(x, y)

            mode_hud.drag = nil

            if was_dragged then
                return true
            end
        end

        if hitbox.kind == 'drag' then
            return true
        end

        if hitbox.kind == 'group' then
            if type == 2 or type == 5 then
                mode_hud_toggle_group(hitbox.group)
                mode_hud_close_popout()
                mode_hud_refresh()
                return true
            elseif type == 1 or type == 4 then
                return true
            end
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
    local group = commandArgs[3] and commandArgs[3]:lower()
    local message

    eventArgs.handled = true

    if action == 'on' then
        display.mode_hud.enabled = true
        message = 'Mode HUD is now on.'
    elseif action == 'off' then
        display.mode_hud.enabled = false
        message = 'Mode HUD is now off.'
    elseif action == 'reset' then
        display.mode_hud.x = 24
        display.mode_hud.y = 180
        message = 'Mode HUD position reset.'
    elseif action == 'group' and display.mode_hud.group_states[group] ~= nil then
        mode_hud_toggle_group(group)
        message = 'Mode HUD ' .. group .. ' group is now ' .. (display.mode_hud.group_states[group] and 'expanded' or 'collapsed') .. '.'
    else
        display.mode_hud.enabled = not display.mode_hud.enabled
        message = 'Mode HUD is now ' .. (display.mode_hud.enabled and 'on' or 'off') .. '.'
    end

    mode_hud_refresh()
    add_to_chat(122, message)
end

local function shell_quote(value)
    return '"' .. tostring(value):gsub('"', '\\"') .. '"'
end

local function command_quote(value)
    value = tostring(value)

    if value:find('%s') or value:find('"') then
        return shell_quote(value)
    end

    return value
end

local function repo_update_root()
    if repo_update.path and repo_update.path ~= '' then
        return repo_update.path
    end

    if windower and windower.addon_path then
        return windower.addon_path:gsub('[\\/]$', '')
    end

    return '.'
end

local add_repo_output

local function run_repo_git(args)
    if not io or not io.popen then
        return nil, 'io.popen is not available in this Lua environment.'
    end

    local command = command_quote(repo_update.git_command) .. ' -C ' .. shell_quote(repo_update_root()) .. ' ' .. args .. ' 2>&1'
    local handle = io.popen(command)

    if not handle then
        return nil, 'Unable to start git command.'
    end

    local output = handle:read('*a') or ''
    local ok, reason, code = handle:close()

    return {
        ok = ok,
        reason = reason,
        code = code,
        output = output,
    }
end

local function repo_failure_details(action, result, start_error)
    local output = result and result.output or start_error or ''
    local lower_output = output:lower()

    if start_error then
        return start_error, 'This may mean Windower cannot spawn shell commands. Use git outside the game.'
    elseif lower_output:find('not recognized') or lower_output:find('command not found') or lower_output:find('not found') then
        return 'Git executable was not found from Wine/Windower.', 'Install Git for Windows in this Wine prefix, or set repo_update.git_command to the full git.exe path.'
    elseif lower_output:find('not a git repository') then
        return 'The configured folder is not a Git repository.', 'Set repo_update.path to the repository root that contains the .git folder.'
    elseif lower_output:find('cannot change to') or lower_output:find('no such file or directory') or lower_output:find('the system cannot find') then
        return 'The configured repository path could not be opened.', 'Check repo_update.path. Under Wine, Linux paths usually need a Z:/home/deck/... style path.'
    elseif lower_output:find('dubious ownership') then
        return 'Git rejected the folder because of dubious ownership.', 'Run git config --global --add safe.directory for this repository outside the game.'
    elseif lower_output:find('permission denied') or lower_output:find('publickey') or lower_output:find('authentication failed') or lower_output:find('could not read username') then
        return 'GitHub authentication failed.', 'Configure SSH keys/credential manager inside the Wine prefix, or switch the remote to HTTPS with working credentials.'
    elseif lower_output:find('could not resolve host') or lower_output:find('failed to connect') or lower_output:find('unable to access') or lower_output:find('network is unreachable') then
        return 'Git could not reach GitHub.', 'Check Steam Deck networking, DNS, proxy/VPN, and whether Wine can reach the internet.'
    elseif lower_output:find('local changes') or lower_output:find('would be overwritten') or lower_output:find('commit your changes') or lower_output:find('stash') then
        return 'Local changes would be overwritten by the update.', 'Commit, stash, or manually back up your local edits before pulling.'
    elseif lower_output:find('not possible to fast%-forward') or lower_output:find('divergent') or lower_output:find('non%-fast%-forward') or lower_output:find('reconcile divergent') then
        return 'The branch cannot be fast-forwarded cleanly.', 'Open a terminal and choose whether to merge, rebase, or reset; this command intentionally will not do that in GearSwap.'
    elseif action == 'pull' then
        return 'Git pull failed for an unclassified reason.', 'Run git status and git pull --ff-only in a terminal for the full interactive error.'
    else
        return 'Git fetch/status failed for an unclassified reason.', 'Run git fetch --prune in a terminal to see the full error.'
    end
end

local function add_repo_failure(action, result, start_error)
    local cause, next_step = repo_failure_details(action, result, start_error)

    add_to_chat(123, 'Git ' .. action .. ' failed.')

    if repo_update.debug then
        add_to_chat(123, 'Likely cause: ' .. cause)
        add_to_chat(123, 'Next step: ' .. next_step)
        add_to_chat(123, 'Git command: ' .. repo_update.git_command)
        add_to_chat(123, 'Repository path: ' .. repo_update_root())
    end

    if result and result.output and result.output ~= '' then
        add_repo_output(result.output)
    elseif start_error then
        add_to_chat(123, start_error)
    end
end

function add_repo_output(output)
    local line_count = 0

    for line in output:gmatch('[^\r\n]+') do
        line_count = line_count + 1

        if line_count <= repo_update.max_output_lines then
            add_to_chat(122, line)
        end
    end

    if line_count > repo_update.max_output_lines then
        add_to_chat(122, '...truncated ' .. (line_count - repo_update.max_output_lines) .. ' more line(s).')
    elseif line_count == 0 then
        add_to_chat(122, '(no output)')
    end
end

local function repo_git_status()
    local status, start_error = run_repo_git('status -sb')

    if not status then
        add_repo_failure('status', nil, start_error)
        return
    end

    if not status.ok then
        add_repo_failure('status', status)
        return
    end

    add_repo_output(status.output)
end

local function handle_repo_update_command(commandArgs, eventArgs)
    local action = commandArgs[2] and commandArgs[2]:lower() or 'check'

    eventArgs.handled = true

    if not repo_update.enabled then
        add_to_chat(123, 'Repository update commands are disabled.')
        return
    end

    if action == 'check' or action == 'fetch' then
        add_to_chat(122, 'Fetching repository updates...')

        local fetch, start_error = run_repo_git('fetch --prune')

        if not fetch then
            add_repo_failure('fetch', nil, start_error)
            return
        end

        if not fetch.ok then
            add_repo_failure('fetch', fetch)
            return
        end

        add_to_chat(122, 'Fetch complete. Current status:')
        repo_git_status()
    elseif action == 'pull' then
        add_to_chat(122, 'Pulling repository updates with --ff-only...')

        local pull, start_error = run_repo_git('pull --ff-only')

        if not pull then
            add_repo_failure('pull', nil, start_error)
            return
        end

        if pull.ok then
            add_repo_output(pull.output)
            add_to_chat(122, 'Pull complete. Run //gs reload when you are ready to load changed files.')
        else
            add_repo_failure('pull', pull)
        end
    elseif action == 'status' then
        repo_git_status()
    else
        add_to_chat(123, 'Usage: //gs c repo check | status | pull')
    end
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

    if command == 'repo' or command == 'gitupdate' then
        handle_repo_update_command(commandArgs, eventArgs)
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
    apply_dual_wield_weapon_defaults:schedule(1)
end
