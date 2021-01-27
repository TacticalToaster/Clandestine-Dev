--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("armor_base");
ITEM.name = "BulletSafe IIIA Vest";
ITEM.uniqueID = "vest_bulletsafe";
ITEM.weight = 4;
ITEM.maxDurability = 32;
ITEM.resistance = .5;
ITEM.maxDamage = 6;
ITEM.blunt = .25;
ITEM.speedMod = .95;
ITEM.armorClass = "IIIA"
ITEM.description = "A black vest void of any real features besides straps. It's fairly comfortable to wear, even under clothing.";

ITEM:Register();