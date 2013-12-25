local pm = FindMetaTable( "Player" );

function pm:CanAfford( amount ) 
	if( amount < 0 ) then return false; end
	if( self:GetNWInt( "money" ) - amount < 0 ) then
		return false;
	end
	return true;
end

function pm:AddMoney( amount )

	local oldamount = self:GetNWInt( "money" );
	if oldamount then
	
		if oldamount < 1000000000 then
			oldamount = oldamount + tonumber(amount)
		else
			newmon = 100000
		end
		self:SetNWInt( "money", oldamount );
		
	end
	
end


function PayDay(pl)

	if not(pl:IsValid() and pl:IsPlayer())then
		timer.Destroy( pl:SteamID() .. "jobtimer" );
		return
	end
	local sal = pl:GetNWInt("salary") or 30


	if not pl:IsArrested() then
		pl:AddMoney( sal );
		Notify( pl, 4, 4, "It is payday, you got " .. sal .. " tokens!" );
	else
		Notify( pl, 4, 4, "You do not receive payday while arrested!" );
	end
		
	RP08.SetPlayerInfo(pl)
end