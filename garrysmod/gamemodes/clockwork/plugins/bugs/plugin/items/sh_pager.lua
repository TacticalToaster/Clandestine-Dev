--[[
	� 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Pager";
ITEM.uniqueID = "pager";
ITEM.model = "models/deadbodies/dead_male_civilian_radio.mdl";
ITEM.weight = 1;
ITEM.category = "Communication";
ITEM.description = "A small device with a few buttons, meant for use with a connected pager network.";
/*
ITEM.customFunctions = {"Frequency"};
*/

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;
/*
if (SERVER) then
	function ITEM:OnCustomFunction(player, name)
		if (name == "Frequency") then
			Clockwork.datastream:Start(player, "Frequency", player:GetCharacterData("frequency", ""));
		end;
	end;
end;
*/

ITEM:Register();