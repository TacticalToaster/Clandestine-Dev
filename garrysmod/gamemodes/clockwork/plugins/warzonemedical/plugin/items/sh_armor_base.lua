--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("clothes_base");
ITEM.name = "Armor Base Cool";
ITEM.uniqueID = "armor_base";
ITEM.category = "Armor";
ITEM.weight = 3;
ITEM.maxDurability = 10;
ITEM.resistance = 1;
ITEM.maxDamage = 10;
ITEM.blunt = .35;
ITEM.armorClass = "IIIA"
//ITEM.business = true;
//ITEM.cost = 100;
//ITEM.protection = .2;
ITEM.description = "A set of generic armor.";
//ITEM.maskOverlay = Material( "OIIJIOT/gasmaskdmxmd" );
//ITEM.canTakeDamage = true;
//ITEM.damagePerCondition = 5;

ITEM:AddData("Durability", ITEM.maxDurability, true);

function ITEM:OnInstantiated()
	if (SERVER) then
		self:SetData("Durability", self.maxDurability);
	end;
end;

function ITEM:GetDurability()
	print("Durability is ", self:GetData("Durability"))
	return self:GetData("Durability");
end;

function ITEM:DamageDurability(damageInfo)
	local oldDura = self:GetDurability();
	local newDura = oldDura-(self.resistance*damageInfo:GetDamage());

	print("OUCH", oldDura, newDura);

	self:SetData("Durability", newDura);
end;

function ITEM:GetMaxDamage()
	local dmgModifier = Clockwork.config:Get("scale_chest_dmg"):Get();

	/*if (ConVarExists("ehl2w_damage_scale")) then
		dmgModifier = dmgModifier * GetConVar("ehl2w_damage_scale"):GetFloat();
	end;*/

	print("Max damage is ", self.maxDamage * dmgModifier)

	return self.maxDamage * dmgModifier;
end;

if (CLIENT) then
	function ITEM:GetClientSideInfo()
		if (!self:IsInstance()) then return; end;

		local markupText = "";

		if self.armorClass then
			markupText = Clockwork.kernel:AddMarkupLine(markupText, "Ballistic Rating: "..self.armorClass);
		end

		if self.maxDurability then
			markupText = Clockwork.kernel:AddMarkupLine(markupText, "Durability: "..self:GetData("Durability").."/"..self.maxDurability);
		end

		if self.pocketSpace then
			markupText = Clockwork.kernel:AddMarkupLine(markupText, "Capacity: "..self.pocketSpace.."kg");
		end
		
		if (Clockwork.player:IsWearingItem(self)) then
			markupText = Clockwork.kernel:AddMarkupLine(markupText, "Wearing: Yes");
		else
			markupText = Clockwork.kernel:AddMarkupLine(markupText, "Wearing: No");
		end;

		return (markupText != "" and markupText);
	end;

	function ITEM:GetClientSideModel()
		return self.model;
	end;
end;

ITEM:Register();