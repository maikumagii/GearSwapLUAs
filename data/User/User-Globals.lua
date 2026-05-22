--Place for your settings and custom functions that are meant to affect all of your jobs and characters.
latency                = .25
--If this is set to true it will prevent you from casting shadows when you have more up than that spell would generate.
conserveshadows        = false

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

local hoxne_ampulla_name = 'Hoxne Ampulla'
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

function user_state_change(stateField, newValue, oldValue)
    if stateField == 'Hoxne Ampulla Mode' then
        set_hoxne_ampulla_mode(newValue)
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

function user_self_command(commandArgs, eventArgs)
    local command = commandArgs[1] and commandArgs[1]:lower() or ''

    if command == 'mb' or command == 'magicburst' or command == 'burst' then
        eventArgs.handled = true
        table.remove(commandArgs, 1)
        user_handle_magic_burst_command(commandArgs)
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
