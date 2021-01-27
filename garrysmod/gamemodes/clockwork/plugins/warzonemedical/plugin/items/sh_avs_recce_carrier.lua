--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("armor_base");
ITEM.name = "AVS Recce Configuration";
ITEM.uniqueID = "carrier_avs_recce";
ITEM.weight = 8;
ITEM.maxDurability = 45;
ITEM.resistance = .3;
ITEM.maxDamage = 15;
ITEM.blunt = .12;
ITEM.pocketSpace = 6;
ITEM.speedMod = .85;
ITEM.armorClass = "III"
ITEM.description = "A multi-purpose configuration of the AVS perfect for recon.";

ITEM:Register();