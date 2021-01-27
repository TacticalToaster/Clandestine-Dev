--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Sentry Scout Loadout";
ITEM.uniqueID = "pmc_scout";
ITEM.replacement = "models/pmc/pmc_1/pmc__03.mdl";
ITEM.weight = 2;
ITEM.business = true;
ITEM.cost = 85;
ITEM.access = "V"
ITEM.protection = .15;
ITEM.description = "A Sentry loadout that is designed to be light weight.";

ITEM:Register();