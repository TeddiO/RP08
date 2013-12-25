
if( VoteVGUI ) then

	for k, v in pairs( VoteVGUI ) do
	
		v:Remove();
		VoteVGUI[k] = nil;
	
	end

end

VoteVGUI = { }
PanelNum = 0;

if( LetterWritePanel ) then

	LetterWritePanel:Remove();
	LetterWritePanel = nil;
	
end

function MsgDoVote( msg )

	local question = msg:ReadString();
	local voteid = msg:ReadString();
	local inputenabled = false;
	
	if( HelpToggled or GUIToggled ) then
		inputenabled = true;
	end
	panel = vgui.Create("DFrame") 
	panel:SetPos( 3, ScrH() / 2 - 50 );
    panel:SetTitle( "Vote!" ) 
    panel:MakePopup(true) 
    panel:ShowCloseButton( false ) 
	panel:SetSize(140, 110) 
	panel:SetDraggable( false )
	
	panel:SetKeyboardInputEnabled( false );
	panel:SetMouseInputEnabled( inputenabled );
	panel:SetVisible( true );
	
	local label = vgui.Create( "Label" );
	label:SetParent( panel );
	label:SetPos( 5, 30 );
	label:SetSize( 180, 40 );
	label:SetText( question );
		label:SetVisible( true );	
	

	
	_G["YesVoteFunc" .. voteid] = function( msg )
	
		LocalPlayer():ConCommand( "vote " .. voteid .. " 1\n" );
	
	end
	
	local ybutton = vgui.Create( "Button" );
	ybutton:SetParent( panel );
	ybutton:SetPos( 15, 70 );
	ybutton:SetSize( 40, 20 );
	ybutton:SetCommand( "!" );
	ybutton:SetText( "Yes!" );
	ybutton:SetActionFunction( _G["YesVoteFunc" .. voteid] );
	ybutton:SetVisible( true );
	
	table.insert( VoteVGUI, ybutton );
	
	_G["NoVoteFunc" .. voteid] = function( msg )
	
		LocalPlayer():ConCommand( "vote " .. voteid .. " 2\n" );
	
	end
	
	local nbutton = vgui.Create( "Button" );
	nbutton:SetParent( panel );
	nbutton:SetPos( 60, 70 );
	nbutton:SetSize( 40, 20 );
	nbutton:SetCommand( "!" );
	nbutton:SetText( "No!" );
	nbutton:SetActionFunction( _G["NoVoteFunc" .. voteid] );
	nbutton:SetVisible( true );	
	
	table.insert( VoteVGUI, nbutton );
	
	PanelNum = PanelNum + 1;
	VoteVGUI[voteid .. "vote"] = panel;

end
usermessage.Hook( "DoVote", MsgDoVote );

function KillVoteVGUI( msg )

	local id = msg:ReadString();

	if( VoteVGUI[id .. "vote"] ) then
	
		for k, v in pairs( VoteVGUI ) do
		
			if( v:GetParent() == VoteVGUI[id .. "vote"] ) then
			
				v:Remove();
				VoteVGUI[k] = nil;
			
			end
		
		end

		VoteVGUI[id .. "vote"]:Remove();
		
		VoteVGUI[id .. "vote"] = nil;
		
		PanelNum = PanelNum - 1;
		
	end

end
usermessage.Hook( "KillVoteVGUI", KillVoteVGUI );


function KillVoteVGUI( msg )

	local id = msg:ReadString();

	if( VoteVGUI[id .. "vote"] ) then
	
		for k, v in pairs( VoteVGUI ) do
		
			if( v:GetParent() == VoteVGUI[id .. "vote"] ) then
			
				v:Remove();
				VoteVGUI[k] = nil;
			
			end
		
		end

		VoteVGUI[id .. "vote"]:Remove();
		
		VoteVGUI[id .. "vote"] = nil;
		
		PanelNum = PanelNum - 1;
		
	end

end
usermessage.Hook( "KillVoteVGUI", KillVoteVGUI );

function DoLetter( msg )

	LetterWritePanel = vgui.Create( "Frame" );
	LetterWritePanel:SetPos( ScrW() / 2 - 75, ScrH() / 2 - 100 );
	LetterWritePanel:SetSize( 150, 200 );
	LetterWritePanel:SetMouseInputEnabled( true );
	LetterWritePanel:SetKeyboardInputEnabled( true );
	LetterWritePanel:SetVisible( true );
	

end
usermessage.Hook( "DoLetter", DoLetter );