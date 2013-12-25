dropWeaponThing = true

function dropWeapon( pl, nomsg)
	local aw = pl:GetActiveWeapon()
	if (!ValidEntity(aw)) then return "" end
	
	aw = aw:GetClass()
	
	local team = pl:Team();
	
	if( team == 2 ) then
		if aw == "weapon_glock_bb" or aw == "weapon_mp5_bb" then
			if (!nomsg) then Notify( pl, 1, 3, "You can not drop weapons that come with the class!" ); end
			return ""
		end	
	elseif( team == 3 ) then
		if (!nomsg) then Notify( pl, 1, 3, "This class cannot drop weapons!" ); end
		return "";
	elseif( team == 9 ) then
		if aw == "weapon_deagle_bb" or aw == "weapon_pumpshotgun_cp" then
			if (!nomsg) then Notify( pl, 1, 3, "You can not drop weapons that come with the class!" ); end
			return "";
		end						
	end
	local eaw = aw
	if string.find( aw, "_bb") then
		eaw = string.sub(aw, 1, string.len(aw) - 3)
	end
	
	if(RP08.ItemData[eaw])then
		pl:StripWeapon(aw)
		RP08.CreateItem( pl, eaw )
	else
		if (!nomsg) then Notify( pl, 1, 3, "You can only drop approved weapons!" ); end
	end
	return "";
end
AddChatCommand( "/drop", dropWeapon );
