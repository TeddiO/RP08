local pm = FindMetaTable( "Player" );

function pm:IsArrested()
	return self:GetNetworkedBool("IsArrested")
end

function pm:Arrest()
	self:SetNWBool("IsArrested",true)
end

function pm:Arrested(arrester)
		self:Arrest()
		self:SetPos(JailPos) 
		self:StripWeapons();
		self:SetNetworkedBool("warrant", false)
		self:PrintMessage( 4, "You have been arrested for 350 seconds!" )  
		timer.Create( self:SteamID() .. "jailtimer", 300, 1, self.Unarrest, self);
		
		if(arrester)then
			for k, v in pairs( player.GetAll() ) do
				if (v:IsSuperAdmin() or v:IsAdmin()) then
					umsg.Start( "Yellow", v ) 
						umsg.String( arrester:Nick() .. " has arrested " .. self:Nick() .. "!" )		
					umsg.End()
				end
			end
		end	
		self:SetPos(JailPos) 
		self:PrintMessage( 4, "Don't try and pull a fast one! Back you go!")
end


function pm:Unarrest()

	if self:IsArrested() == true then
		timer.Stop(self:SteamID() .. "jailtimer")  
		timer.Destroy(self:SteamID() .. "jailtimer")  
		if(self.sleep == true)then
			local ragdoll = ents.GetByIndex(self.ragdollindex)
			ragdoll:Remove()
			self:UnSpectate()
			self:Spawn()
			self:SetNWBool("sleep", false)
			self:ConCommand("pp_colormod 0")
			self.sleep = false
		end
		Notify( self, 1, 4, "You have been unarrested!" )
		GAMEMODE:PlayerLoadout( self );
		RP08.Spawns.SetSpawnPoint( self )
	end
end
