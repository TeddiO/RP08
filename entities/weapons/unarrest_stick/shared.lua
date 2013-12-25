

if( SERVER ) then

	AddCSLuaFile( "shared.lua" );

end

if( CLIENT ) then

	SWEP.PrintName = "UnArrest baton";
	SWEP.Slot = 4;
	SWEP.SlotPos = 3;
	SWEP.DrawAmmo = false;
	SWEP.DrawCrosshair = false;

end

// Variables that are used on both client and server

SWEP.Author			= "Rickster"
SWEP.Instructions	= "Left click to unarrest"
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.AnimPrefix		= "stunstick"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.NextStrike = 0;
  
SWEP.ViewModel = Model( "models/weapons/v_stunstick.mdl" );
SWEP.WorldModel = Model( "models/weapons/w_stunbaton.mdl" );
  
SWEP.Sound = Sound( "weapons/stunstick/stunstick_swing1.wav" );
  
SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= -1				// Size of a clip
SWEP.Secondary.DefaultClip	= -1				// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""



/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()

	self:SetWeaponHoldType( "melee" );
	
end


/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
  function SWEP:PrimaryAttack()
  
  	if not(self.Owner:Team() == 2 or self.Owner:Team() == 3 or self.Owner:Team() == 5 or self.Owner:Team() == 9)then
		self.Owner:Kill()
		return
	end
  
  	if( CurTime() < self.NextStrike ) then return; end
  
  	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	self.Weapon:EmitSound( self.Sound );
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER );

	if( CLIENT ) then return; end

 	local trace = self.Owner:GetEyeTrace();

	self.NextStrike = ( CurTime() + .4 );
	
 	if( not trace.Entity:IsValid() and not trace.Entity:IsPlayer() ) then
 		return;
	end
	
	if( self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 94 ) then
		return;
	end
	
	Notify( trace.Entity, 1, 3, "You've been unarrested by " .. self.Owner:Nick() .."!" );
 	trace.Entity:Unarrest();

  end
  