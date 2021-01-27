--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

local CLASS = Clockwork.class:New("Sentry Operations Group");

CLASS.color = Color(248, 231, 28, 255); -- The color of this class.
CLASS.factions = {FACTION_SENTRY}; -- Which factions can select this class.
CLASS.isDefault = true; -- Is this the default class for these factions?
CLASS.wagesName = "Base Pay"; -- What is the name of the "wages" for this class.
CLASS.description = "Contractor working for Sentry Operations Group."; -- A short description of the class.
CLASS.defaultPhysDesc = "An unmarked soldier wearing black BDUs with a tan plate carrier."; -- The default physical description for this class.

CLASS_SENTRY = CLASS:Register();