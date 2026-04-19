--Place for your settings and custom functions that are meant to affect all of your jobs and characters.
latency                = .25
--If this is set to true it will prevent you from casting shadows when you have more up than that spell would generate.
conserveshadows        = false
--Display related settings.

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
    if commandArgs[1]:lower() ~= 'warp' then
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
