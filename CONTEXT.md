# CONTEXT

Working context for future GearSwap Lua edits in this repository.

## Repository Shape

This repo is a customized Kalali/Selindrile-style GearSwap setup for Final Fantasy XI.

Primary paths:

- `data/<JOB>.lua`: upstream/shared job logic. Avoid editing these unless explicitly asked.
- `libs/`: shared Sel libraries. Avoid editing these unless explicitly asked.
- `data/User/User-<JOB>.lua`: user/job hooks loaded before the character gear file.
- `data/Kalali/Kalali-Globals.lua`: character-wide settings and helpers.
- `data/Kalali/Kalali-Items.lua`: character-wide shared gear aliases.
- `data/Kalali/Kalali_<Job>_Gear.lua`: character/job-specific setup and gear sets.
- `data/Kalali/UnusedJobs/`: inactive older job files. Do not treat these as current owned gear unless asked.
- `OWNEDGEAR.md`: machine-oriented index of owned gear parsed from active personalized Lua files.

`data/Kalali/Kalali_Rdm_Gear.lua` is the best reference file for style, structure, and how to handle missing or aspirational pieces.

## Load Order And Override Model

The base job files include `Sel-Include.lua`. The include chain loads shared libraries first, then user/character/job files. Later files override earlier definitions.

Important load order from `libs/Sel-Include.lua`:

1. Shared Sel libraries.
2. `User-Globals.lua`.
3. `<Character>-Globals.lua`.
4. `<Character>-Items.lua`.
5. `User-<JOB>.lua`.
6. `<Character>_<JOB>_Gear.lua`.

Prefer changing character-specific gear files over base job files. If a base function needs custom behavior, use an existing `user_*` or `user_job_*` hook when possible instead of copying the base function.

## General Editing Rules

- Preserve existing style and spacing in the target Lua file.
- Keep changes scoped to the requested job or shared item file.
- Do not rewrite base `data/<JOB>.lua` files for normal gear updates.
- Do not remove user comments that explain substitutions, target gear, or battle-use notes.
- Treat empty strings and empty tables as intentional placeholders when they are used for missing gear.
- Use `set_combine()` for small overlays and variants rather than duplicating full sets unnecessarily.
- Reuse shared `gear.*` aliases when they represent substitutions, augments, or shared cross-file concepts.
- Do not create `gear.*` aliases that only repeat the owned item name, such as `gear.nyame_mail = "Nyame Mail"`. Use the literal item string in sets instead.
- Do not create same-name `gear.*` aliases for bag-qualified duplicate items either, such as `gear.moonlight_ring1 = { name = "Moonlight Ring", bag = "Wardrobe" }`. Use the inline bag-qualified table in the set or in a substitution alias.
- Use bag-qualified tables for duplicate rings/earrings when both copies matter:

```lua
ring1 = { name = "Chirich Ring +1", bag = "Wardrobe" },
ring2 = { name = "Chirich Ring +1", bag = "Wardrobe 2" },
```

## Owned Gear Policy

Build gearsets from gear already present in active personalized files when possible.

Use these sources before inventing replacements:

- `OWNEDGEAR.md` for a broad owned-gear index.
- Active files under `data/Kalali/`, excluding `UnusedJobs`.
- Existing aliases in `Kalali-Items.lua`.
- Existing job files for comparable sets.

When adding or replacing gear in a job file, every equipped item must satisfy both constraints:

- The item is owned, preferably confirmed in `OWNEDGEAR.md` or active personalized files.
- The current job can equip it, confirmed by Windower resources/job flags or another authoritative source.

Do not infer job eligibility from an item appearing in another job's gear file, or from a plain
`OWNEDGEAR.md` source entry. `OWNEDGEAR.md` is only authoritative for job eligibility or item
properties when the specific entry explicitly records those fields. Otherwise, verify the item's
jobs and relevant stats before adding it to a new job file.

