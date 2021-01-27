--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Sentry Light CBRN Loadout";
ITEM.uniqueID = "pmc_light_gasmask";
ITEM.replacement = "models/pmc/pmc_1/pmc__04.mdl";
ITEM.weight = 3.5;
ITEM.business = true;
ITEM.cost = 210;
ITEM.access = "V"
ITEM.protection = .2;
ITEM.description = "A standard issue uniform without the helmet, but including a gaskmask for CBRN protection, used by Sentry contractors.";

ITEM:Register();