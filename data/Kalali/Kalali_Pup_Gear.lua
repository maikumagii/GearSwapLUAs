-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function character_user_job_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'Fodder')
    state.HybridMode:options('Pet', 'DT', 'Normal')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'FullAcc', 'Fodder')
    state.PhysicalDefenseMode:options('PDT')
    state.IdleMode:options('Normal', 'PDT')
    state.Weapons:options('None', 'Kaja', 'Denouements', 'Midnights', 'Pitre', 'PetWeapons')
    state.PetMode                = M { ['description'] = 'Pet Mode', 'None', 'Melee', 'Ranged', 'HybridRanged', 'Bruiser', 'Tank', 'LightTank', 'Magic', 'Heal', 'Nuke' }
    state.AutoRepairMode         = M(false, 'Auto Repair Mode')
    state.AutoDeployMode         = M(true, 'Auto Deploy Mode')
    state.AutoPetMode            = M(true, 'Auto Pet Mode')
    state.PetWSGear              = M(true, 'Pet WS Gear')
    state.PetEnmityGear          = M(false, 'Pet Enmity Gear')

    gear.jse_neck                = "Puppetmaster's Collar +1"
    gear.jse_ear2                = "Karagoz Earring"

    gear.dyna_weapon             = "Pitre Fists"

    -- Artifact gear placeholders.
    gear.af1_head                = "" -- "Foire Taj +3"
    gear.af1_body                = "" -- "Foire Tobe +3"
    gear.af1_hands               = "" -- "Foire Dastanas +3"
    gear.af1_legs                = "" -- "Foire Churidars +3"
    gear.af1_feet                = "" -- "Foire Babouches +3"

    -- Relic gear placeholders.
    gear.af2_head                = "" -- "Pitre Taj +3"
    gear.af2_body                = "" -- "Pitre Tobe +3"
    gear.af2_hands               = "" -- "Pitre Dastanas +3"
    gear.af2_legs                = "" -- "Pitre Churidars +3"
    gear.af2_feet                = "" -- "Pitre Babouches +3"

    gear.af3_head                = "Karagoz Cappello +2"
    gear.af3_body                = "Karagoz Farsetto +2"
    gear.af3_hands               = "Karagoz Guanti +2"
    gear.af3_legs                = "Karagoz Pantaloni +2"
    gear.af3_feet                = "Karagoz Scarpe +2"

    gear.varar_ring1             = { name = "Varar Ring +1", bag = "Wardrobe" }
    gear.varar_ring2             = { name = "Varar Ring +1", bag = "Wardrobe 2" }
    gear.pet_tp_bonus_back       = {
        name = "Dispersal Mantle",
        augments = { 'STR+3', 'DEX+1', 'Pet: TP Bonus +480', }
    }

    -- List of gear I want, could be BiS. When I get the item, can replace it here.
    gear.godhands                = "Kaja Knuckles"       -- "Godhands"
    gear.ohtas                   = "Midnights"           -- "Ohtas"
    gear.buffoons_collar         = gear.jse_neck         -- "Buffoon's Collar +1"
    gear.visucius_pet_ws_back    = gear.pet_tp_bonus_back
    gear.visucius_pet_tank_back  = "Null Shawl"          -- "Visucius's Mantle"
    gear.visucius_master_tp_back = "Null Shawl"          -- "Visucius's Mantle"
    gear.shulmanu_collar         = gear.jse_neck         -- "Shulmanu Collar"
    gear.enmerkar_earring        = "Pratik Earring"      -- "Enmerkar Earring"
    gear.handlers_earring        = "Pratik Earring"      -- "Handler's Earring +1"
    gear.crepuscular_earring     = gear.jse_ear2         -- "Crepuscular Earring"
    gear.c_palug_ring            = gear.varar_ring2      -- "C. Palug Ring"
    gear.incarnation_sash        = "Incarnation Sash"
    gear.klouskap_sash           = gear.incarnation_sash -- "Klouskap Sash +1"
    gear.regimen_mittens         = gear.af3_hands        -- "Regimen Mittens"
    gear.taeon_pet_body          = gear.af3_body         -- Pet Taeon body
    gear.taeon_pet_hands         = gear.af3_hands        -- Pet Taeon hands
    gear.taeon_pet_feet          = gear.af3_feet         -- Pet Taeon feet
    gear.taliah_pet_legs         = gear.af3_legs         -- "Tali'ah Seraweels +2"
    gear.mpaca_head              = gear.af3_head         -- "Mpaca's Cap"
    gear.mpaca_hands             = gear.af3_hands        -- "Mpaca's Gloves"
    gear.mpaca_feet              = gear.af3_feet         -- "Mpaca's Boots"

    -- Default/Automatic maneuvers for each pet mode.  Define at least 3.
    defaultManeuvers             = {
        Melee = {
            { Name = 'Fire Maneuver',    Amount = 1 },
            { Name = 'Thunder Maneuver', Amount = 1 },
            { Name = 'Wind Maneuver',    Amount = 1 },
            { Name = 'Light Maneuver',   Amount = 0 },
        },
        Bruiser = {
            { Name = 'Light Maneuver', Amount = 1 },
            { Name = 'Water Maneuver', Amount = 1 },
            { Name = 'Fire Maneuver',  Amount = 1 },
            { Name = 'Light Maneuver', Amount = 0 },
        },
        Ranged = {
            { Name = 'Wind Maneuver',    Amount = 3 },
            { Name = 'Fire Maneuver',    Amount = 0 },
            { Name = 'Light Maneuver',   Amount = 0 },
            { Name = 'Thunder Maneuver', Amount = 0 },
        },
        HybridRanged = {
            { Name = 'Wind Maneuver',    Amount = 1 },
            { Name = 'Fire Maneuver',    Amount = 1 },
            { Name = 'Light Maneuver',   Amount = 1 },
            { Name = 'Thunder Maneuver', Amount = 0 },
        },
        Tank = {
            { Name = 'Earth Maneuver', Amount = 1 },
            { Name = 'Fire Maneuver',  Amount = 1 },
            { Name = 'Light Maneuver', Amount = 1 },
            { Name = 'Dark Maneuver',  Amount = 0 },
        },
        LightTank = {
            { Name = 'Earth Maneuver', Amount = 1 },
            { Name = 'Fire Maneuver',  Amount = 1 },
            { Name = 'Light Maneuver', Amount = 1 },
            { Name = 'Dark Maneuver',  Amount = 0 },
        },
        Magic = {
            { Name = 'Light Maneuver', Amount = 1 },
            { Name = 'Ice Maneuver',   Amount = 1 },
            { Name = 'Dark Maneuver',  Amount = 1 },
            { Name = 'Earth Maneuver', Amount = 0 },
        },
        Heal = {
            { Name = 'Light Maneuver', Amount = 2 },
            { Name = 'Dark Maneuver',  Amount = 1 },
            { Name = 'Water Maneuver', Amount = 0 },
            { Name = 'Earth Maneuver', Amount = 0 },
        },
        Nuke = {
            { Name = 'Ice Maneuver',   Amount = 2 },
            { Name = 'Dark Maneuver',  Amount = 1 },
            { Name = 'Water Maneuver', Amount = 0 },
            { Name = 'Earth Maneuver', Amount = 0 },
        },
    }

    deactivatehpp                = 85

    select_default_macro_book()
    update_pet_mode()

    send_command('bind @` gs c cycle SkillchainMode')
    send_command('bind @f8 gs c toggle AutoPuppetMode')
    send_command('bind !f7 gs c toggle AutoRepairMode')
