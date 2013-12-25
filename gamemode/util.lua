function string.ToVector(str)
	strtabled = (string.Explode(" " ,str))

	if not str then 
		return nil
	end

	return Vector(tonumber(strtabled[1]),tonumber(strtabled[2]),tonumber(strtabled[3]))
end


function Notify( pl, msgtype, len, msg )
	msg = tostring(msg)
	
	if (not msg or msg == "")then
		return
	end
	
	if (not len or len == "")then
		return
	end
	
	if (not msgtype or msgtype == "")then
		return
	end
	
	pl:SendLua( [[GAMEMODE:AddNotify("]]..tostring(msg)..[[", ]] .. tonumber(msgtype) .. [[, ]] .. tonumber(len) .. [[)]] );

end

function NotifyAll( msgtype, len, msg )

	for k, v in pairs( player.GetAll() ) do
		
		Notify( v, msgtype, len, msg );
		
	end

end


function FindPlayer( info )

	for k, v in pairs( player.GetAll() ) do
		
		if( tonumber( info ) == v:EntIndex() ) then
			return v;
		end
		
		if( info == v:SteamID() ) then
			return v;
		end
		
		if( string.find( v:Nick(), info ) ~= nil ) then
			return v;
		end
		
	end
	
	return nil;

end

