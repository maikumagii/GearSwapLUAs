function character_user_job_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'HighBuff')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'FullAcc')
    state.CastingMode:options('Normal', 'FullMacc')
    state.IdleMode:options('Normal', 'PDT')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('Tizbron', 'Tiztongue', 'None', 'MeleeClubs', 'Naegbron', 'Naegtongue')

    gear.stp_jse_back = { name = "Rosmerta's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Store TP"+10', 'Phys. dmg. taken-10%', } }
    gear.str_wsd_jse_back = { name = "Rosmerta's Cape", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', } }
    gear.nuke_jse_back = "Cornflower Cape" --{ name = "Rosmerta's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', '"Mag.Atk.Bns."+10', } }
    gear.int_wsd_jse_back = gear.str_wsd_jse_back

    gear.jse_neck = "Mirage Stole +2"
    gear.jse_earring = ""

    -- Artifact Gear
    gear.af1_head = ""
    gear.af1_body = "Assim. Jubbah +4"
    gear.af1_hands = "Magus Bazubands"
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

    gear.sibyl_scarf = ""
    gear.baetyl_pendant = ""
    gear.incaters_torque = ""
    gear.regal_earring = ""
    gear.archon_ring = "Metamor. Ring +1"
    gear.fotia_gorget = ""
    gear.fotia_belt = ""
    gear.acuity_belt = ""
    gear.null_masque = ""
    gear.loricate_torque = "Null Loop"
    gear.luminary_sash = "Null Belt"
    gear.genmei_shield = ""

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

    sets.buff['Burst Affinity'] = { --[[legs = gear.af1_legs,]] feet = gear.af3_feet }
    sets.buff['Chain Affinity'] = {} --feet = gear.af1_feet }
    sets.buff.Convergence = { } -- head = gear.af2_head }
    sets.buff.Diffusion = { } --feet = gear.af2_feet }
    sets.buff.Enchainment = {}
    sets.buff.Efflux = { --[[back = gear.stp_jse_back,]] legs = gear.af3_legs }
    sets.buff.Doom = set_combine(sets.buff.Doom, {})

    -- Precast Sets

    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = { } --hands = gear.af2_hands }

    -- Fast cast sets for spells

    sets.precast.FC = {
        main = "Sakpata's Sword", 
        --ammo = "Impatiens",  
        --neck = "Voltsurge Torque",  
        ear1 = "Etiolation Earring", 
        ear2 = "Loquac. Earring",
        --body = gear.af2_body,
        --ring1 = "Kishar Ring", 
        ring2 = "Lebeche Ring",
        --back = "Perimede Cape", OR BLU Fast Cast cape?
        --waist = "Witful Belt", 
    }

    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, { body = gear.af3_body })


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = "Coiste Bodhar",
        head = gear.af3_head,
        neck = gear.jse_neck,
        ear1 = "Moonshade Earring",
        ear2 = "Ishvara Earring",
        body = gear.af1_body,
        hands = "Jhakri Cuffs +2",
        ring1 = "Epaminondas's Ring",
        ring2 = "Sroda Ring",
        back = gear.str_wsd_jse_back,
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
        neck = gear.sibyl_scarf,
        ear1 = gear.regal_earring,
        ear2 = "Friomisi Earring",
        body =  "Amalric Doublet +1", 
        hands = "Jhakri Cuffs +2",
        ring1 = "Epaminondas's Ring",
        ring2 = gear.archon_ring,  
        back = gear.int_wsd_jse_back, 
        waist = "Orpheus's Sash",
        legs = gear.af2_legs,
        feet = gear.af3_feet
    }
    sets.precast.WS['Sanguine Blade'].DT = set_combine(sets.precast.WS.DT, { back = gear.int_wsd_jse_back })

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = { ear1 = "Cessance Earring", ear2 = "Brutal Earring" }
    sets.AccMaxTP = { ear1 = "Regal Earring", ear2 = "Telos Earring" }

    -- Midcast Sets
    sets.midcast.FastRecast = set_combine(sets.precast.FC, { })

    sets.midcast['Blue Magic'] = {}

    -- Physical Spells --

    sets.midcast['Blue Magic'].Physical = {

        -- Largley AF2 Gear STR/ACC
    }

    -- Magical Spells --

    sets.midcast['Blue Magic'].Magical = {
        main = "Bunzi's Rod",
        sub = "Maxentius",
        ammo = "Ghastly Tathlum +1",
        head = gear.af3_head,
        neck = gear.sibyl_scarf,
        ear1 = gear.regal_earring,
        ear2 = "Friomisi Earring",
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Metamor. Ring +1",
        ring2 = "Shiva Ring +1",
        back = gear.nuke_jse_back,
        waist = "Orpheus's Sash",
        legs = gear.af2_legs,
        feet = gear.af3_feet
    }


    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, { ring2 = "Stikini Ring +1" })
    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})
    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicAccuracy = {
        main = "Tizona",
        sub = "Sakpata's Sword",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = "Mirage Stole +2",
        ear1 = gear.regal_earring,
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Stikini Ring +1",
        back = "Cornflower Cape",
        waist = gear.acuity_belt,
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast['Blue Magic'].Magical.FullMacc = sets.midcast['Blue Magic'].MagicAccuracy

    sets.midcast['Enfeebling Magic'] = {
        main = "Tizona",
        sub = "Sakpata's Sword",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = gear.regal_earring,
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = "Regal Cuffs",
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast['Enhancing Magic'] = {
        main = "Pukulatmuj +1",
        sub = "Sakpata's Sword",
        --neck = "Incanter's Torque",
        --ear1 = "Andoaa Earring",
        ear2 = "Mimir Earring",
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Perimede Cape",
        --waist = "Olympus Sash",
    }

    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {  })

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], { head = "Amalric Coif +1" })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
        { head = "Amalric Coif +1", hands = "Regal Cuffs", --[[waist = "Emphatikos Rope",]] legs = "Shedir Seraweels" })

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],
        { legs = "Shedir Seraweels" })

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], { legs = "Shedir Seraweels" })

    --sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
    --sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
    --sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
    --sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })

    sets.element.Dark = { head = "Pixie Hairpin +1", --[[ring2 = "Archon Ring"]] }
    sets.element.Light = {} --ring2="Weatherspoon Ring"

    sets.midcast.Cure = {
        main = "Bunzi's Rod",
        sub = "Sakpata's Sword",
        ammo = "Staunch Tathlum +1",
        neck = gear.loricate_torque,
        ear1 = gear.regal_earring,
        ear2 = "Mendi. Earring",
        body = "Vrikodara Jupon",
        ring1 = "Naji's Loop",
        ring2 = "Menelaus's Ring",
        back = "Moonlight Cape",
        waist = gear.luminary_sash,
    }

    sets.midcast.UnlockedCure = sets.midcast.Cure

    sets.midcast.Cursna = sets.midcast.Cure

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

    sets.midcast['Blue Magic'].Healing = {
        ammo = "Staunch Tathlum +1",
        neck = gear.loricate_torque,
        body = "Vrikodara Jupon",
        ring1 = "Naji's Loop",
        waist = gear.luminary_sash,
    }

    sets.midcast['Blue Magic'].UnlockedHealing = sets.midcast['Blue Magic'].Healing

    sets.midcast['Blue Magic'].SkillBasedBuff = {
        --head = gear.af2_head,
        neck = gear.incaters_torque,
        --body = gear.af1_body,
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Cornflower Cape",
        legs = gear.af3_legs,
        --feet = gear.af2_feet
    }

    sets.midcast['Blue Magic'].Buff = sets.midcast['Blue Magic'].SkillBasedBuff

    sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff,
        { head = "Amalric Coif +1", --[[back = "Grapevine Cape",]] waist = "Gishdubar Sash" })

    sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff,
        { head = "Amalric Coif +1", hands = "Regal Cuffs", --[[waist = "Emphatikos Rope",]] legs = "Shedir Seraweels" })

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = { hands = gear.af1_hands }

    -- Idle sets
    sets.idle = {
        main = "Sakpata's Sword",
        sub = gear.genmei_shield,
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = gear.loricate_torque,
        ear1 = "Etiolation Earring",
        ear2 = "Alabaster Earring",
        body = gear.af3_body,
        hands = "Nyame Gauntlets",
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sabots"
    }

    sets.idle.PDT = {
        main = "Sakpata's Sword",
        sub = gear.genmei_shield,
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = gear.loricate_torque,
        ear1 = "Etiolation Earring",
        ear2 = "Alabaster Earring",
        body = gear.af3_body,
        hands = "Nyame Gauntlets",
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Null Shawl",
        waist = "Flume Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sabots"
    }

    -- Defense sets
    sets.defense.PDT = {
        main = "Sakpata's Sword",
        sub = gear.genmei_shield,
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = gear.loricate_torque,
        ear1 = "Etiolation Earring",
        ear2 = "Alabaster Earring",
        body = gear.af3_body,
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = "Stikini Ring +1",
        back = "Null Shawl",
        waist = "Flume Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sabots"
    }

    sets.defense.MDT = {
        main = "Sakpata's Sword",
        sub = gear.genmei_shield,
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Alabaster Earring",
        body = gear.af3_body,
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = "Stikini Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sabots"
    }

    sets.defense.MEVA = {
        main = "Sakpata's Sword",
        sub = gear.genmei_shield,
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Alabaster Earring",
        body = gear.af3_body,
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = "Stikini Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sabots"
    }

    sets.defense.NukeLock = sets.midcast['Blue Magic'].Magical

    sets.Kiting = { ring2 = "Shneddick Ring" }

    -- Weapons sets
    sets.weapons.Tizbron = { main = "Tizona", sub = gear.tp_bonus_sword }
    sets.weapons.Tiztongue = { main = "Tizona", sub = "Flametongue" }
    sets.weapons.MeleeClubs = { main = "Maxentius", sub = "Bunzi's Rod" }
    sets.weapons.Naegbron = { main = "Naegling", sub = gear.tp_bonus_sword }
    sets.weapons.Naegtongue = { main = "Naegling", sub = gear.tp_bonus_sword }

    -- Engaged sets

    sets.engaged = {
        main = "Tizona",
        sub = gear.tp_bonus_sword,
        ammo = "Aurgelmir Orb +1",
        head = "Adhemar Bonnet +1",
        neck = "Mirage Stole +2",
        ear1 = "Dedition Earring",
        ear2 = "Suppanomimi",
        body = "Adhemar Jacket +1",
        hands = "Adhemar Wrist. +1",
        ring1 = "Epona's Ring",
        ring2 = "Chirich Ring +1",
        back = "Null Shawl",
        waist = "Sailfi Belt +1",
        legs = "Samnuha Tights",
        feet = gear.herculean_ta_feet
    } 

    sets.engaged.AM = set_combine(sets.engaged, {
        head = "Malignance Chapeau",
        ear2 = "Eabani Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Chirich Ring +1",
        back = gear.stp_jse_back,
        waist = "Reiki Yotai",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    })

    sets.engaged.Acc = set_combine(sets.engaged, {
        sub = "Flametongue",
        head = "Malignance Chapeau",
        ear2 = "Eabani Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Chirich Ring +1",
        back = "Null Shawl",
        waist = "Reiki Yotai",
        legs = "Malignance Tights",
    })


    sets.engaged.Acc.AM = set_combine(sets.engaged.Acc, {
        back = gear.stp_jse_back,
    })

    sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {
        main = "Tizona",
        sub = gear.tp_bonus_sword,
        ammo = "Aurgelmir Orb +1",
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Telos Earring",
        ear2 = "Eabani Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Chirich Ring +1",
        ring2 = "Chirich Ring +1",
        back = "Null Shawl",
        waist = "Reiki Yotai",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    })

    sets.engaged.FullAcc.AM = set_combine(sets.engaged.FullAcc, {
        back = gear.stp_jse_back,
    })

    sets.engaged.DT = set_combine(sets.engaged, {
        main = "Tizona",
        sub = gear.tp_bonus_sword,
        ammo = "Aurgelmir Orb +1",
        head = "Malignance Chapeau",
        neck = "Mirage Stole +2",
        ear1 = "Dedition Earring",
        ear2 = "Eabani Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Epona's Ring",
        ring2 = "Chirich Ring +1",
        back = "Null Shawl",
        waist = "Reiki Yotai",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    })

    sets.engaged.DT.AM = set_combine(sets.engaged.DT, {
        ring1 = "Chirich Ring +1",
        back = gear.stp_jse_back,
    })

    sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {
        sub = "Flametongue",
        neck = "Mirage Stole +2",
        ear1 = "Telos Earring",
        ring1 = "Chirich Ring +1",
    })

    sets.engaged.Acc.DT.AM = set_combine(sets.engaged.Acc.DT, {
        back = gear.stp_jse_back,
     })

    sets.engaged.FullAcc.DT = set_combine(sets.engaged.Acc.DT, {
        neck = "Null Loop",
    })
    
    sets.engaged.FullAcc.DT.AM = sets.engaged.FullAcc.DT

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
    ['Naegbron'] = 'Savage Blade',
    ['Naegtongue'] = 'Savage Blade'
}
