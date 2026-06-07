function character_user_job_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'PDT')
    state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
    state.MagicalDefenseMode:options('MDT', 'NukeLock')
    state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('None', 'Maxentius', 'DualWeapons')

    default_weapons = 'Maxentius'

    autows_list = {
        Maxentius = 'Black Halo',
        DualWeapons = 'Black Halo',
    }

    -- GEO gear starts from owned non-GEO pieces evidenced in other active Kalali gear files,
    -- plus verified GEO pieces listed here.
    gear.geo_range = "Dunna"
    gear.geo_neck = "Bagua Charm +2"
    gear.geo_back = "Lifestream Cape"
    gear.af1_head = ""
    gear.af1_body = "Geomancy Tunic +2"
    gear.af1_hands = "Geo. Mitaines +2"
    gear.af1_legs = ""
    gear.af1_feet = ""

    gear.nuke_jse_back = "Null Shawl"
    gear.idle_jse_back = gear.geo_back
    gear.perimede_cape = gear.geo_back
    gear.stikini_ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" }
    gear.stikini_ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" }

    gear.obi_cure_back = "Null Shawl"
    gear.obi_cure_waist = "Witful Belt"

    gear.obi_low_nuke_back = gear.nuke_jse_back
    gear.obi_low_nuke_waist = "Null Belt"

    gear.obi_high_nuke_back = gear.nuke_jse_back
    gear.obi_high_nuke_waist = "Acuity Belt +1"
    gear.ElementalObi = "Hachirin-no-Obi"

    gear.grioavolr_fc_staff = "Mpaca's Staff"
    gear.grioavolr_nuke_staff = "Bunzi's Rod"
    gear.gada_healing_club = "Daybreak"
    gear.gada_enhancing_club = "Bunzi's Rod"

    gear.merlinic_nuke_head = "Amalric Coif +1"
    gear.merlinic_nuke_body = "Nyame Mail"
    gear.merlinic_aspir_feet = "Amalric Nails +1"
    gear.merlinic_refresh_hands = "Nyame Gauntlets"
    gear.merlinic_refresh_feet = "Nyame Sollerets"
    gear.chironic_refresh_hands = "Nyame Gauntlets"
    gear.chironic_refresh_feet = "Nyame Sollerets"
    gear.merlinic_treasure_feet = {}

    autoindi = "Frailty"
    autogeo = "Fury"

    -- Additional local binds
    send_command('bind ^` gs c cycle ElementalMode')
    send_command('bind !` input /ja "Full Circle" <me>')
    send_command('bind @f8 gs c toggle AutoNukeMode')
    send_command('bind @` gs c cycle MagicBurstMode')
    send_command('bind @f10 gs c cycle RecoverMode')
    send_command('bind ^backspace input /ja "Entrust" <me>')
    send_command('bind !backspace input /ja "Life Cycle" <me>')
    send_command('bind @backspace input /ma "Sleep II" <t>')
    send_command('bind ^delete input /ma "Aspir III" <t>')
    send_command('bind @delete input /ma "Sleep" <t>')

    indi_duration = 290

    select_default_macro_book()
end

