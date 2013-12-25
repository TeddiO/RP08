
local PlayerRowsTbl = {}
local UpdateScoreboardz = false
surface.CreateFont( "DefaultBold", 18, 700, false, false, "PlayerRowFont" )



local PANEL = {}
function PANEL:Init()
	self:SetSize( self:GetParent():GetWide(), 74 )
	
	self.SpawnIcon = vgui.Create( "SpawnIcon", self )
	self.SpawnIcon.DoClick = function() return end
	
	
	self.r = 0
	self.g = 0
	self.b = 0
	self.a = 0
end

function PANEL:SetPly( obj )
	if !obj:IsValid() or !ValidEntity( obj ) or obj == NULL then
		UpdateScoreboard()
		return
	end
	self.Ply = obj
end

function PANEL:OnCursorExited()
	self.r = 0
	self.g = 0
	self.b = 0
	self.a = 0
end

function PANEL:OnCursorEntered()
	self.r = 50
	self.g = 50
	self.b = 50
	self.a = 100
end

function PANEL:Paint()
	if !self.Ply:IsValid() or !ValidEntity( self.Ply ) or self.Ply == NULL then
		UpdateScoreboard()
		return
	end
	
	local tc = team.GetColor( self.Ply:Team() )
	
	draw.RoundedBox( 3, 0, 0, self:GetParent():GetWide(), 74, Color( math.Clamp( tc.r + self.r, 0, 255 ), math.Clamp( tc.g + self.g, 0, 255 ), math.Clamp( tc.b + self.b, 0, 255 ), math.Clamp( 125 + self.a, 0, 255 ) ) )
	
	
	if self.Ply == LocalPlayer() then
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawOutlinedRect( 0, 0, self:GetParent():GetWide(), 74 )
		surface.DrawOutlinedRect( 1, 1, self:GetParent():GetWide() - 2, 72 )
		surface.DrawOutlinedRect( 2, 2, self:GetParent():GetWide() - 4, 70 )
	else
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawOutlinedRect( 0, 0, self:GetParent():GetWide(), 74 )
	
end
		draw.SimpleTextOutlined( team.GetName( self.Ply:Team() ), "PlayerRowFont", self:GetParent():GetWide() * 0.5, 10, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0,0,0,255) )
	if self.Ply:IsAdmin() then
	draw.SimpleTextOutlined( "(Admin)", "PlayerRowFont", 74, 27, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0,0,0,255) )
	end
	
	draw.SimpleTextOutlined( self.Ply:Nick(), "PlayerRowFont", 79, 10, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0,0,0,255) )
	draw.SimpleTextOutlined( self.Ply:Frags(), "PlayerRowFont", self:GetParent():GetWide() - 170, 10, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0,0,0,255) )
	draw.SimpleTextOutlined( self.Ply:Deaths(), "PlayerRowFont", self:GetParent():GetWide() - 105, 10, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0,0,0,255) )
	draw.SimpleTextOutlined( self.Ply:Ping(), "PlayerRowFont", self:GetParent():GetWide() - 45, 10, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0,0,0,255) )
end

function PANEL:PerformLayout()
	if !self.Ply:IsValid() or !ValidEntity( self.Ply ) or self.Ply == NULL then
		UpdateScoreboard()
		return
	end
	
	self.SpawnIcon:SetPos( 5, 5 )
	self.SpawnIcon:SetModel( self.Ply:GetModel() )
	self.SpawnIcon:SetToolTip(nil)
	

end

function PANEL:Update()
	self.SpawnIcon:SetModel( self.Ply:GetModel() )
end
vgui.Register( "PlayerRow", PANEL, "DPanel" )

