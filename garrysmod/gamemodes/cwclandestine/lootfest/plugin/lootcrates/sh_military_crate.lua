local LOOTCRATE = Clockwork.lootcrate:New();
	LOOTCRATE.name = "Military Crate";
	LOOTCRATE.uniqueID = "military_crate";
	LOOTCRATE.skin = 0;
	LOOTCRATE.size = 4;
	LOOTCRATE.model = "models/Items/item_item_crate.mdl";
	LOOTCRATE.description = "A crate used by the military before the war.";
	LOOTCRATE.lootTable = "military";
	LOOTCRATE.lootRespawnTime = 1200;
	LOOTCRATE.lootSearchTime = 10;
LOOTCRATE:Register();