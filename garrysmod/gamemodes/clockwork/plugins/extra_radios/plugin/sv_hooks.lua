local PLUGIN = PLUGIN;

-- Called when a player's character data should be restored.
function PLUGIN:PlayerRestoreCharacterData(player, data)
	if ( !data["frequencies"] ) then
		data["frequencies"] = {[1] = 0, [2] = 0, [3] = 0};
	end;
end;

function PLUGIN:PlayerSetSharedVars(player, curTime)
	//print(player:GetCharacterData("frequencies")[1], player:GetCharacterData("frequencies")[2], player:GetCharacterData("frequencies")[3], "HAHAHAJFSLJFALKJFAL");
	player:SetSharedVar( player:GetCharacterData("frequencies")[1], 1, "frequencies" );
	player:SetSharedVar( player:GetCharacterData("frequencies")[2], 2, "frequencies" );
	player:SetSharedVar( player:GetCharacterData("frequencies")[3], 3, "frequencies" );
end;

-- Called when a player attempts to use the long-range radio.
function PLUGIN:PlayerCanRadio(player, text, listeners, eavesdroppers)
	if (player:HasItemByID("handheld_radio")) then
		if (!player:GetCharacterData("frequencies")) then
			Clockwork.player:Notify(player, "You need to set up your channels and frequencies first!");
			
			return false;
		end;
	else
		Clockwork.player:Notify(player, "You do not own a proper radio!");
		
		return false;
	end;

	return true;
end;

-- Called when a player's radio info should be adjusted.
function PLUGIN:PlayerAdjustRadioInfo(player, info)
	for k, v in ipairs( cwPlayer.GetAll() ) do
		if (v:HasInitialized() and v:HasItemByID("handheld_radio")) then
			//print(v:GetCharacterData("long_frequency"), player:GetCharacterData("long_frequency"))
			for i, f in pairs(v:GetCharacterData("frequencies")) do
				if (f == info.frequency) then
					info.listeners[v] = v;
				end;
			end;
		end;
	end;
end;