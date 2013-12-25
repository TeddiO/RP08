ChatCommands = { }
TalkSounds = { }

--Usage:
function AddChatCommand( cmd, callback, prefixconst )

	table.insert( ChatCommands, { cmd = cmd, callback = callback, prefixconst = prefixconst } );

end

function AddChatLine(recipientfilter, player, filter, text)
	
	if (player) then
		umsg.Start("bb_Chat_Player_Message", recipientfilter)
			umsg.Entity(player)
			umsg.String(filter)
			umsg.String(text)
		umsg.End()
	else
		umsg.Start("bb_Chat_Message", recipientfilter)
			umsg.String(filter)
			umsg.String(text)
		umsg.End()
	end
end


function AddChatLineInRange(player, filter, text, pos, radius)
	for k, v in pairs(ents.GetAll()) do
		local plpos = v:GetPos()
		if pos:Distance( plpos ) < radius then
			if (v:IsPlayer()) then
				AddChatLine(v, player, filter, text)
			end
		end
	end
end
/*
function GM:PlayerSay( pl, txt, public)

local text = string.Trim( txt )

	if pl:IsArrested() then
		AddChatLineInRange(pl, "arrested", text, pl:GetPos(), 256)
	return ""
	end
	
	if(pl.sleep == true)then
		if(text == "/sleep")then
			Sleep(pl)
			return "";
		end
		AddChatLineInRange(pl, "ic", text, pl:GetPos(), 256)
	return ""
	end
	
	if( pl:Team() == 2 or pl:Team() == 9 ) then
		if (checktalk(pl, text) == true)then 
			return "";
		end
	end
	
	local ftext = string.lower( text );
	
	for k, v in pairs( ChatCommands ) do
	
		local endpos = string.len( v.cmd );
		local strcmd = string.sub( ftext, 1, endpos );

		local argstart = 1;
		
		if( string.sub( text, endpos + 1, endpos + 1 ) == " " ) then
			argstart = 2;
		end
		
		if( strcmd == v.cmd ) then
			return v.callback( pl, string.sub( text, string.len( v.cmd ) + argstart ) or "" );

		end
	
	end
	AddChatLineInRange(pl, "ic", text, pl:GetPos(), 256)
	return "";

end*/

function AddCombineLine( line, dir )

TalkSounds[line] = dir;
	
end

function listplaycommands(pl)
	if( pl:Team() == 2 or pl:Team() == 3 or pl:Team() == 9 ) then
		for i, v in pairs(TalkSounds) do
			pl:PrintMessage(HUD_PRINTCONSOLE, i)
		end 
	end
end
concommand.Add( "listplaycommands", listplaycommands );

