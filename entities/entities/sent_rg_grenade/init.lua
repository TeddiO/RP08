

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


local GrenadeModel = "models/items/AR2_Grenade.mdl"
util.PrecacheModel(GrenadeModel)

function ENT:Initialize()

	self.Entity:SetModel(GrenadeModel)
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self.Owner = self.Entity:GetOwner()
	self.Explodeit = false
	
	self.PhysObj = self.Entity:GetPhysicsObject()
	if (self.PhysObj:IsValid()) then
		self.PhysObj:Wake()
	end
	
end

function ENT:Explode()

	self.Entity:SetNWBool("exploding",true)
	self.Explodeit = true
	self.Entity:EmitSound(Sound("BaseSmokeEffect.Sound"))

	timer.Simple( 20, function() -- 20
		self.Entity:SetNWBool("exploding",false)
		self.Explodeit = false
		self.Entity:Remove()
	end )

end


function ENT:PhysicsCollide(data, physobj)

	if data.Speed > 50 then
		self.Entity:EmitSound(Sound("SmokeGrenade.Bounce"))
	end

	if not self.Ready and not self.Explodeit then
		timer.Simple( 1, function() self:Explode() end )
		self.Ready = true
	end

end


function ENT:Think()

	if self.Explodeit then
		for k, ply in pairs( player.GetAll() ) do
			if ply:Team() == 9 or ply:Team() == 2 then return end
			local entpos = self.Entity:GetPos()
			local plypos = ply:GetPos()
			if entpos:Distance( plypos ) < 300 then
				ply:JustGassed()
			end
		end
	end

end

