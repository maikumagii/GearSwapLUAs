-- Resolve offhands before the framework equips and locks the selected weapon set.
-- Auto keeps TP offhands for physical sword/club modes, but favors accuracy in Acc.
-- TP explicitly overrides OffenseMode.
local rdm_offhands = {
    DualNaegling = { default = "Gleti's Knife", tp = true },
    DualExcalibur = { default = "Gleti's Knife", tp = true },
    DualMaxentius = { default = "Gleti's Knife", tp = true },
    DualCrocea = { default = "Daybreak" },
    DualPrime = { default = "Gleti's Knife" },
}

local function prepare_weaponset()
    if not state.OffhandMode or not sets or not sets.weapons then
        return
    end
    for name, config in pairs(rdm_offhands) do
        if sets.weapons[name] then
            local use_tp = state.OffhandMode.value == 'TP'
                or (state.OffhandMode.value == 'Auto' and config.tp
                    and state.OffenseMode.value ~= 'Acc')
            sets.weapons[name].sub = use_tp and gear.tp_bonus_sword or config.default
            if name == 'DualCrocea' then
                autows_list[name] = use_tp and 'Savage Blade' or 'Sanguine Blade'
            end
        end
    end
end

-- Sel's implementation is already loaded when this character sidecar is included.
-- Resolve the set before it is equipped/locked, without editing shared Sel files.
local base_equip_weaponset = equip_weaponset
function equip_weaponset()
    prepare_weaponset()
    return base_equip_weaponset()
end

local base_user_job_state_change = user_job_state_change
function user_job_state_change(stateField, newValue, oldValue)
    if base_user_job_state_change then
        base_user_job_state_change(stateField, newValue, oldValue)
    end
    if stateField == 'Offhand Mode' or stateField == 'Offense Mode' then
        equip_weaponset()
        set_autows(state.Weapons.value)
    end
end

-- Specialty weapon sets remain selectable by command, but are skipped by cycling.
local manual_weapons = { DualEnspellOnly = true }

local function register_manual_weapon(name)
    for manual_name in pairs(manual_weapons) do
        if name:lower() == manual_name:lower() then
            name = manual_name
            break
        end
    end
    if manual_weapons[name] and sets.weapons[name] and not state.Weapons:contains(name) then
        local current = state.Weapons.value
        local options = {}
        for _, option in ipairs(state.Weapons) do
            options[#options + 1] = option
        end
        options[#options + 1] = name
        state.Weapons:options(unpack(options))
        state.Weapons:set(current)
    end
end

local base_handle_set = handle_set
function handle_set(cmdParams)
    if cmdParams[1] and cmdParams[1]:lower() == 'weapons' then
        register_manual_weapon(table.concat(cmdParams, ' ', 2))
    end
    return base_handle_set(cmdParams)
end

function configure_rdm_manual_weapons()
    local weapons = state.Weapons
    local base_cycle = weapons.cycle
    local base_cycleback = weapons.cycleback
    weapons.cycle = function(mode)
        repeat
            base_cycle(mode)
        until not manual_weapons[mode.value]
        return mode.current
    end
    weapons.cycleback = function(mode)
        repeat
            base_cycleback(mode)
        until not manual_weapons[mode.value]
        return mode.current
    end
end
