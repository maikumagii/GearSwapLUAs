-- Setup vars that are user-dependent.  Can override this function in a sidecar.
function character_user_job_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant', 'OccultAcumen')
    state.IdleMode:options('Normal', 'PDT')
    state.Weapons:options('None', 'Maxentius', 'Gridarvor', 'Espiritus', 'Grioavolr')

    default_weapons = 'Maxentius'

    autows_list = {
        Maxentius = 'Black Halo',
        Gridarvor = 'Shattersoul',
        Espiritus = 'Shattersoul',
        Grioavolr = 'Shattersoul',
    }

    -- Solo CP skillchain notes:
    --   Black Halo (Fragmentation) <-> Flaming Crush (Fusion) = Light.
    --   Volt Strike and Predator Claws are strong raw damage pacts, but both are Fragmentation/Scission.
    --   Staff WS options are mostly fallback; Maxentius Black Halo should be the master WS damage set.

    gear.jse_neck = "Summoner's Collar +1"
    gear.jse_ear2 = "Beck. Earring +1"

    -- Artifact gear.
    gear.af1_head = ""  -- "Convoker's Horn +3"
    gear.af1_body = "Convoker's Doublet +3"
    gear.af1_hands = "" -- "Convoker's Bracers +3"
    gear.af1_legs = ""  -- "Convoker's Spats +3"
    gear.af1_feet = ""  -- "Convoker's Pigaches +3"

    -- Relic gear.
    gear.af2_head = ""  -- "Glyphic Horn +3"
    gear.af2_body = "Glyphic Doublet +3"
    gear.af2_hands = "" -- "Glyphic Bracers +3"
    gear.af2_legs = ""  -- "Glyphic Spats +3"
    gear.af2_feet = ""  -- "Glyphic Pigaches +3"

    -- Empyrean gear.
    gear.af3_head = "Beckoner's Horn +2"
    gear.af3_body = "Beckoner's Doublet +1"
    gear.af3_hands = "" -- "Beckoner's Bracers +3"
    gear.af3_legs = ""  -- "Beckoner's Spats +3"
    gear.af3_feet = ""  -- "Beckoner's Pigaches +3"

    gear.grioavolr_bp = {
        name = "Grioavolr",
        augments = { 'DMG:+7', 'Blood Pact Dmg.+7', 'Pet: Mag. Acc.+23', 'Pet: "Mag.Atk.Bns."+23', }
    }
    gear.gridarvor = {
        name = "Gridarvor",
        augments = { 'Pet: Accuracy+70', 'Pet: Attack+70', 'Pet: "Dbl. Atk."+15', }
    }
    gear.espiritus = {
        name = "Espiritus",
        augments = { 'MP+50', 'Pet: "Mag.Atk.Bns."+20', 'Pet: Mag. Acc.+20', }
    }
    gear.apogee_head_a = {
        name = "Apogee Crown +1",
        augments = { 'MP+80', 'Pet: "Mag.Atk.Bns."+35', 'Blood Pact Dmg.+8', }
    }
    gear.apogee_head_b = {
        name = "Apogee Crown +1",
        augments = { 'MP+80', 'Pet: Attack+35', 'Blood Pact Dmg.+8', }
    }
    gear.apogee_legs_a = {
        name = "Apogee Slacks +1",
        augments = { 'MP+80', 'Pet: "Mag.Atk.Bns."+35', 'Blood Pact Dmg.+8', }
    }
    gear.apogee_legs_d = {
        name = "Apogee Slacks +1",
        augments = { 'Pet: STR+20', 'Blood Pact Dmg.+14', 'Pet: "Dbl. Atk."+4', }
    }
    gear.apogee_feet_a = {
        name = "Apogee Pumps +1",
        augments = { 'MP+80', 'Pet: "Mag.Atk.Bns."+35', 'Blood Pact Dmg.+8', }
    }
    gear.apogee_feet_b = {
        name = "Apogee Pumps +1",
        augments = { 'MP+80', 'Pet: Attack+35', 'Blood Pact Dmg.+8', }
    }
    gear.merlinic_bp_hands = {
        name = "Merlinic Dastanas",
        augments = { 'Blood Pact Dmg.+10', 'Pet: STR+2', 'Pet: "Mag.Atk.Bns."+3', }
    }
    gear.campestres_magic = {
        name = "Campestres's Cape",
        augments = { 'Pet: Damage taken -5%', 'Pet: M.Acc.+10 Pet: M.Dmg.+10', }
    }

    gear.black_halo_jse_back = "Null Shawl" -- "Campestres's Cape" with STR/MND, Acc/Atk, WSD.
    gear.skillchain_jse_back = gear.campestres_magic
    gear.stikini_ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" }
    gear.stikini_ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" }
    gear.chirich_ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" }
    gear.chirich_ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" }
    gear.varar_ring1 = { name = "Varar Ring +1", bag = "Wardrobe" }
    gear.varar_ring2 = { name = "Varar Ring +1", bag = "Wardrobe 2" }

    -- List of gear I want, could be BiS. When I get the item, can replace it here.
    gear.khatvanga = gear.gridarvor              -- "Khatvanga"
    gear.malignance_pole = gear.gridarvor        -- "Malignance Pole"
    gear.umbra_strap = "Elan Strap +1"           -- "Umbra Strap"
    gear.vox_grip = "Elan Strap +1"              -- "Vox Grip"
    gear.bloodrain_strap = "Elan Strap +1"       -- "Bloodrain Strap"
    gear.epitaph = "Sancus Sachet +1"            -- "Epitaph"
    gear.esper_stone = "Sancus Sachet +1"        -- "Esper Stone +1"
    gear.andoaa_earring = "Evans Earring"        -- "Andoaa Earring"
    gear.lodurr_earring = "Evans Earring"        -- "Lodurr Earring"
    gear.evokers_ring = gear.stikini_ring1       -- "Evoker's Ring"
    gear.c_palug_crown = gear.apogee_head_b      -- "C. Palug Crown"
    gear.c_palug_earring = "Evans Earring"       -- "C. Palug Earring"
    gear.c_palug_ring = gear.varar_ring2         -- "C. Palug Ring"
    gear.gelos_earring = gear.jse_ear2           -- "Gelos Earring"
    gear.enticers_pants = gear.apogee_legs_d     -- "Enticer's Pants"
    gear.conveyance_cape = gear.campestres_magic -- "Conveyance Cape"
    gear.phys_jse_back = "Scintillating Cape"    -- Physical BP cape placeholder.
    gear.magic_jse_back = gear.campestres_magic
    gear.idle_jse_back = gear.campestres_magic
    gear.kobo_obi = "Regal Belt"                -- "Kobo Obi"
    gear.lucidity_sash = "Regal Belt"           -- "Lucidity Sash"
    gear.incarnation_sash = "Incarnation Sash"
    gear.baayami_body = gear.af3_body           -- "Baayami Robe"
    gear.baayami_hands = "Lamassu Mitts +1"     -- "Baayami Cuffs"
    gear.baayami_legs = gear.apogee_legs_d      -- "Baayami Slops"
    gear.baayami_feet = gear.apogee_feet_b      -- "Baayami Sabots"
    gear.telchine_head = gear.af3_head          -- "Telchine Cap"
    gear.telchine_body = gear.af3_body          -- "Telchine Chasuble"
    gear.telchine_hands = "Lamassu Mitts +1"    -- "Telchine Gloves"
    gear.telchine_legs = gear.apogee_legs_d     -- "Telchine Braconi"
    gear.telchine_feet = gear.apogee_feet_b     -- "Telchine Pigaches"
    gear.beckoner_bracers = "Lamassu Mitts +1"  -- "Beckoner's Bracers +3"
    gear.beckoner_pigaches = gear.apogee_feet_b -- "Beckoner's Pigaches +3"
    gear.convoker_pigaches = gear.apogee_feet_b -- "Convoker's Pigaches +3"

    gear.perp_staff = gear.gridarvor

    send_command('bind !` input /ja "Release" <me>')
    send_command('bind @` gs c cycle MagicBurst')
    send_command('bind ^` gs c toggle PactSpamMode')
    send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast Sets
    --------------------------------------

    sets.precast.JA['Astral Flow'] = {
        -- head = gear.af2_head,
    }

    sets.precast.JA['Elemental Siphon'] = {
        main = gear.espiritus,
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        head = gear.af3_head,
        neck = "Caller's Pendant",
        ear1 = "Evans Earring",
        ear2 = gear.jse_ear2,
        body = gear.af1_body,
        hands = "Lamassu Mitts +1",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.magic_jse_back,
        waist = "Regal Belt",
        legs = gear.apogee_legs_d,
        feet = gear.apogee_feet_b
    }

    sets.precast.JA['Mana Cede'] = {
        hands = gear.beckoner_bracers,
    }

    local bp_precast_ear2 = gear.andoaa_earring
    if gear.andoaa_earring == gear.lodurr_earring then
        bp_precast_ear2 = gear.jse_ear2
    end

    -- BP precast: Favor head first, then enough BP-/BPII- to reach the useful delay threshold,
    -- then summoning magic skill for Avatar's Favor potency and its separate delay reduction.
    sets.precast.BloodPactWard = {
        main = gear.espiritus,
        sub = gear.vox_grip,
        ammo = "Sancus Sachet +1",
        head = gear.af3_head,
        neck = "Hoxne Torque",
        ear1 = gear.lodurr_earring,
        ear2 = bp_precast_ear2,
        body = gear.af1_body,
        hands = gear.baayami_hands,
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.conveyance_cape,
        waist = gear.kobo_obi,
        legs = gear.baayami_legs,
        feet = gear.baayami_feet
    }

    sets.precast.BloodPactRage = sets.precast.BloodPactWard

    sets.precast.FC = {
        ammo = "Impatiens",
        neck = "Voltsurge Torque",
        ear1 = "Etiolation Earring",
        ear2 = "Loquac. Earring",
        ring1 = "Kishar Ring",
        ring2 = "Lebeche Ring",
        waist = "Witful Belt",
    }

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})
    sets.precast.FC.Impact = set_combine(sets.precast.FC, { head = empty })
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = gear.espiritus, sub = "Elan Strap +1" })

    sets.precast.WS = {
        ammo = "Oshasha's Treatise",
        head = "Nyame Helm",
        neck = "Fotia Gorget",
        ear1 = "Ishvara Earring",
        ear2 = "Moonshade Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Epaminondas's Ring",
        ring2 = "Cornelia's Ring",
        back = "Null Shawl",
        waist = "Fotia Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
        main = "Maxentius",
        sub = "Ammurapi Shield",
        back = gear.black_halo_jse_back,
    })
    sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS['Black Halo'], {
        ammo = "Crepuscular Pebble",
        ear1 = "Crep. Earring",
        ring1 = gear.chirich_ring1,
        ring2 = gear.chirich_ring2,
        waist = "Null Belt",
    })

    sets.precast.WS['Shattersoul'] = set_combine(sets.precast.WS, {
        main = gear.gridarvor,
        sub = "Elan Strap +1",
        ear1 = "Lugalbanda Earring",
        ring2 = "Metamor. Ring +1",
        waist = "Regal Belt",
    })

    sets.precast.WS['Retribution'] = set_combine(sets.precast.WS, {
        main = gear.gridarvor,
        sub = "Elan Strap +1",
        back = gear.black_halo_jse_back,
        waist = "Regal Belt",
    })

    sets.precast.WS['Garland of Bliss'] = set_combine(sets.precast.WS, {
        main = gear.gridarvor,
        sub = "Elan Strap +1",
        ear1 = "Lugalbanda Earring",
        ring2 = "Metamor. Ring +1",
        waist = "Regal Belt",
    })

    sets.MaxTP = { ear2 = "Ishvara Earring" }
    sets.MaxTP['Black Halo'] = { ear2 = "Telos Earring" }

    sets.precast.WS['Myrkr'] = {
        main = gear.gridarvor,
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        head = gear.af3_head,
        neck = "Caller's Pendant",
        ear1 = "Etiolation Earring",
        ear2 = "Evans Earring",
        body = gear.af1_body,
        hands = "Lamassu Mitts +1",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.apogee_legs_d,
        feet = gear.apogee_feet_b
    }

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

    sets.midcast.Cure = {
        ammo = "Staunch Tathlum +1",
        neck = "Loricate Torque +1",
        ear1 = "Evans Earring",
        ear2 = "Mendi. Earring",
        body = "Vrikodara Jupon",
        ring1 = "Naji's Loop",
        ring2 = "Menelaus's Ring",
        waist = "Null Belt",
    }

    sets.Self_Healing = { waist = "Gishdubar Sash" }
    sets.Cure_Received = { waist = "Gishdubar Sash" }
    sets.Self_Refresh = { waist = "Gishdubar Sash" }

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {})
    sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

    sets.midcast['Summoning Magic'] = {
        main = gear.espiritus,
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        head = gear.af3_head,
        neck = "Hoxne Torque",
        ear1 = "Evans Earring",
        ear2 = gear.jse_ear2,
        body = gear.af1_body,
        hands = "Lamassu Mitts +1",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.magic_jse_back,
        waist = "Regal Belt",
        legs = gear.apogee_legs_d,
        feet = gear.apogee_feet_b
    }

    sets.midcast['Elemental Magic'] = {
        main = gear.grioavolr_bp,
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        head = gear.apogee_head_b,
        neck = "Adad Amulet",
        ear1 = "Friomisi Earring",
        ear2 = "Lugalbanda Earring",
        body = gear.af2_body,
        hands = gear.merlinic_bp_hands,
        ring1 = "Metamor. Ring +1",
        ring2 = "Freke Ring",
        back = gear.magic_jse_back,
        waist = "Regal Belt",
        legs = gear.apogee_legs_d,
        feet = gear.apogee_feet_a
    }
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        neck = "Null Loop",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
    })
    sets.midcast['Elemental Magic'].OccultAcumen = set_combine(sets.midcast['Elemental Magic'], {
        main = gear.khatvanga,
    })

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'].Resistant, { head = empty })
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, { head = empty })
    sets.midcast['Divine Magic'] = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast['Dark Magic'] = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {})
    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast['Absorb-TP'] = set_combine(sets.midcast['Dark Magic'], {})
    sets.midcast['Absorb-TP'].Resistant = set_combine(sets.midcast['Dark Magic'], {})
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})
    sets.midcast.Stun.Resistant = set_combine(sets.midcast['Dark Magic'], {})
    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
    sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast['Enhancing Magic'] = {
        main = gear.espiritus,
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        neck = "Hoxne Torque",
        ear1 = "Evans Earring",
        ear2 = gear.jse_ear2,
        hands = "Lamassu Mitts +1",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.magic_jse_back,
        waist = "Regal Belt",
    }
    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

    --------------------------------------
    -- Avatar pact sets
    --------------------------------------

    sets.midcast.Pet.BloodPactWard = {
        main = gear.espiritus,
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        head = gear.af3_head,
        neck = gear.jse_neck,
        ear1 = "Evans Earring",
        ear2 = gear.jse_ear2,
        body = gear.af1_body,
        hands = "Lamassu Mitts +1",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.magic_jse_back,
        waist = "Regal Belt",
        legs = gear.apogee_legs_d,
        feet = gear.apogee_feet_b
    }

    sets.midcast.Pet.DebuffBloodPactWard = {
        main = gear.grioavolr_bp,
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        head = gear.c_palug_crown,
        neck = "Adad Amulet",
        ear1 = "Lugalbanda Earring",
        ear2 = "Evans Earring",
        body = gear.af1_body,
        hands = gear.merlinic_bp_hands,
        ring1 = gear.stikini_ring1,
        ring2 = gear.c_palug_ring,
        back = gear.magic_jse_back,
        waist = "Regal Belt",
        legs = gear.apogee_legs_d,
        feet = gear.beckoner_pigaches
    }
    sets.midcast.Pet.DebuffBloodPactWard.Acc = set_combine(sets.midcast.Pet.DebuffBloodPactWard, {
        ring2 = gear.stikini_ring2,
    })

    sets.midcast.Pet.PhysicalBloodPactRage = {
        main = gear.gridarvor,
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        head = gear.apogee_head_b,
        neck = gear.jse_neck,
        ear1 = "Lugalbanda Earring",
        ear2 = gear.jse_ear2,
        body = gear.af1_body,
        hands = "Asteria Mitts +1",
        ring1 = gear.varar_ring1,
        ring2 = gear.c_palug_ring,
        back = gear.phys_jse_back,
        waist = gear.incarnation_sash,
        legs = gear.apogee_legs_d,
        feet = gear.apogee_feet_b
    }
    sets.midcast.Pet.PhysicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {
        ring2 = gear.varar_ring2,
    })

    sets.midcast.Pet.MagicalBloodPactRage = {
        main = gear.grioavolr_bp,
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        head = gear.apogee_head_a,
        neck = "Adad Amulet",
        ear1 = "Lugalbanda Earring",
        ear2 = gear.jse_ear2,
        body = gear.af1_body,
        hands = gear.merlinic_bp_hands,
        ring1 = gear.varar_ring1,
        ring2 = gear.varar_ring2,
        back = gear.magic_jse_back,
        waist = "Regal Belt",
        legs = gear.apogee_legs_a,
        feet = gear.apogee_feet_a
    }
    sets.midcast.Pet.MagicalBloodPactRage.Acc = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
    })

    sets.midcast.Pet.WhiteMagic = {}
    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {})
    sets.midcast.Pet['Elemental Magic'].Resistant = set_combine(sets.midcast.Pet.MagicalBloodPactRage.Acc, {})
    sets.midcast.Pet['Impact'] = sets.midcast.Pet.DebuffBloodPactWard

    sets.midcast.Pet['Flaming Crush'] = {
        main = gear.grioavolr_bp,
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        head = gear.apogee_head_a,
        neck = "Adad Amulet",
        ear1 = "Lugalbanda Earring",
        ear2 = gear.jse_ear2,
        body = gear.af1_body,
        hands = gear.merlinic_bp_hands,
        ring1 = gear.varar_ring1,
        ring2 = gear.varar_ring2,
        back = gear.magic_jse_back,
        waist = "Regal Belt",
        legs = gear.apogee_legs_a,
        feet = gear.apogee_feet_a
    }
    sets.midcast.Pet['Flaming Crush'].Acc = set_combine(sets.midcast.Pet['Flaming Crush'], {
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
    })

    sets.midcast.Pet['Mountain Buster'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage,
        { legs = gear.enticers_pants })
    sets.midcast.Pet['Mountain Buster'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc,
        { legs = gear.enticers_pants })
    sets.midcast.Pet['Rock Buster'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage,
        { legs = gear.enticers_pants })
    sets.midcast.Pet['Rock Buster'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc,
        { legs = gear.enticers_pants })
    sets.midcast.Pet['Crescent Fang'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage,
        { legs = gear.enticers_pants })
    sets.midcast.Pet['Crescent Fang'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc,
        { legs = gear.enticers_pants })
    sets.midcast.Pet['Eclipse Bite'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage,
        { legs = gear.enticers_pants })
    sets.midcast.Pet['Eclipse Bite'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc,
        { legs = gear.enticers_pants })
    sets.midcast.Pet['Blindside'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage,
        { legs = gear.enticers_pants })
    sets.midcast.Pet['Blindside'].Acc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage.Acc,
        { legs = gear.enticers_pants })

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.resting = {
        main = gear.gridarvor,
        sub = "Elan Strap +1",
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head,
        neck = "Loricate Torque +1",
        ear1 = "Evans Earring",
        ear2 = "Sanare Earring",
        body = "Shomonjijoe +1",
        hands = "Lamassu Mitts +1",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.apogee_legs_d,
        feet = gear.apogee_feet_b
    }

    sets.idle = set_combine(sets.resting, {})

    sets.idle.PDT = {
        main = gear.malignance_pole,
        sub = "Elan Strap +1",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = gear.stikini_ring2,
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.idle.Avatar = {
        main = gear.gridarvor,
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        head = gear.af3_head,
        neck = "Caller's Pendant",
        ear1 = "Evans Earring",
        ear2 = gear.jse_ear2,
        body = "Shomonjijoe +1",
        hands = "Lamassu Mitts +1",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = gear.idle_jse_back,
        waist = "Regal Belt",
        legs = gear.apogee_legs_d,
        feet = gear.beckoner_pigaches
    }

    sets.idle.PDT.Avatar = set_combine(sets.idle.PDT, {
        main = gear.gridarvor,
        ammo = "Sancus Sachet +1",
        head = gear.af3_head,
        neck = "Caller's Pendant",
        ear1 = "Evans Earring",
        ear2 = gear.jse_ear2,
        body = "Shomonjijoe +1",
        hands = "Lamassu Mitts +1",
        back = gear.idle_jse_back,
        waist = "Regal Belt",
        legs = gear.apogee_legs_d,
        feet = gear.beckoner_pigaches
    })

    sets.idle.Spirit = set_combine(sets.idle.Avatar, {})
    sets.idle.PDT.Spirit = set_combine(sets.idle.PDT.Avatar, {})

    sets.idle.Avatar.Favor = {}
    sets.idle.Avatar.Engaged = {}
    sets.idle.Avatar.Engaged.Carbuncle = {}
    sets.idle.Avatar.Engaged['Cait Sith'] = {}

    sets.perp = {}
    sets.perp.Day = {}
    sets.perp.Weather = {}
    sets.perp.Carbuncle = {}
    sets.perp.Diabolos = {}
    sets.perp.Alexander = sets.midcast.Pet.BloodPactWard
    sets.perp.staff_and_grip = {}

    sets.defense.PDT = sets.idle.PDT
    sets.defense.MDT = set_combine(sets.idle.PDT, {
        neck = "Warder's Charm +1",
    })
    sets.defense.MEVA = set_combine(sets.defense.MDT, {
        neck = "Null Loop",
    })

    sets.Kiting = { ring2 = "Shneddick Ring" }
    sets.latent_refresh = { waist = "Null Belt" }
    sets.latent_refresh_grip = {}
    sets.TPEat = {}
    sets.DayIdle = {}
    sets.NightIdle = {}

    sets.HPDown = {
        head = gear.apogee_head_a,
        ear1 = "Evans Earring",
        ear2 = gear.jse_ear2,
        body = gear.af2_body,
        hands = "Asteria Mitts +1",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = "Null Shawl",
        legs = gear.apogee_legs_a,
        feet = gear.apogee_feet_a
    }

    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Sleep = {}

    -- Weapons sets
    sets.weapons.None = { main = empty, sub = empty, range = empty, ammo = "Sancus Sachet +1" }
    sets.weapons.Maxentius = { main = "Maxentius", sub = "Ammurapi Shield", range = empty, ammo = "Sancus Sachet +1" }
    sets.weapons.Gridarvor = { main = gear.gridarvor, sub = "Elan Strap +1", range = empty, ammo = "Sancus Sachet +1" }
    sets.weapons.Espiritus = { main = gear.espiritus, sub = "Elan Strap +1", range = empty, ammo = "Sancus Sachet +1" }
    sets.weapons.Grioavolr = { main = gear.grioavolr_bp, sub = "Elan Strap +1", range = empty, ammo = "Sancus Sachet +1" }

    sets.buff.Sublimation = { waist = "Embla Sash" }
    sets.buff.DTSublimation = { waist = "Embla Sash" }

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {
        main = gear.gridarvor,
        sub = "Elan Strap +1",
        ammo = "Sancus Sachet +1",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Dedition Earring",
        ear2 = "Telos Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = gear.stikini_ring1,
        ring2 = gear.stikini_ring2,
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        ring1 = gear.chirich_ring1,
        ring2 = gear.chirich_ring2,
    })

    sets.engaged.Maxentius = set_combine(sets.engaged, sets.weapons.Maxentius, {
        ammo = "Sancus Sachet +1",
        head = "Nyame Helm",
        neck = "Null Loop",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = gear.chirich_ring1,
        ring2 = gear.chirich_ring2,
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
    })

    sets.engaged.Maxentius.Acc = set_combine(sets.engaged.Maxentius, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end

    set_macro_page(1, 8)
end

function user_job_customize_melee_set(meleeSet)
    if state.Weapons and sets.engaged[state.Weapons.value] then
        local weaponSet = sets.engaged[state.Weapons.value]

        if weaponSet[state.OffenseMode.current] then
            return weaponSet[state.OffenseMode.current]
        end

        return weaponSet
    end

    return meleeSet
end

function user_job_lockstyle()
    windower.chat.input('/lockstyleset 017')
end