function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {}
    sets.precast.JA['Life Cycle'] = { body = gear.af1_body, back = gear.geo_back }
    sets.precast.JA['Radial Arcana'] = {}
    sets.precast.JA['Mending Halation'] = {}
    sets.precast.JA['Full Circle'] = { head = gear.af1_head, hands = gear.af1_hands }

    -- Indi Duration in slots that would normally have skill here to make entrust more efficient.
    sets.buff.Entrust = {}

    -- Relic hat for Blaze of Glory HP increase.
    sets.buff['Blaze of Glory'] = {}

    -- Fast cast sets for spells

    sets.precast.FC = {
        main = gear.grioavolr_fc_staff,
        sub = "Khonsu",
        ammo = "Impatiens",
        head = "Bunzi's Hat",
        neck = "Voltsurge Torque",
        ear1 = "Etiolation Earring",
        ear2 = "Malignance Earring",
        body = "Inyanga Jubbah +2",
        hands = "Regal Cuffs",
        ring1 = "Kishar Ring",
        ring2 = "Lebeche Ring",
        back = gear.perimede_cape,
        waist = "Witful Belt",
        legs = "Kaykaus Tights +1",
        feet = "Kaykaus Boots +1"
    }

    sets.precast.FC.Geomancy = set_combine(sets.precast.FC, { range = gear.geo_range, ammo = empty })
    sets.precast.FC.Indi = sets.precast.FC.Geomancy

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC,
        { ear2 = "Malignance Earring" })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Ammurapi Shield" })

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.Self_Healing = { waist = "Gishdubar Sash" }
    sets.Cure_Received = { waist = "Gishdubar Sash" }
    sets.Self_Refresh = { waist = "Gishdubar Sash" }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC.Impact = {
        ammo = "Impatiens",
        head = empty,
        neck = "Voltsurge Torque",
        ear1 = "Etiolation Earring",
        ear2 = "Malignance Earring",
        body = "Crepuscular Cloak",
        hands = "Regal Cuffs",
        ring1 = "Kishar Ring",
        ring2 = "Lebeche Ring",
        back = gear.perimede_cape,
        waist = "Witful Belt",
        legs = "Kaykaus Tights +1",
        feet = "Kaykaus Boots +1"
    }

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Ammurapi Shield" })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = "Oshasha's Treatise",
        head = "Nyame Helm",
        neck = "Null Loop",
        ear1 = "Sherida Earring",
        ear2 = "Moonshade Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Epaminondas's Ring",
        ring2 = "Cornelia's Ring",
        back = "Null Shawl",
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.WS.Proc = {
        ammo = "Staunch Tathlum +1",
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Flash Nova'] = {
        ammo = "Ghastly Tathlum +1",
        head = "Pixie Hairpin +1",
        neck = "Sibyl Scarf",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        body = "Nyame Mail",
        hands = "Jhakri Cuffs +2",
        ring1 = "Epaminondas's Ring",
        ring2 = "Metamor. Ring +1",
        back = gear.nuke_jse_back,
        waist = "Orpheus's Sash",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        main = gear.grioavolr_fc_staff,
        sub = "Khonsu",
        head = "Amalric Coif +1",
        neck = "Voltsurge Torque",
        ear1 = "Etiolation Earring",
        ear2 = "Malignance Earring",
        body = "Inyanga Jubbah +2",
        hands = "Regal Cuffs",
        ring1 = "Kishar Ring",
        ring2 = "Prolix Ring",
        back = gear.perimede_cape,
        waist = "Witful Belt",
        legs = "Kaykaus Tights +1",
        feet = "Kaykaus Boots +1"
    }

    sets.midcast.Geomancy = {
        main = "Maxentius",
        sub = "Ammurapi Shield",
        range = gear.geo_range,
        head = gear.af1_head,
        neck = gear.geo_neck,
        ear1 = "Etiolation Earring",
        ear2 = "Malignance Earring",
        body = gear.af1_body,
        hands = gear.af1_hands,
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.geo_back,
        waist = "Null Belt",
        legs = gear.af1_legs,
        feet = gear.af1_feet
    }


    --Extra Indi duration as long as you can keep your 900 skill cap.
    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, { back = gear.geo_back })

    sets.midcast.Cure = {
        main = gear.gada_healing_club,
        sub = "Ammurapi Shield",
        ammo = "Staunch Tathlum +1",
        head = "Amalric Coif +1",
        neck = "Hoxne Torque",
        ear1 = "Etiolation Earring",
        ear2 = "Mendi. Earring",
        body = "Vrikodara Jupon",
        hands = "Regal Cuffs",
        ring1 = "Naji's Loop",
        ring2 = "Menelaus's Ring",
        back = gear.obi_cure_back,
        waist = "Witful Belt",
        legs = "Kaykaus Tights +1",
        feet = "Kaykaus Boots +1"
    }

    sets.midcast.LightWeatherCure = {
        main = "Chatoyant Staff",
        sub = "Khonsu",
        ammo = "Staunch Tathlum +1",
        head = "Amalric Coif +1",
        neck = "Hoxne Torque",
        ear1 = "Etiolation Earring",
        ear2 = "Mendi. Earring",
        body = "Vrikodara Jupon",
        hands = "Regal Cuffs",
        ring1 = "Naji's Loop",
        ring2 = "Menelaus's Ring",
        back = gear.obi_cure_back,
        waist = "Hachirin-no-Obi",
        legs = "Kaykaus Tights +1",
        feet = "Kaykaus Boots +1"
    }

    --Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {
        main = gear.gada_healing_club,
        sub = "Ammurapi Shield",
        ammo = "Staunch Tathlum +1",
        head = "Amalric Coif +1",
        neck = "Hoxne Torque",
        ear1 = "Etiolation Earring",
        ear2 = "Mendi. Earring",
        body = "Vrikodara Jupon",
        hands = "Regal Cuffs",
        ring1 = "Naji's Loop",
        ring2 = "Lebeche Ring",
        back = gear.obi_cure_back,
        waist = "Hachirin-no-Obi",
        legs = "Kaykaus Tights +1",
        feet = "Kaykaus Boots +1"
    }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, { main = "Daybreak", sub = "Ammurapi Shield" })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        neck = "Hoxne Torque",
        hands = "Regal Cuffs",
        back = gear.obi_cure_back,
        ring1 = "Naji's Loop",
        ring2 = "Menelaus's Ring",
        waist = "Witful Belt",
        feet = "Kaykaus Boots +1"
    })

    sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {
        main = gear.grioavolr_fc_staff,
        sub =
        "Khonsu"
    })

    sets.midcast['Elemental Magic'] = {
        main = gear.grioavolr_nuke_staff,
        sub = "Ammurapi Shield",
        ammo = "Ghastly Tathlum +1",
        head = gear.merlinic_nuke_head,
        neck = "Sibyl Scarf",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        body = gear.merlinic_nuke_body,
        hands = "Jhakri Cuffs +2",
        ring1 = "Freke Ring",
        ring2 = "Metamor. Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Nyame Flanchard",
        feet = "Amalric Nails +1"
    }

    sets.midcast['Elemental Magic'].Resistant = {
        main = gear.grioavolr_nuke_staff,
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.merlinic_nuke_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        body = gear.merlinic_nuke_body,
        hands = "Jhakri Cuffs +2",
        ring1 = gear.stikini_ring1,
        ring2 = "Metamor. Ring +1",
        back = gear.nuke_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Amalric Nails +1"
    }

    sets.midcast['Elemental Magic'].Proc = {
        main = empty,
        sub = empty,
        ammo = "Impatiens",
        head = "Amalric Coif +1",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Loquac. Earring",
        body = "Inyanga Jubbah +2",
        hands = "Regal Cuffs",
        ring1 = "Kishar Ring",
        ring2 = "Prolix Ring",
        back = "Null Shawl",
        waist = "Witful Belt",
        legs = "Nyame Flanchard",
        feet = "Kaykaus Boots +1"
    }

    sets.midcast['Elemental Magic'].Fodder = {
        main = gear.grioavolr_nuke_staff,
        sub = "Ammurapi Shield",
        ammo = "Ghastly Tathlum +1",
        head = gear.merlinic_nuke_head,
        neck = "Sibyl Scarf",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        body = gear.merlinic_nuke_body,
        hands = "Jhakri Cuffs +2",
        ring1 = "Freke Ring",
        ring2 = "Metamor. Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Nyame Flanchard",
        feet = "Amalric Nails +1"
    }

    sets.midcast['Elemental Magic'].HighTierNuke = {
        main = gear.grioavolr_nuke_staff,
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.merlinic_nuke_head,
        neck = "Sibyl Scarf",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        body = gear.merlinic_nuke_body,
        hands = "Jhakri Cuffs +2",
        ring1 = "Metamor. Ring +1",
        ring2 = "Freke Ring",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Nyame Flanchard",
        feet = "Amalric Nails +1"
    }

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {
        main = gear.grioavolr_nuke_staff,
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.merlinic_nuke_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        body = gear.merlinic_nuke_body,
        hands = "Jhakri Cuffs +2",
        ring1 = "Metamor. Ring +1",
        ring2 = "Freke Ring",
        back = gear.nuke_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Amalric Nails +1"
    }

    sets.midcast['Elemental Magic'].HighTierNuke.Fodder = {
        main = gear.grioavolr_nuke_staff,
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.merlinic_nuke_head,
        neck = "Sibyl Scarf",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        body = gear.merlinic_nuke_body,
        hands = "Jhakri Cuffs +2",
        ring1 = "Metamor. Ring +1",
        ring2 = "Freke Ring",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Nyame Flanchard",
        feet = "Amalric Nails +1"
    }

    sets.midcast['Dark Magic'] = {
        main = gear.grioavolr_nuke_staff,
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.merlinic_nuke_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        body = gear.merlinic_nuke_body,
        hands = "Jhakri Cuffs +2",
        ring1 = "Metamor. Ring +1",
        ring2 = gear.stikini_ring2,
        back = gear.nuke_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = gear.merlinic_aspir_feet
    }

    sets.midcast.Drain = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Pixie Hairpin +1",
        neck = "Erra Pendant",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        body = gear.merlinic_nuke_body,
        hands = "Jhakri Cuffs +2",
        ring1 = "Metamor. Ring +1",
        ring2 = "Evanescence Ring",
        back = gear.nuke_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = gear.merlinic_aspir_feet
    }

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {
        main = gear.grioavolr_fc_staff,
        sub = "Khonsu",
        ammo = "Pemphredo Tathlum",
        head = "Amalric Coif +1",
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = "Loquac. Earring",
        body = "Inyanga Jubbah +2",
        hands = "Regal Cuffs",
        ring1 = "Metamor. Ring +1",
        ring2 = gear.stikini_ring2,
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Kaykaus Boots +1"
    }

    sets.midcast.Stun.Resistant = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Amalric Coif +1",
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = "Loquac. Earring",
        body = gear.merlinic_nuke_body,
        hands = "Jhakri Cuffs +2",
        ring1 = "Metamor. Ring +1",
        ring2 = gear.stikini_ring2,
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Nyame Flanchard",
        feet = gear.merlinic_aspir_feet
    }

    sets.midcast.Impact = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = empty,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = "Loquac. Earring",
        body = "Crepuscular Cloak",
        hands = "Regal Cuffs",
        ring1 = "Metamor. Ring +1",
        ring2 = gear.stikini_ring2,
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Nyame Flanchard",
        feet = "Amalric Nails +1"
    }

    sets.midcast.Dispel = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Amalric Coif +1",
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = "Loquac. Earring",
        body = gear.merlinic_nuke_body,
        hands = "Jhakri Cuffs +2",
        ring1 = "Metamor. Ring +1",
        ring2 = gear.stikini_ring2,
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Nyame Flanchard",
        feet = gear.merlinic_aspir_feet
    }

    sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, { main = "Daybreak", sub = "Ammurapi Shield" })

    sets.midcast['Enfeebling Magic'] = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Amalric Coif +1",
        neck = "Null Loop",
        ear1 = "Etiolation Earring",
        ear2 = "Malignance Earring",
        body = gear.merlinic_nuke_body,
        hands = "Regal Cuffs",
        ring1 = "Kishar Ring",
        ring2 = gear.stikini_ring2,
        back = gear.nuke_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Amalric Nails +1"
    }

    sets.midcast['Enfeebling Magic'].Resistant = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Amalric Coif +1",
        neck = "Null Loop",
        ear1 = "Etiolation Earring",
        ear2 = "Malignance Earring",
        body = gear.merlinic_nuke_body,
        hands = "Regal Cuffs",
        ring1 = "Metamor. Ring +1",
        ring2 = gear.stikini_ring2,
        back = gear.nuke_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Amalric Nails +1"
    }

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'],
        { head = "Amalric Coif +1", ear2 = "Malignance Earring", waist = "Acuity Belt +1" })
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,
        { head = "Amalric Coif +1", ear2 = "Malignance Earring", waist = "Acuity Belt +1" })

    sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], { ring1 = gear.stikini_ring1 })

    sets.midcast['Enhancing Magic'] = {
        main = gear.gada_enhancing_club,
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Amalric Coif +1",
        neck = "Hoxne Torque",
        ear1 = "Malignance Earring",
        ear2 = "Mimir Earring",
        body = "Inyanga Jubbah +2",
        hands = "Regal Cuffs",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.perimede_cape,
        waist = "Embla Sash",
        legs = "Shedir Seraweels",
        feet = "Kaykaus Boots +1"
    }
    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],
        { legs = "Shedir Seraweels" })

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], { head = "Amalric Coif +1" })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
        { head = "Amalric Coif +1", hands = "Regal Cuffs", waist = "Emphatikos Rope", legs = "Shedir Seraweels" })

    sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], { legs = "Shedir Seraweels" })

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'],
        { ring2 = "Sheltered Ring" })
    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'],
        { ring2 = "Sheltered Ring" })
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'],
        { ring2 = "Sheltered Ring" })
    sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'],
        { ring2 = "Sheltered Ring" })

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {
        main = "Chatoyant Staff",
        sub = "Khonsu",
        head = "Amalric Coif +1",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Inyanga Jubbah +2",
        hands = gear.merlinic_refresh_hands,
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.idle_jse_back,
        legs = "Nyame Flanchard",
        feet = gear.merlinic_refresh_feet
    }

    -- Idle sets

    sets.idle = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Inyanga Jubbah +2",
        hands = gear.chironic_refresh_hands,
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.idle_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = gear.chironic_refresh_feet
    }

    sets.idle.PDT = {
        main = "Mpaca's Staff",
        sub = "Khonsu",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.idle_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {
        main = "Mpaca's Staff",
        sub = "Khonsu",
        range = gear.geo_range,
        head = gear.af1_head,
        neck = gear.geo_neck,
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Nyame Mail",
        hands = gear.af1_hands,
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.geo_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.idle.PDT.Pet = {
        main = "Mpaca's Staff",
        sub = "Khonsu",
        range = gear.geo_range,
        head = gear.af1_head,
        neck = gear.geo_neck,
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Nyame Mail",
        hands = gear.af1_hands,
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.geo_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})

    sets.idle.Weak = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Nyame Mail",
        hands = gear.merlinic_refresh_hands,
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.idle_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    -- Defense sets

    sets.defense.PDT = {
        main = "Mpaca's Staff",
        sub = "Khonsu",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.idle_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.MDT = {
        main = "Mpaca's Staff",
        sub = "Khonsu",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.idle_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.MEVA = {
        main = "Mpaca's Staff",
        sub = "Khonsu",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = gear.merlinic_nuke_body,
        hands = "Nyame Gauntlets",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.idle_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.PetPDT = sets.idle.PDT.Pet

    sets.defense.NukeLock = sets.midcast['Elemental Magic']

    sets.defense.GeoLock = sets.midcast.Geomancy.Indi

    sets.Kiting = {}
    sets.latent_refresh = { waist = "Null Belt" }
    sets.latent_refresh_grip = { sub = "Khonsu" }
    sets.TPEat = { neck = "Null Loop" }
    sets.DayIdle = {}
    sets.NightIdle = {}
    sets.TreasureHunter = set_combine(sets.TreasureHunter, { feet = gear.merlinic_treasure_feet })

    sets.HPDown = {
        head = "Pixie Hairpin +1",
        ear1 = "Etiolation Earring",
        ear2 = "Evans Earring",
        body = "Inyanga Jubbah +2",
        hands = "Jhakri Cuffs +2",
        ring1 = "Metamor. Ring +1",
        ring2 = "Freke Ring",
        back = "Null Shawl",
        legs = "Shedir Seraweels",
        feet = "Nyame Sollerets"
    }

    sets.buff.Doom = set_combine(sets.buff.Doom, {})

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        ammo = "Crepuscular Pebble",
        head = "Nyame Helm",
        neck = "Null Loop",
        ear1 = "Sherida Earring",
        ear2 = "Brutal Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Epaminondas's Ring",
        ring2 = "Cornelia's Ring",
        back = "Null Shawl",
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.engaged.DW = {
        ammo = "Crepuscular Pebble",
        head = "Nyame Helm",
        neck = "Null Loop",
        ear1 = "Sherida Earring",
        ear2 = "Brutal Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Epaminondas's Ring",
        ring2 = "Cornelia's Ring",
        back = "Null Shawl",
        waist = "Reiki Yotai",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    -- Gear that converts elemental damage done to recover MP.
    sets.RecoverMP = {}

    -- Gear for Magic Burst mode.
    sets.MagicBurst = {
        main = gear.grioavolr_nuke_staff,
        sub = "Ammurapi Shield",
        neck =
        "Mizu. Kubikazari",
        ring1 = "Mujin Band"
    }
    sets.ResistantMagicBurst = {
        main = gear.grioavolr_nuke_staff,
        sub = "Ammurapi Shield",
        neck =
        "Mizu. Kubikazari",
        ring1 = "Mujin Band"
    }

    sets.buff.Sublimation = { waist = "Embla Sash" }
    sets.buff.DTSublimation = { waist = "Embla Sash" }

    -- Weapons sets
    sets.weapons.None = { range = gear.geo_range, ammo = empty }
    sets.weapons.Maxentius = { main = 'Maxentius', sub = 'Ammurapi Shield', range = gear.geo_range, ammo = empty }
    sets.weapons.DualWeapons = { main = 'Maxentius', sub = 'Daybreak', range = gear.geo_range, ammo = empty }
end

function extra_user_customize_idle_set(idleSet)
    if pet.isvalid then
        idleSet = set_combine(idleSet, { range = gear.geo_range, ammo = empty })
    end

    return idleSet
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(4, 10)
end
