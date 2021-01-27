local playerMeta = FindMetaTable("Player");

function playerMeta:Wire(freq)
	local wires = self:GetCharacterData("wires");
	wires[freq] = true;
	self:SetCharacterData("wires", wires);
end;