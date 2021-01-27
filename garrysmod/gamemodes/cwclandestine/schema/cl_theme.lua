--[[
	This project is created with the Clockwork framework by Cloud Sixteen.
	http://cloudsixteen.com
--]]

local THEME = Clockwork.theme:Begin(true);

-- Called when fonts should be created.
function THEME:CreateFonts()
	surface.CreateFont("DefaultFont", {
		size = Clockwork.kernel:FontScreenScale(7),
		weight = 600, 
		antialias = true,
		font = "Courier New"
	});
	Clockwork.fonts:Add("clandestine_MainText", 
	{
		font		= "Courier New",
		size		= Clockwork.kernel:FontScreenScale(7),
		weight		= 400
	});
	Clockwork.fonts:Add("clandestine_ESPText", 
	{
		font		= "Arial",
		size		= Clockwork.kernel:FontScreenScale(5.5),
		weight		= 700
	});
	Clockwork.fonts:Add("clandestine_Tooltip", 
	{
		font		= "Courier New",
		size		= Clockwork.kernel:FontScreenScale(5),
		weight		= 50
	});
	Clockwork.fonts:Add("clandestine_MenuTextBig",
	{
		font		= "Courier New",
		size		= Clockwork.kernel:FontScreenScale(18),
		weight		= 300
	});
	Clockwork.fonts:Add("clandestine_MenuTextTiny",
	{
		font		= "Courier New",
		size		= Clockwork.kernel:FontScreenScale(7),
		weight		= 100
	});
	Clockwork.fonts:Add("clandestine_InfoTextFont",
	{
		font		= "Courier New",
		size		= Clockwork.kernel:FontScreenScale(6),
		weight		= 100
	});
	Clockwork.fonts:Add("clandestine_MenuTextHuge",
	{
		font		= "Courier New",
		size		= Clockwork.kernel:FontScreenScale(30),
		weight		= 300
	});
	Clockwork.fonts:Add("clandestine_MenuTextSmall",
	{
		font		= "Courier New",
		size		= Clockwork.kernel:FontScreenScale(10),
		weight		= 300
	});
	Clockwork.fonts:Add("clandestine_IntroTextBig",
	{
		font		= "Courier New",
		size		= Clockwork.kernel:FontScreenScale(18),
		weight		= 300
	});
	Clockwork.fonts:Add("clandestine_IntroTextTiny",
	{
		font		= "Courier New",
		size		= Clockwork.kernel:FontScreenScale(9),
		weight		= 300
	});
	Clockwork.fonts:Add("clandestine_IntroTextSmall",
	{
		font		= "Courier New",
		size		= Clockwork.kernel:FontScreenScale(7),
		weight		= 300
	});
	Clockwork.fonts:Add("clandestine_Large3D2D",
	{
		font		= "Courier New",
		size		= Clockwork.kernel:GetFontSize3D(),
		weight		= 300
	});
	Clockwork.fonts:Add("clandestine_ScoreboardName",
	{
		font		= "Courier New",
		size		= 20,
		weight		= 100
	});
	Clockwork.fonts:Add("clandestine_ScoreboardDesc",
	{
		font		= "Courier New",
		size		= 16,
		weight		= 50
	});
	Clockwork.fonts:Add("clandestine_ScoreboardClass",
	{
		font		= "Courier New",
		size		= 25,
		weight		= 100
	});
	Clockwork.fonts:Add("clandestine_CinematicText",
	{
		font		= "Courier New",
		size		= Clockwork.kernel:FontScreenScale(8),
		weight		= 300
	});
	Clockwork.fonts:Add("clandestine_ChatSyntax",
	{
		font		= "Courier New",
		size		= Clockwork.kernel:FontScreenScale(7),
		weight		= 600
	});
end;

