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
    state.Weapons:options('None', 'Naegling')
    state.WeaponSets:options('Default')
    weapon_sets = { Default = { 'None', 'Naegling' } }
    default_weapons = 'Naegling'
    autows_list = { Naegling = 'Savage Blade' }
    autows = 'Savage Blade'
    state.ExtraMeleeMode = M { ['description'] = 'Extra Melee Mode', 'None' }
    state.Passive = M { ['description'] = 'Passive Mode', 'None', 'MP' }
    state.CastingMode:options('Normal', 'Resistant')
    state.DrainSwapWeaponMode = M { 'Never', 'Always', '300', '1000' }

    -- No great sword or scythe is listed in OWNEDGEAR. Naegling is the starter.
    -- Montante +1 / Anguta / Liberator / Misanthropy remain future weapons.
    gear.af1_head = '' -- Ignominy Burgeonet: Souleater.
    gear.af1_feet = '' -- Ignominy Sollerets: Arcane Circle.
    gear.af2_head = '' -- Fallen's Burgeonet: Dark Seal.
    gear.af2_body = '' -- Fallen's Cuirass: Blood Weapon.
    gear.af2_hands = '' -- Fallen's Finger Gauntlets: Weapon Bash.
    gear.af2_legs = '' -- Fallen's Flanchard: Diabolic Eye.
    gear.af3_body = '' -- Heathen's Cuirass: Dread Spikes.
    gear.af3_legs = '' -- Heathen's Flanchard: Nether Void.
    gear.jse_back = '' -- Ankou's Mantle: Last Resort / Absorb.

    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
    send_command('bind @` gs c cycle SkillchainMode')
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
        ammo = "Knobkierrie",
        head = "Nyame Helm",
        neck = "Rep. Plat. Medal",
        ear1 = "Moonshade Earring",
        ear2 = "Thrud Earring",
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
    sets.MaxTP = { ear1 = "Ishvara Earring" }
    sets.AccMaxTP = { ear1 = "Cessance Earring" }
    sets.weapons.Naegling = { main = "Naegling", sub = "Blurred Shield +1" }
    sets.DrainWeapon = {} -- No owned Drain weapon; preserve current melee weapons/TP.
    sets.AbsorbWeapon = {}
    sets.DreadWeapon = {}
    sets.passive.MP = { ear2 = "Ethereal Earring", waist = "Flume Belt +1" }

    sets.precast.FC = set_combine(sets.precast.FC, {
        head = { name = "Carmine Mask +1", augments = { 'Path:D' } },
        body = "Sworn Platemail",
        legs = "Sworn Brais",
        feet = "Sworn Sabatons",
        ear2 = "Malignance Earring",
        ring2 = "Kishar Ring"
    })
    sets.precast.FC.Impact = set_combine(sets.precast.FC, { head = empty, body = "Crepuscular Cloak" })
    sets.midcast.FastRecast = set_combine(sets.precast.FC, { ammo = "Staunch Tathlum +1" })
    sets.midcast['Dark Magic'] = {
        ammo = "Pemphredo Tathlum",
        head = "Flam. Zucchetto +2",
        neck = "Erra Pendant",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Malignance Earring",
        body = "Flamma Korazin +2",
        hands = "Flam. Manopolas +2",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Flamma Dirs +2",
        feet = "Flam. Gambieras +2"
    }
    sets.midcast['Dark Magic'].Resistant = set_combine(sets.midcast['Dark Magic'], { neck = "Null Loop" })
    sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
        ring2 = "Kishar Ring",
        back = gear.jse_back ~= '' and gear.jse_back or nil
    })
    sets.midcast.Absorb.Resistant = set_combine(sets.midcast.Absorb, { neck = "Null Loop" })
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], { ring1 = "Evanescence Ring", ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" } })
    sets.midcast.Drain.Resistant = set_combine(sets.midcast.Drain, { neck = "Null Loop" })
    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Dark Magic'], { neck = "Null Loop", ring2 = "Kishar Ring" })
    sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" }
    })
    sets.midcast['Elemental Magic'] = set_combine(sets.precast.WS, {
        ammo = "Pemphredo Tathlum",
        neck = "Sibyl Scarf",
        ear1 = "Friomisi Earring",
        ear2 = "Malignance Earring",
        ring1 = "Shiva Ring +1",
        ring2 = "Metamor. Ring +1",
        waist = "Orpheus's Sash"
    })
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        neck = "Null Loop",
        waist = "Null Belt",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" }
    })
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        head = { name = "Carmine Mask +1", augments = { 'Path:D' } },
        body = "Sworn Platemail",
        legs = "Sworn Brais",
        feet = "Sworn Sabatons",
        ear1 = "Alabaster Earring",
        waist = "Sailfi Belt +1"
    })
    sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'], { head = empty, body = "Crepuscular Cloak" })
    -- Dread Spikes scales with max HP, not magic attack bonus.
    sets.midcast['Dread Spikes'] = set_combine(sets.idle.PDT, {
        head = "Sworn Crown",
        body = "Adamantite Armor",
        hands = "Sakpata's Gauntlets",
        legs = "Sworn Brais",
        feet = "Sworn Sabatons",
        neck = "Null Loop",
        ear2 = "Tuisto Earring",
        ring1 = { name = "Moonlight Ring", bag = "Wardrobe" },
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        waist = "Plat. Mog. Belt"
    })
    -- Heathen's Cuirass is missing; this overlay activates only after the alias is filled.
    sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dread Spikes'], { body = gear.af3_body ~= '' and gear.af3_body or nil })
    sets.midcast.Cure.feet = { name = "Odyssean Greaves", augments = { 'MND+8', 'Mag. Acc.+6', '"Cure" potency +5%' } }
    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
    sets.Self_Healing = { body = "Sakpata's Plate", legs = "Flamma Dirs +2", waist = "Gishdubar Sash" }
    sets.Cure_Received = set_combine(sets.Self_Healing, {})
    sets.idle.Refresh = set_combine(sets.idle.Refresh, { head = "Befouled Crown" })

    -- 50% DT and capped equipment haste without assuming any Odyssey augments.
    sets.engaged = {
        ammo = "Coiste Bodhar",
        head = "Sakpata's Helm",
        neck = "Null Loop",
        ear1 = "Alabaster Earring",
        ear2 = "Telos Earring",
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        ring1 = "Niqmaddu Ring",
        ring2 = "Chirich Ring +1",
        back = "Null Shawl",
        waist = "Ioskeha Belt +1",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings"
    }
    sets.engaged.SomeAcc = set_combine(sets.engaged, { ring2 = "Ephramad's Ring" })
    sets.engaged.Acc = set_combine(sets.engaged.SomeAcc, {})
    sets.engaged.FullAcc = set_combine(sets.engaged.Acc, { ammo = "Aurgelmir Orb +1" })
    sets.engaged.Fodder = set_combine(sets.engaged, {
        head = "Flam. Zucchetto +2",
        feet = "Flam. Gambieras +2",
        ear1 = "Brutal Earring",
        ring2 = "Ephramad's Ring"
    })

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, { ring2 = "Niqmaddu Ring" })
    sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
        head = "Flam. Zucchetto +2",
        neck = "Fotia Gorget",
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        ear2 = "Brutal Earring",
        ring1 = "Niqmaddu Ring",
        legs = "Flamma Dirs +2",
        feet = "Flam. Gambieras +2",
        waist = "Fotia Belt"
    })
    sets.precast.WS['Entropy'] = set_combine(sets.precast.WS['Resolution'], { ring2 = "Metamor. Ring +1" })
    -- Scythe / great sword sets remain ready for an owned weapon to be added later.
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
        ammo = "Pemphredo Tathlum",
        head = "Pixie Hairpin +1",
        neck = "Sibyl Scarf",
        ear1 = "Friomisi Earring",
        ear2 = "Malignance Earring",
        ring1 = "Archon Ring",
        ring2 = "Shiva Ring +1",
        waist = "Orpheus's Sash"
    })
    sets.precast.WS['Infernal Scythe'] = set_combine(sets.precast.WS['Sanguine Blade'], {})

    sets.MaxTP['Sanguine Blade'] = {}
    sets.AccMaxTP['Sanguine Blade'] = {}
    sets.MaxTP['Infernal Scythe'] = {}
    sets.AccMaxTP['Infernal Scythe'] = {}

    sets.precast.JA['Diabolic Eye'] = { legs = gear.af2_legs }
    sets.precast.JA['Arcane Circle'] = { feet = gear.af1_feet }
    sets.precast.JA.Souleater = { head = gear.af1_head }
    sets.precast.JA['Weapon Bash'] = { hands = gear.af2_hands }
    sets.precast.JA['Nether Void'] = { legs = gear.af3_legs }
    sets.precast.JA['Blood Weapon'] = { body = gear.af2_body }
    sets.precast.JA['Dark Seal'] = { head = gear.af2_head }
    sets.precast.JA['Last Resort'] = { back = gear.jse_back }
    sets.buff['Dark Seal'] = { head = gear.af2_head }
    sets.buff['Nether Void'] = { legs = gear.af3_legs }
    sets.buff.Souleater = { head = gear.af1_head }
    sets.precast.Step = set_combine(sets.engaged.Acc, {})
    sets.precast.Flourish1 = set_combine(sets.engaged.Acc, {})
    -- Match each offense mode to a complete defensive overlay.
    for _, mode in ipairs({ 'Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder' }) do
        local melee = mode == 'Normal' and sets.engaged or sets.engaged[mode]
        melee.PDT = set_combine(melee, {
            head = "Sakpata's Helm",
            body = "Sakpata's Plate",
            hands = "Sakpata's Gauntlets",
            legs = "Sakpata's Cuisses",
            feet = "Sakpata's Leggings",
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
    for _, name in ipairs({ 'Sanguine Blade', 'Infernal Scythe' }) do
        sets.precast.WS[name].FullAcc = set_combine(sets.precast.WS[name].Acc, { ear2 = "Malignance Earring" })
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(2, 15)
	elseif player.sub_job == 'SAM' then
		set_macro_page(3, 15)
	elseif player.sub_job == 'DNC' then
		set_macro_page(4, 15)
	elseif player.sub_job == 'THF' then
		set_macro_page(1, 15)
	else
		set_macro_page(5, 15)
	end
end