end

-- Define sets used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.precast.FC = {
        ammo = "Impatiens",
        neck = "Voltsurge Torque",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Loquac. Earring",
        ring1 = "Prolix Ring",
        ring2 = "Lebeche Ring",
        waist = "Witful Belt",
    }

    -- Precast sets to enhance JAs
    sets.precast.JA['Tactical Switch'] = {
        -- hands = gear.af2_hands,
    }
    sets.precast.JA['Repair'] = {
        ammo = "Automat. Oil +3",
        feet = gear.af3_feet,
        -- feet = gear.af1_feet,
    }
    sets.precast.JA['Maintenance'] = { ammo = "Automat. Oil +3" }

    sets.precast.JA.Maneuver = {
        main = "Midnights",
        neck = gear.buffoons_collar,
        ear2 = gear.jse_ear2,
        body = gear.af3_body,
        hands = gear.af3_hands,
        -- body = gear.af1_body,
        -- hands = gear.af1_hands,
    }

    -- Weaponskill sets
    sets.precast.WS = {
        head = "Nyame Helm",
        neck = gear.jse_neck,
        ear1 = "Moonshade Earring",
        ear2 = "Sroda Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Niqmaddu Ring",
        ring2 = gear.tvr_ring,
        back = "Null Shawl",
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        neck = "Null Loop",
        ear2 = "Telos Earring",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        waist = "Null Belt",
    })
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS.Acc, {
        ear1 = "Telos Earring",
        ear2 = gear.jse_ear2,
    })
    sets.precast.WS.Fodder = set_combine(sets.precast.WS, {
        ear2 = "Ishvara Earring",
    })

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Victory Smite'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Victory Smite'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Victory Smite'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Stringing Pummel'].Acc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Stringing Pummel'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Stringing Pummel'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shijin Spiral'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Shijin Spiral'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Shijin Spiral'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS,
        { neck = "Fotia Gorget", waist = "Fotia Belt" })
    sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc,
        { neck = "Fotia Gorget", waist = "Fotia Belt" })
    sets.precast.WS['Asuran Fists'].FullAcc = set_combine(sets.precast.WS.FullAcc,
        { neck = "Fotia Gorget", waist = "Fotia Belt" })
    sets.precast.WS['Asuran Fists'].Fodder = set_combine(sets.precast.WS.Fodder,
        { neck = "Fotia Gorget", waist = "Fotia Belt" })

    sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dragon Kick'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Dragon Kick'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Dragon Kick'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tornado Kick'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tornado Kick'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tornado Kick'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Asuran Fists'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Asuran Fists'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Raging Fists'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Raging Fists'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Raging Fists'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Howling Fist'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Howling Fist'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Howling Fist'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Backhand Blow'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Backhand Blow'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Backhand Blow'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Backhand Blow'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Spinning Attack'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Spinning Attack'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Spinning Attack'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Shoulder Tackle'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shoulder Tackle'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Shoulder Tackle'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Shoulder Tackle'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.MaxTP = { ear1 = "Schere Earring" }
    sets.AccMaxTP = { ear1 = "Telos Earring", ear2 = gear.jse_ear2 }

    sets.midcast.FastRecast = {
        ammo = "Impatiens",
        neck = "Voltsurge Torque",
        ear1 = "Etiolation Earring",
        ear2 = "Loquac. Earring",
        ring1 = "Prolix Ring",
        ring2 = "Lebeche Ring",
        waist = "Witful Belt",
    }

    sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

    sets.midcast['Dark Magic'] = {
        ammo = "Pemphredo Tathlum",
        head = "Nyame Helm",
        neck = "Null Loop",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Metamorph Ring +1",
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }
    sets.midcast['Absorb-TP'] = set_combine(sets.midcast['Dark Magic'], {})
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
        neck = "Incanter's Torque",
        ear1 = "Andoaa Earring",
        ear2 = "Mimir Earring",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = "Perimede Cape",
        waist = "Embla Sash"
    })
    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {})

    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {
        neck = "Adad Amulet",
        ear1 = "Pratik Earring",
        ear2 = gear.jse_ear2,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = gear.varar_ring1,
        ring2 = gear.varar_ring2,
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet,
    }
    sets.midcast.Pet['Enfeebling Magic'] = {
        neck = "Adad Amulet",
        ear1 = "Kyrene's Earring",
        ear2 = "Pratik Earring",
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = gear.varar_ring1,
        ring2 = gear.varar_ring2,
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet,
    }
    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet['Enfeebling Magic'], {})

    -- The following sets are predictive and are equipped before we even know the ability will happen, as a workaround due to
    -- the fact that start of ability packets are too late in the case of Pup abilities, WS, and certain spells.
    sets.midcast.Pet.PetEnmityGear = {
        head = gear.af3_head,
        neck = gear.jse_neck,
        ear1 = "Pratik Earring",
        ear2 = gear.jse_ear2,
        body = gear.af3_body,
        hands = gear.af3_hands,
        -- head = gear.af2_head,
        -- body = gear.af2_body,
        -- hands = gear.af2_hands,
        -- legs = gear.af2_legs,
        -- feet = gear.af2_feet,
        ring1 = gear.varar_ring1,
        ring2 = gear.varar_ring2,
        back = gear.visucius_pet_tank_back,
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet,
    }
    sets.midcast.Pet.PetWSGear = {
        head = "Nyame Helm",
        neck = gear.shulmanu_collar,
        ear1 = "Sroda Earring",
        ear2 = gear.crepuscular_earring,
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = gear.varar_ring1,
        ring2 = gear.c_palug_ring,
        back = gear.visucius_pet_ws_back,
        waist = gear.incarnation_sash,
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.midcast.Pet.PetWSGear.Ranged = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Melee = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Tank = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Bruiser = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.LightTank = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Magic = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Heal = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Nuke = set_combine(sets.midcast.Pet.PetWSGear, {})

    sets.resting = {}

    -- Idle sets
    sets.idle = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Adamantite Armor",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = {
        head = gear.af3_head,
        neck = gear.jse_neck,
        ear1 = "Pratik Earring",
        ear2 = gear.jse_ear2,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = gear.varar_ring1,
        ring2 = gear.varar_ring2,
        back = gear.visucius_pet_tank_back,
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = set_combine(sets.midcast.Pet.PetWSGear, {})

    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {})
    sets.idle.Pet.Engaged.Melee = set_combine(sets.idle.Pet.Engaged, {})
    sets.idle.Pet.Engaged.Tank = set_combine(sets.midcast.Pet.PetEnmityGear, {})
    sets.idle.Pet.Engaged.Bruiser = set_combine(sets.idle.Pet.Engaged, {})
    sets.idle.Pet.Engaged.LightTank = set_combine(sets.idle.Pet.Engaged, {
        ear1 = "Pratik Earring",
    })
    sets.idle.Pet.Engaged.Magic = set_combine(sets.midcast.Pet['Elemental Magic'], {})
    sets.idle.Pet.Engaged.Heal = sets.idle.Pet.Engaged.Magic
    sets.idle.Pet.Engaged.Nuke = sets.idle.Pet.Engaged.Magic

    -- Defense sets
    sets.defense.PDT = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Adamantite Armor",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.MDT = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Adamantite Armor",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.MEVA = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Null Loop",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Adamantite Armor",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }
    sets.idle.PDT = sets.defense.PDT

    sets.Kiting = { ring2 = "Shneddick Ring" }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        head = gear.af3_head,
        neck = gear.jse_neck,
        ear1 = "Schere Earring",
        ear2 = "Telos Earring",
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Niqmaddu Ring",
        ring2 = "Epona's Ring",
        back = gear.visucius_master_tp_back,
        waist = "Sailfi Belt +1",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }
    sets.engaged.Acc = set_combine(sets.engaged, {
        neck = "Null Loop",
        ear1 = "Telos Earring",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        waist = "Null Belt",
    })
    sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {
        ear2 = "Telos Earring",
    })
    sets.engaged.Fodder = set_combine(sets.engaged, {
        ear2 = "Brutal Earring",
    })
    sets.engaged.DT = set_combine(sets.defense.PDT, {
        ear1 = "Schere Earring",
        ear2 = "Telos Earring",
    })
    sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {
        neck = "Null Loop",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
    })
    sets.engaged.FullAcc.DT = set_combine(sets.engaged.Acc.DT, {})
    sets.engaged.Fodder.DT = set_combine(sets.engaged.DT, {
        ear2 = "Brutal Earring",
    })
    sets.engaged.Pet = set_combine(sets.engaged, {
        ear1 = "Sroda Earring",
        ear2 = gear.jse_ear2,
        ring1 = gear.varar_ring1,
        ring2 = gear.varar_ring2,
        waist = gear.klouskap_sash,
    })
    sets.engaged.Acc.Pet = set_combine(sets.engaged.Acc, {
        ear2 = gear.jse_ear2,
        ring1 = gear.varar_ring1,
        ring2 = gear.varar_ring2,
    })
    sets.engaged.FullAcc.Pet = set_combine(sets.engaged.Acc.Pet, {})
    sets.engaged.Fodder.Pet = set_combine(sets.engaged.Pet, {})

    -- Weapons sets
    sets.weapons.None = { main = empty, range = "Animator P +1" }
    sets.weapons.Kaja = { main = "Kaja Knuckles", range = "Animator P +1" }
    sets.weapons.Denouements = { main = "Denouements", range = "Animator P +1" }
    sets.weapons.Midnights = { main = "Midnights", range = "Animator P +1" }
    sets.weapons.Pitre = { main = gear.dyna_weapon, range = "Animator P +1" }
    sets.weapons.PetWeapons = { main = gear.ohtas, range = "Animator P II +1" }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 9)
end

--[[
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 20)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 20)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 20)
    else
        set_macro_page(2, 20)
    end
]]

function user_job_lockstyle()
    windower.chat.input('/lockstyleset 017')
end
