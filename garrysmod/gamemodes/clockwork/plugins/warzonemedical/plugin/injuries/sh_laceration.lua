local INJURY = Clockwork.injury:New();
INJURY.name = "Laceration";
INJURY.delay = 60;
INJURY.decay = 0;
INJURY.description = "A deep cut or gash that is bleeding profusely.";
INJURY.victim = "There’s a slicing, tugging sensation, followed by a warm liquid. Upon checking, you notice a severe laceration.";
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

	player:SetCharacterData("blood", blood - 10);

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
		data.infectionChance = 0;
	end;
end;

INJURY:Register();

