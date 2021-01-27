--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Sentry CBRN Infantry Loadout";
ITEM.uniqueID = "pmc_gasmask";
ITEM.replacement = "models/pmc/pmc_1/pmc__07.mdl";
ITEM.weight = 4;
ITEM.business = true;
ITEM.cost = 220;
ITEM.access = "V"
ITEM.protection = .3;
ITEM.description = "A Sentry infantry loadout that includes a gasmask capable of dealing with CBRN threats.";

ITEM:Register();