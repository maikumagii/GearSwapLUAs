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

    gear.rudianos_enmity_block_back = {
        name = "Rudianos's Mantle",
        augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
            'Chance of successful block +5', }
    }
    gear.phalanx_jse_back = {
        name = "Weard Mantle",
        augments = { 'DEX+2', 'VIT+2', 'Enmity+4', '"Phalanx" received +4' }
    }
    gear.fastcast_jse_back = "Null Shawl"              -- Rudianos's Mantle: INT+20, Eva./MEVA, Fast Cast+10
    gear.enmity_jse_back = gear.rudianos_enmity_block_back
    gear.jse_ear2 = "Chev. Earring +1"

    -- Guide missing gear
    gear.guide_missing = {
        apeile_ring = "Apeile Ring",                         -- 2
        apeile_ring_1 = "Apeile Ring +1",                    -- 5
        asklepian_belt = "Asklepian Belt",                   -- 3
        audumbla_sash = "Audumbla Sash",                     -- 3
        baetyl_pendant = "Baetyl Pendant",                   -- 1
        blenmots_ring_1 = "Blenmot's Ring +1",               -- 1
        burtgang = "Burtgang",                               -- 22
        cab_breeches_3 = "Cab. Breeches +3",                 -- 1
        cab_leggings_3 = "Cab. Leggings +3",                 -- 1
        cab_surcoat_3 = "Cab. Surcoat +3",                   -- 2
        carmine_cuisses_1 = "Carmine Cuisses +1",            -- 2
        carriers_sash = "Carrier's Sash",                    -- 1
        chev_armet_3 = "Chev. Armet +3",                     -- 5
        chev_cuirass_3 = "Chev. Cuirass +3",                 -- 4
        chev_cuisses_3 = "Chev. Cuisses +3",                 -- 5
        chev_gauntlets_3 = "Chev. Gauntlets +3",             -- 3
        chev_sabatons_3 = "Chev. Sabatons +3",               -- 13
        coatl_gorget_1 = "Coatl Gorget +1",                  -- 2
        cornelias_ring = "Cornelia's Ring",                  -- 3
        creed_baudrier = "Creed Baudrier",                   -- 3
        crematio_earring = "Crematio Earring",               -- 1
        crepuscular_mail = "Crepuscular Mail",               -- 1
        cryptic_earring = "Cryptic Earring",                 -- 2
        defending_ring = "Defending Ring",                   -- 4
        enchntr_earring_1 = "Enchntr. Earring +1",           -- 4
        eschite_gauntlets = "Eschite Gauntlets",             -- 1
        fenian_ring = "Fenian Ring",                         -- 1
        fortified_ring = "Fortified Ring",                   -- 4
        founders_hose = "Founder's Hose",                    -- 5
        gelatinous_ring_1 = "Gelatinous Ring +1",            -- 10
        jumalik_helm = "Jumalik Helm",                       -- 1
        jumalik_mail = "Jumalik Mail",                       -- 2
        kgt_beads_2 = "Kgt. Beads +2",                       -- 4
        knightly_earring = "Knightly Earring",               -- 1
        leyline_gloves = "Leyline Gloves",                   -- 4
        loess_barbuta_1 = "Loess Barbuta +1",                -- 3
        malevolence = "Malevolence",                         -- 2
        melic_torque = "Melic Torque",                       -- 1
        moonlight_cape = "Moonlight Cape",                   -- 4
        odnowa_earring_1 = "Odnowa Earring +1",              -- 4
        odyss_chestplate = "Odyss. Chestplate",              -- 1, Phalanx +5
        odyssean_greaves = "Odyssean Greaves",               -- 6, Phalanx +5; SIRD +11 only via DM
        odyssean_helm = "Odyssean Helm",                     -- 1, Phalanx +5
        orunmilas_torque = "Orunmila's Torque",              -- 4
        regal_gauntlets = "Regal Gauntlets",                 -- 6
        rev_coronet_3 = "Rev. Coronet +3",                   -- 1
        rev_leggings_3 = "Rev. Leggings +3",                 -- 1
        rev_surcoat_4 = "Rev. Surcoat +4",                   -- 4
        sacro_gorget = "Sacro Gorget",                       -- 2
        sapience_orb = "Sapience Orb",                       -- 6
        save_the_queen_iii = "Save the Queen III",           -- 1
        shab_cuirass_1 = "Shab. Cuirass +1",                 -- 2
        souv_diechlings_1 = "Souv. Diechlings +1",           -- 2
        souveran_schuhs_1 = "Souveran Schuhs +1",            -- 1
        trux_earring = "Trux Earring",                       -- 3
        tuisto_earring = "Tuisto Earring",                   -- 6
        unmoving_collar_1 = "Unmoving Collar +1",            -- 4
    }

    -- Artifact Gear
    gear.af1_head = "" -- Rev. Coronet +3
    gear.af1_body = "Rev. Surcoat +3"
    gear.af1_hands = ""
    gear.af1_legs = ""
    gear.af1_feet = "" -- Rev. Leggings +3

    -- Relic Gear
    gear.af2_head = "Cab. Coronet +3"
    gear.af2_body = "Cab. Surcoat +1" -- Cab. Surcoat +4
    gear.af2_hands = "Cab. Gauntlets +3"
    gear.af2_legs = "Cab. Breeches +1" -- Cab. Breeches +4
    gear.af2_feet = "Cab. Leggings +1" -- Cab. Leggings +3


    -- Empy Gear
    gear.af3_head = "" -- Chev. Armet +1
    gear.af3_body = ""
    gear.af3_hands = ""
    gear.af3_legs = "" -- Chev. Cuisses +1
    gear.af3_feet = "" -- Chev. Sabatons +1

    -- Owned fallbacks for older PLD set pieces.
    gear.rev_leggings_fallback = "Nyame Sollerets"       -- Rev. Leggings +3
    gear.chev_armet_fallback = "Nyame Helm"              -- Chev. Armet +1
    gear.chev_cuisses_fallback = "Nyame Flanchard"       -- Chev. Cuisses +1
    gear.deacon_sword = "Sakpata's Sword"                               -- Deacon Sword
    -- No owned PLD-legal club is tracked yet; Mafic Cudgel remains the target.
    gear.srivatsa = "Srivatsa"
    gear.fc_shield = "Sacro Bulwark"                                    -- Chanter's Shield
    gear.fc_head = "Nyame Helm"                                         -- Carmine Mask +1
    gear.fc_hands = "Nyame Gauntlets"                                   -- Leyline Gloves
    gear.fc_legs = "Nyame Flanchard"                                    -- Odyssean FC legs
    gear.fc_feet = "Nyame Sollerets"                                    -- Odyssean Greaves
    gear.enhancing_main = "Sakpata's Sword"                             -- Colada
    gear.enhancing_body = "Nyame Mail"                                  -- Shab. Cuirass +1
    gear.enhancing_hands = "Nyame Gauntlets"                            -- Regal Gauntlets
    gear.enhancing_back = "Null Shawl"                                  -- Merciful Cape
    gear.souv_head = { name = "Souv. Schaller +1", augments = { 'HP+105', 'Enmity+9', '"Cure" effect received +15%', } } -- Path C
    gear.souv_body = { name = "Souv. Cuirass +1", augments = { 'HP+105', 'Enmity+9', '"Cure" effect received +15%', } }  -- Path C
    gear.souv_hands_c = { name = "Souv. Handsch. +1", augments = { 'HP+105', 'Enmity+9', '"Cure" effect received +15%', } }
    gear.souv_hands_d = { name = "Souv. Handsch. +1", augments = { 'HP+65', 'Shield Skill +15', 'Physical Damage Taken-4%', } }
    gear.souv_hands = gear.souv_hands_c
    gear.souv_block_hands = gear.souv_hands_d
    gear.souv_legs = "Nyame Flanchard"                                  -- Souv. Diechlings +1
    gear.souv_feet = "Nyame Sollerets"                                  -- Souveran Schuhs +1
    gear.enmity_head = "Nyame Helm"                                     -- Loess Barbuta +1
    gear.enmity_hands = "Sakpata's Gauntlets"                           -- Macabre Gaunt. +1
    gear.enmity_feet = "Nyame Sollerets"                                -- Eschite Greaves
    gear.enmity_neck = "Moonlight Necklace"
    gear.elite_royal_collar = "Elite Royal Collar"
    gear.dt_neck = "Loricate Torque +1"                                 -- Unmoving Collar +1
    gear.block_neck = "Loricate Torque +1"                              -- Diemer Gorget
    gear.idle_neck = "Loricate Torque +1"                               -- Coatl Gorget +1
    gear.enmity_ear2 = gear.jse_ear2                                    -- Trux Earring
    gear.dt_ear1 = "Etiolation Earring"                                 -- Odnowa Earring +1
    gear.dt_ear2 = "Sanare Earring"                                     -- Tuisto Earring
    gear.block_ear1 = "Ethereal Earring"                                -- Creed Earring
    gear.block_ear2 = "Sanare Earring"                                  -- Thureous Earring
    gear.acc_ear1 = "Crep. Earring"                                     -- Mache Earring +1
    gear.macc_ear1 = "Crep. Earring"                                    -- Gwati Earring
    gear.macc_ear2 = "Alabaster Earring"                                -- Digni. Earring
    gear.defending_ring = { name = "Moonlight Ring", bag = "Wardrobe" } -- Defending Ring
    gear.enmity_ring1 = { name = "Moonlight Ring", bag = "Wardrobe" }   -- Apeile Ring +1
    gear.enmity_ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" } -- Apeile Ring
    gear.dt_ring1 = { name = "Moonlight Ring", bag = "Wardrobe" }       -- Gelatinous Ring +1
    gear.dt_ring2 = "Shadow Ring"                                       -- Warden's Ring / Shadow Ring
    gear.ws_ring1 = "Sroda Ring"                                        -- Regal Ring
    gear.ws_ring2 = gear.tvr_ring                                   -- Rufescent Ring
    gear.tp_ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" }      -- Flamma Ring / Ramuh Ring +1
    gear.tp_ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" }    -- Petrov Ring / Ramuh Ring +1 / Patricius Ring
    gear.waltz_ring1 = "Menelaus's Ring"                                -- Asklepian Ring
    gear.waltz_ring2 = "Naji's Loop"                                    -- Valseur's Ring
    gear.valorous_wsd_body = "Nyame Mail"                               -- Valorous Mail WSD
    gear.odyssean_wsd_hands = "Nyame Gauntlets"                         -- Odyssean Gauntlets WSD
    gear.odyssean_fc_legs = gear.fc_legs
    gear.ws_back = "Null Shawl"           -- Bleating Mantle / Ground. Mantle +1 / Toro Cape
    gear.tank_back = gear.rudianos_enmity_block_back
    gear.carmine_legs = "Nyame Flanchard" -- Carmine Cuisses +1
    gear.carmine_feet = "Nyame Sollerets" -- Carmine Greaves +1 / Hippo. Socks +1
    gear.sulevia_legs = "Nyame Flanchard" -- Sulev. Cuisses +2
    gear.sulevia_feet = "Nyame Sollerets" -- Sulev. Leggings +2
    gear.reraise_head = "Nyame Helm"      -- Twilight Helm
    gear.reraise_body = "Adamantite Armor" -- Twilight Mail

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
        -- ear2 = { name = "Cryptic Earring", priority = 12 },
        body = { name = "Souv. Cuirass +1", augments = { 'HP+105', 'Enmity+9', '"Cure" effect received +15%', }, priority = 1 },
        hands = { name = "Souv. Handsch. +1", augments = { 'HP+105', 'Enmity+9', '"Cure" effect received +15%', }, priority = 13 },
        -- ring1 = { name = "Apeile Ring +1", priority = 6 },
        -- ring2 = { name = "Apeile Ring", priority = 5 },
        back = {
            name = "Rudianos's Mantle",
            augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
                'Chance of successful block +5', },
            priority = 3,
        },
        -- waist = { name = "Creed Baudrier", priority = 9 },
        -- legs = { name = gear.souv_legs, priority = 2 }, -- Souv. Diechlings +1
        -- feet = { name = gear.af3_feet, priority = 4 }, -- Chev. Sabatons +3
    }

    sets.Enmity.SIRD = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = { name = "Staunch Tathlum +1", priority = 8 },
        -- head = { name = "Loess Barbuta +1", priority = 11 },
        neck = { name = "Moonlight Necklace", priority = 7 },
        -- ear1 = { name = "Odnowa Earring +1", priority = 12 },
        -- ear2 = { name = "Trux Earring", priority = 10 },
        -- body = { name = gear.af3_body, priority = 13 }, -- Chev. Cuirass +3
        hands = { name = "Souv. Handsch. +1", augments = { 'HP+105', 'Enmity+9', '"Cure" effect received +15%', }, priority = 13 },
        -- ring1 = { name = "Apeile Ring +1", priority = 6 },
        -- ring2 = { name = "Gelatinous Ring +1", priority = 5 },
        back = {
            name = "Rudianos's Mantle",
            augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
                'Chance of successful block +5', },
            priority = 3,
        },
        -- waist = { name = "Creed Baudrier", priority = 9 },
        -- legs = { name = "Founder's Hose", priority = 2 },
        -- feet = { name = "Odyssean Greaves", augments = { 'Phalanx +5' }, priority = 4 }, -- Native SIRD+20; SIRD+11 only via DM
    }

    sets.Enmity.DT = {
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = gear.dt_neck,
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = gear.af1_body,
        hands = gear.souv_hands,
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.souv_feet
    }

    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {
        -- legs = gear.af2_legs, -- Cab. Breeches +3
        legs = gear.af2_legs,
    }
    sets.precast.JA['Holy Circle'] = {
        -- feet = gear.af1_feet, -- Rev. Leggings +3
    }
    sets.precast.JA['Sentinel'] = {
        -- feet = gear.af2_feet, -- Cab. Leggings +3
        feet = gear.af2_feet,
    }
    sets.precast.JA['Rampart'] = {
        head = gear.af2_head,
    }
    sets.precast.JA['Fealty'] = {
        -- body = gear.af2_body, -- Cab. Surcoat +3
        body = gear.af2_body,
    }
    sets.precast.JA['Divine Emblem'] = {
        -- feet = gear.af3_feet, -- Chev. Sabatons +3
    }
    sets.precast.JA['Cover'] = {
        -- main = "Save the Queen III",
        -- head = gear.af1_head, -- Rev. Coronet +3
        -- body = gear.af2_body, -- Cab. Surcoat +3
        body = gear.af2_body,
    }

    sets.precast.JA['Invincible'].DT = sets.precast.JA['Invincible']
    sets.precast.JA['Holy Circle'].DT = sets.precast.JA['Holy Circle']
    sets.precast.JA['Sentinel'].DT = sets.precast.JA['Sentinel']
    sets.precast.JA['Rampart'].DT = sets.precast.JA['Rampart']
    sets.precast.JA['Fealty'].DT = sets.precast.JA['Fealty']
    sets.precast.JA['Divine Emblem'].DT = sets.precast.JA['Divine Emblem']
    sets.precast.JA['Cover'].DT = sets.precast.JA['Cover']

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        hands = gear.af2_hands,
    }

    sets.precast.JA['Chivalry'].DT = sets.precast.JA['Chivalry']

    sets.precast.JA['Shield Bash'] = {
        sub = "Aegis",
        -- ear1 = "Knightly Earring",
        hands = gear.af2_hands,
        -- ring1 = "Fenian Ring",
    }
    sets.precast.JA['Provoke'] = sets.Enmity
    sets.precast.JA['Warcry'] = sets.Enmity
    sets.precast.JA['Palisade'] = sets.Enmity
    sets.precast.JA['Intervene'] = sets.Enmity
    sets.precast.JA['Defender'] = sets.Enmity
    sets.precast.JA['Berserk'] = sets.Enmity
    sets.precast.JA['Aggressor'] = sets.Enmity

    sets.precast.JA['Shield Bash'].DT = sets.precast.JA['Shield Bash']
    sets.precast.JA['Provoke'].DT = sets.Enmity.DT
    sets.precast.JA['Warcry'].DT = sets.Enmity.DT
    sets.precast.JA['Palisade'].DT = sets.Enmity.DT
    sets.precast.JA['Intervene'].DT = sets.Enmity.DT
    sets.precast.JA['Defender'].DT = sets.Enmity.DT
    sets.precast.JA['Berserk'].DT = sets.Enmity.DT
    sets.precast.JA['Aggressor'].DT = sets.Enmity.DT

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        ammo = "Aurgelmir Orb +1",
        head = "Nyame Helm",
        neck = gear.dt_neck,
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = gear.af1_body,
        hands = gear.enhancing_hands,
        ring1 = gear.waltz_ring1,
        ring2 = gear.waltz_ring2,
        back = gear.tank_back,
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
        ear1 = gear.acc_ear1,
        ear2 = "Telos Earring",
        body = "Flamma Korazin +2",
        hands = "Flam. Manopolas +2",
        ring1 = gear.tp_ring1,
        ring2 = gear.tp_ring2,
        back = gear.ws_back,
        waist = "Null Belt",
        legs = "Flamma Dirs +2",
        feet = "Flam. Gambieras +2"
    }

    sets.precast.JA['Violent Flourish'] = {
        ammo = "Aurgelmir Orb +1",
        head = "Flam. Zucchetto +2",
        neck = "Erra Pendant",
        ear1 = gear.macc_ear1,
        ear2 = gear.macc_ear2,
        body = "Flamma Korazin +2",
        hands = "Flam. Manopolas +2",
        ring1 = gear.defending_ring,
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        back = gear.ws_back,
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
        -- ear1 = { name = "Enchntr. Earring +1", priority = 1 },
        ear2 = { name = "Loquac. Earring", priority = 2 },
        -- body = { name = "Rev. Surcoat +4", priority = 13 },
        -- hands = { name = "Leyline Gloves", priority = 6 },
        ring1 = "Kishar Ring",
        ring2 = { name = "Prolix Ring", priority = 7 },
        back = {
            name = "Rudianos's Mantle",
            augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
                'Chance of successful block +5', },
            priority = 12,
        },
        waist = { name = "Plat. Mog. Belt", priority = 8 },
        legs = { name = "Sworn Brais", priority = 11 },
        -- feet = { name = gear.af3_feet, priority = 9 }, -- Chev. Sabatons +3
    }

    sets.precast.FC.DT = {
        -- main = "Burtgang",
        sub = "Duban",
        -- ammo = { name = "Sapience Orb", priority = 10 },
        head = { name = "Carmine Mask +1", priority = 3 },
        -- neck = { name = "Orunmila's Torque", priority = 5 },
        -- ear1 = { name = "Enchntr. Earring +1", priority = 1 },
        ear2 = { name = "Loquac. Earring", priority = 2 },
        -- body = { name = "Rev. Surcoat +4", priority = 13 },
        -- hands = { name = "Leyline Gloves", priority = 6 },
        ring1 = "Kishar Ring",
        ring2 = { name = "Prolix Ring", priority = 7 },
        back = {
            name = "Rudianos's Mantle",
            augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
                'Chance of successful block +5', },
            priority = 12,
        },
        waist = { name = "Plat. Mog. Belt", priority = 8 },
        legs = { name = "Sworn Brais", priority = 11 },
        -- feet = { name = gear.af3_feet, priority = 9 }, -- Chev. Sabatons +3
    }

    sets.precast.FC['Enhancing Magic'] = {
        -- main = "Burtgang",
        sub = "Duban",
        -- ammo = { name = "Sapience Orb", priority = 10 },
        head = { name = "Carmine Mask +1", priority = 3 },
        -- neck = { name = "Orunmila's Torque", priority = 5 },
        -- ear1 = { name = "Enchntr. Earring +1", priority = 1 },
        ear2 = { name = "Loquac. Earring", priority = 2 },
        -- body = { name = "Rev. Surcoat +4", priority = 13 },
        -- hands = { name = "Leyline Gloves", priority = 6 },
        ring1 = "Kishar Ring",
        ring2 = { name = "Prolix Ring", priority = 7 },
        back = {
            name = "Rudianos's Mantle",
            augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
                'Chance of successful block +5', },
            priority = 12,
        },
        waist = { name = "Plat. Mog. Belt", priority = 8 },
        legs = { name = "Sworn Brais", priority = 11 },
        -- feet = { name = gear.af3_feet, priority = 9 }, -- Chev. Sabatons +3
    }
    sets.precast.FC['Enhancing Magic'].DT = sets.precast.FC['Enhancing Magic']

    sets.precast.FC.Cure = {
        -- main = "Burtgang",
        sub = "Duban",
        -- ammo = { name = "Sapience Orb", priority = 10 },
        head = { name = "Carmine Mask +1", priority = 3 },
        -- neck = { name = "Orunmila's Torque", priority = 5 },
        -- ear1 = { name = "Enchntr. Earring +1", priority = 1 },
        ear2 = { name = "Loquac. Earring", priority = 2 },
        -- body = { name = "Rev. Surcoat +4", priority = 13 },
        -- hands = { name = "Leyline Gloves", priority = 6 },
        ring1 = "Kishar Ring",
        ring2 = { name = "Prolix Ring", priority = 7 },
        back = {
            name = "Rudianos's Mantle",
            augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
                'Chance of successful block +5', },
            priority = 12,
        },
        waist = { name = "Plat. Mog. Belt", priority = 8 },
        legs = { name = "Sworn Brais", priority = 11 },
        -- feet = { name = gear.af3_feet, priority = 9 }, -- Chev. Sabatons +3
    }

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = "Aurgelmir Orb +1",
        head = "Nyame Helm",
        neck = "Rep. Plat. Medal",
        ear1 = "Cessance Earring",
        ear2 = "Brutal Earring",
        body = gear.valorous_wsd_body,
        hands = gear.odyssean_wsd_hands,
        ring1 = gear.ws_ring1,
        ring2 = gear.ws_ring2,
        back = gear.ws_back,
        waist = "Fotia Belt",
        legs = gear.sulevia_legs,
        feet = gear.sulevia_feet
    }

    sets.precast.WS.DT = {
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Loricate Torque +1",
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = gear.af1_body,
        hands = gear.souv_hands,
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.souv_feet
    }

    sets.precast.WS.Acc = {
        ammo = "Coiste Bodhar",
        head = "Hjarrandi Helm",
        neck = "Null Loop",
        ear1 = gear.acc_ear1,
        ear2 = "Telos Earring",
        body = gear.valorous_wsd_body,
        hands = "Sakpata's Gauntlets",
        ring1 = gear.tp_ring1,
        ring2 = gear.tp_ring2,
        back = gear.ws_back,
        waist = "Null Belt",
        legs = gear.carmine_legs,
        feet = gear.sulevia_feet
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,
        { neck = "Fotia Gorget", ear1 = "Brutal Earring", ear2 = "Moonshade Earring" })
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc,
        { neck = "Fotia Gorget", ear1 = gear.acc_ear1, ear2 = "Moonshade Earring" })

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS,
        { neck = "Fotia Gorget", ear1 = "Brutal Earring", ear2 = "Moonshade Earring" })
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc,
        { neck = "Fotia Gorget", ear1 = gear.acc_ear1, ear2 = "Moonshade Earring" })

    sets.precast.WS['Savage Blade'] = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Crepuscular Pebble",
        head = "Nyame Helm",
        -- neck = "Kgt. Beads +2",
        -- ear1 = "Tuisto Earring",
        ear2 = "Thrud Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        -- ring1 = "Cornelia's Ring",
        -- ring2 = "Gelatinous Ring +1",
        back = gear.tank_back, -- Rudianos's Mantle
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
        neck = "Null Loop",
        ear1 = gear.acc_ear1,
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
        body = gear.valorous_wsd_body,
        hands = gear.odyssean_wsd_hands,
        ring1 = gear.ws_ring1,
        ring2 = gear.ws_ring2,
        back = gear.ws_back,
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }
    sets.precast.WS['Knights of Round'].Acc = set_combine(sets.precast.WS['Knights of Round'], {
        neck = "Null Loop",
        ear1 = gear.acc_ear1,
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
        ear1 = gear.macc_ear1,
        ear2 = gear.macc_ear2,
        body = "Flamma Korazin +2",
        hands = "Flam. Manopolas +2",
        ring1 = gear.defending_ring,
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        back = gear.ws_back,
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
        -- ring1 = "Defending Ring",
        -- ring2 = "Cornelia's Ring",
        -- back = "Moonlight Cape",
        waist = "Orpheus's Sash",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.WS['Aeolian Edge'] = {
        -- main = "Malevolence",
        sub = "Duban",
        ammo = "Ghastly Tathlum +1",
        head = "Nyame Helm",
        -- neck = "Baetyl Pendant",
        ear1 = "Friomisi Earring",
        -- ear2 = "Crematio Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        -- ring1 = "Cornelia's Ring",
        -- ring2 = "Defending Ring",
        -- back = "Moonlight Cape",
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
        -- ear2 = "Cryptic Earring",
        body = gear.souv_body,
        hands = gear.souv_hands,
        -- ring1 = "Apeile Ring +1",
        -- ring2 = "Apeile Ring",
        back = gear.tank_back, -- Rudianos's Mantle
        -- waist = "Creed Baudrier",
        -- legs = gear.souv_legs, -- Souv. Diechlings +1
        -- feet = gear.af3_feet, -- Chev. Sabatons +3
    }
    sets.precast.WS['Atonement'].Acc = set_combine(sets.precast.WS['Atonement'], {
        neck = "Null Loop",
        ear1 = gear.acc_ear1,
        ear2 = "Telos Earring",
    })

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = { ear1 = "Cessance Earring", ear2 = "Brutal Earring", }
    sets.MaxTP['Aeolian Edge'] = { ear2 = gear.macc_ear2 }
    sets.AccMaxTP = { ear1 = gear.acc_ear1, ear2 = "Telos Earring" }


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        main = "Sakpata's Sword",
        sub = gear.fc_shield,
        ammo = "Impatiens",
        head = gear.fc_head,
        neck = "Voltsurge Torque",
        ear1 = "Etiolation Earring",
        ear2 = "Loquac. Earring",
        body = gear.af1_body,
        hands = gear.fc_hands,
        ring1 = gear.dt_ring1,
        ring2 = "Kishar Ring",
        back = gear.fastcast_jse_back,
        waist = "Flume Belt +1",
        legs = gear.odyssean_fc_legs,
        feet = gear.fc_feet
    }

    sets.midcast.FastRecast.DT = {
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Loricate Torque +1",
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = gear.af1_body,
        hands = gear.souv_hands,
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.souv_feet
    }

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
        -- ring1 = "Apeile Ring +1",
        -- ring2 = "Defending Ring",
        back = gear.tank_back, -- Rudianos's Mantle
        -- waist = "Audumbla Sash",
        -- legs = "Founder's Hose",
        -- feet = { name = "Odyssean Greaves", augments = { 'Phalanx +5' } }, -- Native SIRD+20; SIRD+11 only via DM
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
        -- ring1 = "Apeile Ring +1",
        -- ring2 = "Defending Ring",
        back = gear.tank_back, -- Rudianos's Mantle
        -- waist = "Audumbla Sash",
        -- legs = "Founder's Hose",
        -- feet = { name = "Odyssean Greaves", augments = { 'Phalanx +5' } }, -- Native SIRD+20; SIRD+11 only via DM
    }

    sets.midcast.Cure.DT = {
        main = gear.deacon_sword,
        sub = gear.srivatsa,
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Loricate Torque +1",
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = gear.af1_body,
        hands = gear.souv_hands,
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.souv_feet
    }

    sets.midcast.Reprisal = {
        main = "Sakpata's Sword",
        sub = "Priwen",
        ammo = "Staunch Tathlum +1",
        head = gear.enmity_head,
        neck = gear.dt_neck,
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = gear.af1_body,
        hands = gear.souv_hands,
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = "Nyame Flanchard",
        feet = gear.souv_feet
    }

    sets.Self_Healing = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        -- neck = "Unmoving Collar +1",
        -- ear1 = "Tuisto Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        body = gear.souv_body,
        -- hands = "Regal Gauntlets",
        -- ring1 = "Gelatinous Ring +1",
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        -- back = "Moonlight Cape",
        waist = "Plat. Mog. Belt",
        -- legs = "Founder's Hose",
        -- feet = { name = "Odyssean Greaves", augments = { 'Phalanx +5' } }, -- Native SIRD+20; SIRD+11 only via DM
    }

    sets.Self_Healing.SIRD = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        -- neck = "Unmoving Collar +1",
        -- ear1 = "Tuisto Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        body = gear.souv_body,
        -- hands = "Regal Gauntlets",
        -- ring1 = "Gelatinous Ring +1",
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        -- back = "Moonlight Cape",
        waist = "Plat. Mog. Belt",
        -- legs = "Founder's Hose",
        -- feet = { name = "Odyssean Greaves", augments = { 'Phalanx +5' } }, -- Native SIRD+20; SIRD+11 only via DM
    }

    sets.Self_Healing.DT = {
        main = gear.deacon_sword,
        sub = gear.srivatsa,
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Loricate Torque +1",
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = gear.af1_body,
        hands = gear.souv_hands,
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.souv_feet
    }

    sets.Cure_Received = { hands = gear.souv_hands, feet = gear.souv_feet }
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
        -- neck = "Unmoving Collar +1",
        ear1 = "Etiolation Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        body = gear.af1_body, -- Rev. Surcoat +3
        -- hands = "Eschite Gauntlets",
        -- ring1 = "Fortified Ring",
        -- ring2 = "Gelatinous Ring +1",
        back = gear.tank_back, -- Rudianos's Mantle
        -- waist = "Asklepian Belt",
        -- legs = gear.af3_legs, -- Chev. Cuisses +3
        -- feet = gear.af3_feet, -- Chev. Sabatons +3
    }
    sets.midcast['Enlight II'] = sets.midcast.Enlight

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { neck = "Nodens Gorget", waist = "Olympus Sash" })

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })

    sets.midcast.Phalanx = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Aurgelmir Orb +1",
        -- head = { name = "Odyssean Helm", augments = { 'Phalanx +5' } },
        -- neck = "Melic Torque",
        ear1 = "Mimir Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        -- body = { name = "Odyss. Chestplate", augments = { 'Phalanx +5' } },
        hands = gear.souv_hands,
        -- ring1 = "Gelatinous Ring +1",
        ring2 = "Murky Ring",
        back = "Weard Mantle",
        waist = "Flume Belt +1",
        legs = "Sakpata's Cuisses",
        -- feet = "Souveran Schuhs +1",
    }
    sets.midcast.Phalanx.SIRD = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Moonlight Necklace",
        ear1 = gear.jse_ear2, -- Chev. Earring +1
        ear2 = "Mimir Earring",
        -- body = gear.af3_body, -- Chev. Cuirass +3
        hands = gear.souv_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Murky Ring",
        back = "Weard Mantle",
        -- waist = "Audumbla Sash",
        legs = "Sakpata's Cuisses",
        -- feet = { name = "Odyssean Greaves", augments = { 'Phalanx +5' } }, -- Native SIRD+20; SIRD+11 only via DM
    }
    sets.midcast.Phalanx.DT = sets.midcast.Phalanx.SIRD

    sets.Phalanx_Received = {
        main = "Sakpata's Sword",
        hands = gear.souv_hands,
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
        neck = gear.idle_neck,
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Adamantite Armor",
        hands = gear.souv_hands,
        ring1 = gear.defending_ring,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Eschan Stone",
        legs = gear.sulevia_legs,
        feet = gear.af2_feet
    }

    -- Idle sets
    sets.idle = {
        main = "Sakpata's Sword",
        sub = gear.srivatsa,
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = gear.idle_neck,
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Adamantite Armor",
        hands = gear.enhancing_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.carmine_legs,
        feet = gear.carmine_feet
    }

    sets.idle.PDT = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = { name = "Staunch Tathlum +1", priority = 8 },
        -- head = { name = gear.af3_head, priority = 12 }, -- Chev. Armet +3
        -- neck = { name = "Kgt. Beads +2", priority = 10 },
        ear1 = { name = gear.jse_ear2, priority = 6 }, -- Chev. Earring +1
        -- ear2 = { name = "Odnowa Earring +1", priority = 11 },
        body = { name = "Adamantite Armor", priority = 13 },
        -- hands = { name = gear.af3_hands, priority = 2 }, -- Chev. Gauntlets +3
        -- ring1 = { name = "Fortified Ring", priority = 5 },
        -- ring2 = { name = "Gelatinous Ring +1", priority = 4 },
        back = {
            name = "Rudianos's Mantle",
            augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
                'Chance of successful block +5', },
            priority = 3,
        },
        waist = { name = "Null Belt", priority = 7 },
        -- legs = { name = gear.af3_legs, priority = 9 }, -- Chev. Cuisses +3
        -- feet = { name = gear.af3_feet, priority = 1 }, -- Chev. Sabatons +3
    }

    sets.idle.Block = {
        main = gear.deacon_sword,
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.chev_armet_fallback,
        neck = gear.block_neck,
        ear1 = gear.block_ear1,
        ear2 = gear.block_ear2,
        body = "Sakpata's Plate",
        hands = gear.souv_block_hands,
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
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
        -- ring1 = "Gelatinous Ring +1",
        ring2 = "Purity Ring",
        back = gear.tank_back, -- Rudianos's Mantle
        -- waist = "Carrier's Sash",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings"
    }

    sets.idle.Tank = {
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.chev_armet_fallback,
        neck = "Warder's Charm +1",
        ear1 = gear.block_ear1,
        ear2 = gear.block_ear2,
        body = "Sakpata's Plate",
        hands = gear.souv_block_hands,
        ring1 = gear.dt_ring1,
        ring2 = gear.dt_ring2,
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.chev_cuisses_fallback,
        feet = gear.souv_feet
    }

    sets.idle.Kiting = { ring2 = "Shneddick Ring" }

    sets.idle.XP = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = { name = "Staunch Tathlum +1", priority = 8 },
        -- head = { name = gear.af3_head, priority = 12 }, -- Chev. Armet +3
        -- neck = { name = "Kgt. Beads +2", priority = 10 },
        -- ear1 = { name = "Odnowa Earring +1", priority = 11 },
        ear2 = { name = gear.jse_ear2, priority = 6 }, -- Chev. Earring +1
        -- body = { name = gear.af3_body, priority = 13 }, -- Chev. Cuirass +3
        -- hands = { name = gear.af3_hands, priority = 2 }, -- Chev. Gauntlets +3
        -- ring1 = { name = "Fortified Ring", priority = 5 },
        -- ring2 = { name = "Gelatinous Ring +1", priority = 4 },
        back = {
            name = "Rudianos's Mantle",
            augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
                'Chance of successful block +5', },
            priority = 3,
        },
        -- waist = { name = "Asklepian Belt", priority = 7 },
        -- legs = { name = gear.af3_legs, priority = 9 }, -- Chev. Cuisses +3
        -- feet = { name = gear.af3_feet, priority = 1 }, -- Chev. Sabatons +3
    }

    sets.idle.Refresh = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        -- head = gear.af3_head, -- Chev. Armet +3
        -- neck = "Coatl Gorget +1",
        ear1 = "Etiolation Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        -- body = "Jumalik Mail",
        -- hands = "Regal Gauntlets",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = gear.tank_back, -- Rudianos's Mantle
        waist = "Plat. Mog. Belt",
        -- legs = "Carmine Cuisses +1",
        -- feet = gear.af3_feet, -- Chev. Sabatons +3
    }

    sets.idle.Town = {
        -- main = "Burtgang",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        -- head = gear.af3_head, -- Chev. Armet +3
        -- neck = "Coatl Gorget +1",
        ear1 = "Etiolation Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        -- body = "Jumalik Mail",
        -- hands = "Regal Gauntlets",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = gear.tank_back, -- Rudianos's Mantle
        waist = "Plat. Mog. Belt",
        -- legs = "Carmine Cuisses +1",
        -- feet = gear.af3_feet, -- Chev. Sabatons +3
    }

    sets.Kiting = { ring2 = "Shneddick Ring" }

    sets.latent_refresh = { waist = "Eschan Stone" }
    sets.latent_refresh_grip = { sub = "Sacro Bulwark" }
    sets.latent_regen = { ring1 = gear.enmity_ring1, ring2 = gear.enmity_ring2 }
    sets.DayIdle = {}
    sets.NightIdle = {}

    --------------------------------------
    -- Defense sets
    --------------------------------------

    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {}
    sets.MP = {
        head = gear.chev_armet_fallback,
        neck = gear.idle_neck,
        hands = "Nyame Gauntlets",
        ear2 = "Ethereal Earring",
        ring2 = "Mephitas's Ring +1",
        waist = "Flume Belt +1",
        feet = gear.rev_leggings_fallback
    }
    sets.passive.AbsorbMP = {
        head = gear.chev_armet_fallback,
        neck = gear.idle_neck,
        ear2 = "Ethereal Earring",
        waist = "Flume Belt +1",
        feet = gear.rev_leggings_fallback
    }
    sets.MP_Knockback = {}
    sets.Twilight = { head = gear.reraise_head, body = gear.reraise_body }
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
        head = gear.chev_armet_fallback,
        neck = gear.block_neck,
        ear1 = gear.block_ear1,
        ear2 = gear.block_ear2,
        body = "Sakpata's Plate",
        hands = gear.souv_block_hands,
        ring1 = gear.defending_ring,
        ring2 = gear.dt_ring2,
        back = gear.tank_back,
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
        ring2 = gear.dt_ring2,
        back = gear.fastcast_jse_back,
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
        -- neck = "Unmoving Collar +1",
        ear1 = "Crep. Earring",
        ear2 = gear.jse_ear2, -- Chev. Earring +1
        -- body = "Crepuscular Mail",
        hands = "Sakpata's Gauntlets",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back, -- Rudianos's Mantle
        waist = "Sailfi Belt +1",
        -- legs = gear.af3_legs, -- Chev. Cuisses +3
        feet = "Sakpata's Leggings"
    }

    sets.engaged.Acc = {
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Coiste Bodhar",
        head = "Flam. Zucchetto +2",
        neck = "Null Loop",
        ear1 = gear.acc_ear1,
        ear2 = "Telos Earring",
        body = gear.valorous_wsd_body,
        hands = "Sakpata's Gauntlets",
        ring1 = gear.tp_ring1,
        ring2 = gear.tp_ring2,
        back = gear.ws_back,
        waist = "Sailfi Belt +1",
        legs = gear.carmine_legs,
        feet = gear.sulevia_feet
    }

    sets.engaged.XP = {
        -- main = "Malevolence",
        sub = "Duban",
        ammo = { name = "Staunch Tathlum +1", priority = 8 },
        -- head = { name = gear.af3_head, priority = 12 }, -- Chev. Armet +3
        -- neck = { name = "Kgt. Beads +2", priority = 10 },
        -- ear1 = { name = "Odnowa Earring +1", priority = 11 },
        ear2 = { name = gear.jse_ear2, priority = 6 }, -- Chev. Earring +1
        -- body = { name = gear.af3_body, priority = 13 }, -- Chev. Cuirass +3
        -- hands = { name = gear.af3_hands, priority = 2 }, -- Chev. Gauntlets +3
        -- ring1 = { name = "Fortified Ring", priority = 5 },
        -- ring2 = { name = "Gelatinous Ring +1", priority = 4 },
        back = {
            name = "Rudianos's Mantle",
            augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Enmity+10',
                'Chance of successful block +5', },
            priority = 3,
        },
        -- waist = { name = "Asklepian Belt", priority = 7 },
        -- legs = { name = gear.af3_legs, priority = 9 }, -- Chev. Cuisses +3
        -- feet = { name = gear.af3_feet, priority = 1 }, -- Chev. Sabatons +3
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
        head = gear.chev_armet_fallback,
        neck = "Loricate Torque +1",
        ear1 = gear.block_ear1,
        ear2 = gear.block_ear2,
        body = "Sakpata's Plate",
        hands = gear.souv_block_hands,
        ring1 = gear.defending_ring,
        ring2 = gear.dt_ring2,
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.chev_cuisses_fallback,
        feet = gear.souv_feet
    }

    sets.engaged.Tp = set_combine(sets.engaged.Tank, {
        ammo = "Coiste Bodhar",
        neck = "Rep. Plat. Medal",
        ear1 = "Cessance Earring",
        ear2 = "Brutal Earring",
        body = gear.valorous_wsd_body,
        hands = "Sakpata's Gauntlets",
        ring2 = gear.tp_ring2,
        back = gear.ws_back,
        waist = "Sailfi Belt +1",
        legs = gear.sulevia_legs,
        feet = gear.sulevia_feet
    })

    sets.engaged.DDTank = {
        ammo = "Coiste Bodhar",
        head = "Sakpata's Helm",
        neck = "Loricate Torque +1",
        ear1 = "Brutal Earring",
        ear2 = "Cessance Earring",
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        ring1 = gear.defending_ring,
        ring2 = gear.tp_ring2,
        back = gear.phalanx_jse_back,
        waist = "Sailfi Belt +1",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings"
    }

    sets.engaged.Acc.DDTank = {
        ammo = "Coiste Bodhar",
        head = "Sakpata's Helm",
        neck = "Loricate Torque +1",
        ear1 = gear.acc_ear1,
        ear2 = "Telos Earring",
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        ring1 = gear.defending_ring,
        ring2 = gear.tp_ring2,
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
        ear1 = gear.block_ear2,
        ear2 = "Etiolation Earring",
        body = gear.af1_body,
        hands = "Sakpata's Gauntlets",
        ring1 = gear.defending_ring,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.odyssean_fc_legs,
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
        -- ring2 = "Blenmot's Ring +1",
        waist = "Gishdubar Sash"
    }
    sets.buff.Sleep = { neck = "Loricate Torque +1" }
    sets.buff.Cover = { body = gear.af1_body }
    sets.buff.Reprisal = { sub = "Priwen" }
end

local function add_priwen_when_reprisal(baseSet)
    if buffactive['Reprisal'] and sets.buff.Reprisal and not (state.CombatForm and state.CombatForm.value == 'DW') then
        if baseSet and baseSet.sub == gear.srivatsa then
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(1, 19)
    elseif player.sub_job == 'RUN' then
        set_macro_page(1, 19)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 19)
    elseif player.sub_job == 'BLU' then
        set_macro_page(1, 19)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 19)
    else
        set_macro_page(1, 19) --War/Etc
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
