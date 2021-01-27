function GEARSLOTS:ClockworkItemInitialized(itemTable)
	if itemTable("defaultDurability") then
		itemTable:AddData("gearDurability", 100, true);
	end;
end;