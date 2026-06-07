local function should_pld_cure_cheat(spell, spellMap)
    return state.AutoCureCheat
        and state.AutoCureCheat.value
        and spell.target.type == 'SELF'
        and spellMap
        and spellMap:contains('Cure')
end

function user_job_post_precast(spell, spellMap, eventArgs)
    if should_pld_cure_cheat(spell, spellMap) and sets.HPDown then
        curecheat = true
        equip(sets.HPDown)
        eventArgs.handled = true
    end
end

function user_job_post_midcast(spell, spellMap, eventArgs)
    if should_pld_cure_cheat(spell, spellMap) and sets.HPCure then
        equip(sets.HPCure)
        curecheat = false
        eventArgs.handled = true
    end
end
