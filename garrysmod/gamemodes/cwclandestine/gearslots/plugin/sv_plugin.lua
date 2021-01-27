--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

function GEARSLOTS:ScaleDamageByItem(item, damageInfo, hitGroup, protectionType)
	for k, v in pairs(item("hitGroups")) do
		if (v == hitGroup) then
			damageInfo:ScaleDamage(1 - (gearItem(protectionType)/100));
		end;
	end;
end;

local playerMeta = FindMetaTable("Player");

-- A function to get a player's clothes data.
function playerMeta:GetGearData()
	print("CACA")
	local gearData = self:GetCharacterData("Gear");
	print(gearData, "DAB", type(gearData))
	//PrintTable(gearData)

	if (type(gearData) != "table" or table.Empty(gearData)) then
		print("YAYEET")
		gearData = {};
		gearData.headSlot = {itemID = nil, uniqueID = nil};
		gearData.chestOneSlot = {itemID = nil, uniqueID = nil};
		gearData.chestTwoSlot = {itemID = nil, uniqueID = nil};
		gearData.legSlot = {itemID = nil, uniqueID = nil};
		gearData.bagOneSlot = {itemID = nil, uniqueID = nil};
		gearData.bagTwoSlot = {itemID = nil, uniqueID = nil};
	end;
	
	return gearData;
end;

-- A function to remove a player's clothes.
function playerMeta:RemoveGear(bRemoveItem)
	self:SetGearData(nil);
	
	if (bRemoveItem) then
		local gearItem = self:GetGearItem();
		
		if (gearItem) then
			self:TakeItem(gearItem);
			return gearItem;
		end;
	end;
end;

-- A function to get the player's clothes item.
function playerMeta:GetGearItem(slot)
	local gearData = self:GetGearData();
	print(gearData, "OOF1")
	//PrintTable(gearData)
	print(slot, "OOF1")
	print(gearData[slot], "OOF1", gearData[slot].itemID)
	
	if (type(gearData) == "table") then
		if (gearData[slot].itemID != nil and gearData[slot].uniqueID != nil) then
			print("OH YEAH")
			return self:FindItemByID(
				gearData.uniqueID, gearData.itemID
			);
		end;
	end;
end;

-- A function to get whether a player is wearing clothes.
//GOTO needs work
function playerMeta:IsWearingAnyGear()
	return (self:GetGearItem() != nil);
end;

-- A function to get whether a player is wearing an item.
function playerMeta:IsWearingGear(itemTable)
	local gearItem = self:GetGearItem(itemTable("gearSlot"));
	print(itemTable, itemTable("gearSlot"))
	print(gearItem, "YEET")
	//PrintTable(gearItem)
	return (gearItem and gearItem:IsTheSameAs(itemTable));
end;

-- A function to network the player's gear data.
function playerMeta:NetworkGearData()
	local gearData = self:GetGearData();

	self:SetSharedVar("Gear", gearData, "Gear");
end;

-- A function to set a player's clothes data.
//GOTO Needs more work
function playerMeta:SetGearData(itemTable)
	if (itemTable && type(itemTable) == "table") then
		local newGearSlot = itemTable("gearSlot");
		local disabledSlots = itemTable("disabledSlots");
		local gearItem = self:GetGearItem(newGearSlot);
		//local model = cwClass:GetAppropriateModel(self:Team(), self, true);
		
		if (gearItem and itemTable != clothesItem) then
			gearItem:OnChangeClothes(self, false);
		end;
		
		itemTable:OnChangeGear(self, true);
		
		local gearData = self:GetGearData();
			gearData[newGearSlot].itemID = itemTable("itemID");
			gearData[newGearSlot].uniqueID = itemTable("uniqueID");
			print(gearData[newGearSlot].itemID, "DAB222")
		self:NetworkGearData();
	elseif (itemTable) then --when itemTable is a string, which means it's letting us know what slot should be made nil
		local gearItem = self:GetGearItem(itemTable);
		local gearData = self:GetGearData();
			gearData[itemTable].itemID = nil;
			gearData[itemTable].uniqueID = nil;
		self:NetworkGearData();
		
		if (gearItem) then
			gearItem:OnChangeGear(self, false);
		end;
	end;
end;