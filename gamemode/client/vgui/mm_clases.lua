 /*--------------------------------------------------------- 
	Name: 	Main Menu (Classes)
---------------------------------------------------------*/ 
--RP08.Teams.list[id] = {name, color, malemodel, femalemodel, maxallowed}
--for i=1,#RP08.Teams.list do
------The Main List Box----------

local PANEL = {}

function PANEL:Init( )

	self:SetSize( mmwidth, mmheight-10 )
	
	self.list = vgui.Create( "DPanelList", self )
 	self.list:SizeToContents() 
 	self.list:SetPadding(2) 
 	self.list:SetSpacing(3) 
	self.list:StretchToParent( 4, 4, 12, 44 )
	self.list:EnableVerticalScrollbar( ) 

	for i=1,#RP08.Teams.list do
	globali = i
		if not(RP08.Teams.list[i][5] == 0)then
			self.list:AddItem( vgui.Create("RP08.ManMenu_Classes_ITEM", self) ) 
		end
	end
	globali = nil
	self.list:Rebuild()
end

function PANEL:PerformLayout( )
self:StretchToParent( 0, 22, 0, 0 )
end	

	vgui.Register( "RP08.ManMenu_Classes", PANEL, "Panel" )
	
local PANEL = {}

------Each Item----------

function PANEL:Init( )
	self.classesfunction = {}

	self:SetSize( mmwidth, 75 )
	self:SetPos( 1,5 )
	
self.i = globali

local maxallowed = RP08.Teams.list[self.i][5]
	
		self.Label001 = vgui.Create("DLabel", self) 
		if (maxallowed == 64)then
			self.Label001:SetText("Amount: " .. team.NumPlayers(tonumber(self.i)) ) 
		else	
			self.Label001:SetText("Amount: " .. team.NumPlayers(tonumber(self.i)) .. "/" .. RP08.Teams.list[self.i][5]) 
		end
		self.Label001:SizeToContents()
		self.Label001:SetTextColor(Color(255,0,0))
		
		self.Label002 = vgui.Create("DLabel", self) 
		self.Label002:SetText(RP08.Teams.list[self.i][1]) 
		self.Label002:SizeToContents()
		self.Label002:SetTextColor(Color(255,255,255))
	
		self.SpawnIcon001 = vgui.Create( "SpawnIcon", self ) 
				self.SpawnIcon001:SetModel( RP08.Teams.list[self.i][3] ) 
		self.SpawnIcon001:SetToolTip(nil)
		self.SpawnIcon001.DoClick = function( self1 ) return end
		self.SpawnIcon001:SetToolTip(nil)
		self.SpawnIcon001.OnMousePressed = function()
			return
		end
	
	self.OnCursorEntered = function()
		self.SpawnIcon001.PaintOverOLD = self.SpawnIcon001.PaintOver
		self.SpawnIcon001.PaintOver = self.SpawnIcon001.PaintOverHovered 
	end
	
	self.OnCursorExited = function()
		self.SpawnIcon001.PaintOver = self.SpawnIcon001.PaintOverOLD
	end	
					self.buttonclickable = false
					self.button = vgui.Create("DButton", self)
					self.button:SetText("ERROR")
					self.button:SetWide(150)	
					self.button:SetConsoleCommand("bb_changeclass", self.i)
					self.button.i = self.i
					self.button.DoClick = function(self)	end
					
	self.button.OnCursorEntered = function()
		self.SpawnIcon001.PaintOverOLD = self.SpawnIcon001.PaintOver
		self.SpawnIcon001.PaintOver = self.SpawnIcon001.PaintOverHovered 
	end
	
	self.button.OnCursorExited = function()
		self.SpawnIcon001.PaintOver = self.SpawnIcon001.PaintOverOLD
	end
	
	timer.Create( self.i .. "updateinfo" , 3, 0, self.UpdateInfo, self)
	self:UpdateInfo(self)
end

function PANEL:UpdateInfo()

	if (LocalPlayer():Team( ) == self.i)then
		self:SetPaintBackground(false)
	else
		self:SetPaintBackground(true)
	end
	

	if(LocalPlayer():Team( ) == self.i)then
		self.button:SetText("Current Class")
		self.buttonclickable = false
	elseif(team.NumPlayers(tonumber(self.i)) >= RP08.Teams.list[self.i][5])then
		self.button:SetText("Max Players")
		self.buttonclickable = false
	elseif(RP08.Teams.list[self.i][6] and RP08.Teams.list[self.i][6] == true)then
		self.button:SetText("Vote To Become")
		self.buttonclickable = true
	else
		self.button:SetText("Change to")
		self.buttonclickable = true
	end
		
	if(self.buttonclickable == true)then
		self.button.DoClick = function(self)
			OpenMainMenu()	
			RunConsoleCommand( "bb_changeclass", self.i )  
		end
	else
			self.button.DoClick = function(self) return end
	end
	
	if (RP08.Teams.list[self.i][5] == 64)then
		self.Label001:SetText("Amount: " .. team.NumPlayers(tonumber(self.i)) ) 
	else	
		self.Label001:SetText("Amount: " .. team.NumPlayers(tonumber(self.i)) .. "/" .. RP08.Teams.list[self.i][5]) 
	end
end

function PANEL:PerformLayout( )
		self.SpawnIcon001:SetPos( 5 , 5 ) 
		self.Label001:SetPos( 100, 5 )
		self.Label002:SetPos( 100, 25 )
		self.button:SetPos( 100, 50 )	
end

	
vgui.Register( "RP08.ManMenu_Classes_ITEM", PANEL, "DPanel" )