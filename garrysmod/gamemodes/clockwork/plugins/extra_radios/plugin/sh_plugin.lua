Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
//Clockwork.kernel:IncludePrefixed("cl_plugin.lua");

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	local sharedVars, sharedTables = Clockwork.kernel:GetSharedVars();

	sharedTables["frequencies"] = {};
end;