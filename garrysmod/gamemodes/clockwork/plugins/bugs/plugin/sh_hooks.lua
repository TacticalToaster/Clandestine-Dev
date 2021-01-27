local PLUGIN = PLUGIN;

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	local sharedVars, sharedTables = Clockwork.kernel:GetSharedVars();

	globalVars:Bool("pagersOn");

	sharedTables["wires"] = {};
end;