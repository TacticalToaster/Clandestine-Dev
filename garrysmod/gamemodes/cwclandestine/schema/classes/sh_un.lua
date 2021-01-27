--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

local CLASS = Clockwork.class:New("US National Guard Infantry");

CLASS.color = Color(75, 83, 32, 255); -- The color of this class.
CLASS.factions = {FACTION_UN}; -- Which factions can select this class.
CLASS.isDefault = true; -- Is this the default class for these factions?
CLASS.wagesName = "Base Pay"; -- What is the name of the "wages" for this class.
CLASS.description = "US National Guard infantry called to service after the initial invasion."; -- A short description of the class.
CLASS.defaultPhysDesc = "A soldier in a standard US National Guard infantry kit."; -- The default physical description for this class.

CLASS_USNATGUARD = CLASS:Register();