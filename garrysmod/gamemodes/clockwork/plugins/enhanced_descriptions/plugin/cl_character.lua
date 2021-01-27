local PANEL = {};

-- Called when the panel is initialized.
function PANEL:Init()
	local smallTextFont = Clockwork.option:GetFont("menu_text_small");
	local panel = Clockwork.character:GetPanel();
	
	self.categoryList = vgui.Create("cwPanelList", self);
 	self.categoryList:SetPadding(8);
	self.categoryList:SetSpacing(8);
 	self.categoryList:SizeToContents();

	self.overrideModel = nil;
	self.bSelectModel = nil;
	self.bPhysDesc = (Clockwork.command:FindByID("CharPhysDesc") != nil);
	self.info = Clockwork.character:GetCreationInfo();
	
	if (!Clockwork.faction.stored[self.info.faction].GetModel) then
		self.bSelectModel = true;
	end;
	
	if (!Clockwork.faction.stored[self.info.faction].GetName) then
		self.nameForm = vgui.Create("cwBasicForm", self);
		self.nameForm:SetAutoSize(true);
		self.nameForm:SetPadding(8);
		self.nameForm:SetSpacing(8);
		self.nameForm:SetText("Name");
		
		if (Clockwork.faction.stored[self.info.faction].useFullName) then
			self.fullNameTextEntry = self.nameForm:TextEntry("Full Name");
			self.fullNameTextEntry:SetAllowNonAsciiCharacters(true);
		else
			self.forenameTextEntry = self.nameForm:TextEntry("Forename");
			self.forenameTextEntry:SetAllowNonAsciiCharacters(true);
			
			self.surnameTextEntry = self.nameForm:TextEntry("Surname");
			self.surnameTextEntry:SetAllowNonAsciiCharacters(true);
		end;
	end;
	
	if (self.bSelectModel or self.bPhysDesc) then
		if (self.bPhysDesc) then
			self.physDescForm = vgui.Create("cwBasicForm");
			self.physDescForm:SetAutoSize(true);
			self.physDescForm:SetPadding(8);
			self.physDescForm:SetSpacing(8);
			self.physDescForm:SetText(L("CharacterMenuPhysDesc"));
			self.physDescForm:Help(L("CharacterMenuPhysDescHelp"));
			
			self.physDescTextEntry = self.physDescForm:TextEntry();
			self.physDescTextEntry:SetAllowNonAsciiCharacters(true);
		end;
		
		if (self.bSelectModel) then
			self.appearanceForm = vgui.Create("cwBasicForm");
			self.appearanceForm:SetAutoSize(true);
			self.appearanceForm:SetPadding(8);
			self.appearanceForm:SetSpacing(8);
			self.appearanceForm:SetText(L("CharacterMenuAppearance"));
			self.appearanceForm:Help(L("CharacterMenuModelHelp"));
		
			self.modelItemsList = vgui.Create("DPanelList", self);
			self.modelItemsList:SetPadding(4);
			self.modelItemsList:SetSpacing(16);
			self.modelItemsList:SetAutoSize(true);
			self.modelItemsList:EnableHorizontal(true);
			self.modelItemsList:EnableVerticalScrollbar(true);
			
			self.appearanceForm:AddItem(self.modelItemsList);
		end;
	end;
	
	if (self.nameForm) then
		self.categoryList:AddItem(self.nameForm);
	end;

	if (self.physDescForm) then
		self.categoryList:AddItem(self.physDescForm);
	end;

	self.customDescriptions = {};

	Clockwork.plugin:Call("GetDescriptionChoices", self.customDescriptions);

	for i, v in pairs(self.customDescriptions) do
		self[v.name.."DescForm"] = vgui.Create("cwBasicForm");
		self[v.name.."DescForm"]:SetAutoSize(true);
		self[v.name.."DescForm"]:SetPadding(8);
		self[v.name.."DescForm"]:SetSpacing(8);
		self[v.name.."DescForm"]:SetText(v.type);
		self[v.name.."DescForm"]:Help(v.help);

		self[v.name.."DescTextEntry"] = self[v.name.."DescForm"]:TextEntry();
		self[v.name.."DescTextEntry"]:SetAllowNonAsciiCharacters(true);

		self.categoryList:AddItem(self[v.name.."DescForm"]);
	end;
	
	if (self.appearanceForm) then
		self.categoryList:AddItem(self.appearanceForm);
	end;

	self.customizeButton = self.customizeButton or self.appearanceForm:Button("Customize");
	self.customizeButton:SetVisible(false);
	self.info.customizationOptions = {};

	local genderModels = Clockwork.faction.stored[self.info.faction].models[string.lower(self.info.gender)];
	
	if (genderModels and #genderModels == 1) then
		self.bSelectModel = false;
		self.overrideModel = genderModels[1];
		
		if (!panel:FadeInModelPanel(self.overrideModel)) then
			panel:SetModelPanelModel(self.overrideModel);
		end;

		local modelEnt = panel.characterModel.Entity;

		if (IsValid(modelEnt)) then
			local bodygroups = modelEnt:GetBodyGroups();
			local bodygroupCount = table.Count(bodygroups) - 1;
			local skinCount = modelEnt:SkinCount() - 1;

			if (bodygroupCount > 0 or skinCount > 0) then
				self.customizeButton:SetVisible(true);

				self.customizeButton.DoClick = function()
					local options = {};

					if (skinCount > 0) then
						options["Skin"] = {};

						for i = 0, skinCount do
							options["Skin"]["Skin "..tostring(i)] = function()
								modelEnt:SetSkin(i);
								self.info.customizationOptions["Skin"] = i;
							end;
						end;
					end;

					for k, v in pairs(bodygroups) do
						local name, num = v.name or "Unknown", v.num - 1;

						options[name] = {};

						for i = 0, num do
							if (num > 0) then
								options[name][name.." "..tostring(i)] = function()
									modelEnt:SetBodygroup(v.id, i);
									self.info.customizationOptions[v.id] = i;
								end;
							end;
						end;
					end;
		
					local menuPanel = Clockwork.kernel:AddMenuFromData(nil, options, function(menuPanel, option, arguments) end);
				end;
			end;
		end;
	end;
	
	local informationColor = Clockwork.option:GetColor("information");
	local lowerGender = string.lower(self.info.gender);
	local spawnIcon = nil;
	
	for k, v in pairs(Clockwork.faction.stored) do
		if (v.name == self.info.faction) then
			if (self.modelItemsList and v.models[lowerGender]) then
				for k2, v2 in pairs(v.models[lowerGender]) do
					spawnIcon = Clockwork.kernel:CreateMarkupToolTip(vgui.Create("cwSpawnIcon", self));
					spawnIcon:SetModel(v2);
					
					-- Called when the spawn icon is clicked.
					spawnIcon.DoClick = function(spawnIcon)
						self.info.customizationOptions = {};
						
						if (self.selectedSpawnIcon) then
							self.selectedSpawnIcon:SetColor(nil);
						end;
						
						spawnIcon:SetColor(informationColor);
						
						if (!panel:FadeInModelPanel(v2)) then
							panel:SetModelPanelModel(v2);
						end;
						
						self.selectedSpawnIcon = spawnIcon;
						self.selectedModel = v2;

						self.customizeButton:SetVisible(false);

						local modelEnt = panel.characterModel.Entity;

						if (IsValid(modelEnt)) then
							local bodygroups = modelEnt:GetBodyGroups();
							local bodygroupCount = table.Count(bodygroups) - 1;
							local skinCount = modelEnt:SkinCount() - 1;

							if (bodygroupCount > 0 or skinCount > 0) then
								self.customizeButton:SetVisible(true);

								self.customizeButton.DoClick = function()
									local options = {};

									if (skinCount > 0) then
										options["Skin"] = {};

										for i = 0, skinCount do
											options["Skin"]["Skin "..tostring(i)] = function()
												modelEnt:SetSkin(i);
												self.info.customizationOptions["Skin"] = i;
											end;
										end;
									end;

									for k, v in pairs(bodygroups) do
										local name, num = v.name or "Unknown", v.num - 1;

										options[name] = {};

										for i = 0, num do
											if (num > 0) then
												options[name][name.." "..tostring(i)] = function()
													modelEnt:SetBodygroup(v.id, i);
													self.info.customizationOptions[v.id] = i;
												end;
											end;
										end;
									end;

									local menuPanel = Clockwork.kernel:AddMenuFromData(nil, options, function(menuPanel, option, arguments) end);
								end;
							end;
						end;
					end;
					
					self.modelItemsList:AddItem(spawnIcon);
				end;
			end;
		end;
	end;
end;

-- Called when the next button is pressed.
function PANEL:OnNext()
	if (self.overrideModel) then
		self.info.model = self.overrideModel;
	else
		self.info.model = self.selectedModel;
	end;
	
	if (!Clockwork.faction.stored[self.info.faction].GetName) then
		if (IsValid(self.fullNameTextEntry)) then
			self.info.fullName = self.fullNameTextEntry:GetValue();
			
			if (self.info.fullName == "") then
				Clockwork.character:SetFault("You did not choose a name, or the name that you chose is not valid!");
				return false;
			end;
		else
			self.info.forename = self.forenameTextEntry:GetValue();
			self.info.surname = self.surnameTextEntry:GetValue();
			
			if (self.info.forename == "" or self.info.surname == "") then
				Clockwork.character:SetFault("You did not choose a name, or the name that you chose is not valid!");
				return false;
			end;
			
			if (string.find(self.info.forename, "[%p%s%d]") or string.find(self.info.surname, "[%p%s%d]")) then
				Clockwork.character:SetFault("Your forename and surname must not contain punctuation, spaces or digits!");
				return false;
			end;
			
			if (!string.find(self.info.forename, "[aeiou]") or !string.find(self.info.surname, "[aeiou]")) then
				Clockwork.character:SetFault("Your forename and surname must both contain at least one vowel!");
				return false;
			end;
			
			if (string.len(self.info.forename) < 2 or string.len(self.info.surname) < 2) then
				Clockwork.character:SetFault("Your forename and surname must both be at least 2 characters long!");
				return false;
			end;
			
			if (string.len(self.info.forename) > 16 or string.len(self.info.surname) > 16) then
				Clockwork.character:SetFault("Your forename and surname must not be greater than 16 characters long!");
				return false;
			end;
		end;
	end;
	
	if (self.bSelectModel and !self.info.model) then
		Clockwork.character:SetFault("You did not choose a model, or the model that you chose is not valid!");
		return false;
	end;
	
	if (self.bPhysDesc) then
		local minimumPhysDesc = Clockwork.config:Get("minimum_physdesc"):Get();
			self.info.physDesc = self.physDescTextEntry:GetValue();
		if (string.len(self.info.physDesc) < minimumPhysDesc) then
			Clockwork.character:SetFault("The physical description must be at least "..minimumPhysDesc.." characters long!");
			return false;
		end;
	end;

	for i, v in pairs(self.customDescriptions) do
		self.info.plugin[v.name.."Desc"] = self[v.name.."DescTextEntry"]:GetValue();
	end;
end;

-- Called when the panel is painted.
function PANEL:Paint(w, h) end;

-- A function to make the panel fade out.
function PANEL:FadeOut(speed, Callback)
	if (self:GetAlpha() > 0 and (!self.animation or !self.animation:Active())) then
		self.animation = Derma_Anim("Fade Panel", self, function(panel, animation, delta, data)
			panel:SetAlpha(255 - (delta * 255));
			
			if (animation.Finished) then
				panel:SetVisible(false);
			end;
			
			if (animation.Finished and Callback) then
				Callback();
			end;
		end);
		
		if (self.animation) then
			self.animation:Start(speed);
		end;
		
		Clockwork.option:PlaySound("rollover");
	else
		self:SetVisible(false);
		self:SetAlpha(0);
		
		if (Callback) then
			Callback();
		end;
	end;
end;

-- A function to make the panel fade in.
function PANEL:FadeIn(speed, Callback)
	if (self:GetAlpha() == 0 and (!self.animation or !self.animation:Active())) then
		self.animation = Derma_Anim("Fade Panel", self, function(panel, animation, delta, data)
			panel:SetVisible(true);
			panel:SetAlpha(delta * 255);
			
			if (animation.Finished) then
				self.animation = nil;
			end;
			
			if (animation.Finished and Callback) then
				Callback();
			end;
		end);
		
		if (self.animation) then
			self.animation:Start(speed);
		end;
		
		Clockwork.option:PlaySound("click_release");
	else
		self:SetVisible(true);
		self:SetAlpha(255);
		
		if (Callback) then
			Callback();
		end;
	end;
end;

-- Called each frame.
function PANEL:Think()
	self:InvalidateLayout(true);
	
	if (self.animation) then
		self.animation:Run();
	end;
end;

-- Called when the layout should be performed.
function PANEL:PerformLayout(w, h)
	self.categoryList:StretchToParent(0, 0, 0, 0);
	
	if (IsValid(self.modelItemsList)) then
		self.modelItemsList:SetTall(256);
	end;
	
	self:SetSize(512, math.min(self.categoryList.pnlCanvas:GetTall() + 8, ScrH() * 0.6));
end;

vgui.Register("cwCharacterStageTwo", PANEL, "EditablePanel");