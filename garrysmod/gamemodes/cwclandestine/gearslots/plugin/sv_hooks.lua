--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

function GEARSLOTS:PlayerCharacterInitialized(player)
	player.cwGearSlots = {};
	local gearSlots = player.cwGearSlots;
	gearSlots.headSlot = nil;
	gearSlots.chestOneSlot = nil;
	gearSlots.chestTwoSlot = nil;
	gearSlots.legSlot = nil;
	gearSlots.bagOneSlot = nil;
	gearSlots.bagTwoSlot = nil;
end;

function GEARSLOTS:PlayerScaleDamageByHitGroup(player, attacker, hitGroup, damageInfo, baseDamage)
	for k, v in pairs(player:GetGearData()) do
		if (v.itemID != nil) then
			local gearItem = Clockwork.inventory:FindItemByID(
				player:GetInventory(), v.uniqueID, v.itemID
			);

			if (damageInfo:IsBulletDamage() && gearItem("ballisticProtection") != 0) then
				self:ScaleDamageByItem(gearItem, damageInfo, hitGroup, "ballisticProtection");
				/*for k2, v2 in pairs(gearItem("hitGroups")) do
					if (v2 == hitGroup) then
						damageInfo:ScaleDamage(1 - (gearItem("ballisticProtection")/100);
					end;
				end;*/
			end;

			if (damageInfo:IsExplosionDamage() && gearItem("explosiveProtection") != 0) then
				self:ScaleDamageByItem(gearItem, damageInfo, hitGroup, "explosiveProtection");
			end

			if (damageInfo:IsFallDamage() && gearItem("fallProtection") != 0) then
				self:ScaleDamageByItem(gearItem, damageInfo, hitGroup, "fallProtection");
			end
		end;
	end;
end;