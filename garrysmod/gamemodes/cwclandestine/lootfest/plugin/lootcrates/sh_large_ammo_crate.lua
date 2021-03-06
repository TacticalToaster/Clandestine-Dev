local LOOTCRATE = Clockwork.lootcrate:New();
	LOOTCRATE.name = "Large Ammo Crate";
	LOOTCRATE.uniqueID = "large_ammo_crate";
	LOOTCRATE.skin = 0;
	LOOTCRATE.size = 8;
	LOOTCRATE.model = "models/items/ammocrate_bullets_old.mdl";
	LOOTCRATE.description = "A large crate with ammunition logos painted on the sides.";
	LOOTCRATE.lootTable = "ammo_box";
	LOOTCRATE.lootRespawnTime = 2700;
	LOOTCRATE.lootSearchTime = 10;
LOOTCRATE:Register();