function character_user_job_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Match', 'Acc', 'HighBuff', 'HighBuffAcc', 'Proc')
    state.CastingMode:options('Normal', 'Resistant', 'Proc', 'SIRD', 'OccultAcumen')
    state.IdleMode:options('Normal', 'PDT', 'MDT', 'MEVA', 'Aminon')
    state.PhysicalDefenseMode:options('PDT', 'NukeLock')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.BuffWeaponsMode = M { 'Always', 'Never' }
    state.AutoBuffMode = M { ['description'] = 'Auto Buff Mode', 'Off', 'Auto', 'AutoMelee', 'AutoMage' }
    state.Weapons:options('None', 'Naegling', 'Maxentius', 'Crocea', --[['Tauret', 'EnspellOnly',]] 'DualNaegling',
        'DualNaeglingAcc', 'DualMaxentius', 'DualCrocea', 'DualCroceaTP', 'DualMaxentiusAcc' --[[,'DualPrime', 'DualAeolian']],
        'DualEnspellOnly' --[[,'DualProcSword']])
    state.WeaponSets:options('Default', 'Dual' --[[,'Proc','Dynamis']])

    weapon_sets = {
        ['Default'] = { 'None', 'Naegling', 'Maxentius', 'Crocea', --[['Tauret', 'EnspellOnly']] },
        ['Dual'] = { 'DualNaegling', 'DualNaeglingAcc', 'DualCrocea', 'DualCroceaTP', 'DualMaxentius', 'DualMaxentiusAcc' --[[,'DualPrime', 'DualAeolian']], 'DualEnspellOnly' },
        --[[['Dynamis'] = {'DualCroceaSavageBlade','DualCrocea','DualTauretCrocea','DualAeolian'},
		['Proc'] = {'ProcSword','ProcDagger','DualProcSword','DualProcDagger'},]]
    }

    default_weapons = 'Crocea'
    default_dual_weapons = 'DualCrocea'

    autows_list = {
        ['Naegling'] = 'Savage Blade',
        ['Maxentius'] = 'Black Halo',
        ['Crocea'] = 'Sanguine Blade',
        ['Tauret'] = 'Aeolian Edge',
        ['DualNaegling'] = 'Savage Blade',
        ['DualNaeglingAcc'] = 'Savage Blade',
        ['DualMaxentius'] = 'Black Halo',
        ['DualMaxentiusAcc'] = 'Black Halo',
        ['DualEvisceration'] = 'Evisceration',
        ['DualCrocea'] = 'Sanguine Blade',
        ['DualCroceaTP'] = 'Savage Blade',
        ['DualClubs'] = 'Black Halo',
        ['DualAeolian'] = 'Aeolian Edge',
        ['DualPrime'] = 'Exenterator',
        ['DualCroceaSavageBlade'] = "Savage Blade",
        ['CroceaDaybreak'] = "Seraph Blade",
        ["DualTauretCrocea"] = "Aeolian Edge"
    }
    trust_list = { "Joachim", "Ulmia", "Qultada", "Sylvie (UC)", "Monberaux" }

    --gear.mnd_enfeebling_jse_back = {name="Sucellos's Cape",augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Haste+10','Damage taken-5%',}}
    --gear.int_enfeebling_jse_back = {name="Sucellos's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}}
    --gear.str_wsd_jse_back = {name="Sucellos's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
    --gear.physical_mnd_wsd_jse_back = {name="Sucellos's Cape",augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}}
    gear.magical_mnd_wsd_jse_back = { name = "Sucellos's Cape", augments = { 'MND+20', 'Mag. Acc+20/Mag. Dmg.+20', 'MND+10', 'Weapon skill damage +10%' } }
    --gear.int_wsd_jse_back = {name="Sucellos's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Damage taken-5%',}}
    gear.nuke_jse_back = { name = "Sucellos's Cape", augments = { 'INT+20', 'Mag. Acc+20/Mag. Dmg.+20', '"Mag. Atk. Bns."+10', 'Phys. dmg. taken-10%', } }      --TODO
    gear.dw_jse_back = { name = "Sucellos's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', --[[ 'Accuracy+10',]] '"Dual Wield"+10', 'Phys. dmg. taken-10%' } }
    gear.cure_jse_back = { name = "Sucellos's Cape", augments = { 'MND+20', 'Mag. Acc+20/Mag. Dmg.+20', 'MND+9', '"Fast Cast"+10%', 'Phys. dmg. taken-10%', } } --TODO
    
    gear.ghostfyre_enhancing_skill_cape = { name = "Ghostfyre Cape", augments = { 'Mag. Acc.+9', 'Enfb.mag. skill +6', 'Enha.mag. skill +10', 'Enh. Mag. eff. dur. +11' } }
    gear.ghostfyre_enhancing_duration_cape = { name = "Ghostfyre Cape", augments = { 'Mag. Acc.+4', 'Enfb.mag. skill +1', 'Enha.mag. skill +7', 'Enh. Mag. eff. dur. +20' } }
    gear.absorb_tp_recast_jse_back = gear.cure_jse_back

    -- Unimplemented Ambuscade Capes with redirects to capes I do have
    gear.enspell_jse_back = gear.dw_jse_back
    gear.mnd_enfeebling_jse_back = gear.magical_mnd_wsd_jse_back
    gear.int_enfeebling_jse_back = gear.nuke_jse_back
    gear.int_wsd_jse_back = gear.nuke_jse_back
    gear.str_wsd_jse_back = gear.magical_mnd_wsd_jse_back
    gear.physical_mnd_wsd_jse_back = gear.magical_mnd_wsd_jse_back
    gear.str_wsd_jse_back = gear.physical_mnd_wsd_jse_back

    -- JSE Weapon/Neck/Earring
    gear.jse_ear2 = "Leth. Earring +2"
    gear.jse_neck = "Dls. Torque +2"

    -- Artifact Gear
    gear.af1_head = "Atro. Chapeau +4"
    gear.af1_body = "Atrophy Tabard +4"
    gear.af1_hands = "Atro. Gloves +4"
    gear.af1_legs = "Atro. Tights +4"
    gear.af1_feet = "Atro. Boots +4"

    -- Relic Gear
    gear.af2_head = "Viti. Chapeau +4"
    gear.af2_body = "Viti. Tabard +4"
    gear.af2_hands = "Viti. Gloves +4"
    gear.af2_legs = {}
    gear.af2_feet = "Vitiation Boots +4" -- Need for Immunobreak macroing

    -- Empy Gear
    gear.af3_head = "Leth. Chappel +3"
    gear.af3_body = "Lethargy Sayon +3"
    gear.af3_hands = "Leth. Ganth. +3"
    gear.af3_legs = "Leth. Fuseau +3"
    gear.af3_feet = "Leth. Houseaux +3"

    -- List of gear I want, could be BiS. When I get the item, can replace it here
    --
    -- Useful but mostly optimizatio
    gear.umuthi_hat = gear.af3_head
    --  2  Umuthi Hat                    +8 Enspell
    gear.baetyl_pendant = gear.jse_neck
    --  3  Baetyl Pendant                FC +4%, MAB +13
    gear.ournmilas_torque = gear.jse_neck
    --  1  Orunmila's Torque             FC +5%
    gear.perimede_cape = gear.cure_jse_back
    --  3  Perimede Cape                 QC+4%
    gear.obstinate_sash = "Embla Sash"
    --  6  Obstinate Sash                +5 Enfeebling Duration
    --
    -- Pure min/max or niche
    gear.diamond_aspis = ""
    --  0  Diamond Aspis                 Swap piece
    gear.homillary = "Staunch Tathlum +1"
    --  1  Homiliary                     Idle Refresh +1
    gear.null_masque = gear.af3_head
    --  1  Null Masque                   Animon Idle
    gear.meili_earring = "Alabaster Earring"
    --  4  Meili Earring                 Healing skill + 10
    gear.zennaroi_ear = "Alabaster Earring"
    --  2  Zennaroi Earring              MDB +1
    gear.crepuscular_cloak = "" --"Twilight Cloak"
    --  2  Crepuscular Cloak          	 Impact (can't cast without, so it's ok!)
    -- hands
    gear.hieros_mittens = gear.af1_hands
    --  1  Hieros Mittens                Cursna Set
    gear.shadow_mantle = "Null Shawl"
    --  2  Shadow Mantle                 Phys Annul
    gear.engulfer_cape = "Null Shawl"
    --  2  Engulfer Cape +1              -4% MDT, Magic Absorb
    gear.luminary_sash = "Embla Sash"
    --  1  Luminary Sash                 Conserve MP / MND
    gear.bishops_sash = "Embla Sash"
    --  1  Bishop's Sash                 +5 Healing (cursna)

    -- Ignored placeholders
    gear.filler_shield = "Ammurapi Shield"
    --   3  Removed grip and replaced with Crocea, didn't research sub (FullFC, Status Removal, Cursna)==--


    -- head body hands legs boots "Taeon " xxx gear for +3 Phalanx increase (+15 total) -- DI Dark Matter gear? +5 a piece (+25 total), and Sworn gear (+24 total, only body is better)


    -- Additional local binds
    send_command('bind @` gs c cycle ElementalMode')
    send_command('bind ^` gs c scholar dark')
    send_command('bind !` gs c scholar light')
    send_command('bind !backspace input /ja "Composure" <me>')
    send_command('bind ^backspace input /ja "Saboteur" <me>')
    send_command('bind @backspace input /ja "Spontaneity" <t>')
    send_command('bind ^\\\\ input /ma "Protect V" <t>')
    send_command('bind @\\\\ input /ma "Shell V" <t>')
    send_command('bind !\\\\ input /ma "Reraise III" <me>')
    send_command('bind @f8 gs c toggle AutoNukeMode')
    send_command('bind @f10 gs c cycle RecoverMode')

    select_default_macro_book()
end

function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Weapons sets
    sets.weapons.Naegling = { main = "Naegling", sub = "Ammurapi Shield", range = empty }
    sets.weapons.Crocea = { main = "Crocea Mors", sub = "Ammurapi Shield", range = empty }
    sets.weapons.Maxentius = { main = "Maxentius", sub = "Ammurapi Shield", range = empty }
    --sets.weapons.Tauret = { main = "Tauret", sub = "Ammurapi Shield", range = empty }
    --sets.weapons.EnspellOnly = { main = "Qutrub Knife", sub = "Sacro Bulwark", range = "Ullr", ammo = empty }

    sets.weapons.DualNaegling = { main = "Naegling", sub = gear.tp_bonus_sword, range = empty }
    sets.weapons.DualNaeglingAcc = { main = "Naegling", sub = "Gleti's Knife", range = empty }
    --sets.weapons.DualPrime = {main="Mpu Gandring",sub="Gleti's Knife",range=empty}
    sets.weapons.DualCrocea = { main = "Crocea Mors", sub = "Daybreak", range = empty }
    sets.weapons.DualCroceaTP = { main = "Crocea Mors", sub = gear.tp_bonus_sword, range = empty }
    --sets.weapons.DualAeolian = { main = "Tauret", sub = "Maxentius", range = empty }
    sets.weapons.DualMaxentius = { main = "Maxentius", sub = gear.tp_bonus_sword, range = empty }
    sets.weapons.DualMaxentiusAcc = { main = "Maxentius", sub = "Gleti's Knife", range = empty }
    sets.weapons.DualEnspellOnly = { main = "Crocea Mors", sub = "Ammurapi Shield", range = "Ullr", ammo = empty }


    -- Precast Sets

    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = { body = gear.af2_body }

    -- Steps (Pure Acc)
    sets.precast.Step = {
        ammo = "Aurgelmir Orb +1",
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = gear.zennaroi_ear,
        ear2 = "Crep. Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    -- Violent Flourish (Macc & Acc)
    sets.precast.JA['Violent Flourish'] = {
        ammo = "Regal Gem", --Or range="Ullr" but swapping to this makes you lose TP.
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = "Crep. Earring",
        body = "Malignance Tabard",
        hands = gear.af3_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamorph Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        legs = "Dashing Subligar"
    }

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
        main = "Sakpata's Sword",
        sub = "Sacro Bulwark",
        ammo = "Impatiens",
        head = gear.af1_head,
        neck = "Loricate Torque +1",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_ear2,
        body = gear.af2_body,
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = "Lebeche Ring",
        back = gear.perimede_cape,
        waist = "Witful Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.FC.DT = {
        main = "Sakpata's Sword",
        sub = "Sacro Bulwark",
        ammo = "Impatiens",
        head = gear.af1_head,
        neck = "Loricate Torque +1",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_ear2,
        body = gear.af2_body,
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = "Lebeche Ring",
        back = gear.perimede_cape,
        waist = "Witful Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.FullFC = {
        main = "Crocea Mors",
        sub = gear.filler_shield,
        ammo = "Impatiens",
        head = gear.af1_head,
        neck = gear.ournmilas_torque,
        ear1 = "Malignance Earring",
        ear2 = gear.jse_ear2,
        body = gear.af2_body,
        hands = gear.gende_gages,
        ring1 = "Kishar Ring",
        ring2 = "Lebeche Ring",
        back = gear.perimede_cape,
        waist = "Witful Belt",
        legs = "Sworn Brais",
        feet = gear.filler_FullFC
    }

    sets.precast.FC.Impact = set_combine(sets.precast.FullFC, { head = empty, body = gear.crepuscular_cloak })
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Sacro Bulwark" })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        range = empty,
        ammo = "Oshasha's Treatise",
        head = gear.af2_head,
        neck = "Fotia Gorget",
        ear1 = "Sherida Earring",
        ear2 = "Moonshade Earring",
        body = "Nyame Mail",
        hands = gear.af1_hands,
        ring1 = "Sroda Ring",
        ring2 = gear.cornealias_ring,
        back = gear.str_wsd_jse_back,
        waist = "Fotia Belt",
        legs = "Nyame Flanchard",
        feet = gear.af3_feet
    }

    sets.precast.WS.HighBuff = set_combine(sets.precast.WS, {
        ammo = "Crepuscular Pebble",
        neck = gear.jse_neck,
        ear1 = "Ishvara Earring",
        ring2 = gear.tvr_ring,
        waist = "Sailfi Belt +1"
    })
    sets.precast.WS.HighBuffAcc = set_combine(sets.precast.WS.HighBuff, {
        neck = "Null Loop",
        ear1 = "Telos Earring",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        waist = "Null Belt"
    })

    sets.precast.WS.Proc = {
        ammo = "Aurgelmir Orb +1",
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = gear.zennaroi_ear,
        ear2 = "Crep. Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = {
        range = empty,
        ammo = "Regal Gem",
        head = gear.af2_head,
        neck = "Fotia Gorget",
        ear1 = "Sherida Earring",
        ear2 = "Moonshade Earring",
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamorph Ring +1",
        back = gear.physical_mnd_wsd_jse_back,
        waist = "Fotia Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.precast.WS['Requiescat'].HighBuff = set_combine(sets.precast.WS['Requiescat'], {
        ammo = "Crepuscular Pebble",
        head = gear.null_masque,
        ear1 = "Malignance Earring",
        ear2 = "Regal Earring",
        body = "Bunzi's Robe",
        hands = "Malignance Gloves",
        ring1 = "Sroda Ring",
        ring2 = gear.tvr_ring,
        legs = "Nyame Flanchard"
    })
    sets.precast.WS['Requiescat'].HighBuffAcc = set_combine(sets.precast.WS['Requiescat'].HighBuff, {
        neck = "Null Loop",
        ear1 = "Telos Earring",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        waist = "Null Belt"
    })

    sets.precast.WS['Chant Du Cygne'] = {
        range = empty,
        ammo = "Oshasha's Treatise",
        head = "Nyame Helm",
        neck = "Fotia Gorget",
        ear1 = "Sherida Earring",
        ear2 = "Brutal Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Ilabrat Ring",
        ring2 = "Epona's Ring",
        back = gear.str_wsd_jse_back,
        waist = "Fotia Belt",
        legs = "Nyame Flanchard",
        feet = gear.af3_feet
    }
    sets.precast.WS['Chant Du Cygne'].HighBuff = set_combine(sets.precast.WS['Chant Du Cygne'], {
        ammo = "Crepuscular Pebble",
        ear2 = "Regal Earring",
        ring1 = "Sroda Ring",
        ring2 = gear.tvr_ring
    })
    sets.precast.WS['Chant Du Cygne'].HighBuffAcc = set_combine(sets.precast.WS['Chant Du Cygne'].HighBuff, {
        neck = "Null Loop",
        ear1 = "Telos Earring",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        waist = "Null Belt"
    })

    sets.precast.WS['Evisceration'] = sets.precast.WS['Chant Du Cygne']

    sets.precast.WS['Savage Blade'] = {
        range = empty,
        ammo = "Oshasha's Treatise",
        head = gear.af2_head,
        neck = "Rep. Plat. Medal",
        ear1 = "Ishvara Earring",
        ear2 = "Moonshade Earring",
        body = "Nyame Mail",
        hands = gear.af1_hands,
        ring1 = "Sroda Ring",
        ring2 = "Epaminondas's Ring",
        back = gear.str_wsd_jse_back,
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = gear.af3_feet
    }
    sets.precast.WS['Savage Blade'].HighBuff = set_combine(sets.precast.WS['Savage Blade'], {
        ammo = "Crepuscular Pebble",
        neck = gear.jse_neck,
        ring2 = gear.tvr_ring
    })
    sets.precast.WS['Savage Blade'].HighBuffAcc = set_combine(sets.precast.WS['Savage Blade'].HighBuff, {
        neck = "Null Loop",
        ear1 = "Telos Earring",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        waist = "Null Belt"
    })

    sets.precast.WS['Black Halo'] = {
        range = empty,
        ammo = "Oshasha's Treatise",
        head = gear.af2_head,
        neck = "Rep. Plat. Medal",
        ear1 = "Regal Earring",
        ear2 = "Moonshade Earring",
        body = "Nyame Mail",
        hands = gear.af1_hands,
        ring1 = "Sroda Ring",
        ring2 = "Epaminondas's Ring",
        back = gear.physical_mnd_wsd_jse_back,
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = gear.af3_feet
    }

    sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS['Black Halo'], {
        neck = "Null Loop",
        ear1 = "Telos Earring",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        waist = "Null Belt"
    })

    sets.precast.WS['Black Halo'].HighBuff = set_combine(sets.precast.WS['Black Halo'], {
        ammo = "Crepuscular Pebble",
        neck = gear.jse_neck,
        body = "Bunzi's Robe",
        hands = gear.af1_hands,
        ring2 = gear.tvr_ring
    })
    sets.precast.WS['Black Halo'].HighBuffAcc = set_combine(sets.precast.WS['Black Halo'].HighBuff, {
        neck = "Null Loop",
        ear1 = "Telos Earring",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        waist = "Null Belt"
    })

    sets.precast.WS['Sanguine Blade'] = {
        range = empty,
        ammo = "Sroda Tathlum",
        head = "Pixie Hairpin +1",
        neck = gear.baetyl_pendant,
        ear1 = "Malignance Earring",
        ear2 = "Regal Earring",
        body = "Nyame Mail",
        hands = "Jhakri Cuffs +2",
        ring1 = "Epaminondas's Ring",
        ring2 = "Archon Ring",
        back = gear.magical_mnd_wsd_jse_back,
        waist = "Orpheus's Sash",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }
    sets.precast.WS['Sanguine Blade'].HighBuff = set_combine(sets.precast.WS['Sanguine Blade'], {})

    sets.precast.WS['Seraph Blade'] = {
        range = empty,
        ammo = "Sroda Tathlum",
        head = gear.af3_head,
        neck = "Fotia Gorget",
        ear1 = "Malignance Earring",
        ear2 = "Moonshade Earring",
        body = "Nyame Mail",
        hands = gear.af3_hands,
        ring1 = "Epaminondas's Ring",
        ring2 = "Freke Ring",
        back = gear.magical_mnd_wsd_jse_back,
        waist = "Orpheus's Sash",
        legs = "Nyame Flanchard",
        feet = gear.af3_feet
    }
    sets.precast.WS['Seraph Blade'].HighBuff = set_combine(sets.precast.WS['Seraph Blade'], {})

    sets.precast.WS['Shining Strike'] = sets.precast.WS['Seraph Blade']
    sets.precast.WS['Flash Nova'] = sets.precast.WS['Seraph Blade']

    sets.precast.WS['Aeolian Edge'] = {
        range = empty,
        ammo = "Sroda Tathlum",
        head = gear.af3_head,
        neck = "Sibyl Scarf",
        ear1 = "Malignance Earring",
        ear2 = "Moonshade Earring",
        body = "Nyame Mail",
        hands = "Jhakri Cuffs +2",
        ring1 = "Epaminondas's Ring",
        ring2 = "Freke Ring",
        back = gear.int_wsd_jse_back,
        waist = "Orpheus's Sash",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }
    sets.precast.WS['Aeolian Edge'].HighBuff = set_combine(sets.precast.WS['Aeolian Edge'], {})

    sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.WS['Aeolian Edge'], {
        neck = "Sibyl Scarf",
        hands = "Jhakri Cuffs +2",
        back = gear.nuke_jse_back
    })
    sets.precast.WS['Red Lotus Blade'].HighBuff = set_combine(sets.precast.WS['Red Lotus Blade'], {})

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = { ear2 = "Brutal Earring" }
    sets.MaxTP['Requiescat'] = { ear2 = "Regal Earring" }
    sets.MaxTP['Black Halo'] = { ear2 = "Ishvara Earring" }
    sets.AccMaxTP = { ear2 = "Telos Earring" }
    sets.AccMaxTP['Black Halo'] = { ear2 = "Crep. Earring" }
    sets.MagicalMaxTP = { ear2 = "Friomisi Earring" }

    -- Midcast Sets

    -- Gear that converts elemental damage done to recover MP.
    sets.midcast.FastRecast = {
        main = "Sakpata's Sword",
        sub = "Sacro Bulwark",
        ammo = "Staunch Tathlum +1",
        head = gear.af1_head,
        neck = "Loricate Torque +1",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_ear2,
        body = gear.af2_body,
        hands = "Bunzi's Gloves",
        ring1 = "Murky Ring",
        ring2 = "Freke Ring",
        back = gear.mnd_enfeebling_jse_back,
        waist = "Emphatikos Rope",
        legs = "Bunzi's Pants",
        feet = "Bunzi's Sabots"
    }

    sets.midcast.Cure = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Regal Gem",
        head = "Kaykaus Mitra +1",
        neck = "Hoxne Torque",
        ear1 = gear.meili_earring,
        ear2 = "Mendi. Earring",
        body = "Kaykaus Bliaut +1",
        hands = "Kaykaus Cuffs +1",
        ring1 = "Naji's Loop",
        ring2 = "Menelaus's Ring",
        back = gear.mnd_enfeebling_jse_back,
        waist = gear.luminary_sash,
        legs = "Kaykaus Tights +1",
        feet = "Kaykaus Boots +1"
    }

    sets.midcast.LightWeatherCure = {
        main = "Chatoyant Staff",
        sub = "Umbra Strap",
        range = empty,
        ammo = "Regal Gem",
        head = "Kaykaus Mitra +1",
        neck = "Hoxne Torque",
        ear1 = gear.meili_earring,
        ear2 = "Mendi. Earring",
        body = "Kaykaus Bliaut +1",
        hands = "Kaykaus Cuffs +1",
        ring1 = "Naji's Loop",
        ring2 = "Menelaus's Ring",
        back = "Twilight Cape",
        waist = "Hachirin-no-Obi",
        legs = "Kaykaus Tights +1",
        feet = "Kaykaus Boots +1"
    }

    --Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Regal Gem",
        head = "Kaykaus Mitra +1",
        neck = "Hoxne Torque",
        ear1 = gear.meili_earring,
        ear2 = "Mendi. Earring",
        body = "Kaykaus Bliaut +1",
        hands = "Kaykaus Cuffs +1",
        ring1 = "Naji's Loop",
        ring2 = "Menelaus's Ring",
        back = "Twilight Cape",
        waist = "Hachirin-no-Obi",
        legs = "Kaykaus Tights +1",
        feet = "Kaykaus Boots +1"
    }

    sets.midcast.Cure.DT = {
        main = "Daybreak",
        sub = "Culminus",
        range = empty,
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head,
        neck = "Loricate Torque +1",
        ear1 = "Halasz Earring",
        ear2 = "Mendi. Earring",
        body = "Bunzi's Robe",
        hands = "Kaykaus Cuffs +1",
        ring1 = "Murky Ring",
        ring2 = "Freke Ring",
        back = gear.mnd_enfeebling_jse_back,
        waist = "Emphatikos Rope",
        legs = "Bunzi's Pants",
        feet = "Bunzi's Sabots"
    }

    sets.midcast.Cursna = {
        main = "Crocea Mors",
        sub = gear.filler_shield,
        range = empty,
        ammo = "Staunch Tathlum +1",
        head = "Kaykaus Mitra +1",
        neck = "Debilis Medallion",
        ear1 = gear.meili_earring,
        ear2 = gear.jse_ear2,
        body = gear.af2_body,
        hands = gear.hieros_mittens,
        ring1 = "Haoma's Ring",
        ring2 = "Menelaus's Ring",
        back = "Oretan. Cape +1",
        waist = gear.bishops_sash,
        legs = gear.af1_legs,
        feet = "Vanya Clogs"
    }

    sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, { main = "Crocea Mors", sub = gear.filler_shield })

    sets.midcast['Enhancing Magic'] = {
        main = gear.Colada,
        sub = "Ammurapi Shield",
        ammo = "Staunch Tathlum +1",
        head = gear.telchine_enhancing_duration_head,
        neck = gear.jse_neck,
        ear1 = "Andoaa Earring",
        ear2 = gear.jse_ear2,
        body = gear.af2_body,
        hands = gear.af1_hands,
        ring1 = "Kishar Ring",
        ring2 = "Lebeche Ring",
        back = gear.ghostfyre_enhancing_duration_cape,
        waist = "Embla Sash",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    -- Duration on others with Composure: 4-piece Lethargy plus Atrophy hands
    -- wins after outside duration gear is included.
    -- Current: 1.35 Composure * 1.89 listed duration * 1.45 augments.
    -- Telchine head: 1.20 Composure * 1.89 listed duration * 1.55 augments.
    -- Telchine head + Viti body: 1.10 Composure * 2.04 listed duration * 1.55 augments.
    -- Lethargy hands: 1.50 Composure * 1.69 listed duration * 1.45 augments.
    sets.buff.ComposureOther = {
        head = gear.af3_head,
        body = gear.af3_body,
        hands = gear.af1_hands,
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    --Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
    --Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
    sets.EnhancingSkill = {
        main = "Pukulatmuj +1",
        sub = "Forfend +1",
        ammo = "Staunch Tathlum +1",
        head = "Befouled Crown",
        neck = "Hoxne Torque",
        ear1 = "Andoaa Earring",
        ear2 = "Mimir Earring",
        body = gear.af2_body,
        hands = gear.af2_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = gear.ghostfyre_enhancing_skill_cape,
        waist = "Olympus Sash",
        legs = gear.af1_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Refresh = { head = "Amalric Coif +1", body = gear.af1_body, legs = gear.af3_legs }
    sets.midcast.Aquaveil = {
        head = "Amalric Coif +1",
        hands = "Regal Cuffs",
        waist = "Emphatikos Rope",
        legs = "Shedir Seraweels"
    } --hands="Regal Cuffs"
    sets.midcast.BarElement = { legs = "Shedir Seraweels" }
    sets.midcast.BarStatus = { neck = "Sroda Necklace" }
    sets.midcast.Temper = sets.EnhancingSkill
    sets.midcast.Enspell = sets.EnhancingSkill
    sets.midcast.BoostStat = { hands = gear.af2_hands }
    sets.midcast.Stoneskin = { neck = "Nodens Gorget", legs = "Shedir Seraweels" }
    sets.midcast.Protect = { ring2 = "Sheltered Ring" }
    sets.midcast.Shell = { ring2 = "Sheltered Ring" }
    sets.midcast.Regen = { main = "Crocea Mors", sub = "Ammurapi Shield" }
    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Curaga = sets.midcast.Cure
    sets.Self_Healing = { ear1 = "Etiolation Earring", waist = "Gishdubar Sash" }
    sets.Cure_Received = { waist = "Gishdubar Sash" }
    sets.Self_Refresh = { waist = "Gishdubar Sash" }
    sets.Self_Phalanx = {
        main = "Sakpata's Sword" --[[,
        head = "Taeon Chapeau",
        body = "Taeon Tabard",
        hands = "Taeon Gloves",
        back = gear.mnd_enfeebling_jse_back,
        legs = "Taeon Tights",
        feet = "Taeon Boots",
        ammo = "Staunch Tathlum +1"]]
    }
    sets.Self_Phalanx.DW = { main = "Sakpata's Sword", sub = "Egeking" }

    sets.midcast['Enfeebling Magic'] = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Regal Gem",
        head = gear.af2_head,
        neck = gear.jse_neck,
        ear1 = "Malignance Earring",
        ear2 = "Snotra Earring",
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamorph Ring +1",
        back = gear.mnd_enfeebling_jse_back,
        waist = gear.obstinate_sash,
        legs = gear.af3_legs,
        feet = gear.af2_feet
    }

    sets.midcast['Enfeebling Magic'].Resistant = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        range = "Ullr",
        ammo = empty,
        head = gear.af1_head,
        neck = "Null Loop",
        ear1 = "Regal Earring",
        ear2 = "Snotra Earring",
        body = gear.af1_body,
        hands = gear.af3_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamorph Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.chironic_macc_legs,
        feet = gear.af1_feet
    }

    sets.midcast['Enfeebling Magic'].DW = { main = "Bunzi's Rod", sub = "Maxentius" }

    sets.midcast.Sleep = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        range = "Ullr",
        ammo = empty,
        head = gear.af3_head,
        neck = gear.jse_neck,
        ear1 = "Malignance Earring",
        ear2 = "Snotra Earring",
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Kishar Ring",
        ring2 = "Metamorph Ring +1",
        back = "Null Shawl",
        waist = gear.obstinate_sash,
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Bind = sets.midcast.Sleep
    sets.midcast.Break = sets.midcast.Sleep
    sets.midcast['Dia III'] = sets.midcast.Sleep
    sets.midcast['Bio III'] = sets.midcast.Sleep
    sets.midcast.Inundation = sets.midcast.Sleep

    sets.midcast.Dia = set_combine(sets.midcast.Sleep, sets.TreasureHunter)
    sets.midcast.Diaga = set_combine(sets.midcast.Sleep, sets.TreasureHunter)
    sets.midcast.Bio = set_combine(sets.midcast.Sleep, sets.TreasureHunter)

    sets.midcast.Sleep.Resistant = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        range = "Ullr",
        ammo = empty,
        head = gear.af1_head,
        neck = "Null Loop",
        ear1 = "Regal Earring",
        ear2 = "Snotra Earring",
        body = gear.af1_body,
        hands = gear.af3_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamorph Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.chironic_macc_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Bind.Resistant = sets.midcast.Sleep.Resistant
    sets.midcast.Break.Resistant = sets.midcast.Sleep.Resistant

    sets.midcast.Sleep.DW = { main = "Bunzi's Rod", sub = "Maxentius" }
    sets.midcast.Bind.DW = sets.midcast.Sleep.DW
    sets.midcast.Break.DW = sets.midcast.Sleep.DW

    sets.midcast.Dispel = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        range = "Ullr",
        ammo = empty,
        head = gear.af1_head,
        neck = gear.jse_neck,
        ear1 = "Regal Earring",
        ear2 = "Snotra Earring",
        body = gear.af1_body,
        hands = gear.af3_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamorph Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af1_legs,
        feet = gear.af1_feet
    }

    sets.midcast.Dispel.DW = { main = "Bunzi's Rod", sub = "Maxentius" }
    sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, { main = "Daybreak", sub = "Ammurapi Shield" })
    sets.midcast.Dispelga.DW = { main = "Daybreak", sub = "Bunzi's Rod" }

    sets.midcast.Frazzle = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Regal Gem",
        head = gear.af3_head,
        neck = gear.jse_neck,
        ear1 = "Malignance Earring",
        ear2 = "Snotra Earring",
        body = gear.af3_body,
        hands = "Regal Cuffs",
        ring1 = "Kishar Ring",
        ring2 = "Metamorph Ring +1",
        back = gear.mnd_enfeebling_jse_back,
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af2_feet
    }

    sets.midcast.Distract = sets.midcast.Frazzle

    sets.midcast.Frazzle.Resistant = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Regal Gem",
        head = gear.af1_head,
        neck = gear.jse_neck,
        ear1 = "Regal Earring",
        ear2 = "Snotra Earring",
        body = gear.af3_body,
        hands = "Regal Cuffs",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamorph Ring +1",
        back = gear.mnd_enfeebling_jse_back,
        waist = "Null Belt",
        legs = gear.chironic_macc_legs,
        feet = gear.af2_feet
    }

    sets.midcast.Distract.Resistant = sets.midcast.Frazzle.Resistant

    sets.midcast['Frazzle II'] = sets.midcast.Frazzle.Resistant
    sets.midcast.Frazzle.DW = { main = "Bunzi's Rod", sub = "Daybreak" }
    sets.midcast.Distract.DW = sets.midcast.Frazzle.DW

    sets.midcast.Addle = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Regal Gem",
        head = gear.af3_head,
        neck = gear.jse_neck,
        ear1 = "Malignance Earring",
        ear2 = "Snotra Earring",
        body = gear.af3_body,
        hands = "Regal Cuffs",
        ring1 = "Kishar Ring",
        ring2 = "Metamorph Ring +1",
        back = gear.mnd_enfeebling_jse_back,
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af2_feet
    }

    sets.midcast.Paralyze = sets.midcast.Addle
    sets.midcast.Slow = sets.midcast.Addle

    sets.midcast.Addle.Resistant = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Regal Gem",
        head = gear.af1_head,
        neck = gear.jse_neck,
        ear1 = "Regal Earring",
        ear2 = "Snotra Earring",
        body = gear.af3_body,
        hands = "Regal Cuffs",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamorph Ring +1",
        back = gear.mnd_enfeebling_jse_back,
        waist = "Null Belt",
        legs = gear.chironic_macc_legs,
        feet = gear.af2_feet
    }

    sets.midcast.Paralyze.Resistant = sets.midcast.Addle.Resistant
    sets.midcast.Slow.Resistant = sets.midcast.Addle.Resistant

    sets.midcast.Addle.DW = { main = "Bunzi's Rod", sub = "Daybreak" }
    sets.midcast.Paralyze.DW = sets.midcast.Addle.DW
    sets.midcast.Slow.DW = sets.midcast.Addle.DW

    sets.midcast.Gravity = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Regal Gem",
        head = gear.af3_head,
        neck = gear.jse_neck,
        ear1 = "Malignance Earring",
        ear2 = "Snotra Earring",
        body = gear.af3_body,
        hands = "Regal Cuffs",
        ring1 = "Kishar Ring",
        ring2 = "Metamorph Ring +1",
        back = gear.int_enfeebling_jse_back,
        waist = "Null Belt", -- Embla Sash
        legs = gear.af3_legs,
        feet = gear.af2_feet
    }

    sets.midcast.Gravity.Resistant = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Regal Gem",
        head = gear.af1_head,
        neck = gear.jse_neck,
        ear1 = "Regal Earring",
        ear2 = "Snotra Earring",
        body = gear.af3_body,
        hands = "Regal Cuffs",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamorph Ring +1",
        back = gear.int_enfeebling_jse_back,
        waist = "Null Belt",
        legs = gear.chironic_macc_legs,
        feet = gear.af2_feet
    }

    sets.midcast.Gravity.DW = { main = "Bunzi's Rod", sub = "Maxentius" }

    sets.midcast.Poison = sets.midcast.Gravity
    sets.midcast.Poison.Resistant = sets.midcast.Gravity.Resistant
    sets.midcast.Poison.DW = sets.midcast.Gravity.DW

    sets.midcast.Blind = sets.midcast.Gravity
    sets.midcast.Blind.Resistant = sets.midcast.Gravity.Resistant
    sets.midcast.Blind.DW = sets.midcast.Gravity.DW

    sets.midcast.Silence = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        range = "Ullr",
        ammo = empty,
        head = gear.af3_head,
        neck = gear.jse_neck,
        ear1 = "Malignance Earring",
        ear2 = "Snotra Earring",
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Kishar Ring",
        ring2 = "Metamorph Ring +1",
        back = "Null Shawl",
        waist = gear.obstinate_sash,
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Silence.Resistant = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        range = "Ullr",
        ammo = empty,
        head = gear.af1_head,
        neck = "Null Loop",
        ear1 = "Regal Earring",
        ear2 = "Snotra Earring",
        body = gear.af1_body,
        hands = gear.af3_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamorph Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.chironic_macc_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Silence.DW = { main = "Bunzi's Rod", sub = "Daybreak" }

    sets.midcast['Elemental Magic'] = {
        main = "Telopanos Saber",
        sub = "Culminus",
        ammo = "Ghastly Tathlum +1",
        head = gear.af3_head,
        neck = gear.baetyl_pendant,
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Freke Ring",
        ring2 = "Metamorph Ring +1",
        back = gear.nuke_jse_back,
        waist = "Sacro Cord",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast['Elemental Magic'].DT = {
        main = "Telopanos Saber",
        sub = "Culminus",
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head,
        neck = "Loricate Torque +1",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Freke Ring",
        ring2 = "Metamorph Ring +1",
        back = gear.nuke_jse_back,
        waist = "Emphatikos Rope",
        legs = "Bunzi's Pants",
        feet = gear.af3_feet
    }

    sets.midcast['Elemental Magic'].Resistant = {
        main = "Telopanos Saber",
        sub = "Ammurapi Shield",
        range = "Ullr",
        ammo = empty,
        head = gear.af3_head,
        neck = "Sibyl Scarf",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Freke Ring",
        ring2 = "Metamorph Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast['Elemental Magic'].Proc = {
        main = "Gleti's Knife",
        sub = "Forfend +1",
        range = empty,
        ammo = "Regal Gem",
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Snotra Earring",
        ear2 = gear.jse_ear2,
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Kishar Ring",
        ring2 = "Prolix Ring",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.midcast['Elemental Magic'].HighTierNuke = {
        main = "Telopanos Saber",
        sub = "Ammurapi Shield",
        ammo = "Ghastly Tathlum +1",
        head = gear.af3_head,
        neck = "Sibyl Scarf",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Freke Ring",
        ring2 = "Metamorph Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {
        main = "Telopanos Saber",
        sub = "Ammurapi Shield",
        range = "Ullr",
        ammo = empty,
        head = gear.af3_head,
        neck = "Sibyl Scarf",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Freke Ring",
        ring2 = "Metamorph Ring +1",
        gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    -- Thunder V maps to HighTierNuke; this mode favors TP gain over magic damage.
    sets.midcast['Elemental Magic'].HighTierNuke.OccultAcumen = {
        main = "Telopanos Saber",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Aurgelmir Orb +1",
        head = gear.merlinic_oa_head,
        neck = "Null Loop",
        ear1 = "Dedition Earring",
        ear2 = "Crep. Earring",
        body = gear.merlinic_oa_body,
        hands = gear.merlinic_oa_hands,
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Oneiros Rope",
        legs = "Perdition Slops",
        feet = gear.merlinic_oa_feet
    }

    -- Gear that Recovers MP when nuking.
    -- sets.RecoverMP = {body=gear.seidr_cotehardie}

    -- Gear for Magic Burst mode.
    sets.MagicBurst = {
        main = "Telopanos Saber",
        sub = "Ammurapi Shield",
        neck = "Mizu. Kubikazari",
        hands = "Bunzi's Gloves",
        ring1 = "Mujin Band"
    }
    sets.midcast['Elemental Magic'].DW = { main = "Telopanos Saber", sub = "Bunzi's Rod" }

    sets.midcast.Impact = {
        main = "Telopanos Saber",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Regal Gem",
        head = empty,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = "Snotra Earring",
        body = gear.crepuscular_cloak,
        hands = gear.af3_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamorph Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].HighTierNuke.OccultAcumen, {
        head = empty,
        body = gear.crepuscular_cloak
    })

    sets.midcast['Dark Magic'] = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Regal Gem",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = "Snotra Earring",
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamorph Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Drain = {
        main = "Crocea Mors",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Regal Gem",
        head = "Pixie Hairpin +1",
        neck = "Erra Pendant",
        ear1 = "Malignance Earring",
        ear2 = "Snotra Earring",
        body = gear.af1_body,
        hands = gear.af1_hands,
        ring1 = "Evanescence Ring",
        ring2 = "Metamorph Ring +1",
        back = gear.nuke_jse_back,
        waist = "Fucho-no-obi",
        legs = gear.af1_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Aspir = set_combine(sets.midcast.Drain, {})
    sets.midcast.Aspir.OccultAcumen = set_combine(sets.midcast.Aspir, {})

    sets.midcast['Absorb-TP'] = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        range = "Ullr",
        ammo = empty,
        head = "Carmine Mask +1",
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_ear2,
        body = gear.af2_body,
        hands = gear.af3_hands,
        ring1 = "Kishar Ring",
        ring2 = "Lebeche Ring",
        back = gear.absorb_tp_recast_jse_back,
        waist = "Witful Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast['Absorb-TP'].Resistant = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        range = "Ullr",
        ammo = empty,
        head = "Carmine Mask +1",
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_ear2,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Kishar Ring",
        ring2 = "Lebeche Ring",
        back = gear.absorb_tp_recast_jse_back,
        waist = "Witful Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Stun = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        range = "Ullr",
        ammo = empty,
        head = gear.af1_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_ear2,
        body = gear.af2_body,
        hands = gear.af3_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamorph Ring +1",
        back = gear.mnd_enfeebling_jse_back,
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Stun.Resistant = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        range = "Ullr",
        ammo = empty,
        head = gear.af1_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_ear2,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = "Metamorph Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Stun.DW = { main = "Bunzi's Rod", sub = "Maxentius" }

    -- Sets for special buff conditions on spells.

    sets.buff.Saboteur = { hands = gear.af3_hands }

    sets.buff.Doom = set_combine(sets.buff.Doom, {})

    -- Sets to return to when not performing an action.

    -- Idle sets
    sets.idle = {
        main = "Mpaca's Staff",
        sub = "Umbra Strap",
        ammo = gear.homillary,
        head = gear.af2_head,
        neck = "Sibyl Scarf",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.idle.PDT = {
        main = "Daybreak",
        sub = "Archduke's Shield",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Adamantite Armor",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = "Shadow Ring",
        back = gear.shadow_mantle,
        waist = "Plat. Mog. Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.idle.MDT = {
        main = "Daybreak",
        sub = "Archduke's Shield",
        range = empty,
        ammo = "Staunch Tathlum +1",
        head = "Bunzi's Hat",
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Bunzi's Robe",
        hands = "Bunzi's Gloves",
        ring1 = "Murky Ring",
        ring2 = "Shadow Ring",
        back = gear.engulfer_cape,
        waist = "Null Belt",
        legs = "Bunzi's Pants",
        feet = "Bunzi's Sabots"
    }

    sets.idle.MEVA = {
        main = "Daybreak",
        sub = "Archduke's Shield",
        range = empty,
        ammo = "Staunch Tathlum +1",
        head = "Bunzi's Hat",
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Bunzi's Robe",
        hands = "Bunzi's Gloves",
        ring1 = "Murky Ring",
        ring2 = "Shadow Ring",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Bunzi's Pants",
        feet = "Bunzi's Sabots"
    }

    sets.idle.Aminon = {
        main = "Daybreak",
        sub = "Archduke's Shield",
        range = empty,
        ammo = "Staunch Tathlum +1",
        head = gear.null_masque,
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Bunzi's Robe",
        hands = "Bunzi's Gloves",
        ring1 = "Murky Ring",
        ring2 = "Shadow Ring",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Bunzi's Pants",
        feet = "Bunzi's Sabots"
    }

    -- Defense sets
    sets.defense.PDT = {
        main = "Daybreak",
        sub = "Sacro Bulwark",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Adamantite Armor",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = "Shadow Ring",
        back = gear.shadow_mantle,
        waist = "Plat. Mog. Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.NukeLock = sets.midcast['Elemental Magic']

    sets.defense.MDT = {
        main = "Daybreak",
        sub = "Sacro Bulwark",
        range = empty,
        ammo = "Staunch Tathlum +1",
        head = "Bunzi's Hat",
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Bunzi's Robe",
        hands = "Bunzi's Gloves",
        ring1 = "Murky Ring",
        ring2 = "Shadow Ring",
        back = gear.engulfer_cape,
        waist = "Null Belt",
        legs = "Bunzi's Pants",
        feet = "Bunzi's Sabots"
    }

    sets.defense.MEVA = {
        main = "Daybreak",
        sub = "Sacro Bulwark",
        range = empty,
        ammo = "Staunch Tathlum +1",
        head = "Bunzi's Hat",
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Bunzi's Robe",
        hands = "Bunzi's Gloves",
        ring1 = "Murky Ring",
        ring2 = "Shadow Ring",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Bunzi's Pants",
        feet = "Bunzi's Sabots"
    }

    sets.Kiting = { ring2 = "Shneddick Ring" }
    sets.latent_refresh = { waist = "Fucho-no-obi" }
    sets.DayIdle = {}
    sets.NightIdle = {}

    sets.buff.Sublimation = { waist = "Embla Sash" }
    sets.buff.DTSublimation = { waist = "Embla Sash" }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.Dagger.Accuracy.Evasion

    -- Normal melee group

    sets.engaged = {
        ammo = "Coiste Bodhar",
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Windbuffet Belt +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.Acc = {
        ammo = "Coiste Bodhar",
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

    sets.engaged.DT = {
        ammo = "Coiste Bodhar",
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Sherida Earring",
        ear2 = "Dedition Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Murky Ring",
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Windbuffet Belt +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.Acc.DT = {
        ammo = "Coiste Bodhar",
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Murky Ring",
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.DW = {
        ammo = "Coiste Bodhar",
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = gear.dw_jse_back,
        waist = "Windbuffet Belt +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.DW.Acc = {
        ammo = "Coiste Bodhar",
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = gear.dw_jse_back,
        waist = "Null Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.DW.DT = {
        ammo = "Coiste Bodhar",
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Sherida Earring",
        ear2 = "Dedition Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Murky Ring",
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = gear.dw_jse_back,
        waist = "Windbuffet Belt +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.DW.Acc.DT = {
        ammo = "Coiste Bodhar",
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Murky Ring",
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = gear.dw_jse_back,
        waist = "Null Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    --[[sets.engaged.EnspellOnly = {
        range = "Ullr",
        ammo = empty,
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Suppanomimi",
        ear2 = gear.jse_ear2,
        body = "Sworn Platemail",
        hands = "Aya. Manopolas +2",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = gear.dw_jse_back,
        waist = "Orpheus's Sash",
        legs = "Malignance Tights",
        -- legs = "Sworn Brais", TOO MUCH DMG, NO LONGER 0
        feet = "Malignance Boots"
    }

    sets.engaged.EnspellOnly.Acc = {
        range = "Ullr",
        ammo = empty,
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Suppanomimi",
        ear2 = gear.jse_ear2,
        body = "Sworn Platemail",
        hands = "Aya. Manopolas +2",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = gear.dw_jse_back,
        waist = "Orpheus's Sash",
        legs = "Malignance Tights",
        -- legs = "Sworn Brais", TOO MUCH DMG, NO LONGER 0
        feet = "Malignance Boots"
    }]]

    sets.engaged.DualEnspellOnly = {
        range = "Ullr",
        ammo = empty,
        head = "Sworn Crown",
        neck = "Bathy Choker",
        ear1 = "Digni. Earring",
        ear2 = "Crepuscular Earring",
        body = "Sworn Platemail",
        hands = "Aya. Manopolas +2",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = gear.enspell_jse_back,
        waist = "Orpheus's Sash",
        legs = "Sworn Brais",
        feet = "Sworn Sabatons"
    }

    sets.engaged.DualEnspellOnly.Acc = {
        range = "Ullr",
        ammo = empty,
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Suppanomimi",
        ear2 = gear.jse_ear2,
        body = "Sworn Platemail",
        hands = "Aya. Manopolas +2",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = gear.dw_jse_back,
        waist = "Orpheus's Sash",
        legs = "Malignance Tights",
        -- legs = "Sworn Brais", TOO MUCH DMG, NO LONGER 0
        feet = "Malignance Boots"
    }
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
    if player.sub_job == 'SCH' then
        set_macro_page(2, 4)
    else
        set_macro_page(1, 4)
    end
end

function user_job_buff_change(buff, gain)
    if buff:startswith('Addendum: ') or buff:endswith(' Arts') then
        style_lock = true
    end
end

function user_job_lockstyle()
    if player.sub_job == 'SCH' then
        if state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
            windower.chat.input('/lockstyleset 017')
        elseif state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
            windower.chat.input('/lockstyleset 017')
        else
            windower.chat.input('/lockstyleset 017')
        end
    elseif player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        windower.chat.input('/lockstyleset 017')
    else
        windower.chat.input('/lockstyleset 017')
    end
end

buff_spell_lists = {
    Auto = { --Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
        { Name = 'Refresh III', Buff = 'Refresh',     SpellID = 894, When = 'Always' },
        { Name = 'Haste II',    Buff = 'Haste',       SpellID = 511, When = 'Always' },
        { Name = 'Aurorastorm', Buff = 'Aurorastorm', SpellID = 119, When = 'Idle' },
        { Name = 'Reraise',     Buff = 'Reraise',     SpellID = 135, When = 'Always' },
    },

    AutoMelee = {
        { Name = 'Phalanx II', Buff = 'Phalanx',       SpellID = 107, When = 'Combat' },
        { Name = 'Haste II',   Buff = 'Haste',         SpellID = 511, When = 'Combat' },
        { Name = 'Temper II',  Buff = 'Multi Strikes', SpellID = 895, When = 'Combat' },
        --{Name='Refresh III',	Buff='Refresh',			SpellID=894,	When='Always'},
        { Name = 'Gain-STR',   Buff = 'STR Boost',     SpellID = 486, When = 'Combat' },
    },

    AutoMage = {
        { Name = 'Phalanx II',  Buff = 'Phalanx',   SpellID = 107, When = 'Always' },
        { Name = 'Haste II',    Buff = 'Haste',     SpellID = 511, When = 'Always' },
        { Name = 'Refresh III', Buff = 'Refresh',   SpellID = 894, When = 'Always' },
        { Name = 'Refresh III', Buff = 'Refresh',   SpellID = 894, When = 'Always' },
        { Name = 'Gain-INT',    Buff = 'INT Boost', SpellID = 490, When = 'Always' },
        { Name = 'Aquaveil',    Buff = 'Aquaveil',  SpellID = 55,  When = 'Always' },
        { Name = 'Blink',       Buff = 'Blink',     SpellID = 53,  When = 'Always' },
        { Name = 'Shell V',     Buff = 'Shell',     SpellID = 52,  When = 'Always' },
        { Name = 'Protect V',   Buff = 'Protect',   SpellID = 47,  When = 'Always' },
        { Name = 'Stoneskin',   Buff = 'Stoneskin', SpellID = 54,  When = 'Always' },
    },

    Default = {
        { Name = 'Haste II',    Buff = 'Haste',     SpellID = 511, Reapply = false },
        { Name = 'Refresh III', Buff = 'Refresh',   SpellID = 894, Reapply = false },
        { Name = 'Gain-MND',    Buff = 'MND Boost', SpellID = 491, Reapply = false },
        { Name = 'Aquaveil',    Buff = 'Aquaveil',  SpellID = 55,  Reapply = false },
        { Name = 'Phalanx II',  Buff = 'Phalanx',   SpellID = 107, Reapply = false },
        { Name = 'Stoneskin',   Buff = 'Stoneskin', SpellID = 54,  Reapply = false },
        { Name = 'Blink',       Buff = 'Blink',     SpellID = 53,  Reapply = false },
        { Name = 'Shell V',     Buff = 'Shell',     SpellID = 52,  Reapply = false },
        { Name = 'Protect V',   Buff = 'Protect',   SpellID = 47,  Reapply = false },
    },

    MageBuff = {
        { Name = 'Haste II',    Buff = 'Haste',     SpellID = 511, Reapply = false },
        { Name = 'Refresh III', Buff = 'Refresh',   SpellID = 894, Reapply = false },
        { Name = 'Gain-INT',    Buff = 'INT Boost', SpellID = 490, Reapply = false },
        { Name = 'Aquaveil',    Buff = 'Aquaveil',  SpellID = 55,  Reapply = false },
        { Name = 'Phalanx II',  Buff = 'Phalanx',   SpellID = 107, Reapply = false },
        { Name = 'Stoneskin',   Buff = 'Stoneskin', SpellID = 54,  Reapply = false },
        { Name = 'Blink',       Buff = 'Blink',     SpellID = 53,  Reapply = false },
        { Name = 'Shell V',     Buff = 'Shell',     SpellID = 52,  Reapply = false },
        { Name = 'Protect V',   Buff = 'Protect',   SpellID = 47,  Reapply = false },
    },

    FullMeleeBuff = {
        { Name = 'Haste II',    Buff = 'Haste',         SpellID = 511, Reapply = false },
        { Name = 'Refresh III', Buff = 'Refresh',       SpellID = 894, Reapply = false },
        { Name = 'Phalanx II',  Buff = 'Phalanx',       SpellID = 107, Reapply = false },
        { Name = 'Temper II',   Buff = 'Multi Strikes', SpellID = 895, Reapply = false },
        { Name = 'Gain-STR',    Buff = 'STR Boost',     SpellID = 486, Reapply = false },
        --{Name='Enthunder',		Buff='Enthunder',		SpellID=104,	Reapply=false},
        --{Name='Shock Spikes',	Buff='Shock Spikes',	SpellID=251,	Reapply=false},
        { Name = 'Shell V',     Buff = 'Shell',         SpellID = 52,  Reapply = false },
        { Name = 'Protect V',   Buff = 'Protect',       SpellID = 47,  Reapply = false },
        --{Name='Barblizzard',	Buff='Barblizzard',		SpellID=61,		Reapply=false},
        --{Name='Barparalyze',	Buff='Barparalyze',		SpellID=74,		Reapply=false},
        { Name = 'Aquaveil',    Buff = 'Aquaveil',      SpellID = 55,  Reapply = false },
        { Name = 'Regen II',    Buff = 'Regen',         SpellID = 110, Reapply = false },
        { Name = 'Stoneskin',   Buff = 'Stoneskin',     SpellID = 54,  Reapply = false },
        { Name = 'Blink',       Buff = 'Blink',         SpellID = 53,  Reapply = false },
    },

    MeleeBuff = {
        { Name = 'Haste II',     Buff = 'Haste',         SpellID = 511, Reapply = false },
        { Name = 'Refresh III',  Buff = 'Refresh',       SpellID = 894, Reapply = false },
        { Name = 'Phalanx II',   Buff = 'Phalanx',       SpellID = 107, Reapply = false },
        { Name = 'Temper II',    Buff = 'Multi Strikes', SpellID = 895, Reapply = false },
        { Name = 'Gain-STR',     Buff = 'STR Boost',     SpellID = 486, Reapply = false },
        { Name = 'Enthunder',    Buff = 'Enthunder',     SpellID = 104, Reapply = false },
        { Name = 'Shock Spikes', Buff = 'Shock Spikes',  SpellID = 251, Reapply = false },
    },

    Odin = {
        { Name = 'Refresh III', Buff = 'Refresh',       SpellID = 894, Reapply = false },
        { Name = 'Haste II',    Buff = 'Haste',         SpellID = 511, Reapply = false },
        { Name = 'Phalanx II',  Buff = 'Phalanx',       SpellID = 107, Reapply = false },
        { Name = 'Gain-INT',    Buff = 'INT Boost',     SpellID = 490, Reapply = false },
        { Name = 'Temper II',   Buff = 'Multi Strikes', SpellID = 895, Reapply = false },
        { Name = 'Regen II',    Buff = 'Regen',         SpellID = 110, Reapply = false },
        { Name = 'Enaero',      Buff = 'Enaero',        SpellID = 102, Reapply = false },
        { Name = 'Stoneskin',   Buff = 'Stoneskin',     SpellID = 54,  Reapply = false },
        { Name = 'Shell V',     Buff = 'Shell',         SpellID = 52,  Reapply = false },
        { Name = 'Protect V',   Buff = 'Protect',       SpellID = 47,  Reapply = false },
    },

    HybridCleave = {
        { Name = 'Refresh III',  Buff = 'Refresh',       SpellID = 894, Reapply = false },
        { Name = 'Haste II',     Buff = 'Haste',         SpellID = 511, Reapply = false },
        { Name = 'Phalanx II',   Buff = 'Phalanx',       SpellID = 107, Reapply = false },
        { Name = 'Gain-INT',     Buff = 'INT Boost',     SpellID = 490, Reapply = false },
        { Name = 'Enthunder II', Buff = 'Enthunder II',  SpellID = 316, Reapply = false },
        { Name = 'Temper II',    Buff = 'Multi Strikes', SpellID = 895, Reapply = false },
        { Name = 'Shell V',      Buff = 'Shell',         SpellID = 52,  Reapply = false },
        { Name = 'Protect V',    Buff = 'Protect',       SpellID = 47,  Reapply = false },
    },
}
