--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

local CLASS = Clockwork.class:New("Syrian Weapons Specialist");

CLASS.color = Color(70, 70, 55, 255); -- The color of this class.
CLASS.factions = {FACTION_RUSALLY}; -- Which factions can select this class.
CLASS.isDefault = true; -- Is this the default class for these factions?
CLASS.wagesName = "Base Pay"; -- What is the name of the "wages" for this class.
CLASS.description = "A Syrian chemical weapons specialist assisting the effort to invade the US."; -- A short description of the class.
CLASS.defaultPhysDesc = "A man donning a Syrian military outfit. He smells like chlorine."; -- The default physical description for this class.

CLASS_SYRWEPSPEC = CLASS:Register();