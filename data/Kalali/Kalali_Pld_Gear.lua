function character_user_job_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'Tp', 'XP')
    state.HybridMode:options('Tank', 'DDTank', 'Normal')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'SIRD')
    state.Passive:options('None', 'AbsorbMP')
    state.PhysicalDefenseMode:options('PDT', 'PDT_Reraise')
    state.MagicalDefenseMode:options('MDT', 'MDT_Reraise')
    state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Tank', 'Kiting', 'PDT', 'Block', 'MDT', 'Normal')
    state.Weapons:options('None', 'ExcaliburDuban', 'ExcaliburAegis', 'ExcaliburBlurred', 'NaeglingDuban',
        'NaeglingAegis', 'BurtgangDuban', 'BurtgangAegis')

    autows_list = {
        ExcaliburDuban = 'Knights of Round',
        ExcaliburAegis = 'Knights of Round',
        ExcaliburBlurred = 'Knights of Round',
        NaeglingDuban = 'Savage Blade',
        NaeglingAegis = 'Savage Blade',
        BurtgangDuban = 'Atonement',
        BurtgangAegis = 'Atonement',
    }

    state.ExtraDefenseMode = M { ['description'] = 'Extra Defense Mode', 'None', 'MP', 'Twilight' }

    gear.rudianos_enmity_back = {
        name = "Rudianos's Mantle",
        augments = { 'VIT+20', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
            'Phys. dmg. taken-10%', }
    }
    gear.rudianos_fc_back = {
        name = "Rudianos's Mantle",
        augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'HP+20', '"Fast Cast"+10' }
    }
    gear.rudianos_cure_back = {
        name = "Rudianos's Mantle",
        augments = { 'MND+20', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10',
            '"Cure" potency +10%', 'Spell interruption rate down-10%' }
    }
    gear.rudianos_str_wsd_back = {
        name = "Rudianos's Mantle",
        augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%',
            'Damage taken-5%' }
    }
    gear.phalanx_jse_back = {
        name = "Weard Mantle",
        augments = { 'VIT+4', 'DEX+2', 'Phalanx +5' }
    }
    gear.jse_ear2 = "Chev. Earring +1"

    -- Guide missing gear
    gear.guide_missing = {
        -- UNM / Unity Wanted
        loess_barbuta_1 = "Loess Barbuta +1",                -- 3
        odnowa_earring_1 = "Odnowa Earring +1",              -- 5

        -- HTBF
        crepuscular_mail = "Crepuscular Mail",               -- 1
        sacro_gorget = "Sacro Gorget",                       -- 2
        trux_earring = "Trux Earring",                       -- 3

        -- Domain Invasion
        tuisto_earring = "Tuisto Earring",                   -- 6

        -- Geas Fete / Escha-Reisenjima
        asklepian_belt = "Asklepian Belt",                   -- 3
        eschite_gauntlets = "Eschite Gauntlets",             -- 1
        fortified_ring = "Fortified Ring",                   -- 4
        odyssean_helm = "Odyssean Helm",                     -- 1, Phalanx +5
        sapience_orb = "Sapience Orb",                       -- 6

        -- Sinister Reign
        jumalik_helm = "Jumalik Helm",                       -- 1
        leyline_gloves = "Leyline Gloves",                   -- 4
        malevolence = "Malevolence",                         -- 2

        -- Omen
        regal_gauntlets = "Regal Gauntlets",                 -- 6

        -- Meeble Burrows
        orunmilas_torque = "Orunmila's Torque",              -- 4

        -- Abyssea
        creed_baudrier = "Creed Baudrier",                   -- 3

        -- JSE reforging
        rev_coronet_3 = "Rev. Coronet +3",                   -- 1
        rev_leggings_3 = "Rev. Leggings +3",                 -- 1

        -- Mythic
        burtgang = "Burtgang",                               -- 23

        -- Crafted / AH / older-content pieces
        shab_cuirass_1 = "Shab. Cuirass +1",                 -- 2
    }

    -- Artifact Gear
    gear.af1_head = "" -- Rev. Coronet +3
    gear.af1_body = "Rev. Surcoat +4"
    gear.af1_hands = ""
    gear.af1_legs = ""
    gear.af1_feet = "" -- Rev. Leggings +3

    -- Relic Gear
    gear.af2_head = "Cab. Coronet +3"
    gear.af2_body = "Cab. Surcoat +1" -- Cab. Surcoat +4
    gear.af2_hands = "Cab. Gauntlets +4"
    gear.af2_legs = "Cab. Breeches +1" -- Cab. Breeches +4
    gear.af2_feet = "Cab. Leggings +3"


    -- Empy Gear
    gear.af3_head = "Chev. Armet +1"
    gear.af3_body = "Chev. Cuirass +1"
    gear.af3_hands = "Chev. Gauntlets +1"
    gear.af3_legs = "Chev. Cuisses +1"
    gear.af3_feet = "Chev. Sabatons +1"

    gear.souv_head = {
        name = "Souv. Schaller +1",
        augments = { 'HP+105', 'Enmity+9', 'Potency of "Cure" effect received +15%' }
    }
    gear.souv_body = {
        name = "Souv. Cuirass +1",
        augments = { 'HP+105', 'Enmity+9', 'Potency of "Cure" effect received +15%' }
    }
    gear.souv_hands_c = {
        name = "Souv. Handsch. +1",
        augments = { 'HP+105', 'Enmity+9', 'Potency of "Cure" effect received +15%' }
    }
    gear.souv_hands_d = {
        name = "Souv. Handsch. +1",
        augments = { 'HP+65', 'Shield skill +15', 'Phys. dmg. taken -4' }
    }
    gear.souv_legs = {
        name = "Souv. Diechlings +1",
        augments = { 'HP+105', 'Enmity+9', 'Potency of "Cure" effect received +15%' }
    }
    gear.souv_feet = {
        name = "Souveran Schuhs +1",
        augments = { 'HP+105', 'Enmity+9', 'Potency of "Cure" effect received +15%' }
    }
    gear.odyssean_greaves_cure = {
        name = "Odyssean Greaves",
        augments = { 'MND+8', 'Mag. Acc.+6', '"Cure" potency +5%' }
    }
    gear.odyssean_greaves_enmity = {
        name = "Odyssean Greaves",
        augments = { 'MND+7', 'Mag. Acc.+24', '"Mag. Atk. Bns."+9', 'Enmity+8' }
    }
    gear.odyssean_greaves_phalanx = gear.odyssean_greaves_enmity -- Target augment: Phalanx +5

    -- Additional local binds
    send_command('bind !` gs c SubJobEnmity')
    send_command('bind ^backspace input /ja "Shield Bash" <t>')
    send_command('bind @backspace input /ja "Cover" <stpt>')
    send_command('bind !backspace input /ja "Sentinel" <me>')
    send_command('bind @= input /ja "Chivalry" <me>')
    send_command('bind != input /ja "Palisade" <me>')
    send_command('bind ^delete input /ja "Provoke" <stnpc>')
    send_command('bind !delete input /ma "Cure IV" <stal>')
    send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @` gs c cycle RuneElement')
    send_command('bind ^pause gs c toggle AutoRuneMode')
    send_command('bind @f8 gs c toggle AutoTankMode')
    send_command('bind @f10 gs c toggle TankAutoDefense')
    send_command('bind ^@!` gs c cycle SkillchainMode')

    select_default_macro_book()
    update_defense_mode()
