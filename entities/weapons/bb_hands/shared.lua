if( SERVER ) then

	AddCSLuaFile( "shared.lua" );

end

if( CLIENT ) then

	SWEP.PrintName = "Hands";
	SWEP.Slot = 0;
	SWEP.SlotPos = 1;
	SWEP.DrawAmmo = false;
	SWEP.DrawCrosshair = false;

end

// Variables that are used on both client and server

SWEP.Author			= "[BB]"
SWEP.Instructions	= "Left click - Weakly punch. \nRight click - Knock on doors"
SWEP.Contact		= "http://bbroleplay.co.uk"
SWEP.Purpose		= "To knock"

SWEP.ViewModel = Model( "models/weapons/v_fists.mdl" );
SWEP.WorldModel = Model( "models/weapons/w_fists.mdl" );

-- SWEP.ViewModelFOV	= 62
-- SWEP.ViewModelFlip	= false
SWEP.AnimPrefix		= "admire"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
  
  
SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= -1				// Size of a clip
SWEP.Secondary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""

SWEP.IronSightPos = Vector( 0, 6.2, -8.0 );
SWEP.IronSightAng = Vector( -4, 0, 0.0 );
SWEP.NoIronSightFovChange = true;
SWEP.NoIronSightAttack = true;

/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()


	self:SetWeaponHoldType( "normal" );
	


	self.HitSounds = {
	
		Sound( "npc/vort/foot_hit.wav" ),
		Sound( "weapons/crossbow/hitbod1.wav" ),
		Sound( "weapons/crossbow/hitbod2.wav" )
	}
	
	self.SwingSounds = {
	
		Sound( "npc/vort/claw_swing1.wav" ),
		Sound( "npc/vort/claw_swing2.wav" )
	
	}

end

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
  function SWEP:PrimaryAttack()
  
  	if( self.Owner:KeyDown( IN_SPEED ) and self.Owner:GetVelocity():Length() >= 140 ) then 
		return false; 
	end
  		  
		self.Weapon:EmitSound( self.SwingSounds[math.random( 1, #self.SwingSounds )] );
		
		self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
		
		self.Weapon:SetNextPrimaryFire( CurTime() + 4 - ( .8 * math.Clamp( self.Owner:GetNWInt( "sprint" ) / 100, 0, 1 ) )  );
		
			
		local trace = {}
		trace.start = self.Owner:EyePos();
		trace.endpos = trace.start + self.Owner:GetAimVector() * 60;
		trace.filter = self.Owner;
			
		local tr = util.TraceLine( trace );
			
		if( tr.Hit or tr.Entity:IsValid() ) then
			
			if( SERVER ) then
				
				if( tr.Entity:IsValid() ) then
			
					local norm = ( tr.Entity:GetPos() - self.Owner:GetPos() ):Normalize();
					local push = 2000 * norm;
					
					if( tr.Entity:IsPlayer()) then
						local pl = tr.Entity;
						local hp = pl:Health();
						hp = hp - math.random( 1, 4 );
						if( hp <= 0 ) then pl:Knockout() end
						pl:SetHealth( hp );
						if not (self.Owner:GetAimVector():Angle().p < 330 and self.Owner:GetAimVector():Angle().p > 260) then
							pl:SetVelocity( ( tr.Entity:GetPos() - self.Owner:GetPos() ) * 5 )
						end
						pl:ViewPunch( Angle( math.random(-15, 15), math.random(-15, 15), math.random(-15, 15) ) )
					else					
						tr.Entity:GetPhysicsObject():ApplyForceOffset( push, tr.HitPos );
					end
				
				end
				
			end
			
			self.Weapon:EmitSound( self.HitSounds[math.random( 1, #self.HitSounds )] );
			
		end

  end
 
  /*---------------------------------------------------------
  SecondaryAttack
  ---------------------------------------------------------*/
  
function SWEP:SecondaryAttack()
   
		local trace = { }
		trace.start = self.Owner:EyePos();
		trace.endpos = trace.start + self.Owner:GetAimVector() * 60;
		trace.filter = self.Owner;
			
		local tr = util.TraceLine( trace );
			
	if( not tr.Entity:IsValid() or not tr.Entity:IsDoor() or self.Owner:EyePos():Distance( tr.Entity:GetPos() ) > 65 ) then
 		--self:ToggleIronsight();
	else
		self.Weapon:EmitSound( Sound( "physics/wood/wood_crate_impact_hard2.wav" ) );
	end

  end