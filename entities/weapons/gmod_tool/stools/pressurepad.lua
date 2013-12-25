TOOL.Category = "Construction"
TOOL.Name        = "#Pressure Pad Tool"
TOOL.Command     = nil
TOOL.ConfigName  = ""

TOOL.ClientConVar["Mass"] = "500"
TOOL.ClientConVar["Model"] = "models/props_c17/clock01.mdl"
TOOL.ClientConVar["Description"] = ""
TOOL.ClientConVar["Once"] = "0"
TOOL.ClientConVar["Delay"] = "0"
TOOL.ClientConVar["Key"] = "5"
TOOL.ClientConVar["Above"] = "1"

// Register

cleanup.Register("pressurepads")

// Console

CreateConVar("sbox_maxpressurepads", 1, FCVAR_NOTIFY)

// Client

if (CLIENT) then
	// Tool
	
	language.Add("Tool_pressurepad_name", "Pressure Pad Tool")
	language.Add("Tool_pressurepad_desc", "Pressure Pad which press key when weight is applied")
	language.Add("Tool_pressurepad_0", "Left click to spawn a Pressure Pad and Right click to set model to what you're looking at")
	
	// Other
	
	language.Add("Undone_pressurepad", "Undone Pressure Pad")
	language.Add("SBoxLimit_pressurepads", "You've hit the Pressure Pads limit!")
	language.Add("Cleanup_pressurepads", "Pressure Pads")
	language.Add("Cleaned_pressurepads", "Cleaned up all Pressure Pads")
end

// Message

function TOOL:Message(Text)
	if SERVER then
		self:GetOwner():SendLua("GAMEMODE:AddNotify('"..Text.."', NOTIFY_GENERIC, 10)")
		self:GetOwner():SendLua("surface.PlaySound('ambient/water/drip"..math.random(1, 4)..".wav')")
	end
end

// Left click

function TOOL:LeftClick(Trace)
	if(CLIENT) then
		return true
	end
	
	// Locals
	
	local Player = self:GetOwner()

	local Key = self:GetClientNumber("Key")
	local Mass = self:GetClientNumber("Mass")
	if(Mass > 85)then
		Mass = 85
	end
	local Once = self:GetClientNumber("Once")
	local Delay = self:GetClientNumber("Delay")
	local Description = self:GetClientInfo("Description")
	local Model = self:GetClientInfo("Model")
	local Above = self:GetClientNumber("Above")
	
	// Keep it nice and whole
	
	Mass = math.floor(Mass)
	Delay = math.floor(Delay)
	
	if (Trace.Entity and Trace.Entity:IsValid() and Trace.Entity:GetClass() == "gmod_pressurepad") then
		// Merge
		
		local Table = {
			Mass = Mass,
			Above = Above,
			Once = Once,
			Delay = Delay,
			Description = Description
		}
		
		table.Merge(Trace.Entity:GetTable(), Table)
		
		// Other
		
		Trace.Entity:GetTable():SetEntityKey(Key)
		Trace.Entity:GetTable():SetEntityLabel(Description)
		
		self:Message("Properties changed for Pressure Pad!")
		
		return true
	end
	
	local Ang = Trace.HitNormal:Angle()
	
	Ang.pitch = Ang.pitch + 90

	local Button = CreatePressurePad(Player, Model, Above, Mass, Once, Delay, Ang, Trace.HitPos, Key, Description)
	
	if not (Button) then return false end
	
	local Minimum = Button:OBBMins()
	
	Button:SetPos(Trace.HitPos - Trace.HitNormal * Minimum.z)
	
	undo.Create("pressurepad")
		undo.AddEntity(Button)
		undo.SetPlayer(Player)
	undo.Finish()
	
	Player:AddCount("pressurepads", Button)
	
	Player:AddCleanup("pressurepads", Button)
	
	self:Message("Pressure Pad has been created!")
	
	return true, Button
end

// Right click

function TOOL:RightClick(Trace)
	if (CLIENT) then
		return true
	end
	
	if (Trace.Entity and Trace.Entity:IsValid()) then
		if (Trace.Entity:GetClass() == "prop_physics") then
			self:GetOwner():ConCommand('pressurepad_Model "'..Trace.Entity:GetModel()..'"\n')
			
			self:Message("Pressure Pad model set to "..Trace.Entity:GetModel())
		else
			self:Message("Pressure Pads only accept physics models!")
		end
	end
	
	return true
end

// Make it

