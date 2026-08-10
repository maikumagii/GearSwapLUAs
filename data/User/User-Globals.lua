--Place for your settings and custom functions that are meant to affect all of your jobs and characters.
latency                = .25
--If this is set to true it will prevent you from casting shadows when you have more up than that spell would generate.
conserveshadows        = false

--Options for automation.
state.ReEquip          = M(true, 'ReEquip Mode')        --Set this to false if you don't want to equip your current Weapon set when you aren't wearing any weapons.
state.AutoArts         = M(true, 'AutoArts')            --Set this to false if you don't want to automatically try to keep up Solace/Arts.
state.AutoLockstyle    = M(true, 'AutoLockstyle Mode')  --Set this to false if you don't want gearswap to automatically lockstyle on load and weapon change.
state.CancelStoneskin  = M(true, 'Cancel Stone Skin')   --Set this to false if you don't want to automatically cancel stoneskin when you're slept.
state.HoxneMode        = M(false, 'HoxneMode')          --Equips Hoxne Ampulla with an empty ranged slot until toggled off.
state.HoxneAmpullaMode = state.HoxneMode                --Legacy alias; gs c toggle HoxneAmpullaMode still works.
state.SkipProcWeapons  = M(true, 'Skip Proc Weapons')   --Set this to false if you want to display weapon sets fulltime rather than just Aby/Voidwatch.
state.NotifyBuffs      = M(false, 'Notify Buffs')       --Set this to true if you want to notify your party when you recieve a specific buff/debuff. (List Below)

if disable_priority and not disable_priority:contains('HoxneMode') then
    table.insert(disable_priority, 1, 'HoxneMode')
end

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

local hoxne_mode_set = { range = 'empty', ammo = 'Hoxne Ampulla' }
local teleport_ring_names = {
    'Dim. Ring (Dem)',
    'Dim. Ring (Mea)',
    'Dim. Ring (Holla)',
}
local teleport_ring_spell_map = {
    ['Dim. Ring (Dem)'] = 'Teleport-Dem',
    ['Dim. Ring (Mea)'] = 'Teleport-Mea',
    ['Dim. Ring (Holla)'] = 'Teleport-Holla',
}

