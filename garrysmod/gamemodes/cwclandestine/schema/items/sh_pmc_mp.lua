--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Sentry Security Loadout";
ITEM.uniqueID = "pmc_mp";
ITEM.replacement = "models/pmc/pmc_1/pmc__14.mdl";
ITEM.weight = 3;
ITEM.business = true;
ITEM.cost = 190;
ITEM.access = "V"
ITEM.protection = .26;
ITEM.description = "A Sentry loadout that includes a ballistic-rated faceshield, standard for riot control.";

ITEM:Register();