--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local Clockwork = Clockwork;

local ITEM = Clockwork.item:New(nil, true);
ITEM.name = "Gear Base";
ITEM.model = "models/props_c17/suitcase_passenger_physics.mdl";
ITEM.weight = 2;
ITEM.useText = "Wear";
ITEM.gearSlot = "chestTwoSlot";
ITEM.disabledSlots = {"chestOneSlot"};
ITEM.hitGroups = {HITGROUP_CHEST, HITGROUP_STOMACH};
ITEM.ballisticProtection = 20;
ITEM.explosiveProtection = 10;
ITEM.fallProtection = 0;
ITEM.durability = 60;
ITEM.category = "Gear";
ITEM.description = "A suitcase with a ballistics vest.";

-- Called when a player changes clothes.
function ITEM:OnChangeGear(player, bIsWearing)
	/*if (bIsWearing) then
		local replacement = nil;
		
		if (self.GetReplacement) then
			replacement = self:GetReplacement(player);
		end;
		
		if (type(replacement) == "string") then
			player:SetModel(replacement);
		elseif (self("replacement")) then
			player:SetModel(self("replacement"));
		elseif (self("group")) then
			player:SetModel("models/humans/"..self("group").."/"..self:GetModelName(player));
		end;
	else
		Clockwork.player:SetDefaultModel(player);
		Clockwork.player:SetDefaultSkin(player);
	end;*/
	
	if (self.OnChangedGear) then
		self:OnChangedGear(player, bIsWearing);
	end;
end;

-- Called to get whether a player has the item equipped.
function ITEM:HasPlayerEquipped(player, bIsValidWeapon)
	if (CLIENT) then
		return Clockwork.player:IsWearingGear(self);
	else
		return player:IsWearingGear(self);
	end;
end;

-- Called when a player has unequipped the item.
function ITEM:OnPlayerUnequipped(player, extraData)
	player:RemoveGear();
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position)
	if (player:IsWearingGear(self)) then
		Clockwork.player:Notify(player, "You cannot drop this while you are wearing it!");
		return false;
	end;
end;

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	//self:HasPlayerEquipped();
	if (self("whitelist") and !table.HasValue(self("whitelist"), player:GetFaction())) then
		Clockwork.player:Notify(player, "Your faction cannot wear this gear!");
		return false;
	end;
	
	if (player:Alive() and !player:IsRagdolled()) then
		//if (self:CanPlayerWearGear(player, itemEntity) != false) then
			player:SetGearData(self);
			//print(player:IsWearingGear(self))
			//player:
			return true;
		//end;
	else
		Clockwork.player:Notify(player, "You cannot do this action at the moment!");
	end;
	
	return false;
end;

/*if (CLIENT) then
	function ITEM:GetClientSideInfo()
		if (!self:IsInstance()) then return; end;
		
		local durability = self:GetData("gearDurability");
		local clientSideInfo = "";
		local durabilityColor = Color((255 / 100) * (100 - durability), (255 / 100) * durability, 0, 255);
	
		clientSideInfo = Clockwork.kernel:AddMarkupLine(
			clientSideInfo, "Durability: "..math.floor(durability).."%", durabilityColor
		);
	
		return (clientSideInfo != "" and clientSideInfo);
	end;
end;*/

if (CLIENT) then
	function ITEM:GetClientSideInfo()
		if (!self:IsInstance()) then return; end;
		
		if (Clockwork.player:IsWearingGear(self)) then
			return "Is Wearing: Yes";
		else
			return "Is Wearing: No";
		end;
	end;
end;

Clockwork.item:Register(ITEM);