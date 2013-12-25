
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/BB/Drugs/bb_drugs001.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	self.Entity.damage = 10
end

function ENT:OnTakeDamage(dmg)
	self.Entity.damage = self.Entity.damage - dmg:GetDamage()

	if(self.Entity.damage <= 0) then
		local effectdata = EffectData()
		effectdata:SetOrigin( self.Entity:GetPos() )
		effectdata:SetMagnitude( 3 )
		effectdata:SetScale( 3 )
		effectdata:SetRadius( 2 )
	util.Effect( "WheelDust", effectdata )
		self.Entity:Remove()
	end
end

function ENT:Use(activator,caller)
DrugPlayer(caller)
self.Entity:Remove()
end

function ENT:Think()

end

function ENT:OnRemove( )
	local pl = self.Entity.ownu
	pl.maxDrugs = pl.maxDrugs - 1
end