if (SERVER) then
	function CreatePressurePad(Player, Model, Above, Mass, Once, Delay, Ang, Pos, Key, Description, Nocollide, Vel, Avel, Frozen)
		if (!Player:CheckLimit("pressurepads")) then return false end
		
		local Button = ents.Create("gmod_pressurepad")
		
		Button:SetModel(Model)
		Button:SetAngles(Ang)
		Button:SetPos(Pos)
		Button:Spawn()
		
		// Merge
		
		local Table = {
			Mass = Mass,
			Above = Above,
			Once = Once,
			Delay = Delay,
			Description = Description
		}
		
		table.Merge(Button:GetTable(), Table)
		
		// Set the entities owner
		
		Button:GetTable():SetPlayer(Player)
		
		// Other
		
		Button:GetTable():SetEntityKey(Key)
		Button:GetTable():SetEntityLabel(Description)
		
		if Frozen then Button:GetPhysicsObject():EnableMotion(false) end

		if Nocollide then Button:GetPhysicsObject():EnableCollisions(false) end
		
		return Button
	end
	
	duplicator.RegisterEntityClass("gmod_pressurepad", CreatePressurePad, "Model", "Above", "Mass", "Once", "Delay", "Ang", "Pos", "Key", "Description", "Nocollide", "Vel", "Avel", "Frozen")
end

// Control panel

function TOOL.BuildCPanel(Panel)
	Panel:AddControl("Header", {Text = "#Tool_pressurepad_name", Description = "#Tool_pressurepad_desc"})

	local Models = {}
	
	Models["Clock"] = {}
	Models["Clock"]["pressurepad_Model"] = "models/props_c17/clock01.mdl"
	
	Models["Gate"] = {}
	Models["Gate"]["pressurepad_Model"] = "models/props_building_details/Storefront_Template001a_Bars.mdl"
	
	Models["Lid"] = {}
	Models["Lid"]["pressurepad_Model"] = "models/props_junk/TrashDumpster02b.mdl"
	
	Models["Blast Door"] = {}
	Models["Blast Door"]["pressurepad_Model"] = "models/props_lab/blastdoor001a.mdl"
	
	Models["Prison Door"] = {}
	Models["Prison Door"]["pressurepad_Model"] = "models/props_doors/door03_slotted_left.mdl"
	
	Panel:AddControl("ComboBox", {Label = "Model", Options = Models, MenuButton = 0})
	
	Panel:AddControl("CheckBox", {Label = "Press once when weight is applied/removed", Command = "pressurepad_Once"})
	
	Panel:AddControl("CheckBox", {Label = "Only allow entities above to activate", Command = "pressurepad_Above"})
	
	Panel:AddControl("Slider", {Label = "Mass", Type = "Integer", Min = 0, Max = 1000, Command = "pressurepad_Mass"})
	
	Panel:AddControl("Slider", {Label = "Delay untill pad deactivates", Type = "Integer", Min = 0, Max = 10, Command = "pressurepad_Delay"})
	
	Panel:AddControl("Numpad", {Label = "Key to emulate", Command = "pressurepad_Key", ButtonSize = 22})

	Panel:AddControl("TextBox", {Label = "Description", MaxLength = "100", Command = "pressurepad_Description"})
end

// Ghost

function TOOL:UpdateGhostPressurePad(Entity, Player)
	if (!Entity) then return end
	
	if (!Entity:IsValid()) then return end

	local TR = utilx.GetPlayerTrace(Player, Player:GetCursorAimVector())
	
	local Trace = util.TraceLine(TR)
	
	if (!Trace.Hit) then return end
	
	if (Trace.Entity && Trace.Entity:GetClass() == "gmod_pressurepad" || Trace.Entity:IsPlayer()) then
		Entity:SetNoDraw(true)
		
		return
	end
	
	local Ang = Trace.HitNormal:Angle()
	
	Ang.pitch = Ang.pitch + 90
	
	local Minimum = Entity:OBBMins()
	
	Entity:SetPos(Trace.HitPos - Trace.HitNormal * Minimum.z)
	
	Entity:SetAngles(Ang)
	
	Entity:SetNoDraw(false)
end

// Think

function TOOL:Think()
	if (self:GetClientInfo("Model") and self:GetClientInfo("Model") != "") then
		if (!self.GhostEntity || !self.GhostEntity:IsValid() || self.GhostEntity:GetModel() != self:GetClientInfo("Model")) then
			self:MakeGhostEntity(self:GetClientInfo("Model"), Vector(0, 0, 0), Angle(0, 0, 0) )
		end
		
		self:UpdateGhostPressurePad(self.GhostEntity, self:GetOwner())
	end
end