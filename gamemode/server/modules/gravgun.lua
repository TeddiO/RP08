function GM:GravGunPunt(ply, ent)
	return false
end

local CanPickup = { -- Add any entities here that you want the gravgun to pickup
	"prop_physics",
	"spawned_item",
	"drug_lab",
	"drug",
	"letter",
	"money",
	"food",
}

function GM:GravGunOnPickedUp(ply, ent)
	if ent == NULL then return false end
	if !ent:IsValid() then return false end
	if !ValidEntity( ent ) then return false end
	if !table.HasValue( CanPickup, ent:GetClass() ) then return false end
	
	return false
end

function GM:GravGunPickupAllowed(ply, ent)
	if ent == NULL then return false end
	if !ent:IsValid() then return false end
	if !ValidEntity( ent ) then return false end
	if !table.HasValue( CanPickup, ent:GetClass() ) then return false end
	
	if ent:BoundingRadius() <= 50 then
		local trdata = {} 
		trdata.start = ply:GetShootPos()
		trdata.endpos = ply:GetShootPos() + (ply:GetAimVector() * 100)
		trdata.filter = ply 
		local trace = util.TraceLine( trdata )
		if trace.Hit then
			return true
		end
	end
	return false
end