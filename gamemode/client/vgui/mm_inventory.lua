------------------------------
------RP08.ManMenu_Inventory----------
-------------------------------

------The Main List Box----------

local PANEL = {}

function PANEL:Init( )

	self:SetSize( mmwidth, mmheight-10 )

	globallist = vgui.Create( "DPanelList", self )
 	globallist:SizeToContents() 
 	globallist:SetPadding(2) 
 	globallist:SetSpacing(3) 
	globallist:StretchToParent( 4, 4, 12, 44 )
	globallist:EnableVerticalScrollbar( )
	self:Think(self)
end

function PANEL:PerformLayout( )
self:StretchToParent( 0, 22, 0, 0 )
end	

function PANEL:Think()

	if(RP08.InventoryUpdate == true)then
		RP08.InventoryUpdate = false
		self.i = 50
		globallist:Clear() 
		globallist:AddItem( vgui.Create("RP08.ManMenu_Inventory_HEADER", self) ) 
		for k, v in pairs( RP08.PlayerInventory ) do
			globalitem = k			
			if(RP08.ItemData[tostring(k)])then
				globallist:AddItem( vgui.Create("RP08.ManMenu_Inventory_ITEM", self) ) 
			end
		end
		globallist:Rebuild()
	end
end

vgui.Register( "RP08.ManMenu_Inventory", PANEL, "Panel" )

------Each Item----------	
local PANEL = {}

function PANEL:Init( )
	self.inventoryfunction = {}
	self:SetSize( mmwidth, 75 )
	self:SetPos( 1,5 )
	self.item = tostring(globalitem)

		self.Label001 = vgui.Create("DLabel", self) 
		self.Label001:SetText(RP08.ItemData[self.item].Name) 
		self.Label001:SizeToContents()
		self.Label001:SetTextColor(Color(255,0,0))
		
		self.Label002 = vgui.Create("DLabel", self) 
		self.Label002:SetText(RP08.ItemData[self.item].Desc) 
		self.Label002:SizeToContents()
		self.Label002:SetTextColor(Color(255,255,255))
		
		self.label_amount = vgui.Create("DLabel", self) 
		self.label_amount:SetText("Amount: "..RP08.PlayerInventory[self.item])
		self.label_amount:SizeToContents()
		self.label_amount:SetTextColor(Color(255,255,255))
		
	
		
		self.label_size = vgui.Create("DLabel", self) 
		self.label_size:SetText("Size:" .. RP08.ItemData[self.item].Size)
		self.label_size:SizeToContents()
		self.label_size:SetTextColor(Color(255,255,255))
	----------------------	
	--Spawn Icon
	-----------------------
		self.SpawnIcon001 = vgui.Create( "SpawnIcon", self ) 
		if (RP08.ItemData[self.item].Skin)then
			self.SpawnIcon001:SetModel( RP08.ItemData[self.item].Model, RP08.ItemData[self.item].Skin ) 
		else
			self.SpawnIcon001:SetModel( RP08.ItemData[self.item].Model ) 
		end
		self.SpawnIcon001:SetToolTip(nil)
		self.SpawnIcon001.DoClick = function( self1 ) return end
		self.SpawnIcon001:SetToolTip(nil)
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

	if(RP08.ItemData[self.item].OnUse)then
		self.inventoryfunction[1] = "Drop"
		self.inventoryfunction[2] = "Destroy All"
		self.inventoryfunction[3] = "Use"
	else
		self.inventoryfunction[1] = "Drop"
		self.inventoryfunction[2] = "Destroy All"
	end
	
		self.button = {}
				for j=1,#self.inventoryfunction do
					self.button[j] = vgui.Create("DButton", self)
					self.button[j]:SetText(self.inventoryfunction[j])
					self.button[j].OnCursorEntered = function()
						self.SpawnIcon001.PaintOver = self.SpawnIcon001.PaintOverHovered 
					end
					self.button[j].OnCursorExited = function()
							self.SpawnIcon001.PaintOver = self.SpawnIcon001.PaintOverOLD
					end
				end
				
				//DROP
					self.button[1].DoClick = function()

					RunConsoleCommand("RP08_inventory", RP08.ItemData[self.item].UniqueID, "dropitem", "1")
						OpenMainMenu()
					end
					
					//Destroy		
					self.button[2].DoClick = function()
						
							local menu123 = DermaMenu() // create a derma menu
														
   							menu123:AddOption("Are You Sure?", function() end ) // adding options
   							menu123:AddOption("No", function() end ) // adding options
   							menu123:AddOption("Yes", function() RunConsoleCommand("RP08_inventory", RP08.ItemData[self.item].UniqueID, "destroyitem") end ) // adding options
  							menu123:Open() 
						--OpenMainMenu()
						--globallist:RemoveItem(self) 
					--	globallist:Rebuild()	
					end	
				
				//USE
				if(self.button[3])then
					self.button[3].DoClick = function()
						RunConsoleCommand("RP08_inventory", RP08.ItemData[self.item].UniqueID, "useitem")		
					end
				end
				

end

function PANEL:PerformLayout( )
		self.SpawnIcon001:SetPos( 5 , 5 ) 
		self.Label001:SetPos( 85, 5 )
		self.Label002:SetPos( 85, 25 )
		self.label_amount:SetPos( 480, 5 )
		self.label_size:SetPos( 480, 45 )
		local i3 = 85
		for j=1,#self.inventoryfunction do
			self.button[j]:SetPos( i3, 50 )	
				i3 = i3 + self.button[j]:GetWide()
		end
end

	
vgui.Register( "RP08.ManMenu_Inventory_ITEM", PANEL, "DPanel" )

------HEADER----------	
local PANEL = {}

function PANEL:Init( )				
	self.Label001 = vgui.Create("DLabel", self) 
	self.Label001:SetText("Space Used: ".. RP08.GetInventorySize()) 
	self.Label001:SetFont("coolvetica")
	self.Label001:SizeToContents()
	self.Label001:SetTextColor(Color(255,255,255))
	
end

function PANEL:PerformLayout( )

self.Label001:SetPos( 100, 3 )
end
	
vgui.Register( "RP08.ManMenu_Inventory_HEADER", PANEL, "DPanel" )