function RP08.BuildScoreboard()
	
	MainBoard = vgui.Create( "DPanel" )
	MainBoard:SetSize( ScrW() * 0.6, ScrH() * 0.75 )
	MainBoard:Center()
	MainBoard.Paint = function()
		-- Main background
		surface.SetDrawColor( 50, 200, 50, 200 )
		surface.DrawOutlinedRect( 0, 0, MainBoard:GetWide(), MainBoard:GetTall() )
		surface.DrawOutlinedRect( 1, 1, MainBoard:GetWide() - 2, MainBoard:GetTall() - 2 )
		surface.SetDrawColor( 50, 50, 50, 150 )
		surface.DrawRect( 2, 2, MainBoard:GetWide() - 3, MainBoard:GetTall() - 3 )
		surface.SetTexture( surface.GetTextureID("BB/BB_Banner") )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( 10, 10, MainBoard:GetWide() - 20, 128 )
		
		
		-- Name/team/kills/ping background
		surface.SetDrawColor( 150, 150, 150, 200 )
		surface.DrawRect( 10, 148, MainBoard:GetWide() - 20, 15 )
		surface.SetDrawColor( 50, 200, 50, 200 )
		surface.DrawOutlinedRect( 10, 148, MainBoard:GetWide() - 20, 15 )
		surface.SetDrawColor( 200, 200, 200, 200 )
		surface.SetTexture( surface.GetTextureID( "gui/center_gradient" ) )
		surface.DrawTexturedRect( 10, 148, MainBoard:GetWide() - 20, 15, 0 )
		
		-- Name/team/kills/ping words
		draw.DrawText( "Name", "DefaultBold", 89, 149, Color(0,0,0,255), TEXT_ALIGN_LEFT )
		draw.DrawText( "Class/Group", "DefaultBold", MainBoard:GetWide() * 0.5, 149, Color(0,0,0,255), TEXT_ALIGN_CENTER )
		draw.DrawText( "Kills", "DefaultBold", MainBoard:GetWide() - 185, 149, Color(0,0,0,255), TEXT_ALIGN_CENTER )
		draw.DrawText( "Deaths", "DefaultBold", MainBoard:GetWide() - 120, 149, Color(0,0,0,255), TEXT_ALIGN_CENTER )
		draw.DrawText( "Ping", "DefaultBold", MainBoard:GetWide() - 60, 149, Color(0,0,0,255), TEXT_ALIGN_CENTER )
	end
	
	PlayerRows = vgui.Create( "DPanelList", MainBoard )
	PlayerRows:SetPos( 10, 168 )
	PlayerRows:SetSize( MainBoard:GetWide() - 20, MainBoard:GetTall() - 178 )
	PlayerRows:SetSpacing( 0 )
	PlayerRows:EnableHorizontal( false )
	PlayerRows:EnableVerticalScrollbar( true )
	PlayerRows.Paint = function()
		surface.SetDrawColor( 50, 200, 50, 200 )
		surface.DrawOutlinedRect( 0, 0, PlayerRows:GetWide(), PlayerRows:GetTall() )
	end
	
	for k, ply in pairs( player.GetAll() ) do
		local PlyRow = vgui.Create( "PlayerRow" )
		PlyRow:SetPly( ply )
		PlayerRows:AddItem( PlyRow )
		PlayerRowsTbl[ ply ] = PlyRow
	end
	
	MainBoard:SetVisible( false )
	gui.EnableScreenClicker( false )
	UpdateScoreboardz = true

end
timer.Simple( 5, RP08.BuildScoreboard )

function UpdateScoreboard()
	if UpdateScoreboardz then
		for pl, row in pairs( PlayerRowsTbl ) do
			if !pl:IsValid() or !ValidEntity( pl ) or pl == NULL then
				PlayerRows:RemoveItem( row )
				row:Remove()
				PlayerRowsTbl[ pl ] = nil
			end
		end
		
		for k, ply in pairs( player.GetAll() ) do
			if !PlayerRowsTbl[ ply ] and ply:IsValid() then
				local PlyRow = vgui.Create( "PlayerRow" )
				PlyRow:SetPly( ply )
				PlayerRows:AddItem( PlyRow )
				PlayerRowsTbl[ ply ] = PlyRow
			end
		end
		
		-- table.sort( AllPlayers, function(a, b) return a:Team() > b:Team() end )
		MainBoard:InvalidateLayout()
		PlayerRows:InvalidateLayout()
	end
end
timer.Create( "UpdateBoardz", 1, 0, UpdateScoreboard )

function GM:CreateScoreboard()
	return false
end

function GM:ScoreboardShow()
	if !UpdateScoreboardz then return end
	if BannedMenu then return end
	MainBoard:SetVisible( true )
	gui.EnableScreenClicker( true )

end

function GM:ScoreboardHide()
	if !UpdateScoreboardz then return end
	MainBoard:SetVisible( false )
	gui.EnableScreenClicker( false )
end




