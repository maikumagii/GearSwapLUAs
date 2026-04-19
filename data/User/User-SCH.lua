function user_job_setup()
    state.MusaMode = M { ['description'] = 'MusaMode', 'Never', '1000', 'Always' }
end

function user_job_post_precast(spell, spellMap, eventArgs)
    if spell.action_type ~= 'Magic' then
        return
    end

    if not spell.english:startswith('Regen') then
        return
    end

    if state.MusaMode.value ~= 'Never'
        and state.Weapons.value ~= 'None'
        and not state.UnlockWeapons.value
        and (state.MusaMode.value == 'Always' or tonumber(state.MusaMode.value) > player.tp) then
        internal_enable_set("Weapons")
    end
end
