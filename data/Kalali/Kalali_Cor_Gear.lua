-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'Proc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
    state.HybridMode:options('Normal', 'DT')
    state.ExtraMeleeMode = M { ['description'] = 'Extra Melee Mode', 'None', 'DWMax' }
    state.Weapons:options('Default', 'Naegling', 'DualNaegling', 'LeadenRanged', 'DualLeadenRanged',
        'LeadenMelee', 'DualLeadenMelee', 'LastStandRanged', 'DualAeolian', 'None')

    state.CompensatorMode:options('Always', '300', '1000', 'Never')

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet" --For MAB WS, do not put single-use bullets here.
    gear.QDbullet = "Living Bullet"
    options.ammo_warning_limit = 15

    -- Ambuscade Capes
    gear.tp_ranger_jse_back = { name = "Camulus's Mantle", augments = { 'AGI+19', 'Rng.Acc.+20 Rng.Atk.+20', --[['Rng.Acc.+10',]] '"Store TP"+10', 'Phys. dmg. taken -10%' } }
    gear.tp_snapshot_jse_back = gear.tp_ranger_jse_back
    --gear.snapshot_jse_back = { name = "Camulus's Mantle", augments = { '"Snapshot"+10', } }
    gear.tp_jse_back = { name = "Camulus's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'DEX+1', '"Double Attack"+10%', } }
    --gear.tp_jse_back = { name = "Camulus's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Store TP"+10', } }
    gear.magic_wsd_jse_back = { name = "Camulus's Mantle", augments = { 'AGI+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'AGI+10', 'Weapon skill damage +10%' } }
    gear.ranger_wsd_jse_back = gear.magic_wsd_jse_back
    --gear.ranger_wsd_jse_back = { name = "Camulus's Mantle", augments = { 'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10', 'Weapon skill damage +10%', } }
    gear.str_wsd_jse_back = { name = "Camulus's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken -10%' } }

    -- JSE Weapon/Neck/Earring
    gear.jse_main_roll = { name = "Rostam", augments = { 'Path:C' } }
    gear.jse_main_ma = { name = "Rostam", augments = { 'Path:B' } }
    gear.jse_main_stp = { name = "Lanun Knife", augments = { 'Path:A' } }
    gear.jse_neck = "Comm. Charm +2"

    -- Artifact Gear
    --gear.af1_head = ""
    gear.af1_body = "Laksa. Frac +3"
    --gear.af1_hands = ""
    --gear.af1_legs = ""
    --gear.af1_feet = ""

    -- Relic Gear
    gear.af2_head = "Lanun Tricorne +3"
    gear.af2_body = "Lanun Frac. +3"
    gear.af2_hands = "" -- "Lanun Gants +1"
    gear.af2_legs = ""  -- "Lanun Trews +1"
    gear.af2_feet = "Lanun Bottes +4"

    -- Empy Gear
    gear.af3_head = "" --"Chass. Tricorne +1"
    gear.af3_body = "Chasseur's Frac +2"
    gear.af3_hands = "Chasseur's Gants +2"
    gear.af3_legs = "" --"Chas. Culottes +1"
    gear.af3_feet = "" --"Chass. Bottes +1"

    -- Additional local binds
    send_command('bind ^` gs c cycle ElementalMode')
    send_command('bind !` gs c elemental quickdraw')

    send_command('bind ^backspace input /ja "Double-up" <me>')
    send_command('bind @backspace input /ja "Snake Eye" <me>')
    send_command('bind !backspace input /ja "Fold" <me>')
    send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')

    send_command('bind ^\\\\ input /ja "Random Deal" <me>')
    send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
    send_command('bind ^@!\\\\ gs c toggle LuzafRing')
    send_command('bind @f7 gs c toggle RngHelper')

    send_command('bind !r gs c weapons DualSavageWeapons;gs c update')
    send_command('bind ^q gs c weapons DualAeolian;gs c update')
    send_command('bind @q gs c weapons DualKustawi;gs c update')
    send_command('bind !q gs c weapons DualLeadenRanged;gs c update')
    send_command('bind @pause roller roll')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Triple Shot'] = { body = gear.af3_body }
    sets.precast.JA['Snake Eye'] = { legs = gear.af2_legs }
    sets.precast.JA['Wild Card'] = { feet = gear.af2_feet }
    sets.precast.JA['Random Deal'] = { body = gear.af2_body }
    sets.precast.FoldDoubleBust = { hands = gear.af2_hands }

    sets.precast.CorsairRoll = {
        main = gear.jse_main_roll,
        range = "Compensator",
        head = gear.af2_head,
        --neck = "Regal Necklace",
        hands = gear.af3_hands,
        ring2 = "Luzaf's Ring",
        back = gear.tp_jse_back,
    }

    sets.precast.LuzafRing = { ring2 = "Luzaf's Ring" }

    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, { legs = gear.af3_legs })
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, { feet = gear.af3_feet })
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, { head = gear.af3_head })
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, { body = gear.af3_body })
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, { hands = gear.af3_hands })

    sets.precast.CorsairShot = {
        ammo = gear.QDbullet,
        head = gear.ikenga_head,
        neck = gear.jse_neck,
        ear1 = "Dedition Earring",
        ear2 = "Telos Earring",
        body = gear.af,
        hands = gear.nyame_hands,
        ring1 = "Ilabrat Ring",
        ring2 = "Petrov Ring",
        back = gear.tp_ranger_jse_back,
        waist = "Escha Stone",
        legs = gear.nyame_legs,
        feet = gear.af2_feet
    }

    sets.precast.CorsairShot.Damage = {
        ammo = gear.QDbullet,
        head = gear.ikenga_head,
        neck = gear.jse_neck,
        ear1 = gear.limbus_ear1,
        ear2 = "Friomisi Earring",
        body = gear.af,
        hands = gear.nyame_hands,
        ring1 = "Ilabrat Ring",
        ring2 = "Petrov Ring",
        back = gear.tp_ranger_jse_back,
        waist = "Escha Stone",
        legs = gear.nyame_legs,
        feet = gear.af2_feet
    }

    sets.precast.CorsairShot.Proc = {
        ammo = gear.QDbullet,
        head = gear.ikenga_head,
        neck = gear.jse_neck,
        ear1 = gear.limbus_ear1,
        ear2 = "Friomisi Earring",
        body = gear.af,
        hands = gear.nyame_hands,
        ring1 = "Ilabrat Ring",
        ring2 = "Petrov Ring",
        back = gear.tp_ranger_jse_back,
        waist = "Escha Stone",
        legs = gear.nyame_legs,
        feet = gear.af2_feet
    }

    sets.precast.CorsairShot['Light Shot'] = {
        ammo = gear.QDbullet,
        head = gear.ikenga_head,
        neck = gear.jse_neck,
        ear1 = gear.limbus_ear1,
        ear2 = "Friomisi Earring",
        body = gear.af,
        hands = gear.nyame_hands,
        ring1 = "Ilabrat Ring",
        ring2 = "Petrov Ring",
        back = gear.tp_ranger_jse_back,
        waist = "Escha Stone",
        legs = gear.nyame_legs,
        feet = gear.af2_feet
    }

    sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {
        --feet = gear.af3_feet
    })

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        --[[head = "Carmine Mask +1",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = gear.herculean_waltz_body,
        hands = gear.herculean_waltz_hands,
        ring1 = "Defending Ring",
        ring2 = "Valseur's Ring",
        back = "Moonlight Cape",
        waist = "Flume Belt +1",
        legs = "Dashing Subligar",
        feet = gear.herculean_waltz_feet]]
    }

    sets.Self_Waltz = { --[[head = "Mummu Bonnet +2", body = "Passion Jacket", ring1 = "Asklepian Ring"]] }

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells

    sets.precast.FC = { --unimplemented
        --[[head = "Carmine Mask +1",
        neck = "Baetyl Pendant",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Loquac. Earring",
        body = "Dread Jupon",
        hands = "Leyline Gloves",
        ring1 = "Kishar Ring",
        ring2 = "Lebeche Ring",
        back = "Moonlight Cape",
        waist = "Flume Belt +1",
        legs = "Rawhide Trousers",
        feet = "Carmine Greaves +1"]]
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { --[[neck = "Magoraga Beads", body = "Passion Jacket"]] })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, { --[[ear2 = "Mendi. Earring"]] })

    sets.precast.RA = {
        ammo = gear.RAbullet,
        head = gear.af3_head,
        neck = gear.jse_neck,
        --body = "Ososhi Vest +1"
        body = gear.ikenga_body,
        --hands = "Carmine Fin. Ga. +1",
        hands = gear.ikenga_hands,
        ring1 = "Crepuscular Ring",
        back = gear.snapshot_jse_back,
        --waist = "Impulse Belt",
        legs = gear.ikenga_legs,
        --legs = "Adhemar Kecks +1",
        feet = "Meg. Jam. +2"
    }

    sets.precast.RA.Flurry = set_combine(sets.precast.RA, {
        body = gear.af1_body })
    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {
        body = gear.af1_body })


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = gear.WSbullet,
        head = gear.nyame_head,
        neck = "Null Loop",
        ear1 = gear.wotg_ear,
        ear2 = "Ishvara Earring",
        body = gear.af1_body,
        hands = gear.af3_hands,
        ring1 = "Epaminondas's Ring",
        ring2 = "Sroda Ring",
        back = gear.str_wsd_jse_back,
        waist = "Sailfi Belt +1",
        legs = gear.nyame_legs,
        feet = gear.af2_feet
    }

    sets.precast.WS.Acc = {
        ammo = gear.WSbullet,
        head = gear.nyame_head,
        neck = "Null Loop",
        ear1 = gear.wotg_ear,
        ear2 = "Ishvara Earring",
        body = gear.af1_body,
        hands = gear.af3_hands,
        ring1 = "Epaminondas's Ring",
        ring2 = "Sroda Ring",
        back = gear.str_wsd_jse_back,
        waist = "Null Belt",
        legs = gear.nyame_legs,
        feet = gear.af2_feet
    }

    sets.precast.WS.Proc = {
        ammo = gear.WSbullet,
        head = gear.nyame_head,
        neck = "Null Loop",
        -- neck = "Caro Necklace",
        ear1 = gear.wotg_ear,
        ear2 = "Ishvara Earring",
        body = gear.af1_body,
        hands = gear.af3_hands,
        ring1 = "Epaminondas's Ring",
        ring2 = "Sroda Ring",
        back = gear.str_wsd_jse_back,
        waist = "Null Belt",
        legs = gear.nyame_legs,
        feet = gear.af2_feet
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = sets.precast.WS
    sets.precast.WS['Savage Blade'] = {
        ammo = gear.WSbullet,
        head = gear.nyame_head,
        neck = "Null Loop",
        -- neck = "Caro Necklace",
        ear1 = gear.wotg_ear,
        ear2 = "Ishvara Earring",
        body = gear.af1_body,
        hands = gear.af3_hands,
        ring1 = "Epaminondas's Ring",
        ring2 = "Sroda Ring",
        back = gear.str_wsd_jse_back,
        waist = "Sailfi Belt +1",
        legs = gear.nyame_legs,
        feet = gear.af2_feet
    }
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
        neck = "Null Loop",
        ear2 = "Telos Earring",
        back = "Null Shawl",
        waist = "Null Belt"
    })
    sets.precast.WS['Last Stand'] = {
        ammo = gear.WSbullet,
        head = gear.nyame_head,
        -- neck = "Fotia Gorget",
        ear1 = gear.wotg_ear,
        ear2 = "Telos Earring",
        body = gear.af1_body,
        hands = gear.af3_hands,
        ring1 = "Epaminondas's Ring",
        ring2 = "Sroda Ring",
        back = gear.ranger_wsd_jse_back,
        -- waist = "Fotia Belt",
        legs = gear.nyame_legs,
        feet = gear.af2_feet
    }
    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
        neck = "Null Loop",
        ear2 = "Telos Earring",
        back = "Null Shawl",
        waist = "Null Belt"
    })
    sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Detonator'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Slug Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Slug Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Numbing Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Numbing Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Sniper Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Sniper Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Split Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Split Shot'].Acc = sets.precast.WS['Last Stand'].Acc

    sets.precast.WS['Leaden Salute'] = {
        ammo = gear.MAbullet,
        head = "Pixie Hairpin +1",
        neck = gear.jse_neck,
        -- neck = "Baetyl Pendant",
        ear1 = gear.wotg_ear,
        ear2 = "Friomisi Earring",
        body = gear.af1_body,
        hands = gear.nyame_hands,
        ring1 = "Epaminondas's Ring",
        -- ring1 = "Archon Ring"
        ring2 = "Dingir Ring",
        back = gear.magic_wsd_jse_back,
        waist = "Eschan Stone",
        legs = gear.nyame_legs,
        feet = gear.af2_feet
    }

    sets.precast.WS['Aeolian Edge'] = {
        ammo = gear.MAbullet,
        head = gear.nyame_head,
        neck = gear.jse_neck,
        ear1 = gear.wotg_ear,
        ear2 = "Friomisi Earring",
        body = gear.af1_body,
        hands = gear.nyame_hands,
        ring1 = "Epaminondas's Ring",
        ring2 = "Dingir Ring",
        back = gear.magic_wsd_jse_back,
        waist = "Eschan Stone",
        legs = gear.nyame_legs,
        feet = gear.af2_feet
    }

    sets.precast.WS['Wildfire'] = {
        ammo = gear.MAbullet,
        head = gear.nyame_head,
        neck = gear.jse_neck,
        ear1 = gear.wotg_ear,
        ear2 = "Friomisi Earring",
        body = gear.af1_body,
        hands = gear.nyame_hands,
        ring1 = "Epaminondas's Ring",
        ring2 = "Dingir Ring",
        back = gear.magic_wsd_jse_back,
        waist = "Eschan Stone",
        legs = gear.nyame_legs,
        feet = gear.af2_feet
    }
    sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
    sets.precast.WS['Hot Shot'].Acc = sets.precast.WS['Wildfire'].Acc

    --Because omen skillchains.
    sets.precast.WS['Burning Blade'] = sets.precast.WS['Wildfire']

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = {}
    sets.AccMaxTP = {}

    -- Midcast Sets
    sets.midcast.FastRecast = {
        --[[head = "Carmine Mask +1",
        neck = "Baetyl Pendant",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Loquac. Earring",
        body = "Dread Jupon",
        hands = "Leyline Gloves",
        ring1 = "Kishar Ring",
        ring2 = "Lebeche Ring",
        back = "Moonlight Cape",
        waist = "Flume Belt +1",
        legs = "Rawhide Trousers",
        feet = "Carmine Greaves +1"]]
    }

    -- Specific spells

    sets.midcast.Cure = {
        --[[head = "Carmine Mask +1",
        neck = "Phalaina Locket",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Mendi. Earring",
        body = "Dread Jupon",
        hands = "Leyline Gloves",
        ring1 = "Janniston Ring",
        ring2 = "Lebeche Ring",
        back = "Solemnity Cape",
        waist = "Flume Belt +1",
        legs = "Carmine Cuisses +1",
        feet = "Carmine Greaves +1"]]
    }

    sets.Self_Healing = {
        -- neck = "Phalaina Locket",
        -- hands = "Buremte Gloves",
        -- ring2 = "Kunaji Ring",
        -- waist ="Gishdubar Sash"
    }
    sets.Cure_Received = {
        -- neck = "Phalaina Locket",
        -- hands = "Buremte Gloves",
        -- ring2 = "Kunaji Ring",
        -- waist ="Gishdubar Sash"
    }
    sets.Self_Refresh = {
        waist = "Gishdubar Sash",
    }

    sets.midcast.Utsusemi = sets.midcast.FastRecast

    -- Ranged gear
    sets.midcast.RA = {
        ammo = gear.RAbullet,
        head = "Malignance Chapeau",
        neck = "Iskur Gorget",
        ear1 = "Telos Earring",
        ear2 = "Crepuscular Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Crepuscular Ring",
        ring2 = "Ilabrat Ring",
        back = gear.tp_ranger_jse_back,
        --waist = "Yemaya Belt",
        waist = "Null Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.midcast.RA.Acc = {
        ammo = gear.RAbullet,
        head = "Malignance Chapeau",
        neck = "Null Loop",
        ear1 = "Telos Earring",
        ear2 = "Crepuscular Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Crepuscular Ring",
        ring2 = "Ilabrat Ring",
        back = gear.tp_ranger_jse_back,
        waist = "Null Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.buff['Triple Shot'] = { body = gear.af3_body }

    -- Sets to return to when not performing an action.

    sets.DayIdle = {}
    sets.NightIdle = {}

    sets.buff.Doom = set_combine(sets.buff.Doom, {})

    -- Resting sets
    sets.resting = {}


    -- Idle sets
    sets.idle = {
        ammo = gear.RAbullet,
        head = "Malignance Chapeau",
        neck = "Null Loop",
        --neck = "Loricate Torque +1",
        ear1 = gear.limbus_ear1,
        ear2 = "Eabani Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = gear.limbus_ring1,
        ring2 = "Chirich Ring+1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.idle.PDT = sets.idle

    sets.idle.Refresh = sets.idle

    -- Defense sets
    sets.defense.PDT = {
        ammo = gear.RAbullet,
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Genmei Earring",
        ear2 = "Sanare Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Dark Ring",
        back = "Shadow Mantle",
        waist = "Flume Belt +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.defense.MDT = sets.idle

    sets.defense.MEVA = sets.idle

    sets.Kiting = { legs = "Carmine Cuisses +1" }
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    sets.DWMax = {
        ear1 = "Suppanomimi",
        ear2 = "Eabani Earring",
        body = "Adhemar Jacket +1",
        --hands = "Floral Gauntlets",
        waist = "Reiki Yotai"
    }

    -- Weapons sets
    sets.weapons.Default = {
        main = "Naegling",
        sub = "Blurred Knife +1",
        range = gear.tp_bonus_gun
    }
    sets.weapons.Naegling = {
        main = "Naegling",
        sub = "Nusku Shield",
        range = gear.tp_bonus_gun
    }
    sets.weapons.DualNaegling = {
        main = "Naegling",
        sub = "Blurred Knife +1",
        range = gear.tp_bonus_gun
    }
    sets.weapons.LeadenRanged = {
        main = "Naegling",
        sub = "Nusku Shield",
        range = "Death Penalty"
    }
    sets.weapons.DualLeadenRanged = {
        main = "Naegling",
        sub = "Tauret",
        range = "Death Penalty"
    }
    sets.weapons.LeadenMelee = {
        main = gear.jse_main_ma,
        sub = "Nusku Shield",
        range = "Death Penalty"
    }
    sets.weapons.DualLeadenMelee = {
        main = gear.jse_main_ma,
        sub = "Blurred Knife +1",
        range = "Death Penalty"
    }
    sets.weapons.LastStandRanged = {
        main = gear.jse_main_stp,
        sub = "Nusku Shield",
        range = "Fomalhaut"
    }
    sets.weapons.DualAeolian = {
        main = gear.jse_main_ma,
        sub = "Tauret",
        range = gear.tp_bonus_gun
    }
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        head = "Malignance Chapeau",
        neck = "Iskur Gorget",
        ear1 = "Dedition Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Adhemar Wrist. +1",
        ring1 = "Epona's Ring",
        ring2 = "Petrov Ring",
        back = gear.tp_jse_back,
        waist = "Windbuffet Belt +1",
        legs = "Samnuha Tights", -- AUG?
        --feet = gear.herc_ta_boots
        feet = "Malignance Boots"
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        hands = "Malignance Gloves",
        ring1 = "Chirich Ring +1",
        legs = "Malignance Tights",
        -- legs="Chas. Culottes +3",
    })

    sets.engaged.DT = set_combine(sets.engaged, {

        --ear1 = "Odnowa Earring +1",
        ear1 = gear.limbus_ear1,
        hands = "Malignance Gloves",
        ring1 = gear.limbus_ring1,
        legs = "Malignance Tights",
        -- legs="Chas. Culottes +3",
    })

    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.DT)

    sets.engaged.DW = {
        head = "Malignance Chapeau",
        neck = "Iskur Gorget",
        ear1 = "Dedition Earring",
        ear2 = "Eabani Earring",
        body = "Malignance Tabard",
        hands = "Adhemar Wrist. +1",
        ring1 = "Epona's Ring",
        ring2 = "Petrov Ring",
        back = gear.tp_jse_back,
        waist = "Reiki Yotai",
        legs = "Samnuha Tights", -- AUG?
        --feet = gear.herc_ta_boots
        feet = "Malignance Boots"
    }

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
        ear1 = "Telos Earring",
        hands = "Malignance Gloves",
        ring1 = "Chirich Ring +1",
        legs = "Malignance Tights",
        -- legs="Chas. Culottes +3",
    })

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, {
        --ear1 = "Odnowa Earring +1",
        ear1 = limbus_ear1,
        hands = "Malignance Gloves",
        ring1 = gear.limbus_ring1,
        legs = "Malignance Tights",
        -- legs="Chas. Culottes +3",
    })

    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.engaged.DW.DT)
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'RNG' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'DRG' then
        set_macro_page(1, 2)
    else
        set_macro_page(1, 2)
    end
