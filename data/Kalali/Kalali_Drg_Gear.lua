-- Starter sets rebuilt from OWNEDGEAR.md; job/slot flags and base stats verified
-- against Windower/Resources resources_data/items.lua and item_descriptions.lua.
-- Only recorded augments are selected. Empty JSE aliases are acquisition hooks.
function character_user_job_setup()
    state.OffenseMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.WeaponskillMode:options('Match', 'Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder', 'Proc')
    state.HybridMode:options('Normal', 'PDT', 'MDT')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
    state.Weapons:options('None', 'ShiningOne', 'Naegling')
    state.WeaponSets:options('Default')
    weapon_sets = { Default = { 'None', 'ShiningOne', 'Naegling' } }
    default_weapons = 'ShiningOne'
    autows_list = { ShiningOne = 'Impulse Drive', Naegling = 'Savage Blade' }
    autows = 'Impulse Drive'
    state.ExtraMeleeMode = M { ['description'] = 'Extra Melee Mode', 'None' }
    state.Passive = M { ['description'] = 'Passive Mode', 'None', 'MP' }

    -- Missing JSE: fill these only with the actual owned job piece.
    gear.af1_head = '' -- Vishap Armet: Spirit Link and healing-breath trigger.
    gear.af1_legs = '' -- Vishap Brais: Ancient Circle.
    gear.af1_feet = '' -- Vishap Greaves: Jump.
    gear.af2_head = '' -- Pteroslaver Armet: Deep Breathing / breath potency.
    gear.af2_body = '' -- Pteroslaver Mail: Call Wyvern / Spirit Surge.
    gear.af2_hands = '' -- Pteroslaver Finger Gauntlets: Angon.
    gear.af3_head = '' -- Peltast's Mezail: wyvern breath.
    gear.af3_body = '' -- Peltast's Plackart: Spirit Jump.
    gear.af3_hands = '' -- Peltast's Vambraces: Spirit Link.
    gear.af3_feet = '' -- Peltast's Schynbalds: Soul Jump.
    gear.jse_back = '' -- Brigantia's Mantle: wyvern HP / breath potency.
    -- Trishula is a future weapon; it is not in OWNEDGEAR.

    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f7 gs c toggle AutoJumpMode')
    send_command('bind @` gs c cycle SkillchainMode')
    select_default_macro_book()
end

