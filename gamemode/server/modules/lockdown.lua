ulstat = 0
lstat = 0

function lockdown( pl )
	if( lstat == 0 and pl:Team() == 3 ) then
		pl:PrintMessage(3, "If this is found to be a bad use for lockdown, you will be banned");
		for k,v in pairs(player.GetAll()) do
			v:ConCommand("play npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav\n");
			v:PrintMessage(4, "LOCKDOWN! PLEASE GET INSIDE!")
			v:PrintMessage(3, "LOCKDOWN! PLEASE GET INSIDE!")
			v:SetNetworkedBool("inLockdown",true)
		end
		timer.Create("lockdown", 60, 0, remindlockdown)
		lstat = 1
	else
		pl:PrintMessage(3, "Lockdown in progress or your not the mayor");
		return "";
	end
end	
AddChatCommand( "/lockdown", lockdown );

function remindlockdown()

	for k,v in pairs(player.GetAll()) do
		v:PrintMessage(4, "Lockdown is in progress, Please get inside.")
		v:SetNetworkedBool("inLockdown",true)
	end
	return false
	
end

function unlockdown( pl )
	if( lstat == 1 and (pl:Team() == 3 or Admins[pl:SteamID()]) ) then
		for k,v in pairs(player.GetAll()) do
			v:PrintMessage(4, "LOCKDOWN IS NOW OVER!")
			v:PrintMessage(3, "LOCKDOWN IS NOW OVER!")
			v:SetNetworkedBool("inLockdown",false)
		end
		lstat = 0
		timer.Destroy("lockdown")
	end
	return "";
end	
AddChatCommand( "/unlockdown", unlockdown );