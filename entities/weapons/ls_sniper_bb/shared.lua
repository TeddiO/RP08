

if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.HasCrossHair		= false
		
	SWEP.Slot				= 5
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "n"
	SWEP.DrawWeaponInfoBox  = true
	
end

SWEP.Base			= "rg_base"
SWEP.Category   	= "[BB]RP Sweps"

------------
-- Info --
------------
SWEP.PrintName		= "Sniper Rifle"	
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
SWEP.HoldType 			= "smg"
SWEP.FiresUnderwater 	= false
SWEP.HasLaser			= true
SWEP.HasSilencer		= false

----------------------
-- Primary Fire --
----------------------
SWEP.Primary.Sound			= Sound( "weapons/awp/awp1.wav" )
SWEP.Primary.Damage			= 90
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Ammo			= "smg1"


-------------------------
-- Secondary Fire --
-------------------------
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1


---------------------------------------
-- Recoil, Spread, and Spray --
---------------------------------------
SWEP.RecoverTime 	= 1

SWEP.MinSpread		= 0.5
SWEP.MaxSpread		= 5
SWEP.DeltaSpread	= 0.5

SWEP.MinRecoil		= 5--0.2
SWEP.MaxRecoil		= 10--3
SWEP.DeltaRecoil	= 2--0.2

SWEP.MinSpray		= 0
SWEP.MaxSpray		= 2
SWEP.DeltaSpray		= 0.5


---------------------------
-- Ironsight/Scope --
---------------------------

SWEP.IronSightsPos = Vector (5.5082, -6.7323, 2.1361)
SWEP.IronSightsAng = Vector (-1.3812, -0.2537, -0.0094)
SWEP.IronSightZoom			= 1
SWEP.UseScope				= true
SWEP.ScopeScale 			= 0.4
SWEP.ScopeZooms				= {5,15}
SWEP.DrawSniperSights		= true
SWEP.DrawRifleSights		= false

-------------------------
-- Effects/Visual --
-------------------------
SWEP.ViewModel			= "models/weapons/v_snip_awp.mdl" 
SWEP.WorldModel			= "models/weapons/w_snip_awp.mdl" 

SWEP.MuzzleEffect			= "rg_muzzle_highcal"
-- Available muzzle effects: rg_muzzle_grenade, rg_muzzle_highcal, rg_muzzle_hmg, rg_muzzle_pistol, rg_muzzle_rifle, rg_muzzle_silenced, none

SWEP.ShellEffect			= "rg_shelleject_rifle"
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
SWEP.CrouchModifier		= 0.75
SWEP.IronSightModifier 	= 0
SWEP.RunModifier 		= 1.5
SWEP.JumpModifier 		= 2 


--------------------
-- Fire Modes --
--------------------
SWEP.AvailableFireModes		= {"Semi"}

SWEP.SemiRPM				= 60
SWEP.DrawFireModes			= false 
