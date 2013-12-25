/*---------------------------------------------------------

  Doors Mod

 This Module lets players own/unown doors
 
Module.Name 	= "Doors"
Module.Author 	= "Ben Swanson"
Module.Website 	= "www.bbroleplay.co.uk"
---------------------------------------------------------*/

RP08.Doors = {}
RP08.Doors.Downer = {}

local meta = FindMetaTable( "Entity" );

 /*---------------------------------------------------------
   Name:GM:ShowSpare2
   Desc: F2
--------------------------------------------------------*/
function RP08.Doors.f4( pl )

----------------------------------------
--	Usermessage info
--------------------------------------------
--status
	--  0/nil = unowned
	--  1 = unownable
	-- 2 = ownednoaccess
	--3 = ownedaccess
	--4 = owner
	
--title
	--string
----------------------------------------------------------------				
	--owner nick
		--string			
				
-----------------if owner == true-----------------------

--Lists all players
	--nick
	--uniqueids
	--true/false
---------------------------------------------------------------
	--local trace = pl:GetEyeTrace();
	local ent = pl:GetEyeTrace().Entity
	
	if( ent:IsValid() and ent:IsDoor() and pl:GetPos():Distance( ent:GetPos() ) < 115 ) then
		
		local cur = 0
		
		if(ent:GetTable().owner)then
			if(ent:GetTable().owner == pl:UniqueID( ))then
				cur	= 4
			elseif(ent:GetTable().accesors[pl:UniqueID( )])then
				cur = 3
			else
				cur = 2
			end
		end
		
		if(ent:GetTable().extrainfo == 1)then
			cur = 1
		end
		
		
		local title = ""
		
		if(ent:GetNWString("title"))then
			title = ent:GetNWString("title")
		end
		
		
		local np = ""
			
		if(ent:GetTable().owner)then
			local a234a = player.GetByUniqueID(ent:GetTable().owner)
			if(a234a and a234a:IsValid())then
				np = a234a:Nick() or ""
			else
				np = "Offline"
			end
		end
		
		umsg.Start("RP08_DoorsCreatePanel", pl)
		
			umsg.Long(cur)
			umsg.String(title)
		
			
			umsg.String(np)
			if(ent:GetTable().owner)then
				for k, v in pairs(player.GetAll( ))do
						umsg.Short(v:UserID( ))
					if(v:UniqueID() == pl:UniqueID())then
						umsg.Short(2)
					elseif(ent:GetTable().accesors[v:UniqueID( )])then
						umsg.Short(1)
					else
						umsg.Short(0)
					end
				end
	
			end	
		umsg.End()
		
	end

end
hook.Add("ShowSpare2", "Doors", RP08.Doors.f4)  
----------------------------------------
--	Storing on door info
--------------------------------------------

--extrainfo
	--int
		--1= unownable
	
--title
	--nwstring("title")
	
--owner
	--uid
--accesors = {}
	--[uid] = true
---------------------------------------------
function RP08.Doors.fromclient( pl, cmd, args )

	local ent = pl:GetEyeTrace().Entity
	if( not (ent:IsValid() and ent:IsDoor() and pl:GetPos():Distance( ent:GetPos() ) < 115) ) then return end 
	if(args[1] == "buy")then
		if(ent:GetTable().extrainfo == 1)then
			return
		end
		
		if(ent:GetTable().owner)then
			return
		end
		
		local cost = RP08.CfgVars["doorcost"]
	
		if( not pl:CanAfford( cost ) ) then
			Notify( pl, 1, 4, "You cannot afford this door!" );
			return;
		end
		
		if(table.Count(RP08.Doors.Downer[pl:UniqueID()]) >= 5)then
			Notify( pl, 1, 4, "You have reached the maximum doors!" );
			return;
		end
		
			
		pl:AddMoney( cost * -1 );
		Notify( pl, 1, 4, "You've owned this door for " .. cost .. " tokens!" );
		
			ent:GetTable().owner = pl:UniqueID( )
			ent:GetTable().accesors = {}
			
			if not(	RP08.Doors.Downer[pl:UniqueID()])then
				RP08.Doors.Downer[pl:UniqueID()] = {}
			end
			
			RP08.Doors.Downer[pl:UniqueID()][ent:EntIndex()] = 1
					
			
		if not(string.lower(args[2]) == "nexus" or args[2] == "buy")then
			ent:SetNWString("title", tostring(args[2]))
		else
			ent:SetNWString("title", "Invalid title(Press F4 to change)")
		end
		
	elseif(args[1] == "sell")then
			
		ent:GetTable().owner = nil
		ent:GetTable().accesors = nil
		ent:SetNWString("title", "")
		
				RP08.Doors.Downer[pl:UniqueID()][ent:EntIndex()] = nil
	elseif(args[1] == "updatetitle")then
	
		ent:SetNWString("title", args[2])
	
	elseif(args[1] == "updateaccessors")then
		ent:GetTable().accesors = nil
		ent:GetTable().accesors = {}
		for k , v in pairs(string.Explode( ";", args[2] ))do
		
			--Convert userid to uniqueid
			for _, v1 in pairs(player.GetAll()) do  
				if(v1:UserID( ) == tonumber(v)) then		
					ent:GetTable().accesors[v1:UniqueID()] = 1
				end
			end
			
		end
			
	end

