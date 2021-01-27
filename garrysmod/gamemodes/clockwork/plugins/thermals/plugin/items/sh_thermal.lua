local ITEM = Clockwork.item:New("accessory_base");

ITEM.name = "FLIR Thermal NVDs";
ITEM.uniqueID = "flir";
ITEM.cost = 15;
ITEM.weight = 1;
ITEM.business = false;
ITEM.category = "Accessories";
ITEM.description = "A pair of multi-purpose, battery-powered FLIR NVDs.";

-- Called when a player wears the accessory.
function ITEM:OnWearAccessory(player, isWearing)
	if (isWearing) then
		if (SERVER) then
			for i,v in pairs(player:GetAccessoryData()) do
				if (string.lower(v) == "flir" or string.lower(v) == "nv") then
					local goggleItem = player:GetItemInstance(string.lower(v), i);
					player:RemoveAccessory(goggleItem);
				end;
			end;
		end;
		print("WEARING FLIR")
		player:SetSharedVar("nvdType", "flir")
	else
		print("NOT WEARING FLIR")
		player:SetSharedVar("nvdType", "");
	end;
end;

ITEM:Register();