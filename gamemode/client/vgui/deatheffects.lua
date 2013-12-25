
surface.CreateFont( "ChatFont", 28, 800, false, false, "DeathFont" )
AlphaOfFadingThingy = 1
SpeedOfDadingThingy = 50

function DrawNewLifeMessage(um)
	local time = um:ReadFloat()
	local text = "You have forgotten everything in your past life! Obey the New Life Rule."
	RP08.DrawDecreaseBar( time, text, "DeathFont" )
end
usermessage.Hook( "DrawNLRBar", DrawNewLifeMessage )

function LetsThinkOfSomeShit()

	if LocalPlayer():Alive() then
		if AlphaOfFadingThingy >= 2 then
			AlphaOfFadingThingy = 1
		end
	else
		if AlphaOfFadingThingy < 255 then
			AlphaOfFadingThingy = math.Clamp( AlphaOfFadingThingy + SpeedOfDadingThingy * FrameTime(), 1, 255 ) -- We use FrameTime() so the effects are as smooth as possible
		end
	end

end
hook.Add( "Think", "ThinkOfAlpha", LetsThinkOfSomeShit )


function EffectsAsHealthDecends()

	if LocalPlayer().BeingGassed then return end

	-- Calculations for darken of screen 
	if LocalPlayer():Alive() then
		amounttodarken = math.Clamp( 0.002 * LocalPlayer():Health() - 0.1, -0.1, 0 ) -- Equation to calculate the amount to darken of their screen
	else
		amounttodarken = -0.1
	end
	
	-- Calculation for motion blur
	local amountblur = math.Clamp( 0.02 * LocalPlayer():Health(), 0.05, 1 )
	
	-- Color mod contrast
	local colorcontrast = math.Clamp( 0.01574803149606 * AlphaOfFadingThingy + 0.9842519685039, 1, 5 )
	
	-- Color mod multiplier
	local colormultiplier = math.Clamp( 0.01181102362204 * AlphaOfFadingThingy + 0.988188976378, 1, 4 )
	
	-- Sharpen contrast
	local sharpencontrast = math.Clamp( 0.01968503937007 * AlphaOfFadingThingy - 0.0196850393701, 0, 5 )
	
	-- Sharpen sin curve
	local sharpensinecurve = math.Clamp( math.sin( CurTime() ) * 5, -5, 5 )
	
	

	
	-- Now we actually do the effects
	
	
	-- Motion blur
	if LocalPlayer():Alive() then
		DrawMotionBlur( amountblur, 0.99, 0 )
	else
		DrawMotionBlur( 0.1, 0.99, 0 )
	end
	
	-- Color mod
 	local ColorTable = {} 
 	ColorTable[ "$pp_colour_addr" ] = 0
 	ColorTable[ "$pp_colour_addg" ] = 0 
 	ColorTable[ "$pp_colour_addb" ] = 0 
 	ColorTable[ "$pp_colour_brightness" ] = amounttodarken
 	ColorTable[ "$pp_colour_contrast" ] = colorcontrast
 	ColorTable[ "$pp_colour_colour" ] = colormultiplier
 	ColorTable[ "$pp_colour_mulr" ] = 0 
 	ColorTable[ "$pp_colour_mulg" ] = 0 
 	ColorTable[ "$pp_colour_mulb" ] = 0  
 	DrawColorModify( ColorTable ) 
	
	DrawSharpen( sharpencontrast, sharpensinecurve )
	
	-- Darken screen on death
	surface.SetDrawColor( 0, 0, 0, math.Round( AlphaOfFadingThingy ) )
	surface.DrawRect( -5, -5, ScrW() + 10, ScrH() + 10 )
	
end
hook.Add( "RenderScreenspaceEffects", "HealthEffects", EffectsAsHealthDecends )


-- Make players view of their eyes
function WatchTheRagDoll( ply )

	local ragdoll = ply:GetRagdollEntity()
	if not ragdoll or ragdoll == NULL or not ragdoll:IsValid() then return end
	local eyes = ragdoll:GetAttachment( ragdoll:LookupAttachment( "eyes" ) )


	local view = {
		origin = eyes.Pos,
		angles = eyes.Ang,
		fov = 90
	}
	
	return view
	
end
hook.Add( "CalcView"," CalcTheirView", WatchTheRagDoll )
