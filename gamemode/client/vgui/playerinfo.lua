function DrawPlayerInfo( pl )
	if( not pl:Alive() ) then return; end
	local pos = pl:EyePos();
				
	pos.z = pos.z + 14;
	pos = pos:ToScreen();
	local nick=pl:Nick()
	if pl:GetNetworkedInt("AutoNick") then
		nick=pl:GetNetworkedString("NickName")
	end

		draw.DrawText( pl:Nick(), "TargetID", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 150 ), 1 );
		draw.DrawText( pl:Nick(), "TargetID", pos.x, pos.y, Color( 255, 255, 255, 255 ), 1 );

		draw.DrawText(pl:GetNWString( "Ntitle" ), "TargetID", pos.x, pos.y + 20, Color( 255, 255, 255, 200 ), 1 );
		
end

function DrawWarrantInfo( pl )

	if( not pl:Alive() ) then return; end

	local pos = pl:EyePos();
				
	pos.z = pos.z + 14;
	pos = pos:ToScreen();
				
		draw.DrawText( "Warrent for Arrest!", "TargetID", pos.x + 1, pos.y - 21, Color( 255, 0, 0, 255 ), 1 );		

end

function GM:HUDDrawTargetID()

end

function GM:HUDShouldDraw( name )

	if( name == "CHudHealth" or name == "CHudBattery" or name == "CHudSuitPower" ) then return false; end
	if( HelpToggled and name == "CHudChat" ) then return false; end
	
	return true;

end