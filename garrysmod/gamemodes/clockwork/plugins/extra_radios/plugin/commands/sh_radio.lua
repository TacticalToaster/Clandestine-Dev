--[[
	© 2015 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("Radio");
COMMAND.tip = "Send a radio message out to other characters using a multi-channel radio.";
COMMAND.text = "[number Channel] <string Text>";
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_DEATHCODE, CMD_FALLENOVER);
COMMAND.arguments = 2;
//COMMAND.optionalArguments = 1;
COMMAND.alias = {"R"};

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local channel = tonumber(arguments[1])

	if (channel) then
		if (math.Round(channel) < 4) then
			local freq = player:GetCharacterData("frequencies")[channel];

			if (freq) then
				local text = arguments;
				table.remove(text, 1);
				Clockwork.player:SayRadio(player, table.concat(text, " "), true, false, {frequency = freq});
			else
				Clockwork.player:Notify(player, "That channel doesn't have a frequency set!");
			end;
		else
			Clockwork.player:Notify(player, "You can only use channels 1-3!");
		end;
	else
		Clockwork.player:Notify(player, "You need to specify which channel you're talking on!");
	end;
end;

COMMAND:Register();