end
concommand.Add( "RP08_Doors", RP08.Doors.fromclient);

 /*---------------------------------------------------------
   Name:PlayerInitialSpawn()
--------------------------------------------------------*/
function RP08.Doors.PlayerInitialSpawn( pl )
	if (RP08.Doors.Downer[pl:UniqueID()])then
		timer.Destroy(pl:UniqueID().."doors")
	else
		RP08.Doors.Downer[pl:UniqueID()] = {}
	end
end
hook.Add("PlayerInitialSpawn","RP08.Doors.PlayerInitialSpawn",RP08.Doors.PlayerInitialSpawn)

 /*---------------------------------------------------------
   Name:PlayerDisconnected()
--------------------------------------------------------*/
function RP08.Doors.PlayerDisconnected( pl )

	timer.Create(pl:UniqueID().."doors", 250, 1, RP08.Doors.Timedout, pl:UniqueID())

end
hook.Add("PlayerDisconnected","RP08.Doors.PlayerDisconnected",RP08.Doors.PlayerDisconnected)
 /*---------------------------------------------------------
   Name:Timedout
--------------------------------------------------------*/
function RP08.Doors.Timedout( ud )
local uid = tostring(ud)
	for k, v in pairs(RP08.Doors.Downer[uid])do
	
		local unonwme = ents.GetByIndex(k)
		unonwme:GetTable().owner = nil
		unonwme:GetTable().accesors = nil
		unonwme:SetNWString("title", "")
	end

	RP08.Doors.Downer[uid] = nil

end


 /*---------------------------------------------------------
   Name:ccDoorunownable()
   Desc: Makes a door not ownable
--------------------------------------------------------*/
function RP08.Doors.ccDoorunownable( pl, cmd, args )

	if( pl:EntIndex() ~= 0 and not pl:IsSuperAdmin() ) then 
		pl:PrintMessage( 2, "You're not a super admin!" );
		return;
	end

 	local trace = pl:GetEyeTrace();
 	if( not trace.Entity:IsValid() or not trace.Entity:IsDoor() or pl:EyePos():Distance( trace.Entity:GetPos() ) > 200 ) then
		return;
	end
	
	
	trace.Entity:GetTable().owner = nil
	trace.Entity:GetTable().accesors = nil
	trace.Entity:SetNWString("title", args[1])
	trace.Entity:GetTable().extrainfo = 1
	
end
concommand.Add( "rp_unownable", RP08.Doors.ccDoorunownable );

 /*---------------------------------------------------------
   Name:ccDoorownable()
   Desc: Makes a door ownable
--------------------------------------------------------*/
function RP08.Doors.ccDoorownable( pl, cmd )

	if( pl:EntIndex() ~= 0 and not pl:IsSuperAdmin() ) then 
		pl:PrintMessage( 2, "You're not a super admin!" );
		return;
	end

 	local trace = pl:GetEyeTrace();
 	if( not trace.Entity:IsValid() or not trace.Entity:IsDoor() or pl:EyePos():Distance( trace.Entity:GetPos() ) > 200 ) then
		return;
	end
	
	trace.Entity:SetNWString("title", "")
	trace.Entity:GetTable().extrainfo = nil

end
concommand.Add( "rp_ownable", RP08.Doors.ccDoorownable );


/*---------------------------------------------------------
   Name: ccSavedoorinfo( pl, cmd, args )
   Desc: Saves the door info
---------------------------------------------------------*/
function RP08.Doors.ccSavedoorinfo( pl, cmd, args )

	if( pl:EntIndex() ~= 0 and not pl:IsSuperAdmin() ) then 
		pl:PrintMessage( 2, "You're not a super admin!" );
		return;
	end
 
 	local pTable = {} 
	
	for k,v in pairs(ents.FindByClass("func_door*")) do

		if(v:GetTable().extrainfo == 1)then
			local idx = v:EntIndex()
			pTable[idx] = {}
			if(v:GetName() == "")then
				pTable[idx]["pos"] = tostring(v:GetPos())
			else
				pTable[idx]["name"] = tostring(v:GetName())
			end
			pTable[idx]["ei"] = 1
			pTable[idx]["title"] = v:GetNWString("title")
		end
		
	end
	
	for k,v in pairs(ents.FindByClass("prop_door_rotating")) do
		if(v:GetTable().extrainfo == 1)then
			local idx = v:EntIndex()
			pTable[idx] = {}
			if(v:GetName() == "")then
				pTable[idx]["pos"] = tostring(v:GetPos())
			else
				pTable[idx]["name"] = tostring(v:GetName())
			end
			pTable[idx]["ei"] = 1
			pTable[idx]["title"] = v:GetNWString("title")
		end
	end
	
	file.Write( "rp08/doors/doors_" .. game.GetMap() .. ".txt",util.TableToKeyValues(pTable))
