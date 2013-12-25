

if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.HasCrossHair		= true
		
	SWEP.Slot				= 4
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "k"
	SWEP.DrawWeaponInfoBox  = true
	
end

SWEP.Base			= "rg_base"
SWEP.Category   	= "[BB]RP Sweps"

------------
-- Info --
------------
SWEP.PrintName		= "Pump Shotgun"	
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
SWEP.FiresUnderwater 	= false
SWEP.HasLaser			= false
SWEP.HasSilencer		= false

----------------------
-- Primary Fire --
----------------------
SWEP.Primary.Sound			= Sound( "Weapon_M3.Single" )
SWEP.Primary.Damage			= 30
SWEP.Primary.Delay 		    = 0
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Ammo			= "buckshot"


---------------------------------------
-- Recoil, Spread, and Spray --
---------------------------------------
SWEP.RecoverTime 	= 1

SWEP.MinSpread		= 0.01
SWEP.MaxSpread		= 0.05
SWEP.DeltaSpread	= 0.01

SWEP.MinRecoil		= 1--0.2
SWEP.MaxRecoil		= 10--3
SWEP.DeltaRecoil	= 1--0.2

SWEP.MinSpray		= 0
SWEP.MaxSpray		= 2
SWEP.DeltaSpray		= 0.25

local ShotgunReloading
ShotgunReloading = false

---------------------------
-- Ironsight/Scope --
---------------------------
SWEP.IronSightsPos 		= Vector (5.7431, -1.6786, 3.3682)
SWEP.IronSightsAng 		= Vector (0.0634, -0.0235, 0)
SWEP.IronSightZoom			= 1.5
SWEP.UseScope				= false
SWEP.ScopeScale 			= 0.4
SWEP.ScopeZooms				= {4,8}
SWEP.DrawSniperSights		= false
SWEP.DrawRifleSights		= false

-------------------------
-- Effects/Visual --
-------------------------
SWEP.ViewModel			= "models/weapons/v_shot_m3super90.mdl"
SWEP.WorldModel			= "models/weapons/w_shot_m3super90.mdl"

SWEP.MuzzleEffect			= "rg_muzzle_highcal"
-- Available muzzle effects: rg_muzzle_grenade, rg_muzzle_highcal, rg_muzzle_hmg, rg_muzzle_pistol, rg_muzzle_rifle, rg_muzzle_silenced, none

SWEP.ShellEffect			= "rg_shelleject_shotgun"
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

	self.Weapon:SetNetworkedBool( "reloading", false)

	return true
end


-------------------
-- Modifiers --
-------------------
SWEP.CrouchModifier		= 0.75
SWEP.IronSightModifier 	= 0.5
SWEP.RunModifier 		= 1.5
SWEP.JumpModifier 		= 2 


--------------------
-- Fire Modes --
--------------------
SWEP.AvailableFireModes		= {"UnderWaterShotgun"}


SWEP.AutoRPM				= 600
SWEP.SemiRPM				= 400
SWEP.DrawFireModes			= false



/*---------------------------------------------------------
	Reload does nothing
---------------------------------------------------------*/
function SWEP:Reload()

	if ( self.Reloadaftershoot > CurTime() ) then return end

	self:SetIronsights(false)

	if (self.Weapon:GetNWBool("reloading", false)) or ShotgunReloading then return end

	if (self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
			ShotgunReloading = true
			self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
			self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)
			self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		timer.Simple(0.3, function()
			ShotgunReloading = false
			self.Weapon:SetNetworkedBool("reloading", true)
			self.Weapon:SetVar("reloadtimer", CurTime() + 1)
			self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
			self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)
		end)
	end
