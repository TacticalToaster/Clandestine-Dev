local ITEM = Clockwork.item:New("accessory_base");

ITEM.name = "PNV-10T NVDs";
ITEM.uniqueID = "nv";
ITEM.cost = 15;
ITEM.weight = 1;
ITEM.business = false;
ITEM.category = "Accessories";
ITEM.description = "A cheap NVD that uses one monocle split between both eyes.";

-- Called when a player wears the accessory.
function ITEM:OnWearAccessory(player, isWearing)
	if (isWearing) then
		if (SERVER) then
			for i,v in pairs(player:GetAccessoryData()) do
				print(i, v, "E")
				if (string.lower(v) == "flir" or string.lower(v) == "nv") then
					local goggleItem = player:GetItemInstance(string.lower(v), i);
					player:RemoveAccessory(goggleItem);
				end;
			end;
		end;
		print("WEARING NVD")
		player:SetSharedVar("nvdType", "nv")
	else
		print("NOT WEARING NVD")
		player:SetSharedVar("nvdType", "");
	end;
end;

ITEM:Register();