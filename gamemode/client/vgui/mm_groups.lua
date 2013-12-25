local groupud = false
local GroupTabs = GroupTabs
local GroupIfo = GroupIfo

function RP08.GroupUpdate(msg)

	playergroup = msg:ReadShort()
	playergroupname = msg:ReadString()
	playerrank = msg:ReadShort()
	playerrankname = msg:ReadString()
	groupud = true
	
end

usermessage.Hook( "GroupInfo", RP08.GroupUpdate );
	
local PANEL = {}

function PANEL:Init( )
	self:SetSize( mmwidth, mmheight )
	
	local MainMessage = vgui.Create("DLabel", self) 
	MainMessage:SetText("You Are Not In Any Group") 
	MainMessage:SetFont("GModToolName") 
	MainMessage:SizeToContents()
	MainMessage:SetPos((mmwidth / 2) - (MainMessage:GetWide() / 2), 40 ) 
	MainMessage:SetTextColor(Color(255,0,0))
	
	local MainMessage2 = vgui.Create("DLabel", self) 
	MainMessage2:SetText("Visit bbroleplay.co.uk for more info") 
	MainMessage2:SetFont("Trebuchet18") 
	MainMessage2:SizeToContents()
	MainMessage2:SetPos((mmwidth / 2) - (MainMessage2:GetWide() / 2), 100 ) 
	MainMessage2:SetTextColor(Color(255,0,0))
	
	GroupTabs = vgui.Create( "DPropertySheet", self )
	GroupTabs:StretchToParent( 4, 20, 4, 4 )
	GroupTabs:SetVisible( false )
		
	--groups	
	local groups = vgui.Create("Panel", GroupTabs)	
	groups:StretchToParent( 2,2,2,2)
	groups:SetPos(4,30)
	
	---overview
	local overview = vgui.Create("Panel", GroupTabs)	
	overview:StretchToParent( 0,0,0,0 )
	
	
	GroupIfo = vgui.Create("DLabel", overview) 
	GroupIfo:SetText("loading...") 
	GroupIfo:SetFont("Trebuchet24") 
	GroupIfo:SizeToContents()
	GroupIfo:SetPos((mmwidth / 2) - (GroupIfo:GetWide() / 2), 100 ) 
	GroupIfo:SetTextColor(Color(255,0,0))


	GroupTabs:AddSheet( "Overview",  overview, "gui/silkicons/group" )
	
	
			----members
	local members = vgui.Create("Panel", GroupTabs)	
	members:StretchToParent( 0,0,0,0 )
	
	local List = vgui.Create( "DListView", members ) 
	List:SetMultiSelect( true )
	List:SetSize(300, members:GetTall() - 20)
	List:SetPos( (members:GetWide() / 2 )- (List:GetWide() / 2), 5 ) 
	List:AddColumn( "members" ) 
	List:AddColumn(  "Access" ) 
	
	List:AddLine( "[BB]Ben", "Owner" ) 	

	GroupTabs:AddSheet( "Members Online",  members, "gui/silkicons/group" )
	
	--classes
	
		groupclasslist = vgui.Create( "DPanelList", groups )
		groupclasslist:EnableVerticalScrollbar( ) 
		groupclasslist:SetSpacing(3) 
		groupclasslist:SetPadding(2) 
		
	
	GroupTabs:AddSheet( "Classes",  groupclasslist, "gui/silkicons/group" )
end

function PANEL:Think()

	if(groupud == true and RP08.Groups.Clases[playergroup])then
	
		GroupIfo:SetText("You are in the group:  " .. playergroupname .. "\nYour Rank is:  "..playerrankname)
		GroupIfo:SizeToContents()
		GroupIfo:SetPos((mmwidth / 2) - (GroupIfo:GetWide() / 2), 100 ) 

		GroupTabs:SetVisible( true )
		groupclasslist:Clear() 
	
		for k,v in pairs(RP08.Groups.Clases[playergroup])do
			local class = vgui.Create("Groups_Classes_ITEM", self)
			class:SetInfo(v.name, tonumber(v.rankneeded), v.model, v.skin, v.id)
			groupclasslist:AddItem(class)
		end		
		
		groupud = false

	end
	
end

vgui.Register( "MainMenu_Groups", PANEL, "Panel" )
	
local PANEL = {}

------Each Item----------

function PANEL:Init( )
	self.classesfunction = {}

	 self:SetTall( 75 )
	
	self.Label001 = vgui.Create("DLabel", self) 
		self.Label001:SetText("Amount: " .. team.NumPlayers(tonumber(self.i)) ) 
		self.Label001:SizeToContents()
		self.Label001:SetTextColor(Color(255,0,0))
		
		self.Label002 = vgui.Create("DLabel", self) 
		self.Label002:SetText("updating...") 
		self.Label002:SizeToContents()
		self.Label002:SetTextColor(Color(255,255,255))
	
		self.SpawnIcon001 = vgui.Create( "SpawnIcon", self ) 
		self.SpawnIcon001.DoClick = function( self1 ) return end
	
		self.button = vgui.Create("DButton", self)
		self.button:SetText("ERROR")
		self.button:SetWide(150)	
		self.button:SetConsoleCommand("bb_changeclass", self.i)
		self.button.i = self.i
		self.button.DoClick = function(self)	end
	
end

function PANEL:SetInfo(n,r,m, s, id)
	self.name = n
	self.rank = r
	self.model = m
	self.skin = s
	self.i = id

	self:UpdateInfo(self)

end

function PANEL:UpdateInfo()
	self.Label002:SetText(self.name)
	self.SpawnIcon001:SetModel( Model(self.model), 0) 
	self.SpawnIcon001:SetSkin( tonumber(self.skin) )
	self.SpawnIcon001:SetToolTip(nil)
		self:SetPaintBackground(true)
	
	if not( playerrank >= self.rank)then
		self.button:SetText("Not High Enough Rank")
		self.button.DoClick = function(self)	end
	elseif(LocalPlayer():Team( ) == self.i)then
		self.button:SetText("Current Group Class")
		self.button.DoClick = function(self)	end
	else
		self.button:SetText("Change to Group Class")
		self.button.DoClick = function()
			groupud = true
			RunConsoleCommand( "bb_changegroup", playergroup, self.i )  
			OpenMainMenu()	
		end
	end
	
	self.Label001:SizeToContents()
	self.Label002:SizeToContents()
	
	self.Label001:SetText("Amount: " .. team.NumPlayers(tonumber(self.i)) ) 
end

function PANEL:PerformLayout( )
		self.SpawnIcon001:SetPos( 5 , 5 ) 
		self.Label001:SetPos( 100, 25 )
		self.Label002:SetPos( 100, 5 )
		self.button:SetPos( 100, 50 )	
end

	
vgui.Register( "Groups_Classes_ITEM", PANEL, "DPanel" )