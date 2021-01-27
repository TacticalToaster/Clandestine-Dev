--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Sentry Advisor Loadout";
ITEM.uniqueID = "pmc_officer";
ITEM.replacement = "models/pmc/pmc_1/pmc__01.mdl";
ITEM.weight = 4;
ITEM.business = true;
ITEM.cost = 210;
ITEM.access = "V"
ITEM.protection = .26;
ITEM.description = "A standard Sentry loadout that includes a beret. Used for contractors in advisor and management roles.";

ITEM:Register();