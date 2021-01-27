local PLUGIN = PLUGIN;

local DefMats = {}
local DefClrs = {}

-- A most likely futile attempt to make things faster
local pairs = pairs
local string = string
local render = render

local ColorTab = 
{
	[ "$pp_colour_addr" ] 		= -.4,
	[ "$pp_colour_addg" ] 		= -.5,
	[ "$pp_colour_addb" ] 		= -.5,
	[ "$pp_colour_brightness" ] 	= .1,
	[ "$pp_colour_contrast" ] 	= 1,
	[ "$pp_colour_colour" ] 	= 0,
	[ "$pp_colour_mulr" ] 		= 0,
	[ "$pp_colour_mulg" ] 		= 0,
	[ "$pp_colour_mulb" ] 		= 0,
}

local Color_Brightness		= 0.8
local Color_Contrast 		= 1.1
local Color_AddGreen		= -0.35
local Color_MultiplyGreen 	= 0.028

local NVTab = 
{
	[ "$pp_colour_addr" ] 		= -1,
	[ "$pp_colour_addg" ] 		= Color_AddGreen,
	[ "$pp_colour_addb" ] 		= -1,
	[ "$pp_colour_brightness" ] = Color_Brightness,
	[ "$pp_colour_contrast" ]	= Color_Contrast,
	[ "$pp_colour_colour" ] 	= 0,
	[ "$pp_colour_mulr" ] 		= 0,
	[ "$pp_colour_mulg" ] 		= Color_MultiplyGreen,
	[ "$pp_colour_mulb" ] 		= 0
}

-- Called when screen space effects should be rendered.
function PLUGIN:RenderScreenspaceEffects()
    local cwClient = Clockwork.Client;
    local nvdActive = cwClient:GetSharedVar("nvdActive");
    local nvdType = cwClient:GetSharedVar("nvdType");

    if (nvdActive and nvdType == "flir") then
        //print ("Flir ACTIVE.")
        for k,v in pairs( ents.GetAll() ) do
		
			if string.sub( (v:GetModel() or "" ), -3) == "mdl" then -- only affect models
			
				-- Inefficient, but not TOO laggy I hope
				local r = v:GetColor().r
				local g = v:GetColor().g
				local b = v:GetColor().b
				local a = v:GetColor().a
				if (a > 0) then
					
					local entmat = v:GetMaterial()

					if v:IsNPC() or v:IsPlayer() then -- It's alive!
					
						if not (r == 255 and g == 255 and b == 255 and a == 255) then -- Has our color been changed?
							DefClrs[ v ] = Color( r, g, b, a )  -- Store it so we can change it back later
							v:SetColor( 255, 255, 255, 255 ) -- Set it back to what it should be now
						end
						
						if entmat ~= "xray/living" then -- Has our material been changed?
							DefMats[ v ] = entmat -- Store it so we can change it back later
							v:SetMaterial( "xray/living" ) -- The xray matierals are designed to show through walls
						end
						
					else -- It's a prop or something
					
						if not (r == 255 and g == 255 and b == 255 and a == 255) then
							DefClrs[ v ] = Color( r, g, b, a )
							v:SetColor( 255, 255, 255, 255 )
						end
					
						if entmat ~= "xray/prop" then
							DefMats[ v ] = entmat
							v:SetMaterial( "xray/living" )
						end
					end
				end
			end
		end
	    -- Colormod
		DrawColorModify( ColorTab ) 
		
		-- Bloom
		DrawBloom(
	    .15,  					-- Darken
	    1,				-- Multiply
	    9, 				-- Horizontal Blur
	    9, 				-- Vertical Blur
	    1, 				-- Passes
	    1, 				-- Color Multiplier
	    1, 				-- Red
	    1, 				-- Green
	    1 
	    ) 			-- Blue
	elseif (nvdActive and nvdType == "nv") then
		DrawColorModify( NVTab ) 
		
		-- Bloom
		DrawBloom(
	    .1,  					-- Darken
	    1,				-- Multiply
	    9, 				-- Horizontal Blur
	    9, 				-- Vertical Blur
	    1, 				-- Passes
	    1, 				-- Color Multiplier
	    1, 				-- Red
	    1, 				-- Green
	    1 
	    ) 			-- Blue
    elseif (!nvdActive) then
        //print ("Flir INACTIVE.")
        -- Set colors and materials back to normal
		for ent,mat in pairs( DefMats ) do
			if ent:IsValid() then
				ent:SetMaterial( mat )
			end
		end
		
		for ent,clr in pairs( DefClrs ) do
			if ent:IsValid() then
				ent:SetColor( clr.r, clr.g, clr.b, clr.a )
			end
		end
		
		-- Clean up our tables- we don't need them anymore.
		DefMats = {}
		DefClrs = {}
    end
