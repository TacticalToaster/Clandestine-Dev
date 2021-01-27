--[[
	� 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Meloxicam Tablet";
ITEM.uniqueID = "meloxicam";
ITEM.model = "models/carlsmei/escapefromtarkov/medical/analgin.mdl";
ITEM.weight = 0.1;
ITEM.useText = "Take";
ITEM.category = "Medical - Oral"
//ITEM.useSound = "items/medshot4.wav";
ITEM.description = "A small package containing a tiny 15mg white tablet. The package says use once a day.";

//ITEM:AddData("Uses", 0, true);

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	local entity = player:GetEyeTraceNoCursor().Entity;
	local target = Clockwork.entity:GetPlayer(entity);
	
	if (target and entity:GetPos():Distance( player:GetShootPos() ) <= 192) then
		local pain = target:GetCharacterData("pain");
		if (!target:HasInjury("unconsciousness")) then
			target:SetCharacterData("pain", pain - 10);
			Clockwork.chatBox:Add(player, nil, "treat", "* You have given the patient the tablet!");
		else
			Clockwork.player:Notify(player, "The patient can't take the pill while unconscious!");
			return false;
		end;
	else
		local pain = player:GetCharacterData("pain");
		player:SetCharacterData("pain", pain - 10);
		Clockwork.chatBox:Add(player, nil, "treat", "* You have taken the tablet!");
	end;

	/*local currentUses = self:GetData("Uses");

	if (currentUses + 1 < self.totalUses) then
		self:SetData("Uses", currentUses + 1);
		return true;
	end;*/
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;
/*
if (CLIENT) then
	function ITEM:GetClientSideInfo()
		if (!self:IsInstance()) then return; end;

		local markupText = "";
		
		//markupText = Clockwork.kernel:AddMarkupLine(markupText, "Uses left: ".. self:GetData("Uses") or 1);
		//markupText = Clockwork.kernel:AddMarkupLine(markupText, "Total health amount: ".. self.totalHeal or 1);
		//markupText = Clockwork.kernel:AddMarkupLine(markupText, "Time to heal: ".. self.totalTime or 1);

		return (markupText != "" and markupText);
	end;
end;*/

ITEM:Register();