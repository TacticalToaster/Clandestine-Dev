--[[
	� 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("SayCenterText");
COMMAND.tip = "Broadcast a center text message to all characters.";
COMMAND.text = "<string Text>";
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_FALLENOVER);
COMMAND.access = "o";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local text = table.concat(arguments, " ");

	if (text == "") then
		Clockwork.player:Notify(player, "You did not specify enough text!");

		return;
	end;

	Schema:CenterText(text);
end;

COMMAND:Register();
