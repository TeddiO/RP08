/*

	We control all things here related to the toolgun / physgun / gravgun here. 
	For the sake of prediction this file is shared.
	Any server specific functions will be found in sv_toolgun.lua

*/

/*
	The below function and table effectively just prevents users from toolgunning certain entities.
	It saves the trouble of expecting admin mods to automatically cater for it (or people wondering their ents have went).
	If you don't want an ent to be touched, add it to the table below.
*/
local BlacklistedEnts={"func_","prop_door","prop_s","sent_","spawned","env","cse","gun","drug","weapon","money","send_keypad"}


local function NoEntTouching(ply, tr, toolmode)
	if !ply:IsAdmin() then return end 
		
	if (tr.Entity:GetClass() == "prop_ragdoll" and !ply:IsAdmin()) then
		return false
	end
	
	for _, badents in pairs (BlacklistedEnts) do
		if string.find(tr.Entity:GetClass(),badents) then return false end
	end
	
	return true
end
hook.Add("CanTool","NoTouchyEnts",NoEntTouching)

local ToolsBlackList = {
	"colour",
	"material",
	"paint",
	"duplicator",
	"eyeposer",
	"faceposer",
	"remover",
	"colour",
	"material",
	"paint",
	"hoverball",
	"emitter",
	"elastic",
	"hydraulic",
	"muscle",
	"nail",
	"ballsocket",
	"ballsocket_adv",
	"pulley",
	"rope",
	"slider",
	"weld",
	"winch",
	"balloon",
	"button",
	"duplicator",
	"dynamite",
	"keepupright",
	"lamp",
	"nocollide",
	"thruster",
	"turret",
	"wheel",
	"eyeposer",
	"faceposer",
	"statue",
	"weld_ez",
	"axis",
}



/*

local function CanTheyUseThatTool( ply, tr, toolmode, second )

	-- In the case of the nail gun, let's check the entity they're nailing TO first.
	if toolmode == "nail" and not second then
		local tr2 = {}
		tr2.start = tr.HitPos
		tr2.endpos = tr.HitPos + ply:GetAimVector() * 16
		tr2.filter = { ply, tr.Entity }
		local trace = util.TraceLine( tr2 )

		if trace.Entity and trace.Entity:IsValid() and not trace.Entity:IsPlayer() then
			local ret = CanTheyUseThatTool( ply, trace, toolmode, true )
			if ret ~= nil then
				return ret
			end
		end
	end

	-- In the case of the remover, we have to make sure they're not trying to right click remove one of no delete ents
	if toolmode == "remover" and ply:KeyDown( IN_ATTACK2 ) and not ply:KeyDownLast( IN_ATTACK2 ) then
		local ConstrainedEntities = constraint.GetAllConstrainedEntities( tr.Entity )
		if ConstrainedEntities then -- If we have anything to worry about
			-- Loop through all the entities in the system
			for _, ent in pairs( ConstrainedEntities ) do
				if ent.NoDeleting then
					Notify( ply, 1, 4, "This entity is constrained to non-deletable entities!" )
					return false
				end
			end
		end
	end

	if tr.Entity.NoDeleting then
		if table.HasValue( ToolsBlackList, toolmode ) then
			return false
		end
	end

end

function AllowPickupWithPhysGun( ply, ent )
	if ent.NoMoving then return false end
end

function AllowPickupWithGravGun( ply, ent )
	if ent.NoMoving then return false end
end*/

hook.Add( "PhysgunPickup", "AllowPickupWithPhysGun", AllowPickupWithPhysGun )
hook.Add( "GravGunPickupAllowed", "AllowPickupWithGravGun", AllowPickupWithGravGun )
hook.Add( "CanTool", "CanTheyUseThatTool", CanTheyUseThatTool )
