--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

local CLASS = Clockwork.class:New("Iraqi Ground Forces");

CLASS.color = Color(255, 0, 0, 255); -- The color of this class.
CLASS.factions = {FACTION_OPFOR}; -- Which factions can select this class.
CLASS.isDefault = false; -- Is this the default class for these factions?
CLASS.wagesName = "Base Pay"; -- What is the name of the "wages" for this class.
CLASS.description = "The ground forces of the Iraqi Armed Forces."; -- A short description of the class.
CLASS.defaultPhysDesc = "A man sporting the kit of a standard Iraqi infantryman."; -- The default physical description for this class.

CLASS_IGF = CLASS:Register();