-- Called when to initialize the theme.
function THEME:Initialize()
	--[[
		Change theme options here. Look at clockwork/framework/cl_theme.lua
		to see what you can override.
	--]]

	Clockwork.option:SetFont("info_text_font", "clandestine_InfoTextFont");
	Clockwork.option:SetFont("bar_text", "clandestine_MainText");
	Clockwork.option:SetFont("auto_bar_text", "clandestine_MainText");
	Clockwork.option:SetFont("main_text", "clandestine_MainText");
	Clockwork.option:SetFont("hints_text", "clandestine_IntroTextTiny");
	Clockwork.option:SetFont("large_3d_2d", "clandestine_Large3D2D");
	Clockwork.option:SetFont("scoreboard_name", "clandestine_ScoreboardName");
	Clockwork.option:SetFont("scoreboard_class", "clandestine_ScoreboardClass");
	Clockwork.option:SetFont("scoreboard_desc", "clandestine_ScoreboardDesc");
	Clockwork.option:SetFont("target_id_text", "clandestine_MenuTextSmall");
	Clockwork.option:SetFont("cinematic_text", "clandestine_CinematicText");
	Clockwork.option:SetFont("date_time_text", "clandestine_IntroTextSmall");
	Clockwork.option:SetFont("menu_text_big", "clandestine_MenuTextBig");
	Clockwork.option:SetFont("menu_text_huge", "clandestine_MenuTextHuge");
	Clockwork.option:SetFont("menu_text_tiny", "clandestine_IntroTextTiny");
	Clockwork.option:SetFont("intro_text_big", "clandestine_IntroTextBig");
	Clockwork.option:SetFont("menu_text_small", "clandestine_IntroTextSmall");
	Clockwork.option:SetFont("intro_text_tiny", "clandestine_IntroTextTiny");
	Clockwork.option:SetFont("intro_text_small", "clandestine_IntroTextSmall");
	Clockwork.option:SetFont("player_info_text", "clandestine_MainText");
	Clockwork.option:SetFont("chat_box_syntax", "clandestine_ChatSyntax");
	Clockwork.option:SetFont("chat_box_text", "clandestine_MainText");
	
	Clockwork.option:SetColor("information", Color(62, 70, 102, 255));
	Clockwork.option:SetColor("background", Color(0, 0, 0, 255));
	Clockwork.option:SetColor("target_id", Color(62, 70, 102, 255));
	//Clockwork.option:SetFont("bar_text", "DefaultFont");
	//Clockwork.option:SetFont("main_text", "DefaultFont");
	//Clockwork.option:SetFont("hints_text", "DefaultFont");

	Clockwork.option:SetKey("gradient", "clandestine/blue_grad");
	Clockwork.option:SetKey("schema_logo", "clandestine/zeta");
	Clockwork.option:SetKey("intro_image", "clandestine/intro")

	Clockwork.option:SetSound("click_release", "ambient/levels/prison/radio_random12.wav");
	Clockwork.option:SetSound("rollover", "ambient/levels/prison/radio_random2.wav");
	Clockwork.option:SetSound("click", "ambient/levels/prison/radio_random8.wav");
end;

function THEME:GetBarIconFromClass(class)
	--[[
		It's possible to return an icon to use for a particular bar class.
		For example to have a health bar icon you might do:
		
		return Material("path/to/my/health/bar/icon");
	--]]
end;

-- Called just before a bar is drawn.
function THEME.module:PreDrawBar(barInfo) end;

-- Called just after a bar is drawn.
function THEME.module:PostDrawBar(barInfo) end;

-- Called when the menu is opened.
function THEME.module:MenuOpened() end;

-- Called when the menu is closed.
function THEME.module:MenuClosed() end;

-- Called just before the weapon selection info is drawn.
function THEME.module:PreDrawWeaponSelectionInfo(info) end;

-- Called just before the local player's information is drawn.
function THEME.module:PreDrawPlayerInfo(boxInfo, information, subInformation) end;

-- Called after the character menu has initialized.
function THEME.hooks:PostCharacterMenuInit(panel) end;

-- Called every frame that the character menu is open.
function THEME.hooks:PostCharacterMenuThink(panel) end;

-- Called after the character menu is painted.
function THEME.hooks:PostCharacterMenuPaint(panel) end;

-- Called after a character menu panel is opened.
function THEME.hooks:PostCharacterMenuOpenPanel(panel) end;

-- Called after the main menu has initialized.
function THEME.hooks:PostMainMenuInit(panel) end;

-- Called after the main menu is rebuilt.
function THEME.hooks:PostMainMenuRebuild(panel) end;

-- Called after a main menu panel is opened.
function THEME.hooks:PostMainMenuOpenPanel(panel, panelToOpen) end;

-- Called after the main menu is painted.
function THEME.hooks:PostMainMenuPaint(panel) end;

-- Called every frame that the main menu is open.
function THEME.hooks:PostMainMenuThink(panel) end;

Clockwork.theme:Finish(THEME);