--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Sentry Light Loadout";
ITEM.uniqueID = "pmc_light";
ITEM.replacement = "models/pmc/pmc_1/pmc__02.mdl";
ITEM.weight = 3.5;
ITEM.business = true;
ITEM.cost = 210;
ITEM.access = "V"
ITEM.protection = .2;
ITEM.description = "A standard issue uniform without the helmet used by Sentry contractors.";

ITEM:Register();