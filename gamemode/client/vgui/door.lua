/*---------------------------------------------------------
  Door system
---------------------------------------------------------*/
RP08.door = {}


function RP08.door.CreatePanel(msg)

	local status = msg:ReadLong()
	local doortitle = msg:ReadString() or LocalPlayer():Name() .. "'s Door"
	
	local ownernick = msg:ReadString() or "error"
	
	local uidname = {}
	
	for _, pl1 in pairs(player.GetAll()) do  

		uidname[pl1:UserID()] = pl1:Nick()
		
	end
	
	local pls = {}
	if(status == 4)then -- We are the owner
		for k, v in pairs(player.GetAll( ))do
			local userid = msg:ReadShort()
			local type1 = msg:ReadShort()
			pls[userid] = {uidname[userid], type1}
		end
	end
		
	local InTheList = {}	
	local InTheList2 = {}

	local height = 200
	local width = 200
	
	if(status == 4)then -- We are the owner

		height = 510
		width = 430
	end
	
	local doorpan = vgui.Create("DFrame")
	doorpan:SetPos((ScrW() / 2) - (width /2), (ScrH() / 2) - (height/2)) 
	doorpan:SetSize(width, height)
	doorpan:SetTitle( "Door Options" ) 
	doorpan:SetVisible( true )
	doorpan:MakePopup()
	
	local y = 30
	local text2 = ""
	
	if(status == 1)then
		text2 = "Unownable"	
	elseif(status == 2 or status == 3)then
		text2 = "Owned by:"
		title = ownernick
	elseif(status == 0)then
		text2 = "For Sale"
		doortitle = LocalPlayer():Nick() .. "'s Door"
	end
	
	if not(text2 == "")then -- unowned
		Label001 = vgui.Create("DLabel", doorpan) 
		Label001:SetText(text2) 
		Label001:SetFont("GModToolName") 
		Label001:SizeToContents()
		Label001:SetPos((width / 2) - (Label001:GetWide() / 2), y ) 
		Label001:SetTextColor(Color(255,0,0))
		y = y + 60
	end
	
	
	
		local te = vgui.Create( "DTextEntry", doorpan ) 
		if(status == 2 or status == 3)then -- owner by someone else
			te:SetValue(ownernick)
		else
			te:SetValue(doortitle)
		end
		te:SetSize(150,25)
		te:SetPos( 25, y ) 

	if(status == 2 or status == 3)then -- owner by someone else
	y = y + 40
		Label001 = vgui.Create("DLabel", doorpan) 
		if(status == 3)then
			Label001:SetText("You have: Access") 
			Label001:SetTextColor(Color(0,255,0))
		else
			Label001:SetText("You have: No Access") 
			Label001:SetTextColor(Color(255,0,0))
		end
	--	Label001:SetFont("GModToolName") 
		Label001:SizeToContents()
		Label001:SetPos((width / 2) - (Label001:GetWide() / 2), y ) 
		
		y = y + 60
	end
		
			
	if(status == 4)then -- We are the owner
		local sellbutton = vgui.Create( "DButton", doorpan ) 
		sellbutton:SetText("Sell")
		sellbutton:SetSize(150,25)
		sellbutton:SetPos( te:GetWide() + 100, y ) 
		sellbutton.OnMousePressed = function() 
			RunConsoleCommand("RP08_Doors", "sell")	
			doorpan:Remove()
		end
	elseif(status == 0)then
	y = y + 50
		local buybutton = vgui.Create( "DButton", doorpan ) 
		buybutton:SetText("Buy")
		buybutton:SetSize(150,25)
		buybutton:SetPos(25, y ) 
		buybutton.OnMousePressed = function() 	
			RunConsoleCommand("RP08_Doors", "buy", te:GetValue()) 
			doorpan:Remove()
		end
	end
	
	y = y + 35


	if(status == 4)then
		local List = vgui.Create( "DListView", doorpan ) 
		List:SetMultiSelect( false )
		List:SetSize(200, 400)
		List:SetPos( 10, y ) 

		local List2 = vgui.Create( "DListView", doorpan ) 
		List2:SetMultiSelect( false )
		List2:SetSize(200, 400)
		List2:SetPos( 220, y ) 
	
		List.DoDoubleClick = function( LineID, Line ) 
			List2:AddLine( pls[InTheList[Line]][1] ) 
			table.insert(InTheList2,InTheList[Line])
			InTheList[Line] = nil
			List:RemoveLine(Line) 
		end
	
		List2.DoDoubleClick = function( LineID, Line )
			if(pls[InTheList2[Line]][2] == 2)then
				Derma_Message( "You cannot remove the owners rights" )
			else
				List:AddLine( pls[InTheList2[Line]][1] ) 
				table.insert(InTheList,InTheList2[Line])		
				InTheList2[Line] = nil
				List2:RemoveLine(Line) 
			end
		end
	
		local Col1 = List:AddColumn( "No Access" ) 
		local Col11 = List2:AddColumn( "Acess" ) 
		for k, v in pairs(pls)do
			if(v[2] == 1 or v[2] == 2)then
				List2:AddLine( v[1] ) 
				table.insert(InTheList2, k)
			else
				List:AddLine( v[1] ) 
				table.insert(InTheList, k )
			end
		end 
	
		y = y + 410
		
		local sellbutton = vgui.Create( "DButton", doorpan ) 
		sellbutton:SetText("Submit New Data")
		sellbutton:SetSize(100,25)
		sellbutton:SetPos( (width / 2)-(sellbutton:GetWide() / 2), y ) 
		sellbutton.OnMousePressed = function() 	
		if(doortitle ~= te:GetValue())then
			RunConsoleCommand("RP08_Doors", "updatetitle", te:GetValue())
		end
		local accessors = ""
		
			for k, v in pairs(InTheList2)do
				
				if(accessors == "")then
					accessors = v
				else
					accessors = accessors .. ";" .. v
				end
				
			end
		RunConsoleCommand("RP08_Doors", "updateaccessors", accessors) 
		doorpan:Remove()
		end
	y = y + 35
	end
end

usermessage.Hook( "RP08_DoorsCreatePanel", RP08.door.CreatePanel );