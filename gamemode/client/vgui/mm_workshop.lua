------------------------------
------RP08.ManMenu_Workshop----------
-------------------------------
local workshopcurrentitem = ""
------The Main List Box----------

local PANEL = {}

function PANEL:Init( )

	self:SetSize( mmwidth, mmheight-10 )

	local workshoplist = vgui.Create( "DPanelList", self )
 	workshoplist:SizeToContents() 
 	workshoplist:SetPadding(2) 
 	workshoplist:SetSpacing(3) 
	workshoplist:StretchToParent( 4, 4, 12, 44 )
	workshoplist:EnableVerticalScrollbar( )

		workshoplist:AddItem( vgui.Create("RP08.ManMenu_Workshop_HEADER", self) ) 

		for k, v in pairs( RP08.Workshoplist ) do
			workshopcurrentitem = k		
				workshoplist:AddItem( vgui.Create("RP08.ManMenu_Workshop_ITEM", self) ) 
		end
		workshoplist:Rebuild()
end

function PANEL:PerformLayout( )
self:StretchToParent( 0, 22, 0, 0 )
end	

vgui.Register( "RP08.ManMenu_Workshop", PANEL, "Panel" )
	

------HEADER----------	
local PANEL = {}

function PANEL:Init( )				
	self.Label001 = vgui.Create("DLabel", self) 
	self.Label001:SetText("Welcome to the store! Please select what you want!") 
	self.Label001:SetFont("coolvetica")
	self.Label001:SizeToContents()
	self.Label001:SetTextColor(Color(255,255,255))
end

function PANEL:PerformLayout( )

self.Label001:SetPos( 100, 3 )
end
	
vgui.Register( "RP08.ManMenu_Workshop_HEADER", PANEL, "DPanel" )	

------Each Item----------	
local PANEL = {}

function PANEL:Init( )
--RP08.Weapons.list[id] = {name, description, model, size, price}
	self:SetSize( mmwidth, 75 )
	self:SetPos( 1,5 )
	self.item = tostring(workshopcurrentitem)
		self.Label001 = vgui.Create("DLabel", self) 
		self.Label001:SetText(RP08.ItemData[self.item].Name) 
		self.Label001:SizeToContents()
		self.Label001:SetTextColor(Color(255,0,0))
		
		self.Label002 = vgui.Create("DLabel", self) 
		self.Label002:SetText(RP08.ItemData[self.item].Desc) 
		self.Label002:SizeToContents()
		self.Label002:SetTextColor(Color(255,255,255))
		
		local rightcoltext = ""
		
		rightcoltext = rightcoltext .. "Amount in Batch: " .. RP08.Workshoplist[self.item].BatchAmount
		
		rightcoltext = rightcoltext .. "\n"
		
		rightcoltext = rightcoltext .. "Cost: "..(RP08.Workshoplist[self.item].BatchAmount * RP08.Workshoplist[self.item].Costperitem)
		
		rightcoltext = rightcoltext .. "\n"
		
		local tneed = RP08.Workshoplist[self.item].Team
		
		if (tneed)then
			rightcoltext = rightcoltext .. RP08.Teams.list[tneed][1] .. " only"
		
		end
		
		self.labelrightcol = vgui.Create("DLabel", self) 
		self.labelrightcol:SetText(rightcoltext)
		self.labelrightcol:SizeToContents()
		self.labelrightcol:SetTextColor(Color(255,255,255))
	----------------------	
	--Spawn Icon
	-----------------------
		self.SpawnIcon001 = vgui.Create( "SpawnIcon", self ) 
		self.SpawnIcon001:SetModel( RP08.ItemData[self.item].Model )
		self.SpawnIcon001:SetToolTip(nil)
		self.SpawnIcon001.DoClick = function( self1 ) return end
		self.SpawnIcon001.PaintOverOLD = self.SpawnIcon001.PaintOver
		self.SpawnIcon001.OnMousePressed = function()
			return
		end
		
	self.OnCursorEntered = function()
		self.SpawnIcon001.PaintOver = self.SpawnIcon001.PaintOverHovered 
	end
	
	self.OnCursorExited = function()
		self.SpawnIcon001.PaintOver = self.SpawnIcon001.PaintOverOLD
	end
	
	----------------------	
	--Buttons
	-----------------------

					self.button = vgui.Create("DButton", self)
					self.button:SetText("Manufacture")
					self.button:SetWide(150)
					self.button.OnCursorEntered = function()
						self.SpawnIcon001.PaintOver = self.SpawnIcon001.PaintOverHovered 
					end
					self.button.OnCursorExited = function()
							self.SpawnIcon001.PaintOver = self.SpawnIcon001.PaintOverOLD
					end

					//DROP
					self.button.DoClick = function()
						RunConsoleCommand("RP08_Workshop", self.item)
						OpenMainMenu()
					end

end

function PANEL:PerformLayout( )
		self.SpawnIcon001:SetPos( 5 , 5 ) 
		self.Label001:SetPos( 85, 5 )
		self.Label002:SetPos( 85, 25 )
		self.labelrightcol:SetPos( 450, 15 )
		self.button:SetPos( 85, 50 )	
end

	
vgui.Register( "RP08.ManMenu_Workshop_ITEM", PANEL, "DPanel" )