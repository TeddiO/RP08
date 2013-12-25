
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/props_lab/clipboard.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
end

function ENT:Think()

end

function ENT:OnRemove()
	local pl = self.Entity.owner
	pl.maxletters = pl.maxletters - 1
end

function ENT:Use(pl,caller)

	if not(self.Entity.owner:IsValid())then
		self.Entity:Remove()
	end

	umsg.Start( "ShowLetter", pl );
		umsg.Short( self.Entity.type );
		umsg.Vector( self.Entity:GetPos() );
		umsg.String( self.Entity.content);
		umsg.Entity( self.Entity.owner );
	umsg.End();		
end