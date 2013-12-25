function GetTextHeight( font, str )

	surface.SetFont( font );
	local w, h = surface.GetTextSize( str );
	
	return h;
	
end



function RP08.DrawItemInfo(tr)

	local Itemname = tr.Entity:GetNWString( "Name")
	local Itemsize = "[Size: "..tr.Entity:GetNWString('Size').."]"
	local pos = tr.Entity:GetPos()
	local fade = math.Clamp(300 - distance, 1, 254 )

	pos = pos:ToScreen()

	local tex=surface.GetTextureID("BBRP/x0")//Gets the txture id for the brick texture
   surface.SetTexture(tex)
   surface.SetDrawColor(0,0,0,255)//Makes sure the image draws correctly
   surface.DrawTexturedRect(pos.x, pos.y-6,40,40) 
	
	local namelen = string.len( Itemname )
	draw.SimpleTextOutlined(Itemname, "TargetID", pos.x + 40 + (namelen * 4),pos.y-10, Color( 255, 186, 0, fade ),1,1,2,Color(0,0,0,fade))
	local sl = string.len( Itemsize )
	draw.SimpleTextOutlined(Itemsize, "TargetID", pos.x + 37 +(sl * 4), pos.y+10, Color( 255, 186, 0, fade ),1,1,1,Color(0,0,0,fade))
	
	
end

function DrawOwnableInfo(ent)

	local title = ent:GetNWString("title")
	
	if(title == "")then
		title = "For Sale (Press F4)"
	end
	pos = LocalPlayer():GetEyeTrace().HitPos:ToScreen();
	local fade = math.Clamp(255 - distance, 1, 254 )
		
	local col = Color( 255, 0, 0, fade)
	
	if(string.lower(title) == "nexus")then
		col = Color( 0, 0, 255, fade)
	end
	
	draw.SimpleTextOutlined( title , "GModToolSubtitle", pos.x + 1, pos.y + 1, col, 1,1,2,Color(255,255,255,fade));
end
