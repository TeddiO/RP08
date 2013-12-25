--This is part of the door module
local meta = FindMetaTable( "Entity" );
 /*---------------------------------------------------------
   Name: IsOwnable()
   Desc: Are we a door?
---------------------------------------------------------*/
function meta:IsDoor()

	local class = self:GetClass();
	
	if (class == "prop_dynamic") then
		if (self.GetKeyValues) then
			if (self:GetSolid() == 6) then
				if (tostring(self:GetKeyValues().MinAnimTime) == "1") then
					if (tostring(self:GetKeyValues().MaxAnimTime) == "5") then
						return true
					end
				end
			end
		end
	end
	
	if( class == "func_door" or
		class == "func_door_rotating" or
		class == "prop_door_rotating") then
		
		return true;
		
	end
	
	return false;

end

/*---------------------------------------------------------
   Name: GetStatus()
   Desc: Gets the status of the door
 --  0/nil = unowned
 --  1 = owned
 --  2 = unownable
---------------------------------------------------------*/
function meta:GetStatus()

	if (self:GetNWInt( "status" ))then
		return self:GetNWInt( "status" );
	else
		return 0;
	end

end





function meta:DisallowMoving( bool )
	self.NoMoving = bool
end

function meta:DisallowDeleting( bool )
	self.NoDeleting = bool
end

