local INJURY = Clockwork.injury:New();
INJURY.name = "Damaged Arm";
INJURY.delay = 60;
INJURY.decay = 0;
INJURY.description = "Massive damage to the arm that is permanent.";
INJURY.victim = "Repeated injury to your arm has caused permanent damage in your muscles.";
INJURY.limit = 2;

function INJURY:OnThink(player, data)

end;

function INJURY:OnAcquire(player, data)
	local pain = player:GetCharacterData("pain");

	player:SetCharacterData("pain", pain + 10);
end;

function INJURY:OnEnd(player, data, treater)
end;

function INJURY:OnDelay(player, data)
end;

INJURY:Register();

