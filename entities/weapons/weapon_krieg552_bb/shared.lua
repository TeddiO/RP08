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
	SWEP.SlotPos			= 2
	SWEP.IconLetter			= "A"
	
	killicon.AddFont("weapon_krieg552_phx","CSKillIcons",SWEP.IconLetter,Color(255,80,0,255))
	SWEP.DrawWeaponInfoBox  = true
	
end

SWEP.Base			= "rg_base"
SWEP.Category   	= "[BB]RP Sweps"

------------
-- Info --
------------
SWEP.PrintName		= "Krieg 550"
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
SWEP.HoldType 			= "ar2"
SWEP.FiresUnderwater 	= true
SWEP.HasLaser			= false
SWEP.HasSilencer		= false
SWEP.SilencerTime		= 2.1

----------------------
-- Primary Fire --
----------------------
SWEP.Primary.Sound			= Sound("Weapon_SG550.Single") -- SOUND
SWEP.Primary.RegularSound	= Sound("Weapon_SG550.Single")
SWEP.Primary.SilencedSound	= Sound("Weapon_M4A1.Silenced")

SWEP.Primary.Damage			= 34
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
SWEP.RecoverTime 	= 1

SWEP.MinSpread		= 0.009
SWEP.MaxSpread		= 0.5
SWEP.DeltaSpread	= 0.027

SWEP.MinRecoil		= 0.9--0.2
SWEP.MaxRecoil		= 3--3
SWEP.DeltaRecoil	= 1.3--0.2

/*---------------------------------------------------------
Deploy
---------------------------------------------------------*/
function SWEP:Deploy()
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )

	self:SetIronsights( false )

	self.Weapon:SetNextPrimaryFire(CurTime() + 1)

	ShotgunReloading = false
	self.Weapon:SetNetworkedBool( "reloading", false)

	return true
end


---------------------------
-- Ironsight/Scope --
---------------------------

SWEP.IronSightsPos = Vector (6.6578, -11.6345, 2.6682)
SWEP.IronSightsAng = Vector (1.0305, 0.6769, -0.1381)
SWEP.IronSightZoom			= 1
SWEP.UseScope				= true
SWEP.ScopeScale 			= 0.4
SWEP.ScopeZooms				= {2,4}
SWEP.DrawSniperSights		= false
SWEP.DrawRifleSights		= true

-------------------------
-- Effects/Visual --
-------------------------
SWEP.ViewModel			= "models/weapons/v_snip_sg550.mdl"
SWEP.WorldModel			= "models/weapons/w_snip_sg550.mdl"

SWEP.MuzzleEffect			= "rg_muzzle_rifle"
-- Available muzzle effects: rg_muzzle_grenade, rg_muzzle_highcal, rg_muzzle_hmg, rg_muzzle_pistol, rg_muzzle_rifle, rg_muzzle_silenced, none

SWEP.ShellEffect			= "rg_shelleject_rifle"
-- Available shell eject effects: rg_shelleject, rg_shelleject_rifle, rg_shelleject_shotgun, none

SWEP.MuzzleAttachment		= "1" 
SWEP.ShellEjectAttachment	= "2" 


-------------------
-- Modifiers --
-------------------
SWEP.CrouchModifier		= 0.75
SWEP.IronSightModifier 	= 0.5
SWEP.RunModifier 		= 4
SWEP.JumpModifier 		= 6


--------------------
-- Fire Modes --
--------------------
SWEP.AvailableFireModes		= {"Auto","Semi"} -- TYPES

SWEP.AutoRPM				= 700
SWEP.SemiRPM				= 600
SWEP.DrawFireModes			= true 


-----------------------------26859799710999--
