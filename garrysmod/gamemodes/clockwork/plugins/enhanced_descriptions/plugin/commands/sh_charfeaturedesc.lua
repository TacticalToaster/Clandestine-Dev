--[[
	© 2015 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("CharFeatureDesc");
COMMAND.tip = "Change your character's feature description.";
COMMAND.text = "[string Text]";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local minimumPhysDesc = 0//Clockwork.config:Get("minimum_physdesc"):Get();

	if (arguments[1]) then
		local text = table.concat(arguments, " ");
		
		if (string.utf8len(text) < minimumPhysDesc) then
			Clockwork.player:Notify(player, "The physical description must be at least "..minimumPhysDesc.." characters long!");
			return;
		end;
		
		player:SetCharacterData("featureDesc", Clockwork.kernel:ModifyPhysDesc(text));
	else
		Clockwork.dermaRequest:RequestString(player, "Feature Description Change", "What do you want to change your feature description to?", player:GetSharedVar("featureDesc"), function(result)
			player:RunClockworkCmd(self.name, result);
		end)
	end;
end;

COMMAND:Register();