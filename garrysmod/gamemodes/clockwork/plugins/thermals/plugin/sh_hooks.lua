local PLUGIN = PLUGIN;

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
    playerVars:Bool("nvdActive", true);
    playerVars:String("nvdType", true);
end

function PLUGIN:ToggleNVD(player)
	if (SERVER) then
		if (IsValid(player) and player:IsValid()) then
			player:SetSharedVar("nvdActive", !(player:GetSharedVar("nvdActive")))
		end;
	else
		Clockwork.datastream:Start("ToggleClockworkNVD");
	end;
end;

if (SERVER) then
	Clockwork.datastream:Hook("ToggleClockworkNVD", function(player)
		PLUGIN:ToggleNVD(player);
	end);
else
	function PLUGIN:PlayerButtonDown(ply, key)
		if (ply:GetSharedVar("nvdType") != "" and key == KEY_N) then
			self:ToggleNVD(Clockwork.Client);
		end;
	end;

	concommand.Add("cwToggleNVD", function(ply, cmd, args, argStr)
		PLUGIN:ToggleNVD();
	end);
end;