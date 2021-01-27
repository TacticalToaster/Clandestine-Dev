local PLUGIN = PLUGIN;
local player = player;
local libPlayer = player;

local COMMAND = Clockwork.command:New("TogglePagers");
COMMAND.tip = "Toggle pagers on or off.";
COMMAND.text = "";
COMMAND.flags = 0;
COMMAND.access = "a";
COMMAND.arguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	//local fadeTime = tonumber(arguments[1]);
	if (Clockwork.kernel:GetSharedVar("pagersOn")) then
		Clockwork.kernel:SetSharedVar("pagersOn", false);
	else
		Clockwork.kernel:SetSharedVar("pagersOn", true);
	end;
	
	print("ah, ", Clockwork.kernel:GetSharedVar("pagersOn"), !Clockwork.kernel:GetSharedVar("pagersOn"), !(Clockwork.kernel:GetSharedVar("pagersOn")))

	if (Clockwork.kernel:GetSharedVar("pagersOn")) then
		Clockwork.player:Notify(player, "Pagers are now on.");
	else
		Clockwork.player:Notify(player, "Pagers are now off.");
	end;
end;

COMMAND:Register();