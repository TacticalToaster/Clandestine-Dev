--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("SetWireFreq");
COMMAND.tip = "Set a wire's frequency.";
COMMAND.text = "[string UniqueID] [string ItemID] [number Frequency]";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 3;
COMMAND.alias = {"SetWireFreq", "SWF"};

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local uniqueID = arguments[1];
	local itemID = arguments[2];
	local frequency = arguments[3];

	local wire = player:FindItemByID(uniqueID, itemID);

	if (wire) then
		if (string.find(frequency, "^%d%d%d%.%d$")) then
			local start, finish, decimal = string.match(frequency, "(%d)%d(%d)%.(%d)");
			
			start = tonumber(start);
			finish = tonumber(finish);
			decimal = tonumber(decimal);
			
			if (start == 1 and finish > 0 and finish < 10 and decimal > 0 and decimal < 10) then
				wire:SetData("Frequency", frequency);
				
				Clockwork.player:Notify(player, "You have set the wire's frequency to "..frequency..".");
			else
				Clockwork.player:Notify(player, "The wire frequency must be between 101.1 and 199.9!");
			end;
		else
			Clockwork.player:Notify(player, "The wire frequency must look like xxx.x!");
		end;
	end;
end;

COMMAND:Register();