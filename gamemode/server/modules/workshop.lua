----------------------------------------------------
----------Workshop
------------------------------------------------------
function RP08.Workshop( pl, cmd, args )
	if( args == "" ) then return ""; end
	
	if pl:IsArrested() then return ""; end
	
	local TheClass = args[1]
	local TheItem = RP08.ItemData[TheClass]
	local Workshopdata = RP08.Workshoplist[TheClass]

	if not(TheClass)then 	return "";  end   
	
	if (Workshopdata.Team)then
	
		if( pl:Team() ~= Workshopdata.Team ) then
			Notify( pl, 1, 3, "You are not a ".. RP08.Teams.list[Workshopdata.Team][1].."!");
			return "";
		end
		
	end
		
	local trace = { }
	
	trace.start = pl:EyePos();
	trace.endpos = trace.start + pl:GetAimVector() * 85;
	trace.filter = pl;
	
	local tr = util.TraceLine( trace );
		if( not pl:CanAfford( Workshopdata.Costperitem * Workshopdata.BatchAmount) ) then
			Notify( pl, 1, 3, "You cannot afford this!" );
			return "";
		end
		
		Notify( pl, 1, 3, "You bought a shipment of "..TheItem.Name.."'s!" );
		pl:AddMoney( (Workshopdata.Costperitem * Workshopdata.BatchAmount) * -1);
		local hw = Workshopdata.BatchAmount / 2
		local itemz = {}
		for i=((math.floor(hw) - 1) * -1), math.ceil(hw), 1 do 
			local item = RP08.CreateItem( pl, TheClass, Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z + 16 + (i * 2)) )
			if (ValidEntity(item)) then
				table.insert(itemz, item)
			end
		end
		for k, v in pairs(itemz) do
			for k2, v2 in pairs(itemz) do
				if (v != v2) then
					constraint.NoCollide(v, v2, 0, 0)
				end
			end
		end
	
	return "";
end
concommand.Add( "RP08_Workshop", RP08.Workshop );