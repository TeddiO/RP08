
DeriveGamemode( "sandbox" );
include( "util.lua" )
include( "shared.lua" )

RP08={}

GUIToggled = false;
RP08.GUI     = {}
RP08.Panels  = {}
RP08.Effects = {}
AdminTellAlpha = -1;
AdminTellStartTime = 0;
AdminTellMsg = "";
helpmessage = 0
mmwidth, mmheight = 600,600 --Main Menu Size 
distance = 0
w, h = ScrW(), ScrH()
StunStickFlashAlpha = -1;

AlphaOfFadingThingy = 1
SpeedOfDadingThingy = 50


function GM:Initialize()
	self.BaseClass:Initialize();
	--drawnlrstuff = false
	LocalPlayer().BeingGassed = false
	RunConsoleCommand("pp_sharpen", 0)
end



for k, v in pairs( file.Find("rp08/gamemode/shared/*.lua",LUA_PATH)) do
	include( "shared/"..v )
end

for k, v in pairs( file.Find("rp08/gamemode/client/*.lua",LUA_PATH)) do
	include( "client/"..v )
end

for k, v in pairs( file.Find("rp08/gamemode/client/vgui/*.lua",LUA_PATH)) do
	include( "client/vgui/"..v )
end

surface.CreateFont( "akbar", 20, 500, true, false, "AckBarWriting" );

function HelpSelect( msg )

	local sentnumber = msg:ReadShort();
	
	if(sentnumber == helpmessage)then
		helpmessage = 0
	else
		helpmessage = sentnumber
	end
	

end
usermessage.Hook( "HelpSelect", HelpSelect );


function Yellow(msg)
	local terror = msg:ReadString()
	 ErrorNoHalt(terror.."\n")
end
usermessage.Hook( "Yellow", Yellow );


usermessage.Hook( "GetFlash", function(umdata)
	plyflash = umdata:ReadFloat()
end )

usermessage.Hook( "GetStamina", function(umdata)
	plysprint = umdata:ReadFloat()
end )




function AdminTell( msg )

	AdminTellStartTime = CurTime();
	AdminTellAlpha = 0;
	AdminTellMsg = msg:ReadString();

end
usermessage.Hook( "AdminTell", AdminTell );

LetterY = 0;
LetterAlpha = -1;
LetterMsg = "";
LetterType = 0;
LetterPos = Vector( 0, 0, 0 );

function ShowLetter( msg )

	LetterType = msg:ReadShort();
	LetterPos = msg:ReadVector();
	LetterMsg = msg:ReadString();
	LetterOwner = msg:ReadEntity();
	LetterY = ScrH() / 2;
	LetterAlpha = 0;
	
end
usermessage.Hook( "ShowLetter", ShowLetter );

function UpdateLetter( msg )

	LetterMsg = msg:ReadString();
	
end
usermessage.Hook( "UpdateLetter", UpdateLetter );

function GM:Think()

	if( LetterAlpha > -1 and LocalPlayer():GetPos():Distance( LetterPos ) > 100 ) then
		LetterAlpha = -1;
	end
end

function KillLetter( msg )

	LetterAlpha = -1;

end
usermessage.Hook( "KillLetter", KillLetter );

function ToggleClicker()
	GUIToggled = !GUIToggled;

	gui.EnableScreenClicker( GUIToggled )
	
	for k, v in pairs( VoteVGUI ) do
	
		v:SetMouseInputEnabled( GUIToggled );
	end
end
usermessage.Hook( "ToggleClicker", ToggleClicker );

timer.Simple(2,function()vgui.Create( "HUD") end)

RunConsoleCommand("rp08LoadProfile")