end

function user_job_lockstyle()
    if player.equipment.main == nil or player.equipment.main == 'empty' then
        windower.chat.input('/lockstyleset 080')
    elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then     --Sword in main hand.
        if player.equipment.sub == nil or player.equipment.sub == 'empty' then   --Sword/Nothing.
            windower.chat.input('/lockstyleset 080')
        elseif res.items[item_name_to_id(player.equipment.sub)].shield_size then --Sword/Shield
            windower.chat.input('/lockstyleset 080')
        elseif res.items[item_name_to_id(player.equipment.sub)].skill == 3 then  --Sword/Sword.
            windower.chat.input('/lockstyleset 080')
        elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then  --Sword/Dagger.
            windower.chat.input('/lockstyleset 080')
        else
            windower.chat.input('/lockstyleset 080')                             --Catchall just in case something's weird.
        end
    elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then     --Dagger in main hand.
        if player.equipment.sub == nil or player.equipment.sub == 'empty' then   --Dagger/Nothing.
            windower.chat.input('/lockstyleset 080')
        elseif res.items[item_name_to_id(player.equipment.sub)].shield_size then --Dagger/Shield
            windower.chat.input('/lockstyleset 080')
        elseif res.items[item_name_to_id(player.equipment.sub)].skill == 3 then  --Dagger/Sword.
            windower.chat.input('/lockstyleset 080')
        elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then  --Dagger/Dagger.
            windower.chat.input('/lockstyleset 080')
        else
            windower.chat.input('/lockstyleset 080') --Catchall just in case something's weird.
        end
    end
end
