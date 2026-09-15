-- Starter sets rebuilt from OWNEDGEAR.md; job/slot flags and base stats verified
-- against Windower/Resources resources_data/items.lua and item_descriptions.lua.
-- Only recorded augments are selected. Empty JSE aliases are acquisition hooks.
function character_user_job_setup()
    state.OffenseMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.WeaponskillMode:options('Match', 'Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder', 'Proc')
    state.HybridMode:options('Normal', 'PDT', 'MDT')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
    state.Weapons:options('None', 'Tauret', 'RudraTPBonus')
    state.WeaponSets:options('Default')
    weapon_sets = { Default = { 'None', 'Tauret', 'RudraTPBonus' } }
    default_weapons = 'Tauret'
    default_dual_weapons = 'Tauret'
    autows_list = { Tauret = 'Evisceration', RudraTPBonus = "Rudra's Storm" }
    autows = 'Evisceration'
    state.ExtraMeleeMode = M {
        ['description'] = 'Extra Melee Mode',
        'None',
        'Suppa',
        'DWEarrings',
        'DWMax'
    }

    -- No Senuna's Mantle is listed: combat sets use Null Shawl directly.
    gear.jse_back = '' -- Senuna's Mantle: Samba duration (acquire separately).
    gear.reverse_flourish_back = '' -- Toetapper Mantle with Reverse Flourish augment.
    gear.af1_head = '' -- Maxixi Tiara: Samba.
    gear.af1_feet = '' -- Maxixi Toe Shoes: Jig.
    gear.af2_head = '' -- Horos Tiara: Trance.
    gear.af2_body = '' -- Horos Casaque: No Foot Rise.
    gear.af2_legs = '' -- Horos Tights: Jig / Saber Dance.
    gear.af2_feet = '' -- Horos Toe Shoes: Step accuracy.
    gear.af3_head = '' -- Maculele Tiara: Climactic Flourish.
    gear.af3_body = '' -- Maculele Casaque: Striking Flourish.
    gear.af3_hands = '' -- Maculele Bangles: Reverse Flourish / skillchain bonus.
    -- Aeneas / Taming Sari are future weapons, not owned entries.

    send_command('bind @` gs c step')
    send_command('bind ^!@` gs c toggle usealtstep')
    send_command('bind ^@` gs c cycle mainstep')
    send_command('bind !@` gs c cycle altstep')
    send_command('bind ^` input /ja "Saber Dance" <me>')
    send_command('bind !` input /ja "Fan Dance" <me>')
    send_command('bind ^\\\\ input /ja "Chocobo Jig II" <me>')
    send_command('bind !\\\\ input /ja "Spectral Jig" <me>')
    send_command('bind !backspace input /ja "Reverse Flourish" <me>')
    send_command('bind ^backspace input /ja "No Foot Rise" <me>')
    send_command('bind %~` gs c cycle SkillchainMode')
    select_default_macro_book()
end

