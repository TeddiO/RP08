

function GM:PlayerInitialSpawn( ply )
	ply:SetTeam(TEAM_CITIZEN)
end

function GM:PlayerSpawn( ply )
	if !ply:HasLoaded() then
		ply:Spectate(OBS_MODE_ROAMING)
	return end


	ply:SetModel("models/player/ct_gsg9.mdl")
	ply:SetMoveType(MOVETYPE_WALK )
	print("Running!")
//	hook.Call( "PlayerSetModel", GAMEMODE, ply )
	hook.Call( "PlayerLoadout", GAMEMODE, ply )
	ply:StopGassing()
	
	if ply:IsArrested() then
		ply:Arrest()
		ply:PrintMessage( HUD_PRINTTALK, "You are arrested!" ) 
		return
	end
end

function GM:PlayerCanPickupWeapon( ply, class )
	if ply:IsArrested() then return false end
	return true
end


/*---------------------------------------------------------
   Name: gamemode:SetPlayerSpeed( )
   Desc: Sets the player's run/walk speed
---------------------------------------------------------*/

local LoadOuts = {
[TEAM_POLICE]={"weapon_glock_bb_cp","arrest_stick","unarrest_stick","weapon_mp5_bb_cp","stunstick","door_ram","weapon_physgun"},
[TEAM_MAYOR]={"mayor_door_ram"},
[TEAM_MOBBOSS]={"unarrest_stick","lockpick"},
[TEAM_MEDIC]={"med_kit"},
[TEAM_POLCHIEF]={"weapon_deagle_bb_cp","arrest_stick","unarrest_stick","weapon_shotgun_cp","stunstick","door_ram","weapon_physgun"},
}
function GM:PlayerLoadout( ply )
	if ply:IsArrested() then return false end
	
	if ply:IsAdmin() then
		ply:Give( "gmod_tool" );
		ply:Give( "weapon_physgun" );
	end
				
	local team = ply:Team()
	if table.HasValue(LoadOuts,team) then
		for _, item in pairs(LoadOuts[team]) do
			ply:Give(item)
		end
	end
	
	ply:Give( "keys" );
	ply:Give( "weapon_physcannon" );
	ply:Give( "bb_hands" );
	ply:Give( "gmod_camera" );
	ply:SelectWeapon( "bb_hands" );

end



function GM:PlayerDisconnected( ply )
	timer.Destroy( ply:SteamID() .. "jobtimer" );
	vote.DestroyVotesWithEnt( ply );
end


function GM:ShowSpare1( ply )
	umsg.Start( "ToggleClicker", ply ); umsg.End();
end


function GM:PlayerUse( ply, ent )

	if ply:IsArrested() then
		ply:ChatPrint(ply:Nick() .. " tries opening the door, but finds his hands tied down")
		ply.ThisThink=CurTime()+ 2
		return false 
	end
	
	if( ent:IsValid() ) then
		ply.ThisThink=CurTime()+ 0.5
		if (ent:GetTable().extrainfo == 1)then
				if (string.lower(ent:GetNWString("title")) == "nexus") then
				print("not auth")
				if not (ply:Team()==2 or ply:Team()==3 or ply:Team()==9) then
					ply:ChatPrint("Nexus Security: Not Authorized")
					ent:Fire("lock")
					return false
				else
					ply:ChatPrint("Nexus Security: Authorized")
					ent:Fire("unlock")
					return true
				end
			end
		elseif( ent:GetTable().MoneyBag ) then	
			ply:PrintMessage(4, "You found T" .. ent:GetTable().Amount .. "!" );
			ply:AddMoney( ent:GetTable().Amount );
			ent:Remove();
			
			return false
		end	
		
	else
			umsg.Start( "KillLetter", ply ); umsg.End()
	end
	
	return true --well let them do what they where doing
end 

function GM:PhysgunPickup( ply, ent )
	local class = ent:GetClass();
	
	if( (ply:Team() == 2 or ply:Team() == 9) and class == "prop_ragdoll") then
			return true
	end
	
	if !ply:IsAdmin() then
		return false
	end

	if( ent:IsPlayer() or ent:IsDoor() ) then return false; end

	if( class ~= "func_physbox" and class ~= "prop_physics" and class ~= "prop_physics_multiplayer" and
		class ~= "prop_vehicle_prisoner_pod" ~= "prop_ragdoll" ) then
		return false;
	end
	return true;
end

local function SetPlayerSpeeds( ply, move )
	if !ply:Alive() or !ply:IsValid() then return end
	
	ply:SetWalkSpeed(RP08.CfgVars["wlkspd"])
      
	if ply:Crouching() then
   		ply:SetWalkSpeed( RP08.CfgVars["crhspd"] )
		ply:SetRunSpeed( RP08.CfgVars["crhspd"] )
     	return
    end
	   
	if ply:IsArrested() then
		ply:SetWalkSpeed( RP08.CfgVars["arrspd"] )
		ply:SetRunSpeed( RP08.CfgVars["arrspd"] + 10 )
		return
	end
	         		 
	if ply:IsPolice() then 
		ply:SetRunSpeed( RP08.CfgVars["runspd"] + 20 )
	else
		ply:SetRunSpeed( RP08.CfgVars["runspd"] )
	end

	
end
hook.Add( "SetupMove", "PlayerSpeeds", SetPlayerSpeeds )

local pm = FindMetaTable( "Player" )

function pm:HasLoaded()
	return self.hasloaded
end
