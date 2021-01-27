local PLUGIN = PLUGIN;

-- Called when a player's character data should be restored.
function PLUGIN:PlayerRestoreCharacterData(player, data)
	if ( !data["blood"] ) then
		data["blood"] = 100;
	end;
	if ( !data["pain"] ) then
		data["pain"] = 0;
	end;
	if ( !data["respiration"] ) then
		data["respiration"] = 100;
	end;
	if ( !data["injuries"] ) then
		data["injuries"] = {};
	end;
	if ( !data["medic"] ) then
		data["medic"] = 0;
	end;
	/*if ( !data["radiation"] ) then
		data["radiation"] = 0;
	end;*/
end;

-- Called when a player's shared variables should be set.
function PLUGIN:PlayerSetSharedVars(player, curTime)
	player:SetSharedVar( "blood", math.Clamp(player:GetCharacterData("blood"), 0, 100));
	player:SetSharedVar( "pain", math.Clamp(player:GetCharacterData("pain"), 0, 100));
	player:SetSharedVar( "respiration", math.Clamp(player:GetCharacterData("respiration"), 0, 100));
	//player:SetSharedVar( "injuries", player:GetCharacterData("injuries") or {});
	//print(player:GetCharacterData("injuries"))
	
	/*
	if (player:Alive() and !player:IsRagdolled() and player:GetVelocity():Length() > 0) then
		if (player:GetCharacterData("hydration") == 100) then
			player:BoostAttribute("Hydration", ATB_ACROBATICS, -40);
			player:BoostAttribute("Hydration", ATB_ENDURANCE, -40);
			player:BoostAttribute("Hydration", ATB_STRENGTH, -40);
			player:BoostAttribute("Hydration", ATB_AGILITY, -40);
			player:BoostAttribute("Hydration", ATB_DEXTERITY, -40);
			player:BoostAttribute("Hydration", ATB_MEDICAL, -40);
		else
			player:BoostAttribute("Hydration", ATB_ACROBATICS, false);
			player:BoostAttribute("Hydration", ATB_ENDURANCE, false);
			player:BoostAttribute("Hydration", ATB_STRENGTH, false);
			player:BoostAttribute("Hydration", ATB_AGILITY, false);
			player:BoostAttribute("Hydration", ATB_DEXTERITY, false);
			player:BoostAttribute("Hydration", ATB_MEDICAL, false);
		end;
	end;
	if (player:Alive() and !player:IsRagdolled() and player:GetVelocity():Length() > 0) then
		if (tonumber(player:GetCharacterData("hunger")) >= 70) then
			player:BoostAttribute("Hunger", ATB_ACROBATICS, -10);
			player:BoostAttribute("Hunger", ATB_ENDURANCE, -10);
			player:BoostAttribute("Hunger", ATB_STRENGTH, -10);
			player:BoostAttribute("Hunger", ATB_AGILITY, -10);
			player:BoostAttribute("Hunger", ATB_DEXTERITY, -10);
			player:BoostAttribute("Hunger", ATB_MEDICAL, -10);
		elseif (tonumber(player:GetCharacterData("hunger")) >= 80) then
			player:BoostAttribute("Hunger", ATB_ACROBATICS, -25);
			player:BoostAttribute("Hunger", ATB_ENDURANCE, -25);
			player:BoostAttribute("Hunger", ATB_STRENGTH, -25);
			player:BoostAttribute("Hunger", ATB_AGILITY, -25);
			player:BoostAttribute("Hunger", ATB_DEXTERITY, -25);
			player:BoostAttribute("Hunger", ATB_MEDICAL, -25);
		elseif (tonumber(player:GetCharacterData("hunger")) >= 90) then
			player:BoostAttribute("Hunger", ATB_ACROBATICS, -30);
			player:BoostAttribute("Hunger", ATB_ENDURANCE, -30);
			player:BoostAttribute("Hunger", ATB_STRENGTH, -30);
			player:BoostAttribute("Hunger", ATB_AGILITY, -30);
			player:BoostAttribute("Hunger", ATB_DEXTERITY, -30);
			player:BoostAttribute("Hunger", ATB_MEDICAL, -30);
		else
			player:BoostAttribute("Hunger", ATB_ACROBATICS, false);
			player:BoostAttribute("Hunger", ATB_ENDURANCE, false);
			player:BoostAttribute("Hunger", ATB_STRENGTH, false);
			player:BoostAttribute("Hunger", ATB_AGILITY, false);
			player:BoostAttribute("Hunger", ATB_DEXTERITY, false);
			player:BoostAttribute("Hunger", ATB_MEDICAL, false);
		end;
	end;
	if (player:Alive() and !player:IsRagdolled() and player:GetVelocity():Length() > 0) then
		if (tonumber(player:GetCharacterData("radiation")) >= 50) then
			player:BoostAttribute("Radiation", ATB_ACROBATICS, -25);
			player:BoostAttribute("Radiation", ATB_ENDURANCE, -25);
			player:BoostAttribute("Radiation", ATB_STRENGTH, -25);
			player:BoostAttribute("Radiation", ATB_AGILITY, -25);
			player:BoostAttribute("Radiation", ATB_DEXTERITY, -25);
			player:BoostAttribute("Radiation", ATB_MEDICAL, -25);
		end;
	end;*/
