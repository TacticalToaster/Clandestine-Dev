--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("SetChannelFrequency");
COMMAND.tip = "Set your radio's channel frequencies.";
COMMAND.text = "[number Channel] [number Frequency]";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 2;
COMMAND.alias = {"SetChFreq", "SCF"};

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local frequency = arguments[2];
	local channel = arguments[1];

	local data = player:GetCharacterData("frequencies");

	if (data == nil or !istable(data)) then
		data = {};
	end
	
	if (string.find(frequency, "^%d%d%d%.%d$")) then
		local start, finish, decimal = string.match(frequency, "(%d)%d(%d)%.(%d)");
		
		start = tonumber(start);
		finish = tonumber(finish);
		decimal = tonumber(decimal);
		
		if (start == 1 and finish > 0 and finish < 10 and decimal > 0 and decimal < 10) then
			data[tonumber(channel)] = tonumber(frequency);

			player:SetCharacterData("frequencies", data);
			
			Clockwork.player:Notify(player, "You have set channel "..channel.." to the frequency "..frequency..".");
		else
			Clockwork.player:Notify(player, "The radio frequency must be between 101.1 and 199.9!");
		end;
	else
		Clockwork.player:Notify(player, "The radio frequency must look like xxx.x!");
	end;
end;

COMMAND:Register();