--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("Page");

COMMAND.tip = "Page another character's pager with a message.";
COMMAND.text = "<string Character> <string Text>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])

	if (Clockwork.kernel:GetSharedVar("pagersOn")) then
		if (player:HasItemByID("pager")) then
			if (target and target:HasItemByID("pager")) then
				Clockwork.chatBox:Add({player, target}, player, "page", table.concat(arguments, " ", 2));
			else
				Clockwork.player:Notify(player, {"NotValidPlayer", arguments[1]});
			end;
		else
			Clockwork.player:Notify(player, "You don't have a pager to use!");
		end;
	else
		Clockwork.player:Notify(player, "There isn't a pager network available!");
	end;
end;

COMMAND:Register();
