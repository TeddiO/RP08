
TOOL.Category		= "Render"
TOOL.Name			= "#Colour"
TOOL.Command		= nil
TOOL.ConfigName		= nil


TOOL.ClientConVar[ "r" ] = 255
TOOL.ClientConVar[ "g" ] = 0
TOOL.ClientConVar[ "b" ] = 255
TOOL.ClientConVar[ "a" ] = 255
TOOL.ClientConVar[ "mode" ] = 0
TOOL.ClientConVar[ "fx" ] = 0

local function SetColour( Player, Entity, Data )

	if ( Data.Color ) then Entity:SetColor( Data.Color.r, Data.Color.g, Data.Color.b, Data.Color.a ) end

	if ( SERVER ) then
		duplicator.StoreEntityModifier( Entity, "colour", Data )
	end
	
end
duplicator.RegisterEntityModifier( "colour", SetColour )

function TOOL:LeftClick( trace )

	if trace.Entity && 		// Hit an entity
	   trace.Entity:IsValid() && 	// And the entity is valid
	   trace.Entity:EntIndex() != 0 // And isn't worldspawn
	then

		if (CLIENT) then
			return true 
		end
	
		local r		= self:GetClientNumber( "r", 0 )
		local g		= self:GetClientNumber( "g", 0 )
		local b		= self:GetClientNumber( "b", 0 )
		local a		= 255

		SetColour( self:GetOwner(), trace.Entity, { Color = Color( r, g, b, a )} )

		return true
		
	end
	
end

function TOOL:RightClick( trace )

	if trace.Entity && 		// Hit an entity
	   trace.Entity:IsValid() && 	// And the entity is valid
	   trace.Entity:EntIndex() != 0 // And isn't worldspawn
	then

		SetColour( self:GetOwner(), trace.Entity, { Color = Color( 255, 255, 255, 255 ), RenderMode = 0, RenderFX = 0 } )	
		return true
	
	end
	
end
