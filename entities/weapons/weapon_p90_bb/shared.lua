

if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.HasCrossHair		= false
		
	SWEP.Slot				= 2
	SWEP.SlotPos			= 2
	SWEP.IconLetter			= "m"
	
	killicon.AddFont("weapon_p90_phx","CSKillIcons",SWEP.IconLetter,Color(255,80,0,255))
	SWEP.DrawWeaponInfoBox  = true
	
end

SWEP.Base			= "rg_base"
SWEP.Category   	= "[BB]RP Sweps"

------------
-- Info --
------------
SWEP.PrintName		= "P90"	
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
SWEP.SilencerTime		= 3

----------------------
-- Primary Fire --
----------------------
SWEP.Primary.Sound			= Sound( "Weapon_P90.Single" )
SWEP.Primary.RegularSound	= Sound("Weapon_P90.Single")
SWEP.Primary.SilencedSound	= Sound("Weapon_USP.SilencedShot")
SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 50
SWEP.Primary.DefaultClip	= 50
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

SWEP.MinSpread		= 0.06
SWEP.MaxSpread		= 0.25
SWEP.DeltaSpread	= 0.02

SWEP.MinRecoil		= 0.85--0.2
SWEP.MaxRecoil		= 3--3
SWEP.DeltaRecoil	= 1.2--0.2


---------------------------
-- Ironsight/Scope --
---------------------------


SWEP.IronSightsPos = Vector (4.6268, -5.3132, 1.7015)
SWEP.IronSightsAng = Vector (0.4541, -0.29, 0.1788)
SWEP.IronSightZoom			= 1.5
SWEP.UseScope				= false
SWEP.ScopeScale 			= 0.4
SWEP.ScopeZooms				= {4,8}
SWEP.DrawSniperSights		= false
SWEP.DrawRifleSights		= true

-------------------------
-- Effects/Visual --
-------------------------
SWEP.ViewModel			= "models/weapons/v_smg_p90.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_p90.mdl"

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
SWEP.CrouchModifier		= 0.75
SWEP.IronSightModifier 	= 0.5
SWEP.RunModifier 		= 4
SWEP.JumpModifier 		= 6


--------------------
-- Fire Modes --
--------------------
SWEP.AvailableFireModes		= {"Auto","Semi"}

SWEP.SemiRPM				= 1000
SWEP.AutoRPM				= 900
SWEP.DrawFireModes			= true 