end

function PLUGIN:Think()
	local cwClient = Clockwork.Client;
	local nvdActive = cwClient:GetSharedVar("nvdActive");
    local nvdType = cwClient:GetSharedVar("nvdType");
    local illumArea = 512 * 2;
    local Brightness = 1;

	if (nvdActive and nvdType != "") then
		for i,v in pairs(player.GetAll()) do
	    	local nvdVActive = v:GetSharedVar("nvdActive");
	    	local nvdVType = v:GetSharedVar("nvdType");
	    	
	    	if ((nvdVActive and nvdVType != "") or v:IsBot()) then
	    		local dirLight = DynamicLight(v:EntIndex() * 2 + 1);

				dirLight.Pos = v:GetShootPos();
				dirLight.r = 125 * Brightness;
				dirLight.g = 255 * Brightness;
				dirLight.b = 125 * Brightness;
				dirLight.brightness = .7;
				//dirLight.dir = v:GetAimVector() * illumArea * 10;
				//dirLight.innerangle = 30;
				//dirLight.outerangle = 45;

				dirLight.Size = illumArea;
				dirLight.Decay = illumArea;

				dirLight.DieTime = CurTime() + FrameTime() * 3
	    	end;
    	end;

		/*local dlight = DynamicLight(cwClient:EntIndex() * 2 + 1);

		dlight.Pos = cwClient:GetShootPos();
		dlight.r = 125 * Brightness;
		dlight.g = 255 * Brightness;
		dlight.b = 125 * Brightness;
		dlight.brightness = 1;

		dlight.Size = illumArea
		dlight.Decay = illumArea

		dlight.DieTime = CurTime() + FrameTime() * 3*/

		local dirLight = DynamicLight(cwClient:EntIndex() * 2 + 1);

		dirLight.Pos = cwClient:GetShootPos();
		dirLight.r = 125 * Brightness;
		dirLight.g = 255 * Brightness;
		dirLight.b = 125 * Brightness;
		dirLight.brightness = .7;
		//dirLight.dir = cwClient:GetAimVector() * illumArea * 10;
		//dirLight.innerangle = 30;
		//dirLight.outerangle = 45;

		dirLight.Size = illumArea;
		dirLight.Decay = illumArea;

		dirLight.DieTime = CurTime() + FrameTime() * 3
	end;
end;

hook.Add("HUDPaint", "DrawFLIRData", function()
    local cwClient = Clockwork.Client;
    local nvdActive = cwClient:GetSharedVar("nvdActive");
    local nvdType = cwClient:GetSharedVar("nvdType");
    if (nvdActive and nvdType == "flir") then
        draw.DrawText( "FLIR ONLINE", "DebugFixed", ScrW() * 0.5, ScrH() * 0.25, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
    elseif (nvdActive and nvdType == "nv") then
    	draw.DrawText( "NIGHT VISION ONLINE", "DebugFixed", ScrW() * 0.5, ScrH() * 0.25, Color( 50, 50, 50, 255 ), TEXT_ALIGN_LEFT )
    end
end)