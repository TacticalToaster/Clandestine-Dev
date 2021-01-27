local PLUGIN = PLUGIN;

local playerMeta = FindMetaTable("Player");

-- A function to get a player's clothes data.
function playerMeta:GetOpticalData()
	local clothesData = self:GetCharacterData("Optic");

	if (type(clothesData) != "table") then
		clothesData = {};
	end;
	
	return clothesData;
end;