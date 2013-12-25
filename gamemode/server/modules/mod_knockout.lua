local pm = FindMetaTable( "Player" );

function pm:Knockout(cop)

	if self.sleep == true then return end
	if self.Knockedout == true then return end

	Notify(self, 1, 35, "You have been knocked out, please wait 35 seconds." )
	self.Knockedout = true
	
	for k,v in pairs(player.GetAll())do
			
		if(v:IsAdmin() or v:IsSuperAdmin())then
				
			umsg.Start( "Yellow", v ) 
				umsg.String( cop:Nick() .. " knocked out "..self:Nick().."!" )		
			umsg.End()
		end
	end	
	plsleep(self)
end

function pm:JustGassed()
	if not self.BeingGassed then
		umsg.Start( "GassedEffects", self ) umsg.End()
		self.BeingGassed = true
		timer.Create("gas: "..self:UniqueID(), 30, 1, function() self:StopGassing() end )
	end
end

function pm:StopGassing()
	timer.Remove("gas: "..self:UniqueID())
	self.BeingGassed = false
	umsg.Start( "StopGassedEffects", self ) umsg.End()
end
