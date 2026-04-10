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
    -- Actually important
        gear.sacro_bulwark = "Ammurapi Shield"
        --  12 Sacro Bulwark                 DT -10%, Cure Potency +5%, SIRD 7%
        gear.pukulatmuj = ""
        --  1  Pukulatmuj +1                 Enhancing Set, (required)
        gear.forfend = "Ammurapi Shield"
        --  2  Forfend +1                    R15 Enhancing Set (required)
        gear.regal_gem = "Staunch Tathlum+1"
        --  14 Regal Gem                     Enfeebling Set (required)
        gear.warders_charm = ""
        --  5  Warder's Charm +1             MDT, MEVA, Animon neck, +10 Magic Burst, +15 Skillchain
        gear.loricate_torque = ""
        --  7  Loricate Torque +1            -6 DT, SIRD 5%
        gear.kishar_ring = ""
        --  6  Kishar Ring                   FC +4% Enfeebling Duration +10%
        gear.metamorph_ring = ""
        --  27 Metamorph Ring +1             +16 INT/MND/CHR, +10 MAcc, +60 MP
        gear.witful_belt = ""
        --  3  Witful Belt                   FC +3%, Haste +3%
        gear.emphatikos_rope = ""
        --  4  Emphatikos Rope               SIRD +12%, Aquaveil +1
        gear.telchine_cap = ""
        --  1  Telchine Cap                  Augmented, Enhancing Magic Duration +10%
        gear.telchine_braconi = ""
        --  1  Telchine Braconi              + Enhancing Duration

    -- Useful but mostly optimization
        gear.egeking = ""
        --  1  Egeking                       +2 Phalanx
        gear.rubicundity = ""
        --  1  Rubicundity                   Drain Set, +20 Drain/Aspir Potency (They will take an extra 20 hp/mp)
        gear.mpacas_staff = ""
        --  1  Mpaca's Staff                 Idle Set, +2 Refresh
		--	   easy enough to get, 2 MP refresh worth
        gear.impatiens = "Staunch Tathlum+1"
        --  3  Impatiens                     SIRD 10%, QC 2%
        gear.umuthi_hat = ""
        --  2  Umuthi Hat                    Reduced Stoneskin Casting Time, +13 Enhancing, +8 Enspell
        gear.amalric_coif = ""
        --  2  Amalric Coif +1               +2 Refresh Potency
        gear.incanters_torque = ""
        --  4  Incanter's Torque             Magic skills + 10 (Melic Torque Enh + Henic Torque Heal -- Synergy)
        gear.baetyl_pendant = ""
        --  3  Baetyl Pendant                FC +4%, MAB +13
        gear.sibyl_scarf = ""
        --  4  Sibyl Scarf                   INT +10, MAB +10
        gear.ournmilas_torque = ""
        --  1  Orunmila's Torque             FC +5%
        gear.etiolation_earring = ""
        --  9  Etiolation Earring            FC +1% MDT - 3%
        gear.andoaa_earring = ""
        --  2  Andoaa Earring                Enhancing +5
        gear.freke_ring = ""
        --  8  Freke Ring                    10 INT, 8 MAB, 10 SIRD
        gear.cornelias_ring = ""
        --  6  Cornelia's Ring               +10% WSD
        gear.perimede_cape = gear.cure_jse_back
        --  3  Perimede Cape                 QC+4%
        gear.acuity_belt = ""
    	--  3  Acuity Belt +1                +16 INT, +15 Macc
        gear.obstinate_sash = ""
        --  6  Obstinate Sash                +5 Enfeebling Duration

    -- Pure min/max or niche
        --  gear.bolelebunga = ""
        --  1  Bolelabunga                   Overkill? +10% Regen (effectively, 1 HP / tic)
        gear.diamond_aspis = ""
        --  0  Diamond Aspis                 Swap piece
        gear.culminus = "Ammurapi Shield"
        --  3  Culminus                      Low Tier Nuke, highest +Magic Damage
        gear.homillary = "Staunch Tathlum+1"
        --  1  Homiliary                     Idle Refresh +1
        gear.hasty_pinion = ""
        --  3  Hasty Pinion +1               Haste +1%, for sets that don't Haste Cap
        gear.oshashas_treatise = ""
        --  3  Oshasha's Treatise            Wsd 3%
        gear.befouled_crown = ""
        --  1  Befouled Crown                +16 Enhancing
        gear.null_masque = ""
        --  1  Null Masque                   Animon Idle
        gear.phalaina_locket = ""
        --  2  Phalaina Locket               +4% Cure and Cure Received
        gear.nodens_gorget = ""
        --  1  Nodens Gorget                 Stoneskin + 30 HP
        gear.sroda_necklace = ""
        --  1  Sroda Necklace                +20 Resist Ailment of Bar-status spells
        gear.mizu_kubikazari = ""
        --  1  Mizu. Kubikazari              +10 Magic Burst
        gear.debilis_medallion = ""
        --  1  Debilis Medallion             Cursna Set
        gear.anu_torque = ""
        --  2  Anu Torque                    +7 STP Default Neck, switch immediately
        gear.fotia_gorget = ""
        --  4  Fotia Gorget                  fTP replicating WS
        gear.rep_plat_medal = ""
        --  2  Rep. Plat. Medal              STR +10, ATK + 30, Bastok Citizen Regain +2
        gear.prolix_ring = ""
        --  1  Prolix Ring                   FC +2%
        gear.mujin_band = ""
        --  1  Mujin Band                    Magic Burst II +5%
        gear.sanare_earring = ""
        --  5  Sanare Earring                MDB+4, MEva+6
        gear.ethereal_earring = ""
        --  3  Ethereal Earring              Eva+5, Converts 3% Damage Taken to MP
        gear.crep_earring = ""
        --  6  Crep. Earring                 Acc +10, STP +5
        gear.meili_earring = ""
        --  4  Meili Earring                 Healing skill + 10
        gear.zennaroi_ear = ""
        --  2  Zennaroi Earring              MDB +1
        gear.seidr_cotehardie = ""
        --  1  Seidr Cotehardie              2% Magic damage dealt to MP
        gear.crepuscular_cloak = ""
        --  2  Crepuscular Cloak             Impact
        gear.hieros_mittens = ""
        --  1  Hieros Mittens                Cursna Set
        gear.kunaji_ring = ""
        --  2  Kunaji Ring                   +5 Cure Received
        gear.shadow_ring = ""
        --  7  Shadow Ring                   Death protection, MDB
        gear.sironas_ring = ""
        --  3  Sirona's Ring                 healing skill + 10
        gear.haomas_ring = ""
        --  1  Haoma's Ring                  +15% Cursnda Success
        gear.sheltered_ring = ""
        --  2  Sheltered Ring                +10 DEF, +3% MDT (does not have to be equipped)
        gear.cacoethic_ring = ""
        --  4  Cacoethic Ring +1             +11 Accuracy
        gear.lebeche_ring = ""
        --  4  Lebeche Ring                  QM +2%
        gear.shadow_mantle = ""
        --  2  Shadow Mantle                 Phys Annul
        gear.engulfer_cape = ""
        --  2  Engulfer Cape +1              -4% MDT, Magic Absorb
        gear.oretan_cape = ""
        --  1  Oretan. Cape +1               +5 Cursna
        gear.sacro_cord = ""
        --  1  Sacro Cord                    +8 INT/MND/MAB/Macc
        gear.luminary_sash = ""
        --  1  Luminary Sash                 Conserve MP / MND
        gear.bishops_sash = ""
    	--  1  Bishop's Sash                 +5 Healing (cursna)
        gear.olympus_sash = ""
    	--  1  Olympus Sash                  +5 Enhancing
        gear.siegel_sash = ""
    	--  1  Siegel Sash                   Stoneskin + 20 HP, Casting time -8%
        gear.fuchonoobi = ""
    	--  2  Fucho-no-obi                  +8 Drain/Aspirt Potency
        gear.plat_mog_belt = ""
    	--  2  Plat. Mog. Belt               +10% HP, 15 Eva, -3 DT
        gear.fotia_belt = ""
        --  3  Fotia Belt                    fTP Belt

    -- Ignored placeholders
        gear.filler_shield = "Ammurapi Shield"
        --   3  Removed grip and replaced with Crocea, didn't research sub (FullFC, Status Removal, Cursna)
        gear.filler_grip = "Enki Strap"
        --   3  Still using staff in some cases, might as well have a grip (Light Weather Cure, Idle, Latent Refresh)
        gear.filler_idle_hands = "" -- 1
        gear.filler_cureDT_hands -- 1
        gear.filler_drain_hands = "" -- 1
        gear.ghostfyre_cape = "" -- 4
        --  ****"Ghostfyre Cape"            +10 Enhancing, +20% Enhancing Duration

    -- Other placeholders
        gear.sworn_brais = "Aya. Cosciales +2"
        --  1  Sworn Brais                   R0 has better Fast Cast
        gear.filler_enfeebling_legs = "" 
		--  9
        gear.filler_idle_legs = "" 
		--  1
    -- feet
        gear.filler_idle_feet = "" 
		--  1
        gear.filler_feet = "" 
        --  1                               Was part of a Cursna set, healing skill?
        gear.filler_FullFC_feet = "" 
		--  0
        gear.filler_drain_feet = "" 
		--  1

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
    sets.precast.Step = {ammo=gear.hasty_pinion,
		head="Malignance Chapeau",neck="Null Loop",ear1=gear.zennaroi_ear,ear2="Crepuscular Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1=gear.cacoethic_ring,ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	-- Violent Flourish (Macc & Acc)
    sets.precast.JA['Violent Flourish'] = {ammo=gear.regal_gem,--Or range="Ullr" but swapping to this makes you lose TP.
		head=gear.af3_head,neck="Null Loop",ear1="Malignance Earring",ear2="Crepuscular Earring",
		body="Malignance Tabard",hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
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

	sets.precast.FullFC = {main="Crocea Mors",sub=gear.filler_shield,ammo=gear.impatiens,
		head=gear.af1_head,neck=gear.ournmilas_torque,ear1="Malignance Earring",ear2=gear.jse_ear2,
		body=gear.af2_body,hands=gear.gende_gages,ring1=gear.kishar_ring,ring2=gear.lebeche_ring,
		back=gear.perimede_cape,waist=gear.witful_belt,legs=gear.sworn_brais,feet=gear.filler_FullFC=feet}

	sets.precast.FC.Impact = set_combine(sets.precast.FullFC, {head=empty,body=gear.crepuscular_cloak})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub=gear.sacro_bulwark})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {range=empty,ammo=gear.oshashas_treatise,
		head=gear.af2_head,neck=gear.fotia_gorget,ear1="Sherida Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands=gear.af1_hands,ring1="Sroda Ring",ring2=gear.cornealias_ring,
		back=gear.str_wsd_jse_back,waist=gear.fotia_belt,legs="Nyame Flanchard",feet=gear.af3_feet}

	sets.precast.WS.Proc = 	{ammo=gear.hasty_pinion,
		head="Malignance Chapeau",neck="Null Loop",ear1=gear.zennaroi_ear,ear2="Crepuscular Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1=gear.cacoethic_ring,ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = {range=empty,ammo=gear.regal_gem,
		head=gear.af2_head,neck=gear.fotia_gorget,ear1="Sherida Earring",ear2="Moonshade Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
		back=gear.physical_mnd_wsd_jse_back,waist=gear.fotia_belt,legs=gear.af3_legs,feet=gear.af3_feet}

	sets.precast.WS['Chant Du Cygne'] = {range=empty,ammo="Coiste Bodhar",
		head="Nyame Helm",neck=gear.fotia_gorget,ear1="Sherida Earring",ear2="Brutal Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Epaminondas's Ring",ring2=gear.cornelias_ring,
		back=gear.str_wsd_jse_back,waist=gear.fotia_belt,legs="Nyame Flanchard",feet=gear.af3_feet}

	sets.precast.WS['Evisceration'] = sets.precast.WS['Chant Du Cygne']

	sets.precast.WS['Savage Blade'] = {range=empty,ammo=gear.oshashas_treatise,
		head=gear.af2_head,neck=gear.rep_plat_medal,ear1="Sherida Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands=gear.af1_hands,ring1="Sroda Ring",ring2=gear.cornelias_ring,
		back=gear.str_wsd_jse_back,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet=gear.af3_feet}

	sets.precast.WS['Black Halo'] = {range=empty,ammo=gear.oshashas_treatise,
		head=gear.af2_head,neck=gear.rep_plat_medal,ear1="Sherida Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands=gear.af1_hands,ring1="Sroda Ring",ring2=gear.cornelias_ring,
		back=gear.physical_mnd_wsd_jse_back,waist="Sailfi Belt +1",legs="Nyame Flanchard",feet=gear.af3_feet}

	sets.precast.WS['Sanguine Blade'] = {range=empty,ammo="Sroda Tathlum",
		head=gear.af3_head,neck=gear.baetyl_pendant,ear1="Malignance Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands=gear.af3_hands,ring1="Epaminondas's Ring",ring2=gear.cornelias_ring,
		back=gear.magical_mnd_wsd_jse_back,waist="Orpheus's Sash",legs="Nyame Flanchard",feet=gear.af3_feet}

	sets.precast.WS['Seraph Blade'] = {range=empty,ammo="Sroda Tathlum",
		head=gear.af3_head,neck=gear.baetyl_pendant,ear1="Malignance Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands=gear.af3_hands,ring1="Epaminondas's Ring",ring2=gear.cornelias_ring,
		back=gear.magical_mnd_wsd_jse_back,waist="Orpheus's Sash",legs="Nyame Flanchard",feet=gear.af3_feet}

	sets.precast.WS['Shining Strike'] = sets.precast.WS['Seraph Blade']
	sets.precast.WS['Flash Nova'] = sets.precast.WS['Seraph Blade']

	sets.precast.WS['Aeolian Edge'] = {range=empty,ammo="Sroda Tathlum",
		head=gear.af3_head,neck=gear.fotia_gorget,ear1="Malignance Earring",ear2="Moonshade Earring",
		body="Nyame Mail",hands=gear.af1_hands,ring1=gear.freke_ring,ring2=gear.cornelias_ring,
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
		back=gear.mnd_enfeebling_jse_back,waist=gear.emphatikos_rope,legs="Bunzi's Pants",feet="Bunzi's Sabots"}

    sets.midcast.Cure = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
        head="Kaykaus Mitra +1",neck=gear.incanters_torque,ear1=gear.meili_earring,ear2="Mendi. Earring",
        body="Kaykaus Bliaut +1",hands="Kaykaus Cuffs +1",ring1=gear.sironas_ring,ring2="Menelaus's Ring",
        back=gear.mnd_enfeebling_jse_back,waist=gear.luminary_sash,legs="Kaykaus tights +1",feet="Kaykaus Boots +1"}

    sets.midcast.LightWeatherCure = {main="Chatoyant Staff",sub=gear.filler_grip,range=empty,ammo=gear.regal_gem,
        head="Kaykaus Mitra +1",neck=gear.incanters_torque,ear1=gear.meili_earring,ear2="Mendi. Earring",
        body="Kaykaus Bliaut +1",hands="Kaykaus Cuffs +1",ring1=gear.sironas_ring,ring2="Menelaus's Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs="Kaykaus tights +1",feet="Kaykaus Boots +1"}

		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
        head="Kaykaus Mitra +1",neck=gear.incanters_torque,ear1=gear.meili_earring,ear2="Mendi. Earring",
        body="Kaykaus Bliaut +1",hands="Kaykaus Cuffs +1",ring1=gear.sironas_ring,ring2="Menelaus's Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs="Kaykaus tights +1",feet="Kaykaus Boots +1"}

    sets.midcast.Cure.DT = {main="Daybreak",sub=gear.culminus,range=empty,ammo="Staunch Tathlum +1",
        head=gear.af3_head,neck=gear.loricate_torque,ear1="Halasz Earring",ear2="Mendi. Earring",
        body="Bunzi's Robe",hands=gear.filler_cureDT_hands,ring1="Murky Ring",ring2=gear.freke_ring,
        back=gear.mnd_enfeebling_jse_back,waist=gear.emphatikos_rope,legs="Bunzi's Pants",feet="Bunzi's Sabots"}

	sets.midcast.Cursna = {main="Crocea Mors",sub=gear.filler_shield,range=empty,ammo=gear.hasty_pinion,
        head="Kaykaus Mitra +1",neck=gear.debilis_medallion,ear1=gear.meili_earring,ear2=gear.jse_ear2,
        body=gear.af2_body,hands=gear.hieros_mittens,ring1=gear.haomas_ring,ring2="Menelaus's Ring",
        back=gear.oretan_cape,waist=gear.bishops_sash,legs=gear.af1_legs,feet=gear.filler_feet}

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Crocea Mors",sub=gear.filler_shield})

	sets.midcast['Enhancing Magic'] = {main="Colada",sub="Ammurapi Shield",ammo="Staunch Tathlum +1",
		head=gear.telchine_cap,neck=gear.jse_neck,ear1=gear.andoaa_earring,ear2=gear.jse_ear2,
		body=gear.af2_body,hands=gear.af1_hands,ring1=gear.kishar_ring,ring2=gear.lebeche_ring,
		back=gear.ghostfyre_cape,waist="Embla Sash",legs=gear.telchine_braconi,feet=gear.af3_feet}

	--Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.
	sets.buff.ComposureOther = {head=gear.af3_head,
		body=gear.af3_body,
		legs=gear.af3_legs,feet=gear.af3_feet}

	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.EnhancingSkill = {main=gear.pukulatmuj,sub=gear.forfend,ammo="Staunch Tathlum +1",
		head=gear.befouled_crown,neck=gear.incanters_torque,ear1=gear.andoaa_earring,ear2="Mimir Earring",
		body=gear.af2_body,hands=gear.af2_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back=gear.ghostfyre_cape,waist=gear.olympus_sash,legs=gear.af1_legs,feet=gear.af3_feet}

	sets.midcast.Refresh = {head=gear.amalric_coif,body=gear.af1_body,legs=gear.af3_legs}
	sets.midcast.Aquaveil = {head=gear.amalric_coif,hands="Regal Cuffs",waist=gear.emphatikos_rope,legs="Shedir Seraweels"} --hands="Regal Cuffs"
	sets.midcast.BarElement = {legs="Shedir Seraweels"}
	sets.midcast.BarStatus = {neck=gear.sroda_necklace}
	sets.midcast.Temper = sets.EnhancingSkill
	sets.midcast.Enspell = sets.EnhancingSkill
	sets.midcast.BoostStat = {hands=gear.af2_hands}
	sets.midcast.Stoneskin = {neck=gear.nodens_gorget,waist=gear.siegel_sash}--ring2="Earthcry Earring"  -- Misisng  Seraweels?
	sets.midcast.Protect = {ring2=gear.sheltered_ring}
	sets.midcast.Shell = {ring2=gear.sheltered_ring}
	sets.midcast.Regen = {main="Crocea Mors",sub="Ammurapi Shield"}

	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = {neck=gear.phalaina_locket,ear1=gear.etiolation_earring,ring2=gear.kunaji_ring,waist="Gishdubar Sash"}
	sets.Cure_Received = {neck=gear.phalaina_locket,ring2=gear.kunaji_ring,waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	sets.Self_Phalanx = {main="Sakpata's Sword",head="Taeon Chapeau",body="Taeon Tabard",hands="Taeon Gloves",back=gear.mnd_enfeebling_jse_back,legs="Taeon Tights",feet="Taeon Boots",ammo="Staunch Tathlum +1"}
	sets.Self_Phalanx.DW = {main="Sakpata's Sword",sub=gear.egeking}

	sets.midcast['Enfeebling Magic'] = {main="Bunzi's Rod",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
		head=gear.af3_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
		back=gear.mnd_enfeebling_jse_back,waist=gear.obstinate_sash,legs=gear.filler_enfeebling_legs,feet=gear.af2_feet}

	sets.midcast['Enfeebling Magic'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af3_head,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af1_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.filler_enfeebling_legs,feet=gear.af3_feet}

	sets.midcast['Enfeebling Magic'].DW = {main="Bunzi's Rod",sub="Maxentius"}

	sets.midcast.Sleep = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af3_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.kishar_ring,ring2=gear.metamorph_ring,
		back="Null Shawl",waist=gear.obstinate_sash,legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast.Bind = sets.midcast.Sleep
	sets.midcast.Break = sets.midcast.Sleep
	sets.midcast['Dia III'] = sets.midcast.Sleep
	sets.midcast['Bio III'] = sets.midcast.Sleep
	sets.midcast.Inundation = sets.midcast.Sleep

	sets.midcast.Dia = set_combine(sets.midcast.Sleep, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.Sleep, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.Sleep, sets.TreasureHunter)

	sets.midcast.Sleep.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af1_head,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af1_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.filler_enfeebling_legs,feet=gear.af3_feet}

	sets.midcast.Bind.Resistant = sets.midcast.Sleep.Resistant
	sets.midcast.Break.Resistant = sets.midcast.Sleep.Resistant

	sets.midcast.Sleep.DW = {main="Bunzi's Rod",sub="Maxentius"}
	sets.midcast.Bind.DW = sets.midcast.Sleep.DW
	sets.midcast.Break.DW = sets.midcast.Sleep.DW

	sets.midcast.Dispel = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af1_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af1_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.filler_enfeebling_legs,feet=gear.af3_feet}

	sets.midcast.Dispel.DW = {main="Bunzi's Rod",sub="Maxentius"}
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {main="Daybreak",sub="Ammurapi Shield"})
	sets.midcast.Dispelga.DW = {main="Daybreak",sub="Bunzi's Rod"}

	sets.midcast.Frazzle = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
		head=gear.af3_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
		back=gear.mnd_enfeebling_jse_back,waist=gear.obstinate_sash,legs=gear.af3_legs,feet=gear.af2_feet}

	sets.midcast.Distract = sets.midcast.Frazzle

	sets.midcast.Frazzle.Resistant = {main="Daybreak",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af1_head,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af1_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.filler_enfeebling_legs,feet=gear.af3_feet}

	sets.midcast.Distract.Resistant = sets.midcast.Frazzle.Resistant

	sets.midcast['Frazzle II'] = sets.midcast.Frazzle.Resistant
	sets.midcast.Frazzle.DW = {main="Bunzi's Rod",sub="Daybreak"}
	sets.midcast.Distract.DW = sets.midcast.Frazzle.DW

	sets.midcast.Addle = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
		head=gear.af2_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
		back=gear.mnd_enfeebling_jse_back,waist=gear.obstinate_sash,legs=gear.filler_enfeebling_legs,feet=gear.af2_feet}

	sets.midcast.Paralyze = sets.midcast.Addle
	sets.midcast.Slow = sets.midcast.Addle

	sets.midcast.Addle.Resistant = {main="Daybreak",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af2_head,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.filler_enfeebling_legs,feet=gear.af3_feet}

	sets.midcast.Paralyze.Resistant = sets.midcast.Addle.Resistant
	sets.midcast.Slow.Resistant = sets.midcast.Addle.Resistant

	sets.midcast.Addle.DW = {main="Bunzi's Rod",sub="Daybreak"}
	sets.midcast.Paralyze.DW = sets.midcast.Addle.DW
	sets.midcast.Slow.DW = sets.midcast.Addle.DW

	sets.midcast.Gravity = {main="Bunzi's Rod",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
		head=gear.af3_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.kishar_ring,ring2=gear.metamorph_ring,
		back=gear.int_enfeebling_jse_back,waist=gear.obstinate_sash,legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast.Gravity.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
		head=gear.af3_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
		back=gear.int_enfeebling_jse_back,waist="Null Belt",legs=gear.filler_enfeebling_legs,feet=gear.af3_feet}

	sets.midcast.Gravity.DW = {main="Bunzi's Rod",sub="Maxentius"}

	sets.midcast.Poison = sets.midcast.Gravity
	sets.midcast.Poison.Resistant = sets.midcast.Gravity.Resistant
	sets.midcast.Poison.DW = sets.midcast.Gravity.DW

	sets.midcast.Blind = sets.midcast.Gravity
	sets.midcast.Blind.Resistant = sets.midcast.Gravity.Resistant
	sets.midcast.Blind.DW = sets.midcast.Gravity.DW

	sets.midcast.Silence = {main="Daybreak",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af3_head,neck=gear.jse_neck,ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.kishar_ring,ring2=gear.metamorph_ring,
		back="Null Shawl",waist=gear.obstinate_sash,legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast.Silence.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af1_head,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af1_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.filler_enfeebling_legs,feet=gear.af3_feet}

	sets.midcast.Silence.DW = {main="Bunzi's Rod",sub="Daybreak"}

	--After Bunzi's is augmented it will probably win on low-tier nukes.
	sets.midcast['Elemental Magic'] = {main="Bunzi's Rod",sub=gear.culminus,ammo="Ghastly Tathlum +1",
		head=gear.af3_head,neck=gear.baetyl_pendant,ear1="Malignance Earring",ear2="Friomisi Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.freke_ring,ring2=gear.metamorph_ring,
		back=gear.nuke_jse_back,waist=gear.sacro_cord,legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast['Elemental Magic'].DT = {main="Bunzi's Rod",sub=gear.culminus,ammo="Staunch Tathlum +1",
		head=gear.af3_head,neck=gear.loricate_torque,ear1="Malignance Earring",ear2="Friomisi Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.freke_ring,ring2=gear.metamorph_ring,
		back=gear.nuke_jse_back,waist=gear.emphatikos_rope,legs="Bunzi's Pants",feet=gear.af3_feet}

    sets.midcast['Elemental Magic'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af3_head,neck=gear.sibyl_scarf,ear1="Malignance Earring",ear2="Friomisi Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.freke_ring,ring2=gear.metamorph_ring,
		back=gear.nuke_jse_back,waist=gear.acuity_belt,legs=gear.af3_legs,feet=gear.af3_feet}

    sets.midcast['Elemental Magic'].Proc = {main="Gleti's Knife",sub=gear.forfend,range=empty,ammo=gear.regal_gem,
        head="Malignance Chapeau",neck="Null Loop",ear1="Snotra Earring",ear2=gear.jse_ear2,
        body="Malignance Tabard",hands="Malignance Gloves",ring1=gear.kishar_ring,ring2=gear.prolix_ring,
        back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.midcast['Elemental Magic'].HighTierNuke = {main="Bunzi's Rod",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head=gear.af3_head,neck=gear.sibyl_scarf,ear1="Malignance Earring",ear2="Friomisi Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.freke_ring,ring2=gear.metamorph_ring,
		back=gear.nuke_jse_back,waist=gear.acuity_belt,legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
		head=gear.af3_head,neck=gear.sibyl_scarf,ear1="Malignance Earring",ear2="Friomisi Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1=gear.freke_ring,ring2=gear.metamorph_ring,
		gear.nuke_jse_back,waist=gear.acuity_belt,legs=gear.af3_legs,feet=gear.af3_feet}

	-- Gear that Recovers MP when nuking.
	sets.RecoverMP = {body=gear.seidr_cotehardie}

	-- Gear for Magic Burst mode.
    sets.MagicBurst = {main="Bunzi's Rod",sub="Ammurapi Shield",neck=gear.mizu_kubikazari,hands="Bunzi's Gloves",ring1=gear.mujin_band}
	sets.midcast['Elemental Magic'].DW = {main="Bunzi's Rod",sub="Daybreak"}

	sets.midcast.Impact = {main="Bunzi's Rod",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
		head=empty,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.crepuscular_cloak,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast['Dark Magic'] = {main="Daybreak",sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
		head=gear.af3_head,neck="Null Loop",ear1="Malignance Earring",ear2="Snotra Earring",
		body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
		back="Null Shawl",waist="Null Belt",legs=gear.af3_legs,feet=gear.af3_feet}

    sets.midcast.Drain = {main=gear.rubicundity,sub="Ammurapi Shield",range=empty,ammo=gear.regal_gem,
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Malignance Earring",ear2="Snotra Earring",
        body=gear.af3_body,hands=gear.filler_drain_hands,ring1="Evanescence Ring",ring2=gear.metamorph_ring,
        back=gear.nuke_jse_back,waist=gear.fuchonoobi,legs=gear.filler_drain_feet,feet=gear.af3_feet}

	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast['Absorb-TP'] = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
        head=gear.af1_head,neck="Null Loop",ear1="Malignance Earring",ear2=gear.jse_ear2,
        body=gear.af2_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
        back=gear.mnd_enfeebling_jse_back,waist="Null Belt",legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast['Absorb-TP'].Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
        head=gear.af1_head,neck="Null Loop",ear1="Malignance Earring",ear2=gear.jse_ear2,
        body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
        back="Null Shawl",waist="Null Belt",legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast.Stun = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
        head=gear.af1_head,neck="Null Loop",ear1="Malignance Earring",ear2=gear.jse_ear2,
        body=gear.af2_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
        back=gear.mnd_enfeebling_jse_back,waist="Null Belt",legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast.Stun.Resistant = {main="Bunzi's Rod",sub="Ammurapi Shield",range="Ullr",ammo=empty,
        head=gear.af1_head,neck="Null Loop",ear1="Malignance Earring",ear2=gear.jse_ear2,
        body=gear.af3_body,hands=gear.af3_hands,ring1="Stikini Ring +1",ring2=gear.metamorph_ring,
        back="Null Shawl",waist="Null Belt",legs=gear.af3_legs,feet=gear.af3_feet}

	sets.midcast.Stun.DW = {main="Bunzi's Rod",sub="Maxentius"}

	-- Sets for special buff conditions on spells.

	sets.buff.Saboteur = {hands=gear.af3_hands}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.

	-- Idle sets
	sets.idle = {main="Mpaca's Staff",sub=gear.filler_grip,ammo=gear.homillary,
		head=gear.af2_head,neck=gear.sibyl_scarf,ear1=gear.etiolation_earring,ear2=gear.ethereal_earring,
		body=gear.af3_body,hands=gear.filler_idle_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Null Shawl",waist="Null Belt",legs=gear.filler_idle_legs,feet=gear.filler_idle_feet}

	sets.idle.PDT = {main="Daybreak",sub=gear.sacro_bulwark,ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck=gear.loricate_torque,ear1=gear.etiolation_earring,ear2=gear.ethereal_earring,
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Murky Ring",ring2=gear.shadow_ring,
		back=gear.shadow_mantle,waist=gear.plat_mog_belt,legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.idle.MDT = {main="Daybreak",sub=gear.sacro_bulwark,range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck=gear.warders_charm,ear1=gear.etiolation_earring,ear2=gear.sanare_earring,
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Murky Ring",ring2=gear.shadow_ring,
		back=gear.engulfer_cape,waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

	sets.idle.MEVA = {main="Daybreak",sub=gear.sacro_bulwark,range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck=gear.warders_charm,ear1=gear.etiolation_earring,ear2=gear.sanare_earring,
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Murky Ring",ring2=gear.shadow_ring,
		back="Null Shawl",waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

	sets.idle.Aminon = {main="Daybreak",sub=gear.sacro_bulwark,range=empty,ammo="Staunch Tathlum +1",
		head=gear.null_masque,neck=gear.warders_charm,ear1=gear.etiolation_earring,ear2=gear.sanare_earring,
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Murky Ring",ring2=gear.shadow_ring,
		back="Null Shawl",waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

	-- Defense sets
	sets.defense.PDT = {main="Daybreak",sub=gear.sacro_bulwark,ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck=gear.loricate_torque,ear1=gear.etiolation_earring,ear2=gear.ethereal_earring,
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Murky Ring",ring2=gear.shadow_ring,
		back=gear.shadow_mantle,waist=gear.plat_mog_belt,legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.NukeLock = sets.midcast['Elemental Magic']

	sets.defense.MDT = {main="Daybreak",sub=gear.sacro_bulwark,range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck=gear.warders_charm,ear1=gear.etiolation_earring,ear2=gear.sanare_earring,
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Murky Ring",ring2=gear.shadow_ring,
		back=gear.engulfer_cape,waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

    sets.defense.MEVA = {main="Daybreak",sub=gear.sacro_bulwark,range=empty,ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",neck=gear.warders_charm,ear1=gear.etiolation_earring,ear2=gear.sanare_earring,
		body="Bunzi's Robe",hands="Bunzi's Gloves",ring1="Murky Ring",ring2=gear.shadow_ring,
		back="Null Shawl",waist="Null Belt",legs="Bunzi's Pants",feet="Bunzi's Sabots"}

	sets.Kiting = {ring2="Shneddick Ring"}
	sets.latent_refresh = {waist=gear.fuchonoobi}
	sets.latent_refresh_grip = {sub=gear.filler_grip}
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
		head="Malignance Chapeau",neck=gear.anu_torque,ear1="Sherida Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.Acc = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1=gear.crep_earring,ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1="Sherida Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Murky Ring",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.Acc.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1=gear.crep_earring,ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Murky Ring",ring2="Chirich Ring +1",
		back="Null Shawl",waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DW = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck=gear.anu_torque,ear1="Sherida Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.dw_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DW.Acc = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1=gear.crep_earring,ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.dw_jse_back,waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DW.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1="Sherida Earring",ear2="Dedition Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Murky Ring",ring2="Chirich Ring +1",
		back=gear.dw_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DW.Acc.DT = {ammo="Coiste Bodhar",
		head="Malignance Chapeau",neck="Null Loop",ear1=gear.crep_earring,ear2="Telos Earring",
		body="Malignance Tabard",hands="Malignance Gloves",ring1="Murky Ring",ring2="Chirich Ring +1",
		back=gear.dw_jse_back,waist="Null Belt",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.EnspellOnly = {ammo="Sroda Tathlum",
		head=gear.umuthi_hat,neck="Null Loop",ear1="Sherida Earring",ear2="Brutal Earring",
		body="Malignance Tabard",hands="Aya. Manopolas +2",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.ghostfyre_cape,waist="Orpheus's Sash",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.EnspellOnly.Acc = {ammo="Sroda Tathlum",
		head="Malignance Chapeau",neck="Null Loop",ear1=gear.crep_earring,ear2=gear.jse_ear2,
		body="Malignance Tabard",hands="Aya. Manopolas +2",ring1=gear.cacoethic_ring,ring2="Chirich Ring +1",
		back="Null Shawl",waist="Orpheus's Sash",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DualEnspellOnly = {ammo="Sroda Tathlum",
		head=gear.umuthi_hat,neck="Null Loop",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Malignance Tabard",hands="Aya. Manopolas +2",ring1="Chirich Ring +1",ring2="Chirich Ring +1",
		back=gear.ghostfyre_cape,waist="Orpheus's Sash",legs="Carmine Cuisses +1",feet="Malignance Boots"}

	sets.engaged.DualEnspellOnly.Acc = {ammo="Sroda Tathlum",
		head="Malignance Chapeau",neck="Null Loop",ear1=gear.crep_earring,ear2=gear.jse_ear2,
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
