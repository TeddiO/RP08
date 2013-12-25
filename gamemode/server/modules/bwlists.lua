/*---------------------------------------------------------
Black and White Lists

 Allows people to always or never be a certain class
 
Module.Name 	= "Blacklists"
Module.Author 	= "Ben Swanson - Modified by Teddi"
Module.Website 	= "www.bbroleplay.co.uk"
---------------------------------------------------------*/
--[class .. steamid] - true/false
RP08.BLists = {}
if( not file.IsDir( "rp08/modules/BLists/" ) ) then	file.CreateDir( "rp08/modules/BLists" );	end

/*---------------------------------------------------------
   Name:saveBLists()
   Desc: Saves BLists
--------------------------------------------------------*/
function RP08.BLists.save()
	--if( file.Exists( "rp08/modules/BLists/thelist.txt" ) ) then
		if(RP08.BLists.lists)then
			file.Write( "rp08/modules/BLists/thelist.txt", util.TableToKeyValues(RP08.BLists.lists))
		end
	--end
end

/*---------------------------------------------------------
   Name:loadBLists()
   Desc: Gets the BLists from the files
--------------------------------------------------------*/
function RP08.BLists.load()
	RP08.BLists.lists = RP08.BLists.lists or {}
	RP08.BLists.Spawns = nil
	if( file.Exists( "rp08/modules/BLists/thelist.txt" ) ) then
		RP08.BLists.lists = nil
		RP08.BLists.lists = util.KeyValuesToTable(file.Read( "rp08/modules/BLists/thelist.txt" ))
	else
		print("BLists Module: There is no lists!")
		RP08.BLists.save()	
		print("BLists Module: File Created Sucesfully")
	end
end
RP08.BLists.load()

/*---------------------------------------------------------
   Name:saveBLists()
   Desc: Saves BLists
--------------------------------------------------------*/
function RP08.BLists.Blacklist(pl, cmd, args)
--targetname  --true/false --classid
	if( pl:EntIndex() ~= 0 and not Admins[pl:SteamID()] ) then 
		pl:PrintMessage( 2, "You're not an admin!" );
		return;
	end
	

	local teamid = tonumber(args[3]) or 2

	local target = FindPlayer( args[1] );
	
	if( target ) then
		if (args[2] and tobool(args[2]) == false) then
			RP08.BLists.lists[string.lower(teamid .. target:SteamID())] = nil
			pl:PrintMessage(2, "Revoked Blacklisting: "..target:Nick() .. " from team "..team.GetName(teamid).."!")
		else
			RP08.BLists.lists[string.lower(teamid .. target:SteamID())] = "black"
			pl:PrintMessage(2, "Blacklisted: "..target:Nick() .. " from team "..team.GetName(teamid).."!")
		end
		RP08.BLists.save()
	else
	
		pl:PrintMessage(2, "Invalid Player!")
	
	end
	
	RP08.BLists.save()

end
concommand.Add( "rp_blacklist",  RP08.BLists.Blacklist)