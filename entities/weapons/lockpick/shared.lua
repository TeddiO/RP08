SWEP.PrintName = "A Lockpick";
SWEP.DrawWeaponInfoBox = false
SWEP.Slot = 4;
SWEP.SlotPos = 1;
SWEP.DrawAmmo = false;
SWEP.DrawCrosshair = false;

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel = Model( "models/weapons/v_crowbar.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_crowbar.mdl" )


function SWEP:Initialize()

	self:SetWeaponHoldType( "Crowbar" );
	
	util.PrecacheSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
	util.PrecacheSound("weapons/iceaxe/iceaxe_swing1.wav")
end


SWEP.Sound = Sound( "physics/wood/wood_box_impact_hard3.wav" );

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= -1				// Size of a clip
SWEP.Secondary.DefaultClip	= -1				// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""


function SWEP:PrimaryAttack()

	if not(self.Owner:Team() == 5)then
		self.Owner:Kill()
		return
	end
	
self.Weapon:SetNextPrimaryFire(CurTime() + .4)

local trace = self.Owner:GetEyeTrace()
local bullet = {}
	bullet.Num    = 1
	bullet.Src    = self.Owner:GetShootPos()
	bullet.Dir    = self.Owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = 1
	bullet.Damage = 0
	
if (trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 and not trace.Entity:IsDoor()) then
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	self.Owner:FireBullets(bullet) 
	self.Weapon:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
	
elseif (trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 and trace.Entity:IsDoor() and trace.Entity:IsValid()) then
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	self.Owner:FireBullets(bullet) 
	self.Weapon:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random( 3, 5 ) .. ".wav")
	
	if(trace.Entity:GetTable().unlockAmount == nil) then
		trace.Entity:GetTable().unlockAmount = 1
	elseif(trace.Entity:GetTable().unlockAmount < 6) then
		if (string.lower(trace.Entity:GetNWString("title")) == "nexus") then
			trace.Entity:GetTable().unlockAmount = trace.Entity:GetTable().unlockAmount + 0.25
		else
			trace.Entity:GetTable().unlockAmount = trace.Entity:GetTable().unlockAmount + 0.5
		end
	else
	if (SERVER) then
		trace.Entity:GetTable().unlockAmount = nil
		trace.Entity:Fire( "unlock", "", .5 )
		if (trace.Entity:GetClass() == "prop_dynamic") then
			trace.Entity:Fire("setanimation","open","0")
			trace.Entity:Fire("setanimation","close",5)
		else
			trace.Entity:Fire( "open", "", .6 )
			end
		end
		self.Weapon:SetNextPrimaryFire(CurTime() + 3)
	end
else
	self.Weapon:EmitSound("weapons/iceaxe/iceaxe_swing1.wav")
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)

end
end

