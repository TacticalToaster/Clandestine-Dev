local LOOTCRATE = Clockwork.lootcrate:New();
	LOOTCRATE.name = "Military Box";
	LOOTCRATE.uniqueID = "military_box";
	LOOTCRATE.skin = 0;
	LOOTCRATE.size = 6;
	LOOTCRATE.model = "models/Items/ammocrate_grenade.mdl";
	LOOTCRATE.description = "A box used by the military. It's rather large.";
	LOOTCRATE.lootTable = "new_military";
	LOOTCRATE.lootRespawnTime = 1800;
	LOOTCRATE.lootSearchTime = 15;
LOOTCRATE:Register();