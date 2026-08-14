function character_user_job_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'Tp')
    state.HybridMode:options('Tank', 'DDTank', 'Normal')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'SIRD')
    state.Passive:options('None', 'AbsorbMP')
    state.PhysicalDefenseMode:options('PDT_HP', 'PDT', 'PDT_Reraise')
    state.MagicalDefenseMode:options('MDT_HP', 'MDT', 'MDT_Reraise')
    state.ResistDefenseMode:options('MEVA_HP', 'MEVA')
    state.IdleMode:options('Tank', 'Kiting', 'PDT', 'Block', 'MDT', 'Normal')
    state.Weapons:options('None', 'ExcaliburDuban', 'ExcaliburAegis', 'NaeglingDuban', 'NaeglingAegis',
        'BurtgangDuban', 'BurtgangAegis')

    state.AutoCureCheat = M(true, 'Auto Cure Cheat')

    autows_list = {
        ExcaliburDuban = 'Knights of Round',
        ExcaliburAegis = 'Knights of Round',
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

    -- Artifact Gear
    gear.af1_head = "" -- Unneeded
    gear.af1_body = "" -- Cab. Surcoat +1
    gear.af1_hands = "" -- Cab. Gauntlets +1
    gear.af1_legs = "" -- Cab. Breeches +1
    gear.af1_feet = "" -- Cab. Leggings +1

    -- Relic Gear
    gear.af2_head = "" -- Rampart
    gear.af2_body = "" -- Rev. Surcoat +3
    gear.af2_hands = "" -- Shield Bash
    gear.af2_legs = ""
    gear.af2_feet = "" -- Rev. Leggings +3


    -- Empy Gear
    gear.af3_head = "" -- Chev. Armet +1
    gear.af3_body = ""
    gear.af3_hands = ""
    gear.af3_legs = "" -- Chev. Cuisses +1
    gear.af3_feet = "" -- Chev. Sabatons +1

    -- Owned fallbacks for older PLD set pieces.
    gear.cab_leggings_fallback = "Nyame Sollerets"       -- Cab. Leggings +1
    gear.rev_surcoat_fallback = "Adamantite Armor"       -- Rev. Surcoat +3
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
    gear.enmity_neck = "Loricate Torque +1"                             -- Moonlight Necklace
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
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.enmity_head,
        neck = gear.enmity_neck,
        ear1 = "Friomisi Earring",
        ear2 = gear.enmity_ear2,
        body = gear.souv_body,
        hands = gear.enmity_hands,
        ring1 = gear.enmity_ring1,
        ring2 = gear.enmity_ring2,
        back = gear.enmity_jse_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.enmity_feet
    }

    sets.Enmity.SIRD = {
        main = "Sakpata's Sword",
        sub = gear.srivatsa,
        ammo = "Staunch Tathlum +1",
        head = gear.enmity_head,
        neck = gear.enmity_neck,
        ear1 = "Friomisi Earring",
        ear2 = gear.enmity_ear2,
        body = gear.souv_body,
        hands = gear.enmity_hands,
        ring1 = gear.enmity_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.enmity_jse_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.fc_feet
    }

    sets.Enmity.DT = {
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = gear.dt_neck,
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = gear.rev_surcoat_fallback,
        hands = gear.souv_hands,
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.souv_feet
    }

    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity, { legs = gear.af1_legs })
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity, { feet = gear.af2_feet })
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity, { feet = gear.af1_feet })
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity, {}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity, { body = gear.af1_body })
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity, { feet = gear.af3_feet })
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, { body = gear.af1_body }) -- head="Rev. Coronet +1"

    sets.precast.JA['Invincible'].DT = set_combine(sets.Enmity.DT, { legs = gear.af1_legs })
    sets.precast.JA['Holy Circle'].DT = set_combine(sets.Enmity.DT, { feet = gear.af2_feet })
    sets.precast.JA['Sentinel'].DT = set_combine(sets.Enmity.DT, { feet = gear.af1_feet })
    sets.precast.JA['Rampart'].DT = set_combine(sets.Enmity.DT, {}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'].DT = set_combine(sets.Enmity.DT, { body = gear.af1_body })
    sets.precast.JA['Divine Emblem'].DT = set_combine(sets.Enmity.DT, { feet = gear.af3_feet })
    sets.precast.JA['Cover'].DT = set_combine(sets.Enmity.DT, { body = gear.af1_body }) -- head="Rev. Coronet +1"

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = gear.dt_neck,
        ear1 = "Mendi. Earring",
        ear2 = "Etiolation Earring",
        body = "Nyame Mail",
        hands = "Sakpata's Gauntlets",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamor. Ring +1",
        back = gear.enmity_jse_back,
        waist = "Olympus Sash",
        legs = "Nyame Flanchard",
        feet = gear.carmine_feet
    }

    sets.precast.JA['Chivalry'].DT = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = gear.dt_neck,
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = "Nyame Mail",
        hands = "Sakpata's Gauntlets",
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Olympus Sash",
        legs = "Nyame Flanchard",
        feet = gear.carmine_feet
    }

    sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, { hands = gear.af1_hands })
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})

    sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, { hands = gear.af1_hands })
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
    sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
    sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
    sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
    sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
    sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
    sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        ammo = "Aurgelmir Orb +1",
        head = "Nyame Helm",
        neck = gear.dt_neck,
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = gear.rev_surcoat_fallback,
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

    sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells

    sets.precast.FC = {
        main = "Sakpata's Sword",
        sub = gear.fc_shield,
        ammo = "Impatiens",
        head = gear.fc_head,
        neck = "Voltsurge Torque",
        ear1 = "Etiolation Earring",
        ear2 = "Loquac. Earring",
        body = gear.rev_surcoat_fallback,
        hands = gear.fc_hands,
        ring1 = "Lebeche Ring",
        ring2 = "Kishar Ring",
        back = gear.fastcast_jse_back,
        waist = "Flume Belt +1",
        legs = gear.odyssean_fc_legs,
        feet = gear.fc_feet
    }

    sets.precast.FC.DT = {
        main = "Sakpata's Sword",
        ammo = "Impatiens",
        head = gear.souv_head,
        neck = "Voltsurge Torque",
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = gear.rev_surcoat_fallback,
        hands = gear.souv_hands,
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.souv_feet
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Olympus Sash" })
    sets.precast.FC['Enhancing Magic'].DT = set_combine(sets.precast.FC.DT, { waist = "Olympus Sash" })

    sets.precast.FC.Cure = set_combine(sets.precast.FC,
        { neck = "Hoxne Torque", ear1 = "Mendi. Earring", ear2 = "Etiolation Earring", body = "Nyame Mail" })

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
        body = gear.rev_surcoat_fallback,
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
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
        neck = "Null Loop",
        ear1 = gear.acc_ear1,
        ear2 = "Telos Earring",
        waist = "Null Belt",
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
    sets.precast.WS['Knights of the Round'] = sets.precast.WS['Knights of Round']
    sets.precast.WS['Knights of the Round'].Acc = sets.precast.WS['Knights of Round'].Acc

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
        ammo = "Ghastly Tathlum +1",
        head = "Pixie Hairpin +1",
        neck = "Fotia Gorget",
        ear1 = "Friomisi Earring",
        ear2 = "Moonshade Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Archon Ring",
        ring2 = "Metamor. Ring +1",
        back = gear.ws_back,
        waist = "Fotia Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.WS['Aeolian Edge'] = {
        ammo = "Pemphredo Tathlum",
        head = "Nyame Helm",
        neck = "Sibyl Scarf",
        ear1 = gear.macc_ear1,
        ear2 = "Moonshade Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Metamor. Ring +1",
        ring2 = gear.tvr_ring,
        back = gear.ws_back,
        waist = "Orpheus's Sash",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.WS['Atonement'] = {
        ammo = "Staunch Tathlum +1",
        head = gear.enmity_head,
        neck = gear.enmity_neck,
        ear1 = "Friomisi Earring",
        ear2 = gear.enmity_ear2,
        body = gear.souv_body,
        hands = gear.enmity_hands,
        ring1 = gear.enmity_ring1,
        ring2 = gear.enmity_ring2,
        back = gear.enmity_jse_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.enmity_feet
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
        body = gear.rev_surcoat_fallback,
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
        body = gear.rev_surcoat_fallback,
        hands = gear.souv_hands,
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.souv_feet
    }

    sets.midcast.Flash = set_combine(sets.Enmity, {})
    sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
    sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast['Dark Magic'] = set_combine(sets.Enmity, {})
    sets.midcast['Dark Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast['Absorb-TP'] = set_combine(sets.midcast['Dark Magic'], {})
    sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
    sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {
        main = "Sakpata's Sword",
        sub = gear.srivatsa,
        ammo = "Staunch Tathlum +1",
        head = gear.enmity_head,
        neck = "Hoxne Torque",
        ear1 = "Mendi. Earring",
        ear2 = "Etiolation Earring",
        body = "Nyame Mail",
        hands = gear.enmity_hands,
        ring1 = gear.defending_ring,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.enmity_jse_back,
        waist = "Flume Belt +1",
        legs = gear.carmine_legs,
        feet = gear.fc_feet
    }

    sets.midcast.Cure.SIRD = {
        main = gear.deacon_sword,
        sub = gear.srivatsa,
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Loricate Torque +1",
        ear1 = "Mendi. Earring",
        ear2 = "Etiolation Earring",
        body = "Nyame Mail",
        hands = gear.enmity_hands,
        ring1 = gear.defending_ring,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.enmity_jse_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.fc_feet
    }

    sets.midcast.Cure.DT = {
        main = gear.deacon_sword,
        sub = gear.srivatsa,
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Loricate Torque +1",
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = gear.rev_surcoat_fallback,
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
        body = gear.rev_surcoat_fallback,
        hands = gear.souv_hands,
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = "Nyame Flanchard",
        feet = gear.souv_feet
    }

    sets.Self_Healing = {
        main = gear.deacon_sword,
        sub = gear.srivatsa,
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Hoxne Torque",
        ear1 = "Mendi. Earring",
        ear2 = "Etiolation Earring",
        body = gear.souv_body,
        hands = gear.enmity_hands,
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.souv_feet
    }

    sets.Self_Healing.SIRD = {
        main = gear.deacon_sword,
        sub = gear.srivatsa,
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Loricate Torque +1",
        ear1 = "Mendi. Earring",
        ear2 = "Etiolation Earring",
        body = gear.souv_body,
        hands = gear.enmity_hands,
        ring1 = gear.defending_ring,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.fc_feet
    }

    sets.Self_Healing.DT = {
        main = gear.deacon_sword,
        sub = gear.srivatsa,
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Loricate Torque +1",
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = gear.rev_surcoat_fallback,
        hands = gear.souv_hands,
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.souv_feet
    }

    sets.HPDown = {
        main = gear.deacon_sword,
        sub = "Sacro Bulwark",
        ammo = "Staunch Tathlum +1",
        head = "Pixie Hairpin +1",
        neck = "Loricate Torque +1",
        ear1 = "Friomisi Earring",
        ear2 = "Ethereal Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Crepuscular Ring",
        ring2 = "Mephitas's Ring +1",
        back = "Null Shawl",
        waist = "Plat. Mog. Belt",
        legs = "Dashing Subligar",
        feet = "Nyame Sollerets"
    }

    sets.HPCure = {
        main = gear.deacon_sword,
        sub = gear.srivatsa,
        ammo = "Crepuscular Pebble",
        head = gear.souv_head,
        neck = "Hoxne Torque",
        ear1 = "Mendi. Earring",
        ear2 = "Etiolation Earring",
        body = gear.souv_body,
        hands = gear.enmity_hands,
        ring1 = gear.enmity_ring1,
        ring2 = gear.enmity_ring2,
        back = gear.enmity_jse_back,
        waist = "Flume Belt +1",
        legs = gear.souv_legs,
        feet = gear.souv_feet
    }

    sets.Cure_Received = { hands = gear.souv_hands, feet = gear.souv_feet }
    sets.Self_Refresh = { waist = "Gishdubar Sash" }
    sets.Enhancing_Received = {}

    sets.midcast['Enhancing Magic'] = {
        main = gear.enhancing_main,
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.fc_head,
        neck = "Hoxne Torque",
        ear1 = "Mimir Earring",
        ear2 = "Alabaster Earring",
        body = gear.enhancing_body,
        hands = gear.enhancing_hands,
        ring1 = gear.defending_ring,
        ring2 = "Kishar Ring",
        back = gear.enhancing_back,
        waist = "Olympus Sash",
        legs = gear.carmine_legs,
        feet = gear.fc_feet
    }

    sets.midcast['Enhancing Magic'].SIRD = {
        main = gear.enhancing_main,
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = "Hoxne Torque",
        ear1 = "Mimir Earring",
        ear2 = gear.dt_ear2,
        body = gear.enhancing_body,
        hands = gear.souv_hands,
        ring1 = gear.defending_ring,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.enhancing_back,
        waist = "Olympus Sash",
        legs = gear.souv_legs,
        feet = gear.fc_feet
    }

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { neck = "Nodens Gorget", waist = "Olympus Sash" })

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })

    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],
        {
            main = "Sakpata's Sword",
            sub = "Forfend +1",
            hands = gear.souv_hands,
            back = gear.phalanx_jse_back,
            legs =
            "Sakpata's Cuisses",
            feet = gear.souv_feet
        })
    sets.midcast.Phalanx.SIRD = set_combine(sets.midcast['Enhancing Magic'].SIRD,
        {
            main = "Sakpata's Sword",
            sub = "Duban",
            hands = gear.souv_hands,
            back = gear.phalanx_jse_back,
            feet = gear
                .souv_feet
        })
    sets.midcast.Phalanx.DT = set_combine(sets.midcast.Phalanx.SIRD, {})
    sets.Phalanx_Received = {
        main = "Sakpata's Sword",
        hands = gear.souv_hands,
        back = gear.phalanx_jse_back,
        legs =
        "Sakpata's Cuisses",
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
        feet = gear.cab_leggings_fallback
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
        main = "Sakpata's Sword",
        sub = gear.srivatsa,
        ammo = "Staunch Tathlum +1",
        head = "Sakpata's Helm",
        neck = gear.dt_neck,
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        ring1 = gear.dt_ring1,
        ring2 = gear.dt_ring2,
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings"
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
        main = "Sakpata's Sword",
        sub = "Aegis",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Adamantite Armor",
        hands = "Nyame Gauntlets",
        ring1 = "Archon Ring",
        ring2 = gear.dt_ring2,
        back = gear.fastcast_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
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

    sets.defense.PDT = {
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = "Sakpata's Helm",
        neck = gear.dt_neck,
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        ring1 = gear.dt_ring1,
        ring2 = gear.dt_ring2,
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings"
    }

    sets.defense.PDT_HP = {
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Staunch Tathlum +1",
        head = gear.souv_head,
        neck = gear.dt_neck,
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = gear.rev_surcoat_fallback,
        hands = gear.souv_hands,
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = "Nyame Flanchard",
        feet = gear.souv_feet
    }

    sets.defense.MDT = {
        main = "Sakpata's Sword",
        sub = "Aegis",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Warder's Charm +1",
        ear1 = gear.dt_ear1,
        ear2 = "Sanare Earring",
        body = "Adamantite Armor",
        hands = "Nyame Gauntlets",
        ring1 = "Archon Ring",
        ring2 = gear.dt_ring2,
        back = gear.fastcast_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.MDT_HP = {
        main = "Sakpata's Sword",
        sub = "Aegis",
        ammo = "Staunch Tathlum +1",
        head = "Sakpata's Helm",
        neck = "Warder's Charm +1",
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Null Belt",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings"
    }

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

    sets.defense.MEVA_HP = {
        main = "Sakpata's Sword",
        sub = "Aegis",
        ammo = "Staunch Tathlum +1",
        head = "Sakpata's Helm",
        neck = "Warder's Charm +1",
        ear1 = gear.dt_ear1,
        ear2 = gear.dt_ear2,
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        ring1 = gear.dt_ring1,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Null Belt",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings"
    }

    sets.defense.PDT_Reraise = set_combine(sets.defense.PDT_HP, sets.Twilight)
    sets.defense.MDT_Reraise = set_combine(sets.defense.MDT_HP, sets.Twilight)

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {
        main = "Sakpata's Sword",
        sub = "Duban",
        ammo = "Coiste Bodhar",
        head = "Flam. Zucchetto +2",
        neck = "Rep. Plat. Medal",
        ear1 = "Cessance Earring",
        ear2 = "Brutal Earring",
        body = gear.valorous_wsd_body,
        hands = "Sakpata's Gauntlets",
        ring1 = gear.tp_ring1,
        ring2 = gear.tp_ring2,
        back = gear.ws_back,
        waist = "Windbuffet Belt +1",
        legs = gear.sulevia_legs,
        feet = "Flam. Gambieras +2"
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
        body = gear.rev_surcoat_fallback,
        hands = "Sakpata's Gauntlets",
        ring1 = gear.defending_ring,
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = gear.tank_back,
        waist = "Flume Belt +1",
        legs = gear.odyssean_fc_legs,
        feet = gear.cab_leggings_fallback
    }

    sets.Reraise = sets.Twilight
    sets.engaged.Acc.Tank = sets.engaged.Tank
    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc.Tank, sets.Reraise)

    --------------------------------------
    -- Custom buff sets
    --------------------------------------
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
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
