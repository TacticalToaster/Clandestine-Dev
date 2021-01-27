local PLUGIN = PLUGIN;

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	globalVars:String("fadeColor");
	globalVars:Bool("fadeOn");
end;