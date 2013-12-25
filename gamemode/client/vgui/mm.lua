 /*--------------------------------------------------------- 
	Name: 	Main Menu (General Tabs and layout)
---------------------------------------------------------*/ 
RP08.MenuOpen = false

local PANEL = {}

function PANEL:Init( )

	self:SetTitle("Main Menu");
	self:SetDeleteOnClose(false);
	
	self.button88 = vgui.Create("DButton", self)
		self.button88:SetText("Close")
		self.button88.DoClick = function(self)
		OpenMainMenu()
	end	
		
	self.TabControl = vgui.Create( "DPropertySheet", self )
	self.TabControl:AddSheet( "Inventory",  vgui.Create( "RP08.ManMenu_Inventory", self.TabControl ), "gui/silkicons/application_view_tile" )
	self.TabControl:AddSheet( "Classes",  vgui.Create( "RP08.ManMenu_Classes", self.TabControl ), "gui/silkicons/group" )
	self.TabControl:AddSheet( "Store",  vgui.Create( "RP08.ManMenu_Workshop", self.TabControl ), "gui/silkicons/wrench" )
end

function PANEL:PerformLayout( )
	self:SetVisible( RP08.MenuOpen )	
	self:SetSize( mmwidth, mmheight )
	self:SetPos( ScrW()/2 - self:GetWide()/2, ScrH()/2 - self:GetTall()/2 )
	self.button88:SetPos( self:GetWide() - self.button88:GetWide(),1 )
	self.TabControl:StretchToParent( 4, 24, 4, 4 )
	DFrame.PerformLayout( self )

end

vgui.Register( "RP08.MainMenuTabs", PANEL, "DFrame" )

-------------------------------
-----------Umsg Hook--------------------
-------------------------------

function OpenMainMenu()
	
	RP08.MenuOpen = not(RP08.MenuOpen)
	gui.EnableScreenClicker( RP08.MenuOpen )
	if(MainMenu)then
		MainMenu:SetVisible(RP08.MenuOpen)
	else
	
		MainMenu = vgui.Create( "RP08.MainMenuTabs" )
		MainMenu:MakePopup()
		
	end
end

usermessage.Hook( "RP08.OpenMainMenu", OpenMainMenu );
