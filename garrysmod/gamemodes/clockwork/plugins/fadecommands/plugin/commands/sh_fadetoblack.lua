local PLUGIN = PLUGIN;
local player = player;
local libPlayer = player;

local COMMAND = Clockwork.command:New("FadeToBlack");
COMMAND.tip = "Make everyone fade to black.";
COMMAND.text = "<Float Fade Time>";
COMMAND.flags = 0;
COMMAND.access = "a";
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local fadeTime = tonumber(arguments[1]);

	if (!fadeTime) then
		fadeTime = 1;
	end;

	for i,v in pairs(libPlayer.GetAll()) do
		v:ScreenFade(SCREENFADE.OUT + SCREENFADE.STAYOUT, Color( 0, 0, 0, 255 ), fadeTime, 0)
	end;

	Clockwork.kernel:SetSharedVar("fadeOn", true);
	Clockwork.kernel:SetSharedVar("fadeColor", string.FromColor(Color( 0, 0, 0, 255 )));

	Clockwork.player:Notify(player, "Fading to black.");
end;

COMMAND:Register();