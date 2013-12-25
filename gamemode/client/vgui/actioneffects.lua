

function EndStunStickFlash()

	StunStickFlashAlpha = -1;

end

function StunStickFlash()

	if( StunStickFlashAlpha == -1  ) then
		StunStickFlashAlpha = 0;
	end
	
	timer.Create( LocalPlayer():EntIndex() .. "StunStickFlashTimer", .3, 1, EndStunStickFlash );

end
usermessage.Hook( "StunStickFlash", StunStickFlash );

usermessage.Hook( "StopGassedEffects", function()
	hook.Remove( "RenderScreenspaceEffects", "DrawTheseGasEffects" )
	LocalPlayer().BeingGassed = false
end)

usermessage.Hook( "GassedEffects", function()
	local duration = 30
	local start = CurTime()
	LocalPlayer().BeingGassed = true
	
	local function DrawTheseGasEffects()
		local dtime = CurTime() - start
		
		if dtime > duration then -- Our time has come :'(
			hook.Remove( "RenderScreenspaceEffects", "DrawTheseGasEffects" )
			LocalPlayer().BeingGassed = false
			return
		end
		
		DrawMaterialOverlay( "models/props_lab/Tank_Glass001", 0.075 )
		
		DrawMotionBlur( 0.25, 1, 0.06 )
		
	 	local GasColorTable = {} 
	 	GasColorTable[ "$pp_colour_addr" ] = 102 * 0.02
	 	GasColorTable[ "$pp_colour_addg" ] = 95 * 0.02
	 	GasColorTable[ "$pp_colour_addb" ] = 0 * 0.02
	 	GasColorTable[ "$pp_colour_brightness" ] = -1.4
	 	GasColorTable[ "$pp_colour_contrast" ] = 1
	 	GasColorTable[ "$pp_colour_colour" ] = 0.15
	 	GasColorTable[ "$pp_colour_mulr" ] = 0 * 0.1 
	 	GasColorTable[ "$pp_colour_mulg" ] = 0 * 0.1
	 	GasColorTable[ "$pp_colour_mulb" ] = 0 * 0.1  
	 	DrawColorModify( GasColorTable )
		
	end
	hook.Add( "RenderScreenspaceEffects", "DrawTheseGasEffects", DrawTheseGasEffects )
end )