Do not replace an invalid job item with aspirational gear just because the job can equip it. If the user
explicitly says they acquired a new item that is not reflected in `OWNEDGEAR.md` yet, it can be used,
but treat that as a user-provided owned-gear exception and keep it scoped to the requested change.

If a best-in-slot or target piece is not owned, follow the RDM pattern:

1. Define a `gear.<alias>` for the target concept.
2. Assign it to an owned fallback.
3. Leave a nearby comment naming the desired piece and why it matters.

Example pattern:

```lua
gear.umuthi_hat = gear.af3_head
--  2  Umuthi Hat                    +8 Enspell
```

This keeps sets runnable today while documenting future upgrades.

## Gear Alias Conventions

Use aliases for:

- JSE capes with augments.
- AF/relic/empy pieces.
- Shared weapons or accessories.
- Augmented gear.
- Missing or aspirational pieces with fallbacks.

Hard rule: do not create `gear.*` aliases as simple wrappers for plain owned gear.
An alias must communicate augment details, a future upgrade path, shared special handling, or a missing/aspirational fallback.
If an item is just an owned item name, put the literal item name directly in the set.

Avoid this:

```lua
gear.nyame_mail = "Nyame Mail"
gear.mall_chapeau = "Mall. Chapeau +2"
```

Do this instead:

```lua
body = "Nyame Mail"
head = "Mall. Chapeau +2"
```

The `gear.*` namespace should make substitutions and special handling easy to spot; mixing plain owned gear into it makes missing or replacement gear harder to identify.

This also applies to bag-qualified duplicate rings or earrings. Do not define `gear.moonlight_ring1`, `gear.moonlight_ring2`, `gear.stikini_ring1`, etc. just to encode wardrobe location. In this repo, `ring1` corresponds to `Wardrobe` and `ring2` corresponds to `Wardrobe 2`, so inline the bag-qualified table where needed.

Common RDM-style aliases:

- `gear.af1_*`: artifact gear.
- `gear.af2_*`: relic gear.
- `gear.af3_*`: empyrean gear.
- `gear.jse_ear2`, `gear.jse_neck`: job-specific earring/neck.
- `gear.*_jse_back`: Ambuscade cape variants.
- `gear.tp_bonus_sword`, `gear.tp_bonus_dagger`, `gear.tp_bonus_gun`: shared Magian TP bonus weapons from `Kalali-Items.lua`.

When a cape or augmented piece is not owned, redirect the alias to the closest owned cape and comment the intended future version.

## Job Gear File Structure

Follow the organization used by `Kalali_Rdm_Gear.lua`:

1. `character_user_job_setup()`
   - Define state options.
   - Define weapon modes and weapon groups.
   - Set defaults like `default_weapons` and `default_dual_weapons`.
   - Define `autows_list`.
   - Define `trust_list` when useful.
   - Define job-local gear aliases and owned fallbacks.
   - Add local binds.
   - Call `select_default_macro_book()`.

2. `init_gear_sets()`
   - Weapons.
   - Precast JA and FC sets.
   - Weaponskill sets.
   - Midcast sets.
   - Buff condition sets.
   - Idle/defense sets.
   - Engaged sets and variants.

3. Job-local helpers
   - `select_default_macro_book()`.
   - `user_job_buff_change()`.
   - `user_job_lockstyle()`.
   - Job-specific buff lists or automation tables.

Do not move big sections around unless the user asks for a cleanup.

## State And Mode Patterns

Modes should be explicit and match the set names that exist.

Examples from RDM:

```lua
state.OffenseMode:options('Normal', 'Acc')
state.HybridMode:options('Normal', 'DT')
state.WeaponskillMode:options('Match', 'Proc')
state.CastingMode:options('Normal', 'Resistant', 'Proc', 'SIRD')
state.IdleMode:options('Normal', 'PDT', 'MDT', 'MEVA', 'Aminon')
```

