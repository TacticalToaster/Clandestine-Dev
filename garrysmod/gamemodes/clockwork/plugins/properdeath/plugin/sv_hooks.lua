local PLUGIN = PLUGIN;

function PLUGIN:PlayerCanDeathDropInventory(player, inflictor, attacker, damageInfo)
	//return true;
end;

function PLUGIN:PlayerDeath(player, inflictor, attacker, damageInfo)
	local ragdoll = player:GetRagdollEntity();

	if (IsValid(ragdoll)) then

		if (Clockwork.plugin:Call("PlayerCanDeathDropInventory", player, inflictor, attacker, damageInfo)) then
			ragdoll.cwIsBelongings = true;
			ragdoll.cwInventory = Clockwork.inventory:CreateDuplicate(player:GetInventory());
			ragdoll.cwCash = player:GetCash();
			ragdoll:SetRenderMode(RENDERMODE_NORMAL);

			player:SetCharacterData("Inventory", {}, true);
			player:SetCharacterData("Cash", 0, true);
		end;
	end;
end;

function PLUGIN:EntityHandleMenuOption(player, entity, option, arguments)
	if (entity:GetClass() == "prop_ragdoll" and arguments == "cwContainerOpen") then
		if (!entity.cwInventory) then entity.cwInventory = {}; end;
		if (!entity.cwCash) then entity.cwCash = 0; end;

		local bodyPlayer = Clockwork.entity:GetPlayer(entity);

		local searchInv = entity.cwInventory;
		local searchCash = entity.cwCash;

		if (bodyPlayer and bodyPlayer:Alive() and bodyPlayer:IsRagdolled() and bodyPlayer:GetRagdollEntity() == entity) then
			searchInv = bodyPlayer:GetInventory();
			searchCash = bodyPlayer:GetCash();
		end;
		
		player:EmitSound("physics/body/body_medium_impact_soft"..math.random(1, 7)..".wav");
		
		Clockwork.storage:Open(player, {
			name = "Corpse",
			weight = 12,
			entity = entity,
			distance = 192,
			cash = searchCash,
			inventory = searchInv,
			OnGiveCash = function(player, storageTable, cash)
				entity.cwCash = storageTable.cash;
			end,
			OnTakeCash = function(player, storageTable, cash)
				entity.cwCash = storageTable.cash;
			end
		});
	end;
end;