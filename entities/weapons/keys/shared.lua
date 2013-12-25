

if( SERVER ) then

	AddCSLuaFile( "shared.lua" );

end

if( CLIENT ) then

	SWEP.PrintName = "Keys";
	SWEP.Slot = 1;
	SWEP.SlotPos = 1;
	SWEP.DrawAmmo = false;
	SWEP.DrawCrosshair = false;

end

// Variables that are used on both client and server

SWEP.Author			= "[BB]"
SWEP.Instructions	= "Left Click to lock \nRick CLick to Unlock"
SWEP.Contact		= "http://bbroleplay.co.uk"
SWEP.Purpose		= "Securing your property"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.AnimPrefix		= "rpg"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
  
SWEP.Sound = "doors/door_latch3.wav";
  
SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= -1				// Size of a clip
SWEP.Secondary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""



/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
	self:SetWeaponHoldType( "normal" );
end




function SWEP:Deploy()

	if( SERVER ) then

		self.Owner:DrawViewModel( false );
		self.Owner:DrawWorldModel( false );
		
	end

end

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
  function SWEP:PrimaryAttack()
  
	if( CLIENT ) then return; end

 	local trace = self.Owner:GetEyeTrace();

 	if( not trace.Entity:IsValid() or not trace.Entity:IsDoor() or self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 65 ) then
 		return;
	end

	if(trace.Entity:GetTable().owner and (self.Owner:UniqueID() == trace.Entity:GetTable().owner or trace.Entity:GetTable().accesors[self.Owner:UniqueID( )]))then
	
		trace.Entity:Fire( "lock", "", 0 );
		
		self.Owner:EmitSound( self.Sound );
		self.Weapon:SetNextPrimaryFire( CurTime() + 1.0 );
		
	else
	
			Notify( self.Owner, 1, 3, "You don't own this door!" );
		
			self.Weapon:SetNextPrimaryFire( CurTime() + .5 );
	
	
	end

  end
 
  /*---------------------------------------------------------
  SecondaryAttack
  ---------------------------------------------------------*/
  function SWEP:SecondaryAttack()
  
	if( CLIENT ) then return; end

 	local trace = self.Owner:GetEyeTrace();

 	if( not trace.Entity:IsValid() or not trace.Entity:IsDoor() or self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 65 ) then
 		return;
	end

	if(trace.Entity:GetTable().owner and (self.Owner:UniqueID() == trace.Entity:GetTable().owner or trace.Entity:GetTable().accesors[self.Owner:UniqueID( )]))then
		
		trace.Entity:Fire( "unlock", "", 0 );

		self.Owner:EmitSound( self.Sound );
		self.Weapon:SetNextPrimaryFire( CurTime() + 1.0 );
		
	else
	
	
			Notify( self.Owner, 1, 3, "You don't own this door!" );
		
			self.Weapon:SetNextPrimaryFire( CurTime() + .5 );
		
		end
		
	
 
  end 
