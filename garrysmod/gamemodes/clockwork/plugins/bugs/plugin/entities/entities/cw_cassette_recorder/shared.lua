--[[
	� 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

DEFINE_BASECLASS("base_gmodentity");

ENT.Type = "anim";
ENT.Author = "TacticalToaster";
ENT.PrintName = "Bug";
ENT.Spawnable = false;
ENT.AdminSpawnable = false;

-- Called when the data tables are setup.
function ENT:SetupDataTables()
	self:DTVar("Bool", 0, "off");
	self:DTVar("Bool", 1, "transmit");
end;

-- A function to get the frequency.
function ENT:GetFrequency()
	return self:GetNetworkedString("frequency");
end;

-- A function to get whether the entity is off.
function ENT:IsOff()
	return self:GetDTBool(0);
end;

-- A function to get whether the entity is transmitting or receiving.
function ENT:IsTransmitting()
	return self:GetDTBool(1);
end;