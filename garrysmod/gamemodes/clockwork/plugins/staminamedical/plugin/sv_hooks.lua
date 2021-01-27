--[[
	© 2015 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

-- Called when a player's character data should be saved.
function cwStamina:PlayerSaveCharacterData(player, data)
	if (data["stamina"]) then
		data["stamina"] = math.Round(data["stamina"]);
	end;
end;

-- Called when a player's character data should be restored.
function cwStamina:PlayerRestoreCharacterData(player, data)
	if (!data["Stamina"]) then
		data["Stamina"] = 100;
	end;
end;

-- Called just after a player spawns.
function cwStamina:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	if (!firstSpawn and !lightSpawn) then
		player:SetCharacterData("Stamina", 100);
	end;
end;

-- Called when a player attempts to throw a punch.
function cwStamina:PlayerCanThrowPunch(player)
	if (player:GetCharacterData("Stamina") <= 10) then
		return false;
	end;
end;

-- Called when a player throws a punch.
function cwStamina:PlayerPunchThrown(player)
	if (Clockwork.config:Get("stam_punch"):Get()) then
		local attribute = Clockwork.attributes:Fraction(player, ATB_STAMINA, 1.5, 0.25) or .5;
		local decrease = 5 / (1 + attribute);
		
		player:SetCharacterData("Stamina", math.Clamp(player:GetCharacterData("Stamina") - decrease, 0, 100));
	end;
end;

-- Called when a player's shared variables should be set.
function cwStamina:PlayerSetSharedVars(player, curTime)
	player:SetSharedVar("Stamina", math.floor(player:GetCharacterData("Stamina")));
end;

-- Called when a player's stamina should regenerate.
function cwStamina:PlayerShouldStaminaRegenerate(player)
	return true;
end;

-- Called when a player's stamina should drain.
function cwStamina:PlayerShouldStaminaDrain(player)
	return true;
end;

-- Called at an interval while a player is connected.
function cwStamina:PlayerThink(player, curTime, infoTable)
	local blood = tonumber(player:GetCharacterData("blood")) or 100;
	local pain = tonumber(player:GetCharacterData("pain")) or 0;
	local respiration = tonumber(player:GetCharacterData("respiration")) or 100;
	local injuries = player:GetInjuries();
	local playerBoost = (player.combatBoost <= CurTime()) or false;
	local medicalScale = 1;

	if (pain >= 30) then
		medicalScale = medicalScale + .2;
	end;

	if (respiration <= 80) then
		medicalScale = medicalScale + .5;
	end;

	if (blood <= 80) then
		medicalScale = medicalScale + .3;
	end;

	if (player:HasInjury("damaged chest")) then
		medicalScale = medicalScale + .3;
	end;

	local regenScale = Clockwork.config:Get("stam_regen_scale"):Get();
	local drainScale = Clockwork.config:Get("stam_drain_scale"):Get();
	drainScale = drainScale * medicalScale;
	local attribute = Clockwork.attributes:Fraction(player, ATB_STAMINA, 1, 0.25) or .3;
	local regeneration = 0;
	local maxHealth = player:GetMaxHealth();
	local healthScale = (drainScale * (math.Clamp(player:Health(), maxHealth * 0.1, maxHealth) / maxHealth));
	local decrease = (drainScale + (drainScale - healthScale)) - ((drainScale * 0.5) * attribute);
	
	if (!player:IsNoClipping() and player:IsOnGround()) then
		local playerVelocityLength = player:GetVelocity():Length();
		if ((infoTable.isRunning or infoTable.isJogging) and playerVelocityLength != 0) then

			local info = {
				drain = decrease
			};

			Clockwork.plugin:Call("PlayerAdjustStaminaDrain", player, info);

			decrease = info.drain;
			//print(decrease)

			if (Clockwork.plugin:Call("PlayerShouldStaminaDrain", player)) then
				player:SetCharacterData(
					"Stamina", math.Clamp(
						player:GetCharacterData("Stamina") - decrease, 0, 100
					)
				);
				
				if (player:GetCharacterData("Stamina") > 1) then
					if (infoTable.isRunning) then
						player:ProgressAttribute(ATB_STAMINA, 0.025, true);
					elseif (infoTable.isJogging) then
						player:ProgressAttribute(ATB_STAMINA, 0.0125, true);
					end;
				end;
			end;
		elseif (playerVelocityLength == 0) then
			if (player:Crouching()) then
				regeneration = (regenScale + attribute) * 2 * math.Clamp(2.5 - medicalScale, .2, 1);
			else
				regeneration = (regenScale + attribute) * math.Clamp(2 - medicalScale, 0, 2);
			end;
		else
			regeneration = regenScale / (1.5 + medicalScale);
		end;
	elseif(!player:IsNoClipping() and !player:IsOnGround() and !player:IsRagdolled()) then
		player.nextJumpTime = CurTime() + .8 * medicalScale;

		local info = {
			drain = decrease
		};

		Clockwork.plugin:Call("PlayerAdjustStaminaDrain", player, info);

		decrease = info.drain;

		if (Clockwork.plugin:Call("PlayerShouldStaminaDrain", player)) then
			player:SetCharacterData(
				"Stamina", math.Clamp(
					player:GetCharacterData("Stamina") - (decrease * 5), 0, 100
				)
			);
		end;
	end;

	if (player.nextJumpTime > CurTime() or player:GetCharacterData("Stamina") < 5) then
		infoTable.jumpPower = -1000;
	end;

	if (regeneration > 0 and Clockwork.plugin:Call("PlayerShouldStaminaRegenerate", player)) then
		local info = {
			regen = regeneration
		};

		Clockwork.plugin:Call("PlayerAdjustStaminaRegeneration", player, info);

		regeneration = info.regen;

		player:SetCharacterData(
			"Stamina", math.Clamp(
				player:GetCharacterData("Stamina") + regeneration, 0, 100
			)
		);
	end;
	
	local newRunSpeed = infoTable.runSpeed * 2;
	local diffRunSpeed = newRunSpeed - infoTable.walkSpeed;
	local maxRunSpeed = Clockwork.config:Get("run_speed"):Get();
	local timeToSprint = Clockwork.config:Get("running_startup"):Get();
	local speedVar = 0;
	
	if (infoTable.isRunning or infoTable.isJogging) then
		speedVar = curTime - player.lastSprint;
		//print(speedVar, player.speedUp)
	else
		speedVar = -(curTime - player.lastSprint) * 1.5;
	end;

	player.lastSprint = curTime;

	player.speedUp = math.Clamp(player.speedUp + speedVar, 1, timeToSprint + 1);

	if (!playerBoost or player:GetCharacterData("Stamina") < 50) then
		infoTable.runSpeed = math.Clamp(newRunSpeed - (diffRunSpeed - ((diffRunSpeed / 100) * player:GetCharacterData("Stamina"))), infoTable.walkSpeed, maxRunSpeed);
	end;

	if (infoTable.isJogging) then
		local walkSpeed = Clockwork.config:Get("walk_speed"):Get();
		local newWalkSpeed = walkSpeed * Clockwork.config:Get("jog_speed"):Get();
		local diffWalkSpeed = newWalkSpeed - walkSpeed;

		if (!playerBoost) then
			infoTable.runSpeed = math.Clamp(newWalkSpeed - (diffWalkSpeed - ((diffWalkSpeed / 100) * player:GetCharacterData("Stamina"))), infoTable.walkSpeed, maxRunSpeed);
		else
			infoTable.runSpeed = math.Clamp(newWalkSpeed, infoTable.walkSpeed, maxRunSpeed);
		end;
		
		if (player:GetCharacterData("Stamina") < 1) then
			player:SetSharedVar("IsJogMode", false);
		end;
	end;

	infoTable.runSpeed = Lerp(player.speedUp/(timeToSprint + 1), infoTable.walkSpeed, infoTable.runSpeed);
	infoTable.walkSpeed = Lerp(player.speedUp/(timeToSprint + 1), infoTable.walkSpeed, infoTable.runSpeed);
	
	local stamina = player:GetCharacterData("Stamina");

	local bPlayerBreathSnd = false;
	
	if (stamina < 30 and Clockwork.event:CanRun("sounds", "breathing")) then
		bPlayerBreathSnd = true;
	end;
	
	if (!player.nextBreathingSound or curTime >= player.nextBreathingSound) then
		if (!Clockwork.player:IsNoClipping(player)) then
			player.nextBreathingSound = curTime + 1;
			
			if (bPlayerBreathSnd) then
				local volume = Clockwork.config:Get("breathing_volume"):Get() - stamina;
				print("breathe sound", volume)

				Clockwork.player:StartSound(player, "LowStamina", "player/breathe1.wav", volume / 100);
			else
				Clockwork.player:StopSound(player, "LowStamina", 4);
			end;
		end;
	end;
end;

function cwStamina:PlayerCharacterLoaded(player)
	player.nextJumpTime = 0;
	player.speedUp = 1;
	player.lastSprint = CurTime();
end;