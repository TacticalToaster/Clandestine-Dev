Clockwork.chatBox:RegisterClass("radio_mc", "ic", function(info)
	local color = Color(75, 150, 50, 255);
	local channel = 1;

	if (info.data.frequency) then
		channel = Clockwork.Client:GetSharedVar(info.data.frequency, "frequencies");
	end;

	if (channel == 2) then
		color = Color(75, 180, 50, 255);
	elseif (channel == 3) then
		color = Color(75, 210, 50, 255);
	end;

	//local localized = Clockwork.chatBox:LangToTable("ChatPlayerRadios", color, info.name, info.text);

	Clockwork.chatBox:Add(info.filtered, nil, Color(75, 150, 50, 255), info.name.." radios in on ", color, "Channel "..channel, Color(75, 150, 50, 255), " \""..info.text.."\"");
end);


