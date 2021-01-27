--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

-- Called when Clockwork has loaded all of the entities.
function Schema:ClockworkInitPostEntity() end;

-- Called when data should be saved.
function Schema:SaveData() end;

-- Called just after data should be saved.
function Schema:PostSaveData() end;

-- Called when a player's default model is needed.
function Schema:GetPlayerDefaultModel(player) end;

function Schema:PlayerAdjustCharacterCreationInfo(player, info)
   if info.faction == FACTION_SENTRY then
     local title = "Rct.";

     info.name = ("%s %s"):format(title, info.name);
   end;
end;

-- Called when a player's default inventory is needed.
function Schema:GetPlayerDefaultInventory(player, character, inventory)
	if (character.faction == FACTION_SENTRY) then
		Clockwork.inventory:AddInstance(
			inventory, Clockwork.item:CreateInstance("weapon_ehl2w_m9")
		);
		Clockwork.inventory:AddInstance(
			inventory, Clockwork.item:CreateInstance("ammo_pistol")
		);
		Clockwork.inventory:AddInstance(
			inventory, Clockwork.item:CreateInstance("handheld_radio")
		);
	elseif (character.faction == FACTION_OPFOR) then
		Clockwork.inventory:AddInstance(
			inventory, Clockwork.item:CreateInstance("handheld_radio")
		);
		Clockwork.inventory:AddInstance(
			inventory, Clockwork.item:CreateInstance("weapon_ehl2w_m9")
		);
		for i = 1, 2 do
			Clockwork.inventory:AddInstance(
				inventory, Clockwork.item:CreateInstance("ammo_pistol")
			);
		end;
	/*elseif (character.faction == FACTION_BLUFOR) then
		Clockwork.inventory:AddInstance(
			inventory, Clockwork.item:CreateInstance("handheld_radio")
		);
		Clockwork.inventory:AddInstance(
			inventory, Clockwork.item:CreateInstance("weapon_ehl2w_m9")
		);
		Clockwork.inventory:AddInstance(
			inventory, Clockwork.item:CreateInstance("ammo_pistol")
		);
		Clockwork.inventory:AddInstance(
			inventory, Clockwork.item:CreateInstance("weapon_ehl2w_m4a1")
		);
		Clockwork.inventory:AddInstance(
			inventory, Clockwork.item:CreateInstance("ammo_556x45")
		);*/
	else
		Clockwork.inventory:AddInstance(
			inventory, Clockwork.item:CreateInstance("suitcase")
		);
	end;
end;