function init_gear_sets()
    sets.weapons.None = {}
    -- Nyame is user-confirmed Path B, rank 20.
    -- Use the owned pieces without claiming fully ranked bonuses.
    sets.idle = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Alabaster Earring",
        ear2 = "Sanare Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
        back = "Moonlight Cape",
        waist = "Null Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }
    sets.idle.PDT = set_combine(sets.idle, { ring1 = "Murky Ring", ring2 = "Moonlight Ring" })
    sets.idle.Refresh = set_combine(sets.idle, {
        ring1 = { name = "Stikini Ring +1", bag = "Wardrobe" },
        ring2 = { name = "Stikini Ring +1", bag = "Wardrobe 2" }
    })
    sets.idle.Weak = set_combine(sets.idle.PDT, {})
    sets.resting = set_combine(sets.idle.Refresh, {})
    sets.defense.PDT = set_combine(sets.idle.PDT, {})
    sets.defense.MDT = set_combine(sets.idle.PDT, { neck = "Warder's Charm +1" })
    sets.defense.MEVA = set_combine(sets.defense.MDT, { back = "Null Shawl" })
    sets.Kiting = { ring2 = "Shneddick Ring" }
    -- Twilight Helm/Mail and Frenzy Sallet are not owned: no automatic swaps.
    sets.Reraise = {}
    sets.buff.Sleep = {}
    sets.buff.Doom = { neck = "Nicander's Necklace", ring1 = "Purity Ring", waist = "Gishdubar Sash" }
    -- Perfect Lucky Egg cannot be equipped by these jobs.
    sets.TreasureHunter = { head = "Wh. Rarab Cap +1", ring1 = "Hoxne Ring", waist = "Chaac Belt" }
    sets.Self_Healing = { waist = "Gishdubar Sash" }
    sets.Cure_Received = { waist = "Gishdubar Sash" }
    sets.Self_Refresh = { waist = "Gishdubar Sash" }

    -- Casting gear: retain defensive armor where no owned Fast Cast piece exists.
    sets.precast.FC = set_combine(sets.idle.PDT, {
        ammo = "Impatiens",
        neck = "Voltsurge Torque",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Loquac. Earring",
        ring1 = "Lebeche Ring",
        ring2 = "Prolix Ring"
    })
    sets.midcast.FastRecast = set_combine(sets.precast.FC, { ammo = "Staunch Tathlum +1" })
    sets.midcast.Cure = set_combine(sets.idle.PDT, {
        ear1 = "Mendi. Earring",
        ear2 = "Enchntr. Earring +1",
        ring1 = "Menelaus's Ring",
        ring2 = "Lebeche Ring"
    })
    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
    sets.precast.Waltz = set_combine(sets.idle.PDT, {
        neck = "Unmoving Collar +1",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Tuisto Earring",
        legs = "Dashing Subligar"
    })
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Default physical WS foundation; specific multihit / critical sets follow.
    sets.precast.WS = {
        ammo = "Knobkierrie",
        head = "Nyame Helm",
        neck = "Rep. Plat. Medal",
        ear1 = "Moonshade Earring",
        ear2 = "Thrud Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Epaminondas's Ring",
        ring2 = "Ephramad's Ring",
        back = "Null Shawl",
        waist = "Sailfi Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, { neck = "Null Loop" })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS.Acc, { ear2 = "Telos Earring" })
    sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})
    sets.precast.WS.Proc = set_combine(sets.idle.PDT, {})
    sets.MaxTP = { ear1 = "Ishvara Earring" }
    sets.AccMaxTP = { ear1 = "Cessance Earring" }
    -- Weapons: Shining One supplies Impulse Drive even before the quest WS is learned.
    sets.weapons.ShiningOne = { main = "Shining One", sub = "Utu Grip" }
    sets.weapons.Naegling = { main = "Naegling", sub = "Regis" }
    sets.passive.MP = { ear2 = "Ethereal Earring", waist = "Flume Belt +1" }

    sets.precast.FC = set_combine(sets.precast.FC, { head = { name = "Carmine Mask +1", augments = { 'Path:D' } } })
    sets.midcast.FastRecast = set_combine(sets.precast.FC, { ammo = "Staunch Tathlum +1" })
    -- HP increases help the trigger. The empty AF alias does not claim an enhanced threshold.
    sets.midcast.HB_Trigger = set_combine(sets.midcast.FastRecast, {
        head = gear.af1_head ~= '' and gear.af1_head or nil,
        body = "Adamantite Armor",
        ear1 = "Alabaster Earring",
        ear2 = "Tuisto Earring",
        ring1 = { name = "Moonlight Ring", bag = "Wardrobe" },
        ring2 = { name = "Moonlight Ring", bag = "Wardrobe 2" },
        back = "Moonlight Cape",
        waist = "Plat. Mog. Belt"
    })
    sets.Self_Healing.legs = "Flamma Dirs +2"
    sets.Cure_Received.legs = "Flamma Dirs +2"

    -- Offensive starter TP set: full Flamma +2, with 25% DT from accessories.
    -- Alabaster fills the armor-haste gap; Nyame is reserved for PDT/MDT variants.
    sets.engaged = {
        ammo = "Aurgelmir Orb +1",
        head = "Flam. Zucchetto +2",
        neck = "Null Loop",
        ear1 = "Alabaster Earring",
        ear2 = "Sherida Earring",
        body = "Flamma Korazin +2",
        hands = "Flam. Manopolas +2",
        ring1 = "Murky Ring",
        ring2 = "Moonlight Ring",
        back = "Null Shawl",
        waist = "Ioskeha Belt +1",
        legs = "Flamma Dirs +2",
        feet = "Flam. Gambieras +2"
    }
    sets.engaged.SomeAcc = set_combine(sets.engaged, {})
    sets.engaged.Acc = set_combine(sets.engaged, { ear2 = "Telos Earring" })
    sets.engaged.FullAcc = set_combine(sets.engaged.Acc, { ammo = "Staunch Tathlum +1" })
    -- Explicit offensive option: Flamma Store TP / multiattack with Gleti critical rate.
    sets.engaged.Fodder = set_combine(sets.engaged, {
        body = "Gleti's Cuirass",
        hands = "Flam. Manopolas +2",
        legs = "Flamma Dirs +2",
        ring1 = "Niqmaddu Ring",
        ring2 = "Ephramad's Ring"
    })

    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, { ring2 = "Niqmaddu Ring" })
    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
        head = "Flam. Zucchetto +2",
        neck = "Fotia Gorget",
        ear2 = "Sherida Earring",
        body = "Flamma Korazin +2",
        hands = "Flam. Manopolas +2",
        ring1 = "Niqmaddu Ring",
        legs = "Flamma Dirs +2",
        feet = "Flam. Gambieras +2",
        waist = "Fotia Belt"
    })
    sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS['Stardiver'], {
        body = "Gleti's Cuirass",
        legs = "Gleti's Breeches"
    })
    sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS['Impulse Drive'], {})
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
    -- Stat-based Jump sets may use normal owned TP gear; JSE overlays remain empty.
    sets.precast.JA.Jump = set_combine(sets.engaged.Fodder, { ear1 = "Telos Earring" })
    sets.precast.JA.Jump = set_combine(sets.precast.JA.Jump, { feet = gear.af1_feet ~= '' and gear.af1_feet or nil })
    sets.precast.JA['High Jump'] = set_combine(sets.engaged.Fodder, { ear1 = "Telos Earring" })
    sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA['High Jump'], { body = gear.af3_body ~= '' and gear.af3_body or nil })
    sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA['High Jump'], { feet = gear.af3_feet ~= '' and gear.af3_feet or nil })
    sets.precast.JA['Super Jump'] = {}
    -- Angon consumables are not in OWNEDGEAR. Add ammo="Angon" after obtaining them.
    sets.precast.JA.Angon = { hands = gear.af2_hands }
    sets.precast.JA['Ancient Circle'] = { legs = gear.af1_legs }
    sets.precast.JA['Spirit Link'] = { head = gear.af1_head, hands = gear.af3_hands, ear1 = "Pratik Earring" }
    sets.precast.JA['Call Wyvern'] = { body = gear.af2_body }
    sets.precast.JA['Deep Breathing'] = { head = gear.af2_head }
    sets.precast.JA['Spirit Surge'] = { body = gear.af2_body }
    sets.precast.JA['Steady Wing'] = { back = gear.jse_back }
    sets.precast.JA['Restoring Breath'] = { back = gear.jse_back }
    sets.precast.JA['Smiting Breath'] = { back = gear.jse_back }
    -- Healing-breath potency gear is missing. Gleti hands protect the wyvern.
    sets.HealingBreath = { head = gear.af3_head, hands = "Gleti's Gauntlets", back = gear.jse_back }
    sets.SmitingBreath = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Gleti's Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Adad Amulet",
        ear1 = "Alabaster Earring",
        ear2 = "Crep. Earring",
        ring1 = "Murky Ring",
        back = gear.jse_back,
        waist = "Incarnation Sash"
    }
    -- Match each offense mode to a complete defensive overlay.
    for _, mode in ipairs({ 'Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder' }) do
        local melee = mode == 'Normal' and sets.engaged or sets.engaged[mode]
        melee.PDT = set_combine(melee, {
            head = "Nyame Helm",
            body = "Nyame Mail",
            hands = "Nyame Gauntlets",
            legs = "Nyame Flanchard",
            feet = "Nyame Sollerets",
            ammo = "Staunch Tathlum +1",
            neck = "Null Loop",
            ear1 = "Alabaster Earring",
            ring1 = "Murky Ring",
            ring2 = "Moonlight Ring"
        })
        melee.MDT = set_combine(melee.PDT, { neck = "Warder's Charm +1", back = "Null Shawl" })
    end
    -- Build accuracy variants from each actual WS, preserving its damage-specific gear.
    for name, ws in pairs(sets.precast.WS) do
        if type(ws) == 'table' and ws.body and name ~= 'SomeAcc' and name ~= 'Acc'
            and name ~= 'FullAcc' and name ~= 'Fodder' and name ~= 'Proc' then
            local base = {}
            for _, slot in ipairs({ 'main', 'sub', 'range', 'ammo', 'head', 'body', 'hands', 'legs', 'feet', 'neck', 'waist', 'back', 'ear1', 'ear2', 'ring1', 'ring2' }) do
                base[slot] = ws[slot]
            end
            ws.SomeAcc = set_combine(base, { neck = "Null Loop" })
            ws.Acc = set_combine(ws.SomeAcc, {})
            ws.FullAcc = set_combine(ws.Acc, { ear2 = base.ear1 == "Telos Earring" and base.ear2 or "Telos Earring" })
            ws.Fodder = set_combine(base, {})
        end
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(5, 13)
    elseif player.sub_job == 'SAM' then
        set_macro_page(3, 13)
    elseif player.sub_job == 'BLU' then
        set_macro_page(2, 13)
    else
        set_macro_page(5, 13)
    end
end
