function character_user_job_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant', 'AoE')
    state.IdleMode:options('Normal', 'NoRefresh', 'DT')
    state.Weapons:options('None', 'Naegling', 'Aeneas', 'DualWeapons', 'DualNaegling', 'DualTauret', 'DualAeolian')

    gear.melee_str_wsd_back = { name = "Intarabus's Cape", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%', } }
    gear.melee_chr_wsd_back = gear.melee_str_wsd_back
    gear.melee_dex_wsd_back = gear.melee_str_wsd_back
    gear.melee_int_wsd_back = gear.melee_str_wsd_back
    gear.magic_jse_back = { name = "Intarabus's Cape", augments = { 'Mag. Acc+8/Mag. Dmg.+8', '"Fast Cast"+10', } }
    --gear.magic_jse_back = { name = "Intarabus's Cape", augments = { 'CHR+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'Mag. Acc.+10', '"Fast Cast"+10', 'Damage taken-5%', } }

    gear.linos_str_wsd = { name = "Linos", augments = { 'STR+8', 'Attack+15', 'Weapon skill damage +2%' } } -- Savage Blade
    gear.linos_chr_wsd = { name = "Linos", augments = { 'CHR+8', 'Attack+20', 'Weapon skill damage +3%' } } -- Mordant Rime
    gear.linos_dex_wsd = gear
    .linos_chr_wsd                                                                                          -- Rudra's Storm
    gear.linos_int_wsd = gear
    .linos_chr_wsd                                                                                          -- Aeolian Edge
    gear.linos_fc = gear.linos_chr_wsd
    gear.linos_tp = { name = "Linos", augments = { 'Accuracy+19', '"Store TP"+4', 'Quadrule Attack +3%' } }
    -- JSE Weapon/Neck/Earring
    gear.jse_ear2 = "Fili Earring +1"
    gear.jse_neck = "Bard's Charm +2"

    -- Artifact Gear
    gear.af1_head = {}  --"Brioso Roundlet"
    gear.af1_body = {}  --"Brioso Just. +3"
    gear.af1_hands = {} --"Brioso Cuffs"
    gear.af1_legs = {}  --"Brioso Cannions"
    gear.af1_feet = {}  -- "Brioso Slippers +3"

    -- Relic Gear
    gear.af2_head = {}
    gear.af2_body = "Bihu Jstcrps. +3"
    gear.af2_hands = {}
    gear.af2_legs = {}
    gear.af2_feet = {} --"Bihu Slippers +3"

    -- Empy Gear
    gear.af3_head = "Fili Calot +1"
    gear.af3_body = "Fili Hongreline +2"
    gear.af3_hands = "Fili Manchettes +2"
    gear.af3_legs = "Fili Rhingrave +1"
    gear.af3_feet = "Fili Cothurnes +1"

    -- List of gear I want, could be BiS. When I get the item, can replace it here
    -- Actually important
    gear.aeneas = "Naegling"
    gear.genmei_shield = "Ammurapi Shield"
    gear.linos_fc = "Daurdabla"
    gear.gletis_knife = "Blurred Knife +1"
    gear.loricate_torque = "Null Loop"
    --  7  Loricate Torque +1            -6 DT, SIRD 5%
    gear.kishar_ring = "Stikini Ring +1"
    --  6  Kishar Ring                   FC +4% Enfeebling Duration +10%
    gear.witful_belt = "Null Belt"
    --  3  Witful Belt                   FC +3%, Haste +3%
    gear.mpacas_staff = "Kali" -- "Mpaca's Staff"
    --  1  Mpaca's Staff                 Idle Set, +2 Refresh
    --
    --       easy enough to get, 2 MP refresh worth
    gear.umbra_strap = "Ammurapi Shield" -- "Umbra Strap"
    gear.impatiens = "Staunch Tathlum +1"
    --  3  Impatiens                     SIRD 10%, QC 2%
    gear.baetyl_pendant = gear.jse_neck
    --  3  Baetyl Pendant                FC +4%, MAB +13
    gear.acuity_belt = "Eschan Stone"
    --  3  Acuity Belt +1                +16 INT, +15 Macc
    gear.debilis_medallion = gear.jse_neck
    --  1  Debilis Medallion             Cursna Set
    gear.prolix_ring = "Stikini Ring +1"
    --  1  Prolix Ring                   FC +2%
    gear.sanare_earring = "Eabani Earring"
    --  5  Sanare Earring                MDB+4, MEva+6
    gear.hieros_mittens = "Inyan. Dastanas +2"
    --  1  Hieros Mittens                Cursna Set
    gear.shadow_ring = ""
    --  7  Shadow Ring                   Death protection, MDB
    gear.haomas_ring = "Stikini Ring +1"
    --  1  Haoma's Ring                  +15% Cursna Success
    gear.shadow_mantle = "Null Shawl"
    --  2  Shadow Mantle                 Phys Annul
    gear.engulfer_cape = "Null Shawl"
    --  2  Engulfer Cape +1              -4% MDT, Magic Absorb
    gear.oretan_cape = "Null Shawl"
    --  1  Oretan. Cape +1               +5 Cursna]
    gear.luminary_sash = "Embla Sash"
    --  1  Luminary Sash                 Conserve MP / MND
    gear.fuchonoobi = "Eschan Stone"
    --  2  Fucho-no-obi                  +8 Drain/Aspirt Potency
    gear.voltsurge_torque = "Null Loop"   -- Acc, DEX
    gear.kentarch_belt = "Sailfi Belt +1" -- DEX
    gear.regal_earring = "Telos Earring"  -- Macc, Acc, CHR



    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2

    -- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')

    -- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
    send_command('bind !` input /ma "Chocobo Mazurka" <me>')
    send_command('bind @` gs c cycle MagicBurstMode')
    send_command('bind @f10 gs c cycle RecoverMode')
    send_command('bind @f8 gs c toggle AutoNukeMode')
    send_command('bind !f7 gs c cycle CarnMode')

    select_default_macro_book()
end

function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Weapons sets
    --sets.weapons.Aeneas = { main = "Aeneas", sub = gear.genmei_shield }
    --sets.weapons.DualWeapons = { main = "Aeneas", sub = "Blurred Knife +1" }
    sets.weapons.DualNaegling = { main = "Naegling", sub = "Blurred Knife +1" }
    sets.weapons.Naegling = { main = "Naegling", sub = gear.genmei_shield }
    --sets.weapons.DualTauret = { main = "Tauret", sub = "Blurred Knife +1" }
    --sets.weapons.DualAeolian = { main = "Tauret", sub = "Malevolence" }

    sets.buff.Sublimation = { waist = "Embla Sash" }
    sets.buff.DTSublimation = { waist = "Embla Sash" }
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
        main = "Kali",
        sub = "Ammurapi Shield",
        ammo = gear.impatiens,
        head = "Bunzi's Hat",
        neck = gear.voltesurge_torque,
        ear1 = "Etiolation Earring",
        ear2 = "Loquac. Earring",
        body = "Inyanga Jubbah +2",
        hands = gear.af3_hands,
        ring1 = gear.kishar_ring,
        ring2 = "Lebeche Ring",
        back = gear.magic_jse_back,
        waist = gear.witful_belt,
        legs = "Aya. Cosciales +2",
        feet = gear.af2_feet
    }

    sets.precast.FC.DT = {
        main = "Kali",
        sub = gear.genmei_shield,
        ammo = gear.impatiens,
        head = "Bunzi's Hat",
        neck = gear.voltesurge_torque,
        ear1 = "Etiolation Earring",
        ear2 = "Loquac. Earring",
        body = "Inyanga Jubbah +2",
        hands = gear.af3_hands,
        ring1 = gear.kishar_ring,
        ring2 = "Lebeche Ring",
        back = gear.magic_jse_back,
        waist = gear.witful_belt,
        legs = "Aya. Cosciales +2",
        feet = gear.af2_feet
    }

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        feet = "Kaykaus Boots +1"
    })

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
        main = "Daybreak",
        sub = gear.genmei_shield,
    })

    sets.precast.FC.BardSong = {
        main = "Kali",
        sub = gear.genmei_shield,
        range = gear.linos_fc,
        ammo = empty,
        head = gear.af3_head,
        neck = gear.loricate_torque,
        ear1 = "Loquac. Earring",
        ear2 = gear.jse_ear2,
        body = "Inyanga Jubbah +2",
        hands = gear.af3_hands,
        ring1 = gear.kishar_ring,
        ring2 = "Lebeche Ring",
        back = gear.magic_jse_back,
        waist = gear.witful_belt,
        legs = "Kaykaus Tights +1",
        feet = gear.af3_feet
    }

    sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong, { range = "Marsyas" })
    sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong, { range = "Daurdabla" })
    sets.precast.FC.Lullaby = { range = "Marsyas" }
    sets.precast.FC.Lullaby.Resistant = { range = "Daurdabla" }
    sets.precast.FC['Horde Lullaby'] = { range = "Marsyas" }
    sets.precast.FC['Horde Lullaby'].Resistant = { range = "Daurdabla" }
    sets.precast.FC['Horde Lullaby'].AoE = { range = "Daurdabla" }
    sets.precast.FC['Horde Lullaby II'] = { range = "Marsyas" }
    sets.precast.FC['Horde Lullaby II'].Resistant = { range = "Daurdabla" }
    sets.precast.FC['Horde Lullaby II'].AoE = { range = "Daurdabla" }

    sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong, { range = "Marsyas" })
    sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong, { range = "Marsyas" })

    sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, { range = info.ExtraSongInstrument })
    sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla

    -- Precast sets to enhance JAs

    sets.precast.JA.Nightingale = { feet = gear.af2_feet }
    sets.precast.JA.Troubadour = { body = gear.af2_body }
    sets.precast.JA['Soul Voice'] = { --[[legs = gear.af2_legs]] }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        range = gear.linos_str_wsd,
        head = "Nyame Helm",
        neck = gear.jse_neck,
        ear1 = "Moonshade Earring",
        ear2 = "Ishvara Earring",
        body = gear.af2_body,
        hands = "Nyame Gauntlets",
        ring1 = "Epaminondas's Ring",
        ring2 = "Ilabrat Ring",
        back = gear.melee_str_wsd_back,
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.WS.Acc = {
        range = gear.linos_str_wsd,
        head = "Nyame Helm",
        neck = gear.jse_neck,
        ear1 = "Moonshade Earring",
        ear2 = "Ishvara Earring",
        body = gear.af2_body,
        hands = "Nyame Gauntlets",
        ring1 = "Epaminondas's Ring",
        ring2 = "Ilabrat Ring",
        back = gear.melee_str_wsd_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.WS['Savage Blade'] = {
        range = gear.linos_str_wsd,
        head = "Nyame Helm",
        neck = gear.jse_neck,
        ear1 = "Moonshade Earring",
        ear2 = "Ishvara Earring",
        body = gear.af2_body,
        hands = "Nyame Gauntlets",
        ring1 = "Epaminondas's Ring",
        ring2 = "Ilabrat Ring",
        back = gear.melee_str_wsd_back,
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.WS["Rudra's Storm"] = {
        range = gear.linos_dex_wsd,
        head = "Nyame Helm",
        neck = gear.jse_neck,
        ear1 = "Moonshade Earring",
        ear2 = "Ishvara Earring",
        body = gear.af2_body,
        hands = "Nyame Gauntlets",
        ring1 = "Epaminondas's Ring",
        ring2 = "Ilabrat Ring",
        back = gear.melee_str_wsd_back,
        waist = gear.kentarch_belt,
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.WS['Mordant Rime'] = {
        range = gear.linos_chr_wsd,
        head = "Nyame Helm",
        neck = gear.jse_neck,
        ear1 = gear.regal_earring,
        ear2 = "Ishvara Earring",
        body = gear.af2_body,
        hands = "Nyame Gauntlets",
        ring1 = "Epaminondas's Ring",
        ring2 = "Metamorph Ring +1",
        back = gear.melee_str_wsd_back,
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.WS['Aeolian Edge'] = {
        range = gear.linos_str_wsd,
        head = "Nyame Helm",
        neck = gear.baetyl_pendant,
        ear1 = "Moonshade Earring",
        ear2 = "Friomisi Earring",
        body = gear.af2_body,
        hands = "Nyame Gauntlets",
        ring1 = "Epaminondas's Ring",
        ring2 = "Shiva Ring +1",
        back = gear.melee_int_wsd_back,
        waist = "Orpheus's Sash",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }



    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = {
        ear1 = "Ishvara Earring",
        ear2 = "Telos Earring",
    }
    sets.AccMaxTP = {
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    -- Midcast Sets

    -- General set for recast times.
    sets.midcast.FastRecast = {
        main = "Kali",
        sub = "Ammurapi Shield",
        range = gear.linos_fc,
        head = "Bunzi's Hat",
        neck = gear.voltesurge_torque,
        ear1 = "Etiolation Earring",
        ear2 = "Loquac. Earring",
        body = "Inyanga Jubbah +2",
        hands = gear.af3_hands,
        ring1 = gear.kishar_ring,
        ring2 = "Lebeche Ring",
        back = gear.magic_jse_back,
        waist = gear.witful_belt,
        legs = "Aya. Cosciales +2",
        feet = gear.af2_feet
    }

    -- Gear to enhance certain classes of songs
    sets.midcast.Ballad = { legs = gear.af3_legs }
    sets.midcast.Lullaby = { range = "Marsyas" }
    sets.midcast.Lullaby.Resistant = { range = "Daurdabla" }
    sets.midcast['Horde Lullaby'] = { range = "Marsyas" }
    sets.midcast['Horde Lullaby'].Resistant = { range = "Daurdabla" }
    sets.midcast['Horde Lullaby'].AoE = { range = "Daurdabla" }
    sets.midcast['Horde Lullaby II'] = { range = "Marsyas" }
    sets.midcast['Horde Lullaby II'].Resistant = { range = "Daurdabla" }
    sets.midcast['Horde Lullaby II'].AoE = { range = "Daurdabla" }
    sets.midcast.Madrigal = { head = gear.af3_head }
    sets.midcast.Paeon = {}
    sets.midcast.March = { hands = gear.af3_hands, }
    sets.midcast['Honor March'] = set_combine(sets.midcast.March, { range = "Marsyas" })
    sets.midcast.Minuet = { body = gear.af3_body }
    sets.midcast.Minne = {}
    sets.midcast.Threnody = { --[[neck = "Elite Royal Collar"]] }
    sets.midcast.Carol = {}
    sets.midcast["Sentinel's Scherzo"] = { feet = "Fili Cothurnes +1" }
    sets.midcast['Magic Finale'] = { range = "Daurdabla" }
    sets.midcast.Mazurka = { range = "Marsyas" }

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {
        main = "Kali",
        sub = gear.genmei_shield,
        range = "Gjallarhorn",
        ammo = empty,
        head = gear.af3_head,
        neck = "Mnbw. Whistle +1",
        ear1 = "Etiolation Earring",
        ear2 = "Loquac. Earring",
        body = gear.af3_body,
        hands = "Inyan. Dastanas +2",
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.magic_jse_back,
        waist = "Embla Sash",
        legs = "Inyanga Shalwar +2",
        feet = gear.af1_feet
    }

    sets.midcast.SongEffect.DW = {
        main = "Kali",
        sub = "Kali",
    } --Only weapons in this set. This set is overlayed onto  SongEffect

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {
        main = "Kali",
        sub = "Ammurapi Shield",
        range = "Marsyas",
        ammo = empty,
        head = "Inyanga Tiara +2",
        neck = "Mnbw. Whistle +1",
        ear1 = gear.regal_earring,
        ear2 = "Fili Earring +1",
        body = gear.af3_body,
        hands = "Inyan. Dastanas +2",
        ring1 = "Metamorph Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.magic_jse_back,
        waist = gear.acuity_belt,
        legs = "Inyanga Shalwar +2",
        feet = gear.af1_feet
    }

    sets.midcast.SongDebuff.DW = {
        main = "Kali",
        sub = "Kali",
    } --Only weapons in this set. This set is overlayed onto  SongDebuff

    -- For song debuffs (accuracy primary, duration secondary)
    sets.midcast.SongDebuff.Resistant = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        range = "Gjallarhorn",
        ammo = empty,
        head = gear.af1_head,
        neck = "Mnbw. Whistle +1",
        ear1 = gear.regal_earring,
        ear2 = "Fili Earring +1",
        body = gear.af1_body,
        hands = gear.af1_hands,
        ring1 = "Metamorph Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.magic_jse_back,
        waist = gear.acuity_belt,
        legs = gear.af1_feet,
        feet = gear.af1_legs
    }

    -- Song-specific recast reduction
    sets.midcast.SongRecast = {
        main = "Kali",
        sub = "Ammurapi Shield",
        range = "Daurdabla",
        ammo = empty,
        head = "Bunzi's Hat",
        neck = gear.voltesurge_torque,
        ear1 = "Etiolation Earring",
        ear2 = "Loquac. Earring",
        body = "Inyanga Jubbah +2",
        hands = "gear.af3_hands",
        ring1 = gear.kishar_ring,
        ring2 = gear.prolix_ring,
        back = gear.magic_jse_back,
        waist = gear.witful_belt,
        legs = gear.af3_legs,
        feet = gear.af1_feet
    }

    -- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = { range = info.ExtraSongInstrument }

    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, { range = info.ExtraSongInstrument })

    -- Other general spells and classes.
    sets.midcast.Cure = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Kaykaus Mitra +1",
        neck = gear.incaters_torque,
        ear1 = "Mendi. Earring",
        ear2 = "Fili Earring +1",
        body = "Kaykaus Bliaut +1",
        hands = "Kaykaus Cuffs +1",
        ring1 = "Naji's Loop",
        ring2 = "Menelaus's Ring",
        back = gear.magic_jse_back,
        waist = gear.luminary_sash,
        legs = "Kaykaus tights +1",
        feet = "Kaykaus Boots +1"
    }

    sets.midcast.Curaga = sets.midcast.Cure

    sets.Self_Healing = {
        waist = "Gishdubar Sash"
    }
    sets.Cure_Received = {
        waist = "Gishdubar Sash"
    }

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        neck = gear.debilis_medallion,
        hands = gear.hieros_mittens,
        back = gear.oretan_cape,
        ring1 = gear.haomas_ring,
        ring2 = "Menelaus's Ring",
        waist = gear.witful_belt,
    })

    sets.idle = {
        main = gear.mpacas_staff,
        sub = gear.umbra_strap,
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head,
        neck = gear.loricate_torque,
        ear1 = "Etiolation Earring",
        ear2 = "Alabaster Earring",
        body = "Null Shawl",
        hands = gear.af3_hadns,
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Null Shawl",
        waist = "Flume Belt +1",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.idle.NoRefresh = {
        main = "Daybreak",
        sub = gear.genmei_shield,
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = gear.loricate_torque,
        ear1 = "Etiolation Earring",
        ear2 = gear.sanare_earring,
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = gear.shadow_ring,
        back = gear.magic_jse_cape,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = gear.af3_feet
    }

    sets.idle.DT = {
        main = "Daybreak",
        sub = gear.genmei_shield,
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = gear.loricate_torque,
        ear1 = "Etiolation Earring",
        ear2 = gear.sanare_earring,
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = gear.shadow_ring,
        back = gear.magic_jse_cape,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    -- Defense sets

    sets.defense.PDT = {
        main = "Daybreak",
        sub = gear.genmei_shield,
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = gear.loricate_torque,
        ear1 = "Etiolation Earring",
        ear2 = gear.sanare_earring,
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = gear.shadow_ring,
        back = gear.magic_jse_cape,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.MDT = {
        main = "Daybreak",
        sub = gear.genmei_shield,
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = gear.loricate_torque,
        ear1 = "Etiolation Earring",
        ear2 = gear.sanare_earring,
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = gear.shadow_ring,
        back = gear.magic_jse_cape,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.Kiting = { feet = "Fili Cothurnes +1" }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        main = "Naegling",
        sub = gear.genmei_shield,
        range = gear.linos_tp,
        head = "Aya. Zucchetto +2",
        neck = "Bard's Charm +2",
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
        body = "Ayanmo Corazza +2",
        hands = "Bunzi's Gloves ",
        ring1 = "Moonlight Ring",
        ring2 = "Moonlight Ring",
        back = "Null Shawl",
        waist = "Windbuffet Belt +1",
        legs = "Volte Tights",
        feet = "Nyame Sollerets"
    }

    sets.engaged = {
        main = "Naegling",
        sub = gear.genmei_shield,
        range = gear.linos_tp,
        head = "Aya. Zucchetto +2",
        neck = "Bard's Charm +2",
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
        body = "Ayanmo Corazza +2",
        hands = "Bunzi's Gloves ",
        ring1 = "Moonlight Ring",
        ring2 = "Moonlight Ring",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Volte Tights",
        feet = "Nyame Sollerets"
    }

    sets.engaged.Acc = {
        main = "Naegling",
        sub = gear.genmei_shield,
        range = gear.linos_tp,
        head = "Aya. Zucchetto +2",
        neck = "Bard's Charm +2",
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
        body = "Ayanmo Corazza +2",
        hands = "Bunzi's Gloves ",
        ring1 = "Moonlight Ring",
        ring2 = "Moonlight Ring",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Volte Tights",
        feet = "Nyame Sollerets"
    }

    sets.engaged.DW = {
        main = "Naegling",
        sub = "Blurred Knife +1",
        range = gear.linos_tp,
        head = "Aya. Zucchetto +2",
        neck = "Bard's Charm +2",
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
        body = "Ayanmo Corazza +2",
        hands = "Bunzi's Gloves ",
        ring1 = "Moonlight Ring",
        ring2 = "Moonlight Ring",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Volte Tights",
        feet = "Nyame Sollerets"
    }

    sets.engaged.DW.DT = {
        main = "Naegling",
        sub = "Blurred Knife +1",
        range = gear.linos_tp,
        head = "Aya. Zucchetto +2",
        neck = "Bard's Charm +2",
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
        body = "Ayanmo Corazza +2",
        hands = "Bunzi's Gloves ",
        ring1 = "Moonlight Ring",
        ring2 = "Moonlight Ring",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Volte Tights",
        feet = "Nyame Sollerets"
    }

    sets.engaged.DW.Acc = {
        main = "Naegling", --Missing
        sub = "Blurred Knife +1",
        range = gear.linos_tp,
        head = "Aya. Zucchetto +2",
        neck = "Bard's Charm +2",
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
        body = "Ayanmo Corazza +2",
        hands = "Bunzi's Gloves ",
        ring1 = "Moonlight Ring",
        ring2 = "Moonlight Ring",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Volte Tights",
        feet = "Nyame Sollerets"
    }

    sets.engaged.DW.Acc.DT = {
        main = "Naegling",
        sub = "Blurred Knife +1",
        range = gear.linos_tp,
        head = "Aya. Zucchetto +2",
        neck = "Bard's Charm +2",
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
        body = "Ayanmo Corazza +2",
        hands = "Bunzi's Gloves ",
        ring1 = "Moonlight Ring",
        ring2 = "Moonlight Ring",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Volte Tights",
        feet = "Nyame Sollerets"
    }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(10, 10)
end

autows_list = {
    ['Naegling'] = 'Savage Blade',
    ['Aeneas'] = "Rudra's Storm",
    ['DualWeapons'] = "Rudra's Storm",
    ['DualNaegling'] = 'Savage Blade',
    ['DualTauret'] = 'Evisceration',
    ['DualAeolian'] = 'Aeolian Edge'
}
