
----------------------------------------------------
----------Team/Class Selection
----------------------------------------------------
RP08.Teams.Make = {}
function bb_changeclass( pl, cmd, args )

		if( args == "" ) then return ""; end

--IF NOT ARRESTED
	if pl:IsArrested() then
		pl:PrintMessage( HUD_PRINTTALK, "You are arrested!" ) 
		return "";
	end
	
	if ( pl.sleep == true ) then
		pl:PrintMessage( HUD_PRINTTALK, "You are sleeping or have been knocked out!" ) 
		return "";
	end
		--Delay 

	if( CurTime() - pl:GetTable().LastChangeClass < 60 ) then
	
		pl:PrintMessage( HUD_PRINTTALK, "Please wait " .. math.ceil( 60 - ( CurTime() - pl:GetTable().LastChangeClass ) ) .. " second(s)!" );
		return "";	
	end	
		
--GET INFO FROM CONCOMMAND	
	local ident = tonumber(args[1])
--IS IDENT VALID

		--CODE

--ARE WE NOT ALLREADY THAT CLASS
	if( pl:Team() == tonumber(ident) ) then
		pl:PrintMessage( HUD_PRINTTALK, "You shouldn't see this message!" );
		return "";	
	end
	
--check if we were demoted recently

	if (pl:GetTable().demotions and pl:GetTable().demotions[pl:Team()])then
		if(pl:GetTable().demotions[pl:Team()] > CurTime())then
			pl:PrintMessage(4, "You have been too recently demoted from this class!")
			return "";
		end
	end	
	
--Check if we are in black or white lists

	if(RP08.BLists)then
		print("Checking if user is blacklisted")
		if(RP08.BLists.lists[string.lower(ident .. pl:SteamID())] == "black")then
			pl:PrintMessage( 3, "You have been blacklisted for this class!" );
			return "";	
		end
	end
--IS THE CLASS FULL	
	if(team.NumPlayers(tonumber(ident)) >= RP08.Teams.list[ident][5])then
		pl:PrintMessage( HUD_PRINTTALK, "You shouldn't see this message!" );
		return "";	
	end
--Special Features	


	if(ident == 10)then
		pl:PrintMessage( HUD_PRINTTALK, "Checking Database...." );
		return "";
	end
	
	if(ident == 9)then
		if not(pl:Team() == 2)then --if not team 2
			pl:PrintMessage( HUD_PRINTTALK, "You must be a " .. RP08.Teams.list[2][1] .. " first!" );
			return "";
		end
	end
	
--IS IT A VOTE

	if(RP08.Teams.list[ident][6] == true)then		
		DoVote( pl, ident )	
		return
	else
		RP08.Teams.Make(ident, pl)
		
		pl:GetTable().LastChangeClass = CurTime();
		
		return
	end
end

concommand.Add( "bb_changeclass", bb_changeclass);


function RP08.Teams.Make(ident, pl)

	if(ident == 1)then
	--Citizen--
		pl:SetTeam( ident );
		pl:UpdateTi( "Citizen" );
		pl:KillSilent();
				return
	elseif(ident == 2)then
	--Civil Protection--
		pl:GetTable().RadioChannel = 2
		pl:SetTeam( ident );
		pl:UpdateTi( "Civil Protection" );
		NotifyAll( 1, 4, pl:Nick() .. " has been made Police!" );
		pl:KillSilent();
		local mnew = RP08.CfgVars["normalsal"] + 15
		pl:SetNWInt( "salary", mnew )
		return
	elseif(ident == 3)then
	--Mayor--
	pl:GetTable().RadioChannel = 2
		pl:SetTeam( ident );
		pl:UpdateTi( "Mayor" );
		pl:KillSilent();
		NotifyAll( 1, 4, pl:Nick() .. " has been made Mayor!" );
		local mnew = RP08.CfgVars["normalsal"] + 40
		pl:SetNWInt( "salary", mnew )
		return
	elseif(ident == 4)then
	--Gangster--
		pl:SetTeam( ident );
		pl:UpdateTi( "Gangster" );
		pl:KillSilent();
			local mnew = RP08.CfgVars["normalsal"] - 5
		pl:SetNWInt( "salary", mnew )
		NotifyAll( 1, 4, pl:Nick() .. " has been made a Gangster!" );
		return
	elseif(ident == 5)then
	--Mob Boss--
		pl:SetTeam( ident );
		pl:UpdateTi( "Mob Boss" );
		pl:KillSilent();
		local mnew = RP08.CfgVars["normalsal"] - 10
		pl:SetNWInt( "salary", mnew )
		NotifyAll( 1, 4, pl:Nick() .. " has been made the Mob Boss!" );
		elseif(ident == 6)then
	--Weapon Dealer--
		pl:SetTeam( ident );
			pl:UpdateTi( "Weapon Dealer" );
			pl:KillSilent();
			pl:SetNWInt( "salary", 5 )
			NotifyAll( 1, 4, pl:Nick() .. " has been made a Weapon Dealer!" );	
	elseif(ident == 7)then
	--Medic--
		pl:SetTeam( ident );
			pl:UpdateTi( "Medic" );
			pl:KillSilent();
			local mnew = RP08.CfgVars["normalsal"] + 10
			pl:SetNWInt( "salary", mnew )
			NotifyAll( 1, 4, pl:Nick() .. " has been made a Medic!" );	
	elseif(ident == 8)then
	--Cook--
		pl:SetTeam( ident );
			pl:UpdateTi( "Cook" );
			
			pl:KillSilent();
			local mnew = RP08.CfgVars["normalsal"] + 15
			pl:SetNWInt( "salary", mnew )
			NotifyAll( 1, 4, pl:Nick() .. " has been made a Cook!" );	
	elseif(ident == 9)then
	--Pd Chief--
	pl:GetTable().RadioChannel = 2
		pl:SetTeam( ident );
		pl:UpdateTi( "Police Chief" );
		
		pl:KillSilent();
		local mnew = RP08.CfgVars["normalsal"] + 20
		pl:SetNWInt( "salary", mnew )
		NotifyAll( 1, 4, pl:Nick() .. " has been made Police Chief!" );	
	else
		pl:PrintMessage( HUD_PRINTTALK, "Invalid Class!" );
	end
	
end

function DoVote( pl, cls )
	local class = tonumber(cls)

	if( VoteCopOn ) then
		Notify( pl, 1, 4,  "There is already a vote!" );
		return "";
	end

	if( CurTime() - pl:GetTable().LastVote < 60 ) then
	
		pl:PrintMessage( HUD_PRINTTALK, "Please wait " .. math.ceil( 60 - ( CurTime() - pl:GetTable().LastVote ) ) .. " second(s)!" );
		return "";
	
	end
	
	vote:Create( pl:Nick() .. ":\nwants to be "..RP08.Teams.list[class][1], pl:EntIndex() .. class, pl, 12, RP08.FinishVote);
	pl:GetTable().LastVote = CurTime();
	pl:GetTable().VoteTo = class
	VoteCopOn = true;
	
	return "";

end

function RP08.FinishVote( result, pl )
	
	VoteCopOn = false;

	local voteto = pl:GetTable().VoteTo

	if(result == 1)then
		RP08.Teams.Make(voteto, pl)
		
		pl:GetTable().LastChangeClass = CurTime();
	else
        NotifyAll( 1, 4, pl:Nick() .. " did not get enough votes!" );
	end
end