AddCombineLine( "sweeping for suspect", "npc/metropolice/hiding02.wav" );
AddCombineLine( "isolate", "npc/metropolice/hiding05.wav" );
AddCombineLine( "11-99.  Officer needs assistance", "npc/metropolice/vo/11-99officerneedsassistance.wav" );
AddCombineLine( "administer", "npc/metropolice/vo/administer.wav" );
AddCombineLine( "affirmative", "npc/metropolice/vo/affirmative.wav" );
AddCombineLine( "affirmative2", "npc/metropolice/vo/affirmative2.wav" );
AddCombineLine( "all units move in", "npc/metropolice/vo/allunitsmovein.wav" );
AddCombineLine( "amputate", "npc/metropolice/vo/amputate.wav" );
AddCombineLine( "anti-citizen", "npc/metropolice/vo/anticitizen.wav" );
AddCombineLine( "citizen", "npc/metropolice/vo/citizen.wav" );
AddCombineLine( "confirm priority 1 sighted", "npc/metropolice/vo/confirmpriority1sighted.wav" );
AddCombineLine( "control is 100 percent in this location..", "npc/metropolice/vo/control100percent.wav" );
AddCombineLine( "copy", "npc/metropolice/vo/copy.wav" );
AddCombineLine( "cover me, i'm going in", "npc/metropolice/vo/covermegoingin.wav" );
AddCombineLine( "6-3.  criminal trespass.", "npc/metropolice/vo/criminaltrespass63.wav" );
AddCombineLine( "destroy that cover", "npc/metropolice/vo/destroythatcover.wav" );
AddCombineLine( "don't move", "npc/metropolice/vo/dontmove.wav" );
AddCombineLine( "final verdict administered", "npc/metropolice/vo/finalverdictadministered.wav" );
AddCombineLine( "final warning", "npc/metropolice/vo/finalwarning.wav" );
AddCombineLine( "first warning, move away", "npc/metropolice/vo/firstwarningmove.wav" );
AddCombineLine( "get down!", "npc/metropolice/vo/getdown.wav" );
AddCombineLine( "get out of here", "npc/metropolice/vo/getoutofhere.wav" );
AddCombineLine( "i got suspect 1 here", "npc/metropolice/vo/gotsuspect1here.wav" );
AddCombineLine( "help!", "npc/metropolice/vo/help.wav" );
AddCombineLine( "help", "npc/metropolice/vo/help.wav" );
AddCombineLine( "he's running", "npc/metropolice/vo/hesrunning.wav" );
AddCombineLine( "hold it", "npc/metropolice/vo/holdit.wav" );
AddCombineLine( "hold it right there", "npc/metropolice/vo/holditrightthere.wav" );
AddCombineLine( "10-103", "npc/metropolice/vo/investigating10-103.wav" );
AddCombineLine( "i said move along", "npc/metropolice/vo/isaidmovealong.wav" );
AddCombineLine( "issuing malcompliance citation", "npc/metropolice/vo/issuingmalcompliantcitation.wav" );
AddCombineLine( "keep moving", "npc/metropolice/vo/keepmoving.wav" );
AddCombineLine( "all units lock your position", "npc/metropolice/vo/lockyourposition.wav" );
AddCombineLine( "lookin for trouble?", "npc/metropolice/vo/lookingfortrouble.wav" );
AddCombineLine( "look out!", "npc/metropolice/vo/lookout.wav" );
AddCombineLine( "minor hits continuing prosecution", "npc/metropolice/vo/minorhitscontinuing.wav" );
AddCombineLine( "move", "npc/metropolice/vo/move.wav" );
AddCombineLine( "move along", "npc/metropolice/vo/movealong3.wav" );
AddCombineLine( "move back right now", "npc/metropolice/vo/movebackrightnow.wav" );
AddCombineLine( "move it", "npc/metropolice/vo/moveit2.wav" );
AddCombineLine( "moving to hardpoint", "npc/metropolice/vo/movingtohardpoint.wav" );
AddCombineLine( "officer needs assistance on 11-99", "npc/metropolice/vo/officerneedsassistance.wav" );
AddCombineLine( "officer needs help", "npc/metropolice/vo/officerneedshelp.wav" );
AddCombineLine( "possible civil privacy violator here", "npc/metropolice/vo/possiblelevel3civilprivacyviolator.wav" );
AddCombineLine( "prepare to receive civil judgement", "npc/metropolice/vo/prepareforjudgement.wav" );
AddCombineLine( "i have a priority 2 anti citizen here", "npc/metropolice/vo/priority2anticitizenhere.wav" );
AddCombineLine( "prosecute", "npc/metropolice/vo/prosecute.wav" );
AddCombineLine( "ready to amputate", "npc/metropolice/vo/readytoamputate.wav" );
AddCombineLine( "roger that", "npc/metropolice/vo/rodgerthat.wav" );
AddCombineLine( "search", "npc/metropolice/vo/search.wav" );
AddCombineLine( "sentence delivered", "npc/metropolice/vo/sentencedelivered.wav" );
AddCombineLine( "sterilize", "npc/metropolice/vo/sterilize.wav" );
AddCombineLine( "sweeping for suspect", "npc/metropolice/vo/sweepingforsuspect.wav" );
AddCombineLine( "team position advance", "npc/metropolice/vo/teaminpositionadvance.wav" );
AddCombineLine( "take cover", "npc/metropolice/vo/takecover.wav" );
AddCombineLine( "second warning", "npc/metropolice/vo/thisisyoursecondwarning.wav" );
AddCombineLine( "you want a noncompliance verdict?", "npc/metropolice/vo/youwantamalcomplianceverdict.wav" );