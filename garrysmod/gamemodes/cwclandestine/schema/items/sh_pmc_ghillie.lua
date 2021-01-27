--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Pre-War Ghillie Suit";
ITEM.uniqueID = "pmc_ghillie";
ITEM.replacement = "models/humans/group03/suit_gh.mdl";
ITEM.weight = 3;
ITEM.business = true;
ITEM.cost = 100;
ITEM.access = "V"
ITEM.protection = .15;
ITEM.description = "A pre-war military ghillie suit used for concealment in vegetation.";

ITEM:Register();