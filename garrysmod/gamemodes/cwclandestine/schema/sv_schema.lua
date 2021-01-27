--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

-- This is where you might add any functions for your schema.
function Schema:MakeAnnouncement(text)
	Clockwork.player:NotifyAll(text);
end;

--[[-------------------------------------------------------------------------
This function makes a colored text announcement using a color table, in example, you would put:
Schema:NotifyColor(player, Color(255,255,255,255), "I really like foobars!")
---------------------------------------------------------------------------]]
function Schema:NotifyColor(player, color, text)
	Clockwork.chatBox:SendColored(player, color, text);
end;