end;

-- Called at an interval while a player is connected.
function PLUGIN:PlayerThink(player, curTime, infoTable)
	local alive = player:Alive();
	local faction = player:GetFaction();
	local curTime = CurTime();

	player:SetCharacterData("blood", math.Clamp(player:GetCharacterData("blood"), 0, 100));
	player:SetCharacterData("pain", math.Clamp(player:GetCharacterData("pain"), 0, 100));
	player:SetCharacterData("respiration", math.Clamp(player:GetCharacterData("respiration"), 0, 100));

	local blood = tonumber(player:GetCharacterData("blood"));
	local pain = tonumber(player:GetCharacterData("pain"));
	local respiration = tonumber(player:GetCharacterData("respiration"));
	local injuries = player:GetInjuries();

	if (!player.reviveTime) then
		player.reviveTime = 0;
	end;

	if (!player.statRegenTime) then
		player.statRegenTime = CurTime();
	end;

	for i,v in pairs(injuries) do
		local injuryTable = Clockwork.injury:FindByID(v.type);

		if (injuryTable) then
			if (injuryTable.OnDelay) then
				if (v.delay <= CurTime()) then
					injuryTable:OnDelay(player, v);
					v.delay = CurTime() + injuryTable.delay;
				end;
			end;

			if (injuryTable.OnThink) then
				injuryTable:OnThink(player, v);
			end;
		end;
	end;
	
	if ( player:Alive() ) then
		//blood
		if (blood <= 0 and !player.dyingBlood) then
			player.dyingBlood = true;
			Clockwork.chatBox:Add(player, nil, "injurykill", "** Your body fails, as there is not enough blood to supply it properly. You die soon after.");
			timer.Simple(5, function()
				if (player:Alive()) then
					player:Kill();
					player.deathIsPK = true;
					Clockwork.player:NotifyAdmins("o", player:Name().." has died due to bloodloss!", "death");
					/*if (!Clockwork.player:IsProtected(player)) then
						Clockwork.player:SetBanned(player, true);
					end;*/
					//player:KillSilent();
				end;
			end);
		elseif (blood <= 30 and !player:HasInjury("unconsciousness") and !player.dyingBlood) then
			//player.knockedBlood = true;
			Clockwork.chatBox:Add(player, nil, "injury", "** You feel extremely tired, and in short time you fall unconscious.");
			if (player:Alive()) then
				//Clockwork.player:SetRagdollState(player, RAGDOLL_KNOCKEDOUT, nil);
				player:GiveInjury("unconsciousness");
				player.reviveTime = CurTime() + 180;
			end;
		end;

		//pain
		if (pain >= 80 and !player:HasInjury("unconsciousness")) then
			//player.knockedPain = true;
			Clockwork.chatBox:Add(player, nil, "injury", "** Everything aches and feels numb at the same time as you drift into unconscious.");
			if (player:Alive()) then
				//Clockwork.player:SetRagdollState(player, RAGDOLL_KNOCKEDOUT, nil);
				player:GiveInjury("unconsciousness");
				player.reviveTime = CurTime() + 180;
			end;
		elseif (pain >= 50 and !player.immobilizedPain and !player:HasInjury("unconsciousness") and (player.combatBoost <= CurTime() or player.combatBoostCooldown >= CurTime())) then //GOTO check this
			player.immobilizedPain = true;
			Clockwork.chatBox:Add(player, nil, "injury", "** Your pain grows in strength, hurting everytime you move. You're effectively immobilized.");
			timer.Simple(2, function()
				if (player:Alive()) then
					Clockwork.player:SetRagdollState(player, RAGDOLL_FALLENOVER, nil);
					player:SetSharedVar("FallenOver", false);
				end;
			end);
		end;

		//respiration
		if (respiration <= 0 and !player.dyingRespiration) then
			player.dyingRespiration = true;
			Clockwork.chatBox:Add(player, nil, "injurykill", "** Life itself fades away as you suffocate to death.");
			timer.Simple(5, function()
				if (player:Alive()) then
					player:Kill();
					player.deathIsPK = true;
					Clockwork.player:NotifyAdmins("o", player:Name().." has died due to suffocation!", "death");
					/*if (!Clockwork.player:IsProtected(player)) then
						Clockwork.player:SetBanned(player, true);
					end;*/
				end;
			end);
		elseif (respiration <= 50 and !player:HasInjury("unconsciousness") and !player.dyingRespiration) then
			player.knockedRespiration = true;
			Clockwork.chatBox:Add(player, nil, "injury", "** As it becomes increasingly harder to breathe, you drift into an unconscious state.");
			if (player:Alive()) then
				//Clockwork.player:SetRagdollState(player, RAGDOLL_KNOCKEDOUT, nil);
				player:GiveInjury("unconsciousness");
			end;
		end;

		if (respiration > 50 and blood > 30 and pain < 80 and player:HasInjury("unconsciousness") and CurTime() >= player.reviveTime) then
			player:TreatInjuries("unconsciousness");
			Clockwork.chatBox:Add(player, nil, "treat", "** You come back to your senses, taking in the environment. You feel better then before.");
		end;

		if (respiration > 50 and blood > 30 and pain < 50 and player:GetRagdollState() == RAGDOLL_FALLENOVER and player:GetSharedVar("FallenOver") == false) then
			player:SetSharedVar("FallenOver", true);
			Clockwork.chatBox:Add(player, nil, "treat", "** As your pain lessens, you're once again able to move freely.");
		end;

		local bPlayerBreathSnd = false;

		if (respiration <= 80 and respiration > 50 and Clockwork.event:CanRun("sounds", "breathing") and (self:GetCharacterData("Stamina") and self:GetCharacterData("Stamina") >= 30)) then
			bPlayerBreathSnd = true;
		end;
		
		if (!player.nextRespirationSound or curTime >= player.nextRespirationSound) then
			if (!Clockwork.player:IsNoClipping(player)) then
				player.nextRespirationSound = curTime + 1;
				
				if (bPlayerBreathSnd) then
					local volume = 20 + respiration;

					Clockwork.player:StartSound(player, "Respiration", "player/breathe1.wav", volume / 100);
				else
					Clockwork.player:StopSound(player, "Respiration", 1);
				end;
			end;
		end;

		local bPlayerPainSnd = false;

		if (pain >= 20 and pain < 80 and Clockwork.event:CanRun("sounds", "pain")) then
			bPlayerPainSnd = true;
		end;
		
		if (!player.nextPainSound or curTime >= player.nextPainSound) then
			if (!Clockwork.player:IsNoClipping(player)) then
				player.nextPainSound = curTime + math.random(4, 7);
				
				if (bPlayerPainSnd) then
					local painSound = "vo/npc/male01/moan01.wav";
					local painRandom = math.random(1, 5);
					local volume = 20 + pain;

					if (player:GetGender() == GENDER_MALE) then
						painSound = "vo/npc/male01/moan0"..painRandom..".wav";
					else
						painSound = "vo/npc/female01/moan0"..painRandom..".wav";
					end;

					if (pain >= 45) then
						painRandom = math.random(1, 9);

						if (player:GetGender() == GENDER_MALE) then
							player:EmitSound("vo/npc/male01/pain0"..painRandom..".wav");
						else
							player:EmitSound("vo/npc/female01/pain0"..painRandom..".wav");
						end;
					else
						Clockwork.player:StartSound(player, "Pain", painSound, volume / 100);
					end;
				else
					Clockwork.player:StopSound(player, "Pain", 4);
				end;
			end;
		end;

		if (CurTime() >= player.statRegenTime) then
			player:SetCharacterData("respiration", math.Clamp(respiration + .1, 0, 100));
			player:SetCharacterData("blood", math.Clamp(blood + .033, 0, 100));
			player:SetCharacterData("pain", math.Clamp(pain - .1, 0, 100));
			player.statRegenTime = player.statRegenTime + 1;
		end;

		/*if (player:Health() <= 15 and !player:HasInjury("unconsciousness")) then
			player:GiveInjury("unconsciousness");
			player:SetHealth(50);
		end;*/

		local medSpeedMod = 1;
		local medWeightMod = 1;

		if (player:HasInjury("damaged leg")) then
			medSpeedMod = medSpeedMod * .75;
		end;

		if (player:HasInjury("damaged chest")) then
			medWeightMod = medWeightMod * .75;
		end;

		if (player.combatBoost >= CurTime() or player.combatBoostCooldown <= CurTime()) then
			medSpeedMod = medSpeedMod * 1.35
		end;

		infoTable.walkSpeed = infoTable.walkSpeed * medSpeedMod;
		infoTable.runSpeed = infoTable.runSpeed * medSpeedMod;
		infoTable.jumpPower = infoTable.jumpPower * medSpeedMod;

		infoTable.inventoryWeight = infoTable.inventoryWeight * medWeightMod;

		local clothes = player:GetClothesItem();

		if (clothes) then
			if (clothes.pocketSpace) then
				infoTable.inventoryWeight = infoTable.inventoryWeight + clothes.pocketSpace;
			end;

			if (clothes.speedMod) then
				infoTable.walkSpeed = infoTable.walkSpeed * clothes.speedMod;
				infoTable.runSpeed = infoTable.runSpeed * clothes.speedMod;
			end;
		end;
	end;
