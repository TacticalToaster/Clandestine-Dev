--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

local FACTION = Clockwork.faction:New("Sentry Operations Group");

FACTION.whitelist = true; -- Do we need to be whitelisted to select this faction?
FACTION.useFullName = true; -- Do we allow players to enter a full name, otherwise it only lets them select a first and second.
FACTION.material = "warzone/factions/sentry"; -- The path to the faction material (shown on the creation screen).
FACTION.models = {
	female = {},
	male = {}
};

for i=1, 9 do
	table.insert(FACTION.models.male, "models/half-dead/civilians/male_0"..i..".mdl");
end;

for i=1, 7 do
	if (i != 5) then
		table.insert(FACTION.models.female, "models/half-dead/civilians/female_0"..i..".mdl");
	end;
end;

FACTION_SENTRY = FACTION:Register();