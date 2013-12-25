function Demote( pl, args ) 
	if pl:IsArrested() then
				pl:PrintMessage( HUD_PRINTTALK, "You are arrested!" ) 
	return ""
	end
	if not(pl:Team() == 3) then
		Notify( pl, 1, 3, "You must be the Mayor!" );
		return ""
	end
	
	local useridExists = false
    for k, v in pairs(player.GetAll()) do 
        if(v:Alive()) then 
            if( CurTime() - pl:GetTable().LastVote < 80 ) then
                Notify( pl, 1, 4, "Please wait " .. math.ceil( 80 - ( CurTime() - pl:GetTable().LastVote ) ) .. " second(s)!" );
                return "";
    
            end
            
            if(v:UserID( ) == tonumber(args)) then 
            useridExists = true
            
                if( v:Team() == 1 ) then 
                    Notify( pl, 1, 4,  v:Nick() .." is already a citizen!" );
                else
                    NotifyAll( 1, 4, pl:Nick() .. " has started a vote for demotion!");    
                    vote:Create( v:Nick() .. ":\n Demotion Nominee", v:EntIndex() .. "votecop", v, 12, FinishDemote );     
                    pl:GetTable().LastVote = CurTime();
                    VoteCopOn = true;
                    return "";
                    end 
                
            end  
        end 
    end 
    
    if(useridExists == false) then
        Notify( pl, 1, 3, "Unable to find a player with this User ID!" );
    else 
        if( v:Team() == 1 ) then 
        else
        Notify( pl, 1, 3, "Demotion vote has been started!" );
    end
end
    return "";
end
AddChatCommand( "/demote", Demote );

function FinishDemote( choice, v)

    VoteCopOn = false;
	
	if not(v:GetTable().demotions)then
		v:GetTable().demotions = {}
	end

    if( choice == 1 ) then
		v:GetTable().demotions[v:Team()] = CurTime() + 1200 --1hours
        v:SetTeam( 1 );
        v:UpdateTi( "Citizen" );
		v:SetNWInt("salary", RP08.CfgVars["normalpay"])
		if ( v:GetTable().Arrested ) then
			v:PrintMessage( HUD_PRINTTALK, "You are arrested!" ) 
		else
			v:KillSilent();
		end
        
        NotifyAll( 1, 4, v:Nick() .. " has been demoted!" );
            
    else
    
        NotifyAll( 1, 4, v:Nick() .. " has not been demoted!" );
    
    end
end