function init_gear_sets()
    sets.weapons.None = {}
    -- Nyame is user-confirmed Path B, rank 20.
    -- Use the owned pieces without claiming fully ranked bonuses.
    sets.idle = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Alabaster Earring",
        ear2 = "Sanare Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Moonlight Cape",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }
    sets.idle.PDT = set_combine(sets.idle, { ring1 = "Murky Ring", ring2 = "Moonlight Ring" })
    sets.idle.Refresh = set_combine(sets.idle, {
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" }
    })
    sets.idle.Weak = set_combine(sets.idle.PDT, {})
    sets.resting = set_combine(sets.idle.Refresh, {})
    sets.defense.PDT = set_combine(sets.idle.PDT, {})
    sets.defense.MDT = set_combine(sets.idle.PDT, { neck = "Warder's Charm +1" })
    sets.defense.MEVA = set_combine(sets.defense.MDT, { back = "Null Shawl" })
    sets.Kiting = { ring2 = "Shneddick Ring" }
    -- Twilight Helm/Mail and Frenzy Sallet are not owned: no automatic swaps.
    sets.Reraise = {}
    sets.buff.Sleep = {}
    sets.buff.Doom = { neck = "Nicander's Necklace", ring1 = "Purity Ring", waist = "Gishdubar Sash" }
    -- Perfect Lucky Egg cannot be equipped by these jobs.
    sets.TreasureHunter = { head = "Wh. Rarab Cap +1", ring1 = "Hoxne Ring", waist = "Chaac Belt" }
    sets.Self_Healing = { waist = "Gishdubar Sash" }
    sets.Cure_Received = { waist = "Gishdubar Sash" }
    sets.Self_Refresh = { waist = "Gishdubar Sash" }

    -- Casting gear: retain defensive armor where no owned Fast Cast piece exists.
    sets.precast.FC = set_combine(sets.idle.PDT, {
        ammo = "Impatiens",
        neck = "Voltsurge Torque",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Loquac. Earring",
        ring1 = "Lebeche Ring",
        ring2 = "Prolix Ring"
    })
    sets.midcast.FastRecast = set_combine(sets.precast.FC, { ammo = "Staunch Tathlum +1" })
    sets.midcast.Cure = set_combine(sets.idle.PDT, {
        ear1 = "Mendi. Earring",
        ear2 = "Enchntr. Earring +1",
        ring1 = "Menelaus's Ring",
        ring2 = "Lebeche Ring"
    })
    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
    sets.precast.Waltz = set_combine(sets.idle.PDT, {
        neck = "Unmoving Collar +1",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Tuisto Earring",
        legs = "Dashing Subligar"
    })
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Default physical WS foundation; specific multihit / critical sets follow.
    sets.precast.WS = {
        ammo = "Oshasha's Treatise",
        head = "Nyame Helm",
        neck = "Rep. Plat. Medal",
        ear1 = "Moonshade Earring",
        ear2 = "Ishvara Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Epaminondas's Ring",
        ring2 = "Ephramad's Ring",
        back = "Null Shawl",
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, { neck = "Null Loop" })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS.Acc, { ear2 = "Telos Earring" })
    sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})
    sets.precast.WS.Proc = set_combine(sets.idle.PDT, {})
    sets.MaxTP = { ear1 = "Telos Earring" }
    sets.AccMaxTP = { ear1 = "Cessance Earring" }
    sets.weapons.Tauret = { main = "Tauret", sub = "Gleti's Knife" }
    -- Optional TP-bonus offhand: lower offhand accuracy and no Gleti Waltz bonus.
    sets.weapons.RudraTPBonus = { main = "Tauret", sub = gear.tp_bonus_dagger }
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { body = "Passion Jacket" })
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, { body = "Passion Jacket" })

    -- Malignance gives 31% DT; Null Loop and both rings bring the default to 51%.
    sets.engaged = {
        ammo = "Aurgelmir Orb +1",
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Telos Earring",
        ear2 = "Sherida Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Murky Ring",
        ring2 = "Moonlight Ring",
        back = "Null Shawl",
        waist = "Reiki Yotai",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }
    -- Reiki supplies 7 DW for capped magic haste with DNC's level-99 DW trait.
    -- Extra Melee Mode None keeps the base DW; add overlays as haste support falls.
    sets.Suppa = { ear1 = "Suppanomimi" }
    sets.DWEarrings = { ear1 = "Suppanomimi", ear2 = "Eabani Earring" }
    sets.DWMax = {
        ear1 = "Suppanomimi",
        ear2 = "Eabani Earring",
        body = "Adhemar Jacket +1",
        waist = "Reiki Yotai"
    }
    sets.engaged.SomeAcc = set_combine(sets.engaged, {})
    sets.engaged.Acc = set_combine(sets.engaged, {})
    sets.engaged.FullAcc = set_combine(sets.engaged.Acc, { ammo = "Staunch Tathlum +1" })
    sets.engaged.Fodder = set_combine(sets.engaged, {
        head = "Adhemar Bonnet +1",
        body = "Adhemar Jacket +1",
        hands = "Adhemar Wrist. +1",
        ring1 = "Ilabrat Ring",
        ring2 = "Epona's Ring",
        waist = "Sailfi Belt +1",
        feet = gear.herculean_ta_feet
    })

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shark Bite'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        ammo = "Aurgelmir Orb +1",
        head = "Adhemar Bonnet +1",
        neck = "Fotia Gorget",
        ear1 = "Telos Earring",
        ear2 = "Sherida Earring",
        body = "Gleti's Cuirass",
        hands = "Adhemar Wrist. +1",
        ring1 = "Ilabrat Ring",
        ring2 = "Epona's Ring",
        waist = "Fotia Belt",
        legs = "Gleti's Breeches",
        feet = gear.herculean_ta_feet
    })
    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS['Evisceration'], {
        body = "Adhemar Jacket +1",
        legs = "Nyame Flanchard"
    })
    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS['Pyrrhic Kleos'], {})
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        ammo = "Pemphredo Tathlum",
        neck = "Sibyl Scarf",
        ear1 = "Moonshade Earring",
        ear2 = "Friomisi Earring",
        ring1 = "Shiva Ring +1",
        ring2 = "Metamor. Ring +1",
        waist = "Orpheus's Sash"
    })
    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)
    sets.MaxTP['Aeolian Edge'] = { ear1 = "Ishvara Earring" }
    sets.AccMaxTP['Aeolian Edge'] = { ear1 = "Ishvara Earring" }
    -- Do not replace Evisceration's TP earrings at 3000 TP: it does not use Moonshade.
    sets.MaxTP.Evisceration = {}
    sets.AccMaxTP.Evisceration = {}
    sets.MaxTP['Pyrrhic Kleos'] = {}
    sets.AccMaxTP['Pyrrhic Kleos'] = {}
    sets.MaxTP['Dancing Edge'] = {}
    sets.AccMaxTP['Dancing Edge'] = {}

    -- Waltz potency from Passion Jacket / Dashing Subligar; Gleti's Knife adds
    -- another 10% when already equipped. Do not swap weapons and lose TP to cure.
    sets.precast.Waltz = set_combine(sets.precast.Waltz, {
        body = "Passion Jacket",
        hands = "Gleti's Gauntlets",
        feet = "Nyame Sollerets",
        waist = "Chaac Belt"
    })
    sets.precast.Waltz['Healing Waltz'] = {}
    sets.Self_Waltz = {} -- Asklepian Ring is not owned.
    sets.precast.Step = set_combine(sets.engaged.Acc, { ammo = "Aurgelmir Orb +1", waist = "Null Belt" })
    sets.precast.Step = set_combine(sets.precast.Step, { feet = gear.af2_feet ~= '' and gear.af2_feet or nil })
    sets.Enmity = set_combine(sets.idle.PDT, {
        neck = "Unmoving Collar +1",
        ear1 = "Cryptic Earring",
        ear2 = "Friomisi Earring",
        body = "Passion Jacket"
    })
    sets.precast.JA.Provoke = sets.Enmity
    sets.precast.JA['No Foot Rise'] = { body = gear.af2_body }
    sets.precast.JA.Trance = { head = gear.af2_head }
    sets.precast.Samba = { head = gear.af1_head, back = gear.jse_back }
    sets.precast.Jig = { legs = gear.af2_legs, feet = gear.af1_feet }
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity
    -- Violent Flourish needs both physical accuracy and magic accuracy for its stun.
    sets.precast.Flourish1['Violent Flourish'] = set_combine(sets.precast.Step, {
        ammo = "Pemphredo Tathlum",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Crep. Earring",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" }
    })
    sets.precast.Flourish1['Desperate Flourish'] = set_combine(sets.precast.Step, {})
    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = { hands = gear.af3_hands, back = gear.reverse_flourish_back }
    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = { body = gear.af3_body }
    sets.precast.Flourish3['Climactic Flourish'] = { head = gear.af3_head }
    sets.buff['Climactic Flourish'] = { head = gear.af3_head }
    sets.buff['Saber Dance'] = { legs = gear.af2_legs }
    sets.Skillchain = { hands = gear.af3_hands }
    sets.ExtraRegen = {
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        waist = "Null Belt"
    }
    -- Match each offense mode to a complete defensive overlay.
    for _, mode in ipairs({ 'Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder' }) do
        local melee = mode == 'Normal' and sets.engaged or sets.engaged[mode]
        melee.PDT = set_combine(melee, {
            head = "Malignance Chapeau",
            body = "Malignance Tabard",
            hands = "Malignance Gloves",
            legs = "Malignance Tights",
            feet = "Malignance Boots",
            ammo = "Staunch Tathlum +1",
            neck = "Null Loop",
            ear1 = "Alabaster Earring",
            ring1 = "Murky Ring",
            ring2 = "Moonlight Ring"
        })
        melee.MDT = set_combine(melee.PDT, { neck = "Warder's Charm +1", back = "Null Shawl" })
    end
    -- Build accuracy variants from each actual WS, preserving its damage-specific gear.
    for name, ws in pairs(sets.precast.WS) do
        if type(ws) == 'table' and ws.body and name ~= 'SomeAcc' and name ~= 'Acc'
            and name ~= 'FullAcc' and name ~= 'Fodder' and name ~= 'Proc' then
            local base = {}
            for _, slot in ipairs({ 'main', 'sub', 'range', 'ammo', 'head', 'body', 'hands', 'legs', 'feet', 'neck', 'waist', 'back', 'ear1', 'ear2', 'ring1', 'ring2' }) do
                base[slot] = ws[slot]
            end
            ws.SomeAcc = set_combine(base, { neck = "Null Loop" })
            ws.Acc = set_combine(ws.SomeAcc, {})
            ws.FullAcc = set_combine(ws.Acc, { ear2 = base.ear1 == "Telos Earring" and base.ear2 or "Telos Earring" })
            ws.Fodder = set_combine(base, {})
        end
    end
    sets.precast.WS['Aeolian Edge'].FullAcc = set_combine(sets.precast.WS['Aeolian Edge'].Acc, {
        ear2 = "Enchntr. Earring +1"
    })
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(10, 9)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'SAM' then
        set_macro_page(9, 9)
    elseif player.sub_job == 'THF' then
        set_macro_page(8, 9)
    else
        set_macro_page(10, 9)
    end
end
