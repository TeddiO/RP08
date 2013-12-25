function GM:HUDPaint()

	self.BaseClass:HUDPaint();

	local colour = 70;

	if(LocalPlayer():Team() == 2 or LocalPlayer():Team() == 3 or LocalPlayer():Team() == 9) then
			for k, v in pairs( player.GetAll() ) do
				if(v:GetNWBool("warrant") == true) then
					DrawWarrantInfo( v )
				end	
			end
		end
		local plyForAdminTag=ents.FindInSphere(LocalPlayer():GetPos(),300)
		for k,pl in pairs(plyForAdminTag) do
			if (pl:GetMoveType()==MOVETYPE_NOCLIP and pl:IsAdmin()) then
				//draw tag
				draw.DrawText("ADMINING","TargetID",pl:GetPos():ToScreen().x,pl:GetPos():ToScreen().y,Color(255,0,0),TEXT_ALIGN_CENTER)
			end
			
		end
		local tr = LocalPlayer():GetEyeTrace();
		if( tr.Entity:IsValid() ) then
			distance = tr.Entity:GetPos():Distance( LocalPlayer():GetPos() )
			if(distance < 400)then
				if( tr.Entity:IsPlayer() ) then
						DrawPlayerInfo( tr.Entity );
				elseif( tr.Entity:GetClass() == "spawned_item")then
					RP08.DrawItemInfo(tr)
				elseif( tr.Entity:IsDoor() ) then
					DrawOwnableInfo(tr.Entity)
				end
			end
		end
		
		if( LetterAlpha > -1 ) then
	
			if( LetterY > ScrH() * .25 ) then
				LetterY = math.Clamp( LetterY - 300 * FrameTime(), ScrH() * .25, ScrH() / 2 );
			end
		
			if( LetterAlpha < 255 ) then
				LetterAlpha = math.Clamp( LetterAlpha + 400 * FrameTime(), 0, 255 );
			end
		
			local font = "";
		
			if( LetterType == 1 ) then
				font = "AckBarWriting";
			else
				font = "Default";
			end
		
			draw.RoundedBox( 2, ScrW() * .2, LetterY, ScrW() * .8 - ( ScrW() * .2 ), ScrH(), Color( 255, 255, 255, math.Clamp( LetterAlpha, 0, 200 ) ) );
			draw.DrawText( LetterMsg, font, ScrW() * .25 + 20, LetterY + 80, Color( 0, 0, 0, LetterAlpha ), 0 );
			if(LetterOwner:IsPlayer())then
				draw.DrawText( LetterOwner:Nick(), font, ScrW() * .25 + 20, ScrH() -  100, team.GetColor(LetterOwner:Team()), 0 );
				if(LetterOwner == LocalPlayer())then
					draw.DrawText( "/write or /type on the letter to change it", font, ScrW() * .25 + 20, ScrH() -  50, Color(0,0,0,255), 0 );
				end
			end
		end
		
	if( StunStickFlashAlpha > -1 ) then
	
		surface.SetDrawColor( 255, 255, 255, StunStickFlashAlpha );
		surface.DrawRect( 0, 0, ScrW(), ScrH() );
	
		StunStickFlashAlpha = math.Clamp( StunStickFlashAlpha + 1500 * FrameTime(), 0, 255 );
	
	end


	draw.DrawText( "bbservers.co.uk", "TargetID", ScrW() - 70, ScrH() - 30, Color( 255, 255, 255, 255 ), 1 );
	
end


/*---------------------------------------
	Name: HUD
	Desc: Displays players HP, money etc.
---------------------------------------*/

local PANEL = {}

function PANEL:Init()
	local MoneyFont = surface.CreateFont ("arial bold", 20, 400, true, false, "Moneyfont") 
	local TitleFont = surface.CreateFont ("arial bold", 16, 400, true, false, "Title") 
	


    self:SetPos(ScrW() / 19 - 40, ScrH() / 1.2 - 40)
    self:SetSize(215 ,135)
		
		moneylbl = vgui.Create("DLabel",self)
		moneylbl:SetFont("Moneyfont")
		moneylbl:SetPos(30, 5)
		
		titlelbl = vgui.Create("DLabel",self)
		titlelbl:SetFont("Title")
		titlelbl:SetPos(30, 108)
	
