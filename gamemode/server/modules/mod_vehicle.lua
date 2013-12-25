local AllowedModels = {"models/nova/chair_plastic01.mdl", "models/nova/jeep_seat.mdl", "models/nova/chair_office02.mdl", "models/nova/chair_office01.mdl", "models/nova/chair_wood01.mdl"}

local function VehicleRestrict(ply, model)

	if !ply:IsAdmin() then
		ply:PrintMessage(HUD_PRINTTALK, "Vehicles are for admins only!")
		return false
	end

	for k, v in pairs(AllowedModels)do 
		if (model == v) then
			return true 
		end
	end
	
	return false
end
hook.Add( "PlayerSpawnVehicle", "VehicleRestrict",  VehicleRestrict) 