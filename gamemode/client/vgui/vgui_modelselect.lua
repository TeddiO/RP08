/*---------------------------------------------------------
  Player Model Menu
---------------------------------------------------------*/

local PANEL = {}

local CharMenu = false

function PANEL:Init()

	if CharMenu then self:Close() return end
	CharMenu = true
	
	self:SetWidth(360)
	self:SetHeight(370)
	self:Center()
	self:SetTitle("Choose your character")
	self:ShowCloseButton( false )
	self:MakePopup()
	
	self.GenderList = vgui.Create("DPanelList",self)
	self.GenderList:SetPos(10,30)
	self.GenderList:SetSize(self:GetWide() - 20, self:GetTall() - 20 )
	self.GenderList:SetSpacing( 3 )
	self.GenderList:EnableHorizontal( false )
	self.GenderList:EnableVerticalScrollbar( false )
	self.GenderList.Paint = function() end
	
	
	self.Instructions = vgui.Create( "DLabel" )
	self.Instructions:SetText( "Choose a gender then click on a character." )
	self.GenderList:AddItem( self.Instructions )
	
		self.MaleCategory = vgui.Create("DCollapsibleCategory")
		self.MaleCategory:SetPos( 40, 40)
		self.MaleCategory:SetSize( 370, 125 )
		self.MaleCategory:SetExpanded( true )
		self.MaleCategory:SetLabel("Male Player Models")
				
			self.MaleList = vgui.Create("DPanelList")
			self.MaleList:SetAutoSize( true )
			self.MaleList:SetSpacing( 1 )
			self.MaleList:EnableHorizontal( true )
		
		self.MaleCategory:SetContents(self.MaleList)

			for _, model in pairs(CivilianModels) do
				if model[2] == false then
					local icon = vgui.Create( "SpawnIcon" )
					icon:SetModel(CivilianModels[_][1])
					icon:SetToolTip(nil)
					icon.DoClick = function()
						RunConsoleCommand("rp08ModelSelect",CivilianModels[_][1])
						self:Close()
					end
					self.MaleList:AddItem(icon)
				end
			end
		
	self.GenderList:AddItem(self.MaleCategory)
				
		self.FemaleCategory = vgui.Create("DCollapsibleCategory")
		self.FemaleCategory:SetPos( 10, 170)
		self.FemaleCategory:SetSize( 370, 125 )
		self.FemaleCategory:SetExpanded( true )
		self.FemaleCategory:SetLabel("Female Player Models")

			self.FemaleList = vgui.Create("DPanelList")
			self.FemaleList:SetAutoSize( true )
			self.FemaleList:SetSpacing( 1 )
			self.FemaleList:EnableHorizontal( true )
		
		self.FemaleCategory:SetContents( self.FemaleList )
		

			for _, model in pairs(CivilianModels) do
				if model[2] == true then
					local icon = vgui.Create( "SpawnIcon" )
					icon:SetModel(CivilianModels[_][1])
					icon:SetToolTip(nil)
					icon.DoClick = function()
						RunConsoleCommand("rp08ModelSelect",CivilianModels[_][1])
						self:Close()
					end
					self.FemaleList:AddItem(icon)
				end
			end
		
	self.GenderList:AddItem(self.FemaleCategory)
	
	
end
vgui.Register("RP08ModelSelection",PANEL,"DFrame")
usermessage.Hook("SelectModel", function() vgui.Create("RP08ModelSelection") end)


