local PLUGIN = PLUGIN;

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Number("blood", true);
	playerVars:Number("pain", true);
	playerVars:Number("respiration", true);
	playerVars:Number("medic", true);
	//playerVars:Entity("injuries", true);
end;