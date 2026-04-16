function character_user_job_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'HighBuff')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'FullAcc')
    state.CastingMode:options('Normal', 'SIRD', 'Resistant', 'FullMacc')
    state.IdleMode:options('Normal', 'PDT')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('Tizbron', 'Tiztongue', 'None', 'MeleeClubs', 'HybridWeapons', 'Naegbron', 'Naegtongue')

    gear.stp_jse_back = { name = "Rosmerta's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Store TP"+10', 'Phys. dmg. taken-10%', } }
    gear.wsd_jse_back = { name = "Rosmerta's Cape", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', } }
    --gear.nuke_jse_back = { name = "Rosmerta's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', '"Mag.Atk.Bns."+10', } }

    gear.jse_neck = "Mirage Stole +2"
    -- Artifact Gear
    gear.af1_head = ""
    gear.af1_body = "Assim. Jubbah +4"
    gear.af1_hands = ""
    gear.af1_legs = ""
    gear.af1_feet = ""

    -- Relic Gear
    gear.af2_head = ""
    gear.af2_body = ""
    gear.af2_hands = ""
    gear.af2_legs = "Luh. Shalwar +4"
    gear.af2_feet = ""

    -- Empy Gear
    gear.af3_head = "Hashishin Kavuk +3"
    gear.af3_body = "Hashishin Minitan +2"
    gear.af3_hands = "Hashi. Bazu. +2"
    gear.af3_legs = "Hashishin Tayt +2"
    gear.af3_feet = "Hashi. Basmak +2"


    autows = 'Expiacion'

    -- Additional local binds
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind @` input /ja "Efflux" <me>')
    send_command('bind !` input /ja "Burst Affinity" <me>')
    send_command('bind ^@!` gs c cycle SkillchainMode')
    send_command(
        'bind ^backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Mighty Guard" <me>')
    send_command(
        'bind !backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Carcharian Verve" <me>')
    send_command('bind @backspace input /ja "Convergence" <me>')
    send_command('bind @f10 gs c toggle LearningMode')
    send_command('bind ^@!` gs c cycle MagicBurstMode')
    send_command('bind @f8 gs c toggle AutoNukeMode')

    select_default_macro_book()
end

function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.buff['Burst Affinity'] = { legs = gear.af1_legs, feet = gear.af3_feet }
    sets.buff['Chain Affinity'] = { feet = gear.af1_feet }
    sets.buff.Convergence = { head = gear.af2_head }
    sets.buff.Diffusion = { feet = gear.af2_feet }
    sets.buff.Enchainment = {}
    sets.buff.Efflux = { back = gear.da_jse_back, legs = gear.af3_legs }
    sets.buff.Doom = set_combine(sets.buff.Doom, {})

    -- Precast Sets

    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = { hands = gear.af2_hands }

    -- Fast cast sets for spells

    sets.precast.FC = {
        main = "Vampirism", -- MISSING
        sub = "Sakpata's Sword",
        ammo = "Impatiens",
        head = "Carmine Mask +1",     -- MISSING
        neck = "Voltsurge Torque",    -- MISSING
        ear1 = "Enchntr. Earring +1", -- MISSING
        ear2 = "Loquac. Earring",
        body = gear.af2_body,
        hands = "Leyline Gloves",   -- MISSING
        ring1 = "Kishar Ring",      -- MISSING
        ring2 = "Lebeche Ring",
        back = "Perimede Cape",     -- MISSING
        waist = "Witful Belt",      -- MISSING
        legs = "Psycloth Lappas",   -- MISSING
        feet = "Carmine Greaves +1" -- MISSING
    }

    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, { body = gear.af3_body })


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = "Coisted Bodhar",
        head = gear.af3_head,
        neck = gear.jse_neck,
        ear1 = "Moonshade Earring",
        ear2 = "Ishvara Earring",
        body = gear.af1_body,
        hands = "Jhakri Cuffs +2",
        ring1 = "Epaminondas's Ring",
        ring2 = "Sroda Ring",
        back = gear.wsd_jse_back,
        waist = "Sailfi Belt +1",
        legs = gear.af2_legs,
        feet = "Nyame Flanchard"
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    sets.precast.WS.HighBuff = set_combine(sets.precast.WS, {
        ammo = "Crepuscular Pebble",
        hands = "Gleti's Gauntlets",
        --waist = "Kentarch Belt +1",
        ring2 = "Sroda Ring"
    })

    sets.precast.WS.DT = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        neck = gear.fotia_gorget,
        ear2 = gear.regal_earring,
        ring1 = "Metamor. Ring +1",
        ring2 = "Epona's Ring",
        waist = gear.fotia_belt
    })

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {
        neck = gear.fotia_gorget,
        ear2 = gear.regal_earring,
        ring1 = "Metamor. Ring +1",
        ring2 = "Epona's Ring",
        waist = gear.fotia_belt
    })

    sets.precast.WS['Requiescat'].HighBuff = set_combine(sets.precast.WS.HighBuff, {
        head = gear.null_masque,
        neck = gear.fotia_gorget,
        ear1 = "Brutal Earring",
        ear2 = gear.regal_earring,
        body = "Gleti's Cuirass",
        ring1 = "Metamor. Ring +1",
        ring2 = "Sroda Ring",
        waist = gear.fotia_belt,
        legs = "Gleti's Breeches"
    })

    sets.precast.WS['Requiescat'].DT = set_combine(sets.precast.WS.DT, {})

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Savage Blade'].HighBuff = set_combine(sets.precast.WS.HighBuff, {})
    sets.precast.WS['Savage Blade'].DT = set_combine(sets.precast.WS.DT, {})

    sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Expiacion'].HighBuff = set_combine(sets.precast.WS.HighBuff, {})
    sets.precast.WS['Expiacion'].DT = set_combine(sets.precast.WS.DT, {})

    sets.precast.WS['Sanguine Blade'] = {
        ammo = "Ghastly Tathlum +1",
        head = "Pixie Hairpin +1",
        neck = gear.sibyl_scarf, --"Baetyl Pendant", -- Sibyl Scarf
        ear1 = gear.regal_earring,
        ear2 = "Friomisi Earring",
        body = gear.nyame_mail, -- "Amalric Doublet +1",
        hands = "Jhakri Cuffs +2",
        ring1 = "Epaminondas's Ring",
        ring2 = gear.archon_ring,     -- "Metamor. Ring +1",
        back = gear.int_wsd_jse_back, -- str wsd back
        waist = "Orpheus's Sash",
        legs = gear.af2_legs,
        feet = gear.af3_feet
    }
    sets.precast.WS['Sanguine Blade'].DT = set_combine(sets.precast.WS.DT, { back = gear.nuke_jse_back })

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = { ear1 = "Cessance Earring", ear2 = "Brutal Earring" }
    sets.AccMaxTP = { ear1 = "Regal Earring", ear2 = "Telos Earring" }

    -- Midcast Sets
    sets.midcast.FastRecast = {
        main = "Vampirism",
        sub = "Sakpata's Sword",
        ammo = "Hasty Pinion +1",
        head = "Carmine Mask +1",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Loquac. Earring",
        body = gear.af2_body,
        hands = "Leyline Gloves",
        ring1 = "Kishar Ring",
        ring2 = "Prolix Ring",
        back = "Swith Cape +1",
        waist = "Witful Belt",
        legs = "Psycloth Lappas",
        feet = "Carmine Greaves +1"
    }

    sets.midcast['Blue Magic'] = {}

    -- Physical Spells --

    sets.midcast['Blue Magic'].Physical = {
        main = "Vampirism",
        sub = "Vampirism",
        ammo = "Mavi Tathlum",
        head = "Lilitu Headpiece",
        neck = "Mirage Stole +2",
        ear1 = "Suppanomimi",
        ear2 = "Telos Earring",
        body = "Jhakri Robe +2",
        hands = "Jhakri Cuffs +2",
        ring1 = "Ifrit Ring +1",
        ring2 = "Ilabrat Ring",
        back = gear.wsd_jse_back,
        waist = "Grunfeld Rope",
        legs = "Jhakri Slops +2",
        feet = "Jhakri Pigaches +2"
    }

    -- Magical Spells --

    sets.midcast['Blue Magic'].Magical = {
        main = "Bunzi's Rod",
        sub = "Maxentius",
        ammo = "Ghastly Tathlum +1",
        head = "Jhakri Coronal +2",
        neck = "Baetyl Pendant",
        ear1 = "Regal Earring",
        ear2 = "Friomisi Earring",
        body = "Amalric Doublet +1",
        hands = "Amalric Gages +1",
        ring1 = "Metamor. Ring +1",
        ring2 = "Shiva Ring +1",
        back = gear.nuke_jse_back,
        waist = gear.ElementalObi,
        legs = gear.af2_legs,
        feet = "Amalric Nails +1"
    }

    sets.midcast['Blue Magic'].Magical.SIRD = {
        main = "Bunzi's Rod",
        sub = "Sakpata's Sword",
        ammo = "Staunch Tathlum +1",
        head = "Jhakri Coronal +2",
        neck = "Loricate Torque +1",
        ear1 = "Regal Earring",
        ear2 = "Friomisi Earring",
        body = "Amalric Doublet +1",
        hands = "Rawhide Gloves",
        ring1 = "Murky Ring",
        ring2 = "Metamor. Ring +1",
        back = gear.nuke_jse_back,
        waist = "Emphatikos Rope",
        legs = "Carmine Cuisses +1",
        feet = "Amalric Nails +1"
    }

    sets.midcast['Blue Magic'].Subduction = {
        main = "Bunzi's Rod",
        sub = "Maxentius",
        ammo = "Ghastly Tathlum +1",
        head = "Jhakri Coronal +2",
        neck = "Baetyl Pendant",
        ear1 = "Regal Earring",
        ear2 = "Friomisi Earring",
        body = "Amalric Doublet +1",
        hands = "Amalric Gages +1",
        ring1 = "Metamor. Ring +1",
        ring2 = "Shiva Ring +1",
        back = gear.nuke_jse_back,
        waist = gear.ElementalObi,
        legs = gear.af2_legs,
        feet = "Amalric Nails +1"
    }

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
        {
            neck = "Mirage Stole +2",
            hands = "Jhakri Cuffs +2",
            ring1 = "Stikini Ring +1",
            ring2 = "Stikini Ring +1",
            waist = "Yamabuki-no-Obi",
            feet = "Jhakri Pigaches +2"
        })


    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, { ring2 = "Stikini Ring +1" })
    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})
    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicAccuracy = {
        main = "Tizona",
        sub = "Sakpata's Sword",
        ammo = "Pemphredo Tathlum",
        head = gear.af1_head,
        neck = "Mirage Stole +2",
        ear1 = "Regal Earring",
        ear2 = "Njordr Earring",
        body = "Amalric Doublet +1",
        hands = "Malignance Gloves",
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Cornflower Cape",
        waist = "Acuity Belt +1",
        legs = gear.af1_legs,
        feet = "Malignance Boots"
    }

    sets.midcast['Blue Magic'].Magical.FullMacc = sets.midcast['Blue Magic'].MagicAccuracy
    sets.midcast['Blue Magic'].Subduction.FullMacc = sets.midcast['Blue Magic'].MagicAccuracy

    sets.midcast['Enfeebling Magic'] = {
        main = "Tizona",
        sub = "Sakpata's Sword",
        ammo = "Pemphredo Tathlum",
        head = "Jhakri Coronal +2",
        neck = "Mirage Stole +2",
        ear1 = "Regal Earring",
        ear2 = "Digni. Earring",
        body = "Jhakri Robe +2",
        hands = "Regal Cuffs",
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Psycloth Lappas",
        feet = "Skaoi Boots"
    }

    sets.midcast['Enhancing Magic'] = {
        main = "Vampirism",
        sub = "Sakpata's Sword",
        ammo = "Hasty Pinion +1",
        head = "Telchine Cap",
        neck = "Incanter's Torque",
        ear1 = "Andoaa Earring",
        ear2 = "Gifted Earring",
        body = "Telchine Chas.",
        hands = "Telchine Gloves",
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Perimede Cape",
        waist = "Olympus Sash",
        legs = "Telchine Braconi",
        feet = "Telchine Pigaches"
    }

    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'],
        {
            main = "Pukulatmuj +1",
            sub = "Sakpata's Sword",
            head = "Carmine Mask +1",
            ear2 = "Mimir Earring",
            body = gear
                .taeon_phalanx_body,
            hands = gear.herculean_phalanx_hands,
            legs = "Carmine Cuisses +1",
            feet = gear
                .herculean_nuke_feet
        })

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], { head = "Amalric Coif +1" })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
        { head = "Amalric Coif +1", hands = "Regal Cuffs", waist = "Emphatikos Rope", legs = "Shedir Seraweels" })

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],
        { legs = "Shedir Seraweels" })

    sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], { legs = "Shedir Seraweels" })

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
    sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })

    sets.element.Dark = { head = "Pixie Hairpin +1", ring2 = "Archon Ring" }
    sets.element.Light = {} --ring2="Weatherspoon Ring"

    sets.midcast.Cure = {
        main = "Bunzi's Rod",
        sub = "Sakpata's Sword",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Regal Earring",
        ear2 = "Mendi. Earring",
        body = "Vrikodara Jupon",
        hands = "Telchine Gloves",
        ring1 = "Naji's Loop",
        ring2 = "Menelaus's Ring",
        back = "Moonlight Cape",
        waist = "Luminary Sash",
        legs = "Nyame Flanchard",
        feet = "Medium's Sabots"
    }

    sets.midcast.UnlockedCure = {
        main = "Bunzi's Rod",
        sub = "Sakpata's Sword",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Regal Earring",
        ear2 = "Mendi. Earring",
        body = "Nyame Mail",
        hands = "Telchine Gloves",
        ring1 = "Metamor. Ring +1",
        ring2 = "Naji's Loop",
        back = "Moonlight Cape",
        waist = "Luminary Sash",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        neck = "Debilis Medallion",
        hands = "Hieros Mittens",
        back = "Oretan. Cape +1",
        ring1 = "Haoma's Ring",
        ring2 = "Menelaus's Ring",
        waist = "Witful Belt"
    })

    -- Breath Spells --

    sets.midcast['Blue Magic'].Breath = {
        ammo = "Mavi Tathlum",
        head = gear.af2_head,
        neck = "Mirage Stole +2",
        ear1 = "Regal Earring",
        ear2 = "Digni. Earring",
        body = gear.af1_body,
        hands = gear.af2_hands,
        ring1 = "Kunaji Ring",
        ring2 = "Meridian Ring",
        back = "Cornflower Cape",
        legs = gear.af3_legs,
        feet = gear.af2_feet
    }

    -- Physical Added Effect Spells most notably "Stun" spells --

    sets.midcast['Blue Magic'].Stun = {
        main = "Tizona",
        sub = "Sakpata's Sword",
        ammo = "Pemphredo Tathlum",
        head = "Malignance Chapeau",
        neck = "Mirage Stole +2",
        ear1 = "Regal Earring",
        ear2 = "Digni. Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Cornflower Cape",
        waist = "Luminary Sash",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.midcast['Blue Magic'].Stun.Resistant = {
        main = "Tizona",
        sub = "Sakpata's Sword",
        ammo = "Falcon Eye",
        head = "Malignance Chapeau",
        neck = "Mirage Stole +2",
        ear1 = "Regal Earring",
        ear2 = "Digni. Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Cornflower Cape",
        waist = "Olseni Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    -- Other Specific Spells --

    sets.midcast['Blue Magic'].UnlockedAoEHealing = {
        main = "Bunzi's Rod",
        sub = "Sakpata's Sword",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Unmoving Collar +1",
        ear1 = "Tuisto Earring",
        ear2 = "Odnowa Earring +1",
        body = "Nyame Mail",
        hands = "Telchine Gloves",
        ring1 = "Naji's Loop",
        ring2 = "Gelatinous Ring +1",
        back = "Moonlight Cape",
        waist = "Eschan Stone",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.midcast['Blue Magic'].AoEHealing = {
        main = "Bunzi's Rod",
        sub = "Sakpata's Sword",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Unmoving Collar +1",
        ear1 = "Tuisto Earring",
        ear2 = "Odnowa Earring +1",
        body = "Vrikodara Jupon",
        hands = "Telchine Gloves",
        ring1 = "Naji's Loop",
        ring2 = "Gelatinous Ring +1",
        back = "Moonlight Cape",
        waist = "Eschan Stone",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.midcast['Blue Magic'].Healing = {
        main = "Bunzi's Rod",
        sub = "Sakpata's Sword",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Tuisto Earring",
        ear2 = "Odnowa Earring +1",
        body = "Vrikodara Jupon",
        hands = "Telchine Gloves",
        ring1 = "Naji's Loop",
        ring2 = "Gelatinous Ring +1",
        back = "Moonlight Cape",
        waist = "Eschan Stone",
        legs = "Gyve Trousers",
        feet = "Medium's Sabots"
    }

    sets.midcast['Blue Magic'].UnlockedHealing = {
        main = "Bunzi's Rod",
        sub = "Sakpata's Sword",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Regal Earring",
        ear2 = "Mendi. Earring",
        body = "Nyame Mail",
        hands = "Telchine Gloves",
        ring1 = "Metamor. Ring +1",
        ring2 = "Naji's Loop",
        back = "Moonlight Cape",
        waist = "Luminary Sash",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.midcast['Blue Magic'].SkillBasedBuff = {
        main = "Iris",
        sub = "Iris",
        ammo = "Mavi Tathlum",
        head = gear.af2_head,
        neck = "Mirage Stole +2",
        ear1 = "Gifted Earring",
        ear2 = "Njordr Earring",
        body = gear.af1_body,
        hands = "Rawhide Gloves",
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Cornflower Cape",
        waist = "Witful Belt",
        legs = gear.af3_legs,
        feet = gear.af2_feet
    }

    sets.midcast['Blue Magic'].Buff = {
        main = "Vampirism",
        sub = "Vampirism",
        ammo = "Mavi Tathlum",
        head = gear.af2_head,
        neck = "Incanter's Torque",
        ear1 = "Gifted Earring",
        ear2 = "Loquac. Earring",
        body = gear.af1_body,
        hands = gear.af3_hands,
        ring1 = "Kishar Ring",
        ring2 = "Dark Ring",
        back = "Aurist's Cape +1",
        waist = "Witful Belt",
        legs = "Lengo Pants",
        feet = "Carmine Greaves +1"
    }

    sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff,
        { head = "Amalric Coif +1", back = "Grapevine Cape", waist = "Gishdubar Sash" })

    sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff,
        { head = "Amalric Coif +1", hands = "Regal Cuffs", waist = "Emphatikos Rope", legs = "Shedir Seraweels" })

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = { hands = gear.af1_hands }

    -- Idle sets
    sets.idle = {
        main = "Bolelabunga",
        sub = "Genmei Shield",
        ammo = "Staunch Tathlum +1",
        head = "Rawhide Mask",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Jhakri Robe +2",
        hands = gear.herculean_refresh_hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Umbra Cape",
        waist = "Flume Belt +1",
        legs = "Lengo Pants",
        feet = gear.herculean_refresh_feet
    }

    sets.idle.PDT = {
        main = "Sakpata's Sword",
        sub = "Genmei Shield",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Jhakri Robe +2",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = "Dark Ring",
        back = "Moonlight Cape",
        waist = "Flume Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    -- Defense sets
    sets.defense.PDT = {
        main = "Sakpata's Sword",
        sub = "Genmei Shield",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = "Shadow Ring",
        back = "Shadow Mantle",
        waist = "Flume Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.MDT = {
        main = "Bolelabunga",
        sub = "Genmei Shield",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = "Shadow Ring",
        back = "Moonlight Cape",
        waist = "Carrier's Sash",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.MEVA = {
        main = "Bolelabunga",
        sub = "Genmei Shield",
        ammo = "Staunch Tathlum +1",
        head = "Malignance Chapeau",
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Malignance Tabard",
        hands = "Leyline Gloves",
        ring1 = "Vengeful Ring",
        ring2 = "Purity Ring",
        back = gear.nuke_jse_back,
        waist = "Carrier's Sash",
        legs = "Telchine Braconi",
        feet = "Malignance Boots"
    }

    sets.defense.NukeLock = sets.midcast['Blue Magic'].Magical

    sets.Kiting = { ring2 = "Shneddick Ring" }

    -- Weapons sets
    sets.weapons.Tizbron = { main = "Tizona", sub = "Thibron" }
    sets.weapons.Tiztongue = { main = "Tizona", sub = "Flametongue" }
    sets.weapons.MeleeClubs = { main = "Maxentius", sub = "Bunzi's Rod" }
    sets.weapons.Naegbron = { main = "Naegling", sub = "Thibron" }
    sets.weapons.Naegtongue = { main = "Naegling", sub = "Thibron" }

    -- Engaged sets

    sets.engaged = {
        main = "Tizona",
        aub = gear.tp_bonus_sword,
        ammo = "Aurgelmir Orb +1",
        head = "Dampening Tam",
        neck = "Mirage Stole +2",
        ear1 = "Cessance Earring",
        ear2 = "Brutal Earring",
        body = "Adhemar Jacket +1",
        hands = "Adhemar Wrist. +1",
        ring1 = "Epona's Ring",
        ring2 = "Petrov Ring",
        back = gear.da_jse_back,
        waist = "Windbuffet Belt +1",
        legs = "Samnuha Tights",
        feet = gear.herculean_ta_feet
    }

    sets.engaged.AM = {
        main = "Tizona",
        aub = gear.tp_bonus_sword,
        ammo = "Aurgelmir Orb +1",
        head = "Dampening Tam",
        neck = "Mirage Stole +2",
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
        body = "Adhemar Jacket +1",
        hands = "Adhemar Wrist. +1",
        ring1 = "Epona's Ring",
        ring2 = "Petrov Ring",
        back = gear.stp_jse_back,
        waist = "Windbuffet Belt +1",
        legs = "Samnuha Tights",
        feet = "Carmine Greaves +1"
    }


    sets.engaged.Acc = {
        main = "Tizona",
        aub = "Flametongue",
        ammo = "Falcon Eye",
        head = "Dampening Tam",
        neck = "Mirage Stole +2",
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Adhemar Wrist. +1",
        ring1 = "Epona's Ring",
        ring2 = "Petrov Ring",
        back = gear.da_jse_back,
        waist = "Windbuffet Belt +1",
        legs = "Carmine Cuisses +1",
        feet = "Malignance Boots"
    }

    sets.engaged.Acc.AM = {
        main = "Tizona",
        sub = "Flametongue",
        ammo = "Falcon Eye",
        head = "Dampening Tam",
        neck = "Mirage Stole +2",
        ear1 = "Digni. Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Adhemar Wrist. +1",
        ring1 = "Epona's Ring",
        ring2 = "Ilabrat Ring",
        back = gear.stp_jse_back,
        waist = "Windbuffet Belt +1",
        legs = "Carmine Cuisses +1",
        feet = "Malignance Boots"
    }

    sets.engaged.FullAcc = {
        main = "Tizona",
        sub = "Flametongue",
        ammo = "Falcon Eye",
        head = "Carmine Mask +1",
        neck = "Mirage Stole +2",
        ear1 = "Mache Earring +1",
        ear2 = "Telos Earring",
        body = gear.af1_body,
        hands = gear.af1_hands,
        ring1 = "Ramuh Ring +1",
        ring2 = "Ramuh Ring +1",
        back = gear.da_jse_back,
        waist = "Olseni Belt",
        legs = "Carmine Cuisses +1",
        feet = "Malignance Boots"
    }

    sets.engaged.FullAcc.AM = {
        main = "Tizona",
        sub = "Flametongue",
        ammo = "Falcon Eye",
        head = "Carmine Mask +1",
        neck = "Mirage Stole +2",
        ear1 = "Mache Earring +1",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Ramuh Ring +1",
        ring2 = "Ramuh Ring +1",
        back = gear.stp_jse_back,
        waist = "Olseni Belt",
        legs = "Carmine Cuisses +1",
        feet = "Malignance Boots"
    }

    sets.engaged.DT = {
        main = "Tizona",
        aub = gear.tp_bonus_sword,
        ammo = "Aurgelmir Orb +1",
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Suppanomimi",
        ear2 = "Brutal Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Murky Ring",
        ring2 = "Petrov Ring",
        back = gear.da_jse_back,
        waist = "Windbuffet Belt +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.DT.AM = {
        main = "Tizona",
        aub = gear.tp_bonus_sword,
        ammo = "Aurgelmir Orb +1",
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Cessance Earring",
        ear2 = "Brutal Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Murky Ring",
        ring2 = "Petrov Ring",
        back = gear.stp_jse_back,
        waist = "Reiki Yotai",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.Acc.DT = {
        main = "Tizona",
        sub = "Flametongue",
        ammo = "Falcon Eye",
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Murky Ring",
        ring2 = "Ilabrat Ring",
        back = gear.da_jse_back,
        waist = "Reiki Yotai",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.Acc.DT.AM = {
        main = "Tizona",
        sub = "Flametongue",
        ammo = "Falcon Eye",
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Digni. Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Murky Ring",
        ring2 = "Ilabrat Ring",
        back = gear.stp_jse_back,
        waist = "Reiki Yotai",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.FullAcc.DT = {
        main = "Tizona",
        sub = "Flametongue",
        ammo = "Falcon Eye",
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Mache Earring +1",
        ear2 = "Odr Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Murky Ring",
        ring2 = "Ramuh Ring +1",
        back = gear.da_jse_back,
        waist = "Reiki Yotai",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.Self_Healing = { waist = "Gishdubar Sash" }
    sets.Self_Refresh = { back = "Amalric Coif +1", waist = "Gishdubar Sash" }
    sets.Phalanx_Received = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'RDM' then
        set_macro_page(3, 1)
    else
        set_macro_page(1, 1)
    end
end

autows_list = {
    ['Tizbron'] = 'Expiacion',
    ['Tiztongue'] = 'Expiacion',
    ['MeleeClubs'] = 'Black Halo',
    ['HybridWeapons'] = 'Sanguine Blade',
    ['Naegbron'] = 'Savage Blade',
    ['Naegtongue'] = 'Savage Blade'
}