end

concommand.Add( "rp_savedoors", RP08.Doors.ccSavedoorinfo );

/*---------------------------------------------------------
   Name: ccLoaddoorinfo( )
   Desc: Loads the door info
---------------------------------------------------------*/

function RP08.Doors.ccLoaddoorinfo( )
	
	if not(file.Exists("rp08/doors/doors_" .. game.GetMap() .. ".txt"))then
		print "No Door Info For Map"
		return
	else
		print "Door info loaded"
	end

	local fileread = util.KeyValuesToTable(file.Read( "rp08/doors/doors_" .. game.GetMap() .. ".txt" ))

	for index,v in pairs(fileread) do
		if(v.name)then
			local gotents = ents.FindByName( v.name )
			for k1, v1 in pairs(gotents) do
				v1:SetNWString("title", v.title)
				v1:GetTable().extrainfo = 1
			end
		else
			local vec = string.ToVector(v.pos)
			local gotents = ents.FindInSphere( vec, 1)
			for k1, v1 in pairs(gotents) do
				v1:SetNWString("title", v.title)
				v1:GetTable().extrainfo = 1
			end
		end
		
	end
	RP08.Doors.doorinfoupdate()
end
--concommand.Add( "rp_loaddoors", RP08.Doors.ccLoaddoorinfo );
timer.Simple(10, RP08.Doors.ccLoaddoorinfo)

 /*---------------------------------------------------------
   Name:deletetunneldoors( )
   Desc: Deletes the doors for the tunnels
----------------------------------------------------*/
function RP08.Doors.doorinfoupdate()

	for k,object in pairs(ents.FindByClass("prop_physics*")) do
		object:Remove()
	end
 
		local ind_checkpointdoor = ents.FindByName("ind_checkpointdoor")

		for k1, v1 in pairs( ind_checkpointdoor ) do
			v1:Remove()
		end
		
			
		local i = 0
		local sd2 = ents.FindByName("shop_door2")
		if(sd2[2])then
			sd2[2]:Remove()
		end
		
		for k1, v1 in pairs( ents.FindByName("rope_swing*") ) do
			v1:Remove()
		end
	
		for k1, v1 in pairs( ents.FindByName("swing_seat*") ) do
			v1:Remove()
		end

		for k1, v1 in pairs( ents.FindByClass("func_breakable_surf") ) do
			v1:Remove()
		end
		
		for k1, v1 in pairs( ents.FindByClass("env_sprite") ) do 
			v1:Remove() 
		end
end
	
 --Admin Fucntions--
  /*--------------------------------------------------------- 
     Name: Manually unOwn a door
	Admin Function
 ---------------------------------------------------------*/ 
function RP08.Doors.ccDoorunOwn( pl, cmd, args )

	if( pl:EntIndex() ~= 0 and not pl:IsAdmin() ) then 
		pl:PrintMessage( 2, "You're not an admin!" );
		return;
	end

 	local trace = pl:GetEyeTrace();

 	if( not trace.Entity:IsValid() or not trace.Entity:IsDoor() or pl:EyePos():Distance( trace.Entity:GetPos() ) > 200 ) then
		return;
	end

	trace.Entity:Fire( "unlock", "", 0 );
	
	trace.Entity:GetTable().owner = nil
	trace.Entity:GetTable().accesors = nil
	trace.Entity:SetNWString("title", "")

end
concommand.Add( "rp_unown", RP08.Doors.ccDoorunOwn );

 --Admin Fucntions--
  /*--------------------------------------------------------- 
     Name: Manually change door's name
	Admin Function
 ---------------------------------------------------------*/ 
function RP08.Doors.ccDoorChangeName( pl, cmd, args )

	if( pl:EntIndex() ~= 0 and not pl:IsAdmin() ) then 
		pl:PrintMessage( 2, "You're not an admin!" );
		return;
	end

 	local trace = pl:GetEyeTrace();

 	if( not trace.Entity:IsValid() or not trace.Entity:IsDoor() or pl:EyePos():Distance( trace.Entity:GetPos() ) > 200 ) then
		return;
	end


	trace.Entity:SetNWString("title", tostring(args))

end
--concommand.Add( "rp_renamedoor", RP08.Doors.ccDoorChangeName );