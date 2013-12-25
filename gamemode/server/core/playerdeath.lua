function GM:DoPlayerDeath(ply, attacker, dmginfo)
	umsg.Start( "DrawNLRBar", ply ) umsg.End()
end

function GM:PlayerDeathSound()
	return true // disables the BEEP BEEP sound
end

function GM:CanPlayerSuicide( pl )
	Notify(pl, 4, 4, "If you are stuck use /sleep or ask an admin to move you if you are trapped.")
	return false;
end
/*---------------------------------------------------------
   Name: gamemode:PlayerDeath( )
   Desc: Called when a player dies.
---------------------------------------------------------*/
function GM:PlayerDeath( ply, Inflictor, Attacker )
	ply:StripWeapons()
	ply:StripAmmo()
	ply:CreateRagdoll()

	// Don't spawn for at least 2 seconds
	ply.NextSpawnTime = CurTime() + 2
	
	timer.Create( ply:UserID().."respawn", 30, 1, function() if not(ply:Alive())then ply:Spawn() end end )

	if ( Inflictor && Inflictor == Attacker && (Inflictor:IsPlayer() || Inflictor:IsNPC()) ) then
	
		Inflictor = Inflictor:GetActiveWeapon()
		if ( !Inflictor || Inflictor == NULL ) then Inflictor = Attacker end
	
	end

	if (Attacker == ply) then
		return 
	end
	ply:AddDeaths( 1 )
	if ( Attacker:IsPlayer() ) then
	
	print(Attacker:Nick() .. " has killed " .. ply:Nick() .. " using " .. Inflictor:GetClass())
	
		ply:SetNetworkedBool("warrant", false)
		ply:GetTable().Arrested = false;
		ply:GetTable().DeathPos = nil;
		if(ply:Team() == 3)then
			RP08.Teams.Make(1, ply)
		end
		Attacker:AddFrags( 1 )
		for k, v in pairs(player.GetAll()) do
			if (v:IsAdmin()) then
				umsg.Start( "Yellow", v ) 
					umsg.String( Attacker:Nick() .. " has killed " .. ply:Nick() .. " using " .. Inflictor:GetClass() )		
				umsg.End()
			end
		end
		return 
	end
	
end