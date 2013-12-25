----------------
--RP08
--Credits to
--
--Ben Build (Bentech)
--Teddi
--Cpf
-----------------
RP08={}
DeriveGamemode( "sandbox" );

//Opening the config files..
include("serverconfig.lua")
include("sharedconfig.lua")
AddCSLuaFile("sharedconfig.lua")


include( "shared.lua" )
include( "util.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "util.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_chat.lua" )

for k, v in pairs( file.Find("rp08/gamemode/shared/*.lua",LUA_PATH)) do
	AddCSLuaFile( "shared/"..v )
	include( "shared/"..v )
end

for k, v in pairs( file.Find("rp08/gamemode/server/core/*.lua",LUA_PATH)) do
	include("server/core/"..v)
end

for k, v in pairs( file.Find("rp08/gamemode/server/modules/*.lua",LUA_PATH)) do
	include("server/modules/"..v)
end

for k, v in pairs( file.Find("rp08/gamemode/client/*.lua",LUA_PATH)) do
	AddCSLuaFile( "client/"..v )
end

for k, v in pairs( file.Find("rp08/gamemode/client/vgui/*.lua",LUA_PATH)) do
	AddCSLuaFile( "client/vgui/"..v )
end

/*---------------------------------------------------------
   Name: gamemode:ShutDown( )
   Desc: Called when the Lua system is about to shut down
---------------------------------------------------------*/
function GM:ShutDown( )

	for k,pl in pairs(player.GetAll())do
		local team = pl:Team()
		for b, j in pairs( pl:GetWeapons() ) do
			local class = j:GetClass()
			if string.find(class, "_bb" ) then
				if( team == 2 ) then
					if class != "weapon_glock_bb" and class != "weapon_mp5_bb" then
						RP08.Item_Update(pl, string.Replace(class, "_bb", ""), 1)
						pl:StripWeapon(class)
					end	
				elseif( team == 9 ) then
					if class != "weapon_deagle_bb" and class != "weapon_pumpshotgun_cp" then
						RP08.Item_Update(pl, string.Replace(class, "_bb", ""), 1)
						pl:StripWeapon(class)
					end						
				else
					RP08.Item_Update(pl, string.Replace(class, "_bb", ""), 1)
					pl:StripWeapon(class)
				end
			end 	
		end
		
		RP08.SetPlayerInfo(pl, true)
		
		
	end
	
end

 
 function GM:ShowTeam( pl )
	umsg.Start("RP08.OpenMainMenu", pl)
	umsg.End()
end

function ShowSpare2( pl )
	pl:ConCommand( "gm_showspare2\n" );
end
concommand.Add( "gm_spare2", ShowSpare2 );

function GM:ShowHelp( pl )
	umsg.Start("RP08.Help.Toggle", pl)
	umsg.End()
end

function GM:GetGameDescription() 
 	return "RP08 v.3.0"
end

function GM:GetFallDamage( ply, fspeed ) 
	return (fspeed-580)*(100/(1024-580))
end
