Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("sh_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("cl_plugin.lua");

Clockwork.plugin:AddExtra("/injuries/");
Clockwork.plugin:AddExtra("/meta/");

function PLUGIN:GetActionTimeModifier(player)
	local timeMod = 1;
	local blood = tonumber(player:GetCharacterData("blood"));
	local pain = tonumber(player:GetCharacterData("pain"));
	local respiration = tonumber(player:GetCharacterData("respiration"));

	if (player:HasInjury("damaged arm")) then
		timeMod = timeMod + .25;
	end;

	if (player:HasInjury("concussion")) then
		timeMod = timeMod + .1;
	end;

	if (player:HasInjury("traumatic brain injury")) then
		timeMod = timeMod + .15;
	end;

	if (pain >= 30) then
		timeMod = timeMod + .1;
	end;

	if (respiration <= 80) then
		timeMod = timeMod + .1;
	end;

	return timeMod;
end;