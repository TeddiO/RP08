//This file is here to override any default sandbox stuff. Just here to keep it tidy.
//Never edit this file unless you really have to. 
//If you want to allow Admins to spawn them, change IsSuperAdmin to IsAdmin.

function GM:PlayerSpawnSWEP(pl)
	if !pl:IsSuperAdmin() then return false end
end

function GM:PlayerGiveSWEP(pl)
	if !pl:IsSuperAdmin() then return false end
end

function GM:PlayerSpawnSENT(pl)
	if !pl:IsSuperAdmin() then return false end
end

function GM:PlayerSpawnNPC(pl)
	if !pl:IsSuperAdmin() then return false end
end

function GM:PlayerSpawnRagdoll(pl)
	if !pl:IsSuperAdmin() then return false end
end

function GM:PlayerSpawnEffect(pl)
	if !pl:IsSuperAdmin() then return false end
end

//Prevents players from getting a free toolgun via leafblower
concommand.Add("gmod_toolmode leafblower",function() end)