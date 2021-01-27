--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("armor_base");
ITEM.name = "Kevlar Vest";
ITEM.uniqueID = "vest_kevlar";
ITEM.weight = 3;
ITEM.maxDurability = 32;
ITEM.resistance = .6;
ITEM.maxDamage = 6;
ITEM.blunt = .35;
ITEM.armorClass = "IIIA"
ITEM.description = "Very light and comfortable ballistic vest, but it's fairly weak, even against pistol rounds.";

ITEM:Register();