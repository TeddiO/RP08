local timeLeft = 10
local timeLeft2 = 10
local stormOn = false

VoteCopOn = false;
----------------------------------------------------
----------Warramts
----------------------------------------------------

function playerunWarrant( pl, args )

	if not( pl:Team() == 2 or pl:Team() == 3 or pl:Team() == 9 ) then
		Notify( pl, 1, 3, "You must be either the Mayor or Police." );
		return
	end
	
	if (#team.GetPlayers(3) > 0) then
		if (pl:Team() != 3) then
			pl:PrintMessage(3, "The Mayor is currently in charge of unwarranting.")
			return ""
		end
	elseif (#team.GetPlayers(9) > 0) then
		if (pl:Team() != 9) then
			pl:PrintMessage(3, "The Police Chief is currently in charge of unwarranting.")
			return ""
		end
	end

	--player.GetByID( id ) FAILS
	local v = v
	
	for k1, v1 in pairs(player.GetAll()) do  
	
		if(v1:UserID( ) == tonumber(args)) then 
		
			v = v1
		
		end
	
	end
	v=ASS_FindPlayerName(tostring(args))
	if not(v)then
		Notify( pl, 1, 3, "Unable to find a player with this Username" );
		return "";
	end
	
	if(v:Alive()) then
		v:SetNWBool("warrant", false)
		for a, b in pairs(player.GetAll()) do  
			if(b:Alive() and (b:IsAdmin() )) then
				b:PrintMessage( 3, v:Nick() .. " has been unwarranted by "..pl:Nick().."!" ) 
			end
		end
		Notify( pl, 1, 3, "Warrant has been removed." );
	end  
	
	return "";
	
end
AddChatCommand( "/playerunwarrant", playerunWarrant );

function playerWarrant( pl, args )

	if not( pl:Team() == 2 or pl:Team() == 3 or pl:Team() == 9 ) then
		Notify( pl, 1, 3, "You must be either the Mayor or Police." );
		return ""
	end
	
	if (#team.GetPlayers(3) > 0) then
		if (pl:Team() != 3) then
			Notify(pl, 1, 3, "The Mayor is currently in charge of warranting.")
			return ""
		end
	elseif (#team.GetPlayers(9) > 0) then
		if (pl:Team() != 9) then
			Notify(pl, 1, 3, "The Police Chief is currently in charge of warranting.")
			return ""
		end
	end
	
	local v = v
	
	for k1, v1 in pairs(player.GetAll()) do  
	
		if(v1:UserID( ) == tonumber(args)) then 
		
			v = v1
		
		end
	
	end	
	v=FindPlayer(args)
	if (not v or not v:IsValid())then
		Notify( pl, 1, 3, "Unable to find a player with this Username" );
		return ""
	end
	
	if(v:Alive()) then
		v:SetNWBool("warrant", true)
		for a, b in pairs(player.GetAll()) do  
			if(b:Alive()) then
				if(b:IsSubAdmin())then
					b:PrintMessage( 3, v:Nick() .. " has a warrant for their arrest (set by "..pl:Nick()..")!" ) 
					b:PrintMessage( 4, v:Nick() .. " has a warrant for their arrest (set by "..pl:Nick()..")!" ) 
				else
					b:PrintMessage( 4, v:Nick() .. " has a warrant for their arrest!" ) 
				end
			end
		end
		Notify( pl, 1, 3, "Warrant has been set." );
	end  
	
	return "";
end
AddChatCommand( "/playerwarrant", playerWarrant );