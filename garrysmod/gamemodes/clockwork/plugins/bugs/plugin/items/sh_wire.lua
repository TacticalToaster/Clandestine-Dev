--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Wire";
ITEM.uniqueID = "wire";
ITEM.model = "models/deadbodies/dead_male_civilian_radio.mdl";
ITEM.weight = 1;
ITEM.access = "v";
ITEM.category = "Communication";
ITEM.business = true;
ITEM.description = "A large and bulky wire with a frequency tuner.";
//ITEM.customFunctions = {"Frequency"};

ITEM:AddData("Frequency", 101.1, true);

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	local entity = player:GetEyeTraceNoCursor().Entity;
	local target = Clockwork.entity:GetPlayer(entity);

	if (target and entity:GetPos():Distance( player:GetShootPos() ) <= 192) then
		target:Wire(self:GetData("Frequency"));
	else
		Clockwork.player:Notify(player, "You aren't close enough to wire someone!");
		return false;
	end;
end;

function ITEM:GetEntityMenuOptions(menuPanel, options)
	local freq = self:GetData("Frequency");
	local itemID = self("itemID");
	local uniqueID = self("uniqueID");

	if (CLIENT) then
		options["Set Frequency"] = function()
			Derma_StringRequest("Frequency", "What would you like to set the frequency to?", freq, function(text)
				Clockwork.kernel:RunCommand("SetWireFreq", uniqueID, itemID, text);
				
				if (!Clockwork.menu:GetOpen()) then
					gui.EnableScreenClicker(false);
				end;
			end);
			
			if (!Clockwork.menu:GetOpen()) then
				gui.EnableScreenClicker(true);
			end;
		end;
	end;
end;

/*
if (SERVER) then
	function ITEM:OnCustomFunction(player, name)
		if (name == "Frequency") then
			Clockwork.datastream:Start(player, "BugFrequency", {["uniqueID"] = self("uniqueID"), ["itemID"] = self("itemID"), ["frequency"] = self:GetData("Frequency")});
		end;
	end;
end;
*/

ITEM:Register();