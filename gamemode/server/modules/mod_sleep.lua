----------------------------------------------------
----------Sleep Mod
----------------------------------------------------
Sleep = {}
function Sleep.PlayerSpawn(pl)
 if (pl.sleep == true) then 
	return false
end
	pl.sleep = false
	pl.Knockedout = false

end
hook.Add("PlayerSpawn","Sleep.PlayerSpawn",Sleep.PlayerSpawn)

function Sleep.PlayerInitialSpawn(pl)
  	pl.sleep = false
	pl.ragdollindex = 10
	pl.Knockedout = false
	pl:SetNWBool("sleep", false)

end
hook.Add("PlayerInitialSpawn","Sleep.PlayerInitialSpawn",Sleep.PlayerInitialSpawn)

function Sleep.PlayerSpawnProp(pl)
  	if(pl.sleep == true)then
		return false;
	end
return;
end
hook.Add("PlayerSpawnProp","Sleep.PlayerSpawnProp",Sleep.PlayerSpawnProp)

function unknockout(pl)
	pl.sleep = false
	pl.Knockedout = false
	plunsleep(pl)
end


function plsleep(pl)

	if not( pl:Alive() ) then
		Notify( pl, 1, 4, "You cannot sleep while you are dead!" )
		return;
	end
	pl.curweps = {}
	local team = pl:Team()
	if not pl:GetTable().Arrested then
		for k, wep in pairs( pl:GetWeapons() ) do
			local class = wep:GetClass()
			if string.find(class, "_bb" ) then
				if( team == 2 ) then
					if class != "weapon_glock_bb" and class != "weapon_mp5_bb" then
						table.insert( pl.curweps, class)
					end	
				elseif( team == 9 ) then
					if class != "weapon_deagle_bb" and class != "weapon_pumpshotgun_cp" then
						table.insert( pl.curweps, class)
					end						
				else
					table.insert( pl.curweps, class)
				end
			end
		end
	end
	pl:GetTable().Health = pl:Health()
	pl:SetNWBool("sleep", true)
	pl:StripWeapons()
	local ragdoll = ents.Create("prop_ragdoll")
	ragdoll:SetPos(pl:GetPos())
	ragdoll:SetAngles(Angle(0,pl:GetAngles().Yaw,0))
	ragdoll:SetModel(pl:GetModel())
	ragdoll:Spawn()
	ragdoll:Activate()
	ragdoll:SetVelocity(pl:GetVelocity())
	ragdoll:GetTable().person = pl
	pl:Spectate(OBS_MODE_CHASE)
	pl:SpectateEntity(ragdoll)
	pl:ConCommand("pp_colormod 1")
	pl:ConCommand("pp_colormod_brightness -0.2")
	pl:ConCommand("pp_colormod_color 0")
	
	pl.sleep = true
	pl:Freeze( true )
	pl.ragdollindex = ragdoll:EntIndex( )
	if(pl.Knockedout == true)then
		timer.Simple(35, unknockout, pl)  
	end
end

function plunsleep(pl)
	
	local ragdoll = ents.GetByIndex(pl.ragdollindex)
		
	pl:UnSpectate()
	pl:Spawn()
	pl:SetNWBool("sleep", false)
	
	if (pl:GetTable().unarrestonsleepend == true)then
		Notify( self, 1, 4, "You have been unarrested!" )
		setspawnPos( pl )
		pl:GetTable().unarrestonsleepend = nil
	else
		if(ragdoll and ragdoll:IsValid())then
			pl:SetPos(ragdoll:GetPos())
		else
			setspawnPos( pl )
		end
	end
	
	if(ragdoll and ragdoll:IsValid())then
		ragdoll:Remove()
	end
	
	pl:ConCommand("pp_colormod 0")
	pl.sleep = false
	pl:Freeze( false )
	pl:SetHealth(pl:GetTable().Health)
	GAMEMODE:PlayerLoadout( pl );
	pl.Knockedout = false
	for _, wep in pairs( pl.curweps ) do
		pl:Give( wep )
	end
end

function TrySleep(pl, pos)
	if (pl.sleep == false)then
		if(pl:GetPos() == pos)then
			plsleep(pl)
		else
			Notify( pl, 1, 4, "You have moved since you began sleeping!")
		end
	end
end

function Sleep(pl)

	if (pl.Knockedout == true)then
		Notify( pl, 1, 4, "You cannot sleep while you are knocked out!")
		return "";
	end
	
	if pl:GetNWBool("gassed") then
		Notify( pl, 1, 4, "You cannot sleep while you are gassed!")
		return "";
	end
	
	if (pl:GetVehicle():IsValid() == true)then
		Notify( pl, 1, 4, "You cannot sleep while you are in a chair!")
		return "";
	end
	
	if(pl:Crouching( ) == true)then 
		Notify( pl, 1, 4, "You cannot sleep while you are crouching!")
		return "";
	end	

	if (pl.sleep == false)then
		Notify( pl, 1, 4, "Do not move for 5 seconds.")
		timer.Create(pl:Nick().."sleeping", 4, 1, TrySleep, pl, pl:GetPos())
		return "";
	end

	if (pl.sleep == true)then
		plunsleep(pl)
	end
	return "";
end
 
AddChatCommand( "/sleep", Sleep );