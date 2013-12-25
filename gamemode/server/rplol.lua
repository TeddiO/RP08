function BuyDrugLab( pl )
	if( args == "" ) then return ""; end
	local trace = { }
	trace.start = pl:EyePos();
	trace.endpos = trace.start + pl:GetAimVector() * 85;
	trace.filter = pl;
	if pl:IsArrested() then return false end
	local tr = util.TraceLine( trace );
		
		if ( pl:Team() ~= 2 or pl:Team() ~= 3 ) then
		
			if( not pl:CanAfford( RP08.CfgVars["druglabcost"] ) ) then
				Notify( pl, 1, 3, "You cannot afford this!" );
				return "";
			end
			if(pl.maxDrugLab >= RP08.CfgVars["maxdruglabs"])then
				Notify( pl, 1, 3, "You have reached the maximum drug labs!" );
				return "";
			end
			pl:AddMoney( - RP08.CfgVars["druglabcost"] );
			Notify( pl, 1, 3, "You bought a drug lab" );
			local druglab = ents.Create( "drug_lab" );
			druglab.ownu = pl
			druglab:SetPos( tr.HitPos );
			druglab:Spawn();
			return "";
		else
			Notify( pl, 1, 3, "Mayor and Police cannot buy drug labs!" );
			return "";
		end
	return "";
end
AddChatCommand( "/buydruglab", BuyDrugLab );


function ChangeTitle( pl, args )
	
    if( args == "" ) then return ""; end

	pl:UpdateTi( args );
	
	return "";

end
AddChatCommand( "/title", ChangeTitle );

function PM( pl, args )

	local namepos = string.find( args, " " );
	if( not namepos ) then return ""; end
	
	local name = string.sub( args, 1, namepos - 1 );
	local msg = string.sub( args, namepos + 1 );
	
	target = FindPlayer(name)
		
	if( target ) then
		AddChatLine(target, pl, "pm", msg)
		target:GetTable().LastPMFrom=pl:Nick()
		
		AddChatLine(pl, pl, "pm", msg)
		
	else
		
		Notify( pl, 1, 3, "Unable to find player: " .. name );
		
	end
	
	return "";

end
AddChatCommand( "/pm", PM );


function MakeLetter( pl, args, typenum )

	if( pl.maxletters >= 3 ) then
	
		Notify( pl, 1, 4, "You have reached the maximum letters!" );
		return "";
		
	end

	if( CurTime() - pl:GetTable().LastLetterMade < 3 ) then
	
		Notify( pl, 1, 4, "Please wait " .. math.ceil( 3 - ( CurTime() - pl:GetTable().LastLetterMade ) ) .. " second(s)!" );
		return "";

	end

	pl:GetTable().LastLetterMade = CurTime();
	
	local ftext = string.gsub( args, "//", "\n" );
	
	local tr = { }
	tr.start = pl:EyePos();
	tr.endpos = pl:EyePos() + 95 * pl:GetAimVector();
	tr.filter = pl;
	local trace = util.TraceLine( tr );
	
	local fe = ents.FindInSphere( trace.HitPos,20 )
	
	for _, ctr in pairs(fe)do
		dprint("found letter")
		if(ctr.Entity:IsValid( ) and ctr.Entity:GetClass() == "letter" and ctr.Entity.owner == pl)then
		
			ctr.Entity.content = ftext;
			umsg.Start( "UpdateLetter", pl );
				umsg.String( ftext );
			umsg.End();		
			pl:PrintMessage(3, "You have edited the letter.")
			dprint("edit attempt")
			return "";
		
		end
			
	end
	
	
	local letter = ents.Create( "letter" );
		letter:SetModel( "models/props_c17/paper01.mdl" );
		letter:SetPos( trace.HitPos );
	letter:Spawn();
	
	
	letter:GetTable().Letter = true;
	letter.type = tonumber(typenum);
	letter.content = ftext;
	letter.owner = pl;
	
	pl.maxletters = pl.maxletters + 1
	
	return "";

end
function writeletter( pl, args )
	MakeLetter( pl, args, "1" )
	return "";
end
AddChatCommand( "/write", writeletter);

function typeletter( pl, args )
	MakeLetter( pl, args, "2" )
	return "";
end
AddChatCommand( "/type", typeletter);


function Whisper( pl, args )
	AddChatLineInRange(pl, "whisper", args, pl:GetPos(), 90)
	
	return "";

