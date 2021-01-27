local INJURY = Clockwork.injury:New();
INJURY.name = "Severe Bleed";
INJURY.delay = 30;
INJURY.decay = 0;
INJURY.description = "A large opening in the body. There's an alarming amount of blood exiting the wound.";
INJURY.victim = "You feel your skin get ripped open, leaving a large open wound. Copious amounts of viscous blood seep out of the wound.";
INJURY.defaultData = {hasInfection = false};

function INJURY:OnThink(player, data)

end;

function INJURY:OnAcquire(player, data)
	local pain = player:GetCharacterData("pain");

	player:SetCharacterData("pain", pain + 12);
end;

function INJURY:OnEnd(player, data, treater)
	local pain = player:GetCharacterData("pain");

	player:SetCharacterData("pain", pain - 8);

	if (!treater) then return end;

	if (treater.glovesPatient != player:Name() or treater.glovesTime < CurTime()) then
		treater.glovesTime = 1;

		local chance = math.random(1, 100);

		if (chance <= 80) then
			timer.Simple(math.random(120, 300), function()
				if (player and player:Alive()) then
					player:GiveWoundInfection("bacterial infection");
				end;
			end);
		end;
	end;

	treater.glovesPatient = player:Name();

	//player:GiveInjury("laceration")
end;

function INJURY:OnDelay(player, data)
	local blood = player:GetCharacterData("blood");
	local pain = player:GetCharacterData("pain");

	player:SetCharacterData("blood", blood - 10);
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
			data.infectionChance = data.infectionChance + 8
		end;
	else
		data.infectionChance = 10;
	end;
end;

INJURY:Register();

