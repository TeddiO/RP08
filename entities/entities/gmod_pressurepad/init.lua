// Client

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

// Include

include('shared.lua')

// Initialize

function ENT:Initialize()
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetUseType(ONOFF_USE)
	self.Entity:SetNetworkedInt(0, 0)
	self.Entity:SetColor(255, 60, 65, 255)
	
	self.Entity.Mass = 25
	
	self.Entity.Touching = {}
	
	if (Wire_CreateOutputs) then
		self.Outputs = Wire_CreateOutputs(self.Entity, {"Active", "Mass"})
	end
	
	self:SetEntityPressing(false)
end

// Is above

function ENT:IsBelow(Entity)
	if (self.Entity.Above == 0) then
		return true
	end
	
	return self.Entity:GetPos().z < Entity:GetPos().z
end 

// Get touching

function ENT:GetEntityTouching()
	local Number = 0
	
	for K, V in pairs(self.Entity.Touching) do
		if (K and K:IsValid()) then
			Number = Number + V
		else
			self.Entity.Touching[K] = nil
		end
	end
	
	return Number
end

// When touched

function ENT:StartTouch(Entity)
	local Phys = Entity:GetPhysicsObject()
	
	if (Phys) then
		if (self:IsBelow(Entity)) then
			self.Entity.Touching[Entity] = Phys:GetMass()
		end
	end
	
	local Timer = "Touch: "..self.Entity:EntIndex().." "..Entity:EntIndex()
	
	// Remove timer
	
	timer.Remove(Timer)
	
	// Update mass
	
	self:UpdateEntityMass()
end

// Update mass

function ENT:UpdateEntityMass()
	if (Wire_TriggerOutput) then
		Wire_TriggerOutput(self.Entity, "Mass", self:GetEntityTouching())
	end
end

// When not used

function ENT:EndTouch(Entity)
	local function Func(Entity, ID)
		if (Entity and Entity:IsValid()) then
			Entity.Touching[ID] = nil
		end
		
		// Update mass
		
		self:UpdateEntityMass()
	end
	
	local Timer = "Touch: "..self.Entity:EntIndex().." "..Entity:EntIndex()
	
	// Create timer
	
	local Delay = self.Entity.Delay + 0.5
	
	timer.Create(Timer, Delay, 1, Func, self.Entity, Entity)
end

// Think

function ENT:Think()
	if (self:GetEntityTouching() < self.Entity.Mass) then
		if (self:IsEntityPressing()) then
			self:EntityToggle(false)
		end
	else
		if not (self:IsEntityPressing()) then
			self:EntityToggle(true)
		end
	end
	
	self:SetEntityLabel(self.Entity.Description)
end

// When entity is removed

function ENT:OnRemove()
	local Player = self:GetEntityPlayer()
	local Index  = self:GetEntityIndex()
	local Key 	 = self:GetEntityKey()
	
	numpad.Deactivate(Player, _, {Key}, Index)
end

// Toggle entity

function ENT:EntityToggle(Bool)
	local Player = self:GetEntityPlayer()
	local Index  = self:GetEntityIndex()
	local Key 	 = self:GetEntityKey()
	
	local R, G, B, A = self.Entity:GetColor()
	
	if (Bool) then
		numpad.Activate(Player, _, {Key}, Index)
		
		if (self.Entity.Once == 1) then
			numpad.Deactivate(Player, _, {Key}, Index)
		end
		
		self.Entity:SetColor(135, 245, 125, A)
		
		self:SetEntityPressing(true)
	else
		if (self.Entity.Once == 1) then
			numpad.Activate(Player, _, {Key}, Index)
		end
		
		numpad.Deactivate(Player, _, {Key}, Index)
		
		self.Entity:SetColor(255, 60, 65, A)
		
		self:SetEntityPressing(false)
	end
	
	if (Wire_TriggerOutput) then
		local Number = 0
		
		if (Bool) then
			Number = 1
		end
		
		Wire_TriggerOutput(self.Entity, "Active", Number)
	end
end