local function utility_accessible_bags()
    local bags = {}

    if res and res.bags then
        for bag in res.bags:it() do
            if bag.api and (bag.access == 'Everywhere' or bag.api == 'temporary' or bag.api == 'Temporary') then
                bags[#bags + 1] = bag.api
            end
        end
    end

    if #bags == 0 then
        bags = {
            'inventory',
            'wardrobe',
            'wardrobe2',
            'wardrobe3',
            'wardrobe4',
            'wardrobe5',
            'wardrobe6',
            'wardrobe7',
            'wardrobe8',
            'temporary',
        }
    end

    return bags
end

local function utility_item_count(item_name)
    local count = 0

    for _, bag in ipairs(utility_accessible_bags()) do
        local item = player[bag] and player[bag][item_name]

        if item then
            count = count + (item.count or 1)
        end
    end

    return count
end

local function utility_item_accessible(item_name)
    return utility_item_count(item_name) > 0
end

local function utility_item_remaining(item)
    if not item or not item.next_use_time then
        return nil
    end

    return math.max(math.ceil(item.next_use_time + (local_offset or 18000) - os.time()), 0)
end

local function utility_item_ready(item)
    if not item then
        return true
    end

    if item.charges_remaining and item.charges_remaining <= 0 then
        return false
    end

    if item.usable then
        return true
    end

    local remaining = utility_item_remaining(item)

    return remaining ~= nil and remaining <= 0
end

local function utility_best_accessible_item(item_names)
    local fallback_item_name
    local fallback_remaining

    for _, item_name in ipairs(item_names) do
        if utility_item_accessible(item_name) then
            local item = get_usable_item and get_usable_item(item_name)

            if utility_item_ready(item) then
                return item_name
            end

            local remaining = utility_item_remaining(item) or 0

            if not fallback_item_name or remaining < fallback_remaining then
                fallback_item_name = item_name
                fallback_remaining = remaining
            end
        end
    end

    return fallback_item_name
end

local function set_hoxne_mode(enabled)
    enable('range', 'ammo')

    if enabled then
        equip(hoxne_mode_set)
        internal_disable_set(hoxne_mode_set, 'HoxneMode')
        disable('range', 'ammo')
    else
        internal_enable_set('HoxneMode')
        send_command('gs c update')
    end
end

local function start_utility_magic_fallback(spell_name)
    windower.chat.input('/ma "' .. spell_name .. '" <me>')
end

local function start_teleport_magic_fallback()
    local item_name = utility_best_accessible_item(teleport_ring_names)

    if not item_name then
        add_to_chat(123, 'Teleport item is unavailable.')
        return
    end

    local spell_name = teleport_ring_spell_map[item_name]

    if not spell_name then
        add_to_chat(123, 'No Teleport spell mapping found for ' .. item_name .. '.')
        return
    end

    start_utility_magic_fallback(spell_name)
end

local function user_set_mode_if_available(state_name, mode_value, changed_modes)
    local state_var = state and state[state_name]

    if not state_var or not state_var.contains or not state_var:contains(mode_value) then
        return false
    end

    local old_value = state_var.value
    state_var:set(mode_value)

    if state_change then
        state_change(state_var.description or state_name, state_var.value, old_value)
    end

    changed_modes[#changed_modes + 1] = state_name .. ': ' .. state_var.current
    return true
end

local function user_mode_is_available(state_name, mode_value)
    local state_var = state and state[state_name]
    return state_var and state_var.contains and state_var:contains(mode_value)
end

local function user_mode_is_current(state_name, mode_value)
    local state_var = state and state[state_name]
    return state_var and state_var.value == mode_value
end

local function user_aminon_modes_active()
    local tracked_modes = {
        { 'IdleMode', 'Aminon' },
        { 'CastingMode', 'OccultAcumen' },
        { 'WeaponskillMode', 'Acc' },
        { 'OffenseMode', 'Acc' },
    }

    local available_modes = 0

    for _, mode in ipairs(tracked_modes) do
        if user_mode_is_available(mode[1], mode[2]) then
            available_modes = available_modes + 1

            if not user_mode_is_current(mode[1], mode[2]) then
                return false
            end
        end
    end

    return available_modes > 0
end

local function user_set_aminon_modes(enabled)
    local changed_modes = {}

    if enabled then
        user_set_mode_if_available('IdleMode', 'Aminon', changed_modes)
        user_set_mode_if_available('HybridMode', 'Aminon', changed_modes)
        user_set_mode_if_available('CastingMode', 'OccultAcumen', changed_modes)
        user_set_mode_if_available('WeaponskillMode', 'Acc', changed_modes)
        user_set_mode_if_available('OffenseMode', 'Acc', changed_modes)

        if user_set_mode_if_available('PhysicalDefenseMode', 'Aminon', changed_modes) then
            user_set_mode_if_available('DefenseMode', 'Physical', changed_modes)
        end

        if user_set_mode_if_available('MagicalDefenseMode', 'Aminon', changed_modes) then
            user_set_mode_if_available('DefenseMode', 'Magical', changed_modes)
        end

        if user_set_mode_if_available('ResistDefenseMode', 'Aminon', changed_modes) then
            user_set_mode_if_available('DefenseMode', 'Resist', changed_modes)
        end
    else
        user_set_mode_if_available('IdleMode', 'Normal', changed_modes)
        user_set_mode_if_available('HybridMode', 'Normal', changed_modes)
        user_set_mode_if_available('CastingMode', 'Normal', changed_modes)
        user_set_mode_if_available('WeaponskillMode', 'Match', changed_modes)
        user_set_mode_if_available('OffenseMode', 'Normal', changed_modes)
        user_set_mode_if_available('DefenseMode', 'None', changed_modes)
    end

    if #changed_modes == 0 then
        add_to_chat(123, 'No Aminon offense, defense, or idle modes are available for this job.')
        return
    end

    add_to_chat(122, 'Aminon modes ' .. (enabled and 'enabled' or 'disabled') .. ': ' .. table.concat(changed_modes, ', ') .. '.')
    handle_equipping_gear(player.status)
end

function user_state_change(stateField, newValue, oldValue)
    if stateField == 'HoxneMode' then
        set_hoxne_mode(newValue)
    end
end

local user_kiting_refresh_next = 0
local user_kiting_was_moving = false

local function user_should_equip_kiting()
    return player
        and player.status == 'Idle'
        and moving
        and sets
        and sets.Kiting
end

local function user_can_refresh_kiting()
    return not midaction()
        and not pet_midaction()
        and not (((petWillAct or 0) + 2) > os.clock())
end

function user_customize_kiting_set(baseSet)
    if user_should_equip_kiting() then
        baseSet = set_combine(baseSet, sets.Kiting)
    end

    return baseSet
end

windower.raw_register_event('prerender', function()
    local should_equip = user_should_equip_kiting()

    if should_equip and not user_kiting_was_moving and user_can_refresh_kiting() then
        local now = os.clock()

        if now > user_kiting_refresh_next then
            user_kiting_refresh_next = now + 1
            handle_equipping_gear(player.status)
        end
    end

    user_kiting_was_moving = moving or false
end)

local user_skillchain_elements = {
    ['Light'] = { 'Light', 'Fire', 'Wind', 'Lightning' },
    ['Darkness'] = { 'Dark', 'Ice', 'Earth', 'Water' },
    ['Fusion'] = { 'Light', 'Fire' },
    ['Fragmentation'] = { 'Wind', 'Lightning' },
    ['Distortion'] = { 'Ice', 'Water' },
    ['Gravitation'] = { 'Dark', 'Earth' },
    ['Transfixion'] = { 'Light' },
    ['Compression'] = { 'Dark' },
    ['Liquefaction'] = { 'Fire' },
    ['Liquification'] = { 'Fire' },
    ['Induration'] = { 'Ice' },
    ['Detonation'] = { 'Wind' },
    ['Scission'] = { 'Earth' },
    ['Impaction'] = { 'Lightning' },
    ['Reverberation'] = { 'Water' },
}

local user_skillchain_names = {
    'Fragmentation',
    'Liquefaction',
    'Liquification',
    'Reverberation',
    'Transfixion',
    'Compression',
    'Gravitation',
    'Distortion',
    'Induration',
    'Detonation',
    'Impaction',
    'Scission',
    'Darkness',
    'Fusion',
    'Light',
}

local user_burst_element_precedence = {
    'Lightning',
    'Ice',
    'Wind',
    'Fire',
    'Water',
    'Earth',
    'Dark',
    'Light',
}

local user_burst_precedence_index = {}
for index, element in ipairs(user_burst_element_precedence) do
    user_burst_precedence_index[element] = index
end

local user_last_skillchain = nil

local function user_normalize_incoming_text(text)
    return (text or ''):gsub(string.char(30) .. '.', ''):gsub(string.char(31) .. '.', '')
end

local function user_record_skillchain(skillchain_name, line)
    user_last_skillchain = {
        name = skillchain_name == 'Liquification' and 'Liquefaction' or skillchain_name,
        elements = user_skillchain_elements[skillchain_name],
        time = os.clock(),
        line = line,
    }
end

windower.raw_register_event('incoming text', function(original)
    local line = user_normalize_incoming_text(original)

    if not line:lower():contains('skillchain') then
        return
    end

    local lower_line = line:lower()

    for _, skillchain_name in ipairs(user_skillchain_names) do
        if lower_line:contains(skillchain_name:lower()) then
            user_record_skillchain(skillchain_name, line)
            return
        end
    end
end)

local function user_element_day_weather_bonus(element)
    local day_potency = 0
    local weather_potency = 0

    if element == world.day_element then
        day_potency = 10
    elseif element == data.elements.weak_to[world.day_element] then
        day_potency = -10
    end

    if element == world.weather_element then
        weather_potency = data.weather_bonus_potency[world.weather_intensity] or 0
    elseif element == data.elements.weak_to[world.weather_element] then
        weather_potency = (data.weather_bonus_potency[world.weather_intensity] or 0) * -1
    end

    return day_potency + weather_potency
end

local function user_spell_castable(spell_name)
    if not spell_name then
        return false
    end

    local spell_id = get_spell_id_by_name(spell_name)

    if not spell_id then
        return false
    end

    local spell_recasts = windower.ffxi.get_spell_recasts()

    return silent_can_cast(spell_name)
        and spell_recasts[spell_id] < spell_latency
        and actual_cost(spell_id) < player.mp
end

local function user_best_nuke_tier(element, command)
    local base_spell = data.elements.nuke_of[element]

    if not base_spell then
        return nil
    end

    if element == 'Light' then
        local spells = command == 'smallnuke'
            and { { name = 'Banish II', tier = 2 }, { name = 'Banish', tier = 1 } }
            or {
                { name = 'Holy II', tier = 5 },
                { name = 'Holy', tier = 4 },
                { name = 'Banish III', tier = 3 },
                { name = 'Banish II', tier = 2 },
                { name = 'Banish', tier = 1 },
            }

        for _, spell in ipairs(spells) do
            if user_spell_castable(spell.name) then
                return spell.tier
            end
        end

        return nil
    end

    local tiers = command == 'smallnuke'
        and { { suffix = ' II', tier = 2 }, { suffix = '', tier = 1 } }
        or {
            { suffix = ' VI', tier = 6 },
            { suffix = ' V', tier = 5 },
            { suffix = ' IV', tier = 4 },
            { suffix = ' III', tier = 3 },
            { suffix = ' II', tier = 2 },
            { suffix = '', tier = 1 },
        }

    for _, tier in ipairs(tiers) do
        if user_spell_castable(base_spell .. tier.suffix) then
            return tier.tier
        end
    end

    return nil
end

local function user_best_helix_tier(element)
    local base_spell = data.elements.helix_of[element]

    if not base_spell then
        return nil
    end

    if user_spell_castable(base_spell .. 'helix II') then
        return 2
    elseif user_spell_castable(base_spell .. 'helix') then
        return 1
    end

    return nil
end

local function user_best_ninjutsu_tier(element)
    local base_spell = data.elements.ninjutsu_nuke_of[element]

    if not base_spell or element == 'Light' or element == 'Dark' then
        return nil
    end

    local tiers = {
        { suffix = ': San', tier = 3 },
        { suffix = ': Ni', tier = 2 },
        { suffix = ': Ichi', tier = 1 },
    }

    for _, tier in ipairs(tiers) do
        if user_spell_castable(base_spell .. tier.suffix) then
            return tier.tier
        end
    end

    return nil
end

local function user_best_burst_tier(element, command)
    if command == 'helix' then
        return user_best_helix_tier(element)
    elseif command == 'ninjutsu' then
        return user_best_ninjutsu_tier(element)
    elseif command == 'nuke' or command == 'smallnuke' then
        return user_best_nuke_tier(element, command)
    end

    return nil
end

local function user_compare_burst_candidates(left, right)
    if not right then
        return true
    end

    if left.bonus ~= right.bonus then
        return left.bonus > right.bonus
    end

    if left.tier ~= right.tier then
        return left.tier > right.tier
    end

    return (user_burst_precedence_index[left.element] or 99) < (user_burst_precedence_index[right.element] or 99)
end

local function user_compare_burst_precedence(left, right)
    if not right then
        return true
    end

    return (user_burst_precedence_index[left.element] or 99) < (user_burst_precedence_index[right.element] or 99)
end

local function user_select_magic_burst_element(command)
    if not user_last_skillchain then
        return nil, 'No skillchain has been recorded since GearSwap loaded.'
    end

    local candidates = {}

    for _, element in ipairs(user_last_skillchain.elements or {}) do
        local tier = user_best_burst_tier(element, command)

        if tier then
            candidates[#candidates + 1] = {
                element = element,
                tier = tier,
                bonus = user_element_day_weather_bonus(element),
            }
        end
    end

    if #candidates == 0 then
        return nil, 'No castable ' .. command .. ' spell matches ' .. user_last_skillchain.name .. '.'
    end

    local best_weather_candidate = nil

    for _, candidate in ipairs(candidates) do
        if candidate.bonus > 0 and user_compare_burst_candidates(candidate, best_weather_candidate) then
            best_weather_candidate = candidate
        end
    end

    if best_weather_candidate then
        return best_weather_candidate
    end

    local highest_tier = 0

    for _, candidate in ipairs(candidates) do
        highest_tier = math.max(highest_tier, candidate.tier)
    end

    local best_tier_candidate = nil

    for _, candidate in ipairs(candidates) do
        if candidate.tier == highest_tier and user_compare_burst_precedence(candidate, best_tier_candidate) then
            best_tier_candidate = candidate
        end
    end

    return best_tier_candidate
end

local function user_handle_magic_burst_command(commandArgs)
    local command = (table.remove(commandArgs, 1) or 'nuke'):lower()
    local passthrough_commands = S { 'nuke', 'smallnuke', 'ninjutsu', 'helix' }

    if not passthrough_commands:contains(command) then
        add_to_chat(123, 'Magic burst command must be nuke, smallnuke, ninjutsu, or helix.')
        return
    end

    local candidate, error_message = user_select_magic_burst_element(command)

    if not candidate then
        add_to_chat(123, error_message)
        return
    end

    state.ElementalMode:set(candidate.element)
    add_to_chat(122, 'Magic Burst: ' .. user_last_skillchain.name .. ' -> ' .. candidate.element .. ' ' .. command .. ' (tier ' .. candidate.tier .. ', day/weather ' .. candidate.bonus .. ').')
    windower.chat.input('/console gs c elemental ' .. command .. (#commandArgs > 0 and ' ' .. table.concat(commandArgs, ' ') or ''))
end

local sortie_addons_enabled = false
local sortie_addons = { 'react', 'anchor', 'superwarp', 'skillchains', 'absorbtp' }

local function user_set_sortie_addons(enabled)
    for _, addon in ipairs(sortie_addons) do
        send_command('lua ' .. (enabled and 'load ' or 'unload ') .. addon)
    end

    sortie_addons_enabled = enabled
    add_to_chat(122, 'Sortie addons ' .. (enabled and 'enabled' or 'disabled') .. ': ' .. table.concat(sortie_addons, ', ') .. '.')
end

local user_wardrobe_bags = {
    { number = 1, id = 8, api = 'wardrobe', name = 'Mog Wardrobe', bag_names = S { 'wardrobe', 'mog wardrobe' } },
    { number = 2, id = 10, api = 'wardrobe2', name = 'Mog Wardrobe 2', bag_names = S { 'wardrobe2', 'wardrobe 2', 'mog wardrobe 2' } },
    { number = 3, id = 11, api = 'wardrobe3', name = 'Mog Wardrobe 3', bag_names = S { 'wardrobe3', 'wardrobe 3', 'mog wardrobe 3' } },
    { number = 4, id = 12, api = 'wardrobe4', name = 'Mog Wardrobe 4', bag_names = S { 'wardrobe4', 'wardrobe 4', 'mog wardrobe 4' } },
    { number = 5, id = 13, api = 'wardrobe5', name = 'Mog Wardrobe 5', bag_names = S { 'wardrobe5', 'wardrobe 5', 'mog wardrobe 5' } },
    { number = 6, id = 14, api = 'wardrobe6', name = 'Mog Wardrobe 6', bag_names = S { 'wardrobe6', 'wardrobe 6', 'mog wardrobe 6' } },
    { number = 7, id = 15, api = 'wardrobe7', name = 'Mog Wardrobe 7', bag_names = S { 'wardrobe7', 'wardrobe 7', 'mog wardrobe 7' } },
    { number = 8, id = 16, api = 'wardrobe8', name = 'Mog Wardrobe 8', bag_names = S { 'wardrobe8', 'wardrobe 8', 'mog wardrobe 8' } },
}

local user_wardrobe_bags_by_number = {}
for _, bag in ipairs(user_wardrobe_bags) do
    user_wardrobe_bags_by_number[bag.number] = bag
end

local user_unused_scan_jobs = {
    { job = 'BLU', file_job = 'Blu' },
    { job = 'BRD', file_job = 'Brd' },
    { job = 'COR', file_job = 'Cor' },
    { job = 'GEO', file_job = 'Geo' },
    { job = 'PLD', file_job = 'Pld' },
    { job = 'PUP', file_job = 'Pup' },
    { job = 'RDM', file_job = 'Rdm' },
    { job = 'SCH', file_job = 'Sch' },
    { job = 'SMN', file_job = 'Smn' },
    { job = 'WAR', file_job = 'War' },
}

local function user_item_name(item_id)
    local item = gearswap and gearswap.res and gearswap.res.items and gearswap.res.items[item_id]
    local language = gearswap and gearswap.language or 'english'

    if not item then
        return tostring(item_id)
    end

    return item[language] or item.english or item.en or tostring(item_id)
end

local function user_item_log_name(item_id)
    local item = gearswap and gearswap.res and gearswap.res.items and gearswap.res.items[item_id]
    local language = gearswap and gearswap.language or 'english'

    if not item then
        return tostring(item_id)
    end

    return item[language .. '_log'] or item.log_name or user_item_name(item_id)
end

local function user_normalize_item_name(name)
    return tostring(name or ''):lower()
end

local function user_normalize_bag_id(bag_name)
    if not bag_name then
        return nil
    end

    local normalized_bag_name = user_normalize_item_name(bag_name)

    for _, bag in ipairs(user_wardrobe_bags) do
        if bag.bag_names:contains(normalized_bag_name) then
            return bag.id
        end
    end

    return nil
end

local function user_build_wardrobe_item_ids(bags_to_scan)
    local item_ids = {}

    for _, bag in ipairs(bags_to_scan) do
        local wardrobe = windower.ffxi.get_items(bag.id)

        for _, item in ipairs(wardrobe or {}) do
            if type(item) == 'table' and item.id and item.id ~= 0 then
                item_ids[user_normalize_item_name(user_item_name(item.id))] = item.id
                item_ids[user_normalize_item_name(user_item_log_name(item.id))] = item.id
            end
        end
    end

    return item_ids
end

local function user_copy_augments(augments)
    if type(augments) ~= 'table' then
        return nil
    end

    local copied_augments = {}

    for index, augment in pairs(augments) do
        if augment and augment ~= 'none' then
            copied_augments[index] = augment
        end
    end

    return next(copied_augments) and copied_augments or nil
end

local function user_set_item_augments(set_item)
    return user_copy_augments(set_item.augments)
        or (set_item.augment and set_item.augment ~= 'none' and { set_item.augment } or nil)
end

local function user_inventory_item_augments(item)
    if not item or not gearswap or not gearswap.extdata or not gearswap.extdata.decode then
        return nil
    end

    local decoded_item = gearswap.extdata.decode(item)

    return decoded_item and user_copy_augments(decoded_item.augments) or nil
end

local function user_augments_key(augments)
    if not augments then
        return ''
    end

    local parts = {}

    for index, augment in pairs(augments) do
        parts[#parts + 1] = tostring(index) .. '=' .. tostring(augment)
    end

    table.sort(parts)

    return table.concat(parts, '|')
end

local function user_augments_match(wanted_augments, item_augments)
    -- Extdata augment strings vary for paths/ranks, so name/id is authoritative
    -- for unused scans. The wanted augment key still preserves duplicate counts.
    return true
end

local function user_augments_display(augments)
    if not augments then
        return ''
    end

    local parts = {}

    for _, augment in pairs(augments) do
        parts[#parts + 1] = tostring(augment)
    end

    table.sort(parts)

    return #parts > 0 and ' [' .. table.concat(parts, '; ') .. ']' or ''
end

local function user_find_item_id(item_name, wardrobe_item_ids)
    return wardrobe_item_ids[user_normalize_item_name(item_name)]
end

local function user_add_path_candidate(path_candidates, seen_paths, path)
    if path and not seen_paths[path] then
        path_candidates[#path_candidates + 1] = path
        seen_paths[path] = true
    end
end

local function user_read_text_file(relative_path)
    local path_candidates = {}
    local seen_paths = {}

    user_add_path_candidate(path_candidates, seen_paths, relative_path)

    if windower and windower.addon_path then
        user_add_path_candidate(path_candidates, seen_paths, windower.addon_path .. relative_path)
    end

    if windower and windower.windower_path then
        user_add_path_candidate(path_candidates, seen_paths, windower.windower_path .. 'addons/GearSwap/' .. relative_path)
        user_add_path_candidate(path_candidates, seen_paths, windower.windower_path .. 'addons/gearswap/' .. relative_path)
    end

    for _, path in ipairs(path_candidates) do
        local file = io.open(path, 'r')

        if file then
            local text = file:read('*a')
            file:close()
            return text, path
        end
    end

    return nil, nil
end

local function user_strip_lua_comments(source)
    source = source:gsub('%-%-%[%[.-%]%]', '')
    source = source:gsub('%-%-[^\r\n]*', '')

    return source
end

local function user_count_gear_source_items(source, wardrobe_item_ids)
    local counts = {}

    source = user_strip_lua_comments(source)

    for item_name in source:gmatch('"(.-)"') do
        local item_id = user_find_item_id(item_name, wardrobe_item_ids)

        if item_id then
            counts[item_id] = (counts[item_id] or 0) + 1
        end
    end

    for item_name in source:gmatch("'(.-)'") do
        local item_id = user_find_item_id(item_name, wardrobe_item_ids)

        if item_id then
            counts[item_id] = (counts[item_id] or 0) + 1
        end
    end

    return counts
end

local function user_other_job_gear_files()
    local character_name = player and player.name or 'Kalali'
    local current_job = player and player.main_job or nil
    local files = {}

    for _, job_info in ipairs(user_unused_scan_jobs) do
        if job_info.job ~= current_job then
            files[#files + 1] = 'data/' .. character_name .. '/' .. character_name .. '_' .. job_info.file_job .. '_Gear.lua'
        end
    end

    return files
end

local function user_add_wanted_item(wanted_items, wanted_keys, item_id, set_item, slot)
    if not item_id then
        return
    end

    local augments = type(set_item) == 'table' and user_set_item_augments(set_item) or nil
    local bag_id = type(set_item) == 'table' and user_normalize_bag_id(set_item.bag) or nil
    local entry_key = table.concat({ item_id, user_augments_key(augments), bag_id or '', slot or '' }, '#')

    if wanted_keys[entry_key] then
        return
    end

    wanted_keys[entry_key] = true
    wanted_items[#wanted_items + 1] = {
        id = item_id,
        name = user_item_name(item_id),
        augments = augments,
        bag_id = bag_id,
        used = false,
    }
end

local function user_collect_gearset_items(table_level, wardrobe_item_ids, wanted_items, wanted_keys, visited_tables, parent_key)
    if type(table_level) ~= 'table' or visited_tables[table_level] then
        return
    end

    if table_level.name then
        user_add_wanted_item(wanted_items, wanted_keys, user_find_item_id(table_level.name, wardrobe_item_ids), table_level, parent_key)
        return
    end

    visited_tables[table_level] = true

    for key, value in pairs(table_level) do
        if type(value) == 'table' and key ~= 'augments' then
            user_collect_gearset_items(value, wardrobe_item_ids, wanted_items, wanted_keys, visited_tables, key)
        elseif type(value) == 'string' and value ~= 'augment' and value ~= 'augments' and value ~= 'priority' then
            user_add_wanted_item(wanted_items, wanted_keys, user_find_item_id(value, wardrobe_item_ids), value, key)
        end
    end
end

local function user_build_wanted_gearset_items(bags_to_scan)
    local wardrobe_item_ids = user_build_wardrobe_item_ids(bags_to_scan)
    local wanted_items = {}
    local wanted_keys = {}
    local scanned_files = 0
    local unread_files = 0

    if sets then
        user_collect_gearset_items(sets, wardrobe_item_ids, wanted_items, wanted_keys, {}, nil)
    end

    for _, gear_file in ipairs(user_other_job_gear_files()) do
        local source = user_read_text_file(gear_file)

        if source then
            scanned_files = scanned_files + 1

            for item_id, count in pairs(user_count_gear_source_items(source, wardrobe_item_ids)) do
                for occurrence = 1, count do
                    user_add_wanted_item(wanted_items, wanted_keys, item_id, nil, gear_file .. ':' .. occurrence)
                end
            end
        else
            unread_files = unread_files + 1
        end
    end

    return wanted_items, scanned_files, unread_files
end

local function user_match_wanted_item(item, bag_id, wanted_items)
    local item_augments = user_inventory_item_augments(item)
    local best_match = nil
    local best_score = -1

    for index, wanted_item in ipairs(wanted_items) do
        if not wanted_item.used
            and wanted_item.id == item.id
            and (not wanted_item.bag_id or wanted_item.bag_id == bag_id)
            and user_augments_match(wanted_item.augments, item_augments) then

            local score = 0

            if wanted_item.bag_id == bag_id then
                score = score + 2
            end

            if wanted_item.augments then
                score = score + 4
            end

            if score > best_score then
                best_match = index
                best_score = score
            end
        end
    end

    if best_match then
        wanted_items[best_match].used = true
        return true
    end

    return false, item_augments
end

local function user_scan_unused_wardrobe_gear(cmdParams)
    local wardrobe_number = cmdParams[1] and tonumber(cmdParams[1]) or nil
    local bags_to_scan = {}

    if cmdParams[1] and not wardrobe_number then
        add_to_chat(123, 'Unused command usage: gs c unused [1-8].')
        return
    end

    if wardrobe_number then
        if not user_wardrobe_bags_by_number[wardrobe_number] then
            add_to_chat(123, 'Unused command usage: gs c unused [1-8].')
            return
        end

        bags_to_scan = { user_wardrobe_bags_by_number[wardrobe_number] }
    else
        bags_to_scan = user_wardrobe_bags
    end

    local wanted_items, scanned_files, unread_files = user_build_wanted_gearset_items(bags_to_scan)
    local total_unused = 0

    add_to_chat(122, 'Unused scan comparing against current job plus ' .. scanned_files .. ' other job gear file(s).')

    if unread_files > 0 then
        add_to_chat(123, 'Unused scan could not read ' .. unread_files .. ' other job gear file(s).')
    end

    for _, bag in ipairs(bags_to_scan) do
        local wardrobe = windower.ffxi.get_items(bag.id)
        local bag_unused = {}

        for slot, item in ipairs(wardrobe or {}) do
            if type(item) == 'table' and item.id and item.id ~= 0 then
                local matched, augments = user_match_wanted_item(item, bag.id, wanted_items)

                if not matched then
                    bag_unused[#bag_unused + 1] = {
                        slot = slot,
                        name = user_item_name(item.id),
                        augments = augments,
                    }
                end
            end
        end

        total_unused = total_unused + #bag_unused

        if #bag_unused > 0 then
            add_to_chat(122, bag.name .. ' unused gear: ' .. #bag_unused)

            for _, unused_item in ipairs(bag_unused) do
                add_to_chat(122, '  [' .. unused_item.slot .. '] ' .. unused_item.name .. user_augments_display(unused_item.augments))
            end
        elseif wardrobe_number then
            add_to_chat(122, bag.name .. ': no unused gear found.')
        end
    end

    if not wardrobe_number then
        if total_unused == 0 then
            add_to_chat(122, 'No unused gear found in Mog Wardrobes 1-8.')
        else
            add_to_chat(122, 'Unused gear scan complete: ' .. total_unused .. ' item(s) not found in gearsets.')
        end
    end
end

function user_self_command(commandArgs, eventArgs)
    local command = commandArgs[1] and commandArgs[1]:lower() or ''

    if command == 'unused' then
        eventArgs.handled = true
        table.remove(commandArgs, 1)
        user_scan_unused_wardrobe_gear(commandArgs)
        return
    end

    if command == 'mb' or command == 'magicburst' or command == 'burst' then
        eventArgs.handled = true
        table.remove(commandArgs, 1)
        user_handle_magic_burst_command(commandArgs)
        return
    end

    if command == 'sortie' then
        eventArgs.handled = true
        user_set_sortie_addons(not sortie_addons_enabled)
        return
    end

    if command == 'aminon' then
        eventArgs.handled = true
        user_set_aminon_modes(not user_aminon_modes_active())
        return
    end

    if command == 'warp' then
        eventArgs.handled = true
        start_utility_magic_fallback('Warp')
        return
    end

    if command == 'teleport' or command == 'tele' then
        eventArgs.handled = true
        start_teleport_magic_fallback()
        return
    end

    if command == 'reraise' or command == 'rr' then
        eventArgs.handled = true
        start_utility_magic_fallback('Reraise')
        return
    end

    if command == 'sneak' then
        eventArgs.handled = true
        windower.chat.input('/ma "Sneak" <me>')
        return
    end

    if command == 'invisible' or command == 'invis' then
        eventArgs.handled = true
        windower.chat.input('/ma "Invisible" <me>')
        return
    end
end

local base_extra_user_setup = extra_user_setup
function extra_user_setup()
    if base_extra_user_setup then
        base_extra_user_setup()
    end

    apply_dual_wield_weapon_defaults:schedule(1)
end
