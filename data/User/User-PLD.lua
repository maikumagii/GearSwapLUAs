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

function get_custom_wsmode(spell, spellMap, default_wsmode)
    if state.Weapons.value == 'ExcaliburBlurred'
        and sets.precast.WS[spell.english]
        and sets.precast.WS[spell.english].ExcaliburBlurred then
        if default_wsmode == 'Acc' and sets.precast.WS[spell.english].ExcaliburBlurredAcc then
            return 'ExcaliburBlurredAcc'
        end

        return 'ExcaliburBlurred'
    end
end
