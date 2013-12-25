include("shared.lua")

function ENT:Initialize()

	self.Emitter = ParticleEmitter(self.Entity:GetPos())

end



function ENT:Draw()

	self.Entity:DrawModel()
	
	render.SetMaterial( Material('sprites/redglow8') )
	render.DrawSprite( self.Entity:GetPos() + Vector(0,0,3), 10, 10, Color(255, 255, 255, 225) )

	if self.Entity:GetNWBool("exploding") and self.Entity:IsValid() then
		local particle = self.Emitter:Add("particles/smokey", self.Entity:GetPos())
		particle:SetVelocity(VectorRand()*12)
		particle:SetGravity(Vector(5,5,3))
		particle:SetDieTime(math.Rand(1,2))
		particle:SetStartAlpha(math.Rand(75,125))
		particle:SetEndAlpha(0)
		particle:SetStartSize(math.Rand(150,200))
		particle:SetEndSize(math.Rand(250,300))
		particle:SetRoll(math.Rand(200,300))
		particle:SetRollDelta(math.Rand(-1,1))
		particle:SetColor(math.random(92,112),math.random(92,112),math.random(41,61))
		particle:SetAirResistance(5)
	end
	
end


function ENT:OnRemove()

	self.Emitter:Finish()

end





