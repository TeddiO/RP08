function CombineRequest( pl, args )
	if pl:IsArrested() then
				pl:PrintMessage( HUD_PRINTTALK, "You are arrested!" ) 
	return ""
	end

	for k, v in pairs( player.GetAll() ) do
		
		if( v:Team() == 2 or v:Team() == 9 or v:Team() == 3) then
			AddChatLine(v, pl, "request", args)
			
		end
		
	end
	pl:ChatPrint( "(REQUESTED)" );
	return "";
end
AddChatCommand( "/cr", CombineRequest );

function MayorBroadcast( pl, args )
	if pl:IsArrested() then
			pl:PrintMessage( HUD_PRINTTALK, "You are arrested!" ) 
	return ""
	end

	if not(pl:Team() == 3) then
		Notify( pl, 1, 3, "You must be the Mayor." );
		return ""
	end
	
	local message = tostring(args)
	
	for k, v in pairs( player.GetAll() ) do
		AddChatLine(v, pl, "broadcast", message)
		
	end
	return "";
end
AddChatCommand( "/broadcast", MayorBroadcast );