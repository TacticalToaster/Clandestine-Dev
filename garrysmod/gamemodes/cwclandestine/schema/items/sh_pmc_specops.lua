--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Sentry Bump Loadout";
ITEM.uniqueID = "pmc_specops";
ITEM.replacement = "models/pmc/pmc_1/pmc__09.mdl";
ITEM.weight = 2.5;
ITEM.business = true;
ITEM.cost = 135;
ITEM.access = "V"
ITEM.protection = .23;
ITEM.description = "A light weight loadout used by Sentry Operations Group.";

ITEM:Register();