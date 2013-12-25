

if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.HasCrossHair		= true
		
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "w"
	SWEP.DrawWeaponInfoBox  = true
	
end

SWEP.Base			= "rg_base"
SWEP.Category   	= "[BB]RP Sweps"

------------
-- Info --
------------
SWEP.PrintName		= "M4A1"
SWEP.Author			= "Biff Johnston"
SWEP.Purpose		= ""
SWEP.Instructions	= "Hold your use key and press secondary fire to change fire modes.\nHold your use key and press primary fire to apply silencer."


-------------
-- Misc. --
-------------
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType 			= "ar2"
SWEP.FiresUnderwater 	= true
SWEP.HasLaser			= true
SWEP.HasSilencer		= true

----------------------
-- Primary Fire --
----------------------
SWEP.Primary.Sound			= Sound("Weapon_M4A1.Single")
SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Ammo			= "smg1"


-------------------------
-- Secondary Fire --
-------------------------
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1


---------------------------------------
-- Recoil, Spread, and Spray --
---------------------------------------
SWEP.RecoverTime 	= 0.7

SWEP.MinSpread		= 0.005
SWEP.MaxSpread		= 0.04
SWEP.DeltaSpread	= 0.005

SWEP.MinRecoil		= 1--0.2
SWEP.MaxRecoil		= 5--3
SWEP.DeltaRecoil	= 0.75--0.2

SWEP.MinSpray		= 0
SWEP.MaxSpray		= 2
SWEP.DeltaSpray		= 0.2

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



SWEP.IronSightsPos = Vector (5.9794, -3.7796, 0.8671)
SWEP.IronSightsAng = Vector (3.5938, 1.9852, 3.9263)

SWEP.IronSightZoom			= 1.5
SWEP.UseScope				= false
SWEP.ScopeScale 			= 0.4
SWEP.ScopeZooms				= {4,8}
SWEP.DrawSniperSights		= false
SWEP.DrawRifleSights		= true

-------------------------
-- Effects/Visual --
-------------------------
SWEP.ViewModel			= "models/weapons/v_rif_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"

SWEP.MuzzleEffect			= "rg_muzzle_rifle"
-- Available muzzle effects: rg_muzzle_grenade, rg_muzzle_highcal, rg_muzzle_hmg, rg_muzzle_pistol, rg_muzzle_rifle, rg_muzzle_silenced, none

SWEP.ShellEffect			= "rg_shelleject_rifle"
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
SWEP.AvailableFireModes		= {"Auto","Burst","Semi"}

SWEP.AutoRPM				= 750
SWEP.SemiRPM				= 700
SWEP.BurstRPM				= 850
SWEP.DrawFireModes			= true 

