JailPos = string.ToVector(file.Read( "rp08/jail/" .. game.GetMap() .. "_jailpos.txt" ))

function changejailPos( pl )
	if( pl:IsAdmin() ) then
		JailPos = pl:GetPos()
		file.Write( "rp08/jail/" .. game.GetMap() .. "_jailpos.txt",tostring(JailPos) )
		pl:PrintMessage(4, "Jail Position Set")
		return ""
	else //
		pl:PrintMessage(4, "You are not a high enough rank to set this.")
		return "";	
	end
	return "";
end
AddChatCommand( "/jailpos", changejailPos );

function setJailPos()
	if file.Exists("rp08/jail/" .. game.GetMap() .. "_jailpos.txt") then   
		local fr = file.Read("rp08/jail/" .. game.GetMap() .. "_jailpos.txt")
		JailPos = string.ToVector(fr)
	end
end