end

function PANEL:Paint()

	local col = Color(0,0,0,240)
    local bordcol = Color(0,0,0,180)
	
	BT = 19
		
    surface.SetDrawColor(col.r,col.g,col.b,math.Clamp(col.a - 60,1,255))
    surface.DrawRect(0,0,self:GetWide(),self:GetTall())
    surface.SetDrawColor(bordcol.r,bordcol.g,bordcol.b,math.Clamp(bordcol.a - 60,1,255))
    surface.DrawOutlinedRect(0,0,self:GetWide(),self:GetTall())
    //return true
	
/*	local mullah = surface.GetTextureID("gui/silkicons/money")
	local heart = surface.GetTextureID("gui/silkicons/heart")
	local cup= surface.GetTextureID("gui/silkicons/cup")
	local lightning = surface.GetTextureID("gui/silkicons/lightning")
	local status = surface.GetTextureID("gui/silkicons/comment_add")*/

	/*surface.SetTexture(mullah)
	surface.SetDrawColor(255,255,255,255)
	surface.DrawTexturedRect(5,4,18,15)
	
	surface.SetTexture(heart)
	surface.SetDrawColor(255,255,255,255)
	surface.DrawTexturedRect(5,29,18,15)
	
	surface.SetTexture(cup)
	surface.SetDrawColor(255,255,255,255)
	surface.DrawTexturedRect(6,54,15,15)
	
	surface.SetTexture(lightning)
	surface.SetDrawColor(255,255,255,255)
	surface.DrawTexturedRect(6,80,15,15)
		
	surface.SetTexture(status)
	surface.SetDrawColor(255,255,255,255)
	surface.DrawTexturedRect(5,108,15,15)*/
	
		local hp = LocalPlayer():Health()
		draw.RoundedBox(4, 29, 30, 180 , BT+3, Color(0, 0, 0, 100))
		surface.SetDrawColor( 185, 18, 42, 255 )
		surface.DrawRect(29,30, math.Clamp( 180 * (hp / 100) , 0, 180), BT/2)
		surface.SetDrawColor( 225, 71, 71, 100 )
		surface.DrawRect(29,29, math.Clamp( 180 * (hp / 100) , 0, 180), BT )
		
		//Hunger
		plyhunge = LocalPlayer():GetNetworkedFloat("bb_Hunger")
		draw.RoundedBox(4, 29, 55, 180 , BT+3, Color(0, 0, 0, 100))
		surface.SetDrawColor( 117, 201, 80, 255 )
		surface.DrawRect(29,55, math.Clamp( 180 * (plyhunge / 100) , 0, 180), BT/2 )
		surface.SetDrawColor( 117, 201, 80, 100 )
		surface.DrawRect(29,54, math.Clamp( 180 * (plyhunge / 100) , 0, 180), BT )

		if plysprint==nil then
		plysprint=30 end
		draw.RoundedBox(4, 29, 80, 180 , BT+3, Color(0, 0, 0, 100))
		surface.SetDrawColor( 255,215,0, 255 )
		surface.DrawRect(29,80, math.Clamp( 180 * (plysprint / 30) , 0, 180), BT/2) 
		surface.SetDrawColor( 255,215,0, 100 )
		surface.DrawRect(29,79, math.Clamp( 180 * (plysprint / 30) , 0, 180), BT )

		
		plymoney = LocalPlayer():GetNWInt( "money" )
		plysalar = LocalPlayer():GetNWInt( "salary" )
		plytitle = LocalPlayer():GetNWString( "Ntitle" )
		moneylbl:SetText(plymoney.."T")
		moneylbl:SizeToContents()
		titlelbl:SetText("Title: " ..plytitle)
		titlelbl:SizeToContents()
end

vgui.Register( "HUD", PANEL, "DPanel" )