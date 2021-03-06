local INJURY = Clockwork.injury:New();
INJURY.name = "Damaged Stomach";
INJURY.delay = 60;
INJURY.decay = 0;
INJURY.description = "Massive damage to the stomach and intenstines that is permanent.";
INJURY.victim = "Repeated injury to your lower torso has caused permanent damage to your digestive track.";
INJURY.limit = 1;

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

