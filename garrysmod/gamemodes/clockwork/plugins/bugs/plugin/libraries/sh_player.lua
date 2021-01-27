cwPlayer = player;

-- A function to make a player say text as a radio broadcast.
/*function Clockwork.player:SayRadio(player, text, check, noEavesdrop, customInfo)
	local eavesdroppers = {};
	local listeners = {};
	local canRadio = true;
	local info = {listeners = {}, noEavesdrop = noEavesdrop, text = text};
	
	if (customInfo) then
		table.Merge(info, customInfo);
	end;

	Clockwork.plugin:Call("PlayerAdjustRadioInfo", player, info);
	
	for k, v in pairs(info.listeners) do
		if (type(k) == "Player") then
			listeners[k] = k;
		elseif (type(v) == "Player") then
			listeners[v] = v;
		end;
	end;
	
	if (!info.noEavesdrop) then
		for k, v in pairs(cwPlayer.GetAll()) do
			if (v:HasInitialized() and !listeners[v]) then
				if (v:GetShootPos():Distance(player:GetShootPos()) <= Clockwork.config:Get("talk_radius"):Get()) then
					eavesdroppers[v] = v;
				end;
			end;
		end;
	end;
	
	if (check) then
		canRadio = Clockwork.plugin:Call("PlayerCanRadio", player, info.text, listeners, eavesdroppers);
	end;
	
	if (canRadio) then
		info = Clockwork.chatBox:Add(listeners, player, "radio_mc", info.text, {frequency = info.frequency});
		
		if (info and IsValid(info.speaker)) then
			Clockwork.chatBox:Add(eavesdroppers, info.speaker, "radio_eavesdrop", info.text);
			
			Clockwork.plugin:Call("PlayerRadioUsed", player, info.text, listeners, eavesdroppers);
		end;
	end;
end;*/