end
/*---------------------------------------------------------
   Think does nothing
---------------------------------------------------------*/
function SWEP:Think()


	if ( self.Weapon:GetNetworkedBool( "reloading", false ) ) then
	
		if ( self.Weapon:GetVar( "reloadtimer", 0 ) < CurTime() ) then
			
			// Finsished reload -
			if ( self.Weapon:Clip1() >= self.Primary.ClipSize || self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then
				self.Weapon:SetNetworkedBool( "reloading", false )
				return
			end
			
			// Next cycle
			self.Weapon:SetVar( "reloadtimer", CurTime() + 0.3 )
			self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
			
			// Add ammo
			self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
			self.Weapon:SetClip1(  self.Weapon:Clip1() + 1 )
			
			// Finish filling, final pump
			if ( self.Weapon:Clip1() >= self.Primary.ClipSize || self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then
				self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
			else
			
			end
			
		end
	
	end



if !self.Owner:KeyDown(IN_USE) then 

	if self.Owner:KeyPressed(IN_ATTACK2) then
		self:SetIronsights(true)
		self.Owner:SetNetworkedInt("ScopeLevel", 1)
		if CLIENT then return end
 	end
end

	if self.Owner:KeyReleased(IN_ATTACK2) then
		self:SetIronsights(false)
		self.Owner:SetNetworkedInt("ScopeLevel", 0)
		if CLIENT then return end
	end

	if self.Owner:KeyPressed(IN_ATTACK) and (self.Weapon:GetNWBool("reloading", true)) then
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
		self.Weapon:SetNetworkedBool( "reloading", false)
		self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
	end
end



---------------------------------------------
-- Firemode: UnderWaterShotgun --
---------------------------------------------
SWEP.FireModes = {}

SWEP.FireModes.UnderWaterShotgun = {}

SWEP.UWShotgunRPM 								= 175
SWEP.FireModes.UnderWaterShotgun.NumBullets 	= 20

SWEP.FireModes.UnderWaterShotgun.FireFunction = function(self)

	if not self:CanFire(self.Weapon:Clip1()) then return end 
	
	if not self.OwnerIsNPC then
		self:TakePrimaryAmmo(1) 
	end
	
	local pcStart = self.Owner:GetShootPos()
	local pcForw = self.Owner:GetAimVector()
	local pctrace = {} 
	pctrace.start = pcStart
	pctrace.endpos = pcStart + (pcForw * 1000)
	pctrace.filter = self.Owner 
	local traz = util.TraceLine( pctrace )
	
	if traz.Hit then
		self:RGShootBulletCheap(
		15, 											--Damage per shot
		self.BulletSpeed, 								--Speed of the bullet (this variable is derived from self.MuzzleVelocity)
		0.075, 											-- Bullet Spread
		0, 												-- Bullet Spray
		Vector(0,0,0),									-- Vector corresponding to the direction the gun is currently spraying ("SprayVec")
		self.FireModes.UnderWaterShotgun.NumBullets)
	else
		self:RGShootBullet(
		15, 											--Damage per shot
		self.BulletSpeed, 								--Speed of the bullet (this variable is derived from self.MuzzleVelocity)
		0.075, 											-- Bullet Spread
		0, 												-- Bullet Spray
		Vector(0,0,0),									-- Vector corresponding to the direction the gun is currently spraying ("SprayVec")
		self.FireModes.UnderWaterShotgun.NumBullets)	-- How many bullets to fire
	end
	
	self:ApplyRecoil(
	6,						-- Recoil
	1)						-- Spray
	
	self.Weapon:EmitSound(self.Primary.Sound)
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 1 )

	self:ShootEffects()

end

SWEP.FireModes.UnderWaterShotgun.InitFunction = function(self)


	self.Primary.Automatic = false 
	self.Primary.Delay = 60/self.UWShotgunRPM 
	
	self.FiresUnderwater = true 
	self.ShellEffect			= "rg_muzzle_highcal"
	self.MuzzleEffect			= "rg_shelleject_shotgun"
	self.Primary.Sound			= Sound( "Weapon_M3.Single" )
	
	if CLIENT then
		self.FireModeDrawTable.x = 0.037*surface.ScreenWidth()
		self.FireModeDrawTable.y = 0.952*surface.ScreenHeight()
	end

end

SWEP.FireModes.UnderWaterShotgun.RevertFunction = function(self) 

	self.FiresUnderwater = false
	
	self.ShellEffect			= "rg_muzzle_highcal"
	self.MuzzleEffect			= "rg_shelleject_shotgun"
	self.Primary.Sound			= Sound( "Weapon_M3.Single" )

end

SWEP.FireModes.UnderWaterShotgun.HUDDrawFunction = function(self)

	surface.SetFont("rg_firemode")
	surface.SetTextPos(self.FireModeDrawTable.x,self.FireModeDrawTable.y) 
	surface.SetTextColor(255,220,0,200) 
	surface.DrawText("s")

end
