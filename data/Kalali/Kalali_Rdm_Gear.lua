function character_user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Normal','DT')
	state.WeaponskillMode:options('Match','Proc')
	state.CastingMode:options('Normal','Resistant','Proc','SIRD')
    state.IdleMode:options('Normal','PDT','MDT','MEVA','Aminon')
    state.PhysicalDefenseMode:options('PDT','NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.BuffWeaponsMode = M{'Always','Never'}
	state.AutoBuffMode = M{['description'] = 'Auto Buff Mode','Off','Auto','AutoMelee','AutoMage'}
	state.Weapons:options('None','Naegling','Maxentius','Crocea','Tauret','EnspellOnly','DualWeapons','DualWeaponsAcc','DualMaxentius','DualCrocea','DualMaxentiusAcc',--[['DualPrime']],'DualAeolian','DualEnspellOnly',--[['DualProcSword']])
	state.WeaponSets:options('Default','Dual'--[[,'Proc','Dynamis']])

	weapon_sets = {
		['Default'] = {'None','Naegling','Maxentius','Crocea','Tauret','EnspellOnly'},
		['Dual'] = {'DualWeapons','DualWeaponsAcc','DualMaxentius','DualCrocea','DualMaxentiusAcc',--[['DualPrime']],'DualAeolian','DualEnspellOnly'},
		--[[['Dynamis'] = {'DualCroceaSavageBlade','DualCrocea','DualTauretCrocea','DualAeolian'},
		['Proc'] = {'ProcSword','ProcDagger','DualProcSword','DualProcDagger'},]]
	}

	default_weapons = 'Crocea'
	default_dual_weapons = 'DualCrocea'

	autows_list =  {['Naegling']='Savage Blade',['Maxentius']='Black Halo',['Crocea']='Sanguine Blade',['Tauret']='Aeolian Edge',['DualWeapons']='Savage Blade',['DualWeaponsAcc']='Savage Blade',
					['DualMaxentius']='Black Halo',['DualMaxentiusAcc']='Black Halo',['DualEvisceration']='Evisceration',['DualCrocea']='Sanguine Blade',['DualClubs']='Black Halo',
					['DualAeolian']='Aeolian Edge',['DualPrime']='Exenterator',['DualCroceaSavageBlade']="Savage Blade",['CroceaDaybreak']="Seraph Blade",["DualTauretCrocea"]="Aeolian Edge"}
	trust_list = {"Joachim","Ulmia","Qultada","Sylvie (UC)","Monbreaux"}

	--gear.mnd_enfeebling_jse_back = {name="Sucellos's Cape",augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Haste+10','Damage taken-5%',}}
	--gear.int_enfeebling_jse_back = {name="Sucellos's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}}
	--gear.str_wsd_jse_back = {name="Sucellos's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
	--gear.physical_mnd_wsd_jse_back = {name="Sucellos's Cape",augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}}
	gear.magical_mnd_wsd_jse_back = {name="Sucellos's Cape",augments={ 'MND+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'MND+10', 'Weapon skill damage +10%' } }
	--gear.int_wsd_jse_back = {name="Sucellos's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Damage taken-5%',}}
	gear.nuke_jse_back = { name = "Sucellos's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', '"Mag.Atk.Bns."+10', 'Phys. dmg. taken-10%', } }       --TODO
	gear.dw_jse_back = { name = "Sucellos's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dual Wield"+10', 'Phys. dmg. taken-10%' } }
    gear.cure_jse_back = { name = "Sucellos's Cape", augments = { 'MND+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'MND+9', '"Fast Cast"+10', 'Phys. dmg. taken-10%', } } --TODO

    -- Unimplemented Ambuscade Capes with redirects to capes I do have
    gear.mnd_enfeebling_jse_back = gear.magical_mnd_wsd_jse_back
	gear.int_enfeebling_jse_back = gear.nuke_jse_back
	gear.int_wsd_jse_back = gear.nuke_jse_back
    gear.str_wsd_jse_back = gear.magical_mnd_wsd_jse_back
	gear.physical_mnd_wsd_jse_back = gear.magical_mnd_wsd_jse_back
    gear.str_wsd_jse_back = gear.mnd_wsd_jse_back

    -- JSE Weapon/Neck/Earring
    gear.jse_ear2 = "Leth. Earring +1"
    gear.jse_neck = "Dls. Torque +2"

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
    gear.af2_feet = "Viti. Boots +3" -- Need for Immunobreak macroing

    -- Empy Gear
    gear.af3_head = "Leth. Chappel +2"
    gear.af3_body = "Lethargy Sayon +2"
    gear.af3_hands = "Leth. Gantherots +2"
    gear.af3_legs = "Leth. Fuseau +2"
    gear.af3_feet = "Leth. Houseaux +2"

    -- List of gear I want, could be BiS. When I get the item, can replace it here
    -- main
        gear.sacro_bulwark = "Ammurapi Shield" -- sub = "Sacro Bulwark"
        gear.forfend = "Ammurapi Shield" -- sub = "Forfend +1"
        -- sub = "Diamond Aspis"
        gear.culminus = "Ammurapi Shield" -- sub = "Culminus"
    -- range
    -- ammo
        gear.regal_gem = "Staunch Tathlum+1" --ammo = "Regal Gem"
        gear.impatiens = "Staunch Tathlum+1" --ammo = "Impatiens"
    -- head
    -- neck
        gear.loricate_torque = "" -- neck = "Loricate Torque +1"
        gear.fotia_gorget = ""-- neck = "Fotia Gorget"
        gear.baetyl_pendant = "" -- neck = "Baetyl Pendant"
        gear.sibyl_scarf = "" -- neck = "Sibyl Scarf"
    -- ear
        -- gear.regal_earring = "" -- ear1 = "Regal Earring"
        gear.zennaroi_ear = "" -- ear1="Zennaroi Earring"
    -- body
        gear.crepuscular_cloak = "" -- body = "Crepuscular Cloak"
    -- hands
    -- ring
        gear.cacoethic_ring = "" -- ring1="Cacoethic Ring +1"
        gear.kishar_ring = "" -- ring1 = "Kishar Ring"
        gear.freke_ring = "" -- ring1 = "Freke Ring"
        gear.lebeche_ring = "" -- ring2 = "Lebeche Ring"
        gear.metamorphic_ring = "" -- ring2 = "Metamorphic Ring +1"
        -- gear.archon_ring = "" -- ring2 = "Archon Ring"
    -- back
        gear.perimede_cape = "" -- back = "Perimede Cape"
    -- waist
        gear.fotia_belt = "" -- waist = "Fotia Belt"
        gear.witful_belt = "" -- waist = "Witful Belt"
    -- legs
    -- feet


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
	sets.weapons.Naegling = {main="Naegling",sub="Ammurapi Shield",range=empty}
	sets.weapons.Crocea = {main="Crocea Mors",sub="Ammurapi Shield",range=empty}
	sets.weapons.Maxentius = {main="Maxentius",sub="Ammurapi Shield",range=empty}
	sets.weapons.Tauret = {main="Tauret",sub="Ammurapi Shield",range=empty}
	sets.weapons.DualWeapons = {main="Naegling",sub=gear.tp_sword,range=empty}
	sets.weapons.DualWeaponsAcc = {main="Naegling",sub="Gleti's Knife",range=empty}
	--sets.weapons.DualPrime = {main="Mpu Gandring",sub="Gleti's Knife",range=empty}
	--sets.weapons.DualEvisceration = {}
	sets.weapons.DualCrocea = {main="Crocea Mors",sub="Daybreak",range=empty}
	sets.weapons.DualAeolian = {main="Tauret",sub="Maxentius",range=empty}
	--sets.weapons.DualProcSword = {main="Demers. Degen +1",sub="Blurred Knife +1",range=empty}
	--sets.weapons.ProcSword = {main="Demers. Degen +1",sub="Ammurapi Shield",range=empty}
	--sets.weapons.ProcDagger = {main="Blurred Knife +1",sub="Ammurapi Shield",range=empty}
	--sets.weapons.DualProcDagger = {main="Blurred Knife +1",sub="Demers. Degen +1",range=empty}
	sets.weapons.EnspellOnly = {main="Qutrub Knife",sub=gear.sacro_bulwark}
	sets.weapons.DualEnspellOnly = {main="Qutrub Knife",sub="Ethereal Dagger"}
	--sets.weapons.DualBow = {}
	--sets.weapons.BowMacc = {}
	sets.weapons.DualMaxentius = {main="Maxentius",sub=gear.tp_sword,range=empty}
	sets.weapons.DualMaxentiusAcc = {main="Maxentius",sub="Gleti's Knife",range=empty}

	--Temporary Weapon Sets for Dynamis RP
	--sets.weapons.DualCroceaSavageBlade = {main="Crocea Mors",sub=gear.tp_sword}
	--sets.weapons.DualTauretCrocea = {main="Tauret",sub="Crocea Mors"}

	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = { body = gear.af2_body }

	-- Steps (Pure Acc)
    sets.precast.Step = {ammo="Hasty Pinion +1",
		head="Malignance Chapeau",neck="Null Loop",ear1=gear.zennaroi_ear,ear2="Crepuscular Earring", -- < LEFT OFF
		body="Malignance Tabard",hands="Malignance Gloves",ring1=gear.cacoethic_ring,ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	-- Violent Flourish (Macc & Acc)
    sets.precast.JA['Violent Flourish'] = {ammo=gear.regal_gem,--Or range="Ullr" but swapping to this makes you lose TP.
		head=gear.af3_head,neck="Null Loop",ear1="Malignance Earring",ear2="Crepuscular Earring",
		body="Malignance Tabard",hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.af3_legs,feet=gear.af3_feet}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {main="Sakpata's Sword",sub=gear.sacro_bulwark,ammo=gear.impatiens,
		head=gear.af1_head,neck=gear.loricate_torque,ear1="Malignance Earring",ear2=gear.jse_ear2,
		body=gear.af2_body,hands="Nyame Gauntlets",ring1="Murky Ring",ring2=gear.lebeche_ring,
		back=gear.perimede_cape,waist=gear.witful_belt,legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.precast.FC.DT = {main="Sakpata's Sword",sub=gear.sacro_bulwark,ammo=gear.impatiens,
		head=gear.af1_head,neck=gear.loricate_torque,ear1="Malignance Earring",ear2=gear.jse_ear2,
		body=gear.af2_body,hands="Nyame Gauntlets",ring1="Murky Ring",ring2=gear.lebeche_ring,
		back=gear.perimede_cape,waist=gear.witful_belt,legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.precast.FullFC = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo=gear.impatiens,
		head=gear.af1_head,neck="Orunmila's Torque",ear1="Malignance Earring",ear2=gear.jse_ear2,
		body=gear.af2_body,hands="Gende. Gages +1",ring1=gear.kishar_ring,ring2=gear.lebeche_ring,
		back=gear.perimede_cape,waist=gear.witful_belt,legs="Aya. Cosciales +2",feet=gear.merlinic_fc_feet}

	sets.precast.FC.Impact = set_combine(sets.precast.FullFC, {head=empty,body=gear.crepuscular_cloak})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub=gear.sacro_bulwark})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {range=empty,ammo="Oshasha's Treatise",
		head=gear.af2_head,neck=gear.fotia_gorget,ear1="Sherida Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Jhakri Cuffs +2",ring1="Sroda Ring",ring2="Cornelia's Ring",
		back=gear.str_wsd_jse_back,waist=gear.fotia_belt,legs="Nyame Flanchard",feet=gear.af3_feet}

	sets.precast.WS.Proc = 	{ammo="Hasty Pinion +1",
		head="Malignance Chapeau",neck="Null Loop",ear1=gear.zennaroi_ear,ear2="Crepuscular Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1=gear.cacoethic_ring,ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = {range=empty,ammo=gear.regal_gem,
		head=gear.af2_head,neck=gear.fotia_gorget,ear1="Sherida Earring",ear2="Moonshade Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
		back=gear.physical_mnd_wsd_jse_back,waist=gear.fotia_belt,legs=gear.af3_legs,feet=gear.af3_feet}

	sets.precast.WS['Chant Du Cygne'] = {range=empty,ammo="Coiste Bodhar",
		head="Nyame Helm",neck=gear.fotia_gorget,ear1="Sherida Earring",ear2="Brutal Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Epaminondas's Ring",ring2="Cornelia's Ring",
		back=gear.str_wsd_jse_back,waist=gear.fotia_belt,legs="Nyame Flanchard",feet=gear.af3_feet}

	sets.precast.WS['Evisceration'] = sets.precast.WS['Chant Du Cygne']

	sets.precast.WS['Savage Blade'] = {range=empty,ammo="Oshasha's Treatise",
		head=gear.af2_head,neck="Rep. Plat. Medal",ear1="Sherida Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Jhakri Cuffs +2",ring1="Sroda Ring",ring2="Cornelia's Ring",
		back=gear.str_wsd_jse_back,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet=gear.af3_feet}

	sets.precast.WS['Black Halo'] = {range=empty,ammo="Oshasha's Treatise",
		head=gear.af2_head,neck="Rep. Plat. Medal",ear1="Sherida Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Jhakri Cuffs +2",ring1="Sroda Ring",ring2="Cornelia's Ring",
		back=gear.physical_mnd_wsd_jse_back,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet=gear.af3_feet}

	sets.precast.WS['Sanguine Blade'] = {range=empty,ammo="Sroda Tathlum",
		head=gear.af3_head,neck=gear.baetyl_pendant,ear1="Malignance Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands=gear.af3_hands,ring1="Epaminondas's Ring",ring2="Cornelia's Ring",
		back=gear.magical_mnd_wsd_jse_back,waist="Orpheus's Sash",legs="Nyame Flanchard",feet=gear.af3_feet}

	sets.precast.WS['Seraph Blade'] = {range=empty,ammo="Sroda Tathlum",
		head=gear.af3_head,neck=gear.baetyl_pendant,ear1="Malignance Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands=gear.af3_hands,ring1="Epaminondas's Ring",ring2="Cornelia's Ring",
		back=gear.magical_mnd_wsd_jse_back,waist="Orpheus's Sash",legs="Nyame Flanchard",feet=gear.af3_feet}

	sets.precast.WS['Shining Strike'] = sets.precast.WS['Seraph Blade']
	sets.precast.WS['Flash Nova'] = sets.precast.WS['Seraph Blade']

	sets.precast.WS['Aeolian Edge'] = {range=empty,ammo="Sroda Tathlum",
		head=gear.af3_head,neck=gear.fotia_gorget,ear1="Malignance Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands="Jhakri Cuffs +2",ring1=gear.freke_ring,ring2="Cornelia's Ring",
		back=gear.int_wsd_jse_back,waist="Orpheus's Sash",legs="Nyame Flanchard",feet=gear.af3_feet}

	sets.precast.WS['Red Lotus Blade'] = sets.precast.WS['Aeolian Edge']

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear2="Brutal Earring"}
	sets.AccMaxTP = {ear2="Telos Earring"}
	sets.MagicalMaxTP = {ear2="Friomisi Earring"}

	-- Midcast Sets

	-- Gear that converts elemental damage done to recover MP.
	sets.midcast.FastRecast = {main="Sakpata's Sword",sub=gear.sacro_bulwark,ammo="Staunch Tathlum +1",
		head=gear.af1_head,neck=gear.loricate_torque,ear1="Malignance Earring",ear2=gear.jse_ear2,
		body=gear.af2_body,hands="Bunzi's Gloves",ring1="Murky Ring",ring2=gear.freke_ring,
		back=gear.mnd_enfeebling_jse_back,waist="Emphatikos Rope",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

	sets.midcast.Cure = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
        head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
        body="Bunzi's Robe",hands="Gende. Gages +1",ring1="Sirona's Ring",ring2="Menelaus's Ring",
        back=gear.mnd_enfeebling_jse_back,waist="Luminary Sash",legs=gear.af1_legs,feet="Vanya Clogs"}

    sets.midcast.LightWeatherCure = {main="Chatoyant Staff",sub="Curatio Grip",range=empty,ammo=gear.regal_gem,
        head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
        body="Bunzi's Robe",hands="Gende. Gages +1",ring1="Sirona's Ring",ring2="Menelaus's Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs=gear.af1_legs,feet="Vanya Clogs"}

		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
        head="Vanya Hood",neck="Incanter's Torque",ear1="Meili Earring",ear2="Mendi. Earring",
        body="Bunzi's Robe",hands="Gende. Gages +1",ring1="Sirona's Ring",ring2="Menelaus's Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs=gear.af1_legs,feet="Vanya Clogs"}

    sets.midcast.Cure.DT = {main="Daybreak",sub=gear.culminus,range=empty,ammo="Staunch Tathlum +1",
        head=gear.af3_head,neck=gear.loricate_torque,ear1="Halasz Earring",ear2="Mendi. Earring",
        body="Bunzi's Robe",hands=gear.chironic_nuke_hands,ring1="Murky Ring",ring2=gear.freke_ring,
        back=gear.mnd_enfeebling_jse_back,waist="Emphatikos Rope",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

	sets.midcast.Cursna = {main=gear.grioavolr_fc_staff,sub="Curatio Grip",range=empty,ammo="Hasty Pinion +1",
        head="Vanya Hood",neck="Debilis Medallion",ear1="Meili Earring",ear2=gear.jse_ear2,
        body=gear.af2_body,hands="Hieros Mittens",ring1="Haoma's Ring",ring2="Menelaus's Ring",
        back="Oretan. Cape +1",waist="Bishop's Sash",legs=gear.af1_legs,feet="Vanya Clogs"}

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	sets.midcast['Enhancing Magic'] = {main="Colada",sub="Ammurapi Shield",ammo="Staunch Tathlum +1",
		head="Telchine Cap",neck=gear.jse_neck,ear1="Andoaa Earring",ear2=gear.jse_ear2,
		body=gear.af2_body,hands=gear.af1_hands,ring1=gear.kishar_ring,ring2=gear.lebeche_ring,
		back="Ghostfyre Cape",waist="Embla Sash",legs="Telchine Braconi",feet=gear.af3_feet}

	--Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.
	sets.buff.ComposureOther = {head=gear.af3_head,
		body=gear.af3_body,
		legs=gear.af3_legs,feet=gear.af3_feet}

	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.EnhancingSkill = {main="Pukulatmuj +1",sub=gear.forfend,ammo="Staunch Tathlum +1",
		head="Befouled Crown",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Mimir Earring",
		body=gear.af2_body,hands=gear.af2_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Fi Follet Cape +1",waist="Olympus Sash",legs=gear.af1_legs,feet=gear.af3_feet}

	sets.midcast.Refresh = {head="Amalric Coif +1",body=gear.af1_body,legs=gear.af3_legs}
	sets.midcast.Aquaveil = {head="Amalric Coif +1",waist="Emphatikos Rope",legs="Shedir Seraweels"} --hands="Regal Cuffs"
	sets.midcast.BarElement = {legs="Shedir Seraweels"}
	sets.midcast.BarStatus = {neck="Sroda Necklace"}
	sets.midcast.Temper = sets.EnhancingSkill
	sets.midcast.Enspell = sets.EnhancingSkill
	sets.midcast.BoostStat = {hands="Vitiation Gloves +3"}
	sets.midcast.Stoneskin = {neck="Nodens Gorget",waist="Siegel Sash"}--ring2="Earthcry Earring"
	sets.midcast.Protect = {ring2="Sheltered Ring"}
	sets.midcast.Shell = {ring2="Sheltered Ring"}
	sets.midcast.Regen = {main="Bolelabunga",sub="Ammurapi Shield"}

	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = {neck="Phalaina Locket",ear1="Etiolation Earring",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	sets.Self_Phalanx = {main="Sakpata's Sword",head="Taeon Chapeau",body="Taeon Tabard",hands="Taeon Gloves",back=gear.mnd_enfeebling_jse_back,legs="Taeon Tights",feet="Taeon Boots",ammo="Staunch Tathlum +1"}
	sets.Self_Phalanx.DW = {main="Sakpata's Sword",sub="Egeking"}

	sets.midcast['Enfeebling Magic'] = {main="Bunzi's Rod",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
		head=gear.af3_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
		back=gear.mnd_enfeebling_jse_back,waist="Obstinate Sash",legs=gear.chironic_macc_legs,feet="Vitiation Boots +3"}

	sets.midcast['Enfeebling Magic'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af3_head,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af1_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet=gear.af3_feet}

	sets.midcast['Enfeebling Magic'].DW = {main="Bunzi's Rod",sub="Maxentius"}

	sets.midcast.Sleep = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af3_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.kishar_ring,ring2=gear.metamorphic_ring,
		back="Null Shawl",waist="Obstinate Sash",legs=gear.af3_legs,feet=gear.af3_feet} --Obstinate Sash

	sets.midcast.Bind = sets.midcast.Sleep
	sets.midcast.Break = sets.midcast.Sleep
	sets.midcast['Dia III'] = sets.midcast.Sleep
	sets.midcast['Bio III'] = sets.midcast.Sleep
	sets.midcast.Inundation = sets.midcast.Sleep

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {legs=gear.merlinic_treasure_legs,feet=gear.chironic_treasure_feet})
	sets.midcast.Dia = set_combine(sets.midcast.Sleep, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.Sleep, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.Sleep, sets.TreasureHunter)

	sets.midcast.Sleep.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af1_head,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af1_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet=gear.af3_feet}

	sets.midcast.Bind.Resistant = sets.midcast.Sleep.Resistant
	sets.midcast.Break.Resistant = sets.midcast.Sleep.Resistant

	sets.midcast.Sleep.DW = {main="Bunzi's Rod",sub="Maxentius"}
	sets.midcast.Bind.DW = sets.midcast.Sleep.DW
	sets.midcast.Break.DW = sets.midcast.Sleep.DW

	sets.midcast.Dispel = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af1_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af1_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet=gear.af3_feet}

	sets.midcast.Dispel.DW = {main="Bunzi's Rod",sub="Maxentius"}
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {main="Daybreak",sub="Ammurapi Shield"})
	sets.midcast.Dispelga.DW = {main="Daybreak",sub="Bunzi's Rod"}

	sets.midcast.Frazzle = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
		head=gear.af3_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
		back=gear.mnd_enfeebling_jse_back,waist="Obstinate Sash",legs=gear.af3_legs,feet="Vitiation Boots +3"}

	sets.midcast.Distract = sets.midcast.Frazzle

	sets.midcast.Frazzle.Resistant = {main="Daybreak",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af1_head,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af1_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet=gear.af3_feet}

	sets.midcast.Distract.Resistant = sets.midcast.Frazzle.Resistant

	sets.midcast['Frazzle II'] = sets.midcast.Frazzle.Resistant
	sets.midcast.Frazzle.DW = {main="Bunzi's Rod",sub="Daybreak"}
	sets.midcast.Distract.DW = sets.midcast.Frazzle.DW

	sets.midcast.Addle = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
		head=gear.af2_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
		back=gear.mnd_enfeebling_jse_back,waist="Obstinate Sash",legs=gear.chironic_macc_legs,feet="Vitiation Boots +3"}

	sets.midcast.Paralyze = sets.midcast.Addle
	sets.midcast.Slow = sets.midcast.Addle

	sets.midcast.Addle.Resistant = {main="Daybreak",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af2_head,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet=gear.af3_feet}

	sets.midcast.Paralyze.Resistant = sets.midcast.Addle.Resistant
	sets.midcast.Slow.Resistant = sets.midcast.Addle.Resistant

	sets.midcast.Addle.DW = {main="Bunzi's Rod",sub="Daybreak"}
	sets.midcast.Paralyze.DW = sets.midcast.Addle.DW
	sets.midcast.Slow.DW = sets.midcast.Addle.DW

	sets.midcast.Gravity = {main="Bunzi's Rod",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
		head=gear.af3_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.kishar_ring,ring2=gear.metamorphic_ring,
		back=gear.int_enfeebling_jse_back,waist="Obstinate Sash",legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast.Gravity.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
		head=gear.af3_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
		back=gear.int_enfeebling_jse_back,waist="Null Belt",legs=gear.chironic_macc_legs,feet=gear.af3_feet}

	sets.midcast.Gravity.DW = {main="Bunzi's Rod",sub="Maxentius"}

	sets.midcast.Poison = sets.midcast.Gravity
	sets.midcast.Poison.Resistant = sets.midcast.Gravity.Resistant
	sets.midcast.Poison.DW = sets.midcast.Gravity.DW

	sets.midcast.Blind = sets.midcast.Gravity
	sets.midcast.Blind.Resistant = sets.midcast.Gravity.Resistant
	sets.midcast.Blind.DW = sets.midcast.Gravity.DW

	sets.midcast.Silence = {main="Daybreak",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af3_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.kishar_ring,ring2=gear.metamorphic_ring,
		back="Null Shawl",waist="Obstinate Sash",legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast.Silence.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af1_head,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af1_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.chironic_macc_legs,feet=gear.af3_feet}

	sets.midcast.Silence.DW = {main="Bunzi's Rod",sub="Daybreak"}

	--After Bunzi's is augmented it will probably win on low-tier nukes.
	sets.midcast['Elemental Magic'] = {main="Bunzi's Rod",sub=gear.culminus,ammo="Ghastly Tathlum +1",
		head=gear.af3_head,neck=gear.baetyl_pendant,ear1="Malignance Earring",ear2="Friomisi Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.freke_ring,ring2=gear.metamorphic_ring,
		back=gear.nuke_jse_back,waist="Sacro Cord",legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast['Elemental Magic'].DT = {main="Bunzi's Rod",sub=gear.culminus,ammo="Staunch Tathlum +1",
		head=gear.af3_head,neck=gear.loricate_torque,ear1="Malignance Earring",ear2="Friomisi Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.freke_ring,ring2=gear.metamorphic_ring,
		back=gear.nuke_jse_back,waist="Emphatikos Rope",legs="Bunzi's Pants",feet=gear.af3_feet}

    sets.midcast['Elemental Magic'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af3_head,neck=gear.sibyl_scarf,ear1="Malignance Earring",ear2="Friomisi Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.freke_ring,ring2=gear.metamorphic_ring,
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs=gear.af3_legs,feet=gear.af3_feet}

    sets.midcast['Elemental Magic'].Proc = {main="Gleti's Knife",sub=gear.forfend,range=empty,ammo=gear.regal_gem,
        head="Malignance Chapeau",neck="Null Loop",ear1="Snotra Earring",ear2=gear.jse_ear2,
        body="Malignance Tabard",hands="Malignance Gloves",ring1=gear.kishar_ring,ring2="Prolix Ring",
        back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.midcast['Elemental Magic'].HighTierNuke = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head=gear.af3_head,neck=gear.sibyl_scarf,ear1="Malignance Earring",ear2="Friomisi Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.freke_ring,ring2=gear.metamorphic_ring,
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af3_head,neck=gear.sibyl_scarf,ear1="Malignance Earring",ear2="Friomisi Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.freke_ring,ring2=gear.metamorphic_ring,
		gear.nuke_jse_back,waist="Acuity Belt +1",legs=gear.af3_legs,feet=gear.af3_feet}

	-- Gear that Recovers MP when nuking.
	sets.RecoverMP = {body="Seidr Cotehardie"}

	-- Gear for Magic Burst mode.
    sets.MagicBurst = {main="Bunzi's Rod",sub="Ammurapi Shield",neck="Mizu. Kubikazari",hands="Bunzi's Gloves",ring1="Mujin Band"}
	sets.midcast['Elemental Magic'].DW = {main="Bunzi's Rod",sub="Daybreak"}

	sets.midcast.Impact = {main="Bunzi's Rod",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
		head=empty,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.crepuscular_cloak,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast['Dark Magic'] = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
		head=gear.af3_head,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.af3_legs,feet=gear.af3_feet}

    sets.midcast.Drain = {main="Rubicundity",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Malignance Earring",ear2="Snotra Earring",
        body=gear.af3_body,hands=gear.chironic_aspir_gloves,ring1="Evanescence Ring",ring2=gear.metamorphic_ring,
        back=gear.nuke_jse_back,waist="Fucho-no-obi",legs=gear.chironic_aspir_legs,feet=gear.af3_feet}

	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast['Absorb-TP'] = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
        head=gear.af1_head,neck="Null Loop",ear1="Malignance Earring",ear2=gear.jse_ear2,
        body=gear.af2_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
        back=gear.mnd_enfeebling_jse_back,waist="Null Belt",legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast['Absorb-TP'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
        head=gear.af1_head,neck="Null Loop",ear1="Malignance Earring",ear2=gear.jse_ear2,
        body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
        back="Null Shawl",waist="Null Belt",legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast.Stun = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
        head=gear.af1_head,neck="Null Loop",ear1="Malignance Earring",ear2=gear.jse_ear2,
        body=gear.af2_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
        back=gear.mnd_enfeebling_jse_back,waist="Null Belt",legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast.Stun.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
        head=gear.af1_head,neck="Null Loop",ear1="Malignance Earring",ear2=gear.jse_ear2,
        body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorphic_ring,
        back="Null Shawl",waist="Null Belt",legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast.Stun.DW = {main="Bunzi's Rod",sub="Maxentius"}

	-- Sets for special buff conditions on spells.

	sets.buff.Saboteur = {hands=gear.af3_hands}

	sets.HPDown = {main="Mpaca's Staff",sub="Oneiros Grip",ammo="Homiliary",
		head="Pixie Hairpin +1",neck=gear.loricate_torque,ear1="Hirudinea Earring",ear2="Ethereal Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Mephitas's Ring +1",ring2=gear.metamorphic_ring,
		back="Null Shawl",waist="Luminary Sash",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

    sets.HPCure = {main="Daybreak",sub="Ammurapi Shield",ammo=gear.regal_gem,
		head="Nyame Helm",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Odnowa Earring +1",
		body="Bunzi's Robe",hands="Bokwus Gloves",ring1="Sirona's Ring",ring2="Kunaji Ring",
		back="Engulfer Cape +1",waist="Gishdubar Sash",legs="Nyame Flanchard",feet="Medium's Sabots"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {main="Chatoyant Staff",sub="Oneiros Grip",range=empty,ammo=gear.impatiens,
		head=gear.af2_head,neck=gear.loricate_torque,ear1="Etiolation Earring",ear2="Ethereal Earring",
		body=gear.af3_body,hands=gear.merlinic_refresh_hands,ring1="Murky Ring",ring2="Sheltered Ring",
		back="Null Shawl",waist="Null Belt",legs=gear.merlinic_refresh_legs,feet=gear.merlinic_refresh_feet}

	sets.Ballista = {main="Sakpata's Sword",sub=gear.sacro_bulwark,range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck=gear.jse_neck,ear1="Etiolation Earring",ear2=gear.jse_ear2,
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Shneddick Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Bunzi's Pants",feet=gear.af3_feet}

	-- Idle sets
	sets.idle = {main="Mpaca's Staff",sub="Oneiros Grip",ammo="Homiliary",
		head=gear.af2_head,neck=gear.sibyl_scarf,ear1="Etiolation Earring",ear2="Ethereal Earring",
		body=gear.af3_body,hands=gear.chironic_refresh_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Null Shawl",waist="Null Belt",legs=gear.merlinic_refresh_legs,feet=gear.merlinic_refresh_feet}

	sets.idle.PDT = {main="Daybreak",sub=gear.sacro_bulwark,ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck=gear.loricate_torque,ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Murky Ring",ring2="Shadow Ring",
		back="Shadow Mantle",waist="Plat. Mog. Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.idle.MDT = {main="Daybreak",sub=gear.sacro_bulwark,range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Murky Ring",ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

	sets.idle.MEVA = {main="Daybreak",sub=gear.sacro_bulwark,range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Murky Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

	sets.idle.Aminon = {main="Daybreak",sub=gear.sacro_bulwark,range=empty,ammo="Staunch Tathlum +1",
		head="Null Masque",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Murky Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

	-- Defense sets
	sets.defense.PDT = {main="Daybreak",sub=gear.sacro_bulwark,ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck=gear.loricate_torque,ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Murky Ring",ring2="Shadow Ring",
		back="Shadow Mantle",waist="Plat. Mog. Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.NukeLock = sets.midcast['Elemental Magic']

	sets.defense.MDT = {main="Daybreak",sub=gear.sacro_bulwark,range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Murky Ring",ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

    sets.defense.MEVA = {main="Daybreak",sub=gear.sacro_bulwark,range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Murky Ring",ring2="Shadow Ring",
		back="Null Shawl",waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

	sets.Kiting = {ring2="Shneddick Ring"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.DayIdle = {}
	sets.NightIdle = {}

    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.Dagger.Accuracy.Evasion

	-- Normal melee group

	sets.engaged = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Anu Torque",ear1="Sherida Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.Acc = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1="Sherida Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Murky Ring",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.Acc.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Murky Ring",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DW = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Anu Torque",ear1="Sherida Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.dw_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DW.Acc = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.dw_jse_back,waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DW.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1="Sherida Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Murky Ring",ring2="Chirich Ring +1",
		back=gear.dw_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DW.Acc.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Murky Ring",ring2="Chirich Ring +1",
		back=gear.dw_jse_back,waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.EnspellOnly = {ammo="Sroda Tathlum",
		head="Umuthi Hat",neck="Null Loop",ear1="Sherida Earring",ear2="Brutal Earring",
		body="Malignance Tabard",hands="Aya. Manopolas +2",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Ghostfyre Cape",waist="Orpheus's Sash",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.EnspellOnly.Acc = {ammo="Sroda Tathlum",
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2=gear.jse_ear2,
		body="Malignance Tabard",hands="Aya. Manopolas +2",ring1=gear.cacoethic_ring,ring2="Chirich Ring +1",
		back="Null Shawl",waist="Orpheus's Sash",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DualEnspellOnly = {ammo="Sroda Tathlum",
		head="Umuthi Hat",neck="Null Loop",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Malignance Tabard",hands="Aya. Manopolas +2",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Ghostfyre Cape",waist="Orpheus's Sash",legs="Carmine Cuisses +1",feet="Malignance Boots"}

	sets.engaged.DualEnspellOnly.Acc = {ammo="Sroda Tathlum",
		head="Malignance Chapeau",neck="Null Loop",ear1="Crep. Earring",ear2=gear.jse_ear2,
		body="Malignance Tabard",hands="Aya. Manopolas +2",ring1=gear.cacoethic_ring,ring2="Chirich Ring +1",
		back="Null Shawl",waist="Orpheus's Sash",legs="Carmine Cuisses +1",feet="Malignance Boots"}
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'SCH' then
		set_macro_page(1, 2)
	elseif player.sub_job == 'DNC' then
		set_macro_page(4, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(5, 2)
	elseif player.sub_job == 'BLM' then
		set_macro_page(2, 2)
	elseif player.sub_job == 'DRK' then
		set_macro_page(6, 2)
	else
		set_macro_page(3, 2)
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
			windower.chat.input('/lockstyleset 001')
		elseif state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
			windower.chat.input('/lockstyleset 002')
		else
			windower.chat.input('/lockstyleset 004')
		end
	elseif player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		windower.chat.input('/lockstyleset 020')
	end
end

buff_spell_lists = {
	Auto = {--Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
		{Name='Refresh III',	Buff='Refresh',		SpellID=894,	When='Always'},
		{Name='Haste II',		Buff='Haste',		SpellID=511,	When='Always'},
		{Name='Aurorastorm',	Buff='Aurorastorm',	SpellID=119,	When='Idle'},
		{Name='Reraise',		Buff='Reraise',		SpellID=135,	When='Always'},
	},

	AutoMelee = {
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	When='Combat'},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	When='Combat'},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	When='Combat'},
		--{Name='Refresh III',	Buff='Refresh',			SpellID=894,	When='Always'},
		{Name='Gain-STR',		Buff='STR Boost',		SpellID=486,	When='Combat'},
	},

	AutoMage = {
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	When='Always'},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	When='Always'},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	When='Always'},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	When='Always'},
		{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	When='Always'},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		When='Always'},
		{Name='Blink',			Buff='Blink',			SpellID=53,		When='Always'},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		When='Always'},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		When='Always'},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		When='Always'},
	},

	Default = {
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Gain-MND',		Buff='MND Boost',		SpellID=491,	Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',			Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},

	MageBuff = {
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',			Buff='Blink',			SpellID=53,		Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},

	FullMeleeBuff = {
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Gain-STR',		Buff='STR Boost',		SpellID=486,	Reapply=false},
		--{Name='Enthunder',		Buff='Enthunder',		SpellID=104,	Reapply=false},
		--{Name='Shock Spikes',	Buff='Shock Spikes',	SpellID=251,	Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
		--{Name='Barblizzard',	Buff='Barblizzard',		SpellID=61,		Reapply=false},
		--{Name='Barparalyze',	Buff='Barparalyze',		SpellID=74,		Reapply=false},
		{Name='Aquaveil',		Buff='Aquaveil',		SpellID=55,		Reapply=false},
		{Name='Regen II',		Buff='Regen',			SpellID=110,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Blink',			Buff='Blink',			SpellID=53,		Reapply=false},
	},

	MeleeBuff = {
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Gain-STR',		Buff='STR Boost',		SpellID=486,	Reapply=false},
		{Name='Enthunder',		Buff='Enthunder',		SpellID=104,	Reapply=false},
		{Name='Shock Spikes',	Buff='Shock Spikes',	SpellID=251,	Reapply=false},
	},

	Odin = {
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Regen II',		Buff='Regen',			SpellID=110,	Reapply=false},
		{Name='Enaero',			Buff='Enaero',			SpellID=102,	Reapply=false},
		{Name='Stoneskin',		Buff='Stoneskin',		SpellID=54,		Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},

	HybridCleave = {
		{Name='Refresh III',	Buff='Refresh',			SpellID=894,	Reapply=false},
		{Name='Haste II',		Buff='Haste',			SpellID=511,	Reapply=false},
		{Name='Phalanx II',		Buff='Phalanx',			SpellID=107,	Reapply=false},
		{Name='Gain-INT',		Buff='INT Boost',		SpellID=490,	Reapply=false},
		{Name='Enthunder II',	Buff='Enthunder II',	SpellID=316,	Reapply=false},
		{Name='Temper II',		Buff='Multi Strikes',	SpellID=895,	Reapply=false},
		{Name='Shell V',		Buff='Shell',			SpellID=52,		Reapply=false},
		{Name='Protect V',		Buff='Protect',			SpellID=47,		Reapply=false},
	},
}
