

if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.HasCrossHair		= true
		
	SWEP.Slot				= 1
	SWEP.SlotPos			= 5
	SWEP.IconLetter			= "c"
	SWEP.DrawWeaponInfoBox  = true
	
end

SWEP.Base			= "biff_base"
SWEP.Category   	= "[BB]RP Sweps"

------------
-- Info --
------------
SWEP.PrintName		= "USP"
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
SWEP.HasLaser			= true
SWEP.HasSilencer2		= true

----------------------
-- Primary Fire --
----------------------
SWEP.Primary.Sound			= Sound( "Weapon_usp.Single" )
SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 24
SWEP.Primary.DefaultClip	= 24
SWEP.Primary.Ammo			= "pistol"


-------------------------
-- Secondary Fire --
-------------------------
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1


---------------------------------------
-- Recoil, Spread, and Spray --
---------------------------------------
SWEP.RecoverTime 	= 0.2

SWEP.MinSpread		= 0.14
SWEP.MaxSpread		= 0.18
SWEP.DeltaSpread	= 0.118

SWEP.MinRecoil		= 1--0.7
SWEP.MaxRecoil		= 10--7
SWEP.DeltaRecoil	= 1--0.5

SWEP.MinSpray		= 0
SWEP.MaxSpray		= 6
SWEP.DeltaSpray		= 0.55


---------------------------
-- Ironsight/Scope --
---------------------------
SWEP.IronSightsPos = Vector (4.3502, -1.9511, 2.7908)
SWEP.IronSightsAng = Vector (0.7516, 0.0252, 0)
SWEP.IronSightZoom			= 1.5
SWEP.UseScope				= false
SWEP.ScopeScale 			= 0.4
SWEP.ScopeZooms				= {4,8}
SWEP.DrawSniperSights		= false
SWEP.DrawRifleSights		= false

-------------------------
-- Effects/Visual --
-------------------------
SWEP.ViewModel			= "models/weapons/v_pist_usp.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_usp.mdl"

SWEP.MuzzleEffect			= "rg_muzzle_pistol"
-- Available muzzle effects: rg_muzzle_grenade, rg_muzzle_highcal, rg_muzzle_hmg, rg_muzzle_pistol, rg_muzzle_rifle, rg_muzzle_silenced, none

SWEP.ShellEffect			= "rg_shelleject"
-- Available shell eject effects: rg_shelleject, rg_shelleject_rifle, rg_shelleject_shotgun, none

SWEP.MuzzleAttachment		= "1" 
SWEP.ShellEjectAttachment	= "2" 


-------------------
-- Modifiers --
-------------------
SWEP.CrouchModifier		= 0.9
SWEP.IronSightModifier 	= 0.1
SWEP.RunModifier 		= 2.5
SWEP.JumpModifier 		= 2 

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

--------------------
-- Fire Modes --
--------------------
SWEP.AvailableFireModes		= {"Semi"}

SWEP.SemiRPM				= 3250
SWEP.DrawFireModes			= true 


