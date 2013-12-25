surface.CreateFont( "ChatFont", 24, 800, false, false, "BarsFont" )

function RP08.DrawProgressBar( time, txt )
	if hook.GetTable()[ "HUDPaint" ][ "DrawProgressBar" ] then
		hook.Remove( "HUDPaint", "DrawProgressBar" )
	end
	local duration = time or 15
	local txt = txt or "Progress Bar"
	local start = CurTime()
	
	local function DrawAProgressBar()
		local dtime = CurTime() - start
		
		if dtime > duration then
			hook.Remove( "HUDPaint", "DrawProgressBar" )
			return
		end
		
		surface.SetFont( "BarsFont" )
		local tX, tY = surface.GetTextSize( txt )
		local width = tX + 20 -- ScrW() * 0.75
		local height = tY + 20 -- ScrH() * 0.2
		local x = (ScrW()/2) - (width/2)
		local y = (ScrH()/2) - (height/2)
		RP08.DrawWordBar(x, y, width, height, duration, dtime, txt, "BarsFont", Color( 50, 50, 255, 255 ), Color( 255, 255, 255, 255 ), 10 )
		
	end
	hook.Add( "HUDPaint", "DrawProgressBar", DrawAProgressBar )
end

usermessage.Hook( "CreateProgressBar", function(um)
	local duration = um:ReadFloat()
	local txt = um:ReadString()
	RP08.DrawProgressBar( duration, txt )
end )

function RP08.KillProgressBar()
	if hook.GetTable()[ "HUDPaint" ][ "DrawProgressBar" ] then
		hook.Remove( "HUDPaint", "DrawProgressBar" )
	end
end
usermessage.Hook( "KillProgressBar", RP08.KillProgressBar )



function RP08.DrawDecreaseBar( time, txt )
	if hook.GetTable()[ "HUDPaint" ][ "DrawDecreaseBar" ] then
		hook.Remove( "HUDPaint", "DrawDecreaseBar" )
	end
	local duration = time or 15
	local txt = txt or "Decrease Bar"
	local start = CurTime()
	
	local function DrawADecreaseBar()
		local dtime = CurTime() - start
		
		if dtime > duration then
			hook.Remove( "HUDPaint", "DrawDecreaseBar" )
			return
		end
		
		surface.SetFont( "BarsFont" )
		local tX, tY = surface.GetTextSize( txt )
		local width = tX + 20 -- ScrW() * 0.75
		local height = tY + 20 -- ScrH() * 0.2
		local x = (ScrW()/2) - (width/2)
		local y = (ScrH()/2) - (height/2)
		RP08.DrawWordBar(x, y, width, height, duration, duration - dtime, txt, "BarsFont", Color( 50, 50, 255, 255 ), Color( 255, 255, 255, 255 ), 10 )
		
	end
	hook.Add( "HUDPaint", "DrawDecreaseBar", DrawADecreaseBar )
end

usermessage.Hook( "CreateDecreaseBar", function(um)
	local duration = um:ReadFloat()
	local txt = um:ReadString()
	RP08.DrawDecreaseBar( duration, txt )
end )

function RP08.KillDecreaseBar()
	if hook.GetTable()[ "HUDPaint" ][ "DrawDecreaseBar" ] then
		hook.Remove( "HUDPaint", "DrawDecreaseBar" )
	end
end
usermessage.Hook( "KillDecreaseBar", RP08.KillDecreaseBar )



