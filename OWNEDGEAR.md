# OWNEDGEAR

Machine-oriented owned gear index for future GearSwap Lua work.

```json
{
  "schema": "owned-gear/v1",
  "generated_at": "2026-08-24T00:00:00Z",
  "source_policy": "Parsed active personalized Lua gear files under data/Kalali, excluding data/Kalali/UnusedJobs, Kalali_Crafting.lua, and Kalali-Globals.lua. Lua comments were stripped before extraction. Empty strings, empty tables, and empty sentinel values were ignored. User-confirmed acquisitions may be added with their requesting job file as a source before a full regeneration.",
  "duplicate_policy": "Non-accessory duplicates are collapsed by name plus augments plus bag. Ring and earring entries include copies=2 only when active Lua uses explicit bag-qualified duplicates, such as Wardrobe plus Wardrobe 2.",
  "source_files": [
    "data/Kalali/Kalali-Items.lua",
    "data/Kalali-PLD.lua",
    "data/Kalali/Kalali_Blu_Gear.lua",
    "data/Kalali/Kalali_Brd_Gear.lua",
    "data/Kalali/Kalali_Cor_Gear.lua",
    "data/Kalali/Kalali_Geo_Gear.lua",
    "data/Kalali/Kalali_Pld_Gear.lua",
    "data/Kalali/Kalali_Pup_Gear.lua",
    "data/Kalali/Kalali_Rdm_Gear.lua",
    "data/Kalali/Kalali_Sch_Gear.lua",
    "data/Kalali/Kalali_Smn_Gear.lua",
    "data/Kalali/Kalali_War_Gear.lua"
  ],
  "slot_order": [
    "main",
    "sub",
    "range",
    "ammo",
    "head",
    "body",
    "hands",
    "legs",
    "feet",
    "neck",
    "waist",
    "back",
    "ear",
    "ring"
  ],
  "total_slot_entries": 469,
  "slots": {
    "main": [
      {
        "name": "Bunzi's Rod",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:main",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.gada_enhancing_club",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.grioavolr_nuke_staff",
          "data/Kalali/Kalali_Geo_Gear.lua:main",
          "data/Kalali/Kalali_Rdm_Gear.lua:main",
          "data/Kalali/Kalali_Sch_Gear.lua:main"
        ]
      },
      {
        "name": "Carnwenhan",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:main"
        ]
      },
      {
        "name": "Chango",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:main"
        ]
      },
      {
        "name": "Chatoyant Staff",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:main",
          "data/Kalali/Kalali_Rdm_Gear.lua:main",
          "data/Kalali/Kalali_Sch_Gear.lua:main"
        ]
      },
      {
        "name": "Crocea Mors",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:main"
        ]
      },
      {
        "name": "Daybreak",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:main",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.gada_healing_club",
          "data/Kalali/Kalali_Geo_Gear.lua:main",
          "data/Kalali/Kalali_Rdm_Gear.lua:main",
          "data/Kalali/Kalali_Sch_Gear.lua:main"
        ]
      },
      {
        "name": "Denouements",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:main"
        ]
      },
      {
        "name": "Espiritus",
        "augments": [
          "MP+50",
          "Pet: \"Mag.Atk.Bns.\"+20",
          "Pet: Mag. Acc.+20"
        ],
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:main"
        ]
      },
      {
        "name": "Excalibur",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:main"
        ]
      },
      {
        "name": "Fusetto +2",
        "sources": [
          "data/Kalali/Kalali-Items.lua:gear.tp_bonus_dagger"
        ]
      },
      {
        "name": "Gleti's Knife",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:main"
        ]
      },
      {
        "name": "Gridarvor",
        "augments": [
          "Pet: Accuracy+70",
          "Pet: Attack+70",
          "Pet: \"Dbl. Atk.\"+15"
        ],
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:gear.malignance_pole",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.perp_staff",
          "data/Kalali/Kalali_Smn_Gear.lua:main"
        ]
      },
      {
        "name": "Grioavolr",
        "augments": [
          "DMG:+7",
          "Blood Pact Dmg.+7",
          "Pet: Mag. Acc.+23",
          "Pet: \"Mag.Atk.Bns.\"+23"
        ],
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:main"
        ]
      },
      {
        "name": "Idris",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:gear.idris",
          "data/Kalali/Kalali_Geo_Gear.lua:main"
        ]
      },
      {
        "name": "Kaja Knuckles",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:main"
        ]
      },
      {
        "name": "Kali",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:main"
        ]
      },
      {
        "name": "Lanun Knife",
        "augments": [
          "Path:A"
        ],
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:gear.jse_main_stp",
          "data/Kalali/Kalali_Cor_Gear.lua:main"
        ]
      },
      {
        "name": "Loxotic Mace +1",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:main"
        ]
      },
      {
        "name": "Machaera +2",
        "sources": [
          "data/Kalali/Kalali-Items.lua:gear.tp_bonus_sword"
        ]
      },
      {
        "name": "Maxentius",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:main",
          "data/Kalali/Kalali_Geo_Gear.lua:main",
          "data/Kalali/Kalali_Rdm_Gear.lua:main",
          "data/Kalali/Kalali_Sch_Gear.lua:main",
          "data/Kalali/Kalali_Smn_Gear.lua:main"
        ]
      },
      {
        "name": "Midnights",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:main"
        ]
      },
      {
        "name": "Mpaca's Staff",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:main",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.grioavolr_fc_staff",
          "data/Kalali/Kalali_Geo_Gear.lua:main",
          "data/Kalali/Kalali_Rdm_Gear.lua:main"
        ]
      },
      {
        "name": "Telopanos Staff",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:main"
        ]
      },
      {
        "name": "Musa",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:main"
        ]
      },
      {
        "name": "Naegling",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:main",
          "data/Kalali/Kalali_Brd_Gear.lua:main",
          "data/Kalali/Kalali_Cor_Gear.lua:main",
          "data/Kalali/Kalali_Rdm_Gear.lua:main",
          "data/Kalali/Kalali_War_Gear.lua:main"
        ]
      },
      {
        "name": "Pitre Fists",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:gear.dyna_weapon",
          "data/Kalali/Kalali_Pup_Gear.lua:main"
        ]
      },
      {
        "name": "Pukulatmuj +1",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:main",
          "data/Kalali/Kalali_Rdm_Gear.lua:main"
        ]
      },
      {
        "name": "Qutrub Knife",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:main"
        ]
      },
      {
        "name": "Rostam",
        "augments": [
          "Path:B"
        ],
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:gear.jse_main_ma",
          "data/Kalali/Kalali_Cor_Gear.lua:main"
        ]
      },
      {
        "name": "Rostam",
        "augments": [
          "Path:C"
        ],
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:gear.jse_main_roll",
          "data/Kalali/Kalali_Cor_Gear.lua:main"
        ]
      },
      {
        "name": "Sakpata's Sword",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:main",
          "data/Kalali/Kalali_Rdm_Gear.lua:main"
        ]
      },
      {
        "name": "Telopanos Saber",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:main",
          "data/Kalali/Kalali_Rdm_Gear.lua:main"
        ]
      },
      {
        "name": "Shining One",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:main"
        ]
      },
      {
        "name": "Tauret",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:main"
        ]
      },
      {
        "name": "Tizona",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:main"
        ]
      }
    ],
    "sub": [
      {
        "name": "Aegis",
        "sources": [
          "data/Kalali-PLD.lua:sub",
          "data/Kalali/Kalali_Pld_Gear.lua:sub"
        ]
      },
      {
        "name": "Ammurapi Shield",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:sub",
          "data/Kalali/Kalali_Geo_Gear.lua:sub",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.filler_shield",
          "data/Kalali/Kalali_Rdm_Gear.lua:sub",
          "data/Kalali/Kalali_Sch_Gear.lua:sub",
          "data/Kalali/Kalali_Smn_Gear.lua:sub"
        ]
      },
      {
        "name": "Archduke's Shield",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:sub",
          "data/Kalali/Kalali_Brd_Gear.lua:sub",
          "data/Kalali/Kalali_Rdm_Gear.lua:sub",
          "data/Kalali/Kalali_Sch_Gear.lua:sub"
        ]
      },
      {
        "name": "Blurred Shield +1",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:sub"
        ]
      },
      {
        "name": "Bunzi's Rod",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:sub",
          "data/Kalali/Kalali_Rdm_Gear.lua:sub"
        ]
      },
      {
        "name": "Culminus",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:sub",
          "data/Kalali/Kalali_Sch_Gear.lua:sub"
        ]
      },
      {
        "name": "Daybreak",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:sub",
          "data/Kalali/Kalali_Rdm_Gear.lua:sub"
        ]
      },
      {
        "name": "Duban",
        "sources": [
          "data/Kalali-PLD.lua:sub",
          "data/Kalali/Kalali_Pld_Gear.lua:sub"
        ]
      },
      {
        "name": "Egeking",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:sub"
        ]
      },
      {
        "name": "Genmei Shield",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:sub",
          "data/Kalali/Kalali_Brd_Gear.lua:sub"
        ]
      },
      {
        "name": "Elan Strap +1",
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:gear.bloodrain_strap",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.umbra_strap",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.vox_grip",
          "data/Kalali/Kalali_Smn_Gear.lua:sub"
        ]
      },
      {
        "name": "Ethereal Dagger",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:sub"
        ]
      },
      {
        "name": "Flametongue",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:sub"
        ]
      },
      {
        "name": "Telopanos Saber",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:sub",
          "data/Kalali/Kalali_Cor_Gear.lua:sub",
          "data/Kalali/Kalali_Rdm_Gear.lua:sub"
        ]
      },
      {
        "name": "Forfend +1",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:sub"
        ]
      },
      {
        "name": "Fusetto +2",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:sub"
        ]
      },
      {
        "name": "Gleti's Knife",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:sub",
          "data/Kalali/Kalali_Cor_Gear.lua:sub",
          "data/Kalali/Kalali_Rdm_Gear.lua:sub"
        ]
      },
      {
        "name": "Kali",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:sub"
        ]
      },
      {
        "name": "Khonsu",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:sub",
          "data/Kalali/Kalali_Sch_Gear.lua:sub"
        ]
      },
      {
        "name": "Machaera +2",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:sub",
          "data/Kalali/Kalali_Rdm_Gear.lua:sub"
        ]
      },
      {
        "name": "Maxentius",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:sub",
          "data/Kalali/Kalali_Rdm_Gear.lua:sub"
        ]
      },
      {
        "name": "Nusku Shield",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:sub"
        ]
      },
      {
        "name": "Priwen",
        "sources": [
          "data/Kalali-PLD.lua:sub",
          "data/Kalali/Kalali_Pld_Gear.lua:sub"
        ]
      },
      {
        "name": "Sacro Bulwark",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:sub"
        ]
      },
      {
        "name": "Sakpata's Sword",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:sub"
        ]
      },
      {
        "name": "Srivatsa",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:sub",
          "data/Kalali-PLD.lua:sets.shields.Srivatsa"
        ]
      },
      {
        "name": "Tauret",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:sub"
        ]
      },
      {
        "name": "Umbra Strap",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:sub",
          "data/Kalali/Kalali_Rdm_Gear.lua:sub"
        ]
      },
      {
        "name": "Utu Grip",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:sub"
        ]
      }
    ],
    "range": [
      {
        "name": "Anarchy +2",
        "sources": [
          "data/Kalali/Kalali-Items.lua:gear.tp_bonus_gun",
          "data/Kalali/Kalali_Cor_Gear.lua:range"
        ]
      },
      {
        "name": "Animator P +1",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:range"
        ]
      },
      {
        "name": "Animator P II +1",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:range"
        ]
      },
      {
        "name": "Compensator",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:range"
        ]
      },
      {
        "name": "Daurdabla",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.linos_fc",
          "data/Kalali/Kalali_Brd_Gear.lua:range"
        ]
      },
      {
        "name": "Death Penalty",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:range"
        ]
      },
      {
        "name": "Dunna",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:gear.geo_range",
          "data/Kalali/Kalali_Geo_Gear.lua:range"
        ]
      },
      {
        "name": "Fomalhaut",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:range"
        ]
      },
      {
        "name": "Gjallarhorn",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:range"
        ]
      },
      {
        "name": "Linos",
        "augments": [
          "Accuracy+19",
          "\"Store TP\"+4",
          "Quadruple Attack +3%"
        ],
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.linos_tp",
          "data/Kalali/Kalali_Brd_Gear.lua:range"
        ]
      },
      {
        "name": "Linos",
        "augments": [
          "CHR+8",
          "Attack+20",
          "Weapon skill damage +3%"
        ],
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.linos_chr_wsd",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.linos_fc",
          "data/Kalali/Kalali_Brd_Gear.lua:range"
        ]
      },
      {
        "name": "Linos",
        "augments": [
          "STR+8",
          "Attack+15",
          "Weapon skill damage +2%"
        ],
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.linos_str_wsd",
          "data/Kalali/Kalali_Brd_Gear.lua:range"
        ]
      },
      {
        "name": "Marsyas",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:range"
        ]
      },
      {
        "name": "Ullr",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:range"
        ]
      }
    ],
    "ammo": [
      {
        "name": "Aurgelmir Orb +1",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ammo",
          "data/Kalali/Kalali_Rdm_Gear.lua:ammo"
        ]
      },
      {
        "name": "Automat. Oil +3",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:ammo"
        ]
      },
      {
        "name": "Chrono Bullet",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:ammo",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.RAbullet",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.WSbullet"
        ]
      },
      {
        "name": "Coiste Bodhar",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:ammo",
          "data/Kalali/Kalali_War_Gear.lua:ammo",
          "data/Kalali/Kalali_War_Gear.lua:gear.tp_ammo"
        ]
      },
      {
        "name": "Crepuscular Pebble",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ammo",
          "data/Kalali/Kalali_Geo_Gear.lua:ammo",
          "data/Kalali/Kalali_Sch_Gear.lua:ammo",
          "data/Kalali/Kalali_Smn_Gear.lua:ammo"
        ]
      },
      {
        "name": "Ghastly Tathlum +1",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ammo",
          "data/Kalali/Kalali_Geo_Gear.lua:ammo",
          "data/Kalali/Kalali_Rdm_Gear.lua:ammo",
          "data/Kalali/Kalali_Sch_Gear.lua:ammo"
        ]
      },
      {
        "name": "Impatiens",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ammo",
          "data/Kalali/Kalali_Brd_Gear.lua:ammo",
          "data/Kalali/Kalali_Geo_Gear.lua:ammo",
          "data/Kalali/Kalali_Pup_Gear.lua:ammo",
          "data/Kalali/Kalali_Rdm_Gear.lua:ammo",
          "data/Kalali/Kalali_Sch_Gear.lua:ammo",
          "data/Kalali/Kalali_Smn_Gear.lua:ammo"
        ]
      },
      {
        "name": "Knobkierrie",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:ammo",
          "data/Kalali/Kalali_War_Gear.lua:gear.ws_ammo"
        ]
      },
      {
        "name": "Living Bullet",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:ammo",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.MAbullet",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.QDbullet"
        ]
      },
      {
        "name": "Oshasha's Treatise",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ammo",
          "data/Kalali/Kalali_Geo_Gear.lua:ammo",
          "data/Kalali/Kalali_Rdm_Gear.lua:ammo",
          "data/Kalali/Kalali_Sch_Gear.lua:ammo",
          "data/Kalali/Kalali_Smn_Gear.lua:ammo"
        ]
      },
      {
        "name": "Pemphredo Tathlum",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ammo",
          "data/Kalali/Kalali_Brd_Gear.lua:ammo",
          "data/Kalali/Kalali_Cor_Gear.lua:ammo",
          "data/Kalali/Kalali_Geo_Gear.lua:ammo",
          "data/Kalali/Kalali_Pup_Gear.lua:ammo",
          "data/Kalali/Kalali_Sch_Gear.lua:ammo",
          "data/Kalali/Kalali_War_Gear.lua:ammo"
        ]
      },
      {
        "name": "Perfect Lucky Egg",
        "sources": [
          "data/Kalali/Kalali-Items.lua:ammo"
        ]
      },
      {
        "name": "Regal Gem",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:ammo"
        ]
      },
      {
        "name": "Sancus Sachet +1",
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:ammo",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.esper_stone"
        ]
      },
      {
        "name": "Sroda Tathlum",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:ammo"
        ]
      },
      {
        "name": "Staunch Tathlum +1",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ammo",
          "data/Kalali/Kalali_Brd_Gear.lua:ammo",
          "data/Kalali/Kalali_Geo_Gear.lua:ammo",
          "data/Kalali/Kalali_Pup_Gear.lua:ammo",
          "data/Kalali/Kalali_Rdm_Gear.lua:ammo",
          "data/Kalali/Kalali_Sch_Gear.lua:ammo",
          "data/Kalali/Kalali_Smn_Gear.lua:ammo",
          "data/Kalali/Kalali_War_Gear.lua:ammo"
        ]
      }
    ],
    "head": [
      {
        "name": "Acad. Mortar. +3",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:gear.af1_head",
          "data/Kalali/Kalali_Sch_Gear.lua:head"
        ]
      },
      {
        "name": "Adhemar Bonnet +1",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:head"
        ]
      },
      {
        "name": "Agoge Mask +3",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.af2_head",
          "data/Kalali/Kalali_War_Gear.lua:gear.ws_wsd_head",
          "data/Kalali/Kalali_War_Gear.lua:head"
        ]
      },
      {
        "name": "Agoge Mask +4",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.af2_head",
          "data/Kalali/Kalali_War_Gear.lua:gear.ws_wsd_head",
          "data/Kalali/Kalali_War_Gear.lua:head"
        ]
      },
      {
        "name": "Amalric Coif +1",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:head",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.merlinic_nuke_head",
          "data/Kalali/Kalali_Geo_Gear.lua:head",
          "data/Kalali/Kalali_Rdm_Gear.lua:head",
          "data/Kalali/Kalali_Sch_Gear.lua:head"
        ]
      },
      {
        "name": "Apogee Crown +1",
        "augments": [
          "MP+80",
          "Pet: \"Mag.Atk.Bns.\"+35",
          "Blood Pact Dmg.+8"
        ],
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:gear.apogee_head_a",
          "data/Kalali/Kalali_Smn_Gear.lua:head"
        ]
      },
      {
        "name": "Apogee Crown +1",
        "augments": [
          "MP+80",
          "Pet: Attack+35",
          "Blood Pact Dmg.+8"
        ],
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:gear.apogee_head_b",
          "data/Kalali/Kalali_Smn_Gear.lua:head"
        ]
      },
      {
        "name": "Arbatel Bonnet +3",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:gear.af3_head",
          "data/Kalali/Kalali_Sch_Gear.lua:head"
        ]
      },
      {
        "name": "Atro. Chapeau +4",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af1_head",
          "data/Kalali/Kalali_Rdm_Gear.lua:head"
        ]
      },
      {
        "name": "Aya. Zucchetto +2",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:head"
        ]
      },
      {
        "name": "Azimuth Hood +2",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:gear.af3_head",
          "data/Kalali/Kalali_Geo_Gear.lua:head"
        ]
      },
      {
        "name": "Beckoner's Horn +2",
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:gear.af3_head",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.telchine_head",
          "data/Kalali/Kalali_Smn_Gear.lua:head"
        ]
      },
      {
        "name": "Befouled Crown",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:head"
        ]
      },
      {
        "name": "Boii Mask +2",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.af3_head",
          "data/Kalali/Kalali_War_Gear.lua:head"
        ]
      },
      {
        "name": "Brioso Roundlet +3",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.af1_head",
          "data/Kalali/Kalali_Brd_Gear.lua:head"
        ]
      },
      {
        "name": "Brioso Roundlet +4",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.af1_head",
          "data/Kalali/Kalali_Brd_Gear.lua:head"
        ]
      },
      {
        "name": "Bunzi's Hat",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:head",
          "data/Kalali/Kalali_Geo_Gear.lua:head",
          "data/Kalali/Kalali_Rdm_Gear.lua:head"
        ]
      },
      {
        "name": "Carmine Mask +1",
        "augments": [
          "Path:D"
        ],
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:gear.carmine_mask_d",
          "data/Kalali/Kalali_Blu_Gear.lua:head",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.carmine_mask_d",
          "data/Kalali/Kalali_Cor_Gear.lua:head"
        ]
      },
      {
        "name": "Cab. Coronet +3",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.af2_head",
          "data/Kalali/Kalali_Pld_Gear.lua:head",
          "user-confirmed:pld-new-gear"
        ]
      },
      {
        "name": "Chev. Armet +1",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.af3_head",
          "user-confirmed:pld-chev-armor-1"
        ]
      },
      {
        "name": "Fili Calot +2",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.af3_head",
          "data/Kalali/Kalali_Brd_Gear.lua:head"
        ]
      },
      {
        "name": "Flam. Zucchetto +2",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.flamma_head",
          "data/Kalali/Kalali_War_Gear.lua:head"
        ]
      },
      {
        "name": "Hashishin Kavuk +3",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:gear.af3_head",
          "data/Kalali/Kalali_Blu_Gear.lua:head"
        ]
      },
      {
        "name": "Hjarrandi Helm",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.hjarrandi_head",
          "data/Kalali/Kalali_War_Gear.lua:gear.sakpatas_head",
          "data/Kalali/Kalali_War_Gear.lua:head"
        ]
      },
      {
        "name": "Inyanga Tiara +2",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:head"
        ]
      },
      {
        "name": "Karagoz Cappello +2",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:gear.af3_head",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.mpaca_head",
          "data/Kalali/Kalali_Pup_Gear.lua:head"
        ]
      },
      {
        "name": "Kaykaus Mitra +1",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:head",
          "data/Kalali/Kalali_Rdm_Gear.lua:head",
          "data/Kalali/Kalali_Sch_Gear.lua:head"
        ]
      },
      {
        "name": "Lanun Tricorne +4",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:gear.af2_head",
          "data/Kalali/Kalali_Cor_Gear.lua:head"
        ]
      },
      {
        "name": "Leth. Chappel +3",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af3_head",
          "data/Kalali/Kalali_Rdm_Gear.lua:head"
        ]
      },
      {
        "name": "Malignance Chapeau",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:head",
          "data/Kalali/Kalali_Cor_Gear.lua:head",
          "data/Kalali/Kalali_Rdm_Gear.lua:head"
        ]
      },
      {
        "name": "Mall. Chapeau +2",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:head"
        ]
      },
      {
        "name": "Merlinic Hood",
        "augments": [
          "\"Mag.Atk.Bns.\"+24",
          "\"Occult Acumen\"+11",
          "CHR+2"
        ],
        "sources": [
          "data/Kalali/Kalali-Items.lua:gear.merlinic_oa_head",
          "data/Kalali/Kalali_Rdm_Gear.lua:head"
        ]
      },
      {
        "name": "Nyame Helm",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:head",
          "data/Kalali/Kalali_Brd_Gear.lua:head",
          "data/Kalali/Kalali_Cor_Gear.lua:head",
          "data/Kalali/Kalali_Geo_Gear.lua:head",
          "data/Kalali/Kalali_Pup_Gear.lua:head",
          "data/Kalali/Kalali_Rdm_Gear.lua:head",
          "data/Kalali/Kalali_Sch_Gear.lua:head",
          "data/Kalali/Kalali_Smn_Gear.lua:head",
          "data/Kalali/Kalali_War_Gear.lua:gear.nyame_head",
          "data/Kalali/Kalali_War_Gear.lua:head"
        ]
      },
      {
        "name": "Pedagogy Mortar. +3",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:gear.af2_head"
        ]
      },
      {
        "name": "Pixie Hairpin +1",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:head",
          "data/Kalali/Kalali_Cor_Gear.lua:head",
          "data/Kalali/Kalali_Geo_Gear.lua:head",
          "data/Kalali/Kalali_Rdm_Gear.lua:head",
          "data/Kalali/Kalali_Sch_Gear.lua:head"
        ]
      },
      {
        "name": "Sakpata's Helm",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:head"
        ]
      },
      {
        "name": "Souv. Schaller +1",
        "augments": [
          "HP+105",
          "Enmity+9",
          "Potency of \"Cure\" effect received +15%"
        ],
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.souv_head"
        ]
      },
      {
        "name": "Sworn Crown",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:head"
        ]
      },
      {
        "name": "Telchine Cap",
        "augments": [
          "Enhancing magic effect duration +10%"
        ],
        "sources": [
          "data/Kalali/Kalali-Items.lua:gear.telchine_enhancing_duration_head",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.telchine_cap",
          "data/Kalali/Kalali_Rdm_Gear.lua:head",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.enhancing_duration_head",
          "data/Kalali/Kalali_Sch_Gear.lua:head"
        ]
      },
      {
        "name": "Viti. Chapeau +4",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af2_head",
          "data/Kalali/Kalali_Rdm_Gear.lua:head"
        ]
      },
      {
        "name": "Wh. Rarab Cap +1",
        "sources": [
          "data/Kalali/Kalali-Items.lua:head"
        ]
      }
    ],
    "body": [
      {
        "name": "Acad. Gown +3",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:body",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.af1_body"
        ]
      },
      {
        "name": "Adhemar Jacket +1",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:body"
        ]
      },
      {
        "name": "Agoge Lorica +3",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:body",
          "data/Kalali/Kalali_War_Gear.lua:gear.af2_body",
          "data/Kalali/Kalali_War_Gear.lua:gear.sakpatas_body",
          "data/Kalali/Kalali_War_Gear.lua:gear.tp_body"
        ]
      },
      {
        "name": "Amalric Doublet +1",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:body"
        ]
      },
      {
        "name": "Arbatel Gown +3",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:body",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.af3_body"
        ]
      },
      {
        "name": "Assim. Jubbah +4",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:body",
          "data/Kalali/Kalali_Blu_Gear.lua:gear.af1_body"
        ]
      },
      {
        "name": "Atrophy Tabard +4",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:body",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af1_body"
        ]
      },
      {
        "name": "Ayanmo Corazza +2",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:body"
        ]
      },
      {
        "name": "Azimuth Coat +2",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:body",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.merlinic_nuke_body"
        ]
      },
      {
        "name": "Beckoner's Doublet +1",
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:gear.af3_body",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.baayami_body",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.telchine_body"
        ]
      },
      {
        "name": "Bihu Just. +4",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:body",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.af2_body"
        ]
      },
      {
        "name": "Boii Lorica +2",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:body",
          "data/Kalali/Kalali_War_Gear.lua:gear.af3_body",
          "data/Kalali/Kalali_War_Gear.lua:gear.great_axe_tp_body"
        ]
      },
      {
        "name": "Bunzi's Robe",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:body"
        ]
      },
      {
        "name": "Passion Jacket",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:body",
          "data/Kalali/Kalali_Cor_Gear.lua:body",
          "data/Kalali/Kalali_Pup_Gear.lua:body"
        ]
      },
      {
        "name": "Chasseur's Frac +2",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:body",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.af3_body"
        ]
      },
      {
        "name": "Convoker's Doublet +3",
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:body",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.af1_body"
        ]
      },
      {
        "name": "Crepuscular Cloak",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:body",
          "data/Kalali/Kalali_Sch_Gear.lua:body"
        ]
      },
      {
        "name": "Fili Hongreline +2",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:body",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.af3_body"
        ]
      },
      {
        "name": "Flamma Korazin +2",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:body",
          "data/Kalali/Kalali_War_Gear.lua:gear.flamma_body"
        ]
      },
      {
        "name": "Geomancy Tunic +2",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:body",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.af1_body"
        ]
      },
      {
        "name": "Gleti's Cuirass",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:body"
        ]
      },
      {
        "name": "Glyphic Doublet +3",
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:body",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.af2_body"
        ]
      },
      {
        "name": "Hashishin Mintan +2",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:body",
          "data/Kalali/Kalali_Blu_Gear.lua:gear.af3_body"
        ]
      },
      {
        "name": "Ikenga's Vest",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:body"
        ]
      },
      {
        "name": "Adamantite Armor",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:body",
          "data/Kalali/Kalali_Cor_Gear.lua:body",
          "data/Kalali/Kalali_Geo_Gear.lua:body",
          "data/Kalali/Kalali_Pld_Gear.lua:body",
          "data/Kalali/Kalali_Pup_Gear.lua:body",
          "data/Kalali/Kalali_Rdm_Gear.lua:body",
          "data/Kalali/Kalali_Sch_Gear.lua:body",
          "data/Kalali/Kalali_Smn_Gear.lua:body"
        ]
      },
      {
        "name": "Inyanga Jubbah +2",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:body"
        ]
      },
      {
        "name": "Rev. Surcoat +4",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.af1_body"
        ]
      },
      {
        "name": "Brioso Justau. +3",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.af1_body",
          "user-confirmed:brd-new-gear"
        ]
      },
      {
        "name": "Cab. Surcoat +1",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.af2_body",
          "data/Kalali/Kalali_Pld_Gear.lua:body",
          "user-confirmed:pld-new-gear"
        ]
      },
      {
        "name": "Chev. Cuirass +1",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.af3_body",
          "user-confirmed:pld-chev-armor-1"
        ]
      },
      {
        "name": "Karagoz Farsetto +2",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:body",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.af3_body",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.taeon_pet_body"
        ]
      },
      {
        "name": "Kaykaus Bliaut +1",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:body",
          "data/Kalali/Kalali_Rdm_Gear.lua:body",
          "data/Kalali/Kalali_Sch_Gear.lua:body"
        ]
      },
      {
        "name": "Laksa. Frac +4",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:body",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.af1_body"
        ]
      },
      {
        "name": "Lanun Frac +3",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:body",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.af2_body"
        ]
      },
      {
        "name": "Lanun Frac +4",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:body",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.af2_body"
        ]
      },
      {
        "name": "Lethargy Sayon +3",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:body",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af3_body"
        ]
      },
      {
        "name": "Malignance Tabard",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:body",
          "data/Kalali/Kalali_Cor_Gear.lua:body",
          "data/Kalali/Kalali_Geo_Gear.lua:body",
          "data/Kalali/Kalali_Rdm_Gear.lua:body"
        ]
      },
      {
        "name": "Merlinic Jubbah",
        "augments": [
          "Mag. Acc.+24",
          "\"Occult Acumen\"+11"
        ],
        "sources": [
          "data/Kalali/Kalali-Items.lua:gear.merlinic_oa_body",
          "data/Kalali/Kalali_Rdm_Gear.lua:body",
          "data/Kalali/Kalali_Smn_Gear.lua:body"
        ]
      },
      {
        "name": "Mou. Manteel +1",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:body"
        ]
      },
      {
        "name": "Nyame Mail",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:body",
          "data/Kalali/Kalali_Geo_Gear.lua:body",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.merlinic_nuke_body",
          "data/Kalali/Kalali_Pup_Gear.lua:body",
          "data/Kalali/Kalali_Rdm_Gear.lua:body",
          "data/Kalali/Kalali_Sch_Gear.lua:body",
          "data/Kalali/Kalali_Smn_Gear.lua:body",
          "data/Kalali/Kalali_War_Gear.lua:body",
          "data/Kalali/Kalali_War_Gear.lua:gear.nyame_body"
        ]
      },
      {
        "name": "Pedagogy Gown +3",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:body",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.af2_body"
        ]
      },
      {
        "name": "Pumm. Lorica +3",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:body",
          "data/Kalali/Kalali_War_Gear.lua:gear.af1_body",
          "data/Kalali/Kalali_War_Gear.lua:gear.ws_wsd_body"
        ]
      },
      {
        "name": "Pumm. Lorica +4",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:body",
          "data/Kalali/Kalali_War_Gear.lua:gear.ws_wsd_body"
        ]
      },
      {
        "name": "Sakpata's Plate",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:body"
        ]
      },
      {
        "name": "Shomonjijoe +1",
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:body"
        ]
      },
      {
        "name": "Souv. Cuirass +1",
        "augments": [
          "HP+105",
          "Enmity+9",
          "Potency of \"Cure\" effect received +15%"
        ],
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.souv_body"
        ]
      },
      {
        "name": "Sworn Platemail",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:body",
          "data/Kalali/Kalali_Rdm_Gear.lua:body"
        ]
      },
      {
        "name": "Viti. Tabard +3",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:body",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af2_body"
        ]
      },
      {
        "name": "Viti. Tabard +4",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:body",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af2_body"
        ]
      },
      {
        "name": "Vrikodara Jupon",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:body",
          "data/Kalali/Kalali_Geo_Gear.lua:body",
          "data/Kalali/Kalali_Sch_Gear.lua:body",
          "data/Kalali/Kalali_Smn_Gear.lua:body"
        ]
      }
    ],
    "hands": [
      {
        "name": "Acad. Bracers +3",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:gear.af1_hands",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.hieros_mittens",
          "data/Kalali/Kalali_Sch_Gear.lua:hands"
        ]
      },
      {
        "name": "Adhemar Wrist. +1",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:hands"
        ]
      },
      {
        "name": "Agoge Mufflers +1",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.af2_hands",
          "data/Kalali/Kalali_War_Gear.lua:hands"
        ]
      },
      {
        "name": "Arbatel Bracers +3",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:gear.af3_hands",
          "data/Kalali/Kalali_Sch_Gear.lua:hands"
        ]
      },
      {
        "name": "Asteria Mitts +1",
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:hands"
        ]
      },
      {
        "name": "Atro. Gloves +4",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af1_hands",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.hieros_mittens",
          "data/Kalali/Kalali_Rdm_Gear.lua:hands"
        ]
      },
      {
        "name": "Aya. Manopolas +2",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:hands"
        ]
      },
      {
        "name": "Azimuth Gloves +2",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:gear.af3_hands",
          "data/Kalali/Kalali_Geo_Gear.lua:hands"
        ]
      },
      {
        "name": "Boii Mufflers +2",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.af3_hands",
          "data/Kalali/Kalali_War_Gear.lua:gear.ws_wsd_hands",
          "data/Kalali/Kalali_War_Gear.lua:hands"
        ]
      },
      {
        "name": "Boii Mufflers +3",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.af3_hands",
          "data/Kalali/Kalali_War_Gear.lua:gear.ws_wsd_hands",
          "data/Kalali/Kalali_War_Gear.lua:hands"
        ]
      },
      {
        "name": "Bunzi's Gloves",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:hands",
          "data/Kalali/Kalali_Rdm_Gear.lua:hands"
        ]
      },
      {
        "name": "Chasseur's Gants +3",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:gear.af3_hands",
          "data/Kalali/Kalali_Cor_Gear.lua:hands"
        ]
      },
      {
        "name": "Cab. Gauntlets +4",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.af2_hands",
          "data/Kalali/Kalali_Pld_Gear.lua:hands",
          "user-confirmed:pld-new-gear"
        ]
      },
      {
        "name": "Brioso Cuffs +3",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.af1_hands",
          "user-confirmed:brd-new-gear"
        ]
      },
      {
        "name": "Chev. Gauntlets +1",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.af3_hands",
          "user-confirmed:pld-chev-armor-1"
        ]
      },
      {
        "name": "Fili Manchettes +2",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.af3_hands",
          "data/Kalali/Kalali_Brd_Gear.lua:hands"
        ]
      },
      {
        "name": "Flam. Manopolas +2",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.flamma_hands",
          "data/Kalali/Kalali_War_Gear.lua:hands"
        ]
      },
      {
        "name": "Geo. Mitaines +2",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:gear.af1_hands",
          "data/Kalali/Kalali_Geo_Gear.lua:hands"
        ]
      },
      {
        "name": "Gleti's Gauntlets",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:hands"
        ]
      },
      {
        "name": "Hashi. Bazu. +2",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:gear.af3_hands",
          "data/Kalali/Kalali_Blu_Gear.lua:hands"
        ]
      },
      {
        "name": "Inyan. Dastanas +2",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.hieros_mittens",
          "data/Kalali/Kalali_Brd_Gear.lua:hands"
        ]
      },
      {
        "name": "Jhakri Cuffs +2",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:hands",
          "data/Kalali/Kalali_Geo_Gear.lua:hands",
          "data/Kalali/Kalali_Rdm_Gear.lua:hands",
          "data/Kalali/Kalali_Sch_Gear.lua:hands"
        ]
      },
      {
        "name": "Karagoz Guanti +2",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:gear.af3_hands",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.mpaca_hands",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.regimen_mittens",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.taeon_pet_hands",
          "data/Kalali/Kalali_Pup_Gear.lua:hands"
        ]
      },
      {
        "name": "Kaykaus Cuffs +1",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:hands",
          "data/Kalali/Kalali_Rdm_Gear.lua:hands",
          "data/Kalali/Kalali_Sch_Gear.lua:hands"
        ]
      },
      {
        "name": "Lamassu Mitts +1",
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:gear.baayami_hands",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.telchine_hands",
          "data/Kalali/Kalali_Smn_Gear.lua:hands"
        ]
      },
      {
        "name": "Lanun Gants +4",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:gear.af2_hands",
          "data/Kalali/Kalali_Cor_Gear.lua:hands"
        ]
      },
      {
        "name": "Leth. Ganth. +3",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af3_hands",
          "data/Kalali/Kalali_Rdm_Gear.lua:hands"
        ]
      },
      {
        "name": "Magus Bazubands",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:gear.af1_hands",
          "data/Kalali/Kalali_Blu_Gear.lua:hands"
        ]
      },
      {
        "name": "Malignance Gloves",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:hands",
          "data/Kalali/Kalali_Cor_Gear.lua:hands",
          "data/Kalali/Kalali_Geo_Gear.lua:hands",
          "data/Kalali/Kalali_Rdm_Gear.lua:hands"
        ]
      },
      {
        "name": "Mousai Gages +1",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:hands"
        ]
      },
      {
        "name": "Merlinic Dastanas",
        "augments": [
          "\"Occult Acumen\"+11",
          "INT+8",
          "\"Mag.Atk.Bns.\"+14"
        ],
        "sources": [
          "data/Kalali/Kalali-Items.lua:gear.merlinic_oa_hands",
          "data/Kalali/Kalali_Rdm_Gear.lua:hands"
        ]
      },
      {
        "name": "Merlinic Dastanas",
        "augments": [
          "Blood Pact Dmg.+10",
          "Pet: STR+2",
          "Pet: \"Mag.Atk.Bns.\"+3"
        ],
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:gear.merlinic_bp_hands",
          "data/Kalali/Kalali_Smn_Gear.lua:hands"
        ]
      },
      {
        "name": "Nyame Gauntlets",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:hands",
          "data/Kalali/Kalali_Brd_Gear.lua:hands",
          "data/Kalali/Kalali_Cor_Gear.lua:hands",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.chironic_refresh_hands",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.merlinic_refresh_hands",
          "data/Kalali/Kalali_Geo_Gear.lua:hands",
          "data/Kalali/Kalali_Pup_Gear.lua:hands",
          "data/Kalali/Kalali_Rdm_Gear.lua:hands",
          "data/Kalali/Kalali_Sch_Gear.lua:hands",
          "data/Kalali/Kalali_Smn_Gear.lua:hands",
          "data/Kalali/Kalali_War_Gear.lua:gear.nyame_hands",
          "data/Kalali/Kalali_War_Gear.lua:hands"
        ]
      },
      {
        "name": "Pedagogy Bracers +3",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:gear.af2_hands"
        ]
      },
      {
        "name": "Regal Cuffs",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:hands",
          "data/Kalali/Kalali_Geo_Gear.lua:hands",
          "data/Kalali/Kalali_Rdm_Gear.lua:hands"
        ]
      },
      {
        "name": "Sakpata's Gauntlets",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.sakpatas_hands",
          "data/Kalali/Kalali_War_Gear.lua:hands"
        ]
      },
      {
        "name": "Souv. Handsch. +1",
        "augments": [
          "HP+105",
          "Enmity+9",
          "Potency of \"Cure\" effect received +15%"
        ],
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.souv_hands_c"
        ]
      },
      {
        "name": "Souv. Handsch. +1",
        "augments": [
          "HP+65",
          "Shield skill +15",
          "Phys. dmg. taken -4"
        ],
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.souv_hands_d"
        ]
      },
      {
        "name": "Viti. Gloves +4",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af2_hands",
          "data/Kalali/Kalali_Rdm_Gear.lua:hands"
        ]
      }
    ],
    "legs": [
      {
        "name": "Acad. Pants +3",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:gear.af1_legs",
          "data/Kalali/Kalali_Sch_Gear.lua:legs"
        ]
      },
      {
        "name": "Adhemar Kecks +1",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:legs"
        ]
      },
      {
        "name": "Apogee Slacks +1",
        "augments": [
          "MP+80",
          "Pet: \"Mag.Atk.Bns.\"+35",
          "Blood Pact Dmg.+8"
        ],
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:gear.apogee_legs_a",
          "data/Kalali/Kalali_Smn_Gear.lua:legs"
        ]
      },
      {
        "name": "Apogee Slacks +1",
        "augments": [
          "Pet: STR+20",
          "Blood Pact Dmg.+14",
          "Pet: \"Dbl. Atk.\"+4"
        ],
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:gear.apogee_legs_d",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.baayami_legs",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.telchine_legs",
          "data/Kalali/Kalali_Smn_Gear.lua:legs"
        ]
      },
      {
        "name": "Arbatel Pants +3",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:gear.af3_legs",
          "data/Kalali/Kalali_Sch_Gear.lua:legs"
        ]
      },
      {
        "name": "Atro. Tights +4",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af1_legs",
          "data/Kalali/Kalali_Rdm_Gear.lua:legs"
        ]
      },
      {
        "name": "Aya. Cosciales +2",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:legs"
        ]
      },
      {
        "name": "Azimuth Tights +2",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:gear.af3_legs",
          "data/Kalali/Kalali_Geo_Gear.lua:legs"
        ]
      },
      {
        "name": "Bagua Pants +3",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:gear.af2_legs",
          "data/Kalali/Kalali_Geo_Gear.lua:legs"
        ]
      },
      {
        "name": "Cab. Breeches +1",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.af2_legs",
          "data/Kalali/Kalali_Pld_Gear.lua:legs",
          "user-confirmed:pld-new-gear"
        ]
      },
      {
        "name": "Brioso Cannions +3",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.af1_legs",
          "user-confirmed:brd-new-gear"
        ]
      },
      {
        "name": "Chev. Cuisses +1",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.af3_legs",
          "user-confirmed:pld-chev-armor-1"
        ]
      },
      {
        "name": "Boii Cuisses +2",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.af3_legs",
          "data/Kalali/Kalali_War_Gear.lua:legs"
        ]
      },
      {
        "name": "Boii Cuisses +3",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.af3_legs",
          "data/Kalali/Kalali_War_Gear.lua:legs"
        ]
      },
      {
        "name": "Bunzi's Pants",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:legs"
        ]
      },
      {
        "name": "Chironic Hose",
        "augments": [
          "CHR+6",
          "Mag. Acc.+40",
          "Haste+1%",
          "\"Mag. Atk. Bns.\"+25"
        ],
        "sources": [
          "data/Kalali/Kalali-Items.lua:gear.chironic_macc_legs",
          "data/Kalali/Kalali_Rdm_Gear.lua:legs"
        ]
      },
      {
        "name": "Dashing Subligar",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:legs",
          "data/Kalali/Kalali_Brd_Gear.lua:legs",
          "data/Kalali/Kalali_Cor_Gear.lua:legs",
          "data/Kalali/Kalali_Pld_Gear.lua:legs",
          "data/Kalali/Kalali_Rdm_Gear.lua:legs",
          "data/Kalali/Kalali_War_Gear.lua:legs"
        ]
      },
      {
        "name": "Desultor Tassets",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:legs"
        ]
      },
      {
        "name": "Founder's Hose",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:legs"
        ]
      },
      {
        "name": "Fili Rhingrave +2",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.af3_legs",
          "data/Kalali/Kalali_Brd_Gear.lua:legs"
        ]
      },
      {
        "name": "Flamma Dirs +2",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.flamma_legs",
          "data/Kalali/Kalali_War_Gear.lua:legs"
        ]
      },
      {
        "name": "Gleti's Breeches",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:legs"
        ]
      },
      {
        "name": "Hashishin Tayt +2",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:gear.af3_legs",
          "data/Kalali/Kalali_Blu_Gear.lua:legs"
        ]
      },
      {
        "name": "Inyanga Shalwar +2",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:legs"
        ]
      },
      {
        "name": "Karagoz Pantaloni +2",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:gear.af3_legs",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.taliah_pet_legs",
          "data/Kalali/Kalali_Pup_Gear.lua:legs"
        ]
      },
      {
        "name": "Kaykaus Tights +1",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:legs",
          "data/Kalali/Kalali_Geo_Gear.lua:legs",
          "data/Kalali/Kalali_Rdm_Gear.lua:legs",
          "data/Kalali/Kalali_Sch_Gear.lua:legs"
        ]
      },
      {
        "name": "Kaykaus tights +1",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:legs"
        ]
      },
      {
        "name": "Leth. Fuseau +3",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af3_legs",
          "data/Kalali/Kalali_Rdm_Gear.lua:legs"
        ]
      },
      {
        "name": "Luh. Shalwar +4",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:gear.af2_legs",
          "data/Kalali/Kalali_Blu_Gear.lua:legs"
        ]
      },
      {
        "name": "Malignance Tights",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:legs",
          "data/Kalali/Kalali_Cor_Gear.lua:legs",
          "data/Kalali/Kalali_Geo_Gear.lua:legs",
          "data/Kalali/Kalali_Rdm_Gear.lua:legs"
        ]
      },
      {
        "name": "Nyame Flanchard",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:legs",
          "data/Kalali/Kalali_Brd_Gear.lua:legs",
          "data/Kalali/Kalali_Cor_Gear.lua:legs",
          "data/Kalali/Kalali_Geo_Gear.lua:legs",
          "data/Kalali/Kalali_Pup_Gear.lua:legs",
          "data/Kalali/Kalali_Rdm_Gear.lua:legs",
          "data/Kalali/Kalali_Sch_Gear.lua:legs",
          "data/Kalali/Kalali_Smn_Gear.lua:legs",
          "data/Kalali/Kalali_War_Gear.lua:gear.nyame_legs",
          "data/Kalali/Kalali_War_Gear.lua:gear.sakpatas_legs",
          "data/Kalali/Kalali_War_Gear.lua:legs"
        ]
      },
      {
        "name": "Pedagogy Pants +3",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:gear.af2_legs",
          "data/Kalali/Kalali_Sch_Gear.lua:legs"
        ]
      },
      {
        "name": "Perdition Slops",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:legs",
          "data/Kalali/Kalali_Smn_Gear.lua:legs"
        ]
      },
      {
        "name": "Pumm. Cuisses +4",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.af1_legs",
          "data/Kalali/Kalali_War_Gear.lua:legs"
        ]
      },
      {
        "name": "Sakpata's Cuisses",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:legs"
        ]
      },
      {
        "name": "Souv. Diechlings +1",
        "augments": [
          "HP+105",
          "Enmity+9",
          "Potency of \"Cure\" effect received +15%"
        ],
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.souv_legs",
          "data/Kalali/Kalali_Pld_Gear.lua:legs"
        ]
      },
      {
        "name": "Shedir Seraweels",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:legs",
          "data/Kalali/Kalali_Geo_Gear.lua:legs",
          "data/Kalali/Kalali_Rdm_Gear.lua:legs"
        ]
      },
      {
        "name": "Sworn Brais",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:legs",
          "data/Kalali/Kalali_Rdm_Gear.lua:legs"
        ]
      },
      {
        "name": "Volte Tights",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:legs"
        ]
      }
    ],
    "feet": [
      {
        "name": "Acad. Loafers +3",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:feet",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.af1_feet"
        ]
      },
      {
        "name": "Agoge Calligae +3",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:feet",
          "data/Kalali/Kalali_War_Gear.lua:gear.af2_feet"
        ]
      },
      {
        "name": "Amalric Nails +1",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:feet",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.merlinic_aspir_feet",
          "data/Kalali/Kalali_Sch_Gear.lua:feet"
        ]
      },
      {
        "name": "Apogee Pumps +1",
        "augments": [
          "MP+80",
          "Pet: \"Mag.Atk.Bns.\"+35",
          "Blood Pact Dmg.+8"
        ],
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:feet",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.apogee_feet_a"
        ]
      },
      {
        "name": "Apogee Pumps +1",
        "augments": [
          "MP+80",
          "Pet: Attack+35",
          "Blood Pact Dmg.+8"
        ],
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:feet",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.apogee_feet_b",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.baayami_feet",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.telchine_feet"
        ]
      },
      {
        "name": "Arbatel Loafers +3",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:feet",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.af3_feet"
        ]
      },
      {
        "name": "Atro. Boots +4",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:feet",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af1_feet"
        ]
      },
      {
        "name": "Azimuth Gaiters +2",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:feet",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.af3_feet"
        ]
      },
      {
        "name": "Bagua Sandals +3",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:feet",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.af2_feet"
        ]
      },
      {
        "name": "Bihu Slippers +1",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:feet",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.af2_feet"
        ]
      },
      {
        "name": "Cab. Leggings +3",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.af2_feet",
          "data/Kalali/Kalali_Pld_Gear.lua:feet",
          "user-confirmed:pld-new-gear"
        ]
      },
      {
        "name": "Chev. Sabatons +1",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.af3_feet",
          "user-confirmed:pld-chev-armor-1"
        ]
      },
      {
        "name": "Brioso Slippers +3",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:feet",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.af1_feet"
        ]
      },
      {
        "name": "Brioso Slippers +4",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:feet",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.af1_feet"
        ]
      },
      {
        "name": "Bunzi's Sabots",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:feet"
        ]
      },
      {
        "name": "Fili Cothurnes +2",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:feet",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.af3_feet"
        ]
      },
      {
        "name": "Flam. Gambieras +2",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:feet",
          "data/Kalali/Kalali_War_Gear.lua:gear.flamma_feet"
        ]
      },
      {
        "name": "Hashi. Basmak +2",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:feet",
          "data/Kalali/Kalali_Blu_Gear.lua:gear.af3_feet"
        ]
      },
      {
        "name": "Herculean Boots",
        "augments": [
          "Accuracy+12 Attack+27",
          "\"Triple Atk.\"+4%",
          "AGI+6"
        ],
        "sources": [
          "data/Kalali/Kalali-Items.lua:gear.herculean_ta_feet"
        ]
      },
      {
        "name": "Karagoz Scarpe +2",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:feet",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.af3_feet",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.mpaca_feet",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.taeon_pet_feet"
        ]
      },
      {
        "name": "Kaykaus Boots +1",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:feet",
          "data/Kalali/Kalali_Geo_Gear.lua:feet",
          "data/Kalali/Kalali_Rdm_Gear.lua:feet",
          "data/Kalali/Kalali_Sch_Gear.lua:feet"
        ]
      },
      {
        "name": "Lanun Bottes +4",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:feet",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.af2_feet"
        ]
      },
      {
        "name": "Leth. Houseaux +3",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:feet",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af3_feet"
        ]
      },
      {
        "name": "Malignance Boots",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:feet",
          "data/Kalali/Kalali_Cor_Gear.lua:feet",
          "data/Kalali/Kalali_Geo_Gear.lua:feet",
          "data/Kalali/Kalali_Rdm_Gear.lua:feet"
        ]
      },
      {
        "name": "Meg. Jam. +2",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:feet"
        ]
      },
      {
        "name": "Merlinic Crackows",
        "augments": [
          "INT+1",
          "Mag. Acc.+8",
          "\"Mag.Atk.Bns.\"+12",
          "\"Occult Acumen\"+11"
        ],
        "sources": [
          "data/Kalali/Kalali-Items.lua:gear.merlinic_oa_feet",
          "data/Kalali/Kalali_Rdm_Gear.lua:feet",
          "data/Kalali/Kalali_Smn_Gear.lua:feet"
        ]
      },
      {
        "name": "Nyame Sollerets",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:feet",
          "data/Kalali/Kalali_Brd_Gear.lua:feet",
          "data/Kalali/Kalali_Cor_Gear.lua:feet",
          "data/Kalali/Kalali_Geo_Gear.lua:feet",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.chironic_refresh_feet",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.merlinic_refresh_feet",
          "data/Kalali/Kalali_Pup_Gear.lua:feet",
          "data/Kalali/Kalali_Rdm_Gear.lua:feet",
          "data/Kalali/Kalali_Sch_Gear.lua:feet",
          "data/Kalali/Kalali_Smn_Gear.lua:feet",
          "data/Kalali/Kalali_Pld_Gear.lua:feet",
          "data/Kalali/Kalali_War_Gear.lua:feet",
          "data/Kalali/Kalali_War_Gear.lua:gear.nyame_feet",
          "data/Kalali/Kalali_War_Gear.lua:gear.sakpatas_feet"
        ]
      },
      {
        "name": "Odyssean Greaves",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:feet",
          "user-confirmed:pld-new-gear"
        ]
      },
      {
        "name": "Pumm. Calligae +4",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:feet",
          "data/Kalali/Kalali_War_Gear.lua:gear.af1_feet"
        ]
      },
      {
        "name": "Sakpata's Leggings",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:feet"
        ]
      },
      {
        "name": "Souveran Schuhs +1",
        "augments": [
          "HP+105",
          "Enmity+9",
          "Potency of \"Cure\" effect received +15%"
        ],
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.souv_feet",
          "data/Kalali/Kalali_Pld_Gear.lua:feet"
        ]
      },
      {
        "name": "Sworn Sabatons",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:feet",
          "data/Kalali/Kalali_Rdm_Gear.lua:feet"
        ]
      },
      {
        "name": "Vanya Clogs",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:feet",
          "data/Kalali/Kalali_Geo_Gear.lua:feet",
          "data/Kalali/Kalali_Rdm_Gear.lua:feet",
          "data/Kalali/Kalali_Sch_Gear.lua:feet",
          "data/Kalali/Kalali_Smn_Gear.lua:feet"
        ]
      },
      {
        "name": "Vitiation Boots +4",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:feet",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.af2_feet"
        ]
      }
    ],
    "neck": [
      {
        "name": "Adad Amulet",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:neck",
          "data/Kalali/Kalali_Smn_Gear.lua:neck"
        ]
      },
      {
        "name": "Argute Stole +2",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:gear.jse_neck",
          "data/Kalali/Kalali_Sch_Gear.lua:neck"
        ]
      },
      {
        "name": "Bagua Charm +2",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:gear.geo_neck",
          "data/Kalali/Kalali_Geo_Gear.lua:neck"
        ]
      },
      {
        "name": "Bard's Charm +2",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.baetyl_pendant",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.jse_neck",
          "data/Kalali/Kalali_Brd_Gear.lua:neck"
        ]
      },
      {
        "name": "Bathy Choker",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:neck"
        ]
      },
      {
        "name": "Caller's Pendant",
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:neck"
        ]
      },
      {
        "name": "Comm. Charm +2",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:gear.jse_neck",
          "data/Kalali/Kalali_Cor_Gear.lua:neck"
        ]
      },
      {
        "name": "Debilis Medallion",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:neck",
          "data/Kalali/Kalali_Rdm_Gear.lua:neck",
          "data/Kalali/Kalali_Sch_Gear.lua:neck"
        ]
      },
      {
        "name": "Dls. Torque +2",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.baetyl_pendant",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.jse_neck",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.ournmilas_torque",
          "data/Kalali/Kalali_Rdm_Gear.lua:neck"
        ]
      },
      {
        "name": "Elite Royal Collar",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.elite_royal_collar",
          "data/Kalali/Kalali_Pld_Gear.lua:neck"
        ]
      },
      {
        "name": "Erra Pendant",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:neck",
          "data/Kalali/Kalali_Rdm_Gear.lua:neck",
          "data/Kalali/Kalali_Sch_Gear.lua:neck"
        ]
      },
      {
        "name": "Fotia Gorget",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:neck",
          "data/Kalali/Kalali_Cor_Gear.lua:neck",
          "data/Kalali/Kalali_Pup_Gear.lua:neck",
          "data/Kalali/Kalali_Rdm_Gear.lua:neck",
          "data/Kalali/Kalali_Smn_Gear.lua:neck"
        ]
      },
      {
        "name": "Hoxne Torque",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:neck",
          "data/Kalali/Kalali_Brd_Gear.lua:neck",
          "data/Kalali/Kalali_Geo_Gear.lua:neck",
          "data/Kalali/Kalali_Rdm_Gear.lua:neck",
          "data/Kalali/Kalali_Sch_Gear.lua:neck",
          "data/Kalali/Kalali_Smn_Gear.lua:neck"
        ]
      },
      {
        "name": "Incanter's Torque",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:neck",
          "data/Kalali/Kalali_Cor_Gear.lua:neck",
          "data/Kalali/Kalali_Pup_Gear.lua:neck",
          "data/Kalali/Kalali_War_Gear.lua:neck"
        ]
      },
      {
        "name": "Kgt. Beads +2",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:neck"
        ]
      },
      {
        "name": "Loricate Torque +1",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:neck",
          "data/Kalali/Kalali_Brd_Gear.lua:neck",
          "data/Kalali/Kalali_Cor_Gear.lua:neck",
          "data/Kalali/Kalali_Geo_Gear.lua:neck",
          "data/Kalali/Kalali_Pup_Gear.lua:neck",
          "data/Kalali/Kalali_Rdm_Gear.lua:neck",
          "data/Kalali/Kalali_Sch_Gear.lua:neck",
          "data/Kalali/Kalali_Smn_Gear.lua:neck",
          "data/Kalali/Kalali_War_Gear.lua:neck"
        ]
      },
      {
        "name": "Moonlight Necklace",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:neck"
        ]
      },
      {
        "name": "Mirage Stole +2",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:gear.jse_neck",
          "data/Kalali/Kalali_Blu_Gear.lua:neck"
        ]
      },
      {
        "name": "Mizu. Kubikazari",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:neck",
          "data/Kalali/Kalali_Rdm_Gear.lua:neck"
        ]
      },
      {
        "name": "Mizukage-no-Kubikazari",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:neck"
        ]
      },
      {
        "name": "Mnbw. Whistle +1",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:neck"
        ]
      },
      {
        "name": "Nicander's Necklace",
        "sources": [
          "data/Kalali/Kalali-Items.lua:neck"
        ]
      },
      {
        "name": "Nodens Gorget",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:neck",
          "data/Kalali/Kalali_Brd_Gear.lua:neck",
          "data/Kalali/Kalali_Geo_Gear.lua:neck",
          "data/Kalali/Kalali_Pld_Gear.lua:neck",
          "data/Kalali/Kalali_Rdm_Gear.lua:neck",
          "data/Kalali/Kalali_Sch_Gear.lua:neck",
          "data/Kalali/Kalali_Smn_Gear.lua:neck"
        ]
      },
      {
        "name": "Null Loop",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:neck",
          "data/Kalali/Kalali_Brd_Gear.lua:neck",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.iskur_gorget",
          "data/Kalali/Kalali_Cor_Gear.lua:neck",
          "data/Kalali/Kalali_Geo_Gear.lua:neck",
          "data/Kalali/Kalali_Pup_Gear.lua:neck",
          "data/Kalali/Kalali_Rdm_Gear.lua:neck",
          "data/Kalali/Kalali_Sch_Gear.lua:neck",
          "data/Kalali/Kalali_Smn_Gear.lua:neck",
          "data/Kalali/Kalali_War_Gear.lua:neck"
        ]
      },
      {
        "name": "Puppetmaster's Collar +1",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:gear.buffoons_collar",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.jse_neck",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.shulmanu_collar",
          "data/Kalali/Kalali_Pup_Gear.lua:neck"
        ]
      },
      {
        "name": "Rep. Plat. Medal",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:neck",
          "data/Kalali/Kalali_Rdm_Gear.lua:neck",
          "data/Kalali/Kalali_Sch_Gear.lua:neck"
        ]
      },
      {
        "name": "Sibyl Scarf",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:neck",
          "data/Kalali/Kalali_Cor_Gear.lua:neck",
          "data/Kalali/Kalali_Geo_Gear.lua:neck",
          "data/Kalali/Kalali_Rdm_Gear.lua:neck",
          "data/Kalali/Kalali_Sch_Gear.lua:neck"
        ]
      },
      {
        "name": "Sroda Necklace",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:neck"
        ]
      },
      {
        "name": "Summoner's Collar +1",
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:gear.jse_neck",
          "data/Kalali/Kalali_Smn_Gear.lua:neck"
        ]
      },
      {
        "name": "Voltsurge Torque",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:neck",
          "data/Kalali/Kalali_Brd_Gear.lua:neck",
          "data/Kalali/Kalali_Geo_Gear.lua:neck",
          "data/Kalali/Kalali_Pup_Gear.lua:neck",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.orunmilas_torque",
          "data/Kalali/Kalali_Sch_Gear.lua:neck",
          "data/Kalali/Kalali_Smn_Gear.lua:neck"
        ]
      },
      {
        "name": "War. Beads +1",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:gear.jse_neck",
          "data/Kalali/Kalali_War_Gear.lua:neck"
        ]
      },
      {
        "name": "Warder's Charm +1",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:neck",
          "data/Kalali/Kalali_Pup_Gear.lua:neck",
          "data/Kalali/Kalali_Rdm_Gear.lua:neck",
          "data/Kalali/Kalali_Sch_Gear.lua:neck",
          "data/Kalali/Kalali_Smn_Gear.lua:neck",
          "data/Kalali/Kalali_War_Gear.lua:neck"
        ]
      }
    ],
    "waist": [
      {
        "name": "Acuity Belt +1",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:waist",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.obi_high_nuke_waist",
          "data/Kalali/Kalali_Geo_Gear.lua:waist",
          "data/Kalali/Kalali_Rdm_Gear.lua:waist",
          "data/Kalali/Kalali_Sch_Gear.lua:waist"
        ]
      },
      {
        "name": "Audumbla Sash",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:waist"
        ]
      },
      {
        "name": "Carrier's Sash",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:waist"
        ]
      },
      {
        "name": "Chaac Belt",
        "sources": [
          "data/Kalali/Kalali-Items.lua:waist"
        ]
      },
      {
        "name": "Embla Sash",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.luminary_sash",
          "data/Kalali/Kalali_Brd_Gear.lua:waist",
          "data/Kalali/Kalali_Geo_Gear.lua:waist",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.bishops_sash",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.luminary_sash",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.obstinate_sash",
          "data/Kalali/Kalali_Rdm_Gear.lua:waist",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.bishops_sash",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.luminary_sash",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.obstinate_sash",
          "data/Kalali/Kalali_Sch_Gear.lua:waist",
          "data/Kalali/Kalali_Smn_Gear.lua:waist"
        ]
      },
      {
        "name": "Emphatikos Rope",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:waist",
          "data/Kalali/Kalali_Geo_Gear.lua:waist",
          "data/Kalali/Kalali_Rdm_Gear.lua:waist",
          "data/Kalali/Kalali_Sch_Gear.lua:waist"
        ]
      },
      {
        "name": "Eschan Stone",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.fuchonoobi",
          "data/Kalali/Kalali_Cor_Gear.lua:waist",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.fuchonoobi",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.sacro_cord",
          "data/Kalali/Kalali_Rdm_Gear.lua:waist",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.fuchonoobi",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.sacro_cord",
          "data/Kalali/Kalali_Sch_Gear.lua:waist"
        ]
      },
      {
        "name": "Flume Belt +1",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:waist",
          "data/Kalali/Kalali_Brd_Gear.lua:waist"
        ]
      },
      {
        "name": "Fotia Belt",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:waist",
          "data/Kalali/Kalali_Cor_Gear.lua:waist",
          "data/Kalali/Kalali_Geo_Gear.lua:waist",
          "data/Kalali/Kalali_Pup_Gear.lua:waist",
          "data/Kalali/Kalali_Rdm_Gear.lua:waist",
          "data/Kalali/Kalali_Smn_Gear.lua:waist"
        ]
      },
      {
        "name": "Fucho-no-obi",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:waist"
        ]
      },
      {
        "name": "Gishdubar Sash",
        "sources": [
          "data/Kalali/Kalali-Items.lua:waist",
          "data/Kalali/Kalali_Blu_Gear.lua:waist",
          "data/Kalali/Kalali_Brd_Gear.lua:waist",
          "data/Kalali/Kalali_Cor_Gear.lua:waist",
          "data/Kalali/Kalali_Geo_Gear.lua:waist",
          "data/Kalali/Kalali_Rdm_Gear.lua:waist",
          "data/Kalali/Kalali_Sch_Gear.lua:waist",
          "data/Kalali/Kalali_Smn_Gear.lua:waist",
          "data/Kalali/Kalali_War_Gear.lua:waist"
        ]
      },
      {
        "name": "Hachirin-no-Obi",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:gear.ElementalObi",
          "data/Kalali/Kalali_Geo_Gear.lua:waist",
          "data/Kalali/Kalali_Rdm_Gear.lua:waist",
          "data/Kalali/Kalali_Sch_Gear.lua:waist"
        ]
      },
      {
        "name": "Incarnation Sash",
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:gear.incarnation_sash",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.klouskap_sash",
          "data/Kalali/Kalali_Pup_Gear.lua:waist",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.incarnation_sash",
          "data/Kalali/Kalali_Smn_Gear.lua:waist"
        ]
      },
      {
        "name": "Ioskeha Belt +1",
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:waist"
        ]
      },
      {
        "name": "Null Belt",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:gear.luminary_sash",
          "data/Kalali/Kalali_Blu_Gear.lua:waist",
          "data/Kalali/Kalali_Brd_Gear.lua:waist",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.yemaya_belt",
          "data/Kalali/Kalali_Cor_Gear.lua:waist",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.obi_low_nuke_waist",
          "data/Kalali/Kalali_Geo_Gear.lua:waist",
          "data/Kalali/Kalali_Pup_Gear.lua:waist",
          "data/Kalali/Kalali_Rdm_Gear.lua:waist",
          "data/Kalali/Kalali_Sch_Gear.lua:waist",
          "data/Kalali/Kalali_Smn_Gear.lua:waist",
          "data/Kalali/Kalali_War_Gear.lua:waist"
        ]
      },
      {
        "name": "Olympus Sash",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:waist"
        ]
      },
      {
        "name": "Oneiros Rope",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:waist",
          "data/Kalali/Kalali_Smn_Gear.lua:waist"
        ]
      },
      {
        "name": "Orpheus's Sash",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:waist",
          "data/Kalali/Kalali_Brd_Gear.lua:waist",
          "data/Kalali/Kalali_Cor_Gear.lua:waist",
          "data/Kalali/Kalali_Geo_Gear.lua:waist",
          "data/Kalali/Kalali_Rdm_Gear.lua:waist",
          "data/Kalali/Kalali_Sch_Gear.lua:waist"
        ]
      },
      {
        "name": "Plat. Mog. Belt",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:waist",
          "data/Kalali/Kalali_Sch_Gear.lua:waist"
        ]
      },
      {
        "name": "Regal Belt",
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:gear.kobo_obi",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.lucidity_sash",
          "data/Kalali/Kalali_Smn_Gear.lua:waist"
        ]
      },
      {
        "name": "Reiki Yotai",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:waist",
          "data/Kalali/Kalali_Brd_Gear.lua:waist",
          "data/Kalali/Kalali_Cor_Gear.lua:waist"
        ]
      },
      {
        "name": "Sacro Cord",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:waist",
          "data/Kalali/Kalali_Sch_Gear.lua:waist"
        ]
      },
      {
        "name": "Sailfi Belt +1",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:waist",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.kentarch_belt",
          "data/Kalali/Kalali_Brd_Gear.lua:waist",
          "data/Kalali/Kalali_Cor_Gear.lua:waist",
          "data/Kalali/Kalali_Pup_Gear.lua:waist",
          "data/Kalali/Kalali_Rdm_Gear.lua:waist",
          "data/Kalali/Kalali_Sch_Gear.lua:waist",
          "data/Kalali/Kalali_War_Gear.lua:waist"
        ]
      },
      {
        "name": "Windbuffet Belt +1",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:waist",
          "data/Kalali/Kalali_Rdm_Gear.lua:waist"
        ]
      },
      {
        "name": "Witful Belt",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:waist",
          "data/Kalali/Kalali_Brd_Gear.lua:waist",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.obi_cure_waist",
          "data/Kalali/Kalali_Geo_Gear.lua:waist",
          "data/Kalali/Kalali_Pup_Gear.lua:waist",
          "data/Kalali/Kalali_Rdm_Gear.lua:waist",
          "data/Kalali/Kalali_Sch_Gear.lua:waist",
          "data/Kalali/Kalali_Smn_Gear.lua:waist"
        ]
      },
      {
        "name": "Yemaya Belt",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:waist"
        ]
      }
    ],
    "back": [
      {
        "name": "Bookworm's Cape",
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:back"
        ]
      },
      {
        "name": "Campestres's Cape",
        "augments": [
          "Pet: Damage taken -5%",
          "Pet: M.Acc.+10 Pet: M.Dmg.+10"
        ],
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:back",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.conveyance_cape",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.idle_jse_back",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.magic_jse_back",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.skillchain_jse_back"
        ]
      },
      {
        "name": "Camulus's Mantle",
        "augments": [
          "\"Snapshot\"+10"
        ],
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:back",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.snapshot_jse_back",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.tp_snapshot_jse_back"
        ]
      },
      {
        "name": "Camulus's Mantle",
        "augments": [
          "AGI+19",
          "Rng.Acc.+20 Rng.Atk.+20",
          "\"Store TP\"+10",
          "Phys. dmg. taken -10%"
        ],
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:back",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.tp_ranger_jse_back"
        ]
      },
      {
        "name": "Camulus's Mantle",
        "augments": [
          "AGI+20",
          "Mag. Acc+20 /Mag. Dmg.+20",
          "AGI+10",
          "Weapon skill damage +10%"
        ],
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:back",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.magic_wsd_jse_back",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.ranger_wsd_jse_back"
        ]
      },
      {
        "name": "Camulus's Mantle",
        "augments": [
          "DEX+20",
          "Accuracy+20 Attack+20",
          "DEX+1",
          "\"Double Attack\"+10%"
        ],
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:gear.tp_jse_back"
        ]
      },
      {
        "name": "Camulus's Mantle",
        "augments": [
          "STR+20",
          "Accuracy+20 Attack+20",
          "STR+10",
          "Weapon skill damage +10%",
          "Phys. dmg. taken -10%"
        ],
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:back",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.str_wsd_jse_back"
        ]
      },
      {
        "name": "Cichol's Mantle",
        "augments": [
          "DEX+20",
          "Accuracy+20 Attack+20",
          "Accuracy+10",
          "\"Dbl.Atk.\"+10",
          "Damage taken-5%"
        ],
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:back",
          "data/Kalali/Kalali_War_Gear.lua:gear.da_jse_back"
        ]
      },
      {
        "name": "Cichol's Mantle",
        "augments": [
          "STR+20",
          "Accuracy+20 Attack+20",
          "STR+10",
          "Weapon skill damage +10%",
          "Phys. dmg. taken-10%"
        ],
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:back",
          "data/Kalali/Kalali_War_Gear.lua:gear.str_wsd_jse_back"
        ]
      },
      {
        "name": "Cichol's Mantle",
        "augments": [
          "VIT+20",
          "Accuracy+20 Attack+20",
          "VIT+10",
          "Weapon skill damage +10%"
        ],
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:back",
          "data/Kalali/Kalali_War_Gear.lua:gear.vit_wsd_jse_back"
        ]
      },
      {
        "name": "Cornflower Cape",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:back",
          "data/Kalali/Kalali_Blu_Gear.lua:gear.nuke_jse_back"
        ]
      },
      {
        "name": "Dispersal Mantle",
        "augments": [
          "STR+3",
          "DEX+1",
          "Pet: TP Bonus +480"
        ],
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:back",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.pet_tp_bonus_back",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.visucius_pet_ws_back"
        ]
      },
      {
        "name": "Ghostfyre Cape",
        "augments": [
          "Mag. Acc.+9",
          "Enfb. mag. skill +6",
          "Enha. mag. skill +10",
          "Enhancing magic effect duration +11%"
        ],
        "sources": [
          "data/Kalali/Kalali-Items.lua:gear.ghostfyre_enhancing_skill_cape",
          "data/Kalali/Kalali_Rdm_Gear.lua:back",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.ghostfyre_cape",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.ghostfyre_enhancing_skill_cape"
        ]
      },
      {
        "name": "Ghostfyre Cape",
        "augments": [
          "Mag. Acc.+4",
          "Enfb. mag. skill +1",
          "Enha. mag. skill +7",
          "Enhancing magic effect duration +20%"
        ],
        "sources": [
          "data/Kalali/Kalali-Items.lua:gear.ghostfyre_enhancing_duration_cape",
          "data/Kalali/Kalali_Rdm_Gear.lua:back",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.enhancing_duration_jse_back",
          "data/Kalali/Kalali_Sch_Gear.lua:back",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.enhancing_duration_back"
        ]
      },
      {
        "name": "Gunslinger's Cape",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:back"
        ]
      },
      {
        "name": "Intarabus's Cape",
        "augments": [
          "Mag. Acc+8/Mag. Dmg.+8",
          "\"Fast Cast\"+10"
        ],
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:back",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.magic_jse_back"
        ]
      },
      {
        "name": "Intarabus's Cape",
        "augments": [
          "STR+20",
          "Accuracy+20 Attack+20",
          "Weapon skill damage +10%"
        ],
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:back",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.melee_chr_wsd_back",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.melee_dex_wsd_back",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.melee_int_wsd_back",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.melee_str_wsd_back"
        ]
      },
      {
        "name": "Lifestream Cape",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:back",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.geo_back",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.idle_jse_back",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.perimede_cape"
        ]
      },
      {
        "name": "Moonlight Cape",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:back"
        ]
      },
      {
        "name": "Lugh's Cape",
        "augments": [
          "INT+20",
          "Mag. Acc+20 /Mag. Dmg.+20",
          "INT+10",
          "\"Mag.Atk.Bns.\"+10"
        ],
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:back",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.nuke_jse_back"
        ]
      },
      {
        "name": "Lugh's Cape",
        "augments": [
          "INT+20",
          "Mag. Acc+20 /Mag. Dmg.+20",
          "INT+10",
          "Weapon skill damage +10%"
        ],
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:back",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.black_halo_jse_back",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.magic_wsd_jse_back"
        ]
      },
      {
        "name": "Mecisto. Mantle",
        "sources": [
          "data/Kalali/Kalali-Items.lua:back"
        ]
      },
      {
        "name": "Null Shawl",
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:back",
          "data/Kalali/Kalali_Brd_Gear.lua:back",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.engulfer_cape",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.shadow_mantle",
          "data/Kalali/Kalali_Cor_Gear.lua:back",
          "data/Kalali/Kalali_Geo_Gear.lua:back",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.nuke_jse_back",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.obi_cure_back",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.obi_high_nuke_back",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.obi_low_nuke_back",
          "data/Kalali/Kalali_Pup_Gear.lua:back",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.visucius_master_tp_back",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.visucius_pet_tank_back",
          "data/Kalali/Kalali_Rdm_Gear.lua:back",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.engulfer_cape",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.shadow_mantle",
          "data/Kalali/Kalali_Sch_Gear.lua:back",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.perimede_cape",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.shadow_mantle",
          "data/Kalali/Kalali_Smn_Gear.lua:back",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.black_halo_jse_back",
          "data/Kalali/Kalali_War_Gear.lua:back"
        ]
      },
      {
        "name": "Oretan. Cape +1",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:back",
          "data/Kalali/Kalali_Rdm_Gear.lua:back",
          "data/Kalali/Kalali_Sch_Gear.lua:back"
        ]
      },
      {
        "name": "Perimede Cape",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:back",
          "data/Kalali/Kalali_Cor_Gear.lua:back",
          "data/Kalali/Kalali_Pup_Gear.lua:back",
          "data/Kalali/Kalali_War_Gear.lua:back"
        ]
      },
      {
        "name": "Rosmerta's Cape",
        "augments": [
          "DEX+20",
          "Accuracy+20 Attack+20",
          "DEX+10",
          "\"Store TP\"+10",
          "Phys. dmg. taken-10%"
        ],
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:back",
          "data/Kalali/Kalali_Blu_Gear.lua:gear.stp_jse_back"
        ]
      },
      {
        "name": "Rosmerta's Cape",
        "augments": [
          "STR+20",
          "Accuracy+20 Attack+20",
          "STR+10",
          "Weapon skill damage +10%"
        ],
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:back",
          "data/Kalali/Kalali_Blu_Gear.lua:gear.int_wsd_jse_back",
          "data/Kalali/Kalali_Blu_Gear.lua:gear.str_wsd_jse_back"
        ]
      },
      {
        "name": "Rudianos's Mantle",
        "augments": [
          "HP+60",
          "Eva.+20 /Mag. Eva.+20",
          "Mag. Evasion+10",
          "Enmity+10",
          "Chance of successful block +5"
        ],
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:gear.rudianos_enmity_block_back",
          "data/Kalali/Kalali_Pld_Gear.lua:back"
        ]
      },
      {
        "name": "Weard Mantle",
        "augments": [
          "VIT+4",
          "DEX+2",
          "Phalanx +5"
        ],
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:back",
          "data/Kalali/Kalali_Pld_Gear.lua:gear.phalanx_jse_back",
          "data/Kalali/Kalali_Pld_Gear.lua:gear.weard_phalanx_received_back"
        ]
      },
      {
        "name": "Scintillating Cape",
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:back",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.phys_jse_back"
        ]
      },
      {
        "name": "Sucellos's Cape",
        "augments": [
          "DEX+20",
          "Accuracy+20 Attack+20",
          "\"Dual Wield\"+10",
          "Phys. dmg. taken-10%"
        ],
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:back",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.dw_jse_back"
        ]
      },
      {
        "name": "Sucellos's Cape",
        "augments": [
          "INT+20",
          "Mag. Acc+20/Mag. Dmg.+20",
          "\"Mag. Atk. Bns.\"+10",
          "Phys. dmg. taken-10%"
        ],
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:back",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.int_enfeebling_jse_back",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.int_wsd_jse_back",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.nuke_jse_back"
        ]
      },
      {
        "name": "Sucellos's Cape",
        "augments": [
          "MND+20",
          "Mag. Acc+20/Mag. Dmg.+20",
          "MND+10",
          "Weapon skill damage +10%"
        ],
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:back",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.magical_mnd_wsd_jse_back",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.mnd_enfeebling_jse_back",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.physical_mnd_wsd_jse_back",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.str_wsd_jse_back"
        ]
      },
      {
        "name": "Sucellos's Cape",
        "augments": [
          "MND+20",
          "Mag. Acc+20/Mag. Dmg.+20",
          "MND+9",
          "\"Fast Cast\"+10%",
          "Phys. dmg. taken-10%"
        ],
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:back",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.cure_jse_back",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.perimede_cape"
        ]
      },
      {
        "name": "Twilight Cape",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:back",
          "data/Kalali/Kalali_Sch_Gear.lua:back"
        ]
      }
    ],
    "ear": [
      {
        "name": "Alabaster Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear2",
          "data/Kalali/Kalali_Brd_Gear.lua:ear2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear1",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.andoaa_earring",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.meili_earring",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.zennaroi_ear",
          "data/Kalali/Kalali_Sch_Gear.lua:ear1",
          "data/Kalali/Kalali_Sch_Gear.lua:ear2",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.andoaa_earring",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.meili_earring"
        ]
      },
      {
        "name": "Andoaa Earring",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:ear1",
          "data/Kalali/Kalali_Cor_Gear.lua:ear1",
          "data/Kalali/Kalali_Pup_Gear.lua:ear1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear1",
          "data/Kalali/Kalali_War_Gear.lua:ear1"
        ]
      },
      {
        "name": "Arbatel Earring +1",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Sch_Gear.lua:ear2",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.jse_ear2"
        ]
      },
      {
        "name": "Beck. Earring +1",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:ear2",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.gelos_earring",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.jse_ear2"
        ]
      },
      {
        "name": "Boii Earring +1",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:ear2",
          "data/Kalali/Kalali_War_Gear.lua:gear.jse_ear2"
        ]
      },
      {
        "name": "Brutal Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear1",
          "data/Kalali/Kalali_Blu_Gear.lua:ear2",
          "data/Kalali/Kalali_Geo_Gear.lua:ear2",
          "data/Kalali/Kalali_Pup_Gear.lua:ear2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear2",
          "data/Kalali/Kalali_Sch_Gear.lua:ear1"
        ]
      },
      {
        "name": "Cessance Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear1",
          "data/Kalali/Kalali_Brd_Gear.lua:ear1"
        ]
      },
      {
        "name": "Chas. Earring +2",
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:ear2",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.jse_ear2"
        ]
      },
      {
        "name": "Chev. Earring +1",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:ear1",
          "data/Kalali/Kalali_Pld_Gear.lua:ear2"
        ]
      },
      {
        "name": "Crep. Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:ear1",
          "data/Kalali/Kalali_Geo_Gear.lua:ear1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear2",
          "data/Kalali/Kalali_Sch_Gear.lua:ear1",
          "data/Kalali/Kalali_Sch_Gear.lua:ear2",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.jse_ear2",
          "data/Kalali/Kalali_Smn_Gear.lua:ear1"
        ]
      },
      {
        "name": "Crepuscular Earring",
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:ear2"
        ]
      },
      {
        "name": "Cryptic Earring",
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:ear2",
          "user-confirmed:pld-new-gear"
        ]
      },
      {
        "name": "Dedition Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear1",
          "data/Kalali/Kalali_Cor_Gear.lua:ear1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear2",
          "data/Kalali/Kalali_Sch_Gear.lua:ear2",
          "data/Kalali/Kalali_Smn_Gear.lua:ear1"
        ]
      },
      {
        "name": "Eabani Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear2",
          "data/Kalali/Kalali_Brd_Gear.lua:ear1",
          "data/Kalali/Kalali_Cor_Gear.lua:ear2"
        ]
      },
      {
        "name": "Ethereal Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:ear2",
          "data/Kalali/Kalali_Geo_Gear.lua:ear2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear2",
          "data/Kalali/Kalali_Sch_Gear.lua:ear2"
        ]
      },
      {
        "name": "Etiolation Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear1",
          "data/Kalali/Kalali_Brd_Gear.lua:ear1",
          "data/Kalali/Kalali_Geo_Gear.lua:ear1",
          "data/Kalali/Kalali_Pup_Gear.lua:ear1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear1",
          "data/Kalali/Kalali_Sch_Gear.lua:ear1",
          "data/Kalali/Kalali_Smn_Gear.lua:ear1",
          "data/Kalali/Kalali_War_Gear.lua:ear1"
        ]
      },
      {
        "name": "Enchntr. Earring +1",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear1",
          "data/Kalali/Kalali_Brd_Gear.lua:ear1",
          "data/Kalali/Kalali_Cor_Gear.lua:ear1",
          "data/Kalali/Kalali_Pld_Gear.lua:ear1",
          "data/Kalali/Kalali_Pup_Gear.lua:ear1",
          "data/Kalali/Kalali_Smn_Gear.lua:ear1",
          "data/Kalali/Kalali_War_Gear.lua:ear1"
        ]
      },
      {
        "name": "Evans Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:ear2",
          "data/Kalali/Kalali_Smn_Gear.lua:ear1",
          "data/Kalali/Kalali_Smn_Gear.lua:ear2",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.andoaa_earring",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.c_palug_earring",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.lodurr_earring"
        ]
      },
      {
        "name": "Fili Earring +1",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:ear2",
          "data/Kalali/Kalali_Brd_Gear.lua:gear.jse_ear2"
        ]
      },
      {
        "name": "Friomisi Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear2",
          "data/Kalali/Kalali_Brd_Gear.lua:ear2",
          "data/Kalali/Kalali_Cor_Gear.lua:ear1",
          "data/Kalali/Kalali_Geo_Gear.lua:ear2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear2",
          "data/Kalali/Kalali_Sch_Gear.lua:ear2",
          "data/Kalali/Kalali_Smn_Gear.lua:ear1"
        ]
      },
      {
        "name": "Halasz Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:ear1"
        ]
      },
      {
        "name": "Ishvara Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear2",
          "data/Kalali/Kalali_Brd_Gear.lua:ear1",
          "data/Kalali/Kalali_Brd_Gear.lua:ear2",
          "data/Kalali/Kalali_Cor_Gear.lua:ear1",
          "data/Kalali/Kalali_Pup_Gear.lua:ear2",
          "data/Kalali/Kalali_Sch_Gear.lua:ear2",
          "data/Kalali/Kalali_Smn_Gear.lua:ear1",
          "data/Kalali/Kalali_Smn_Gear.lua:ear2"
        ]
      },
      {
        "name": "Karagoz Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:ear2",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.crepuscular_earring",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.jse_ear2"
        ]
      },
      {
        "name": "Knightly Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:ear1"
        ]
      },
      {
        "name": "Kyrene's Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:ear1"
        ]
      },
      {
        "name": "Leth. Earring +2",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:ear2",
          "data/Kalali/Kalali_Rdm_Gear.lua:gear.jse_ear2"
        ]
      },
      {
        "name": "Loquac. Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear2",
          "data/Kalali/Kalali_Brd_Gear.lua:ear1",
          "data/Kalali/Kalali_Brd_Gear.lua:ear2",
          "data/Kalali/Kalali_Geo_Gear.lua:ear2",
          "data/Kalali/Kalali_Pup_Gear.lua:ear2",
          "data/Kalali/Kalali_Sch_Gear.lua:ear2",
          "data/Kalali/Kalali_Smn_Gear.lua:ear2"
        ]
      },
      {
        "name": "Lugalbanda Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Smn_Gear.lua:ear1",
          "data/Kalali/Kalali_Smn_Gear.lua:ear2"
        ]
      },
      {
        "name": "Malignance Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:ear1",
          "data/Kalali/Kalali_Geo_Gear.lua:ear2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear1",
          "data/Kalali/Kalali_Sch_Gear.lua:ear1"
        ]
      },
      {
        "name": "Mendi. Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear2",
          "data/Kalali/Kalali_Brd_Gear.lua:ear1",
          "data/Kalali/Kalali_Cor_Gear.lua:ear2",
          "data/Kalali/Kalali_Geo_Gear.lua:ear2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear2",
          "data/Kalali/Kalali_Sch_Gear.lua:ear2",
          "data/Kalali/Kalali_Smn_Gear.lua:ear2"
        ]
      },
      {
        "name": "Mimir Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear2",
          "data/Kalali/Kalali_Geo_Gear.lua:ear2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear2"
        ]
      },
      {
        "name": "Moonshade Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear1",
          "data/Kalali/Kalali_Brd_Gear.lua:ear1",
          "data/Kalali/Kalali_Cor_Gear.lua:ear1",
          "data/Kalali/Kalali_Cor_Gear.lua:ear2",
          "data/Kalali/Kalali_Geo_Gear.lua:ear2",
          "data/Kalali/Kalali_Pup_Gear.lua:ear1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear2",
          "data/Kalali/Kalali_Sch_Gear.lua:ear2",
          "data/Kalali/Kalali_Smn_Gear.lua:ear2",
          "data/Kalali/Kalali_War_Gear.lua:ear1"
        ]
      },
      {
        "name": "Pratik Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:ear1",
          "data/Kalali/Kalali_Pup_Gear.lua:ear2",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.enmerkar_earring",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.handlers_earring"
        ]
      },
      {
        "name": "Regal Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:ear1",
          "data/Kalali/Kalali_Cor_Gear.lua:ear2",
          "data/Kalali/Kalali_Cor_Gear.lua:gear.jse_ear2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear1"
        ]
      },
      {
        "name": "Sanare Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:ear2",
          "data/Kalali/Kalali_Cor_Gear.lua:ear2",
          "data/Kalali/Kalali_Geo_Gear.lua:ear2",
          "data/Kalali/Kalali_Pup_Gear.lua:ear2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear2",
          "data/Kalali/Kalali_Sch_Gear.lua:ear2",
          "data/Kalali/Kalali_Smn_Gear.lua:ear2",
          "data/Kalali/Kalali_War_Gear.lua:ear2"
        ]
      },
      {
        "name": "Schere Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:ear1",
          "data/Kalali/Kalali_War_Gear.lua:ear1"
        ]
      },
      {
        "name": "Sherida Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:ear1"
        ]
      },
      {
        "name": "Snotra Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Rdm_Gear.lua:ear1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear2"
        ]
      },
      {
        "name": "Sroda Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:ear1",
          "data/Kalali/Kalali_Pup_Gear.lua:ear2"
        ]
      },
      {
        "name": "Suppanomimi",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear2",
          "data/Kalali/Kalali_Cor_Gear.lua:ear1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear1"
        ]
      },
      {
        "name": "Telos Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ear1",
          "data/Kalali/Kalali_Blu_Gear.lua:ear2",
          "data/Kalali/Kalali_Brd_Gear.lua:ear2",
          "data/Kalali/Kalali_Cor_Gear.lua:ear1",
          "data/Kalali/Kalali_Cor_Gear.lua:ear2",
          "data/Kalali/Kalali_Geo_Gear.lua:ear2",
          "data/Kalali/Kalali_Pup_Gear.lua:ear1",
          "data/Kalali/Kalali_Pup_Gear.lua:ear2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ear2",
          "data/Kalali/Kalali_Sch_Gear.lua:ear2",
          "data/Kalali/Kalali_Smn_Gear.lua:ear2",
          "data/Kalali/Kalali_War_Gear.lua:ear1"
        ]
      },
      {
        "name": "Thrud Earring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_War_Gear.lua:ear2"
        ]
      }
    ],
    "ring": [
      {
        "name": "Apeile Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:ring2",
          "user-confirmed:pld-new-gear"
        ]
      },
      {
        "name": "Apeile Ring +1",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:ring1",
          "user-confirmed:pld-new-gear"
        ]
      },
      {
        "name": "Archon Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring2",
          "data/Kalali/Kalali_Cor_Gear.lua:ring1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring1",
          "data/Kalali/Kalali_Sch_Gear.lua:ring2"
        ]
      },
      {
        "name": "Blenmot's Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali-Items.lua:ring2"
        ]
      },
      {
        "name": "Chirich Ring +1",
        "copies": 2,
        "copy_bags": [
          "Wardrobe",
          "Wardrobe 2"
        ],
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring1",
          "data/Kalali/Kalali_Blu_Gear.lua:ring2",
          "data/Kalali/Kalali_Cor_Gear.lua:ring1",
          "data/Kalali/Kalali_Cor_Gear.lua:ring2",
          "data/Kalali/Kalali_Geo_Gear.lua:ring1",
          "data/Kalali/Kalali_Geo_Gear.lua:ring2",
          "data/Kalali/Kalali_Pup_Gear.lua:ring1",
          "data/Kalali/Kalali_Pup_Gear.lua:ring2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring2",
          "data/Kalali/Kalali_Sch_Gear.lua:ring1",
          "data/Kalali/Kalali_Sch_Gear.lua:ring2",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.chirich_ring1",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.chirich_ring2",
          "data/Kalali/Kalali_Smn_Gear.lua:ring1",
          "data/Kalali/Kalali_Smn_Gear.lua:ring2",
          "data/Kalali/Kalali_War_Gear.lua:ring1",
          "data/Kalali/Kalali_War_Gear.lua:ring2"
        ]
      },
      {
        "name": "Crepuscular Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:ring1"
        ]
      },
      {
        "name": "Dingir Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:ring1",
          "data/Kalali/Kalali_Cor_Gear.lua:ring2"
        ]
      },
      {
        "name": "Epaminondas's Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring1",
          "data/Kalali/Kalali_Brd_Gear.lua:ring1",
          "data/Kalali/Kalali_Cor_Gear.lua:ring1",
          "data/Kalali/Kalali_Cor_Gear.lua:ring2",
          "data/Kalali/Kalali_Geo_Gear.lua:ring1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring1",
          "data/Kalali/Kalali_Sch_Gear.lua:ring1",
          "data/Kalali/Kalali_Smn_Gear.lua:ring1"
        ]
      },
      {
        "name": "Ephramad's Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring2",
          "data/Kalali/Kalali_Brd_Gear.lua:ring2",
          "data/Kalali/Kalali_Cor_Gear.lua:ring2",
          "data/Kalali/Kalali_Geo_Gear.lua:ring2",
          "data/Kalali/Kalali_Pup_Gear.lua:ring2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring2",
          "data/Kalali/Kalali_Sch_Gear.lua:ring2",
          "data/Kalali/Kalali_Smn_Gear.lua:ring2",
          "data/Kalali/Kalali_War_Gear.lua:ring2"
        ]
      },
      {
        "name": "Epona's Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring1",
          "data/Kalali/Kalali_Blu_Gear.lua:ring2",
          "data/Kalali/Kalali_Pup_Gear.lua:ring2"
        ]
      },
      {
        "name": "Evanescence Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:ring2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring1",
          "data/Kalali/Kalali_Sch_Gear.lua:ring1"
        ]
      },
      {
        "name": "Freke Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring2",
          "data/Kalali/Kalali_Geo_Gear.lua:ring1",
          "data/Kalali/Kalali_Geo_Gear.lua:ring2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring2",
          "data/Kalali/Kalali_Sch_Gear.lua:ring1",
          "data/Kalali/Kalali_Smn_Gear.lua:ring2"
        ]
      },
      {
        "name": "Gelatinous Ring +1",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Pld_Gear.lua:ring1",
          "data/Kalali/Kalali_Pld_Gear.lua:ring2",
          "user-confirmed:pld-new-gear"
        ]
      },
      {
        "name": "Haoma's Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:ring1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring1",
          "data/Kalali/Kalali_Sch_Gear.lua:ring1"
        ]
      },
      {
        "name": "Hoxne Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali-Items.lua:ring1"
        ]
      },
      {
        "name": "Ilabrat Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:ring2",
          "data/Kalali/Kalali_Cor_Gear.lua:ring2"
        ]
      },
      {
        "name": "Kishar Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring1",
          "data/Kalali/Kalali_Brd_Gear.lua:ring1",
          "data/Kalali/Kalali_Geo_Gear.lua:ring1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring1",
          "data/Kalali/Kalali_Sch_Gear.lua:ring1",
          "data/Kalali/Kalali_Smn_Gear.lua:ring1"
        ]
      },
      {
        "name": "Lebeche Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring2",
          "data/Kalali/Kalali_Brd_Gear.lua:ring2",
          "data/Kalali/Kalali_Geo_Gear.lua:ring2",
          "data/Kalali/Kalali_Pup_Gear.lua:ring2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring2",
          "data/Kalali/Kalali_Sch_Gear.lua:ring2",
          "data/Kalali/Kalali_Smn_Gear.lua:ring2"
        ]
      },
      {
        "name": "Luzaf's Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Cor_Gear.lua:ring2"
        ]
      },
      {
        "name": "Menelaus's Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring2",
          "data/Kalali/Kalali_Brd_Gear.lua:ring2",
          "data/Kalali/Kalali_Geo_Gear.lua:ring2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring2",
          "data/Kalali/Kalali_Sch_Gear.lua:ring2",
          "data/Kalali/Kalali_Smn_Gear.lua:ring2"
        ]
      },
      {
        "name": "Mephitas's Ring +1",
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:ring2",
          "data/Kalali/Kalali_Pld_Gear.lua:ring2",
          "data/Kalali/Kalali_Smn_Gear.lua:ring2"
        ]
      },
      {
        "name": "Metamor. Ring +1",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring1",
          "data/Kalali/Kalali_Cor_Gear.lua:ring1",
          "data/Kalali/Kalali_Geo_Gear.lua:ring1",
          "data/Kalali/Kalali_Geo_Gear.lua:ring2",
          "data/Kalali/Kalali_Sch_Gear.lua:ring2",
          "data/Kalali/Kalali_Smn_Gear.lua:ring1",
          "data/Kalali/Kalali_Smn_Gear.lua:ring2"
        ]
      },
      {
        "name": "Metamorph Ring +1",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:ring1",
          "data/Kalali/Kalali_Brd_Gear.lua:ring2",
          "data/Kalali/Kalali_Pup_Gear.lua:ring1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring2",
          "data/Kalali/Kalali_War_Gear.lua:ring1"
        ]
      },
      {
        "name": "Moonlight Ring",
        "copies": 2,
        "copy_bags": [
          "Wardrobe",
          "Wardrobe 2"
        ],
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:ring1",
          "data/Kalali/Kalali_Brd_Gear.lua:ring2",
          "data/Kalali/Kalali_War_Gear.lua:ring1",
          "data/Kalali/Kalali_War_Gear.lua:ring2"
        ]
      },
      {
        "name": "Mujin Band",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Geo_Gear.lua:ring1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring1",
          "data/Kalali/Kalali_Sch_Gear.lua:ring2"
        ]
      },
      {
        "name": "Murky Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring1",
          "data/Kalali/Kalali_Brd_Gear.lua:ring1",
          "data/Kalali/Kalali_Cor_Gear.lua:ring1",
          "data/Kalali/Kalali_Pld_Gear.lua:ring1",
          "data/Kalali/Kalali_Pld_Gear.lua:ring2",
          "data/Kalali/Kalali_Pup_Gear.lua:ring1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring1",
          "data/Kalali/Kalali_Sch_Gear.lua:ring1",
          "data/Kalali/Kalali_Smn_Gear.lua:ring1",
          "data/Kalali/Kalali_War_Gear.lua:ring1"
        ]
      },
      {
        "name": "Naji's Loop",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring1",
          "data/Kalali/Kalali_Brd_Gear.lua:ring1",
          "data/Kalali/Kalali_Geo_Gear.lua:ring1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring1",
          "data/Kalali/Kalali_Sch_Gear.lua:ring1",
          "data/Kalali/Kalali_Smn_Gear.lua:ring1"
        ]
      },
      {
        "name": "Niqmaddu Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:ring1",
          "data/Kalali/Kalali_War_Gear.lua:gear.niqmaddu_ring",
          "data/Kalali/Kalali_War_Gear.lua:ring1"
        ]
      },
      {
        "name": "Prolix Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring",
          "data/Kalali/Kalali_Brd_Gear.lua:ring2",
          "data/Kalali/Kalali_Geo_Gear.lua:ring2",
          "data/Kalali/Kalali_Pup_Gear.lua:ring1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring2"
        ]
      },
      {
        "name": "Purity Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali-Items.lua:ring1"
        ]
      },
      {
        "name": "Shadow Ring",
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:gear.shadow_ring",
          "data/Kalali/Kalali_Brd_Gear.lua:ring2",
          "data/Kalali/Kalali_Pld_Gear.lua:ring2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring2",
          "data/Kalali/Kalali_Sch_Gear.lua:gear.shadow_ring",
          "data/Kalali/Kalali_Sch_Gear.lua:ring2"
        ]
      },
      {
        "name": "Sheltered Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali-Items.lua:ring2",
          "data/Kalali/Kalali_Blu_Gear.lua:ring2",
          "data/Kalali/Kalali_Geo_Gear.lua:ring2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring2",
          "data/Kalali/Kalali_Sch_Gear.lua:ring2"
        ]
      },
      {
        "name": "Shiva Ring +1",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Brd_Gear.lua:ring2"
        ]
      },
      {
        "name": "Shneddick Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring2",
          "data/Kalali/Kalali_Cor_Gear.lua:ring2",
          "data/Kalali/Kalali_Pup_Gear.lua:ring2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring2",
          "data/Kalali/Kalali_Sch_Gear.lua:ring2",
          "data/Kalali/Kalali_Smn_Gear.lua:ring2",
          "data/Kalali/Kalali_War_Gear.lua:ring2"
        ]
      },
      {
        "name": "Sroda Ring",
        "copies": 1,
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring2",
          "data/Kalali/Kalali_Cor_Gear.lua:ring1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring1",
          "data/Kalali/Kalali_War_Gear.lua:gear.regal_ring",
          "data/Kalali/Kalali_War_Gear.lua:ring1"
        ]
      },
      {
        "name": "Stikini Ring +1",
        "copies": 2,
        "copy_bags": [
          "Wardrobe",
          "Wardrobe 2"
        ],
        "sources": [
          "data/Kalali/Kalali_Blu_Gear.lua:ring1",
          "data/Kalali/Kalali_Blu_Gear.lua:ring2",
          "data/Kalali/Kalali_Brd_Gear.lua:ring1",
          "data/Kalali/Kalali_Brd_Gear.lua:ring2",
          "data/Kalali/Kalali_Cor_Gear.lua:ring1",
          "data/Kalali/Kalali_Cor_Gear.lua:ring2",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.stikini_ring1",
          "data/Kalali/Kalali_Geo_Gear.lua:gear.stikini_ring2",
          "data/Kalali/Kalali_Geo_Gear.lua:ring1",
          "data/Kalali/Kalali_Geo_Gear.lua:ring2",
          "data/Kalali/Kalali_Pup_Gear.lua:ring2",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring1",
          "data/Kalali/Kalali_Rdm_Gear.lua:ring2",
          "data/Kalali/Kalali_Sch_Gear.lua:ring1",
          "data/Kalali/Kalali_Sch_Gear.lua:ring2",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.evokers_ring",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.stikini_ring1",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.stikini_ring2",
          "data/Kalali/Kalali_Smn_Gear.lua:ring1",
          "data/Kalali/Kalali_Smn_Gear.lua:ring2",
          "data/Kalali/Kalali_War_Gear.lua:ring2"
        ]
      },
      {
        "name": "Varar Ring +1",
        "copies": 2,
        "copy_bags": [
          "Wardrobe",
          "Wardrobe 2"
        ],
        "sources": [
          "data/Kalali/Kalali_Pup_Gear.lua:gear.c_palug_ring",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.varar_ring1",
          "data/Kalali/Kalali_Pup_Gear.lua:gear.varar_ring2",
          "data/Kalali/Kalali_Pup_Gear.lua:ring1",
          "data/Kalali/Kalali_Pup_Gear.lua:ring2",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.c_palug_ring",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.varar_ring1",
          "data/Kalali/Kalali_Smn_Gear.lua:gear.varar_ring2",
          "data/Kalali/Kalali_Smn_Gear.lua:ring1",
          "data/Kalali/Kalali_Smn_Gear.lua:ring2"
        ]
      }
    ]
  }
}
```
