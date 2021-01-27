--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

--[[
	You can either alias your schema object here, or use the `Schema` variable name.
	We recommend using this SetGlobalAlias method as it allows external plugins to
	query your methods easier.
--]]
Schema:SetGlobalAlias("Warzone");

Clockwork.kernel:IncludePrefixed("cl_schema.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_theme.lua");
Clockwork.kernel:IncludePrefixed("sh_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_schema.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");

Clockwork.option:SetKey("name_cash", "USD");
Clockwork.option:SetKey("model_cash", "models/props_lab/box01a.mdl");

Clockwork.quiz:SetEnabled(false);

