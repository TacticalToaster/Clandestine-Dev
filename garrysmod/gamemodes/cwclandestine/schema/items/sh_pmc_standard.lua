--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Sentry Standard Loadout";
ITEM.uniqueID = "pmc_standard";
ITEM.replacement = "models/pmc/pmc_1/pmc__12.mdl";
ITEM.weight = 3.5;
ITEM.business = true;
ITEM.cost = 210;
ITEM.access = "V"
ITEM.protection = .24;
ITEM.description = "A standard issue uniform and plate carrier used by new Sentry contractors.";

ITEM:Register();