RP08.PlayerInventory = {}
RP08.Workshoplist = {}
RP08.InventoryUpdate = false
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
 /*--------------------------------------------------------- 
     Name: ItemUpdate
	Reciving end of the item update
 ---------------------------------------------------------*/ 

function RP08.ItemUpdate( msg )

	local item = msg:ReadString();
	local amount = msg:ReadShort();
	RP08.InventoryUpdate = true
	if (amount < 1)then
		RP08.PlayerInventory[item] = nil
	else
		RP08.PlayerInventory[item] = amount
	end

end
usermessage.Hook( "Item_Update", RP08.ItemUpdate );

/*---------------------------------------------------------
   Name: RP08.InventorySize
   Desc: How Big Is The Inventory
---------------------------------------------------------*/
function RP08.GetInventorySize()
local total = 0
	for k, v in pairs( RP08.PlayerInventory ) do
		local size=0
		if RP08.ItemData[k]!=nil then
			size = RP08.ItemData[k].Size or 0
		end
	total = total + (tonumber(size) * v)
	end
	return total
end


