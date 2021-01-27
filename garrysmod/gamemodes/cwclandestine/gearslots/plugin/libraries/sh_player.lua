-- A function to get the local player's clothes data.
function Clockwork.player:GetGearData()
	return Clockwork.GearData;
end;

-- A function to get the local player's clothes item.
function Clockwork.player:GetGearItem(slot)
	local gearData = self:GetGearData();
	//print(slot, "LOL")
	//print(gearData[slot], "LOL")
	
	if (type(gearData) == "table") then
		if (gearData[slot].itemID != nil and gearData[slot].uniqueID != nil) then
			return self:FindItemByID(
				gearData.uniqueID, gearData.itemID
			);
		end;
	end;
end;

-- A function to get whether the local player is wearing clothes.
//GOTO needs work
function Clockwork.player:IsWearingAnyGear()
	return (self:GetClothesItem() != nil);
end;

-- A function to get whether the local player is wearing an item.
function Clockwork.player:IsWearingGear(itemTable)
	local gearItem = self:GetGearItem(itemTable("gearSlot"));
		//print(gearItem, "REE")
	//PrintTable(gearItem)
	return (gearItem and gearItem:IsTheSameAs(itemTable));
end;