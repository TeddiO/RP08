
 if( SERVER ) then

	AddCSLuaFile( "shared.lua" );

end


 

SWEP.PrintName      = "Medic Kit"   
SWEP.Author  			 = "Teddi"
SWEP.Slot        		 = 4;
SWEP.SlotPos            = 3;
SWEP.Description        = "Heals the wounded."
SWEP.Contact            = ""
SWEP.Purpose            = ""
SWEP.Instructions      = "Left Click to heal player in front of user."

 
SWEP.Spawnable      = false --  Change to false to make Admin only.
SWEP.AdminSpawnable  = false
 
SWEP.ViewModel      = "models/weapons/v_c4.mdl"
SWEP.WorldModel   = "models/weapons/w_c4.mdl"
 
SWEP.Primary.Recoil  = 0
SWEP.Primary.ClipSize      = -1
SWEP.Primary.DefaultClip    = 1
SWEP.Primary.Automatic    = false
SWEP.Primary.Delay    = 2
SWEP.Primary.Ammo      = "none"
 
SWEP.Secondary.Recoil      = 0
SWEP.Secondary.ClipSize  = -1
SWEP.Secondary.DefaultClip  = 1
SWEP.Secondary.Automatic    = true
SWEP.Secondary.Delay        = 0.3
SWEP.Secondary.Ammo  = "none"
 

util.PrecacheSound("HL1/fvox/medical_repaired.wav")
util.PrecacheSound("HL1/fvox/radiation_detected.wav")
util.PrecacheSound("HL1/fvox/automedic_on.wav")

function SWEP:PrimaryAttack()
 
 	if not(self.Owner:Team() == 7)then
		self.Owner:Kill()
		return
	end

 
self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
 
	local trace = self.Owner:GetEyeTrace();
 
 	if( not trace.Entity:IsValid() and not trace.Entity:IsPlayer() ) then
 		return;
	end
	
	if( self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 175 ) then
		return;
	end
			if (trace.Entity:Health() < 105) then
				trace.Entity:SetHealth( 105 );
					
				self.Owner:EmitSound("HL1/fvox/medical_repaired.wav", 150, 100)
				self.Owner:PrintMessage( HUD_PRINTTALK, trace.Entity:Name().." has been healed." );
			else
				self.Owner:PrintMessage( HUD_PRINTTALK, trace.Entity:Name().." is already at full health." );
			end
end
		