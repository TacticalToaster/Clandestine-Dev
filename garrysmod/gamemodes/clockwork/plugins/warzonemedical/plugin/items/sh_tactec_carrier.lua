--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("armor_base");
ITEM.name = "TacTec Plate Carrier (III)";
ITEM.uniqueID = "carrier_tactec_iii";
ITEM.weight = 7;
ITEM.maxDurability = 50;
ITEM.resistance = .4;
ITEM.maxDamage = 15;
ITEM.blunt = .1;
ITEM.pocketSpace = 5;
ITEM.speedMod = .8;
ITEM.armorClass = "III"
ITEM.description = "A light weight plate carrier sporting light weight plates capable of stopping rifle rounds. There's plenty of pouches for extra ammunition.";

ITEM:Register();