end;

function PLUGIN:ChatBoxAdjustInfo(info)
	local speaker = info.speaker;
	local talkRadius = Clockwork.config:Get("talk_radius"):Get();
	local newListeners = {};
	//local newListenersHearing = {};

	if (speaker and (info.class == "ic" or info.class == "yell" or info.class == "whisper")) then
		if (speaker:HasInjury("damaged voice")) then
			local text = info.text;
			local textLength = string.len(text);
			local randomCharacters = math.ceil(textLength/3);
			local textTable = string.ToTable(text);

			for i=1, randomCharacters do
				if (math.random(0, 1) == 1) then
					table.insert(textTable, math.random(2, #textTable), string.char(math.random(97, 122)));
				end;
			end;

			info.text = table.concat(textTable, "");
		end;
	end;

	if (info.class == "ic" or info.class == "yell") then
		local radius = talkRadius;

		if (info.class == "yell") then
			radius = radius * 2;
		end;

		if (speaker) then
			if (speaker:HasInjury("damaged voice")) then
				radius = radius * .75;
			end;
		end;

		for k, v in pairs(info.listeners) do
			if (v:HasInitialized()) then
				local listenerRadius = radius;

				if (v:HasInjury("damaged hearing")) then
					listenerRadius = listenerRadius * .6;
				end;

				if (speaker:GetPos():Distance(v:GetPos()) <= listenerRadius) then
					newListeners[#newListeners + 1] = v;
				end;
			end;
		end;

		info.listeners = newListeners;
	end;
end;

function PLUGIN:PlayerShouldStaminaRegenerate(player)
	local faction = player:GetFaction();
	if ( tonumber(player:GetCharacterData("respiration")) <= 60 ) then
		return false;
	end;
end;

-- Called when a player uses an item.
function PLUGIN:PlayerUseItem(player, itemTable, itemEntity)
	if itemTable.blood then
		player:SetCharacterData( "blood", math.Clamp(player:GetCharacterData("blood") + itemTable.blood, 0, 100) );
	end;
	
	if itemTable.pain then
		player:SetCharacterData( "pain", math.Clamp(player:GetCharacterData("pain") - itemTable.pain, 0, 100) );
	end;
	
	if itemTable.respiration then
		player:SetCharacterData( "respiration", math.Clamp(player:GetCharacterData("respiration") + itemTable.respiration, 0, 100) );
	end;
end;

function PLUGIN:PlayerScaleDamageByHitGroup(player, attacker, hitGroup, damageInfo, baseDamage)
	local armorItem = player:GetClothesItem();

	if (damageInfo:GetDamage() >= 5 and !player:HasInjury("unconsciousness") and CurTime() + 30 >= player.combatBoost) then
		player.combatBoost = CurTime() + 30;
	end;

	if (hitgroup == HITGROUP_CHEST and player:HasInjury("damaged chest")) then
		damageInfo:ScaleDamage(1.5);
	elseif (hitgroup == HITGROUP_STOMACH and player:HasInjury("damaged stomach")) then
		damageInfo:ScaleDamage(1.1);
	elseif (hitgroup == HITGROUP_LEFTARM and player:HasInjury("damaged arm")) then
		damageInfo:ScaleDamage(1.1);
	elseif (hitgroup == HITGROUP_RIGHTARM and player:HasInjury("damaged arm")) then
		damageInfo:ScaleDamage(1.1);
	elseif (hitgroup == HITGROUP_LEFTLEG and player:HasInjury("damaged leg")) then
		damageInfo:ScaleDamage(1.2);
	elseif (hitgroup == HITGROUP_RIGHTLEG and player:HasInjury("damaged leg")) then
		damageInfo:ScaleDamage(1.2);
	end;

	if (armorItem and armorItem.GetDurability and armorItem:GetDurability() > 0) then
		if (damageInfo:IsBulletDamage()) then
			print("thas a lot of damage ", damageInfo:GetDamage() < armorItem:GetMaxDamage(), damageInfo:GetDamage(), armorItem:GetMaxDamage())
			if (armorItem.GetMaxDamage and damageInfo:GetDamage() < armorItem:GetMaxDamage()) then
				armorItem:DamageDurability(damageInfo);
				damageInfo:ScaleDamage(armorItem.blunt or 0);

				local soundNumber = math.random(1, 4);
				player:EmitSound("physics/metal/metal_solid_impact_bullet"..soundNumber..".wav", 130, 80, 1, CHAN_BODY);

				if (damageInfo:GetDamage() > 5) then
					//player:GiveInjury("blunt trauma");
					local pain = player:GetCharacterData("pain");
					player:SetCharacterData("pain", pain - 4);
				end;

				return;
			else
				armorItem:DamageDurability(damageInfo:GetDamage() * 1.5);

				local soundNumber = math.random(1, 3);
				player:EmitSound("physics/metal/metal_computer_impact_bullet"..soundNumber..".wav", 110, 90, 1, CHAN_BODY);
			end;
		end;
	end;

	local permInjChance = math.random(1, 100);

	if (permInjChance <= 5) then
		if (hitgroup == HITGROUP_CHEST) then
			player:GiveInjury("damaged chest");
		elseif (hitgroup == HITGROUP_STOMACH) then
			player:GiveInjury("damaged stomach");
		elseif (hitgroup == HITGROUP_HEAD) then
			local headChance = math.random(1, 3);
			if (headChance == 1) then
				player:GiveInjury("damaged voice");
			elseif (headchance == 2) then
				player:GiveInjury("damaged hearing");
			elseif (headchance == 3) then
				player:GiveInjury("damaged voice"); //GOTO Change this back to vision once it's finished
			end;
		elseif (hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM) then
			player:GiveInjury("damaged arm");
		elseif (hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG) then
			player:GiveInjury("damaged leg");
		end;
	end;

	if (damageInfo:IsBulletDamage()) then
		local chance = math.random(1, 10)

		if (hitGroup == HITGROUP_CHEST and chance <= 3) then
			player:GiveInjury("gunshot wound");
			player:GiveInjury("sucking chest wound");
		elseif ((hitgroup != HITGROUP_HEAD or hitgroup != HITGROUP_CHEST) and chance <= 1) then
			player:GiveInjury("severe bleed");
		elseif (hitgroup == HITGROUP_HEAD) then
			player:GiveInjury("concussion");
		elseif chance <= 6 then
			player:GiveInjury("gunshot wound");
		end;
	elseif (damageInfo:IsDamageType(DMG_SLASH)) then
		//if (hitGroup != HITGROUP_CHEST) then
			player:GiveInjury("laceration");
		//end;
	elseif (damageInfo:IsDamageType(DMG_BURN)) then
		//if (hitGroup != HITGROUP_CHEST) then
			player:GiveInjury("burn wound");
		//end;
	elseif (damageInfo:IsDamageType(DMG_BLAST)) then
		player:GiveInjury("burn wound");

		if (math.random(0, 1) == 1) then
			player:GiveInjury("laceration");
		end;

		if (damageInfo:GetDamage() >= 15 and !player:IsRagdolled()) then
			Clockwork.player:SetRagdollState(player, RAGDOLL_FALLENOVER, nil, nil, damageInfo:GetDamageForce());
			player:SetSharedVar("FallenOver", true);
		end;
	end;
end;

function PLUGIN:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	player.dyingRespiration = false;
	player.dyingBlood = false;
	player.immobilizedPain = false;

	print("Im a virgin", !lightSpawn, !changeClass, player:GetFaction() != FACTION_OPFOR, !lightSpawn and !changeClass and !player:GetFaction() != FACTION_OPFOR)

	if (!lightSpawn and !changeClass and player:GetFaction() != FACTION_OPFOR) then
		print("Ah fuck ", player.deathCount % 2 != 0)
		if (player.deathCount % 2 != 0 and !player.deathIsPK) then
			if (player.deathPos) then
				player:SetPos(player.deathPos);
				//print("Moving player to "..player.deathPos)
			end;
		end;
	end;

	player.deathIsPK = false;

	if (player:GetFaction() == FACTION_OPFOR and !lightSpawn) then
		player:SetCharacterData("blood", 100);
		player:SetCharacterData("respiration", 100);
		player:SetCharacterData("pain", 0);

		local injuries = player:GetInjuries();

		for i,v in pairs(injuries) do
			local injuryTable = Clockwork.injury:FindByID(v.type);

			if (injuryTable.OnEnd) then
				injuryTable:OnEnd(player, v);
			end;
		end;

		player:SetCharacterData( "injuries", {} )
	end;

	if (player:GetCharacterData("blood") <= 0) then
		player:SetCharacterData("blood", 20);
	end;

	if (player:GetCharacterData("respiration") <= 0) then
		player:SetCharacterData("respiration", 20);
	end;

	player:ResetInjuries();
end;

function PLUGIN:DoPlayerDeath(player, attacker, damageInfo)
	player.deathPos = player:GetPos() + Vector(0, 0, 8);
	
	if (player.deathCount) then
		player.deathCount = player.deathCount + 1;
	else
		player.deathCount = 1;
	end

	player.combatBoost = 0;

	if (!player:HasInjury("unconsciousness")) then
		player:GiveInjury("unconsciousness");
		player.reviveTime = CurTime() + 30;
		Clockwork.chatBox:Add(player, nil, "injury", "** Your body becomes overwhelmed from the injuries it sustains, and you lose consciousness.");
		if (attacker:IsPlayer()) then
			Clockwork.player:NotifyAdmins("o", player:Name().." has died from low health and is now unconscious! "..attacker:Name().." killed them!", "death");
		else
			Clockwork.player:NotifyAdmins("o", player:Name().." has died from low health and is now unconscious!", "death");
		end;
	else
		player.reviveTime = math.Clamp(player.reviveTime + 30, CurTime() + 30, math.huge);
		Clockwork.chatBox:Add(player, nil, "injury", "** Your body is damaged severely while you're unconscious.");
		if (attacker:IsPlayer()) then
			Clockwork.player:NotifyAdmins("o", player:Name().." has been double tapped while unconscious by "..attacker:Name().."!", "death");
		else
			Clockwork.player:NotifyAdmins("o", player:Name().." has died while unconscious!", "death");
		end;
	end;

	if (player.deathCount >= 2) then
		if (player.deathCount % 2 != 0 and !player.deathIsPK) then
			Clockwork.player:NotifyAdmins("o", player:Name().." has died "..player.deathCount.." times!", "death");
		else
			Clockwork.player:NotifyAdmins("o", player:Name().." has died "..player.deathCount.." times and will respawn at their default respawn location. This should be a PK.", "death");
			player:TreatInjury("unconsciousness");

			local injuries = player:GetInjuries();

			if (injuries) then
				for i,v in pairs(injuries) do
					local injuryTable = Clockwork.injury:FindByID(v.type);

					if (injuryTable.OnEnd) then
						injuryTable:OnEnd(player);
					end;
				end;
			end;

			player:SetCharacterData( "injuries", {} )
			player:SetCharacterData( "pain", 0 )
			player:SetCharacterData( "respiration", 100 )
			player:SetCharacterData( "blood", 100 )
		end;
	end;
end;

function PLUGIN:PlayerDeath(player, inflictor, attacker, damageInfo)
	local ragdoll = player:GetRagdollEntity();

	if (IsValid(ragdoll) and player:HasInjury("unconsciousness") and !player:GetCharacterData("CharBanned") and player:GetFaction() != FACTION_OPFOR) then
		ragdoll:Remove();
	end;
end;

function PLUGIN:PlayerCanDeathDropInventory(player, inflictor, attacker, damageInfo)
	if (!player:HasInjury("unconsciousness") or player:GetCharacterData("CharBanned")) then
		return true;
	else
		return false;
	end;
end;

function PLUGIN:PlayerCharacterLoaded(player)
	player.reviveTime = 0;
	player.combatBoost = 0;
	player.combatBoostCooldown = 0;
	player.deathPos = nil;
	player.deathCount = 0;
	player.deathIsPK = false;
	player.dyingRespiration = false;
	player.dyingBlood = false;
	player.immobilizedPain = false;
	player.sterileWounds = {};
	player.antibioticTime = 0;
	player.glovesPatient = "";
	player.glovesTime = 0;
end;