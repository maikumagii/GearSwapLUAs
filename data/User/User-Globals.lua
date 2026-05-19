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

function user_self_command(commandArgs, eventArgs)
    local command = commandArgs[1]:lower()

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
