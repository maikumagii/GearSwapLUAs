function character_user_job_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Proc')
    state.HybridMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal', 'PDT')
    state.Weapons:options('Chango', 'ShiningOne', 'Loxotic', 'Naegling', 'Proc')

    autows_list = {
        Chango = 'Upheaval',
        ShiningOne = 'Impulse Drive',
        Loxotic = 'Black Halo',
        Naegling = 'Savage Blade',
        Proc = 'Seraph Strike',
    }

    gear.str_wsd_jse_back = {
        name = "Cichol's Mantle",
        augments = { 'STR+30', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', }
    }
    gear.vit_wsd_jse_back = {
        name = "Cichol's Mantle",
        augments = { 'VIT+30', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%', }
    }
    gear.da_jse_back = {
        name = "Cichol's Mantle",
        augments = { 'DEX+20', 'Accuracy+30 Attack+20', '"Double Attack"+10%', 'Damage taken-5%', }
    }

    gear.jse_neck = "War. Beads +1"
    gear.jse_ear2 = "Boii Earring +1"

    -- Artifact gear.
    gear.af1_head = "" -- "Pumm. Mask +4"
    gear.af1_body = "Pumm. Lorica +2"
    gear.af1_hands = "" -- "Pumm. Mufflers +4"
    gear.af1_legs = "Pumm. Cuisses +4"
    gear.af1_feet = "Pumm. Calligae +4"

    -- Relic gear.
    gear.af2_head = "Agoge Mask +3"
    gear.af2_body = "Agoge Lorica +3"
    gear.af2_hands = "Agoge Mufflers +1"
    gear.af2_legs = "" -- "Agoge Cuisses +3"
    gear.af2_feet = "Agoge Calligae +3"

    -- Empyrean gear.
    gear.af3_head = "Boii Mask +2"
    gear.af3_body = "Boii Lorica +2"
    gear.af3_hands = "Boii Mufflers +2"
    gear.af3_legs = "Boii Cuisses +2"
    gear.af3_feet = "" -- "Boii Calligae +3"

    gear.flamma_head = "Flam. Zucchetto +2"
    gear.flamma_body = "Flamma Korazin +2"
    gear.flamma_hands = "Flam. Manopolas +2"
    gear.flamma_legs = "Flamma Dirs +2"
    gear.flamma_feet = "Flam. Gambieras +2"
    gear.hjarrandi_head = "Hjarrandi Helm"

    -- List of gear I want, could be BiS. When I get the item, can replace it here.
    gear.sakpatas_head = gear.hjarrandi_head        -- "Sakpata's Helm"
    gear.sakpatas_body = gear.af2_body              -- "Sakpata's Plate"
    gear.sakpatas_hands = "Nyame Gauntlets"         -- "Sakpata's Gauntlets"
    gear.sakpatas_legs = "Nyame Flanchard"          -- "Sakpata's Cuisses"
    gear.sakpatas_feet = "Nyame Sollerets"          -- "Sakpata's Leggings"
    gear.null_masque = gear.hjarrandi_head          -- "Null Masque"
    gear.rep_plat_medal = gear.jse_neck             -- "Republican Platinum Medal"
    gear.vim_torque = "Vim Torque"
    gear.niqmaddu_ring = "Petrov Ring"              -- "Niqmaddu Ring"
    gear.regal_ring = "Sroda Ring"                  -- "Regal Ring"
    gear.sroda_ring = "Sroda Ring"
    gear.dedition_earring = "Dedition Earring"
    gear.windbuffet_belt = "Sailfi Belt +1"         -- "Windbuffet Belt +1"
    gear.fotia_gorget = gear.jse_neck               -- "Fotia Gorget"
    gear.fotia_belt = "Sailfi Belt +1"              -- "Fotia Belt"

    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
    send_command('bind @` gs c cycle SkillchainMode')

    select_default_macro_book()
end

function init_gear_sets()
    --------------------------------------
    -- Weapons sets
    --------------------------------------

    sets.weapons.Chango = { main = "Chango", sub = "Duplus Grip" }
    sets.weapons.ShiningOne = { main = "Shining One", sub = "Duplus Grip" }
    sets.weapons.Loxotic = { main = "Loxotic Mace +1", sub = "Blurred Shield +1" }
    sets.weapons.Naegling = { main = "Naegling", sub = "Blurred Shield +1" }
    sets.weapons.Proc = { main = "Loxotic Mace +1", sub = "Blurred Shield +1" }

    --------------------------------------
    -- Precast Sets
    --------------------------------------

    sets.Enmity = {}
    sets.Knockback = {}

    sets.precast.JA['Berserk'] = {
        body = gear.af3_body,
        feet = gear.af2_feet,
    }
    sets.precast.JA['Warcry'] = {
        -- head = gear.af1_head,
    }
    sets.precast.JA['Defender'] = {
        -- hands = gear.af1_hands,
    }
    sets.precast.JA['Aggressor'] = {
        head = gear.af2_head,
        body = gear.af2_body,
    }
    sets.precast.JA['Mighty Strikes'] = {
        hands = gear.af2_hands,
    }
    sets.precast.JA["Warrior's Charge"] = {
        legs = gear.af1_legs,
    }
    sets.precast.JA['Tomahawk'] = {}
    sets.precast.JA['Retaliation'] = {
        hands = gear.af3_hands,
        feet = gear.af1_feet,
    }
    sets.precast.JA['Restraint'] = {
        hands = gear.af3_hands,
    }
    sets.precast.JA['Blood Rage'] = {
        body = gear.af3_body,
    }
    sets.precast.JA['Brazen Rush'] = {}
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})

    sets.precast.Waltz = {}
    sets.precast.Waltz['Healing Waltz'] = {}
    sets.precast.Step = {}
    sets.precast.Flourish1 = {}

    sets.precast.FC = {}
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    sets.midcast.FastRecast = {}
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
    sets.midcast.Cure = {}
    sets.Self_Healing = {}
    sets.Cure_Received = { waist = "Gishdubar Sash" }

    --------------------------------------
    -- Weaponskill sets
    --------------------------------------

    sets.precast.WS = {
        head = "Nyame Helm",
        neck = gear.jse_neck,
        ear1 = "Moonshade Earring",
        ear2 = "Thrud Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Sroda Ring",
        ring2 = "Cornelia's Ring",
        back = gear.str_wsd_jse_back,
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        neck = "Null Loop",
        ear2 = gear.jse_ear2,
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        waist = "Null Belt",
    })
    sets.precast.WS.Proc = {
        ammo = "Staunch Tathlum +1",
        head = gear.flamma_head,
        neck = "Null Loop",
        ear1 = "Telos Earring",
        ear2 = gear.jse_ear2,
        body = gear.flamma_body,
        hands = gear.flamma_hands,
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = gear.da_jse_back,
        waist = "Null Belt",
        legs = gear.flamma_legs,
        feet = gear.flamma_feet
    }

    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
        head = gear.af3_head,
        body = gear.af3_body,
        hands = gear.af3_hands,
        back = gear.vit_wsd_jse_back,
        legs = gear.af3_legs,
        feet = gear.af1_feet,
    })
    sets.precast.WS['Upheaval'].Acc = set_combine(sets.precast.WS.Acc, {
        back = gear.vit_wsd_jse_back,
    })
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
        head = gear.af3_head,
        hands = gear.af3_hands,
    })
    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
        back = gear.da_jse_back,
        ear2 = gear.jse_ear2,
        ring1 = "Petrov Ring",
    })
    sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS.Acc, {
        back = gear.da_jse_back,
    })

    sets.MaxTP = { ear1 = "Brutal Earring", ear2 = gear.jse_ear2 }
    sets.AccMaxTP = { ear1 = "Telos Earring", ear2 = gear.jse_ear2 }
    sets.AccDayMaxTPWSEars = sets.AccMaxTP
    sets.DayMaxTPWSEars = sets.MaxTP
    sets.AccDayWSEars = sets.AccMaxTP
    sets.DayWSEars = sets.MaxTP

    sets.AccWSMightyCharge = {}
    sets.AccWSCharge = {}
    sets.WSMightyCharge = {}
    sets.WSCharge = {}
    sets.WSMighty = {}

    --------------------------------------
    -- Idle / Defense
    --------------------------------------

    sets.resting = {}

    sets.idle = {
        ammo = "Staunch Tathlum +1",
        head = gear.hjarrandi_head,
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = gear.af2_body,
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.PDT = {
        ammo = "Staunch Tathlum +1",
        head = gear.hjarrandi_head,
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = gear.af2_body,
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = gear.str_wsd_jse_back,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.MDT = set_combine(sets.defense.PDT, {
        neck = "Warder's Charm +1",
        back = "Null Shawl",
    })

    sets.defense.MEVA = set_combine(sets.defense.MDT, {
        neck = "Null Loop",
    })

    sets.idle.PDT = sets.defense.PDT
    sets.Kiting = { ring2 = "Shneddick Ring" }
    sets.Reraise = {}
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Sleep = {}

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {
        head = gear.hjarrandi_head,
        neck = gear.vim_torque,
        ear1 = gear.dedition_earring,
        ear2 = gear.jse_ear2,
        body = gear.af2_body,
        hands = gear.af3_hands,
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = gear.da_jse_back,
        waist = "Sailfi Belt +1",
        legs = gear.af3_legs,
        feet = gear.flamma_feet
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        neck = "Null Loop",
        ear1 = "Telos Earring",
        waist = "Null Belt",
    })

    sets.engaged.DT = set_combine(sets.engaged, {
        body = gear.af2_body,
        back = gear.str_wsd_jse_back,
    })
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, {
        body = gear.af2_body,
        back = gear.str_wsd_jse_back,
    })
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    --set_macro_page(1, 1)
end

function user_job_lockstyle()
    windower.chat.input('/lockstyleset 017')
end
