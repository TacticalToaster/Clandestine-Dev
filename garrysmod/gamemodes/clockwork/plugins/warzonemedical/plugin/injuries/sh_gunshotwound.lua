local INJURY = Clockwork.injury:New();
INJURY.name = "Gunshot Wound";
INJURY.delay = 30;
INJURY.decay = 0;
INJURY.description = "An opening in the body caused by a bullet.";
INJURY.victim = "You feel as though you’ve just been hit with a rock, and the air is knocked from your chest. You feel blood trickling down from the site of the injury.";
INJURY.defaultData = {hasInfection = false};

function INJURY:OnThink(player, data)

end;

function INJURY:OnAcquire(player, data)
	local pain = player:GetCharacterData("pain");

	player:SetCharacterData("pain", pain + 10);
end;

function INJURY:OnEnd(player, data, treater)
	local pain = player:GetCharacterData("pain");

	player:SetCharacterData("pain", pain - 10);

	if (!treater) then return end;

	if (treater.glovesPatient != player:Name() or treater.glovesTime < CurTime()) then
		treater.glovesTime = 1;

		local chance = math.random(1, 100);

		if (chance <= 70) then
			timer.Simple(math.random(120, 300), function()
				if (player and player:Alive()) then
					player:GiveWoundInfection("bacterial infection");
				end;
			end);
		end;
	end;

	treater.glovesPatient = player:Name();
end;

function INJURY:OnDelay(player, data)
	local blood = player:GetCharacterData("blood");
	local pain = player:GetCharacterData("pain");

	player:SetCharacterData("blood", blood - 5);
	player:SetCharacterData("pain", pain + 5);

	if (data.infectionChance and (!data.hasInfection or !player:HasInjury("bacterial infection"))) then
		if (data.infectionChance >= math.random(1, 100)) then
			data.hasInfection = true;
			timer.Simple(math.random(120, 300), function()
				if (player and player:Alive()) then
					player:GiveWoundInfection("bacterial infection");
				end;
			end);
		else
			data.infectionChance = data.infectionChance + 5
		end;
	else
		data.infectionChance = 5;
	end;
end;

INJURY:Register();

