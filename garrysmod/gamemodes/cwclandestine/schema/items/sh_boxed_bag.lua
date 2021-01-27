--[[
	� 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Boxed Bag";
ITEM.cost = 15;
ITEM.model = "models/props_junk/cardboard_box004a.mdl";
ITEM.weight = 1;
ITEM.access = "1v";
ITEM.useText = "Open";
ITEM.category = "Storage"
ITEM.business = true;
ITEM.description = "A brown box, open it to reveal its contents.";
ITEM.lootTables = {retail = 4}

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	if (player:HasItemByID("small_bag") and table.Count(player:GetItemsByID("small_bag")) >= 2) then
		Clockwork.player:Notify(player, "You've hit the bags limit!");
		
		return false;
	end;
	
	player:GiveItem(Clockwork.item:CreateInstance("small_bag"));
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

ITEM:Register();