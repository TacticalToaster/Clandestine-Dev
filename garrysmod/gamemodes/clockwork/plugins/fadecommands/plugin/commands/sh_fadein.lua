local PLUGIN = PLUGIN;
local player = player;
local libPlayer = player;

local COMMAND = Clockwork.command:New("FadeIn");
COMMAND.tip = "Make everyone fade back in.";
COMMAND.text = "<Float Fade Time>";
COMMAND.flags = 0;
COMMAND.access = "a";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local fadeTime = tonumber(arguments[1]);
	local fadeColor = string.ToColor(Clockwork.kernel:GetSharedVar("fadeColor")) or Color( 255, 255, 255, 255 );

	if (!fadeTime) then
		fadeTime = 1;
	end;

	Clockwork.kernel:SetSharedVar("fadeOn", false);

	for i,v in pairs(libPlayer.GetAll()) do
		v:ScreenFade(SCREENFADE.IN + SCREENFADE.PURGE, fadeColor, fadeTime, 0)
	end;

	Clockwork.player:Notify(player, "Fading back in.");
end;

COMMAND:Register();