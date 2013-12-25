include('shared.lua')

// Draw

function ENT:Draw()
	if (LocalPlayer():GetEyeTrace().Entity == self.Entity && EyePos():Distance(self.Entity:GetPos()) < 512) then
		if (self:IsEntityPressing()) then
			self:DrawEntityOutline(1.5 + math.sin(CurTime() * 50) * 0.5)
		else
			self:DrawEntityOutline(1.0)
		end
		
		self.Entity:DrawModel()
		
		if (self:GetOverlayText() != "") then
			AddWorldTip(self.Entity:EntIndex(), self:GetOverlayText(), 0.5, self.Entity:GetPos(), self.Entity)
		end
		
		return
	end

	self.Entity:DrawModel()
end