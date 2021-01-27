local PLUGIN = PLUGIN;

-- Called when an entity's menu options are needed.
function BUGS:GetEntityMenuOptions(entity, options)
	//print(entity:GetClass(), "COCK")
	if (entity:GetClass() == "cw_bug") then
		if (!entity:IsOff()) then
			options["Turn Off"] = "cw_bugToggle";
		else
			options["Turn On"] = "cw_bugToggle";
		end;
		
		options["Set Frequency"] = function()
			Derma_StringRequest("Frequency", "What would you like to set the frequency to?", frequency, function(text)
				if (IsValid(entity)) then
					Clockwork.entity:ForceMenuOption(entity, "Set Frequency", text);
				end;
			end);
		end;
		
		options["Take"] = "cw_bugTake";
	end;
end;