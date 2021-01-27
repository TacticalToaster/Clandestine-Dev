--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("armor_base");
ITEM.name = "AVS Light Configuration";
ITEM.uniqueID = "carrier_avs_light";
ITEM.weight = 6;
ITEM.maxDurability = 40;
ITEM.resistance = .45;
ITEM.maxDamage = 15;
ITEM.blunt = .1;
ITEM.pocketSpace = 3;
ITEM.speedMod = .9;
ITEM.armorClass = "III"
ITEM.description = "An extremely light-weight plate carrier configuration that sacrifices durability for speed.";

ITEM:Register();