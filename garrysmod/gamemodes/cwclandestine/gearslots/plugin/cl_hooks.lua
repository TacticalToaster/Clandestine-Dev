--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

function GEARSLOTS:LocalPlayerCreated()
	Clockwork.kernel:RegisterNetworkProxy(Clockwork.Client, "Gear", function(entity, name, oldValue, newValue)
		print("BOOM BOOM BOOM")
		if (oldValue != newValue) then
			if (next(newValue) != nil) then
				Clockwork.GearData = newValue;
				print("POOF")
			else
				print("GOOF")
				Clockwork.GearData.headSlot = {itemID = nil, uniqueID = nil};
				Clockwork.GearData.chestOneSlot = {itemID = nil, uniqueID = nil};
				Clockwork.GearData.chestTwoSlot = {itemID = nil, uniqueID = nil};
				Clockwork.GearData.legSlot = {itemID = nil, uniqueID = nil};
				Clockwork.GearData.bagOneSlot = {itemID = nil, uniqueID = nil};
				Clockwork.GearData.bagTwoSlot = {itemID = nil, uniqueID = nil};
			end;
		end;
	end);
end;