end

function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    sets.Enmity = {
        -- main = "Burtgang",
        sub = "Duban",
        -- ammo = { name = "Sapience Orb", priority = 8 },
        -- head = { name = "Loess Barbuta +1", priority = 11 },
        neck = { name = "Moonlight Necklace", priority = 7 },
        -- ear1 = { name = "Trux Earring", priority = 10 },
        ear2 = { name = "Cryptic Earring", priority = 12 },
        body = {
            name = "Souv. Cuirass +1",
            augments = { 'HP+105', 'Enmity+9', 'Potency of "Cure" effect received +15%' },
            priority = 1
        },
        hands = {
            name = "Souv. Handsch. +1",
            augments = { 'HP+105', 'Enmity+9', 'Potency of "Cure" effect received +15%' },
            priority = 13
        },
        ring1 = { name = "Apeile Ring +1", priority = 6 },
        ring2 = { name = "Apeile Ring", priority = 5 },
        back = {
            name = "Rudianos's Mantle",
            augments = { 'VIT+20', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
                'Phys. dmg. taken-10%', },
            priority = 3,
        },
        -- waist = { name = "Creed Baudrier", priority = 9 },
        legs = {
            name = "Souv. Diechlings +1",
            augments = { 'HP+105', 'Enmity+9', 'Potency of "Cure" effect received +15%' },
            priority = 2
        },
        feet = { name = gear.af3_feet, priority = 4 }, -- Chev. Sabatons +3
    }

    sets.Enmity.SIRD = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = { name = "Staunch Tathlum +1", priority = 8 },
        -- head = { name = "Loess Barbuta +1", priority = 11 },
        neck = { name = "Moonlight Necklace", priority = 7 },
        -- ear1 = { name = "Odnowa Earring +1", priority = 12 },
        -- ear2 = { name = "Trux Earring", priority = 10 },
        body = { name = gear.af3_body, priority = 13 }, -- Chev. Cuirass +3
        hands = {
            name = "Souv. Handsch. +1",
            augments = { 'HP+105', 'Enmity+9', 'Potency of "Cure" effect received +15%' },
            priority = 13
        },
        ring1 = { name = "Apeile Ring +1", priority = 6 },
        ring2 = { name = "Gelatinous Ring +1", priority = 5 },
        back = {
            name = "Rudianos's Mantle",
            augments = { 'VIT+20', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
                'Phys. dmg. taken-10%', },
            priority = 3,
        },
        -- waist = { name = "Creed Baudrier", priority = 9 },
        legs = { name = "Founder's Hose", priority = 2 },
        feet = gear.odyssean_greaves_enmity,
    }

    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {
        legs = gear.af2_legs,
    }
    sets.precast.JA['Holy Circle'] = {
        -- feet = gear.af1_feet, -- Rev. Leggings +3
    }
    sets.precast.JA['Sentinel'] = {
        feet = gear.af2_feet,
    }
    sets.precast.JA['Rampart'] = {
        head = gear.af2_head,
    }
    sets.precast.JA['Fealty'] = {
        body = gear.af2_body,
    }
    sets.precast.JA['Divine Emblem'] = {
        feet = gear.af3_feet, -- Chev. Sabatons +3
    }
    sets.precast.JA['Cover'] = {
        -- head = gear.af1_head, -- Rev. Coronet +3
        body = gear.af2_body,
    }

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        hands = gear.af2_hands,
    }

    sets.precast.JA['Shield Bash'] = {
        sub = "Aegis",
        ear1 = "Knightly Earring",
        hands = gear.af2_hands,
    }
    sets.precast.JA['Provoke'] = sets.Enmity
    sets.precast.JA['Warcry'] = sets.Enmity
    sets.precast.JA['Palisade'] = sets.Enmity
    sets.precast.JA['Intervene'] = sets.Enmity
    sets.precast.JA['Defender'] = sets.Enmity
    sets.precast.JA['Berserk'] = sets.Enmity
    sets.precast.JA['Aggressor'] = sets.Enmity

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        ammo = "Aurgelmir Orb +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = gear.af1_body,
        hands = "Nyame Gauntlets",
        ring1 = "Menelaus's Ring",
        ring2 = "Naji's Loop",
        back = gear.rudianos_enmity_back,
        waist = "Gishdubar Sash",
        legs = "Dashing Subligar",
        feet = "Nyame Sollerets"
    }

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Step = {
        ammo = "Aurgelmir Orb +1",
        head = "Flam. Zucchetto +2",
        neck = "Null Loop",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
        body = "Flamma Korazin +2",
        hands = "Flam. Manopolas +2",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Flamma Dirs +2",
        feet = "Flam. Gambieras +2"
    }

    sets.precast.JA['Violent Flourish'] = {
        ammo = "Aurgelmir Orb +1",
        head = "Flam. Zucchetto +2",
        neck = "Erra Pendant",
        ear1 = "Crep. Earring",
        ear2 = "Alabaster Earring",
        body = "Flamma Korazin +2",
        hands = "Flam. Manopolas +2",
        ring1 = "Murky Ring",
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Flamma Dirs +2",
        feet = "Flam. Gambieras +2"
    }

    sets.precast.JA['Animated Flourish'] = sets.Enmity

    -- Fast cast sets for spells

    sets.precast.FC = {
        -- main = "Burtgang",
        sub = "Duban",
        -- ammo = { name = "Sapience Orb", priority = 10 },
        head = { name = "Carmine Mask +1", priority = 3 },
        -- neck = { name = "Orunmila's Torque", priority = 5 },
        ear1 = { name = "Enchntr. Earring +1", priority = 1 },
        ear2 = { name = "Loquac. Earring", priority = 2 },
        body = { name = gear.af1_body, priority = 13 }, -- Rev. Surcoat +4
        -- hands = { name = "Leyline Gloves", priority = 6 },
        ring1 = "Kishar Ring",
        ring2 = { name = "Prolix Ring", priority = 7 },
        back = { name = "Rudianos's Mantle", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'HP+20', '"Fast Cast"+10' }, priority = 12 },
        waist = { name = "Plat. Mog. Belt", priority = 8 },
        legs = { name = "Sworn Brais", priority = 11 },
        feet = { name = gear.af3_feet, priority = 9 }, -- Chev. Sabatons +3
    }

    sets.precast.FC['Enhancing Magic'] = {
        -- main = "Burtgang",
        sub = "Duban",
        -- ammo = { name = "Sapience Orb", priority = 10 },
        head = { name = "Carmine Mask +1", priority = 3 },
        -- neck = { name = "Orunmila's Torque", priority = 5 },
        ear1 = { name = "Enchntr. Earring +1", priority = 1 },
        ear2 = { name = "Loquac. Earring", priority = 2 },
        body = { name = gear.af1_body, priority = 13 }, -- Rev. Surcoat +4
        -- hands = { name = "Leyline Gloves", priority = 6 },
        ring1 = "Kishar Ring",
        ring2 = { name = "Prolix Ring", priority = 7 },
        back = { name = "Rudianos's Mantle", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'HP+20', '"Fast Cast"+10' }, priority = 12 },
        waist = { name = "Plat. Mog. Belt", priority = 8 },
        legs = { name = "Sworn Brais", priority = 11 },
        feet = { name = gear.af3_feet, priority = 9 }, -- Chev. Sabatons +3
    }
    sets.precast.FC.Cure = {
        -- main = "Burtgang",
        sub = "Duban",
        -- ammo = { name = "Sapience Orb", priority = 10 },
        head = { name = "Carmine Mask +1", priority = 3 },
        -- neck = { name = "Orunmila's Torque", priority = 5 },
        ear1 = { name = "Enchntr. Earring +1", priority = 1 },
        ear2 = { name = "Loquac. Earring", priority = 2 },
        body = { name = gear.af1_body, priority = 13 }, -- Rev. Surcoat +4
        -- hands = { name = "Leyline Gloves", priority = 6 },
        ring1 = "Kishar Ring",
        ring2 = { name = "Prolix Ring", priority = 7 },
        back = { name = "Rudianos's Mantle", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'HP+20', '"Fast Cast"+10' }, priority = 12 },
        waist = { name = "Plat. Mog. Belt", priority = 8 },
        legs = { name = "Sworn Brais", priority = 11 },
        feet = { name = gear.af3_feet, priority = 9 }, -- Chev. Sabatons +3
    }
    sets.precast.FC.Cure.DT = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = "Aurgelmir Orb +1",
        head = "Nyame Helm",
        neck = "Rep. Plat. Medal",
        ear1 = "Cessance Earring",
        ear2 = "Brutal Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Sroda Ring",
        ring2 = gear.tvr_ring,
        back = gear.rudianos_str_wsd_back,
        waist = "Fotia Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.WS.Acc = {
        ammo = "Coiste Bodhar",
        head = "Hjarrandi Helm",
        neck = "Null Loop",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
        body = "Nyame Mail",
        hands = "Sakpata's Gauntlets",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = gear.rudianos_str_wsd_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,
        { neck = "Fotia Gorget", ear1 = "Brutal Earring", ear2 = "Moonshade Earring" })
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc,
        { neck = "Fotia Gorget", ear1 = "Crep. Earring", ear2 = "Moonshade Earring" })

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS,
        { neck = "Fotia Gorget", ear1 = "Brutal Earring", ear2 = "Moonshade Earring" })
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc,
        { neck = "Fotia Gorget", ear1 = "Crep. Earring", ear2 = "Moonshade Earring" })

    sets.precast.WS['Savage Blade'] = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Crepuscular Pebble",
        head = "Nyame Helm",
        neck = "Kgt. Beads +2",
        -- ear1 = "Tuisto Earring",
        ear2 = "Thrud Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = gear.tvr_ring, -- Cornelia's Ring alternative
        ring2 = "Gelatinous Ring +1",
        back = gear.rudianos_str_wsd_back,
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
        neck = "Null Loop",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
        waist = "Null Belt",
    })
    sets.precast.WS['Savage Blade'].ExcaliburBlurred = set_combine(sets.precast.WS['Savage Blade'], {
        main = "Excalibur",
        sub = "Blurred Shield +1",
    })
    sets.precast.WS['Savage Blade'].ExcaliburBlurredAcc = set_combine(sets.precast.WS['Savage Blade'].Acc, {
        main = "Excalibur",
        sub = "Blurred Shield +1",
    })

    -- Excalibur's unique weaponskill.
    sets.precast.WS['Knights of Round'] = {
        ammo = "Aurgelmir Orb +1",
        head = "Nyame Helm",
        neck = "Rep. Plat. Medal",
        ear1 = "Ishvara Earring",
        ear2 = "Moonshade Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Sroda Ring",
        ring2 = gear.tvr_ring,
        back = gear.rudianos_str_wsd_back,
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }
    sets.precast.WS['Knights of Round'].Acc = set_combine(sets.precast.WS['Knights of Round'], {
        neck = "Null Loop",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
        waist = "Null Belt",
    })
    sets.precast.WS['Knights of Round'].ExcaliburBlurred = set_combine(sets.precast.WS['Knights of Round'], {
        main = "Excalibur",
        sub = "Blurred Shield +1",
    })
    sets.precast.WS['Knights of Round'].ExcaliburBlurredAcc = set_combine(sets.precast.WS['Knights of Round'].Acc, {
        main = "Excalibur",
        sub = "Blurred Shield +1",
    })
    sets.precast.WS['Knights of the Round'] = sets.precast.WS['Knights of Round']
    sets.precast.WS['Knights of the Round'].Acc = sets.precast.WS['Knights of Round'].Acc
    sets.precast.WS['Knights of the Round'].ExcaliburBlurred = sets.precast.WS['Knights of Round'].ExcaliburBlurred
    sets.precast.WS['Knights of the Round'].ExcaliburBlurredAcc = sets.precast.WS['Knights of Round'].ExcaliburBlurredAcc

    sets.precast.WS['Flat Blade'] = {
        ammo = "Aurgelmir Orb +1",
        head = "Flam. Zucchetto +2",
        neck = "Erra Pendant",
        ear1 = "Crep. Earring",
        ear2 = "Alabaster Earring",
        body = "Flamma Korazin +2",
        hands = "Flam. Manopolas +2",
        ring1 = "Murky Ring",
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Flamma Dirs +2",
        feet = "Flam. Gambieras +2"
    }

    sets.precast.WS['Sanguine Blade'] = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Ghastly Tathlum +1",
        head = "Nyame Helm",
        neck = "Sibyl Scarf",
        ear1 = "Thrud Earring",
        ear2 = "Friomisi Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring", -- Defending Ring
        ring2 = gear.tvr_ring, -- Cornelia's Ring alternative
        back = "Moonlight Cape",
        waist = "Orpheus's Sash",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.WS['Aeolian Edge'] = {
        -- main = "Malevolence",
        sub = "Duban",
        ammo = "Ghastly Tathlum +1",
        head = "Nyame Helm",
        neck = "Sibyl Scarf",
        ear1 = "Thrud Earring",
        ear2 = "Friomisi Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = gear.tvr_ring, -- Cornelia's Ring alternative
        ring2 = "Murky Ring", -- Defending Ring
        back = "Moonlight Cape",
        waist = "Orpheus's Sash",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.WS['Atonement'] = {
        -- main = "Burtgang",
        sub = "Duban",
        -- ammo = "Sapience Orb",
        -- head = "Loess Barbuta +1",
        neck = "Moonlight Necklace",
        -- ear1 = "Trux Earring",
        ear2 = "Cryptic Earring",
        body = gear.souv_body,
        hands = gear.souv_hands_c,
        ring1 = "Apeile Ring +1",
        ring2 = "Apeile Ring",
        back = gear.rudianos_enmity_back, -- Rudianos's Mantle
        -- waist = "Creed Baudrier",
        legs = gear.souv_legs, -- Souv. Diechlings +1
        feet = gear.af3_feet, -- Chev. Sabatons +3
    }
    sets.precast.WS['Atonement'].Acc = set_combine(sets.precast.WS['Atonement'], {
        neck = "Null Loop",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
    })

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = { ear1 = "Cessance Earring", ear2 = "Brutal Earring", }
    sets.MaxTP['Aeolian Edge'] = { ear2 = "Alabaster Earring" }
    sets.AccMaxTP = { ear1 = "Crep. Earring", ear2 = "Telos Earring" }


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Flash = sets.Enmity
    sets.midcast.Flash.SIRD = sets.Enmity.SIRD
    sets.midcast.Stun = sets.Enmity
    sets.midcast.Stun.SIRD = sets.Enmity.SIRD
    sets.midcast['Dark Magic'] = sets.Enmity
    sets.midcast['Dark Magic'].SIRD = sets.Enmity.SIRD
    sets.midcast['Absorb-TP'] = sets.midcast['Dark Magic']
    sets.midcast['Blue Magic'] = sets.Enmity
    sets.midcast['Blue Magic'].SIRD = sets.Enmity.SIRD
    sets.midcast.Cocoon = sets.Enmity.SIRD

    sets.midcast.Cure = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        -- neck = "Sacro Gorget",
        -- ear1 = "Tuisto Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        body = gear.souv_body,
        -- hands = "Regal Gauntlets",
        ring1 = "Apeile Ring +1",
        ring2 = "Murky Ring", -- Defending Ring
        back = gear.rudianos_cure_back,
        waist = "Audumbla Sash",
        legs = "Founder's Hose",
        feet = gear.odyssean_greaves_cure,
    }

    sets.midcast.Cure.SIRD = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        -- neck = "Sacro Gorget",
        -- ear1 = "Tuisto Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        body = gear.souv_body,
        -- hands = "Regal Gauntlets",
        ring1 = "Apeile Ring +1",
        ring2 = "Murky Ring", -- Defending Ring
        back = gear.rudianos_cure_back,
        waist = "Audumbla Sash",
        legs = "Founder's Hose",
        feet = gear.odyssean_greaves_cure,
    }
    sets.midcast.Cure.DT = sets.midcast.Cure

    sets.midcast.Reprisal = {
        main = "Sakpata's Sword",
        sub = "Priwen",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = gear.af1_body,
        hands = gear.souv_hands_c,
        ring1 = { name = "Moonlight Ring", bag = "Wardrobe" },
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.rudianos_enmity_back,
        waist = "Flume Belt +1",
        legs = "Nyame Flanchard",
        feet = gear.souv_feet
    }

    sets.HPDown = {
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        ring1 = "Murky Ring",
        ring2 = "Shadow Ring",
        back = gear.rudianos_enmity_back,
        waist = "Carrier's Sash",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings"
    }

    sets.Self_Healing = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Unmoving Collar +1",
        -- ear1 = "Tuisto Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        body = gear.souv_body,
        -- hands = "Regal Gauntlets",
        ring1 = "Gelatinous Ring +1",
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = "Moonlight Cape",
        waist = "Plat. Mog. Belt",
        legs = "Founder's Hose",
        feet = gear.odyssean_greaves_cure,
    }

    sets.Self_Healing.SIRD = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Unmoving Collar +1",
        -- ear1 = "Tuisto Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        body = gear.souv_body,
        -- hands = "Regal Gauntlets",
        ring1 = "Gelatinous Ring +1",
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = "Moonlight Cape",
        waist = "Plat. Mog. Belt",
        legs = "Founder's Hose",
        feet = gear.odyssean_greaves_cure,
    }
    sets.Self_Healing.DT = sets.Self_Healing

    sets.HPCure = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Unmoving Collar +1",
        -- ear1 = "Tuisto Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        body = gear.souv_body,
        hands = gear.souv_hands_c,
        ring1 = "Gelatinous Ring +1",
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = "Moonlight Cape",
        waist = "Plat. Mog. Belt",
        legs = "Founder's Hose",
        feet = gear.souv_feet,
    }

    sets.Cure_Received = { hands = gear.souv_hands_c, feet = gear.souv_feet }
    sets.Self_Refresh = { waist = "Gishdubar Sash" }
    sets.Enhancing_Received = {}

    sets.midcast['Enhancing Magic'] = {
        -- body = "Shab. Cuirass +1",
    }

    sets.midcast['Enhancing Magic'].SIRD = {
        -- body = "Shab. Cuirass +1",
    }

    sets.midcast.Enlight = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        -- head = "Jumalik Helm",
        neck = "Unmoving Collar +1",
        ear1 = "Etiolation Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        body = gear.af1_body, -- Rev. Surcoat +4
        -- hands = "Eschite Gauntlets",
        -- ring1 = "Fortified Ring",
        ring2 = "Gelatinous Ring +1",
        back = gear.rudianos_enmity_back,
        -- waist = "Asklepian Belt",
        legs = gear.af3_legs, -- Chev. Cuisses +3
        feet = gear.af3_feet, -- Chev. Sabatons +3
    }
    sets.midcast['Enlight II'] = sets.midcast.Enlight

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { neck = "Nodens Gorget", waist = "Olympus Sash" })

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })

    sets.midcast.Phalanx = {
        main = "Sakpata's Sword",
        sub = "Priwen",
        ammo = "Crepuscular Pebble",
        -- head = "Odyssean Helm", -- Target augment: Phalanx +5
        neck = "Hoxne Torque",
        ear1 = "Mimir Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        body = "Sworn Platemail",
        hands = gear.souv_hands_c,
        ring1 = "Murky Ring",
        -- ring2 = "Fortified Ring",
        back = gear.phalanx_jse_back,
        waist = "Flume Belt +1",
        legs = "Sakpata's Cuisses",
        feet = gear.souv_feet,
    }
    sets.midcast.Phalanx.SIRD = set_combine(sets.midcast.Phalanx, {
        main = "Burtgang",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Moonlight Necklace",
        ear1 = gear.jse_ear2, -- Chev. Earring +1
        ear2 = "Mimir Earring",
        body = gear.af3_body, -- Chev. Cuirass +3
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Murky Ring",
        waist = "Audumbla Sash",
        feet = gear.odyssean_greaves_phalanx,
    })
    sets.Phalanx_Received = {
        main = "Sakpata's Sword",
        hands = gear.souv_hands_c,
        back = gear.phalanx_jse_back,
        legs = "Sakpata's Cuisses",
        feet = gear.souv_feet
    }
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.resting = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Adamantite Armor",
        hands = gear.souv_hands_c,
        ring1 = "Murky Ring",
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.rudianos_enmity_back,
        waist = "Eschan Stone",
        legs = "Nyame Flanchard",
        feet = gear.af2_feet
    }

    -- Idle sets
    sets.idle = {
        -- main = "Burtgang",
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head, -- Chev. Armet +3
        neck = "Kgt. Beads +2",
        ear1 = gear.jse_ear2, -- Chev. Earring +1
        -- ear2 = "Odnowa Earring +1",
        ear2 = "Ethereal Earring",
        body = "Adamantite Armor",
        hands = gear.af3_hands, -- Chev. Gauntlets +3
        -- ring1 = "Fortified Ring",
        ring1 = "Murky Ring",
        ring2 = "Gelatinous Ring +1",
        back = gear.rudianos_enmity_back,
        waist = "Null Belt",
        legs = gear.af3_legs, -- Chev. Cuisses +3
        feet = gear.af3_feet, -- Chev. Sabatons +3
    }

    sets.idle.PDT = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = { name = "Staunch Tathlum +1", priority = 8 },
        head = { name = gear.af3_head, priority = 12 }, -- Chev. Armet +3
        neck = { name = "Kgt. Beads +2", priority = 10 },
        ear1 = { name = gear.jse_ear2, priority = 6 }, -- Chev. Earring +1
        -- ear2 = { name = "Odnowa Earring +1", priority = 11 },
        body = { name = gear.af3_body, priority = 13 }, -- Chev. Cuirass +3
        hands = { name = gear.af3_hands, priority = 2 }, -- Chev. Gauntlets +3
        -- ring1 = { name = "Fortified Ring", priority = 5 },
        ring2 = { name = "Gelatinous Ring +1", priority = 4 },
        back = {
            name = "Rudianos's Mantle",
            augments = { 'VIT+20', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
                'Phys. dmg. taken-10%', },
            priority = 3,
        },
        waist = { name = "Null Belt", priority = 7 },
        legs = { name = gear.af3_legs, priority = 9 }, -- Chev. Cuisses +3
        feet = { name = gear.af3_feet, priority = 1 }, -- Chev. Sabatons +3
    }

    sets.idle.Block = {
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head,
        neck = "Loricate Torque +1",
        ear1 = "Ethereal Earring",
        ear2 = "Sanare Earring",
        body = "Sakpata's Plate",
        hands = gear.souv_hands_d,
        ring1 = { name = "Moonlight Ring", bag = "Wardrobe" },
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.rudianos_enmity_back,
        waist = "Flume Belt +1",
        legs = "Sakpata's Cuisses",
        feet = gear.souv_feet
    }

    sets.idle.MDT = {
        -- main = "Burtgang",
        sub = "Aegis",
        ammo = "Staunch Tathlum +1",
        head = "Sakpata's Helm",
        neck = "Moonlight Necklace",
        -- ear1 = "Tuisto Earring",
        ear2 = "Eabani Earring",
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        ring1 = "Gelatinous Ring +1",
        ring2 = "Purity Ring",
        back = gear.rudianos_enmity_back,
        waist = "Carrier's Sash",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings"
    }

    sets.idle.Tank = {
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head,
        neck = "Warder's Charm +1",
        ear1 = "Ethereal Earring",
        ear2 = "Sanare Earring",
        body = "Sakpata's Plate",
        hands = gear.souv_hands_d,
        ring1 = { name = "Moonlight Ring", bag = "Wardrobe" },
        ring2 = "Shadow Ring",
        back = gear.rudianos_enmity_back,
        waist = "Flume Belt +1",
        legs = gear.af3_legs,
        feet = gear.souv_feet
    }

    sets.idle.Kiting = { ring2 = "Shneddick Ring" }

    sets.idle.XP = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = { name = "Staunch Tathlum +1", priority = 8 },
        head = { name = gear.af3_head, priority = 12 }, -- Chev. Armet +3
        neck = { name = "Kgt. Beads +2", priority = 10 },
        -- ear1 = { name = "Odnowa Earring +1", priority = 11 },
        ear2 = { name = gear.jse_ear2, priority = 6 }, -- Chev. Earring +1
        body = { name = gear.af3_body, priority = 13 }, -- Chev. Cuirass +3
        hands = { name = gear.af3_hands, priority = 2 }, -- Chev. Gauntlets +3
        -- ring1 = { name = "Fortified Ring", priority = 5 },
        ring2 = { name = "Gelatinous Ring +1", priority = 4 },
        back = {
            name = "Rudianos's Mantle",
            augments = { 'VIT+20', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
                'Phys. dmg. taken-10%', },
            priority = 3,
        },
        -- waist = { name = "Asklepian Belt", priority = 7 },
        legs = { name = gear.af3_legs, priority = 9 }, -- Chev. Cuisses +3
        feet = { name = gear.af3_feet, priority = 1 }, -- Chev. Sabatons +3
    }

    sets.idle.Refresh = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head, -- Chev. Armet +3
        neck = "Kgt. Beads +2",
        ear1 = "Etiolation Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        body = gear.af1_body, -- Rev. Surcoat +4
        -- hands = "Regal Gauntlets",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = gear.rudianos_enmity_back,
        waist = "Plat. Mog. Belt",
        legs = gear.af3_legs, -- Chev. Cuisses +3
        feet = gear.af3_feet, -- Chev. Sabatons +3
    }

    sets.idle.Town = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head, -- Chev. Armet +3
        neck = "Kgt. Beads +2",
        ear1 = "Etiolation Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        body = gear.af1_body, -- Rev. Surcoat +4
        -- hands = "Regal Gauntlets",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = gear.rudianos_enmity_back,
        waist = "Plat. Mog. Belt",
        legs = gear.af3_legs, -- Chev. Cuisses +3
        feet = gear.af3_feet, -- Chev. Sabatons +3
    }

    sets.Kiting = { ring2 = "Shneddick Ring" }

    sets.latent_refresh = { waist = "Eschan Stone" }
    sets.latent_refresh_grip = { sub = "Sacro Bulwark" }
    sets.latent_regen = { ring1 = { name = "Moonlight Ring", bag = "Wardrobe" }, ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" } }
    sets.DayIdle = {}
    sets.NightIdle = {}

    --------------------------------------
    -- Defense sets
    --------------------------------------

    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {}
    sets.MP = {
        head = gear.af3_head,
        neck = "Loricate Torque +1",
        hands = "Nyame Gauntlets",
        ear2 = "Ethereal Earring",
        ring2 = "Mephitas's Ring +1",
        waist = "Flume Belt +1",
        feet = "Nyame Sollerets"
    }
    sets.passive.AbsorbMP = {
        head = gear.af3_head,
        neck = "Loricate Torque +1",
        ear2 = "Ethereal Earring",
        waist = "Flume Belt +1",
        feet = "Nyame Sollerets"
    }
    sets.MP_Knockback = {}
    sets.Twilight = { head = "Nyame Helm", body = "Adamantite Armor" }
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

    -- Weapons sets
    sets.weapons.ExcaliburDuban = { main = "Excalibur", sub = "Duban" }
    sets.weapons.ExcaliburAegis = { main = "Excalibur", sub = "Aegis" }
    sets.weapons.ExcaliburBlurred = { main = "Excalibur", sub = "Blurred Shield +1" }
    sets.weapons.NaeglingDuban = { main = "Naegling", sub = "Duban" }
    sets.weapons.NaeglingAegis = { main = "Naegling", sub = "Aegis" }
    sets.weapons.BurtgangDuban = { main = "Burtgang", sub = "Duban" }
    sets.weapons.BurtgangAegis = { main = "Burtgang", sub = "Aegis" }
    sets.weapons.DualWeapons = { main = "Naegling", sub = gear.tp_bonus_sword }

    sets.defense.Block = {
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head,
        neck = "Loricate Torque +1",
        ear1 = "Ethereal Earring",
        ear2 = "Sanare Earring",
        body = "Sakpata's Plate",
        hands = gear.souv_hands_d,
        ring1 = "Murky Ring",
        ring2 = "Shadow Ring",
        back = gear.rudianos_enmity_back,
        waist = "Flume Belt +1",
        legs = "Sakpata's Cuisses",
        feet = gear.souv_feet
    }

    sets.defense.PDT = sets.idle.PDT
    sets.defense.MDT = sets.idle.MDT

    sets.defense.MEVA = {
        main = "Sakpata's Sword",
        sub = "Aegis",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Adamantite Armor",
        hands = "Nyame Gauntlets",
        ring1 = "Purity Ring",
        ring2 = "Shadow Ring",
        back = gear.rudianos_enmity_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.PDT_Reraise = set_combine(sets.defense.PDT, sets.Twilight)
    sets.defense.MDT_Reraise = set_combine(sets.defense.MDT, sets.Twilight)

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Aurgelmir Orb +1",
        head = "Hjarrandi Helm",
        neck = "Unmoving Collar +1",
        ear1 = "Crep. Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        -- body = "Crepuscular Mail",
        hands = "Sakpata's Gauntlets",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.rudianos_enmity_back,
        waist = "Sailfi Belt +1",
        legs = gear.af3_legs, -- Chev. Cuisses +3
        feet = "Sakpata's Leggings"
    }

    sets.engaged.Acc = {
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Coiste Bodhar",
        head = "Flam. Zucchetto +2",
        neck = "Null Loop",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
        body = "Nyame Mail",
        hands = "Sakpata's Gauntlets",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.engaged.XP = {
        -- main = "Malevolence",
        sub = "Duban",
        ammo = { name = "Staunch Tathlum +1", priority = 8 },
        head = { name = gear.af3_head, priority = 12 }, -- Chev. Armet +3
        neck = { name = "Kgt. Beads +2", priority = 10 },
        -- ear1 = { name = "Odnowa Earring +1", priority = 11 },
        ear2 = { name = gear.jse_ear2, priority = 6 }, -- Chev. Earring +1
        body = { name = gear.af3_body, priority = 13 }, -- Chev. Cuirass +3
        hands = { name = gear.af3_hands, priority = 2 }, -- Chev. Gauntlets +3
        -- ring1 = { name = "Fortified Ring", priority = 5 },
        ring2 = { name = "Gelatinous Ring +1", priority = 4 },
        back = {
            name = "Rudianos's Mantle",
            augments = { 'VIT+20', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
                'Phys. dmg. taken-10%', },
            priority = 3,
        },
        -- waist = { name = "Asklepian Belt", priority = 7 },
        legs = { name = gear.af3_legs, priority = 9 }, -- Chev. Cuisses +3
        feet = { name = gear.af3_feet, priority = 1 }, -- Chev. Sabatons +3
    }

    sets.engaged.ExcaliburBlurred = set_combine(sets.engaged, {
        main = "Excalibur",
        sub = "Blurred Shield +1",
        body = "Flamma Korazin +2",
        hands = "Flam. Manopolas +2",
        legs = "Flamma Dirs +2",
    })
    sets.engaged.ExcaliburBlurred.Acc = set_combine(sets.engaged.Acc, {
        main = "Excalibur",
        sub = "Blurred Shield +1",
        body = "Flamma Korazin +2",
        hands = "Flam. Manopolas +2",
        legs = "Flamma Dirs +2",
    })

    sets.engaged.DW = {}

    sets.engaged.DW.Acc = {}

    sets.engaged.Tank = {
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head,
        neck = "Loricate Torque +1",
        ear1 = "Ethereal Earring",
        ear2 = "Sanare Earring",
        body = "Sakpata's Plate",
        hands = gear.souv_hands_d,
        ring1 = "Murky Ring",
        ring2 = "Shadow Ring",
        back = gear.rudianos_enmity_back,
        waist = "Flume Belt +1",
        legs = gear.af3_legs,
        feet = gear.souv_feet
    }

    sets.engaged.Tp = set_combine(sets.engaged.Tank, {
        ammo = "Coiste Bodhar",
        neck = "Rep. Plat. Medal",
        ear1 = "Cessance Earring",
        ear2 = "Brutal Earring",
        body = "Nyame Mail",
        hands = "Sakpata's Gauntlets",
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    })

    sets.engaged.DDTank = {
        ammo = "Coiste Bodhar",
        head = "Sakpata's Helm",
        neck = "Loricate Torque +1",
        ear1 = "Brutal Earring",
        ear2 = "Cessance Earring",
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        ring1 = "Murky Ring",
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = gear.phalanx_jse_back,
        waist = "Sailfi Belt +1",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings"
    }

    sets.engaged.Acc.DDTank = {
        ammo = "Coiste Bodhar",
        head = "Sakpata's Helm",
        neck = "Loricate Torque +1",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        ring1 = "Murky Ring",
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = gear.phalanx_jse_back,
        waist = "Sailfi Belt +1",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings"
    }

    sets.engaged.NoShellTank = {
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Sanare Earring",
        ear2 = "Etiolation Earring",
        body = gear.af1_body,
        hands = "Sakpata's Gauntlets",
        ring1 = "Murky Ring",
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.rudianos_enmity_back,
        waist = "Flume Belt +1",
        legs = "Nyame Flanchard",
        feet = gear.af2_feet
    }

    sets.Reraise = sets.Twilight
    sets.engaged.Acc.Tank = sets.engaged.Tank
    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc.Tank, sets.Reraise)

    --------------------------------------
    -- Custom buff sets
    --------------------------------------
    sets.buff.Doom = {
        neck = "Nicander's Necklace",
        ring1 = "Purity Ring",
        ring2 = "Blenmot's Ring +1",
        waist = "Gishdubar Sash"
    }
    sets.buff.Sleep = { neck = "Loricate Torque +1" }
    sets.buff.Cover = { body = gear.af1_body }
    sets.buff.Reprisal = { sub = "Priwen" }
end

local function add_priwen_when_reprisal(baseSet)
    if buffactive['Reprisal'] and sets.buff.Reprisal and not (state.CombatForm and state.CombatForm.value == 'DW') then
        if baseSet and baseSet.sub == "Srivatsa" then
            return baseSet
        end

        return set_combine(baseSet, sets.buff.Reprisal)
    end

    return baseSet
end

function job_customize_idle_set(idleSet)
    return add_priwen_when_reprisal(idleSet)
end

function job_customize_melee_set(meleeSet)
    return add_priwen_when_reprisal(meleeSet)
end

function job_customize_defense_set(defenseSet)
    return add_priwen_when_reprisal(defenseSet)
end

function user_job_lockstyle()
    windower.chat.input('/lockstyleset 188')
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(19, 1)
    elseif player.sub_job == 'RUN' then
        set_macro_page(19, 1)
    elseif player.sub_job == 'RDM' then
        set_macro_page(19, 1)
    elseif player.sub_job == 'BLU' then
        set_macro_page(19, 1)
    elseif player.sub_job == 'DNC' then
        set_macro_page(19, 1)
    else
        set_macro_page(19, 1) --War/Etc
    end
end

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end

    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
            player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Duban' and
            player.equipment.sub ~= 'Sacro Bulwark' and
            player.equipment.sub ~= 'Svalinn' and player.equipment.sub ~= 'Priwen' and
            player.equipment.sub ~= 'Srivatsa' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end
