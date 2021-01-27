--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("armor_base");
ITEM.name = "AVS Heavy Configuration";
ITEM.uniqueID = "carrier_avs_heavy";
ITEM.weight = 10;
ITEM.maxDurability = 60;
ITEM.resistance = .25;
ITEM.maxDamage = 25;
ITEM.blunt = .15;
ITEM.pocketSpace = 8;
ITEM.speedMod = .6;
ITEM.armorClass = "IV"
ITEM.description = "An AVS carrier configured for maximum protection and capacity. Somewhat light weight considering its capabilities.";

ITEM:Register();