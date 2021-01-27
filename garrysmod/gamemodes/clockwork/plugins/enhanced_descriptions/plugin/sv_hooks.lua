local PLUGIN = PLUGIN;

function PLUGIN:PlayerAdjustCharacterCreationInfo()

end;

-- Called when a player's character data should be restored.
function PLUGIN:PlayerRestoreCharacterData(player, data)
	if ( !data["facialDesc"] ) then
		data["facialDesc"] = "Change this after Bot testing1.";
	end;
	if ( !data["voiceDesc"] ) then
		data["voiceDesc"] = "Change this after Bot testing2.";
	end;
	if ( !data["featureDesc"] ) then
		data["featureDesc"] = "Change this after Bot testing3.";
	end;
	if ( !data["clothingDesc"] ) then
		data["clothingDesc"] = "Change this after Bot testing4.";
	end;
	if ( !data["equipmentDesc"] ) then
		data["equipmentDesc"] = "Change this after Bot testing5.";
	end;
	/*if ( !data["radiation"] ) then
		data["radiation"] = 0;
	end;*/
end;