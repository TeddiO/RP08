
AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );

include( "shared.lua" );

function ENT:Initialize()
	self.Entity:PhysicsInit( SOLID_VPHYSICS );
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS );
	self.Entity:SetSolid( SOLID_VPHYSICS );
	local phys = self.Entity:GetPhysicsObject();
	self.Entity.damage = 50
	if( phys:IsValid() ) then
	  phys:Wake();
	 end
  
end

function ENT:SetData( data )

	self.Entity:GetTable().Data = data;
	
	self.Entity:SetNWString( "Name", data.Name );
	self.Entity:SetNWFloat( "Size", data.Size );

end

function ENT:OnTakeDamage(dmg)
	self.Entity.damage = self.Entity.damage - dmg:GetDamage()
	if(self.Entity.damage <= 0) then
		self.Entity:Destruct()  
	end
end

function ENT:Destruct()

	local vPoint = self.Entity:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart( vPoint )
	effectdata:SetOrigin( vPoint )
	effectdata:SetScale( 10 )
	util.Effect( "MetalSpark", effectdata )
	self.Entity:Remove()

end

/*---------------------------------------------------------
   Name: PhysicsCollide
   Desc: Called when physics collides. The table contains 
			data on the collision
---------------------------------------------------------*/
function ENT:PhysicsCollide(Data, PhysObj)
	--Deal damage to func_breakables
	dprint("si:Colide, "..Data.HitEntity:GetClass())
	if (Data.HitEntity:GetClass() == "spawned_item") then
		self.Entity.damage = self.Entity.damage - 0.5
	end
	if(self.Entity.damage <= 0) then
		self.Entity:Remove()  
	end
end


/*---------------------------------------------------------
   Name: PhysicsUpdate
   Desc: Called to update the physics .. or something.
---------------------------------------------------------*/
function ENT:PhysicsUpdate( physobj )
end

function ENT:Use(pl,caller)
			local uid = self.Entity:GetTable().Data.UniqueID
			if(RP08.InventoryFull( pl, RP08.ItemData[uid].Size ) == false)then
				if(RP08.ItemData[uid].maxallowed and pl:GetTable().Inventory[uid])then
					if(pl:GetTable().Inventory[uid] >= RP08.ItemData[uid].maxallowed)then
						Notify( pl, 1, 3, "You are only allowed ".. RP08.ItemData[uid].maxallowed.." of these!" );
						return
					end
				end
				RP08.Item_Update(pl, uid, 1)
				self.Entity:Remove()
			else
				Notify( pl, 1, 3, "Your inventory is full!" );
			end
end