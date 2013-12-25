

if( SERVER ) then

	AddCSLuaFile( "shared.lua" );

end

if( CLIENT ) then

	SWEP.PrintName = "Stunstick";
	SWEP.Slot = 1;
	SWEP.SlotPos = 3;
	SWEP.DrawAmmo = false;
	SWEP.DrawCrosshair = false;

end

// Variables that are used on both client and server

SWEP.Author			= "[BB]"
SWEP.Instructions	= "Left Click to Stun \n Rick CLick to KnockOut"
SWEP.Contact		= "http://bbroleplay.co.uk"
SWEP.Purpose		= "Securing your property"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.AnimPrefix		= "stunstick"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.NextStrike = 0;
  
SWEP.ViewModel = Model( "models/weapons/v_stunstick.mdl" );
SWEP.WorldModel = Model( "models/weapons/w_stunbaton.mdl" );
  
SWEP.Sound = Sound( "weapons/stunstick/stunstick_swing1.wav" );
  
SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= -1				// Size of a clip
SWEP.Secondary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""

SWEP.StartFlashSize			= 1
SWEP.HitFlashSize			= 3
SWEP.NextWarning			= 0
SWEP.IdleSounds				= {
	"keep moving",
	"lookin for trouble?",
	"prepare to receive civil judgement",
	"ready to amputate",
	"second warning",
	"move",
	"move along",
}
SWEP.WalkSounds				= {
	"first warning, move away",
	"i said move along",
	"move back right now",
	"move it",
}
SWEP.RunSounds				= {
	"destroy that cover",
	"don't move",
	"hold it",
	"hold it right there",
}



/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()

	self:SetWeaponHoldType( "melee" );
	

	
	self.Hit = { 
	Sound( "weapons/stunstick/stunstick_impact1.wav" ),
  	Sound( "weapons/stunstick/stunstick_impact2.wav" ) };
	
	self.FleshHit = {
  	Sound( "weapons/stunstick/stunstick_fleshhit1.wav" ),
  	Sound( "weapons/stunstick/stunstick_fleshhit2.wav" ) };
	
	

end


/*---------------------------------------------------------
   Name: SWEP:Precache( )
   Desc: Use this function to precache stuff
---------------------------------------------------------*/
function SWEP:Precache()
end

function SWEP:DoFlash( ply )

	umsg.Start( "StunStickFlash", ply ); umsg.End();

end


function SWEP:Deploy()
	function DoTheseEffects()
		local evect = EffectData()
			evect:SetEntity(self.Weapon)
			evect:SetMagnitude(self.StartFlashSize * 10)
			evect:SetScale(self.StartFlashSize * 10)
			evect:SetRadius(self.StartFlashSize * 10)
		util.Effect("TeslaHitBoxes", evect)
		self.StartFlashSize = self.StartFlashSize + 1
	end
	timer.Create( "StunFlashes", 0.2, 3, DoTheseEffects )
	timer.Simple( 0.7, function() self.StartFlashSize = 1 end )
	self.Weapon:EmitSound("ambient/energy/zap"..math.random(1,3)..".wav")
end


