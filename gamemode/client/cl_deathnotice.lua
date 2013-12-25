local hud_deathnotice_time = CreateConVar( "hud_deathnotice_time", "0", FCVAR_REPLICATED )

local function PlayerIDOrNameToString( var )
	
end


local function RecvPlayerKilledByPlayer( message )


end
	
usermessage.Hook( "PlayerKilledByPlayer", RecvPlayerKilledByPlayer )


local function RecvPlayerKilledSelf( message )


end
	
usermessage.Hook( "PlayerKilledSelf", RecvPlayerKilledSelf )


local function RecvPlayerKilled( message )


end
	
usermessage.Hook( "PlayerKilled", RecvPlayerKilled )

local function RecvPlayerKilledNPC( message )

end
	
usermessage.Hook( "PlayerKilledNPC", RecvPlayerKilledNPC )


local function RecvNPCKilledNPC( message )

end
	
usermessage.Hook( "NPCKilledNPC", RecvNPCKilledNPC )



function GM:AddDeathNotice( )


end

local function DrawDeath( x, y, death, hud_deathnotice_time )


end


function GM:DrawDeathNotice( x, y )


end
