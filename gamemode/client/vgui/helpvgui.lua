
RP08.HelpToggle = false

local MainHelpText = [[
Primary help goes here. Or a welcome message, feel free to do whatever.
Adding more / less tabs is pretty easy. Just ensure you have the sheet name and use the same name for the sheet, e.g. local MainHelpText.
]]

local RulesText = [[
Put whatever rules you want here.]]



local ControlsText = [[
	F1 - Toggles this help panel.

	F2 - Opens your Main Menu. (Contains Inventory, Groups, Classes, Store, and Options.)

	F3 - Toggles the use of a cursor on screen. (For voting.)

	F4 - When aiming towards a door, opens door options menu. 
]]


local CommandsText = [[
Talking -
	IC / OOC - In-Character / Out-Of-Character -
		In Character is what your character can say or do such as 'Hello, may I buy a newspaper?'
		Out-Of-Character is what you say to other gamers such as 'How do I open my inventory?'
				A few things that you shouldn't do while Rping.
		Knowing somebodies name by looking at the tag above their head.
		Changing how you act due to something that has been said in OOC Chat - eg 'OOC: Somebody just dropped a gun in the bar'
		The New Life Rule. If you are killed, you do NOT know who killed you, you forget your immediate thoughts IC. DO NOT GO BACK TO WHERE YOU DIED.		 
	[[ - Is the prefix for local ooc, which means you are saying something out of character to the people around you. (Ex: [[ How do I open Nexus Doors?)
	/w - Is the prefix for a whisper, typing this before any text will make it so only the people standing right beside you can hear it. (Ex: /w The drugs are under the stairs.)
	/y - Is for yelling, using this before your text will give it a large range which can be heard by a lot of people. (Ex: /y Get back here you criminal!)
	/advert - Sends a global, In-Character message to all players. Costs 5 tokens to use. (Ex: /advert Selling guns.)
	/pm - Send a private message to that player. (Ex: /pm teddi hai)
	/r - Will talk on the radio, you must own a radio first which can be bought from the super admin or someone who has one or from the hide and seek mini game. It has many channels to choose from. (Ex: /r Supp?)
	/cr - Will send a message only to the combine, police, and mayor. It can be used to report on the gangsters or request help. (Ex: /cr Help! A man just broke into my house!)
	/write or /type - Will create a prop that when used will display the message you typed. The difference between the two is the font type. Use // for line breaks.(Ex: /write Hay // How are you doin'?)

Interaction - 
	/give - Will give the user you are looking at the amount of money you type. You cannot give more then you have obviously. (Ex: /give 500)
	/moneydrop - Will drop the amount of money you type in prop form. (Ex: /moneydrop 10)
	/title - This will set your status to whatever you wish it to be, if you feel happy, or you wish to use it as a job status.
	/drop - Drops your held weapon, can't be used with weapons you spawn with. 
	/sleep - Puts you in a ragdoll mode with limited camera view, restores HP but loses guns. Must stay still for 5 seconds to work.
	/buydruglab - Buys a money making druglab, more on this later on.	   
	/steamid - Displays your steam ID

Class Specific -
	/playerwarrant - Used by the Chief and Mayor to warrant a player so their doors can be rammed. Warrant disappears after they are arrested. Use the player's PlayerID. (Obtain PlayerIDs from the 'status' command in your console.)(Ex: /playerwarrant 11)
	/playerunwarrant - Used by the Chief and Mayor to unwarrant a player. Use the player's PlayerID. (Obtain PlayerIDs from the 'status' command in your console.)(Ex: /playerunwarrant 11)
	/demote - Used by the Mayor to demote any player back to citizen. Used the player's PlayerID.
	/agenda - Mobboss only, changes the gangster agenda.
	/lockdown - Mayor only, issues a lockdown.
	/unlockdown - Mayor only, disables lockdown.
	/broadcast - Mayor only, broadcasts a message to all connected players 
]]

local FAQsText = [[
Put FAQ here.
]]




/*ATTN: THIS MUST REMAIN, you can add your name to the bottom of the list if you wish, however for the sake of credits and
recognition, these must remain. Removing these would be considered a violation of the terms and conditions. You can do "//" and quote out this in the line above
however the credits must remain.*/
local CreditsText = [[
	Original RP08 design and production credits:
	Bentech - Made the original version of RP08.
	Teddi - Modifications, lua work, contination of project
	cpf - Modifications, lua work, contination of project and being plain awesome.

	Put your credits here.
]]


function RP08.ToggleHelpFrame()
	RP08.HelpToggle = !RP08.HelpToggle
	RP08HelpFrame:SetVisible( RP08.HelpToggle )
	gui.EnableScreenClicker( RP08.HelpToggle )
end
usermessage.Hook( "RP08.Help.Toggle", RP08.ToggleHelpFrame )


function RP08.BuildHelpPanel()

	RP08HelpFrame = vgui.Create( "DFrame" )
	RP08HelpFrame:SetSize( ScrW() - 100, ScrH() - 100 )
	RP08HelpFrame:Center()
	RP08HelpFrame:SetTitle( "RP08 Help" )
	RP08HelpFrame:SetDraggable( false )
	RP08HelpFrame:ShowCloseButton( false )
	
	local RP08HelpCategories = vgui.Create( "DPropertySheet", RP08HelpFrame )
	RP08HelpCategories:StretchToParent( 10, 35, 10, 10 )
	
	local RP08MainHelpList = vgui.Create( "DPanelList" )
	RP08MainHelpList:SetSpacing( 0 )
	RP08MainHelpList:EnableHorizontal( false )
	RP08MainHelpList:EnableVerticalScrollbar( true )
	local MainHelpTbl = string.Explode( "\n", MainHelpText )
	for k, text in pairs( MainHelpTbl ) do
			local TextFeild = vgui.Create( "DTextEntry" )
			TextFeild:SetTall( 20 )
			TextFeild:SetEnterAllowed( false )
			TextFeild:SetEditable( false )
			TextFeild:SetDrawBorder( false )
			TextFeild:SetText( text )
		RP08MainHelpList:AddItem( TextFeild )
	end

	local RP08RulesList = vgui.Create( "DPanelList" )
	RP08RulesList:SetSpacing( 0 )
	RP08RulesList:EnableHorizontal( false )
	RP08RulesList:EnableVerticalScrollbar( true )
	local RulesTbl = string.Explode( "\n", RulesText )
	for k, text in pairs( RulesTbl ) do
			local TextFeild = vgui.Create( "DTextEntry" )
			TextFeild:SetTall( 20 )
			TextFeild:SetEnterAllowed( false )
			TextFeild:SetEditable( false )
			TextFeild:SetDrawBorder( false )
			TextFeild:SetText( text )
		RP08RulesList:AddItem( TextFeild )
	end
	
	local RP08ControlsList = vgui.Create( "DPanelList" )
	RP08ControlsList:SetSpacing( 0 )
	RP08ControlsList:EnableHorizontal( false )
	RP08ControlsList:EnableVerticalScrollbar( true )
	local ControlsTbl = string.Explode( "\n", ControlsText )
	for k, text in pairs( ControlsTbl ) do
			local TextFeild = vgui.Create( "DTextEntry" )
			TextFeild:SetTall( 20 )
			TextFeild:SetEnterAllowed( false )
			TextFeild:SetEditable( false )
			TextFeild:SetDrawBorder( false )
			TextFeild:SetText( text )
		RP08ControlsList:AddItem( TextFeild )
	end
	
	local RP08CommandsList = vgui.Create( "DPanelList" )
	RP08CommandsList:SetSpacing( 0 )
	RP08CommandsList:EnableHorizontal( false )
	RP08CommandsList:EnableVerticalScrollbar( true )
	local CommandsTbl = string.Explode( "\n", CommandsText )
	for k, text in pairs( CommandsTbl ) do
			local TextFeild = vgui.Create( "DTextEntry" )
			TextFeild:SetTall( 20 )
			TextFeild:SetEnterAllowed( false )
			TextFeild:SetEditable( false )
			TextFeild:SetDrawBorder( false )
			TextFeild:SetText( text )
		RP08CommandsList:AddItem( TextFeild )
	end
	
	local RP08FAQsList = vgui.Create( "DPanelList" )
	RP08FAQsList:SetSpacing( 0 )
	RP08FAQsList:EnableHorizontal( false )
	RP08FAQsList:EnableVerticalScrollbar( true )
	local FAQsTbl = string.Explode( "\n", FAQsText )
	for k, text in pairs( FAQsTbl ) do
			local TextFeild = vgui.Create( "DTextEntry" )
			TextFeild:SetTall( 20 )
			TextFeild:SetEnterAllowed( false )
			TextFeild:SetEditable( false )
			TextFeild:SetDrawBorder( false )
			TextFeild:SetText( text )
		RP08FAQsList:AddItem( TextFeild )
	end
	
	local RP08CreditsList = vgui.Create( "DPanelList" )
	RP08CreditsList:SetSpacing( 0 )
	RP08CreditsList:EnableHorizontal( false )
	RP08CreditsList:EnableVerticalScrollbar( true )
	local CreditsTbl = string.Explode( "\n", CreditsText )
	for k, text in pairs( CreditsTbl ) do
			local TextFeild = vgui.Create( "DTextEntry" )
			TextFeild:SetTall( 20 )
			TextFeild:SetEnterAllowed( false )
			TextFeild:SetEditable( false )
			TextFeild:SetDrawBorder( false )
			TextFeild:SetText( text )
		RP08CreditsList:AddItem( TextFeild )
	end
	

	RP08HelpCategories:AddSheet( "Main Help", RP08MainHelpList, "gui/silkicons/application_view_tile" ) -- Set GUI later,
	RP08HelpCategories:AddSheet( "Rules", RP08RulesList, "gui/silkicons/application_view_tile" ) -- Set GUI later,
	RP08HelpCategories:AddSheet( "Controls", RP08ControlsList, "gui/silkicons/application_view_tile" ) -- Set GUI later,
	RP08HelpCategories:AddSheet( "Commands", RP08CommandsList, "gui/silkicons/application_view_tile" ) -- Set GUI later,
	RP08HelpCategories:AddSheet( "FAQs", RP08FAQsList, "gui/silkicons/application_view_tile" ) -- Set GUI later,
	RP08HelpCategories:AddSheet( "Credits", RP08CreditsList, "gui/silkicons/application_view_tile" ) -- Set GUI later,
	
	RP08HelpFrame:SetVisible( false )
end
timer.Simple( 3, RP08.BuildHelpPanel )