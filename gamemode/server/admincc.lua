ValueCmds = { }


function AddValueCommand( cmd, cfgvar, global )
	ValueCmds[cmd] = { var = cfgvar, global = global };
	concommand.Add( cmd, ccValueCommand );
end

function ccValueCommand( pl, cmd, args )

	local valuecmd = ValueCmds[cmd];

	if( not valuecmd ) then return; end
	
	if( #args < 1 ) then
		if( valuecmd.global ) then
			if( pl:EntIndex() == 0 ) then
				Msg( cmd .. " = " .. GetGlobalInt( valuecmd.var ) );
			else
				pl:PrintMessage( 2, cmd .. " = " .. GetGlobalInt( valuecmd.var ) );
			end
		else
			if( pl:EntIndex() == 0 ) then
				Msg( cmd .. " = " .. RP08.CfgVars[valuecmd.var] );
			else
				pl:PrintMessage( 2, cmd .. " = " .. RP08.CfgVars[valuecmd.var] );
			end
		end
		return;
	end

	if( pl:EntIndex() ~= 0 and not Admins[pl:SteamID()] ) then 
		pl:PrintMessage( 2, "You're not an admin!" );
		return;
	end

	local amount = tonumber( args[1] );
	
	if( valuecmd.global ) then
		SetGlobalInt( valuecmd.var, amount );
	else
		RP08.CfgVars[valuecmd.var] = amount;
	end
	
	local nick = "";
	
	if( pl:EntIndex() == 0 ) then
		nick = "Console";
	else
		nick = pl:Nick();
	end
	
	NotifyAll( 0, 3, nick .. " set " .. cmd .. " to " .. amount );

end

function ccGiveItem( pl, cmd, args )

	if( not pl:IsSuperAdmin() ) then 
		pl:PrintMessage( 2, "You're not a super admin!" );
		return;
	end
	
	AddToLog(pl:Nick() .. "("..pl:SteamID()..") gave  "..args[2].." "..args[1])
	
		RP08.Item_Update(pl, args[1], tonumber(args[2]))

end
concommand.Add( "rp_giveitem", ccGiveItem );

function ccArrest( pl, cmd, args )

	if( pl:EntIndex() ~= 0 and not Admins[pl:SteamID()] ) then 
		pl:PrintMessage( 2, "You're not an admin!" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then

		if(target:IsSuperAdmin() and not pl:IsSuperAdmin())then
			pl:PrintMessage( 2, "You cannot arrest a higer class than you!" );
			return;
		end
		
		if(pl:IsSuperAdmin() and not target:IsSuperAdmin())then
			target:GetTable().ArrestBySuper = true
		end
		
		AddToLog(pl:Nick() .. "("..pl:SteamID()..") arrested ".. target:Nick() .. "("..target:SteamID()..")")
		
		target:Arrest();
		
		return;
	else
	
		if( pl:EntIndex() == 0 ) then
			Msg( "Unable to find player: " .. args[1] .."!" );
		else
			pl:PrintMessage( 2, "Unable to find player: " .. args[1] .."!" );
		end
		return;
	
	end

end
concommand.Add( "rp_arrest", ccArrest );


function ccUnarrest( pl, cmd, args )

	if( pl:EntIndex() ~= 0 and not Admins[pl:SteamID()] ) then 
		pl:PrintMessage( 2, "You're not an admin!" );
		return;
	end
	
	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		if(target:GetTable().ArrestBySuper == true)then
			pl:PrintMessage( 2, "This person has been arrested by a superadmin they must serve their time!" );
			return
		end
		
		AddToLog(pl:Nick() .. "("..pl:SteamID()..") unarrrested ".. target:Nick() .. "("..target:SteamID()..")")
		target:Unarrest();
		
	else
	
		if( pl:EntIndex() == 0 ) then
			Msg( "Unable to find player: " .. args[1] .."!" );
		else
			pl:PrintMessage( 2, "Unable to find player: " .. args[1] .."!" );
		end
		return;
	
	end

end
concommand.Add( "rp_unarrest", ccUnarrest );


function ccMayor( pl, cmd, args )

	if( pl:EntIndex() ~= 0 and not Admins[pl:SteamID()] ) then 
		pl:PrintMessage( 2, "You're not an admin!" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		target:SetTeam( 3 );
		target:UpdateTi( "Mayor" );
		target:KillSilent();
		local mnew = RP08.CfgVars["normalsal"] + 30
		target:SetNWInt("salary", mnew )
		
		local nick = "";
		
		if( pl:EntIndex() ~= 0 ) then
			nick = pl:Nick();
		else
			nick = "Console";
		end
		AddToLog(pl:Nick() .. "("..pl:SteamID()..") mayored ".. target:Nick() .. "("..target:SteamID()..")")
		
		target:PrintMessage( 2, nick .. " has made you Mayor!" );
		
	else
	
		if( pl:EntIndex() == 0 ) then
			Msg( "Unable to find player: " .. args[1] .."!" );
		else
			pl:PrintMessage( 2, "Unable to find player: " .. args[1] .."!" );
		end
		
		return;
	
	end

end
concommand.Add( "rp_mayor", ccMayor );


function ccCPChief( pl, cmd, args )

	if( pl:EntIndex() ~= 0 and not Admins[pl:SteamID()] ) then 
		pl:PrintMessage( 2, "You're not an admin!" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		target:SetTeam( 9 );
		target:UpdateTi( "Police Chief" );
		target:KillSilent();
		local mnew = RP08.CfgVars["normalsal"] + 20
		target:SetNWInt( "salary", mnew )
		
		if( pl:EntIndex() ~= 0 ) then
			nick = pl:Nick();
		else
			nick = "Console";
		end
		AddToLog(pl:Nick() .. "("..pl:SteamID()..") chiefed ".. target:Nick() .. "("..target:SteamID()..")")
		target:PrintMessage( 2, nick .. " has made you Police Chief!" );
		
	else
	
		if( pl:EntIndex() == 0 ) then
			Msg( "Unable to find player: " .. args[1] .."!" );
		else
			pl:PrintMessage( 2, "Unable to find player: " .. args[1] .."!" );
		end
		
		return;
	
	end

end
concommand.Add( "rp_cpchief", ccCPChief );


function ccCP( pl, cmd, args )

	if( pl:EntIndex() ~= 0 and not Admins[pl:SteamID()] ) then 
		pl:PrintMessage( 2, "You're not an admin!" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		target:SetTeam( 2 );
		target:UpdateTi( "Civil Protection" );
		target:KillSilent();
		local mnew = RP08.CfgVars["normalsal"] + 10
		target:SetNWInt( "salary", mnew );
		
		if( pl:EntIndex() ~= 0 ) then
			nick = pl:Nick();
		else
			nick = "Console";
		end
		AddToLog(pl:Nick() .. "("..pl:SteamID()..") cped ".. target:Nick() .. "("..target:SteamID()..")")
		target:PrintMessage( 2, nick .. " has made you Police!" );
		
	else
	
		if( pl:EntIndex() == 0 ) then
			Msg( "Unable to find player: " .. args[1] .."!" );
		else
			pl:PrintMessage( 2, "Unable to find player: " .. args[1] .."!" );
		end
		
		return;
	
	end

end
concommand.Add( "rp_cp", ccCP );



function ccCitizen( pl, cmd, args )

	if( pl:EntIndex() ~= 0 and not Admins[pl:SteamID()] ) then 
		pl:PrintMessage( 2, "You're not an admin!" );
		return;
	end

	local target = FindPlayer( args[1] );
	
	if( target ) then
	
		target:SetTeam( 1 );
		target:UpdateTi( "Citizen" );
		target:KillSilent();
		target:SetNWInt( "salary", RP08.CfgVars["normalsal"] )
		
		if( pl:EntIndex() ~= 0 ) then
			nick = pl:Nick();
		else
			nick = "Console";
		end
		AddToLog(pl:Nick() .. "("..pl:SteamID()..") citizned ".. target:Nick() .. "("..target:SteamID()..")")
		target:PrintMessage( 2, nick .. " has made you a Citizen!" );
		
	else
	
		if( pl:EntIndex() == 0 ) then
			Msg( "Unable to find player: " .. args[1] .."!" );
		else
			pl:PrintMessage( 2, "Unable to find player: " .. args[1] .."!" );
		end
		
		return;
	
	end

end
concommand.Add( "rp_citizen", ccCitizen );

