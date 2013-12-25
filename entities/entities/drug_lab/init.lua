-- ============================================
-- =                                          =
-- =          Crate SENT by Mahalis           =
-- =                                          =
-- ============================================
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
local rechargeTo=10
function ENT:Initialize()
	self.Entity:SetModel( "models/props_combine/combine_mine01.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	timer.Create( self.Entity, 120, 0, self.giveMoney, self)
	self.Entity.sparking = false
	self.Entity.damage = 150
	local ply = self.Entity.ownu
		ply.maxDrugLab = ply.maxDrugLab + 1
	self.power = rechargeTo
	self.used = false
	
end

function ENT:OnTakeDamage(dmg)
	self.Entity.damage = self.Entity.damage - dmg:GetDamage()
	if(self.Entity.damage <= 0) then
		killer = dmg:GetInflictor()
		if (killer:IsPlayer() and killer:IsValid())then
			if(( killer:Team() == 2 or killer:Team() == 9) and not Admins[killer:SteamID()]) then
				killer:AddMoney( 50 );
				Notify( killer, 1, 3, "You got 50 tokens for destroying a drug lab." );
			else
				Notify( killer, 1, 3, "Well done for destroying a drug lab." );
			end
		end
		self.Entity:Destruct()
		self.Entity:Remove()
	end
end

function ENT:giveMoney()
	local ply = self.Entity.ownu
/*	if ply:HasPerk("druglabs_enhanced") then rechargeTo=30 end*/
	if not(ply)then
		self.Entity.ownu = nil
		self.Entity:Destruct()  
		self.Entity:Remove()
		return
	end
	
	if not(ply:IsValid())then
		self.Entity.ownu = nil
		self.Entity:Destruct()  
		self.Entity:Remove()
		return
	end
	
	if not(ply:IsConnected())then
		self.Entity.ownu = nil
		self.Entity:Destruct()  
		self.Entity:Remove()
		return
	end
	
	if(self.power <= 1)then
		Notify( ply, 2, 5, "One of your drug labs has run out of energy, please refill it." )
		return ""
	else
		self.power = self.power - 1
	end
		local baseamnt=RP08.CfgVars["drugpayamount"] - 10;
		local endamnt=baseamnt;

		Notify( ply, 1, 3, "You got paid " .. endamnt .. " tokens for manufacturing/selling drugs." );
		ply:AddMoney(endamnt)

end

function ENT:Destruct()

	local vPoint = self.Entity:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart( vPoint )
	effectdata:SetOrigin( vPoint )
	effectdata:SetScale( 1 )
	util.Effect( "Explosion", effectdata )

end

function ENT:Use(pl,caller)
	if (self.used == true)then
		return false
	end
		self.used = true
		timer.Simple( 2, used, self)
	if not(self.power == rechargeTo)then	
		self.power = rechargeTo
		pl:PrintMessage( HUD_PRINTTALK, "You have recharged the drug lab!" ) 
		return false
	end
	
	if( pl.maxDrugs >= 4 ) then
		Notify( pl, 1, 3, "Reached Max Drugs" );
		return false
	end
		self.Entity.sparking = true
		timer.Create( self.Entity:EntIndex( ), 1, 1, self.createDrug, self)
	
	self.Entity.drugmakin = pl
end

function used(self)

	self.used = false
	
end

function ENT:createDrug()
	self.Entity.sparking = false
	pl = self.Entity.drugmakin
	local drugPos = self.Entity:GetPos()
	drug = ents.Create("drug")
	drug:SetPos(Vector(drugPos.x,drugPos.y,drugPos.z + 10))
	drug.ownu = pl
	drug:Spawn()
	pl.maxDrugs = pl.maxDrugs + 1
end

function ENT:Think()
	if(self.Entity.sparking == true) then
		local effectdata = EffectData()
			effectdata:SetOrigin( self.Entity:GetPos() )
			effectdata:SetMagnitude( 1 )
			effectdata:SetScale( 1 )
			effectdata:SetRadius( 2 )
		util.Effect( "Sparks", effectdata )
	end
end

function ENT:OnRemove()
	local ply = self.Entity.ownu
	
	timer.Destroy(self.Entity) 	

	if (ply and ply:IsValid() and ply:IsConnected())then
		ply.maxDrugLab = ply.maxDrugLab -1
	end
end

