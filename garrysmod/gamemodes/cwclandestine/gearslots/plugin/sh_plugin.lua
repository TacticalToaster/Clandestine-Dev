--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

PLUGIN:SetGlobalAlias("GEARSLOTS")

Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");

//Clockwork.plugin:AddExtra("/lootcrates/");

if (CLIENT) then
	Clockwork.GearData = Clockwork.GearData or {};
	print("REEEEEEEEEEEEEhaslghaljghjkgha", Clockwork.GearData, type(Clockwork.GearData))
	PrintTable(Clockwork.GearData)
	//if (Clockwork.GearData == {}) then
		Clockwork.GearData.headSlot = {itemID = nil, uniqueID = nil};
		Clockwork.GearData.chestOneSlot = {itemID = nil, uniqueID = nil};
		Clockwork.GearData.chestTwoSlot = {itemID = nil, uniqueID = nil};
		Clockwork.GearData.legSlot = {itemID = nil, uniqueID = nil};
		Clockwork.GearData.bagOneSlot = {itemID = nil, uniqueID = nil};
		Clockwork.GearData.bagTwoSlot = {itemID = nil, uniqueID = nil};
		PrintTable(Clockwork.GearData)
	//end
end