For weapon modes, keep `state.Weapons:options(...)`, `state.WeaponSets:options(...)`, `weapon_sets`, `default_weapons`, `default_dual_weapons`, and `autows_list` in sync.

If adding a weapon mode, also check:

- `sets.weapons.<ModeName>`.
- `weapon_sets`.
- `autows_list`.
- Any engaged set variant with the same mode name, if applicable.

## Set Naming Patterns

Use existing Sel/GearSwap naming conventions:

- `sets.weapons.<ModeName>`.
- `sets.precast.JA['Ability Name']`.
- `sets.precast.FC`.
- `sets.precast.WS`.
- `sets.precast.WS['Weapon Skill']`.
- `sets.midcast.<SpellMap>`.
- `sets.midcast['Magic Skill']`.
- `sets.midcast['Magic Skill'].Resistant`.
- `sets.midcast.<SpellName>.DW`.
- `sets.buff.<BuffName>`.
- `sets.idle`, `sets.idle.PDT`, `sets.idle.MDT`, `sets.idle.MEVA`.
- `sets.defense.PDT`, `sets.defense.MDT`, `sets.defense.MEVA`.
- `sets.engaged`, `sets.engaged.Acc`, `sets.engaged.DT`, `sets.engaged.DW`, `sets.engaged.DW.Acc.DT`.

Use assignment aliases for truly identical sets:

```lua
sets.midcast.Bind = sets.midcast.Sleep
sets.midcast.Break = sets.midcast.Sleep
```

Use `set_combine()` when a set is mostly inherited with a few slot changes:

```lua
sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Sacro Bulwark" })
```

## RDM-Specific Lessons To Reuse

RDM is a strong template because it balances real owned gear, future target gear, and specialized behavior.

Important patterns:

- Enhancing Magic is layered by job logic. Do not blindly `set_combine()` full enhancing spell sets. RDM comments explain that the order is base enhancing set, then Composure, then spell-specific pieces.
- Keep `sets.EnhancingSkill`, `sets.midcast['Enhancing Magic']`, `sets.buff.ComposureOther`, and spell-specific enhancing overlays separate.
- For enfeebles, define normal, `Resistant`, and `DW` variants where useful.
- For elemental magic, define normal, `DT`, `Resistant`, `Proc`, `HighTierNuke`, and `DW` variants only where useful.
- Use `sets.MaxTP`, `sets.AccMaxTP`, and `sets.MagicalMaxTP` for Moonshade swaps at 3000 TP.
- Use `sets.TreasureHunter` overlays for Dia/Bio style tagging spells.
- Preserve notes about ranged/ammo conflicts, especially `Ullr`, `empty`, and ammo restoration.

## Placeholder And Upgrade Notes

This repo intentionally documents missing gear inline. Keep those notes useful and specific.

Good placeholder comments include:

- Desired item name.
- Priority or relative value if known.
- Why the item matters.
- Current fallback.

Avoid deleting a placeholder just because the fallback is not best-in-slot. It may be documenting the acquisition plan.

When adding a new missing item, prefer this style:

```lua
gear.example_alias = "Owned Fallback"
--  2  Desired Item Name              Reason this is desired
```

The number before the item name appears to be a personal priority/weight. Preserve it when editing nearby lists. If adding new entries and no priority is known, omit the number or use a short TODO comment.

## Safety Checks

Before finalizing Lua edits:

- Run `git diff --check`.
- Review the relevant diff.
- Check for obvious Lua table syntax issues: missing commas, unclosed braces, accidental bare values.
- If a practical Lua parser or repo test exists, use it; otherwise do a careful text review.

Be careful with existing dirty worktree state. Do not revert unrelated user changes.

## Current Worktree Note

At the time this context file was created, there was unrelated dirty state involving `data/Kalali/Kalali_Pld_Gear.lua` and `data/Kalali/UnusedJobs/Kalali_Pld_Gear.lua`. Future edits should not revert or normalize that move/delete pair unless the user asks.
