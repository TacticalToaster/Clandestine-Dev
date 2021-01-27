local PLUGIN = PLUGIN;

-- Called when a player's character data should be restored.
function PLUGIN:PlayerRestoreCharacterData(player, data)
	if ( !data["wires"] ) then
		data["wires"] = {};
	end;
end;

function PLUGIN:PlayerSetSharedVars(player, curTime)
	local wires = player:GetCharacterData("wires");

	for i, v in pairs(wires) do
		player:SetSharedVar( i, v, "wires" );
	end;
end;

-- Called when a chat box message has been added.
function PLUGIN:ChatBoxMessageAdded(info)
	if (info.class == "ic") then
		local eavesdroppers = {};
		local talkRadius = Clockwork.config:Get("talk_radius"):Get();
		local listeners = {};
		local players = _player.GetAll();
		local bugs = ents.FindByClass("cw_bug");
		local data = {};

		local copyInfo = info;
		
		for k, v in ipairs(bugs) do
			if (!v:IsOff() and info.speaker:GetPos():Distance( v:GetPos() ) <= talkRadius * 2) then
				local frequency = v:GetFrequency();
				local transmitter = v:IsTransmitting();
				
				if (frequency != 0 and transmitter) then
					info.shouldSend = false;		//this would keep the players being bugged from talking normally, only transmitting rather then continuing as normal
					//info.listeners = {};
					data.frequency = frequency;
					data.position = v:GetPos();
					data.entity = v;
					
					break;
				end;
			end;
		end;
		
		if (IsValid(data.entity) and data.frequency != "") then
			for k, v in ipairs(players) do
				if (v:HasInitialized() and v:Alive() and !v:IsRagdolled(RAGDOLL_FALLENOVER)) then
					if (( v:GetCharacterData("bug_frequency") == data.frequency and v:GetSharedVar("tied") == 0
					and v:HasItemByID("bug_receiver") )) then
						listeners[v] = v;
					end;
				end;
			end;
			
			for k, v in ipairs(bugs) do
				local bugPosition = v:GetPos();
				local bugFrequency = v:GetFrequency();
				
				if (!v:IsOff() and !v:IsTransmitting() and bugFrequency == data.frequency) then
					for k2, v2 in ipairs(players) do
						if (v2:HasInitialized() and !listeners[v2] and !eavesdroppers[v2]) then
							if (v2:GetPos():Distance(bugPosition) <= (talkRadius)) then
								eavesdroppers[v2] = v2;
							end;
						end;
						
						break;
					end;
				end;
			end;
			
			if (table.Count(listeners) > 0) then
				Clockwork.chatBox:Add(listeners, info.speaker, "bug", info.text);
			end;
			
			if (table.Count(eavesdroppers) > 0) then
				Clockwork.chatBox:Add(eavesdroppers, info.speaker, "bug", info.text);
			end;
			
			//table.Merge(info.listeners, listeners);
			//table.Merge(info.listeners, eavesdroppers);
		end;

		listensers = {};
		eavesdroppers = {};

		//TODO Holy fuck I should find a way so I don't have to nest all these for loops

		for i, p in pairs(players) do
			if (p:HasInitialized() and p:Alive() and istable(p:GetCharacterData("wires"))) then
				for f, _ in pairs(p:GetCharacterData("wires")) do
					if (info.speaker:GetPos():Distance( p:GetPos() ) <= talkRadius * 1.5) then
						for k, v in pairs(players) do
							if (v:HasInitialized() and v:Alive() and !v:IsRagdolled(RAGDOLL_FALLENOVER)) then
								if (( v:GetCharacterData("bug_frequency") == f and v:GetSharedVar("tied") == 0
								and v:HasItemByID("bug_receiver") )) then
									listeners[v] = v;
								end;
							end;
						end;
						
						for a, b in pairs(bugs) do
							local bugPosition = b:GetPos();
							local bugFrequency = b:GetFrequency();
							
							if (!b:IsOff() and !b:IsTransmitting() and bugFrequency == f) then
								for k2, v2 in pairs(players) do
									if (v2:HasInitialized() and !listeners[v2] and !eavesdroppers[v2]) then
										if (v2:GetPos():Distance(bugPosition) <= (talkRadius * 2)) then
											eavesdroppers[v2] = v2;
										end;
									end;
									
									break;
								end;
							end;
						end;
						
						if (table.Count(listeners) > 0) then
							Clockwork.chatBox:Add(listeners, info.speaker, "bug", info.text);
						end;
						
						if (table.Count(eavesdroppers) > 0) then
							Clockwork.chatBox:Add(eavesdroppers, info.speaker, "bug", info.text);
						end;
						
						//table.Merge(info.listeners, listeners);
						//table.Merge(info.listeners, eavesdroppers);
					end;
				end;
			end;
		end;
	end;
end;

-- Called when an entity's menu option should be handled.
function BUGS:EntityHandleMenuOption(player, entity, option, arguments)
	//print("COCK32", entity:GetClass())
	if (entity:GetClass() == "cw_bug") then
		if (option == "Set Frequency" and type(arguments) == "string") then
			if (string.find(arguments, "^%d%d%d%.%d$")) then
				local start, finish, decimal = string.match(arguments, "(%d)%d(%d)%.(%d)");
				
				start = tonumber(start);
				finish = tonumber(finish);
				decimal = tonumber(decimal);
				
				if (start == 1 and finish > 0 and finish < 10 and decimal > 0 and decimal < 10) then
					entity:SetFrequency(arguments);
					
					Clockwork.player:Notify(player, "You have set this bug's arguments to "..arguments..".");
				else
					Clockwork.player:Notify(player, "The bug's arguments must be between 101.1 and 199.9!");
				end;
			else
				Clockwork.player:Notify(player, "The bug's arguments must look like xxx.x!");
			end;
		elseif (arguments == "cw_bugToggle") then
			entity:Toggle();
		elseif (arguments == "cw_bugTake") then
			local bSuccess, fault;

			if (entity:IsTransmitting()) then
				bSuccess, fault = player:GiveItem(Clockwork.item:CreateInstance("bug_transmitter"));
			else
				bSuccess, fault = player:GiveItem(Clockwork.item:CreateInstance("bug_receiver"));
			end;

			if (!bSuccess) then
				Clockwork.player:Notify(player, fault);
			else
				entity:Remove();
			end;
		end;
	end;
end;