/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
  
  	if not(self.Owner:Team() == 2 or self.Owner:Team() == 3 or self.Owner:Team() == 9)then
		self.Owner:Kill()
		return
	end
  
  	if( CurTime() < self.NextStrike ) then return; end
 
	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	self.Weapon:EmitSound( self.Sound );
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER );

	self.NextStrike = ( CurTime() + .3 );

 	local trace = self.Owner:GetEyeTrace();

 	if( not trace.Entity:IsValid() ) then
 		return;
	end
	
	--[[if( self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 100 ) then
		return;
	end]]
	
	local pcStart = self.Owner:GetShootPos()
	local pcForw = self.Owner:GetAimVector()
	local pctrace = {} 
	pctrace.start = pcStart
	pctrace.endpos = pcStart + (pcForw * 100)
	pctrace.filter = self.Owner 
	local traz = util.TraceLine( pctrace )
	
	timer.Simple( 0.1, function()
	if traz.Hit then
	
		if( SERVER ) then
			
			local rnd = math.random(1,99999)
			local TS = ents.Create("info_target")
				TS:SetPos( self.Weapon:GetAttachment( 1 ).Pos )
				TS:SetName("TS"..rnd)
			local TE = ents.Create("info_target" )
				TE:SetPos(traz.HitPos)
				TE:SetName("TE"..rnd)
			local TB = ents.Create("env_beam")
				TB:SetKeyValue("texture", "sprites/physcannon_bluelight1b.vtf")
				TB:SetKeyValue("renderamt", 255)
				TB:SetKeyValue("rendercolor", "255 255 255")
				TB:SetKeyValue("life", 0.1)
				TB:SetKeyValue("damage", 0)
				TB:SetKeyValue("LightningStart", "TS"..rnd)
				TB:SetKeyValue("LightningEnd", "TE"..rnd)
				TB:SetKeyValue("spawnflags", 1)
				TB:SetKeyValue("TouchType", 0)
				TB:SetKeyValue("framestart", 0)
				TB:SetKeyValue("framerate", 0)
				TB:SetKeyValue("NoiseAmplitude", 8)
				TB:SetKeyValue("TextureScroll", 35)
				TB:SetKeyValue("BoltWidth", 3)
				TB:SetKeyValue("Radius", 256)
				TB:SetKeyValue("StrikeTime", 1)
			local TB2 = ents.Create("env_beam")
				TB2:SetKeyValue("texture", "sprites/physcannon_bluelight1b.vtf")
				TB2:SetKeyValue("renderamt", 255)
				TB2:SetKeyValue("rendercolor", "255 255 255")
				TB2:SetKeyValue("life", 0.1)
				TB2:SetKeyValue("damage", 0)
				TB2:SetKeyValue("LightningStart", "TS"..rnd)
				TB2:SetKeyValue("LightningEnd", "TE"..rnd)
				TB2:SetKeyValue("spawnflags", 1)
				TB2:SetKeyValue("TouchType", 0)
				TB2:SetKeyValue("framestart", 0)
				TB2:SetKeyValue("framerate", 0)
				TB2:SetKeyValue("NoiseAmplitude", 3)
				TB2:SetKeyValue("TextureScroll", 35)
				TB2:SetKeyValue("BoltWidth", 8)
				TB2:SetKeyValue("Radius", 256)
				TB2:SetKeyValue("StrikeTime", 1)
				TS:Spawn()
				TE:Spawn()
				TB:Spawn()
				TB2:Spawn()
				TB:Fire("turnon","","")
				TB2:Fire("turnon","","")
				TB:Fire("kill","",0.1)
				TB2:Fire("kill", "", 0.1)
				TE:Fire("kill", "", 0.1)
				TS:Fire("kill", "", 0.1)
				
			if( traz.Entity:IsPlayer() ) then
				local hp = traz.Entity:Health();
				hp = hp - math.random( 12, 20 );
				if( hp <= 0 ) then traz.Entity:Knockout() end
				
				traz.Entity:SetHealth( hp );
				
				if not (self.Owner:GetAimVector():Angle().p < 330 and self.Owner:GetAimVector():Angle().p > 260) then
					traz.Entity:SetVelocity( ( traz.Entity:GetPos() - self.Owner:GetPos() ) * 7 )
				end
				traz.Entity:ViewPunch( Angle( math.random(-25, 25), math.random(-25, 25), math.random(-25, 25) ) )
				
				timer.Simple( 0.1, self.DoFlash, self, traz.Entity );
				self.Owner:EmitSound( self.FleshHit[math.random(1,#self.FleshHit)] );
			else
				self.Owner:EmitSound( self.Hit[math.random(1,#self.Hit)] );
			end
			
		end
		
		function DoTheseHitEffects()
			local evect = EffectData()
				evect:SetEntity(traz.Entity)
				evect:SetMagnitude(self.HitFlashSize * 10)
				evect:SetScale(self.HitFlashSize * 10)
				evect:SetRadius(self.HitFlashSize * 10)
			util.Effect("TeslaHitBoxes", evect)
			self.HitFlashSize = self.HitFlashSize - 1
		end
		timer.Create( "StunFlashes", 0.2, 3, DoTheseHitEffects )
		timer.Simple( 0.7, function() self.HitFlashSize = 3 end )
		
		local effectdata = EffectData()
			effectdata:SetOrigin( traz.HitPos )
			effectdata:SetEntity( traz.Entity )
			effectdata:SetNormal( traz.Normal )
			effectdata:SetMagnitude( 2 )
			effectdata:SetScale( 1 )
			effectdata:SetRadius( 1 )
		util.Effect( "Sparks", effectdata )
		
	end
	end ) -- Timer end

end
 
/*---------------------------------------------------------
SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
  
  	if not(self.Owner:Team() == 2 or self.Owner:Team() == 3 or self.Owner:Team() == 9)then
		self.Owner:Kill()
		return
	end
	
	if( CurTime() < self.NextStrike ) then return; end
 
	self.Owner:SetAnimation( PLAYER_ATTACK1 );
	self.Weapon:EmitSound( self.Sound );
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER );

	self.NextStrike = ( CurTime() + 1 );
	
	if( CLIENT ) then return; end

 	local trace = self.Owner:GetEyeTrace();

 	if( not trace.Entity:IsValid() and not trace.Entity:IsPlayer()) then
 		return;
	end
	
	if( self.Owner:EyePos():Distance( trace.Entity:GetPos() ) > 100 ) then
		return;
	end
	
	if( SERVER ) then 
	
		if trace.Entity:IsValid() and trace.Entity:IsPlayer() then
			trace.Entity:Knockout(self.Owner)			
		end
	
	end

end


function SWEP:Reload()
	
	if CurTime() < self.NextWarning then return end
	self.NextWarning = ( CurTime() + 2 )

	function DoTheseHitEffects()
		local evect = EffectData()
			evect:SetEntity(self.Weapon)
			evect:SetMagnitude(self.HitFlashSize * 10)
			evect:SetScale(self.HitFlashSize * 10)
			evect:SetRadius(self.HitFlashSize * 10)
		util.Effect("TeslaHitBoxes", evect)
		self.HitFlashSize = self.HitFlashSize - 1
	end
	timer.Create( "StunFlashes", 0.2, 3, DoTheseHitEffects )
	timer.Simple( 0.7, function() self.HitFlashSize = 3 end )
	self.Weapon:EmitSound("ambient/energy/zap"..math.random(1,3)..".wav")
	
	if self.Owner:KeyDown( IN_SPEED ) then
		self.Owner:ConCommand( "say "..self.RunSounds[ math.random( 1, #self.RunSounds ) ] )
	elseif self.Owner:KeyDown( IN_FORWARD ) then
		self.Owner:ConCommand( "say "..self.WalkSounds[ math.random( 1, #self.WalkSounds ) ] )
	else
		self.Owner:ConCommand( "say "..self.IdleSounds[ math.random( 1, #self.IdleSounds ) ] )
	end

end

