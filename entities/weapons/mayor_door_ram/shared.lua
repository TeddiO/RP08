

if( SERVER ) then

	AddCSLuaFile( "shared.lua" );

end

if( CLIENT ) then

	SWEP.PrintName = "Mayor Ram";
	SWEP.Slot = 4;
	SWEP.SlotPos = 4;
	SWEP.DrawAmmo = false;
	SWEP.DrawCrosshair = false;

end

// Variables that are used on both client and server

SWEP.Author			= "Rickster"
SWEP.Instructions	= "Left click to break open doors"
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.AnimPrefix		= "rpg"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Sound = Sound( "physics/wood/wood_box_impact_hard3.wav" );

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

	if( SERVER ) then
	
		self:SetWeaponHoldType( "melee" );
	
	end

end


/*---------------------------------------------------------
   Name: SWEP:Precache( )
   Desc: Use this function to precache stuff
---------------------------------------------------------*/
function SWEP:Precache()
end


/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

	if not(self.Owner:Team() == 3)then
		self.Owner:Kill()
		return
	end

	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	
	if( CLIENT ) then return; end

 	local trace = self.Owner:GetEyeTrace();
	local maintitle = trace.Entity:GetNWString( "maintitle" )
 	if( not trace.Entity:IsValid() or not trace.Entity:IsDoor() or self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 45 ) then
 		return;
	end
	
	if(trace.Entity:GetTable().owner)then	
		local pl = player.GetByUniqueID( trace.Entity:GetTable().owner )
		if(not pl:GetNWBool("warrant") == true)then
			self.Owner:PrintMessage(4, pl:Name().." does not have a warrant!")
			return;
		end
	end
	
	self.Owner:EmitSound( self.Sound );
	
	trace.Entity:Fire( "unlock", "", .5 )
	trace.Entity:Fire( "open", "", .6 )
	
	self.Owner:ViewPunch( Angle( -10, math.random( -5, 5 ), 0 ) );
	self.Weapon:SetNextPrimaryFire( CurTime() + 2.5 );
	
end

