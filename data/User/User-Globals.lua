--Place for your settings and custom functions that are meant to affect all of your jobs and characters.
latency = .25
--If this is set to true it will prevent you from casting shadows when you have more up than that spell would generate.
conserveshadows = false
--Display related settings.

--Options for automation.
state.ReEquip 		  		= M(true, 'ReEquip Mode')		    --Set this to false if you don't want to equip your current Weapon set when you aren't wearing any weapons.
state.AutoArts 		  		= M(true, 'AutoArts') 		        --Set this to false if you don't want to automatically try to keep up Solace/Arts.
state.AutoLockstyle	 	    = M(true, 'AutoLockstyle Mode')     --Set this to false if you don't want gearswap to automatically lockstyle on load and weapon change.
state.CancelStoneskin 		= M(true, 'Cancel Stone Skin')      --Set this to false if you don't want to automatically cancel stoneskin when you're slept.
state.SkipProcWeapons 		= M(true, 'Skip Proc Weapons')      --Set this to false if you want to display weapon sets fulltime rather than just Aby/Voidwatch.
state.NotifyBuffs	  		= M(false, 'Notify Buffs') 	        --Set this to true if you want to notify your party when you recieve a specific buff/debuff. (List Below)

--[[Binds you may want to change.
	Bind special characters.
	@ = Windows Key
	% = Works only when text bar not up.
	$ = Works only when text bar is up.
	^ = Control Key
	! = Alt Key
	~ = Shift Key
	# = Apps Key
]]
send_command('bind !@^f7 gs c toggle AutoWSMode') --Turns auto-ws mode on and off.
send_command('bind !^f7 gs c toggle AutoFoodMode') --Turns auto-ws mode on and off.
send_command('bind f7 gs c cycle Weapons') --Cycle through weapons sets.
send_command('bind @f8 gs c toggle AutoNukeMode') --Turns auto-nuke mode on and off.
send_command('bind ^f8 gs c toggle AutoStunMode') --Turns auto-stun mode off and on.
send_command('bind !f8 gs c toggle AutoDefenseMode') --Turns auto-defense mode off and on.
send_command('bind ^@!f8 gs c toggle AutoTrustMode') --Summons trusts automatically.
send_command('bind @pause gs c cycle AutoBuffMode') --Automatically keeps certain buffs up, job-dependant.
send_command('bind @scrolllock gs c cycle Passive') --Changes offense settings such as accuracy.
send_command('bind f9 gs c cycle OffenseMode') --Changes offense settings such as accuracy.
send_command('bind ^f9 gs c cycle HybridMode') --Changes defense settings for melee such as PDT.
send_command('bind @f9 gs c cycle RangedMode') --Changes ranged offense settings such as accuracy.
send_command('bind !f9 gs c cycle WeaponskillMode') --Changes weaponskill offense settings such as accuracy.
send_command('bind f10 gs c set DefenseMode Physical') --Turns your physical defense set on.
send_command('bind ^f10 gs c cycle PhysicalDefenseMode') --Changes your physical defense set.
send_command('bind !f10 gs c toggle Kiting') --Keeps your kiting gear on..
send_command('bind f11 gs c set DefenseMode Magical') --Turns your magical defense set on.
send_command('bind ^f11 gs c cycle MagicalDefenseMode') --Changes your magical defense set.
send_command('bind @f11 gs c cycle CastingMode') --Changes your castingmode options such as magic accuracy.
send_command('bind !f11 gs c cycle ExtraMeleeMode') --Adds another set layered on top of your engaged set.
send_command('bind ^f12 gs c cycle ResistDefenseMode') --Changes your resist defense set.
send_command('bind f12 gs c set DefenseMode Resist') --Turns your resist defense set on.
send_command('bind @f12 gs c cycle IdleMode') --Changes your idle mode options such as refresh.
send_command('bind !f12 gs c reset DefenseMode') --Turns your defensive mode off.
send_command('bind ^@!f12 gs reload') --Reloads gearswap.
send_command('bind pause gs c update user') --Runs a quick check to make sure you have the right gear on and checks variables.
send_command('bind ^@!pause gs org') --Runs organizer.
send_command('bind ^@!backspace gs c buffup') --Buffup macro because buffs are love.

NotifyBuffs = S{'doom','petrification'}

-- Repo update settings for //gs c gitpull
gearswap_git_repo_path = gearswap_git_repo_path or (windower.windower_path .. 'addons/GearSwap')

local function quote_shell_path(path)
	return '"' .. tostring(path or ''):gsub('"', '\\"') .. '"'
end

local function run_gearswap_git_pull()
	if type(os) ~= 'table' or type(os.execute) ~= 'function' then
		add_to_chat(123, 'Git update failed: this Windower Lua environment does not allow os.execute().')
		return false
	end

	local repo_path = gearswap_git_repo_path
	if not repo_path or repo_path == '' then
		add_to_chat(123, 'Git update failed: gearswap_git_repo_path is not configured.')
		return false
	end

	local is_windows = package and package.config and package.config:sub(1, 1) == '\\'
	local command

	if is_windows then
		command = 'cd /d ' .. quote_shell_path(repo_path) .. ' && git fetch && git pull'
	else
		command = 'cd ' .. quote_shell_path(repo_path) .. ' && git fetch && git pull'
	end

	add_to_chat(122, 'Running git fetch && git pull in ' .. repo_path .. '. The client may pause briefly.')

	local ok, result_a, result_b, result_c
	if is_windows then
		ok, result_a, result_b, result_c = pcall(os.execute, 'cmd /c ' .. quote_shell_path(command))
	else
		ok, result_a, result_b, result_c = pcall(os.execute, command)
	end

	if not ok then
		add_to_chat(123, 'Git update failed: ' .. tostring(result_a))
		return false
	end

	local success = false
	if type(result_a) == 'number' then
		success = result_a == 0
	elseif type(result_a) == 'boolean' then
		success = result_a
	elseif result_a == 'exit' and type(result_b) == 'number' then
		success = result_b == 0
	elseif result_b == 'exit' and type(result_c) == 'number' then
		success = result_c == 0
	end

	if success then
		add_to_chat(122, 'Git update finished. Reloading GearSwap in 2 seconds.')
		send_command('wait 2; gs reload')
		return true
	end

	add_to_chat(123, 'Git update failed. Check that Git is installed and ' .. repo_path .. ' is a valid repo.')
	return false
end

function user_self_command(commandArgs, eventArgs)
	if not commandArgs or not commandArgs[1] then
		return
	end

	local command = commandArgs[1]:lower()

	if command == 'gitpull' or command == 'gitupdate' then
		eventArgs.handled = true
		run_gearswap_git_pull()
	end
end
