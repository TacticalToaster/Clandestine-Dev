local PLUGIN = PLUGIN;

function PLUGIN:GetEntityMenuOptions(entity, options)
	if (entity:GetClass() == "prop_ragdoll") then
		options["Loot"] = "cwContainerOpen";
	end;
end;

function PLUGIN:PostDrawTranslucentRenderables()
	for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
		if (v:GetRenderMode() != RENDERMODE_NORMAL) then
			v:SetRenderMode(RENDERMODE_NORMAL);
		end;
	end;
end;