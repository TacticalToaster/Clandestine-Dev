local PLUGIN = PLUGIN;

function PLUGIN:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	local fadeOn = Clockwork.kernel:GetSharedVar("fadeOn");
	local fadeColor = string.ToColor(Clockwork.kernel:GetSharedVar("fadeColor")) or Color( 255, 255, 255, 255 );

	if (fadeOn) then
		player:ScreenFade(SCREENFADE.OUT + SCREENFADE.STAYOUT, fadeColor, 0, 0);
	end;
end;