
surface.CreateFont( "ChatFont", 22, 100, true, false, "PlInfoFont" )

function RP08.DrawBar(x, y, width, height, maximum, variable, color, borderbold, bordercolor, inercolor)
	local bordercolor = bordercolor or Color(0, 0, 0, 200)
	local inercolor = inercolor or Color(75, 75, 75, 150)
	local color = color or Color(255, 255, 255, 255)
	local borderbold = borderbold or 4
	draw.RoundedBox( borderbold, x, y, width, height, bordercolor )
	draw.RoundedBox( 0, x + (borderbold/2), y + (borderbold/2), width - borderbold, height - borderbold, inercolor )
	draw.RoundedBox( 0, x + (borderbold/2), y + (borderbold/2), math.Clamp( ( (width - borderbold) / maximum ) * variable, 0, width - borderbold ), height - borderbold, color )
end

function RP08.DrawWordBar(x, y, width, height, maximum, variable, text, font, color, textcolor, borderbold, bordercolor, inercolor)
	local bordercolor = bordercolor or Color(0, 0, 0, 200)
	local inercolor = inercolor or Color(75, 75, 75, 150)
	local color = color or Color(255, 255, 255, 255)
	local borderbold = borderbold or 4
	local font = font or "ChatFont"
	local textcolor = textcolor or Color(255, 255, 255, 255)
	draw.RoundedBox( borderbold, x, y, width, height, bordercolor )
	draw.RoundedBox( 0, x + (borderbold/2), y + (borderbold/2), width - borderbold, height - borderbold, inercolor )
	draw.RoundedBox( 0, x + (borderbold/2), y + (borderbold/2), math.Clamp( ( (width - borderbold) / maximum ) * variable, 0, width - borderbold ), height - borderbold, color )
	
	-- Set the font of the text to this one
	surface.SetFont(font)
	local tX, tY = surface.GetTextSize( text )
	
	-- Adjust the x and y positions
	local Tx = x + (width / 2)
	local Ty = ( y - ( tY / 2 ) ) + (height / 2)
	
	-- Draw text on the bar
	draw.DrawText(text, font, Tx + 1, Ty + 1, Color(0, 0, 0, 255), 1)
	draw.DrawText(text, font, Tx, Ty, textcolor, 1)
end

function RP08.DrawFadingText( msg, x, y, color, font, align, duration, fade )
	if hook.GetTable()[ "HUDPaint" ][ "DrawFadingText" ] then
		hook.Remove( "HUDPaint", "DrawFadingText" )
	end
	color = color or Color( 255, 51, 51, 255 )
	font = font or "PlInfoFont"
	align = align or TEXT_ALIGN_CENTER
	duration = duration or 5
	fade = fade or 0.5
	local start = CurTime()
	
	local function drawToScreen()
		local alpha = 255
		local dtime = CurTime() - start
		
		if dtime > duration then -- Our time has come :'(
			hook.Remove( "HUDPaint", "DrawFadingText" )		
			return
		end
		
		if fade - dtime > 0 then -- beginning fade
			alpha = (fade - dtime) / fade -- 0 to 1
			alpha = 1 - alpha -- Reverse
			alpha = alpha * 255
		end
		
		if duration - dtime < fade then -- ending fade
			alpha = (duration - dtime) / fade -- 0 to 1
			alpha = alpha * 255
		end		
		color.a  = alpha
		
		draw.DrawText( msg, font, x, y, color, align )
	end

	hook.Add( "HUDPaint", "DrawFadingText", drawToScreen )
end