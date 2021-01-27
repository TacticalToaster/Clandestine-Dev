--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

local CLASS = Clockwork.class:New("Civilian");

CLASS.color = Color(150, 125, 100, 255); -- The color of this class.
CLASS.factions = {FACTION_CIVILIAN}; -- Which factions can select this class.
CLASS.isDefault = true; -- Is this the default class for these factions?
CLASS.wagesName = "Wages"; -- What is the name of the "wages" for this class.
CLASS.description = "A civilian caught in the crossfire."; -- A short description of the class.
CLASS.defaultPhysDesc = "A regular person."; -- The default physical description for this class.

CLASS_CIVILIAN = CLASS:Register();