--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

local CLASS = Clockwork.class:New("Insurgent");

CLASS.color = Color(255, 0, 0, 255); -- The color of this class.
CLASS.factions = {FACTION_OPFOR}; -- Which factions can select this class.
CLASS.isDefault = true; -- Is this the default class for these factions?
CLASS.wagesName = "Base Pay"; -- What is the name of the "wages" for this class.
CLASS.description = "Standard Middle-Eastern/African insurgent."; -- A short description of the class.
CLASS.defaultPhysDesc = "A man who appears to be dressed up as a civilian."; -- The default physical description for this class.

CLASS_INSURGENT = CLASS:Register();