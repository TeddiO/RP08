RP08.Workshoplist = {}
function giveInventoryWeaponItem(item, pl)
	if (SERVER) then
		if (!pl:HasWeapon(item.Weapon)) then
			pl:Give( item.Weapon)
			pl:SelectWeapon(item.Weapon)
		else
			pl:SelectWeapon(item.Weapon)
			return false
		end
	end
end
 /*--------------------------------------------------------- 
     Name: Create Items
	 Parses all the /items
 ---------------------------------------------------------*/ 
function RP08.CreateItems()
	 for _, ITEM in pairs( RP08.ItemData ) do
				
		if(ITEM.Workshop)then
		
			RP08.Workshoplist[ITEM.UniqueID] = {Team = ITEM.Team, BatchAmount = ITEM.BatchAmount, Costperitem = ITEM.Costperitem}
			
		end
		
	end
	
end
RP08.CreateItems()

 /*----------------------------------- ---------------------- 
    Desc:Gets called when the buttons are pressed
 ---------------------------------------------------------*/ 

function RP08.InventoryHook( pl, cmd, args )
local itemuid = tostring(args[1])
local itemfunction = args[2]
local extrainfo = args[3] or 0
local amount = pl:GetTable().Inventory[itemuid]
	if(amount and amount > 0)then
		if(itemfunction == "destroyitem")then
			RP08.Item_Update(pl, itemuid, -amount)
	elseif(itemfunction == "dropitem" and (RP08.ItemData[itemuid].Dropable==true or pl:IsSuperAdmin()))then
			RP08.CreateItem( pl, itemuid )
			RP08.Item_Update(pl, itemuid, -1)
		elseif(itemfunction == "useitem")then
			if not(RP08.ItemData[itemuid]:OnUse(pl) == false)then
				RP08.Item_Update(pl, itemuid, -1)
			end
		end
	else
		Notify( pl, 4, 4, "You do not own this item!" );
	end
	
	
end

concommand.Add( "RP08_inventory", RP08.InventoryHook)

/*---------------------------------------------------------
   Name: RP08.SendPlayerInventory(pl)
   Desc: Inital Send of all inventory
---------------------------------------------------------*/
function RP08.SendPlayerInventory(pl, cmd, args)

	if not(RP08.ItemData)then
		print("Item system failed to load!")
		pl:PrintMessage(2,"Item system failed to load!")
		return
	end
	
	for k, v in pairs (pl:GetTable().Inventory)do
		RP08.Item_Update(pl, k, v, true)
	end	

end

concommand.Add( "inventory_refresh", RP08.SendPlayerInventory)
/*---------------------------------------------------------
   Name: RP08.Item_Update(pl, item, amount)
   Desc: Updates the GUI
---------------------------------------------------------*/
function RP08.Item_Update(pl, item, amount, init)

	if not(RP08.ItemData)then
		print("Item system failed to load!")
		pl:PrintMessage(2,"Item system failed to load!")
		return false
	end

	if not(RP08.ItemData[item])then
		print("Invalid Item")
		pl:PrintMessage(2,"Invalid Item: '" .. item .. "'")
		--temp remove
		pl:GetTable().Inventory[item] = nil
		--dont remove it incase something goes wrong then everyone looses everything!!!
		return false
	end

	if not(init)then
		if(pl:GetTable().Inventory[item])then
			pl:GetTable().Inventory[item] = pl:GetTable().Inventory[item] + amount
		else
			if(amount == 1)then
				pl:GetTable().Inventory[item] = 1
			end
		end
	end	
	umsg.Start( "Item_Update", pl);
		umsg.String(tostring(item));
		umsg.Long( pl:GetTable().Inventory[item] );
	umsg.End();
	
	if (not pl:GetTable().Inventory[item] or pl:GetTable().Inventory[item] < 1) then
		pl:GetTable().Inventory[item] = nil
	end
	
	return true
end

/*---------------------------------------------------------
   Name: RP08.SendPlayerInventory(pl)
   Desc: Inital Send of all inventory
---------------------------------------------------------*/
function RP08.CreateItem( pl, item, pos )
	local id = tostring(item)
	
	if not(RP08.ItemData[id])then
		return
	end
	
	
		local trace = { }
	
		trace.start = pl:EyePos();
		trace.endpos = trace.start + pl:GetAimVector() * 85;
		trace.filter = pl;
	
		local tr = util.TraceLine( trace );

	local item = ents.Create( "spawned_item" );
	if not(pos)then
		item:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16) );
	else
		item:SetPos(pos);
	end
	
	item:SetModel( RP08.ItemData[id].Model );
	item:SetData( RP08.ItemData[id] );
	item:Spawn()
	return item
end

/*---------------------------------------------------------
   Name: RP08.InventorySize
   Desc: How Big Is The Inventory
---------------------------------------------------------*/
function RP08.GetInventoryAmount( pl )
local total = 0
	for k, v in pairs( pl:GetTable().Inventory ) do
		if(RP08.ItemData[k])then
			total = total + (tonumber(RP08.ItemData[k].Size) * v)
		end
	end
	return total
end

/*---------------------------------------------------------
   Name: RP08.InventorySize
   Desc: How Big Is The Inventory
---------------------------------------------------------*/
function RP08.InventoryFull( pl, size )
	if(not pl:GetTable().Inventory)then
		return false
	end
	if (size) then
		if(RP08.GetInventoryAmount(pl) + size > pl:GetTable().MaxInventory) then
			return true
		else
			return false
		end
	end
	if(RP08.GetInventoryAmount(pl) >= pl:GetTable().MaxInventory)then
		return true
	else
		return false
	end
end
