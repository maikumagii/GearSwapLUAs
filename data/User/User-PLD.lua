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
