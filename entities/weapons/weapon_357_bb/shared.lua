

if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= true
	SWEP.HasCrossHair		= true
	SWEP.AnimPrefix		=	 "357"	
	SWEP.Slot				= 1
	SWEP.SlotPos			= 5
	SWEP.DrawWeaponInfoBox  = true
	
end

SWEP.Base			= "rg_base"
SWEP.Category   	= "[BB]RP Sweps"

------------
-- Info --
------------
SWEP.PrintName		= "357"	
SWEP.Author			= "Biff Johnston"
SWEP.Purpose		= ""
SWEP.Instructions	= ""


-------------
-- Misc. --
-------------
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType 			= "pistol"
SWEP.FiresUnderwater 	= false
SWEP.HasSilencer		= false
SWEP.HasLaser			= false
SWEP.ViewModelFOV		= 62
SWEP.IconLetter			= "C"

----------------------
-- Primary Fire --
----------------------
SWEP.Primary.Sound			= Sound("weapons/357/357_fire2.wav")
SWEP.Primary.Damage			= 75
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Ammo			= "357"


-------------------------
-- Secondary Fire --
-------------------------
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1


---------------------------------------
-- Recoil, Spread, and Spray --
---------------------------------------
SWEP.RecoverTime 	= 0.7

SWEP.MinSpread		= 0.02
SWEP.MaxSpread		= 0.15
SWEP.DeltaSpread	= 0.03

SWEP.MinRecoil		= 9.5--1.2
SWEP.MaxRecoil		= 23--3
SWEP.DeltaRecoil	= 10--2.2

SWEP.MinSpray		= 0
SWEP.MaxSpray		= 2
SWEP.DeltaSpray		= 0.25


---------------------------
-- Ironsight/Scope --
---------------------------
SWEP.IronSightsPos = Vector (-5.6846, -7.4005, 2.5943)
SWEP.IronSightsAng = Vector (0.3052, -0.283, 1.0618)
SWEP.IronSightZoom			= 1.5
SWEP.UseScope				= false
SWEP.ScopeScale 			= 0.4
SWEP.ScopeZooms				= {4,8}
SWEP.DrawSniperSights		= false
SWEP.DrawRifleSights		= false

-------------------------
-- Effects/Visual --
-------------------------
SWEP.ViewModel			= "models/weapons/v_357.mdl"
SWEP.WorldModel			= "models/weapons/w_357.mdl"

SWEP.MuzzleEffect			= "rg_muzzle_pistol"
-- Available muzzle effects: rg_muzzle_grenade, rg_muzzle_highcal, rg_muzzle_hmg, rg_muzzle_pistol, rg_muzzle_rifle, rg_muzzle_silenced, none

SWEP.ShellEffect			= "rg_shelleject"
-- Available shell eject effects: rg_shelleject, rg_shelleject_rifle, rg_shelleject_shotgun, none

SWEP.MuzzleAttachment		= "1" 
SWEP.ShellEjectAttachment	= "2" 

/*---------------------------------------------------------
Deploy
---------------------------------------------------------*/
function SWEP:Deploy()
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	-- Set the deploy animation when deploying

	self:SetIronsights( false )
	-- Set the ironsight mod to false

	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	-- Set the next primary fire to 1 second after deploying

	ShotgunReloading = false
	self.Weapon:SetNetworkedBool( "reloading", false)

	return true
end

-------------------
-- Modifiers --
-------------------
SWEP.CrouchModifier		= 0.7
SWEP.IronSightModifier 	= 0.4
SWEP.RunModifier 		= 1.5
SWEP.JumpModifier 		= 2 


--------------------
-- Fire Modes --
--------------------
SWEP.AvailableFireModes		= {"Semi"}

SWEP.SemiRPM				= 55
SWEP.DrawFireModes			= false 
