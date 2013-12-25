

if( SERVER ) then

	AddCSLuaFile( "shared.lua" );

end

if( CLIENT ) then

	SWEP.PrintName = "Battering Ram";
	SWEP.Slot = 4;
	SWEP.SlotPos = 4;
	SWEP.DrawAmmo = false;
	SWEP.DrawCrosshair = false;

end

// Variables that are used on both client and server

SWEP.Author			= "Teddi"
SWEP.Instructions	= "Left click to break open doors"
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel = Model( "models/weapons/v_rpg.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_rocket_launcher.mdl" )
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

	
		self:SetWeaponHoldType( "rpg" );

end

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

	self.Weapon:SetNextPrimaryFire( CurTime() + 1 );

	if not(self.Owner:Team() == 2 or self.Owner:Team() == 3 or self.Owner:Team() == 9)then
		self.Owner:Kill()
		return
	end

	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	
	if( CLIENT ) then return; end

 	local trace = self.Owner:GetEyeTrace();
    if( not trace.Entity:IsValid() or self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 85 ) then
		return;
	end
	
	if(trace.Entity:GetClass() == "prop_dynamic") or (trace.Entity:GetClass() == "prop_door")then
--	dprint("dynamic")
		if(SPropProtection)then
			local pl = player.GetByUniqueID(SPropProtection["Props"][trace.Entity:EntIndex()][1])
			dprint(pl:Nick())
			if(pl == false or not pl:GetNWBool("warrant") == true)then
				self.Owner:PrintMessage(4, pl:Name().." does not have a warrant!")
				return;
			end
		end
		self.Owner:EmitSound( self.Sound );
		trace.Entity:Fire("setanimation","open","0")
		trace.Entity:Fire("setanimation","close",5)
		self.Owner:ViewPunch( Angle( -10, math.random( -5, 5 ), 0 ) );
		self.Weapon:SetNextPrimaryFire( CurTime() + 5 );
		return;
	end
	
 	if(not trace.Entity:IsDoor() and self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 60 ) then
		return;
	end
	--dprint("door")
	if(trace.Entity:GetTable().owner)then	
		local pl = player.GetByUniqueID( trace.Entity:GetTable().owner )
		if(pl == false or not pl:GetNWBool("warrant") == true)then
			self.Owner:PrintMessage(4, pl:Name().." does not have a warrant!")
			return;
		end
	end
	self.Owner:EmitSound( self.Sound );
	trace.Entity:Fire( "unlock", "", .5 )
	trace.Entity:Fire( "open", "", .6 )
	trace.Entity:Fire( "door_open", "", .6)
	self.Owner:ViewPunch( Angle( -10, math.random( -5, 5 ), 0 ) );
	self.Weapon:SetNextPrimaryFire( CurTime() + 5 );
	
end

