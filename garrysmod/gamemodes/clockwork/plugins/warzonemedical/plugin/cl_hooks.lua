local PLUGIN = PLUGIN;

-- Called when the local player's motion blurs should be adjusted.
function PLUGIN:PlayerAdjustMotionBlurs(motionBlurs)
	if ( Clockwork.Client:HasInitialized() ) then
		local blood = Clockwork.Client:GetSharedVar("blood");
		local data = math.max(blood);
		
		if (data <= 60) then
			motionBlurs.blurTable["blood"] = 1 - Lerp(math.abs(blood-60) / 30, .1, .9);//( (0.25 / 10) * ( 10 - (100 - data) ) );
		end;
	end;
end;

function PLUGIN:GetProgressBarInfo()
	local action, percentage = Clockwork.player:GetAction(Clockwork.Client, true);
	
	if (Clockwork.Client:Alive()) then
		if (action == "wearingGloves") then
			return {text = "Putting on gloves...", percentage = percentage, flash = percentage < 10};
		elseif (action == "applyingBurnGel") then
			return {text = "Applying gel...", percentage = percentage, flash = percentage < 10};
		elseif (action == "applyingTourniquetSelf") then
			return {text = "Wrapping tourniquet on yourself...", percentage = percentage, flash = percentage < 10};
		elseif (action == "applyingTourniquetPatient") then
			return {text = "Wrapping tourniquet on patient...", percentage = percentage, flash = percentage < 10};
		elseif (action == "applyingBandageSelf") then
			return {text = "Wrapping bandage and applying pressure on yourself...", percentage = percentage, flash = percentage < 10};
		elseif (action == "applyingBandagePatient") then
			return {text = "Wrapping bandage and applying pressure on patient...", percentage = percentage, flash = percentage < 10};
		elseif (action == "applyingPressureSelf") then
			return {text = "Applying pressure on yourself...", percentage = percentage, flash = percentage < 10};
		elseif (action == "applyingPressurePatient") then
			return {text = "Applying pressure on patient...", percentage = percentage, flash = percentage < 10};
		elseif (action == "decompressionKit") then
			return {text = "Preparing decompression kit...", percentage = percentage, flash = percentage < 10};
		end;
	end;
end;

local SCREEN_DAMAGE_OVERLAY = Clockwork.kernel:GetMaterial("clockwork/screendamage.png");

function PLUGIN:DrawPlayerScreenDamage(damageFraction)
	local sizeMultiplier = TimedSin(.2 + damageFraction, 1.1, 1.2, 0);
	local scrW, scrH = ScrW() * sizeMultiplier, ScrH() * sizeMultiplier;

	surface.SetDrawColor(255, 255, 255, math.Clamp(255 * damageFraction, 0, 255));
	surface.SetMaterial(SCREEN_DAMAGE_OVERLAY);
	surface.DrawTexturedRect(-(scrW - ScrW())/2, -(scrH - ScrH())/2, scrW, scrH);

	return true;
end;

-- Called when the F1 Text is needed.
/*
function PLUGIN:GetPlayerInfoText(playerInfoText)
	local injuries = Clockwork.Client:GetSharedVar("injuries");
	PrintTable(injuries);
	
	local text = "[Injuries]\n";

	if ((istable(injuries) and table.IsEmpty(injuries)) or !istable(injuries)) then
		text = "[Injuries]\nYou seem to have no noticable injuries."
	end;
	
	for i,v in pairs(injuries) do
		local injuryTable = Clockwork.injury:FindByID(v.type);

		text = text..injuryTable.name..": "..injuryTable.description.."\n";
	end;

	playerInfoText:Add("Injuries", text);
end;*/