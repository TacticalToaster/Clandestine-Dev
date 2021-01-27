--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

-- A function to load the salesmen.
function LOOTFEST:LoadLootCrates()
	self.lootcratedata = Clockwork.kernel:RestoreSchemaData("plugins/lootcrates/"..game.GetMap());
	
	for k, v in pairs(self.lootcratedata) do
		local lootcrate = ents.Create("cw_lootcrate");
		
		salesman:SetPos(v.position);
		salesman:SetModel(v.model);
		salesman:SetAngles(v.angles);
		salesman:Spawn();

		lootcrate:SetCrateTable(v.crateTable)

		Clockwork.entity:MakeSafe(lootcrate, true, true, true);
		self.lootcratedata[k] = lootcrate;
	end;
end;

-- A function to get a salesman table from an entity.
function LOOTFEST:GetTableFromEntity(entity)
	return {
		name = entity:GetDTString(0),
		model = entity:GetModel(),
		angles = entity:GetAngles(),
		position = entity:GetPos(),
		physDesc = entity:GetDTString(1),
		crateTable = entity:GetCrateTable()
	};
end;

-- A function to save the salesmen.
function LOOTFEST:SaveLootCrates()
	local lootcrates = {};
	
	for k, v in pairs(self.lootcratedata) do
		if (IsValid(v)) then
			lootcrates[#lootcrates + 1] = self:GetTableFromEntity(v);
		end;
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/lootcrates/"..game.GetMap(), salesmen);
end;

//A function to get a single random key in a select table.
function LOOTFEST:GetWeightedRandomKey(table)
	local sum = 0;

	for _, chance in pairs(table) do
		sum = sum + chance;
	end;

	local select = math.random() * sum;

	for key, chance in pairs(table) do
		select = select - chance;
		if select < 0 then return key end;
	end;
end;

//A function to create a loot table with a name and preset table.
function LOOTFEST:CreateLootTable(name, table)
	print(name, table)
	local tableName = string.lower(name);
	if table then
		self.lootTables[tableName] = table;
	end;
end;


//A function to add a single item to a loot table.
function LOOTFEST:AddLootToTable(uniqueID, table, lootWeight)
	if !(self.lootTables[table]) then self:CreateLootTable(table, {}) end;
	//print(self.lootTables[table]/*, self.lootTables[table][uniqueID]*/)
	self.lootTables[table][uniqueID] = lootWeight or 1;
	return self.lootTables[table][uniqueID];
end;

function LOOTFEST:SearchCrate(player, entity)
	local searchTime = entity.cwCrateTable.lootSearchTime;

	self:SetSearching(player, searchTime);

	Clockwork.player:EntityConditionTimer(player, entity, entity, searchTime, 192, function() return true end, function(success)
		print(success, player:IsValid(), entity:IsValid())
		if (success) then
			Clockwork.storage:Open(player, {
				name = entity.cwCrateTable.name,
				weight = entity.cwWeight,
				entity = entity,
				distance = 192,
				cash = 0,
				isOneSided = true,
				inventory = entity.cwInventory,
				OnGiveCash = function(player, storageTable, cash)
					return false;
				end,
				OnTakeCash = function(player, storageTable, cash)
					return false;
				end
			});
		end

		self:SetSearching(player, false);

	end);
end;