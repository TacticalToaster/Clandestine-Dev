/*Clockwork.config:AddToSystem("Hunger Tick Time", "stats_hunger_tick", "Tick time (in seconds) for checking/changing hunger.");
Clockwork.config:AddToSystem("Hydration Tick Time", "stats_hydration_tick", "Tick time (in seconds) for checking/changing hydration.");
Clockwork.config:AddToSystem("Toxicity Tick Time", "stats_toxicity_tick", "Tick time (in seconds) for checking/changing toxicity.");
Clockwork.config:AddToSystem("Radiation Tick Time", "stats_radiation_tick", "Tick time (in seconds) for checking/changing radiation.");*/

local PLUGIN = PLUGIN;

PLUGIN.nextInjuryNotification = 0;

Clockwork.chatBox:RegisterClass("injury", "ic", function(info)
	//local localized = Clockwork.chatBox:LangToTable("ChatPlayerDisconnect", Color(200, 150, 200, 255), info.text);

	if (CurTime() >= PLUGIN.nextInjuryNotification) then
		PLUGIN.nextInjuryNotification = CurTime() + .3;

		Clockwork.chatBox:SetMultiplier(.7);
		
		Clockwork.chatBox:Add(info.filtered, "icon16/injury.png", Color(204, 113, 88, 255), info.text);
	end;
end);

Clockwork.chatBox:RegisterClass("injurykill", "ic", function(info)
	//local localized = Clockwork.chatBox:LangToTable("ChatPlayerDisconnect", Color(200, 150, 200, 255), info.text);
	
	Clockwork.chatBox:Add(info.filtered, "icon16/death.png", Color(176, 97, 76, 255), info.text);
end);

Clockwork.chatBox:RegisterClass("treat", "ic", function(info)
	//local localized = Clockwork.chatBox:LangToTable("ChatPlayerDisconnect", Color(200, 150, 200, 255), info.text);
	
	Clockwork.chatBox:SetMultiplier(.7);

	Clockwork.chatBox:Add(info.filtered, "icon16/treat.png", Color(150, 204, 41, 255), info.text);
end);