-- PLD-only sidecar for separating main-hand weapon mode from shield mode.

local pld_shield_base_job_state_change = job_state_change

local function pld_current_weapon_set()
    if not state or not state.Weapons or not sets or not sets.weapons then
        return nil
    end

    if state.Weapons.value == 'None' then
        return nil
    end

    return sets.weapons[state.Weapons.value]
end

local function pld_current_shield_set()
    if not state or not state.Shield or not sets or not sets.shields then
        return nil
    end

    if state.Shield.value == 'None' then
        return nil
    end

    return sets.shields[state.Shield.value]
end

local function pld_current_weapon_lock_set()
    if state and state.UnlockWeapons and state.UnlockWeapons.value then
        return nil
    end

    local weaponSet = pld_current_weapon_set()
    local shieldSet = pld_current_shield_set()

    if weaponSet and shieldSet then
        return set_combine(weaponSet, shieldSet)
    end

    return weaponSet or shieldSet
end

local function pld_apply_weapon_and_shield_lock()
    local lockSet = pld_current_weapon_lock_set()

    if lockSet then
        internal_disable_set(lockSet, "Weapons")
    else
        internal_enable_set("Weapons")
    end
end

function pld_init_shield_state()
    state.Shield = M { ['description'] = 'Shield', 'None', 'Srivatsa', 'Duban', 'Aegis', 'Blurred', 'Sacro', 'Priwen' }
end

function pld_init_shield_sets()
    sets.shields = {
        Srivatsa = { sub = gear.srivatsa },
        Duban = { sub = "Duban" },
        Aegis = { sub = "Aegis" },
        Blurred = { sub = "Blurred Shield +1" },
        Sacro = { sub = "Sacro Bulwark" },
        Priwen = { sub = "Priwen" },
    }
end

function pld_should_keep_shield_for_reprisal(baseSet)
    if state and state.Shield and state.Shield.value ~= 'None' then
        return true
    end

    return baseSet and baseSet.sub == gear.srivatsa
end

function job_state_change(stateField, newValue, oldValue)
    if pld_shield_base_job_state_change then
        pld_shield_base_job_state_change(stateField, newValue, oldValue)
    end

    if stateField == 'Weapons' or stateField == 'Shield' or stateField == 'Unlock Weapons' then
        pld_apply_weapon_and_shield_lock()
    end
end
