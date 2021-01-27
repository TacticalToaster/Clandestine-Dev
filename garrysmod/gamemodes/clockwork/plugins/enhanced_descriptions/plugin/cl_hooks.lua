local PLUGIN = PLUGIN;

/*function PLUGIN:GetPersuasionChoices(choices)
	table.insert(choices, {
		type = "textentry",
		name = "Facial Description"
	});

	table.insert(choices, {
		type = "textentry",
		name = "Voice Description"
	});

	table.insert(choices, {
		type = "textentry",
		name = "Feature Description"
	});

	table.insert(choices, {
		type = "textentry",
		name = "Clothing Description"
	});
end;*/

function PLUGIN:GetDescriptionChoices(choices)
	table.insert(choices, {
		name = "facial",
		type = "Facial Description",
		help = "(Optional) Write out an appropiate description of your character's facial features."
	});

	table.insert(choices, {
		name = "voice",
		type = "Vocal Description",
		help = "(Optional) Write out an appropiate description of your character's voice."
	});

	table.insert(choices, {
		name = "feature",
		type = "Feature Description",
		help = "(Optional) Write out additional features not concealed by clothing."
	});

	table.insert(choices, {
		name = "clothing",
		type = "Clothing Description",
		help = "(Optional) Write out an appropiate description of your character's normal outfit."
	});
end;

function PLUGIN:GetTargetPlayerText(player, targetPlayerText)
	local facialDescription = player:GetCharacterData("facialDesc");
	local voiceDescription = player:GetCharacterData("voiceDesc");
	local featureDescription = player:GetCharacterData("featureDesc");
	local equipmentDescription = player:GetCharacterData("equipmentDesc");
	local clothingDescription = player:GetCharacterData("clothingDesc");

	local targetIDTextFont = Clockwork.option:GetFont("target_id_text");

	local physString = "";

	if (featureDescription) then
		physString = physString..tostring(featureDescription);
	end;

	if (equipmentDescription) then
		physString = physString..tostring(equipmentDescription);
	end;

	if (clothingDescription) then
		physString = physString..tostring(clothingDescription);
	end;

	local faceDescTable = {};
	local voiceDescTable = {};
	local physDescTable = {};

	//if (Clockwork.player:DoesRecognise(player, RECOGNISE_PARTIAL)) then

		if (facialDescription) then
			Clockwork.kernel:WrapText(tostring(facialDescription), targetIDTextFont, math.max(ScrW() / 6, 384), faceDescTable);

			for k, v in pairs(faceDescTable) do
				targetPlayerText:Add("FACEDESC_"..k, v, Color(255, 251, 230, 255), .9);
			end;
		end;

		if (physString != "") then
			Clockwork.kernel:WrapText(physString, targetIDTextFont, math.max(ScrW() / 6, 384), physDescTable);
			
			for k, v in pairs(physDescTable) do
				targetPlayerText:Add("DETAILSDESC_"..k, v, Color(232, 255, 230, 255), .85);
			end;
		end;

		if (voiceDescription) then
			Clockwork.kernel:WrapText(tostring(voiceDescription), targetIDTextFont, math.max(ScrW() / 6, 384), voiceDescTable);

			for k, v in pairs(voiceDescTable) do
				targetPlayerText:Add("VOICEDESC_"..k, v, Color(230, 231, 255, 255), .8);
			end;
		end;
	//end;
end;

