

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

SWEP.Base			= "rg_base"
SWEP.Category   	= "[BB]RP Sweps"

------------
-- Info --
------------
SWEP.PrintName		= "Glock"
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
SWEP.HasLaser			= false
SWEP.HasSilencer		= false

----------------------
-- Primary Fire --
----------------------
SWEP.Primary.Sound			= Sound( "Weapon_Glock.Single" )
SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 16
SWEP.Primary.DefaultClip	= 16
SWEP.Primary.Ammo			= "pistol"


-------------------------
-- Secondary Fire --
-------------------------
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1


---------------------------------------
-- Recoil, Spread, and Spray --
---------------------------------------
SWEP.RecoverTime 	= 0.6

SWEP.MinSpread		= 0.02
SWEP.MaxSpread		= 0.05
SWEP.DeltaSpread	= 0.012

SWEP.MinRecoil		= 1--0.2
SWEP.MaxRecoil		= 10--3
SWEP.DeltaRecoil	= 1--0.2

SWEP.MinSpray		= 0
SWEP.MaxSpray		= 2
SWEP.DeltaSpray		= 0.25

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
SWEP.ViewModel			= "models/weapons/v_pist_glock18.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_glock18.mdl"

SWEP.MuzzleEffect			= "rg_muzzle_pistol"
-- Available muzzle effects: rg_muzzle_grenade, rg_muzzle_highcal, rg_muzzle_hmg, rg_muzzle_pistol, rg_muzzle_rifle, rg_muzzle_silenced, none

SWEP.ShellEffect			= "rg_shelleject"
-- Available shell eject effects: rg_shelleject, rg_shelleject_rifle, rg_shelleject_shotgun, none

SWEP.MuzzleAttachment		= "1" 
SWEP.ShellEjectAttachment	= "2" 


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
SWEP.AvailableFireModes		= {"Semi", "Burst"}

SWEP.BurstRPM				= 600
SWEP.SemiRPM				= 400
SWEP.DrawFireModes			= true 
