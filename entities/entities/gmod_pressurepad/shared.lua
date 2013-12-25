ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = ""
ENT.Author = ""
ENT.Contact	= ""
ENT.Purpose	= ""
ENT.Instructions = ""

// Set the key

function ENT:SetEntityKey(Key)
	self.Entity:SetVar("Numpad", Key)
end

// Get the key

function ENT:GetEntityKey()
	return self.Entity:GetVar("Numpad")
end

// Set button on

function ENT:SetEntityPressing(Bool)
	self.Entity:SetNetworkedBool("Pressing", Bool, true)
end

// Check if it's on
function ENT:IsEntityPressing()
	return self.Entity:GetNetworkedBool("Pressing")
end

// Set label

function ENT:SetEntityLabel(Text)
	local Label = ""
	
	if (Text != "") then
		Label = "\nLabel: "..Text
	end
	
	local Mass = "\nMass: "..self:GetEntityTouching().."/"..self.Entity.Mass
	
	if (self.Entity.Players) then
		Mass = "\nPlayer Activated"
	end
	
	local Status = "(ON)"
	
	if not (self:IsEntityPressing()) then
		Status = "(OFF)"
	end
	
	Text = "Pressure Pad "..Status..Mass..Label
	
	self:SetOverlayText(Text)
end

// Get label

function ENT:GetEntityLabel()
	self.Entity:GetVar("Label", "")
end

// Get player

function ENT:GetEntityPlayer()
	return self.Entity:GetVar("Founder", NULL)
end

// Get player index

function ENT:GetEntityIndex()
	return self.Entity:GetVar("FounderIndex", 0)
end