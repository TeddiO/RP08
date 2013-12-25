/*
	SQLite is the standard SQL used for RP08 now.
	This saves to the sv.db file on the server. 
	If you ever want to edit / view this data, you'll need an SQLite viewer and a copy of your sv.db
	If you want to use mySQL instead, please see mysqloo.lua
	
	Oh, and SQLite sucks. Seriously, this implementation is terrible for not having a basic callback system

*/

local dbtable = "RP08Players"
local sql = sql //Needs all the boost it can get
local string = string
local basemoney = 1000

local function CheckDBTables()
	if !sql.TableExists(dbtable) then
		sql.Query("CREATE TABLE IF NOT EXISTS "..dbtable .." (steam char(20) NOT NULL , playername char(128) NOT NULL ,ip char(15) NULL,inventory char(256) NULL ,health INT NULL ,money INT NOT NULL ,PRIMARY KEY (steam)) ;") //Standard player table
	end
end
hook.Add("Initialize","CheckDBTablesArePresent",CheckDBTables)

local function CreateNewProfile(ply)
	local plyname = sql.SQLStr(ply:Nick())
	local steam = ply:SteamID()
	local ip = string.Explode(":",ply:IPAddress())
	PrintTable(ip)
	
	sql.Query("INSERT INTO "..dbtable.." (`steam`,`playername`,`ip`,`money`) VALUES ('" .. steam .. "', '" .. plyname .. "','"..ip.."','"..basemoney.."' );")
	RP08.LoadPlayerProfile(ply)
end


function RP08.LoadPlayerProfile(ply,cmd,args)
	if !ply:IsValid() then return end
	if ply.hasloaded then return end
	local steam = ply:SteamID()
	if steam == "BOT" then return end	

	local result = sql.Query("SELECT  money , inventory  FROM "..dbtable.." WHERE steam = '"..steam.."' ;")
	
	if !result then
		CreateNewProfile(ply)
		return
	end
	
	ply.hasloaded = true

	if result[1].money != "NULL" then
		ply.money = tonumber(result[1].money)
	else
		ply.money = basemoney
	end
	
	ply.inventory = {}
	
	if result[1].inventory == "NULL" then return end
	local expinv = string.Explode(",",result[1].inventory)
	for _, item in pairs(expinv) do
		if item && item != "" then
			local i = string.Explode("=",item)
			ply.inventory[tonumber(i[1])] = tonumber(i[2])
		end
	end
	
	hook.Call("PlayerDataLoaded",nil,ply) //If you ever need to check or send data specifically when the player has loaded, use this hook.
				
end
concommand.Add("rp08LoadProfile",RP08.LoadPlayerProfile) //Effectively we don't know when the client has finished loading so instead we allow the client to request the data instead.


function RP08.SavePlayerProfile(ply)
	if !ply:IsValid() then return end
	
	local steam = ply:SteamID()
	if steam == "BOT" then return end

	local plyname = sql.SQLStr(ply:Nick())
	local ip = ply:IPAddress()
	local np = string.Explode(":",ip) //Because having ports tacked on seems pointless.	
	local money = ply.money
	local invtogo = ""
	
	for _, item in pairs(ply.inventory) do
		invtogo = invtogo .. _ .. "=" ..item..","
	end
	
	
	sql.Query("UPDATE "..dbtable.." SET playername = '"..plyname.."', ip = '"..np[1].."', inventory = '"..invtogo.."', money = '"..money.."' WHERE steam = '"..steam.."' ")

end
hook.Add("PlayerDisconnected","SaveTheirProfile",RP08.SavePlayerProfile)