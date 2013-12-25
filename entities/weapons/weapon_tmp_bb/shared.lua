

if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.HasCrossHair		= true
		
	SWEP.Slot				= 2
	SWEP.SlotPos			= 3
	SWEP.IconLetter			= "d"
	SWEP.DrawWeaponInfoBox  = true
	
end

SWEP.Base			= "rg_base"
SWEP.Category   	= "[BB]RP Sweps"

------------
-- Info --
------------
SWEP.PrintName		= "TMP"	
SWEP.Author			= "PC Camp"
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
SWEP.HoldType 			= "ar2"
SWEP.FiresUnderwater 	= false
SWEP.HasLaser			= false
SWEP.HasSilencer		= false

----------------------
-- Primary Fire --
----------------------
SWEP.Primary.Sound			= Sound( "Weapon_tmp.Single" )
SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Ammo			= "smg1"


-------------------------
-- Secondary Fire --
-------------------------
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1


---------------------------------------
-- Recoil, Spread, and Spray --
---------------------------------------
SWEP.RecoverTime 	= 0.55

SWEP.MinSpread		= 0.005
SWEP.MaxSpread		= 0.05
SWEP.DeltaSpread	= 0.0065

SWEP.MinRecoil		= 1--0.2
SWEP.MaxRecoil		= 10--3
SWEP.DeltaRecoil	= 1--0.2

SWEP.MinSpray		= 0
SWEP.MaxSpray		= 2
SWEP.DeltaSpray		= 0.25


---------------------------
-- Ironsight/Scope --
---------------------------
SWEP.IronSightsPos = Vector (5.2231, -3.7665, 2.5455)
SWEP.IronSightsAng = Vector (0.6057, -0.1558, 0)
SWEP.IronSightZoom			= 1
SWEP.UseScope				= false
SWEP.ScopeScale 			= 0.4
SWEP.ScopeZooms				= {4,8}
SWEP.DrawSniperSights		= false
SWEP.DrawRifleSights		= false

-------------------------
-- Effects/Visual --
-------------------------
SWEP.ViewModel			= "models/weapons/v_smg_tmp.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_tmp.mdl"

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
SWEP.AvailableFireModes		= {"Auto"}

SWEP.AutoRPM				= 900
SWEP.DrawFireModes			= false 
