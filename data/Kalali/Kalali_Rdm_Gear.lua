function user_job_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Match', 'Proc')
    state.AutoBuffMode:options('Off', 'Auto', 'AutoMelee')
    state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'MDT', 'DTHippo')
    state.PhysicalDefenseMode:options('PDT', 'NukeLock')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('None', 'Crocea', 'DualCrocea', 'DualNaegling', 'DualNaeglingAcc', 'DualAeolian',
        'DualBlackHalo', 'DualBow', 'DualEnspellOnly')


    -- Defaults when no weather/day
    gear.obi_cure_back = "Tempered Cape +1"          --TODO
    gear.obi_cure_waist = "Witful Belt"              --TODO

    gear.obi_low_nuke_back = "Toro Cape"             --TODO
    gear.obi_low_nuke_waist = "Sekhmet Corset"       --TODO

    gear.obi_high_nuke_back = "Toro Cape"            --TODO
    gear.obi_high_nuke_waist = "Refoccilation Stone" --TODO

    -- Ambuscade Capes
    gear.dw_jse_back = { name = "Sucellos's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dual Wield"+10', 'Phys. dmg. taken-10%' } } --TODO
    gear.stp_jse_back = gear.dw_jse_back
    gear.nuke_jse_back = { name = "Sucellos's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', '"Mag.Atk.Bns."+10', 'Phys. dmg. taken-10%', } }       --TODO
    gear.cure_jse_back = { name = "Sucellos's Cape", augments = { 'MND+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'MND+9', '"Fast Cast"+10', 'Phys. dmg. taken-10%', } } --TODO
    gear.mnd_wsd_jse_back = { name = "Sucellos's Cape", augments = { 'MND+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'MND+10', 'Weapon skill damage +10%' } }            --TODO
    gear.str_wsd_jse_back = gear.mnd_wsd_jse_back

    -- JSE Weapon/Neck/Earring
    gear.jse_ear2 = { name = "Lethergy Earring+1", augments = { 'R. Ear:Accuracy+11 Mag. Acc.+11', '"Double Attack"+3%' } }
    gear.jse_neck = "Dis. Torque +2"
    gear.ghostfyre_back = { name = "Ghostfyre Cape" }

    -- Artifact Gear
    gear.af1_head = "Atro. Chapeau +4"
    gear.af1_body = "Atrophy Tabard +3"
    gear.af1_hands = "Atro. Gloves +4"
    gear.af1_legs = "Atro. Tights +4"
    gear.af1_feet = "Atro. Boots +4"

    -- Relic Gear
    gear.af2_head = "Viti. Chapeau +3"
    gear.af2_body = "Viti. Tabard +3"
    gear.af2_hands = "Viti. Gloves +3"
    gear.af2_legs = {}
    gear.af2_feet = "Viti. Boots +3"

    -- Empy Gear
    gear.af3_head = "Leth. Chappel +2"
    gear.af3_body = "Lethargy Sayon +2"
    gear.af3_hands = "Leth. Gantherots +2"
    gear.af3_legs = "Leth. Fuseau +2"
    gear.af3_feet = "Leth. Houseaux +2"

    -- List of gear I want, could be BiS. When I get the item, can replace it here
    -- main
    -- sub = "Sacro Bulwark"
    -- sub = "Genmei Shield"
    -- sub = "Forfend +1"
    -- sub = "Diamond Aspis"
    -- sub = "Culminus"
    -- range
    -- ammo
    gear.regal_gem = "Staunch Tathlum+1" --ammo = "Regal Gem"
    gear.impatiens = "Staunch Tathlum+1" --ammo = "Impatiens"
    -- head
    -- neck = "Fotia Gorget"
    -- neck = "Baetyl Pendant"
    -- neck = "Sibyl Scarf"
    -- ear1 = "Regal Earring"
    -- ear2
    -- body
    -- body = "Twilight Cloak"
    -- hands
    -- ring1 = "Kishar Ring"
    -- ring1 = "Freke Ring"
    -- ring2 = "Lebeche Ring"
    -- ring2 = "Metamorphic Ring +1"
    -- ring2 = "Archon Ring"
    -- back = "Perimede Cape"
    -- waist = "Fotia Belt"
    -- waist = "Witful Belt"
    -- legs
    -- feet

    -- Additional local binds

    send_command('bind !` gs c toggle AutoNukeMode')
    send_command('bind ^` gs c cycle ElementalMode')
    send_command('bind @` gs c cycle MagicBurstMode')

    send_command('bind ^@!` input /ja "Accession" <me>')
    send_command('bind ^backspace input /ja "Saboteur" <me>')
    send_command('bind !backspace input /ja "Spontaneity" <t>')
    send_command('bind @backspace input /ja "Composure" <me>')
    -- send_command('bind @f8 gs c toggle AutoNukeMode')
    send_command('bind != input /ja "Penury" <me>')
    send_command('bind @= input /ja "Parsimony" <me>')
    send_command('bind ^delete input /ja "Dark Arts" <me>')
    send_command('bind !delete input /ja "Addendum: Black" <me>')
    send_command('bind @delete input /ja "Manifestation" <me>')
    send_command('bind ^\\\\ input /ma "Protect V" <t>')
    send_command('bind @\\\\ input /ma "Shell V" <t>')
    send_command('bind !\\\\ input /ma "Reraise" <me>')
    send_command('bind @f10 gs c cycle RecoverMode')
    send_command(
        'bind ^r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c weapons Default;gs c set unlockweapons false')
    send_command('bind ^q gs c set weapons enspellonly;gs c set unlockweapons true')
    send_command('bind !r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c set weapons none')
    send_command('bind !q gs c set skipprocweapons false;gs c set weapons DualProcDaggers;gs c set weaponskillmode proc')

    select_default_macro_book()
end

function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = { body = gear.af2_body }


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells

    sets.precast.FC = {
        main = "Crocea Mors",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = gear.impatiens,
        head = gear.af1_head,
        ear1 = "Malignance Earring",
        ear2 = gear.jse_ear2,
        body = gear.af2_body,
        -- ring1 = "Kishar Ring",
        -- ring2 = "Lebeche Ring",
        back = gear.cure_jse_back
        -- back = "Perimede Cape",
        -- waist = "Witful Belt",
    }

    sets.precast.FC.Impact = set_combine(sets.precast.FC, { head = empty, body = "Twilight Cloak" })
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", --[[ sub = "Sacro Bulwark" ]] })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        range = empty,
        ammo = gear.gog_ammo,
        head = gear.af2_head,
        neck = gear.jse_neck,
        ear1 = gear.wotg_ear,
        ear2 = "Ishvara Earring",
        body = gear.nyame_body,
        hands = gear.af1_hands,
        ring1 = "Sroda Ring",
        ring2 = "Epaminondas's Ring",
        back = gear.wsd_jse_back,
        waist = "Sailfi Belt +1",
        legs = gear.nyame_legs,
        feet = gear.af3_feet
    }

    sets.precast.WS.Proc = {
        range = empty,
        -- ammo = "Hasty Pinion +1", TODO
        head = "Malignance Chapeau",
        neck = "Null Loop",
        -- ear1 = "Mache Earring +1", TODO
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Chirich Ring +1",
        ring2 = "Chirich Ring +1",
        back = gear.wsd_jse_back,
        waist = "Null Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        -- neck = "Fotia Gorget",
        ear2 = "Sherida Earring",
        hands = gear.bunzi_hands,
        ring1 = "Sroda Ring",
        -- ring2 = "Metamorphic Ring +1",
        back = gear.wsd_jse_back,
        -- waist = "Fotia Belt",
    })

    sets.precast.WS['Chant Du Cygne'] = set_combine(sets.precast.WS, {
        range = empty,
        ammo = "Voluspa Tathlum",
        head = "Malignance Chapeau",
        -- neck = "Fotia Gorget",
        ear1 = "Moonshade Earring",
        ear2 = "Sherida Earring",
        body = "Malignance Tabard",
        hands = gear.af1_hands,
        -- ring1 = "Begrudging Ring", TODO
        ring2 = "Ilabrat Ring",
        back = gear.wsd_jse_back,
        -- waist = "Fotia Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    })

    sets.precast.WS['Evisceration'] = sets.precast.WS['Chant Du Cygne']

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Sanguine Blade'] = {
        range = empty,
        ammo = "Sroda Tathlum",
        head = "Pixie Hairpin +1",
        -- neck = "Baetyl Pendant",
        -- ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        body = gear.nyame_body,
        hands = "Jhakri Cuffs +2",
        -- ring1 = "Metamor. Ring +1",
        -- ring2 = "Archon Ring",
        back = gear.mnd_wsd_jse_back,
        waist = "Orpheus's Sash",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    sets.precast.WS['Seraph Blade'] = {
        range = empty,
        ammo = "Sroda Tathlum",
        head = gear.af3_head,
        -- neck = "Fotia Gorget",
        -- ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        body = gear.nyame_body,
        hands = gear.af3_hands,
        ring1 = "Shiva Ring +1",
        -- ring1 = "Freke Ring",
        ring2 = "Epaminondas's Ring",
        back = gear.mnd_wsd_jse_back,
        waist = "Orpheus's Sash",
        legs = gear.nyame_body,
        feet = gear.af3_feet
    }

    sets.precast.WS['Red Lotus Blade'] = sets.precast.WS['Seraph Blade']

    sets.precast.WS['Aeolian Edge'] = {
        range = empty,
        ammo = "Sroda Tathlum",
        head = gear.af3_head,
        -- neck = "Sibyl Scarf",
        -- ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        body = gear.nyame_body,
        hands = "Jhakri Cuffs +2",
        -- ring1 = "Metamor. Ring +1",
        -- ring2 = "Freke Ring",
        back = gear.nuke_jse_back,
        waist = "Refoccilation Stone",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    -- Midcast Sets

    -- sets.TreasureHunter = set_combine(sets.TreasureHunter, { feet = gear.chironic_treasure_feet })

    -- Gear that converts elemental damage done to recover MP.
    -- sets.RecoverMP = { body = "Seidr Cotehardie" }

    -- Gear for Magic Burst mode.
    sets.MagicBurst = {
        main = gear.bunzi_rod,
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Ghastly Tanthum +1",
        -- head = "Ea Hat",
        -- neck = "Sibyl Scarf",
        neck = gear.jse_neck,
        -- body = "Ea Houppelande",
        body = "Amalric Doublet +1",
        -- hands = gear.bunzi_hands,
        hands = gear.bunzi_hands,
        -- ring1 = "Freke Ring",
        -- ring2 = "Metamorphic Ring+1",
        back = gear.nuke_jse_back,
        -- waist = "Acuity Belt +1",
        -- legs = "Ea Slops",
        legs = "Amalric Slops +1",
        -- feet = gear.af2_feet  (when +4)
        feet = "Amalric Nails +1"
    }

    sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

    sets.midcast.Cure = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = gear.regal_gem,
        head = "Kaykaus Mitra +1",
        -- neck = "Incanter's Torque",
        -- ear1 = "Meili Earring",
        ear2 = "Mendi. Earring",
        body = "Kaykaus Bliaut +1",
        hands = "Kaykaus Cuffs +1",
        ring1 = "Naji's Loop",
        ring2 = "Menelaus's Ring",
        back = gear.cure_jse_back,
        -- waist = "Luminary Sash",
        legs = "Kaykaus Tights +1",
        feet = "Kaykaus Boots +1"
    }

    sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {
        main = "Chatoyant Staff",
        sub = "Enki Strap",
        back = "Twilight Cape",
        waist = "Hachirin-no-Obi",
    })

    --Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {
        back = "Twilight Cape",
        waist = "Hachirin-no-Obi",
    })
    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        body = gear.af2_body,
        ring2 = "Menelaus's Ring"
    })
    sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
    sets.midcast.Curaga = sets.midcast.Cure
    sets.Self_Healing = {
        -- neck = "Phalaina Locket",
        ear1 = "Etiolation Earring",
        -- hands = "Buremte Gloves",
        --  ring2 = "Kunaji Ring",
        -- waist = "Gishdubar Sash"
    }
    sets.Cure_Received = {
        -- neck = "Phalaina Locket",
        -- hands = "Buremte Gloves",
        -- ring2 = "Kunaji Ring",
        -- waist = "Gishdubar Sash"
    }
    sets.Self_Refresh = {
        -- back = "Grapevine Cape",
        -- waist = "Gishdubar Sash",
    }
    sets.midcast['Enhancing Magic'] = {
        -- main = "Colada",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Staunch Tanthlum +1",
        head = gear.af3_head,
        neck = gear.jse_neck,
        ear1 = gear.limbus_ear1,
        ear2 = gear.jse_ear2,
        body = gear.af2_body,
        hands = gear.af1_hands,
        ring1 = gear.limbus_ring1,
        ring2 = "Stikini Ring +1",
        back = gear.ghostfyre_back,
        waist = "Embla Sash",
        legs = gear.af3_legs,
        feet = gear.af3_feet
    }

    --Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.
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
        -- main = "Pukulatmuj +1",
        -- sub = "Forfend +1",
        range = empty,
        ammo = "Staunch Tathlum +1",
        -- head = "Befouled Crown",
        -- neck = "Incanter's Torque",
        -- ear1 = "Andoa Earring",
        ear2 = "Mimir Earring",
        body = gear.af2_body,
        hands = gear.af2_hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Ghostfyre Cape",
        -- waist = "Olympus Sash",
        legs = gear.af1_legs,
        feet = gear.af3_feet
    }
    sets.midcast.Refresh = {
        -- head = "Amalric Coif +1",
        body = gear.af1_body,
        legs = gear.af3_legs,
    }
    sets.midcast.Aquaveil = {
        -- head = "Amalric Coif +1",
        hands = "Regal Cuffs",
        -- waist = "Emphatikos Rope",
        legs = "Shedir Seraweels"
    }
    sets.midcast.Phalanx = set_combine(sets.EnhancingSkill, {
        main = gear.sakpata_sword,
        -- sub = "Colada" (With Phalanx augs)
        sub = "Forfend +1",
        head = gear.limbus_head,
        neck = gear.jse_neck,
        ear1 = "Mimir Earring",
        ear2 = gear.jse_ear2,
        body = gear.sworn_body,
        hands = gear.sworn_hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        waist = "Embla Sash",
        legs = gear.sworn_legs,
        feet = gear.sworn_feet
    })
    sets.midcast.BarElement = { legs = "Shedir Seraweels" }
    sets.midcast.Temper = sets.EnhancingSkill
    sets.midcast.Temper.DW = set_combine(sets.midcast.Temper, { sub = "Pukulatmuj" })
    sets.midcast.Enspell = sets.midcast.Temper
    sets.midcast.Enspell.DW = set_combine(sets.midcast.Enspell, { sub = "Pukulatmuj" })
    sets.midcast.BoostStat = { hands = gear.af2_hands }
    sets.midcast.Stoneskin = {
        -- neck = "Nodens Gorget",
        -- ear2 = "Earthcry Earring",
        -- waist = "Siegel Sash",
        legs = "Shedir Seraweels"
    }
    sets.midcast.Protect = { --[[ring2 = "Sheltered Ring"]] }
    sets.midcast.Shell = { --[[ring2 = "Sheltered Ring"]] }

    sets.midcast['Enfeebling Magic'] = {
        main = "Crocea Mors",
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Hydrocera",
        -- ammo = "Regal Gem",
        head = gear.af2_head,
        neck = "Dls. Torque +2",
        ear1 = "Snotra Earring",
        -- ear1 = "Regal Earring",
        -- ear2 = "Snotra Earring",
        ear2 = gear.jse_ear2,
        body = gear.af3_body,
        hands = "Regal Cuffs",
        -- ring1 = "Kishar Ring",
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.nuke_jse_back,
        --waist = "Luminary Sash",
        --legs = "Chironic Hose",
        legs = gear.af1_legs,
        feet = gear.af2_feet
    }

    sets.midcast['Enfeebling Magic'].Resistant = {
        main = "Crocea Mors",
        sub = "Ammurapi Shield",
        range = "Ullr",
        ammo = empty,
        head = gear.af2_head,
        neck = "Dls. Torque +2",
        ear1 = "Snotra Earring",
        -- ear1 = "Regal Earring",
        -- ear2 = "Snotra Earring",
        ear2 = gear.jse_ear2,
        body = gear.af1_body,
        hands = gear.af1_hands,
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.nuke_jse_back,
        -- waist = "Luminary Sash",
        -- legs = "Chironic Hose",
        legs = gear.af1_legs,
        feet = gear.af2_feet
    }

    sets.midcast.DurationOnlyEnfeebling = set_combine(sets.midcast['Enfeebling Magic'],
        { body = gear.af1_body, range = "Ullr" })

    sets.midcast.Silence = sets.midcast.DurationOnlyEnfeebling
    sets.midcast.Silence.Resistant = sets.midcast['Enfeebling Magic'].Resistant
    sets.midcast.Sleep = set_combine(sets.midcast.DurationOnlyEnfeebling, { waist = "Acuity Belt +1" })
    sets.midcast.Sleep.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, { waist = "Acuity Belt +1" })
    sets.midcast.Bind = set_combine(sets.midcast.DurationOnlyEnfeebling, { waist = "Acuity Belt +1" })
    sets.midcast.Bind.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, { waist = "Acuity Belt +1" })
    sets.midcast.Break = set_combine(sets.midcast.DurationOnlyEnfeebling, { waist = "Acuity Belt +1" })
    sets.midcast.Break.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, { waist = "Acuity Belt +1" })

    sets.midcast.Dispel = sets.midcast['Enfeebling Magic'].Resistant

    sets.midcast.SkillBasedEnfeebling = set_combine(sets.midcast['Enfeebling Magic'],
        { --[[ear1 = "Vor Earring",]] hands = gear.af3_hands, ring1 = "Stikini Ring +1", --[[legs = "Psycloth Lappas"]] })

    sets.midcast['Frazzle II'] = sets.midcast['Enfeebling Magic'].Resistant
    sets.midcast['Frazzle III'] = sets.midcast.SkillBasedEnfeebling
    sets.midcast['Frazzle III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant

    sets.midcast['Distract III'] = sets.midcast.SkillBasedEnfeebling
    sets.midcast['Distract III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant

    sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Bio III'] = set_combine(sets.midcast['Enfeebling Magic'],
        { head = gear.af2_head, --[[waist = "Chaac Belt", feet = gear.chironic_treasure_feet]] })

    sets.midcast['Elemental Magic'] = {
        main = gear.bunzi_rod,
        sub = "Ammurapi Shield",
        range = empty,
        ammo = "Ghastly Tathlum +1",
        head = gear.af3_head,
        neck = gear.jse_neck,
        --neck = "Sibyl Scarf",
        --ear1 = "Regal Earring",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        -- body = gear.af3_body
        body = "Amalric Doublet +1",
        -- hands = gear.af3_hands
        hands = gear.af3_hands,
        ring1 = "Shiva Ring +1",
        ring2 = "Shiva Ring +1",
        -- ring2 = "Freke Ring",
        back = gear.nuke_jse_back,
        -- waist = "Acuity Belt +1",
        waist = gear.ElementalObi,
        -- legs = gear.af3_legs
        legs = "Amalric Slops +1",
        -- legs = gear.af1_feet (When Regal Earring)
        feet = "Amalric Nails +1"
    }

    sets.midcast['Elemental Magic'].Resistant = sets.midcast['Elemental Magic']
    sets.midcast['Elemental Magic'].Fodder = sets.midcast['Elemental Magic']
    sets.midcast['Elemental Magic'].Proc = sets.midcast['Elemental Magic']

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'],
        { ammo = "Pemphredo Tathlum", ear1 = "Regal Earring", ring1 = "Metamor. Ring +1" })
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant,
        { ear1 = "Regal Earring", ring1 = "Metamor. Ring +1" })
    sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder,
        { ammo = "Pemphredo Tathlum", ear1 = "Regal Earring", ring1 = "Metamor. Ring +1" })

    sets.midcast.Impact = {
        range = "Ullr",
        ammo = empty,
        head = empty,
        neck = "Null Loop",
        ear1 = "Malignance Earring",
        -- ear1 = "Regal Earring",
        -- ear2 = "Malignance Earring",
        ear2 = gear.jse_ear2,
        body = "Twilight Cloak",
        hands = gear.af1_hands,
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.af1_legs,
        feet = gear.af1_feet
    }

    sets.midcast['Dark Magic'] = {
        range = "Ullr",
        ammo = empty,
        neck = "Erra Pendant",
        ear1 = "Malignance Earring",
        -- ear1 = "Regal Earring",
        -- ear2 = "Malignance Earring",
        ear2 = gear.jse_ear2,
        body = gear.af1_body,
        hands = gear.af1_hands,
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Null Shawl",
        legs = gear.af1_legs,
        feet = gear.af1_feet
        -- waist = "Luminary Sash",
        -- legs = "Psycloth Lappas",
        -- feet = gear.merlinic_nuke_feet
    }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head = "Pixie Hairpin +1",
        neck = "Erra Pendant",
        ring1 = "Evanescence Ring",
        -- ring2 = "Archon Ring",
        -- waist = "Fucho-no-obi",
        -- legs = "Chironic Hose",
    })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {
        main = "Crocea Mors",
        sub = "Ammurapi Shield",
        range = "Ullr",
        ammo = empty,
    }

    sets.midcast.Stun.Resistant = sets.midcast.Stun

    -- Sets for special buff conditions on spells.

    sets.buff.Saboteur = { hands = gear.af3_hands }

    sets.HPDown = {
        head = "Pixie Hairpin +1",
        ear1 = "Mendicant's Earring",
        ear2 = "Evans Earring",
        body = "Jhakri Robe +2",
        hands = "Jhakri Cuffs +2",
        ring1 = "Mephitas's Ring +1",
        ring2 = "Mephitas's Ring",
        back = "Swith Cape +1",
        legs = "Shedir Seraweels",
        feet = "Jhakri Pigaches +2"
    }

    sets.HPCure = {
        main = "Daybreak",
        sub = "Sors Shield",
        range = empty,
        ammo = "Hasty Pinion +1",
        head = "Gende. Caubeen +1",
        neck = "Unmoving Collar +1",
        ear1 = "Gifted Earring",
        ear2 = "Mendi. Earring",
        body = gear.af2_body,
        hands = "Kaykaus Cuffs",
        ring1 = "Gelatinous Ring +1",
        ring2 = "Meridian Ring",
        back = "Moonlight Cape",
        waist = "Luminary Sash",
        legs = "Carmine Cuisses +1",
        feet = "Kaykaus Boots"
    }

    sets.buff.Doom = set_combine(sets.buff.Doom, {})

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {
        main = "Chatoyant Staff",
        sub = "Oneiros Grip",
        range = empty,
        ammo = "Impatiens",
        head = gear.af2_head,
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Jhakri Robe +2",
        hands = gear.merlinic_refresh_hands,
        ring1 = "Defending Ring",
        ring2 = "Sheltered Ring",
        back = "Umbra Cape",
        waist = "Flume Belt +1",
        legs = "Lengo Pants",
        feet = gear.chironic_refresh_feet
    }


    -- Idle sets
    sets.idle = {
        main = gear.sakpata_sword,
        sub = "Ammurapi Shield",
        -- sub = "Sacro Bulwark",
        range = empty,
        ammo = "Staunch Tathlum +1",
        -- head = gear.sworn_head
        head = gear.af2_head,
        neck = "Null Loop",
        -- neck = "Loricate Torque +1",
        ear1 = gear.limbus_ear1,
        -- ear2 = "Odnowa Earring +1", PREFERRED
        -- ear2 = "Etiolation Earring",
        body = gear.af3_body,
        hands = "Malignance Gloves",
        -- hands = gear.sworn_hands,
        ring1 = gear.limbus_ring1,
        ring2 = "Stikini Ring +1",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = "Malignance Tights",
        --legs = gear.sworn_legs
        --feet = gear.sworn_feet
        feet = "Malignance Boots"
    }

    sets.idle.PDT = sets.idle

    sets.idle.MDT = sets.idle

    sets.idle.Weak = sets.idle

    sets.idle.DTHippo = sets.idle

    -- Defense sets
    sets.defense.PDT = sets.idle

    sets.defense.NukeLock = sets.midcast['Elemental Magic']

    sets.defense.MDT = sets.idle

    sets.defense.MEVA = sets.idle

    sets.Kiting = { legs = "Carmine Cuisses +1" }
    sets.latent_refresh = {}
    sets.latent_refresh_grip = {}
    sets.TPEat = {}
    sets.DayIdle = {}
    sets.NightIdle = {}

    -- Weapons sets
    sets.weapons.Crocea = {
        main = "Crocea Mors",
        sub = "Ammurapi Shield"
        --sub="Sacro Bulwark",
    }
    sets.weapons.DualCrocea = { main = "Crocea Mors", sub = "Daybreak" }
    sets.weapons.DualNaegling = { main = "Naegling", sub = "Thibron" }
    sets.weapons.DualNaeglingAcc = { main = "Naegling", sub = "Flametongue" }
    sets.weapons.DualAeolian = { main = "Tauret", sub = "Daybreak" }
    sets.weapons.DualEnspellOnly = { main = "Ethereal Dagger", sub = "Qutrub Knife", range = "Ullr", ammo = empty } -- TODO
    sets.weapons.DualBlackHalo = { main = "Maxentius", sub = "Thibron" }
    sets.weapons.DualBow = { main = "Naegling", sub = "Tauret", range = "Ullr" }
    sets.weapons.BowMacc = { range = "Ullr", ammo = empty }

    sets.buff.Sublimation = { waist = "Embla Sash" }
    sets.buff.DTSublimation = { waist = "Embla Sash" }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.Dagger.Accuracy.Evasion

    -- Normal melee group
    --	sets.engaged = {ammo="Aurgelmir Orb +1",
    --		head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
    --		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",ring2="Ilabrat Ring",
    --		back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}

    sets.engaged = {
        ammo = "Aurgelmir Orb +1",
        -- head = gear.bunzi_head
        head = "Malignance Chapeau",
        -- neck = "Anu Torque",
        neck = "Null Loop",
        ear1 = gear.limbus_ear1,
        ear2 = "Sherida Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Chirich Ring+1",
        ring2 = "Chirich Ring+1",
        back = "Null Shawl",
        waist = "Windbuffet Belt +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.EnspellOnly = {
        ammo = gear.gog_ammo,
        -- head = gear.bunzi_head
        head = "Malignance Chapeau",
        -- neck = "Anu Torque",
        neck = "Null Loop",
        ear1 = "Eabani Earring",
        ear2 = "Sherida Earring",
        body = "Malignance Tabard",
        hands = "Aya. Manopolas +2",
        ring1 = "Chirich Ring+1",
        ring2 = "Chirich Ring+1",
        back = "Null Shawl",
        waist = "Orpheus's Sash",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.Acc = sets.engaged

    sets.engaged.FullAcc = sets.engaged

    sets.engaged.DT = sets.engaged

    sets.engaged.Acc.DT = sets.engaged

    sets.engaged.FullAcc.DT = sets.engaged

    sets.engaged.DW = {
        ammo = "Aurgelmir Orb +1",
        -- head = gear.bunzi_head
        head = "Malignance Chapeau",
        -- neck = "Anu Torque",
        neck = "Null Loop",
        ear1 = "Eabani Earring",
        ear2 = "Sherida Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Chirich Ring+1",
        ring2 = "Chirich Ring+1",
        back = "Null Shawl",
        waist = "Reiki Yotai",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.DW.Acc = sets.engaged.DW

    sets.engaged.DW.FullAcc = sets.engaged.DW

    sets.engaged.DW.DT = sets.engaged.DW

    sets.engaged.DW.Acc.DT = sets.engaged.DW

    sets.engaged.DW.FullAcc.DT = sets.engaged.DW
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
    if player.sub_job == 'DNC' then
        set_macro_page(8, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(7, 4)
    elseif player.sub_job == 'BLM' then
        set_macro_page(6, 4)
    else
        set_macro_page(5, 4)
    end
end

--Job Specific Trust Overwrite
function check_trust()
    if not moving then
        if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
            local party = windower.ffxi.get_party()
            if party.p5 == nil then
                local spell_recasts = windower.ffxi.get_spell_recasts()

                if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
                    windower.chat.input('/ma "Yoran-Oran (UC)" <me>')
                    tickdelay = os.clock() + 3
                    return true
                elseif spell_recasts[984] < spell_latency and not have_trust("August") then
                    windower.chat.input('/ma "August" <me>')
                    tickdelay = os.clock() + 3
                    return true
                elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
                    windower.chat.input('/ma "Qultada" <me>')
                    tickdelay = os.clock() + 3
                    return true
                elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
                    windower.chat.input('/ma "Ulmia" <me>')
                    tickdelay = os.clock() + 3
                    return true
                elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
                    windower.chat.input('/ma "Selh\'teus" <me>')
                    tickdelay = os.clock() + 3
                    return true
                else
                    return false
                end
            end
        end
    end
    return false
end

function user_job_buff_change(buff, gain)
    if buff:startswith('Addendum: ') or buff:endswith(' Arts') then
        style_lock = true
    end
end

function user_job_lockstyle()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.main == nil or player.equipment.main == 'empty' then
            windower.chat.input('/lockstyleset 079')
        elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then     --Sword in main hand.
            if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then      --Sword/Sword.
                windower.chat.input('/lockstyleset 079')
            elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then  --Sword/Dagger.
                windower.chat.input('/lockstyleset 079')
            elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Sword/Club.
                windower.chat.input('/lockstyleset 079')
            else
                windower.chat.input('/lockstyleset 079')                             --Catchall
            end
        elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then     --Dagger in main hand.
            if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then      --Dagger/Sword.
                windower.chat.input('/lockstyleset 079')
            elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then  --Dagger/Dagger.
                windower.chat.input('/lockstyleset 079')
            elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Dagger/Club.
                windower.chat.input('/lockstyleset 079')
            else
                windower.chat.input('/lockstyleset 079')                             --Catchall
            end
        elseif res.items[item_name_to_id(player.equipment.main)].skill == 11 then    --Club in main hand.
            if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then      --Club/Sword.
                windower.chat.input('/lockstyleset 079')
            elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then  --Club/Dagger.
                windower.chat.input('/lockstyleset 079')
            elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Club/Club.
                windower.chat.input('/lockstyleset 079')
            else
                windower.chat.input('/lockstyleset 079') --Catchall
            end
        end
    elseif player.sub_job == 'WHM' or state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
        windower.chat.input('/lockstyleset 079')
    elseif player.sub_job == 'BLM' or state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
        windower.chat.input('/lockstyleset 079')
    else
        windower.chat.input('/lockstyleset 079')
    end
end