end
AddChatCommand( "/w", Whisper );

function localOOC( pl, args )

	if not(pl.gimp == ID_MUTE) then
		AddChatLineInRange(pl, "looc", args, pl:GetPos(), 100)
		return "";
	end
	
	AddChatLineInRange(pl, "looc", args, pl:GetPos(), 300)
	
	return "";

end
AddChatCommand( "[[", localOOC );
AddChatCommand( "/looc", localOOC );


function Yell( pl, args )

	if not(pl.gimp == ID_MUTE) then
		pl:PrintMessage(4, "You have been muted!")
		return "";
	end
	AddChatLineInRange(pl, "yell", args, pl:GetPos(), 650)
	
	return "";

end
AddChatCommand( "/y", Yell );

function SlashMe( pl, args )

	AddChatLineInRange(nil, "", pl:Nick() .. " ".. args, pl:GetPos(), 550)
	return "";

end
AddChatCommand( "/me", SlashMe );

function OOC( pl, args )

	AddChatLine(nil, pl, "ooc", args)
		return "";
end
AddChatCommand( "//", OOC, true );
AddChatCommand( "/a ", OOC, true );
AddChatCommand( "/ooc", OOC, true );

function GiveMoney( pl, args )
	
    if( args == "" ) then return ""; end
	
	local n = tonumber( args )
	
	if( n and n <= 0 ) then
	
		return "";
	
	end
		
	if( not pl:CanAfford( n ) ) then
		
		Notify( pl, 1, 3, "You cannot afford this!" );
		return "";
		
	end
	
	local trace = pl:GetEyeTrace();
	
	if( trace.Entity:IsValid() and trace.Entity:IsPlayer() and trace.Entity:GetPos():Distance( pl:GetPos() ) < 150 ) then
		
		pl:AddMoney( n * -1 );
		trace.Entity:AddMoney( n );		
		Notify( trace.Entity, 0, 4, pl:Nick() .. " has given you " .. n .. " tokens!" );
		Notify( pl, 0, 4, "You gave " .. trace.Entity:Nick() .. " " .. n .. " tokens!" );
		trace.Entity:PrintMessage( HUD_PRINTCONSOLE, pl:Nick() .. " has given you " .. n .. " tokens!" )
		pl:PrintMessage( HUD_PRINTCONSOLE, "You gave " .. trace.Entity:Nick() .. " " .. n .. " tokens!" )
		
	else
	
		Notify( pl, 1, 3, "Must be looking at and be within distance of another player!" );
		
	end
	return "";
end
AddChatCommand( "/give", GiveMoney );

function DropMoney( pl, args )
	
    if( args == "" ) then return ""; end
	
	local amount = tonumber( args );
	
	if( not pl:CanAfford( amount ) ) then
		
		Notify( pl, 1, 3, "Cannot afford this!" );
		return "";
		
	end
	
	if( amount < 10 ) then
	
		Notify( pl, 1, 4, "You must drop atleast 10 tokens!" );
		return "";
	
	end
	
	pl:AddMoney( amount * -1 );
	
	local trace = { }
	
	trace.start = pl:EyePos();
	trace.endpos = trace.start + pl:GetAimVector() * 85;
	trace.filter = pl;
	
	local tr = util.TraceLine( trace );
	
	local moneybag = ents.Create( "prop_physics" );
	moneybag:SetModel( "models/props/cs_assault/money.mdl" );
	moneybag:SetPos( tr.HitPos );
	moneybag:Spawn();
	moneybag:GetTable().MoneyBag = true;
	moneybag:GetTable().Amount = amount;
	
	return "";
end
AddChatCommand( "/moneydrop", DropMoney );

function Advert( pl, args )

	if pl:IsArrested() then
				pl:PrintMessage( HUD_PRINTTALK, "You are arrested!" ) 
	return ""
	end
		pl:AddMoney( - 5 )
		
		AddChatLine(nil, pl, "advert", args)
return "";
end

AddChatCommand( "/advert", Advert );


function playerDist(npcPos)
	local playDis
	local currPlayer
	for k, v in pairs(player.GetAll()) do
		local tempPlayDis = v:GetPos():Distance( npcPos:GetPos() )
		if(playDis == nil) then
			playDis = tempPlayDis
			currPlayer = v
		end
		if(tempPlayDis < playDis) then
			playDis = tempPlayDis
			currPlayer = v
		end
	end
	return currPlayer
end


