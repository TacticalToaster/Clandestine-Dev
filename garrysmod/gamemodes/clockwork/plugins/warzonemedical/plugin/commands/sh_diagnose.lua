local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("Diagnose");
COMMAND.tip = "Check a character's injuries.";
COMMAND.text = "<None>";
COMMAND.flags = CMD_DEFAULT;
//COMMAND.access = "a";
//COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local entity = player:GetEyeTraceNoCursor().Entity;
	local target = Clockwork.entity:GetPlayer(entity);
	
	if (target and entity:GetPos():Distance( player:GetShootPos() ) <= 192) then
		local injuries = target:GetInjuries();
		local injTable = {};

		Clockwork.chatBox:Add(player, nil, "treat", "You notice the following things about the patient:");

		Clockwork.chatBox:Add(player, nil, "treat", "The patient's blood level is: "..math.Round(target:GetCharacterData("blood")).."/100.");
		Clockwork.chatBox:Add(player, nil, "treat", "The patient's respiration is: "..math.Round(target:GetCharacterData("respiration")).."/100.");

		for i,v in pairs(injuries) do
			//local injuryTable = Clockwork.injury:FindByID(v.type);

			if (injTable[v.type]) then
				injTable[v.type] = injTable[v.type] + 1;
			else
				injTable[v.type] = 1;
			end;
			//Clockwork.chatBox:Add(player, nil, "injury", "* "..v.description.." (x"..);
		end;

		for i,v in pairs(injTable) do
			local injuryTable = Clockwork.injury:FindByID(i);

			Clockwork.chatBox:Add(player, nil, "injury", "* "..injuryTable.description.." (x"..v..")");
		end;
	else
		local injuries = player:GetInjuries();
		local injTable = {};

		Clockwork.chatBox:Add(player, nil, "treat", "You notice the following things about yourself:");

		Clockwork.chatBox:Add(player, nil, "treat", "Your blood level is: "..math.Round(player:GetCharacterData("blood")).."/100.");
		Clockwork.chatBox:Add(player, nil, "treat", "Your respiration is: "..math.Round(player:GetCharacterData("respiration")).."/100.");

		for i,v in pairs(injuries) do
			//local injuryTable = Clockwork.injury:FindByID(v.type);

			if (injTable[v.type]) then
				injTable[v.type] = injTable[v.type] + 1;
			else
				injTable[v.type] = 1;
			end;
			//Clockwork.chatBox:Add(player, nil, "injury", "* "..v.description.." (x"..);
		end;

		for i,v in pairs(injTable) do
			local injuryTable = Clockwork.injury:FindByID(i);

			Clockwork.chatBox:Add(player, nil, "injury", "* "..injuryTable.description.." (x"..v..")");
		end;
	end;
end;

COMMAND:Register();
