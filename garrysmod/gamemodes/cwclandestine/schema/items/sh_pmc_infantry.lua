--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Sentry Infantry Loadout";
ITEM.uniqueID = "pmc_infantry";
ITEM.replacement = "models/pmc/pmc_1/pmc__06.mdl";
ITEM.weight = 4;
ITEM.business = true;
ITEM.cost = 210;
ITEM.access = "V"
ITEM.protection = .3;
ITEM.description = "A heavier infantry loadout used by Sentry for direct action operations.";

ITEM:Register();