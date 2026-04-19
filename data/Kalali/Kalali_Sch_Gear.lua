-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function character_user_job_setup()
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Proc', 'OccultAcumen', '9k')
    state.IdleMode:options('Normal', 'PDT')
    state.HybridMode:options('Normal', 'PDT')
    state.Weapons:options('None', 'Musa', 'Chatoyant', 'Mpaca', 'Bunzi', 'Maxentius')
    state.MusaMode:options('Never', '1000', 'Always')

    default_weapons = 'Maxentius'

    autows_list = { ['Maxentius'] = 'Black Halo' }

    gear.nuke_jse_back = { name = "Lugh's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', } }
    gear.jse_neck = "Argute Stole +2"
    gear.jse_earring = "Arbatel Earring"

    -- Artifact Gear
    gear.af1_head = "Acad. Mortar. +3"
    gear.af1_body = "Acad. Gown +3"
    gear.af1_hands = "Acad. Bracers +3"
    gear.af1_legs = "Acad. Pants +3"
    gear.af1_feet = "Acad. Loafers +3"

    -- Relic Gear
    gear.af2_head = "Pedagogy Mortar. +3"
    gear.af2_body = "Pedagogy Gown +3"
    gear.af2_hands = "Pedagogy Bracers +3"
    gear.af2_legs = "Pedagogy Pants +3"
    gear.af2_feet = ""

    -- Empy Gear
    gear.af3_head = "Arbatel Bonnet +2"
    gear.af3_body = "Arbatel Gown +2"
    gear.af3_hands = "Arbatel Bracers +2"
    gear.af3_legs = "Arbatel Pants +3"
    gear.af3_feet = "Arbatel Loafers +3"


    gear.kishar_ring = ""
    gear.perimede_cape = ""
    gear.oshashas_treatise = ""
    gear.fotia_gorget = ""
    gear.fotia_belt = ""
    gear.cornelias_ring = ""
    gear.luminary_sash = ""
    gear.orunmilas_torque = ""
    gear.incanters_torque = ""
    gear.meili_earring = ""
    gear.sibyl_scarf = ""
    gear.debilis_medallion = ""
    gear.hieros_mittens = ""
    gear.bishops_sash = ""
    gear.telchine_cap = ""
    gear.andoaa_earring = ""
    gear.telchine_braconi = ""
    gear.obstinate_sash = ""
    gear.freke_ring = ""
    gear.sacro_cord = ""
    gear.fuchonoobi = ""
    gear.null_masque = ""
    gear.crep_earring = ""
    gear.prolix_ring = ""
    gear.homiliary = ""
    gear.ethereal_earring = ""
    gear.sanare_earring = ""
    gear.shadow_ring = ""
    gear.shadow_mantle = ""
    gear.plat_mog_belt = ""

    -- Additional local binds
    send_command('bind @` gs c cycle ElementalMode')
    send_command('bind ^` gs c scholar dark')
    send_command('bind !` gs c scholar light')
    send_command('bind !backspace gs c scholar speed')
    send_command('bind ^backspace gs c scholar power')
    send_command('bind @backspace gs c scholar cost')
    send_command('bind ^\\\\ input /ma "Protect V" <t>')
    send_command('bind @\\\\ input /ma "Shell V" <t>')
    send_command('bind !\\\\ input /ma "Reraise III" <me>')
    send_command('bind @f8 gs c toggle AutoNukeMode')
    send_command('bind @f10 gs c cycle RecoverMode')
    send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Weapons sets
    sets.weapons.Chatoyant = { main = "Chatoyant", sub = "Khonsu" }
    sets.weapons.Musa = { main = "Musa", sub = "Khonsu" }
    sets.weapons.Mpaca = { main = "Mpaca's Staff", sub = "Khonsu" }
    sets.weapons.Bunzi = { main = "Bunzi's Rod", sub = "Ammurapi Shield" }
    sets.weapons.Maxentius = { main = "Maxentius", sub = "Ammurapi Shield" }

    -- Precast Sets

    -- Precast Sets

    sets.precast.JA['Tabula Rasa'] = { legs = gear.af2_legs }
    sets.precast.JA['Enlightenment'] = { body = gear.af2_body }

    -- Fast cast sets for spells
    sets.precast.FC = {
        main = "Musa",
        sub = "Khonsu",
        ammo = "Impatiens",
        --head = --[[codex removed]]
        neck = gear.orunmilas_torque,
        ear1 = "Malignance Earring",
        ear2 = "Loquac. Earring",
        --body = "Pinga Tunic",
        --hands = "Gende. Gages +1",
        ring1 = gear.kishar_ring,
        ring2 = "Lebeche Ring",
        back = gear.perimede_cape,
        waist = "Witful Belt",
        --legs = "Pinga Pants",
        --feet = --[[codex removed]]
    }

    sets.precast.FC.DT = {
        main = "Musa",
        sub = "Khonsu",
        ammo = "Impatiens",
        --head = --[[codex removed]]
        neck = gear.orunmilas_torque,
        ear1 = "Malignance Earring",
        ear2 = "Loquac. Earring",
        --body = "Pinga Tunic",
        --hands = "Gende. Gages +1",
        ring1 = gear.kishar_ring,
        ring2 = "Lebeche Ring",
        back = gear.perimede_cape,
        waist = "Witful Belt",
        --legs = "Pinga Pants",
        --feet = --[[codex removed]]
    }

    sets.precast.FC.Arts = { feet = gear.af1_feet }
    sets.precast.FC.Impact = set_combine(sets.precast.FC, { head = empty, body = "Crepuscular Cloak" })
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", --[[sub = "Genmei Shield"]] })
    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], { head = empty, body = "Crepuscular Cloak" })
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", --[[sub = "Genmei Shield"]] })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined

    sets.precast.WS = {
        ammo = gear.oshashas_treatise,
        head = "Nyame Helm",
        neck = gear.fotia_gorget,
        ear1 = "Brutal Earring",
        ear2 = "Moonshade Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Epaminondas's Ring",
        ring2 = gear.cornelias_ring,
        back = "Null Shawl",
        waist = gear.fotia_belt,
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.precast.WS['Myrkr'] = {
        ammo = "Ghastly Tathlum +1",
        head = "Pixie Hairpin +1",
        --neck = "Sanctity Necklace",
        ear1 = "Etiolation Earring",
        ear2 = "Moonshade Earring",
        body = gear.af3_body,
        hands = "Nyame Gauntlets",
        --ring1 = "Mephitas's Ring +1",
        ring2 = "Metamor. Ring +1",
        --back = "Pahtli Cape",
        waist = gear.luminary_sash,
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    -- Midcast Sets

    sets.midcast.FastRecast = {
        main = "Musa",
        sub = "Khonsu",
        ammo = "Pemphredo Tathlum",
        --head = --[[codex removed]]
        neck = gear.orunmilas_torque,
        ear1 = "Malignance Earring",
        ear2 = "Loquac. Earring",
        --body = "Pinga Tunic",
        --hands = "Gende. Gages +1",
        ring1 = gear.kishar_ring,
        ring2 = "Lebeche Ring",
        --back = "Solemnity Cape",
        --waist = "Cornelia's Belt",
        --legs = "Pinga Pants",
        --feet = --[[codex removed]]
    }

    sets.midcast.Cure = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Pemphredo Tathlum",
        head = "Kaykaus Mitra +1",
        neck = gear.incanters_torque,
        ear1 = gear.meili_earring,
        ear2 = "Mendi. Earring",
        body = "Kaykaus Bliaut +1",
        hands = "Kaykaus Cuffs +1",
        ring1 = "Naji's Loop",
        ring2 = "Menelaus's Ring",
        --back = "Solemnity Cape",
        waist = gear.luminary_sash,
        legs = "Kaykaus Tights +1",
        feet = "Kaykaus Boots +1"
    }

    sets.midcast.LightWeatherCure = {
        main = "Chatoyant Staff",
        sub = "Khonsu",
        range = empty,
        ammo = "Pemphredo Tathlum",
        head = "Kaykaus Mitra +1",
        neck = gear.incanters_torque,
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

    sets.midcast.LightDayCure = {
        main = "Chatoyant Staff",
        sub = "Khonsu",
        range = empty,
        ammo = "Pemphredo Tathlum",
        head = "Kaykaus Mitra +1",
        neck = gear.incanters_torque,
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

    sets.midcast.Curaga = sets.midcast.Cure

    sets.Self_Healing = { waist = "Gishdubar Sash" }
    sets.Cure_Received = { waist = "Gishdubar Sash" }
    sets.Self_Refresh = { waist = "Gishdubar Sash" }

    sets.midcast.Cursna = {
        main = "Musa",
        sub = "Khonsu",
        range = empty,
        --ammo = "Hasty Pinion +1",
        --head = "Vanya Hood",
        neck = gear.debilis_medallion,
        ear1 = "Malignance Earring",
        ear2 = gear.meili_earring,
        --body = "Pinga Tunic",
        hands = gear.hieros_mittens,
        ring1 = "Haoma's Ring",
        ring2 = "Menelaus's Ring",
        back = "Oretan. Cape +1",
        waist = gear.bishops_sash,
        --legs = "Pinga Pants",
        --feet = "Vanya Clogs"
    }

    sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {
        main = "Musa",
        sub = "Khonsu"
    })

    sets.midcast['Enhancing Magic'] = {
        --ammo = "Savant's Treatise",
        head = gear.telchine_cap,
        neck = gear.incanters_torque,
        ear1 = gear.andoaa_earring,
        --ear2 = "Gifted Earring",
        --body = "Telchine Chas.",
        --hands = "Telchine Gloves",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = gear.perimede_cape,
        waist = "Embla Sash",
        legs = gear.telchine_braconi,
        --feet = "Telchine Pigaches"
    }

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],
        { main = "Musa", head = gear.af3_head, back = "Bookworm's Cape" })


    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], { head = "Amalric Coif +1" })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
        { head = "Amalric Coif +1", waist = "Emphatikos Rope" })

    sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], { ring2 = "Sheltered Ring" })
    sets.midcast.Shellra = sets.midcast.Shell


    -- Custom spell classes

    sets.midcast['Enfeebling Magic'] = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = gear.kishar_ring,
        ring2 = "Stikini Ring +1",
        back = "Null Shawl",
        waist = gear.obstinate_sash,
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast['Enfeebling Magic'].Resistant = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Metamor. Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Dia II'] = sets.midcast['Enfeebling Magic']
    sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Bio II'] = sets.midcast['Enfeebling Magic']

    sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'],
        { ring2 = "Stikini Ring +1", })

    sets.midcast['Dark Magic'] = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Metamor. Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Kaustra = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Pixie Hairpin +1",
        --neck = "Saevus Pendant +1",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = gear.freke_ring,
        ring2 = "Metamor. Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Kaustra.Resistant = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Metamor. Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Drain = {
        ammo = "Pemphredo Tathlum",
        head = "Pixie Hairpin +1",
        neck = "Erra Pendant",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Evanescence Ring",
        ring2 = "Stikini Ring +1",
        back = "Null Shawl",
        waist = gear.fuchonoobi,
        legs = gear.af2_legs,
        feet = gear.af3_feet --feet = "Agwu's Pigaches"
    }

    sets.midcast.Drain.Resistant = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Metamor. Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

    sets.midcast.Stun = {
        main = "Musa",
        sub = "Khonsu",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        --ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Metamor. Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Stun.Resistant = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Metamor. Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {
        main = "Bunzi's Rod",
        sub = "Culminus",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = "Saevus Pendant +1",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = gear.freke_ring,
        ring2 = "Metamor. Ring +1",
        back = gear.nuke_jse_back,
        waist = gear.sacro_cord,
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast['Elemental Magic'].Resistant = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Metamor. Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast['Elemental Magic']['9k'] = {
        main = "Maxentius",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.null_masque,
        neck = "Null Loop",
        ear1 = gear.crep_earring,
        ear2 = "Gwati Earring",
        --body = "Volte Doublet",
        --hands = "Volte Bracers",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        --legs = --[[codex removed]]
        feet = gear.af3_feet
    }

    sets.midcast['Elemental Magic'].Proc = {
        --main = "Mafic Cudgel",
        --sub = "Genmei Shield",
        ammo = "Impatiens",
        head = gear.null_masque,
        neck = "Null Loop",
        ear1 = "Etiolation Earring",
        ear2 = "Loquac. Earring",
        --body = "Volte Doublet",
        --hands = "Volte Bracers",
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        --legs = --[[codex removed]]
        --feet = "Medium's Sabots"
    }

    sets.midcast['Elemental Magic'].OccultAcumen = {}


    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = gear.sibyl_scarf,
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = gear.freke_ring,
        ring2 = "Metamor. Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Metamor. Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Helix = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = gear.sibyl_scarf,
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = gear.freke_ring,
        ring2 = "Metamor. Ring +1",
        back = "Bookworm's Cape",
        waist = "Acuity Belt +1",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Helix.Resistant = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Metamor. Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Helix.Proc = {
        main = empty,
        sub = empty,
        ammo = "Impatiens",
        --head = "Vanya Hood",
        neck = gear.orunmilas_torque,
        ear1 = "Etiolation Earring",
        ear2 = "Loquac. Earring",
        --body = "Volte Doublet",
        --hands = "Gende. Gages +1",
        ring1 = gear.kishar_ring,
        ring2 = gear.prolix_ring,
        --back = "Swith Cape +1",
        waist = "Witful Belt",
        --legs = "Psycloth Lappas",
        --feet = "Regal Pumps +1"
    }

    sets.midcast.Impact = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = empty,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        ear2 = gear.jse_earring,
        body = "Crepuscular Cloak",
        hands = gear.af3_hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Metamor. Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen,
        { head = empty, body = "Crepuscular Cloak" })

    -- Gear for Magic Burst mode.
    sets.MagicBurst = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        neck = "Mizukage-no-Kubikazari",
        ring2 = "Mujin Band"
    }
    sets.HelixBurst = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        neck = "Mizukage-no-Kubikazari",
        ring2 = "Mujin Band"
    }
    sets.ResistantHelixBurst = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        neck = "Mizukage-no-Kubikazari",
        ring2 = "Mujin Band"
    }

    -- Gear that converts elemental damage done to recover MP.
    sets.RecoverMP = {} --body="Seidr Cotehardie"

    -- Gear for specific elemental nukes.
    sets.element.Dark = { head = "Pixie Hairpin +1" --[[, ring2 = "Archon Ring"]] }

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {
        --main = "Mpaca's Staff",
        --sub = "Oneiros Grip",
        ammo = gear.homiliary,
        head = gear.null_masque,
        neck = gear.sibyl_scarf,
        ear1 = "Etiolation Earring",
        ear2 = gear.ethereal_earring,
        body = gear.af3_body,
        --hands = --[[codex removed]]
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        --legs = --[[codex removed]]
        --feet = --[[codex removed]]
    }

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
        main = "Mpaca's Staff",
        sub = "Oneiros Grip",
        ammo = gear.homiliary,
        head = gear.null_masque,
        neck = gear.sibyl_scarf,
        ear1 = "Etiolation Earring",
        ear2 = gear.ethereal_earring,
        body = gear.af3_body,
        --hands = --[[codex removed]]
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        --legs = --[[codex removed]]
        --feet = --[[codex removed]]
    }

    sets.idle.PDT = {
        main = "Daybreak",
        --sub = "Genmei Shield",
        ammo = "Staunch Tathlum +1",
        head = "Kaykaus Mitra +1",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = gear.ethereal_earring,
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = gear.shadow_ring,
        back = gear.shadow_mantle,
        waist = gear.plat_mog_belt,
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.idle.MDT = {
        main = "Daybreak",
        --sub = "Genmei Shield",
        range = empty,
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head,
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = gear.sanare_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Murky Ring",
        ring2 = gear.shadow_ring,
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.idle.MEVA = {
        main = "Daybreak",
        sub = "Genmei Shield",
        range = empty,
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Etiolation Earring",
        ear2 = gear.sanare_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Murky Ring",
        ring2 = gear.shadow_ring,
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    -- Defense sets

    sets.defense.PDT = {
        main = "Daybreak",
        --sub = "Genmei Shield",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = gear.ethereal_earring,
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Murky Ring",
        ring2 = gear.shadow_ring,
        back = gear.shadow_mantle,
        waist = gear.plat_mog_belt,
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.MDT = {
        main = "Daybreak",
        --sub = "Genmei Shield",
        range = empty,
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head,
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = gear.sanare_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Murky Ring",
        ring2 = gear.shadow_ring,
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.defense.MEVA = {
        main = "Daybreak",
        --sub = "Genmei Shield",
        range = empty,
        ammo = "Staunch Tathlum +1",
        head = gear.af3_head,
        neck = "Null Loop",
        ear1 = "Etiolation Earring",
        ear2 = gear.sanare_earring,
        body = gear.af3_body,
        hands = gear.af3_hands,
        ring1 = "Murky Ring",
        ring2 = gear.shadow_ring,
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.Kiting = { ring2 = "Shneddick Ring" }
    sets.latent_refresh = { waist = gear.fuchonoobi }
    --sets.latent_refresh_grip = { sub = "Oneiros Grip" }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        main = "Maxentius",
        --sub = "Genmei Shield",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Null Loop",
        ear1 = "Brutal Earring",
        ear2 = "Dedition Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.engaged.Acc = {
        main = "Maxentius",
        --sub = "Genmei Shield",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Null Loop",
        ear1 = gear.crep_earring,
        ear2 = "Telos Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = { head = gear.af3_head }
    sets.buff['Rapture'] = { head = gear.af3_head }
    sets.buff['Perpetuance'] = { hands = gear.af3_hands }
    sets.buff['Immanence'] = { hands = gear.af3_hands }
    sets.buff['Penury'] = { legs = gear.af3_legs }
    sets.buff['Parsimony'] = { legs = gear.af3_legs }
    sets.buff['Focalization'] = {}
    sets.buff['Celerity'] = {}
    sets.buff['Alacrity'] = {}
    sets.buff['Klimaform'] = { feet = gear.af3_feet }
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff['Light Arts'] = {} --legs="Academic's Pants +3"
    sets.buff['Dark Arts'] = {}  --body="Academic's Gown +3"
    sets.buff.Sublimation = { waist = "Embla Sash" --[[, ear1 = "Savant's Earring"]] }
    sets.buff.DTSublimation = { waist = "Embla Sash" --[[, ear1 = "Savant's Earring" ]] }
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
    if player.sub_job == 'RDM' then
        set_macro_page(2, 5)
    elseif player.sub_job == 'WHM' then
        set_macro_page(3, 5)
    else
        set_macro_page(1, 5)
    end
end
