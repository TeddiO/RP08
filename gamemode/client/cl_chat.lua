bb_Chat = {}

-- Create some client convars that we'll need.
CreateClientConVar("bb_chat_radio", "1", true, true)
CreateClientConVar("bb_chat_ooc", "1", true, true)
CreateClientConVar("bb_chat_ic", "1", true, true)
CreateClientConVar("bb_chat_advert", "1", true, true)
CreateClientConVar("bb_chat_joinleave", "1", true, true)

-- Create Font.
surface.CreateFont("Tahoma", 14, 600, true, false, "bb_Chat_MainText")

-- Emoticons.
bb_Chat.Messages = {}
bb_Chat.Derma = {}

-- History.
bb_Chat.History = {}
bb_Chat.History.Messages = {}
bb_Chat.History.Position = 0

-- Hook.
usermessage.Hook("bb_Chat_Player_Message", function(Message)
	local Player = Message:ReadEntity()
	local Filter = Message:ReadString()
	local Text = Message:ReadString()
	
	-- Check Is Player.
	if ( !Player:IsPlayer() ) then
		bb_Chat.ChatText(nil, nil, Text, Filter)	
	end
	
	-- Chat Text.
	bb_Chat.ChatText(Player:EntIndex(), Player:Name(), Text, Filter)
end)

-- Hook.
usermessage.Hook("bb_Chat_Message", function(Message)
	local Filter = Message:ReadString()
	local Text = Message:ReadString()
	
	-- Chat Text.
	bb_Chat.ChatText(nil, nil, Text, Filter)
end)


-- Get Position.
function bb_Chat.GetPosition()
	local X, Y = 9, ScrH() - (ScrH() / 4)
	
	-- Check Position.
	if (bb_Chat.Position) then Y = bb_Chat.Position end
	
	-- Return X.
	return X, Y
end

-- Get X.
function bb_Chat.GetX()
	local X, Y = bb_Chat.GetPosition()
	
	-- Return X.
	return X
end

-- Get Y.
function bb_Chat.GetY()
	local X, Y = bb_Chat.GetPosition()
	
	-- Return Y.
	return Y
end

-- Get Spacing.
function bb_Chat.GetSpacing(Message)
	if (Message) then
		return 20
	else
		return 20
	end
end

-- Create Derma All.
function bb_Chat.CreateDermaAll()
	bb_Chat.CreateDermaPanel()
	bb_Chat.CreateDermaCheckBoxes()
	bb_Chat.CreateDermaButtons()
	bb_Chat.CreateDermaFilters()
	bb_Chat.CreateDermaTextEntry()

	-- Hide.
	bb_Chat.Derma.Panel.Hide()
end

-- Create Derma Buttons.
function bb_Chat.CreateDermaButtons()
	if (!bb_Chat.Derma.Buttons) then
		bb_Chat.Derma.Buttons = {}
		
		-- Create Derma Button.
		bb_Chat.CreateDermaButton("Up", "+", 434, 16, "Scroll up the message area.", function()
			bb_Chat.History.Position = bb_Chat.History.Position - 1
		end, function(self)
			if (bb_Chat.History.Messages[bb_Chat.History.Position - 5]) then
				self:SetDisabled(false)
			else
				self:SetDisabled(true)
			end
		end)
		bb_Chat.CreateDermaButton("Down", "-", 454, 16, "Scroll down the message area.", function()
			bb_Chat.History.Position = bb_Chat.History.Position + 1
		end, function(self)
			if (bb_Chat.History.Messages[bb_Chat.History.Position + 1]) then
				self:SetDisabled(false)
			else
				self:SetDisabled(true)
			end
		end)
		bb_Chat.CreateDermaButton("Bottom", "*", 474, 16, "Goto the bottom of the message area.", function()
			bb_Chat.History.Position = #bb_Chat.History.Messages
		end, function(self)
			if (bb_Chat.History.Position < #bb_Chat.History.Messages) then
				self:SetDisabled(false)
			else
				self:SetDisabled(true)
			end
		end)
		bb_Chat.CreateDermaButton("Filters", "Filters", 494, 80, "Enable or disable message filters.", function()
			local IsVisible = bb_Chat.Derma.Filters:IsVisible()
			
			-- Check Is Visible.
			if (IsVisible) then
				bb_Chat.Derma.Filters:SetVisible(false)
			else
				bb_Chat.Derma.Filters:SetVisible(true)
			end
		end, function(self) end)
	end
end
	
-- Create Derma Button.
function bb_Chat.CreateDermaButton(Name, Text, X, Width, ToolTip, DoClick, Think)
	if (!bb_Chat.Derma.Buttons[Name]) then
		bb_Chat.Derma.Buttons[Name] = vgui.Create("DButton", bb_Chat.Derma.Panel)
		bb_Chat.Derma.Buttons[Name]:SetText(Text)
		bb_Chat.Derma.Buttons[Name]:SetSize(Width, 16)
		bb_Chat.Derma.Buttons[Name]:SetPos(X, 4)
		bb_Chat.Derma.Buttons[Name]:SetToolTip(ToolTip)
		bb_Chat.Derma.Buttons[Name].DoClick = DoClick
		bb_Chat.Derma.Buttons[Name].Think = Think
	end
end

-- Create Derma Check Boxes.
function bb_Chat.CreateDermaCheckBoxes()
	if (!bb_Chat.Derma.CheckBoxes) then bb_Chat.Derma.CheckBoxes = {} end
end

-- Create Derma Check Box.
function bb_Chat.CreateDermaCheckBox(Name, ConVar, X, ToolTip, Label, Parent, Y)
	if (!bb_Chat.Derma.CheckBoxes[Name]) then
		Parent = Parent or bb_Chat.Derma.Panel
		Y = Y or 4
		
		-- Check Label.
		if (Label) then
			bb_Chat.Derma.CheckBoxes[Name] = vgui.Create("DCheckBoxLabel", Parent)
			bb_Chat.Derma.CheckBoxes[Name]:SetText(Label)
		else
			bb_Chat.Derma.CheckBoxes[Name] = vgui.Create("DCheckBox", Parent)
		end
		
		-- Set Pos.
		bb_Chat.Derma.CheckBoxes[Name]:SetPos(X, Y)
		bb_Chat.Derma.CheckBoxes[Name]:SetToolTip(ToolTip)
		bb_Chat.Derma.CheckBoxes[Name]:SetConVar(ConVar)
		
		-- Check Label.
		if (Label) then
			bb_Chat.Derma.CheckBoxes[Name]:SizeToContents()
		else
			bb_Chat.Derma.CheckBoxes[Name]:SetSize(16, 16)
		end
	end
end

-- Create Derma Text Entry.
function bb_Chat.CreateDermaTextEntry()
	if (!bb_Chat.Derma.TextEntry) then
		bb_Chat.Derma.TextEntry = vgui.Create("DTextEntry", bb_Chat.Derma.Panel)
		bb_Chat.Derma.TextEntry:SetPos(34, 4)
		bb_Chat.Derma.TextEntry:SetSize(396, 16)
		bb_Chat.Derma.TextEntry.OnEnter = function()
			local Message = bb_Chat.Derma.TextEntry:GetValue()
			
			-- Check Message.
			if (Message and Message != "") then
				bb_Chat.History.Position = #bb_Chat.History.Messages
				
				-- Message.
				Message = string.Replace(Message, '"', '\"')
				
				-- Check Say Team.
				if (bb_Chat.SayTeam) then
					LocalPlayer():ConCommand("say_team \""..Message.."\"\n")
				else
					LocalPlayer():ConCommand("say \""..Message.."\"\n")
				end
				
				-- Set Text.
				bb_Chat.Derma.TextEntry:SetText("")
			end
			
			-- Hide.
			bb_Chat.Derma.Panel.Hide()
		end
		
		-- Think.
		function bb_Chat.Derma.TextEntry:Think()
			local Message = self:GetValue()
			
			-- Check Len.
			if (string.len(Message) > 126) then
				self:SetValue(string.sub(Message, 1, 126))
				self:SetCaretPos(126)
				
				-- Play Sound.
				surface.PlaySound("common/talk.wav")
			end
		end
	end
end

-- Create Derma Filters.
function bb_Chat.CreateDermaFilters()
	if (!bb_Chat.Derma.Filters) then
		bb_Chat.Derma.Filters = vgui.Create("EditablePanel")
		bb_Chat.Derma.Filters:SetSize(116, 112)
		
		-- Paint.
		function bb_Chat.Derma.Filters:Paint()
			local BackgroundColor = Color(0, 0, 0, 150)
			local CornerSize = 4
			local TitleColor = Color(50, 255, 50, 255)
			local TextColor = Color(255, 255, 255, 255)
			
			-- Rounded Box.
			draw.RoundedBox(CornerSize, 0, 0, self:GetWide(), self:GetTall(), BackgroundColor)
		end
		
		-- Think.
		function bb_Chat.Derma.Filters:Think()
			local X = bb_Chat.Derma.Panel.x + bb_Chat.Derma.Panel:GetWide() + 4
			local Y = bb_Chat.Derma.Panel.y + bb_Chat.Derma.Panel:GetTall() - self:GetTall()
			
			-- Set Pos.
			self:SetPos(X, Y)
		end
		
		-- Create Derma Check Box.
		bb_Chat.CreateDermaCheckBox("Radio", "bb_chat_radio", 8, "Filter radio messages.", "Filter Radio", bb_Chat.Derma.Filters, 8)
		bb_Chat.CreateDermaCheckBox("OOC", "bb_chat_ooc", 8, "Filter out-of-character messages.", "Filter OOC", bb_Chat.Derma.Filters, 28)
		bb_Chat.CreateDermaCheckBox("IC", "bb_chat_ic", 8, "Filter in-character messages.", "Filter IC", bb_Chat.Derma.Filters, 48)
		bb_Chat.CreateDermaCheckBox("advert", "bb_chat_advert", 8, "Filter advert messages.", "Filter Adverts", bb_Chat.Derma.Filters, 68)
		bb_Chat.CreateDermaCheckBox("Join/Leave", "bb_chat_joinleave", 8, "Filter join/leave messages.", "Filter Join/Leave", bb_Chat.Derma.Filters, 88)
	end
end

-- Create Derma Panel.
function bb_Chat.CreateDermaPanel()
	if (!bb_Chat.Derma.Panel) then
		bb_Chat.Derma.Panel = vgui.Create("EditablePanel")
		bb_Chat.Derma.Panel:SetSize(576, 24)
		bb_Chat.Derma.Panel.Show = function()
			bb_Chat.Derma.Panel:SetKeyboardInputEnabled(true)
			bb_Chat.Derma.Panel:SetMouseInputEnabled(true)
			
			-- Set Visible.
			bb_Chat.Derma.Scroll:SetVisible(true)
			bb_Chat.Derma.Panel:SetVisible(true)
			bb_Chat.Derma.Panel:MakePopup()
			
			-- Position.
			bb_Chat.History.Position = #bb_Chat.History.Messages
			
			-- Request Focus.
			bb_Chat.Derma.TextEntry:RequestFocus()
		end
		bb_Chat.Derma.Panel.Hide = function()
			bb_Chat.Derma.Panel:SetKeyboardInputEnabled(false)
			bb_Chat.Derma.Panel:SetMouseInputEnabled(false)
			
			-- Set Text.
			bb_Chat.Derma.TextEntry:SetText("")
			
			-- Set Visible.
			bb_Chat.Derma.Panel:SetVisible(false)
			bb_Chat.Derma.Scroll:SetVisible(false)
			bb_Chat.Derma.Filters:SetVisible(false)
		end
		
		-- Paint.
		function bb_Chat.Derma.Panel:Paint()
			local BackgroundColor = Color(0, 0, 0, 150)
			local CornerSize = 4
			local TitleColor = Color(50, 255, 50, 255)
			local TextColor = Color(255, 255, 255, 255)
			
			-- Rounded Box.
			draw.RoundedBox(CornerSize, 0, 0, self:GetWide(), self:GetTall(), BackgroundColor)
			
			-- Set Font.
			surface.SetFont("bb_Chat_MainText")
			
			-- Width.
			local Width = surface.GetTextSize("Say")
			
			-- Check Say Team.
			if (bb_Chat.SayTeam) then
				Width = surface.GetTextSize("Say Team")
				
				-- Simple Text.
				draw.SimpleText("Say Team", "bb_Chat_MainText", 5, 13, Color(0, 0, 0, 255), 0, 1)
				draw.SimpleText("Say Team", "bb_Chat_MainText", 4, 12, TitleColor, 0, 1)
				
				-- Text Entry.
				bb_Chat.Derma.TextEntry:SetPos(74, 4)
				bb_Chat.Derma.TextEntry:SetSize(356, 16)
			else
				draw.SimpleText("Say", "bb_Chat_MainText", 5, 13, Color(0, 0, 0, 255), 0, 1)
				draw.SimpleText("Say", "bb_Chat_MainText", 4, 12, TitleColor, 0, 1)
				
				-- Text Entry.
				bb_Chat.Derma.TextEntry:SetPos(34, 4)
				bb_Chat.Derma.TextEntry:SetSize(396, 16)
			end
			
			-- Simple Text.
			draw.SimpleText(":", "bb_Chat_MainText", 5 + Width, 13, Color(0, 0, 0, 255), 0, 1)
			draw.SimpleText(":", "bb_Chat_MainText", 4 + Width, 12, TextColor, 0, 1)
		end
		
		-- Think.
		function bb_Chat.Derma.Panel:Think()
			local X, Y = bb_Chat.GetPosition()
			
			-- Set Pos.
			bb_Chat.Derma.Panel:SetPos(X, Y + 6)
			
			-- Check Is Visible.
			if (self:IsVisible() and input.IsKeyDown(KEY_ESCAPE)) then bb_Chat.Derma.Panel.Hide() end
		end
		
		-- Scroll.
		bb_Chat.Derma.Scroll = vgui.Create("Panel")
		bb_Chat.Derma.Scroll:SetPos(0, 0)
		bb_Chat.Derma.Scroll:SetSize(0, 0)
		
		-- On Mouse Wheeled.
		function bb_Chat.Derma.Scroll:OnMouseWheeled(Delta)
			local IsVisible = bb_Chat.Derma.Panel:IsVisible()
			
			-- Check Is Visible.
			if (IsVisible) then
				if (Delta > 0) then
					if (bb_Chat.History.Messages[bb_Chat.History.Position - 5]) then
						bb_Chat.History.Position = bb_Chat.History.Position - 1
					end
				else
					if (bb_Chat.History.Messages[bb_Chat.History.Position + 1]) then
						bb_Chat.History.Position = bb_Chat.History.Position + 1
					end
				end
			end
		end
	end
end

-- Player Bind Press.
function bb_Chat.PlayerBindPress(Player, Bind, Press)
	if (Bind == "toggleconsole") then
		bb_Chat.Derma.Panel.Hide()
	elseif (Bind == "messagemode" and Press) then
		bb_Chat.Derma.Panel.Show()
		bb_Chat.SayTeam = false
		
		-- Return True.
		return true
	elseif (Bind == "messagemode2" and Press) then
		bb_Chat.Derma.Panel.Show()
		bb_Chat.SayTeam = false -- (normally true).
		
		-- Return True.
		return true
	end
end

-- Add.
hook.Add("PlayerBindPress", "bb_Chat.PlayerBindPress", bb_Chat.PlayerBindPress)

-- Message Add.
function bb_Chat.MessageAdd(Title, Name, Text, Filtered)
	local Message = {}
	
	-- Check Title.
	if (Title) then
		Message.Title = {}
		Message.Title.Text = Title[1]
		Message.Title.Color = Title[2] or Color(255, 255, 255, 255)
	end
	
	-- Check Name.
	if (Name) then
		Message.Name = {}
		Message.Name.Text = Name[1]
		Message.Name.Color = Name[2] or Color(255, 255, 255, 255)
	end
	
	-- Time Start.
	Message.TimeStart = CurTime()
	Message.TimeFade = Message.TimeStart + 10
	Message.TimeFinish = Message.TimeFade + 1
	Message.Spacing = 0
	Message.Blocks = {}
	Message.Color = Text[2] or Color(255, 255, 255, 255)
	Message.Alpha = 255
	Message.Lines = 1
	Message.Text = string.Explode(" ", Text[1])
	
	-- Extract Types.
	bb_Chat.ExtractTypes(Message)
	bb_Chat.PrintConsole(Message)
	
	-- Check Filtered.
	if (Filtered) then return end
	
	-- Check Position.
	if (bb_Chat.History.Position == #bb_Chat.History.Messages) then
		bb_Chat.History.Position = #bb_Chat.History.Messages + 1
	end
	
	-- Check Messages.
	if (#bb_Chat.Messages == 5) then table.remove(bb_Chat.Messages, 5) end
	
	-- Copy.
	local Copy = table.Copy(Message)
	
	-- Insert.
	table.insert(bb_Chat.Messages, 1, Message)
	table.insert(bb_Chat.History.Messages, Copy)
	
	-- Play Sound.
	surface.PlaySound("common/talk.wav")
end

-- Print Console.
function bb_Chat.PrintConsole(Message)
	local String = ""
	
	-- Check Title.
	if (Message.Title) then String = String..Message.Title.Text.." " end
	if (Message.Name) then String = String..Message.Name.Text..": " end
	
	-- For Loop.
	for K, V in pairs(Message.Blocks) do
		local Space = " "
		
		-- Check K.
		if (K == #Message.Blocks) then Space = "" end
		
		-- Check Break.
		if (V.Break) then Space = "" end
		
		-- Check Type.
		if (V.Type == "Text") then String = String..V.Text..Space end
		
		-- Check Break.
		if (V.Break) then
			print(String)
			
			-- String.
			String = ""
		end
	end
	
	-- Check String.
	if (String != "") then print(String) end
end

-- Extract Types.
function bb_Chat.ExtractTypes(Message)
	local Length = 0
	
	-- Check Title.
	if (Message.Title) then Length = Length + string.len(Message.Title.Text) end
	if (Message.Name) then Length = Length + string.len(Message.Name.Text..":") end
	
	-- Set Font.
	surface.SetFont("bb_Chat_MainText")
	
	-- For Loop.
	for K, V in pairs(Message.Text) do
		local Extracted = false
		
		-- Characters.
		local Characters = string.len(V) + 1
		
		-- Check Length.
		if (Length + Characters >= 75) then
			local Break = math.Clamp(Characters - ((Length + Characters) - 75), 0, Characters)
			
			-- Dash.
			local Dash = "-"
			local One = string.sub(V, 1, Break)
			local Two = string.sub(V, Break + 1)
			
			-- Check Find.
			if (string.find(string.sub(One, -1), "%p")) then Dash = "" end
			if (string.find(string.sub(Two, 1, 1), "%p")) then
				Dash, One, Two = "", One..string.sub(Two, 1, 1), string.sub(Two, 2)
			end
			
			-- Check One.
			if (One == "" or Two == "") then Dash = "" end
			
			-- Check Insert.
			table.insert(Message.Blocks, {Type = "Text", Text = One..Dash, Break = true})
			
			-- Check Two.
			if (Two != "") then table.insert(Message.Blocks, {Type = "Text", Text = Two}) end
			
			-- Lines.
			Message.Lines = Message.Lines + 1
			
			-- Length.
			Length = string.len(Two)
			Extracted = true
		end
		
		-- Check Extracted.
		if (!Extracted) then
			Length = Length + Characters
			
			-- Insert.
			table.insert(Message.Blocks, {Type = "Text", Text = V})
		end
	end
	
	-- For Loop.
	for K, V in pairs(Message.Blocks) do
		if (V.Break) then
			if (!Message.Blocks[K + 1]) then
				Message.Blocks[K].Break = false
				
				-- Lines.
				Message.Lines = Message.Lines - 1
			end
		end
	end
end

-- Think.
function bb_Chat.Think()
	local Time = CurTime()
	
	-- For Loop.
	for K, V in pairs(bb_Chat.Messages) do
		if (Time >= V.TimeFade) then
			local FadeTime = V.TimeFinish - V.TimeFade
			local TimeLeft = V.TimeFinish - Time
			local Alpha = math.Clamp((255 / FadeTime) * TimeLeft, 0, 255)
			
			-- Check Alpha.
			if (Alpha == 0) then
				table.remove(bb_Chat.Messages, K)
			else
				V.Alpha = Alpha
			end
		end
	end
end

-- Add.
hook.Add("Think", "bb_Chat.Think", bb_Chat.Think)

-- HUD Paint.
function bb_Chat.HUDPaint()
	local X, Y = bb_Chat.GetPosition()
	
	-- Set Font.
	surface.SetFont("bb_Chat_MainText")
	
	-- Space.
	local Space = surface.GetTextSize(" ")
	local Box = {Width = 0, Height = 0}
	
	-- Table.
	local Table = bb_Chat.Messages
	local IsVisible = bb_Chat.Derma.Panel:IsVisible()
	
	-- Check Is Visible.
	if (IsVisible) then
		Table = {}
		
		-- For Loop.
		for I = 0, 4 do
			table.insert(Table, bb_Chat.History.Messages[bb_Chat.History.Position - I])
		end
	else
		if (#bb_Chat.History.Messages > 100) then
			local Amount = #bb_Chat.History.Messages - 100
			
			-- For Loop.
			for I = 1, Amount do table.remove(bb_Chat.History.Messages, 1) end
		end
	end
	
	-- For Loop.
	for K, V in pairs(Table) do
		if (Table[K - 1]) then Y = Y - Table[K - 1].Spacing end
		
		-- Is Visible.
		local IsVisible = bb_Chat.Derma.Panel:IsVisible()
		
		-- Check Is Visible.
		if (!IsVisible and K == 1) then
			Y = Y - ((bb_Chat.GetSpacing() + V.Spacing) * (V.Lines - 1)) + 14
		else
			if (K == 1) then Y = Y + 2 end
			
			-- Y.
			Y = Y - ((bb_Chat.GetSpacing() + V.Spacing) * V.Lines)
		end
		
		-- Message X.
		local MessageX = X
		local MessageY = Y
		
		-- Check Title.
		if (V.Title) then
			local Width = surface.GetTextSize(V.Title.Text)
			
			-- Title Color.
			local TitleColor = Color(V.Title.Color.r, V.Title.Color.g, V.Title.Color.b, V.Alpha)
			
			-- Draw.
			draw.SimpleText(V.Title.Text, "bb_Chat_MainText", MessageX + 1, MessageY + 1, Color(0, 0, 0, V.Alpha), 0, 0)
			draw.SimpleText(V.Title.Text, "bb_Chat_MainText", MessageX, MessageY, TitleColor, 0, 0)
			
			-- Message X.
			MessageX = MessageX + Width + Space
		end
		
		-- Check Name.
		if (V.Name) then
			local Width = surface.GetTextSize(V.Name.Text)
			
			-- Name Color.
			local NameColor = Color(V.Name.Color.r, V.Name.Color.g, V.Name.Color.b, V.Alpha)
			
			-- Draw.
			draw.SimpleText(V.Name.Text, "bb_Chat_MainText", MessageX + 1, MessageY + 1, Color(0, 0, 0, V.Alpha), 0, 0)
			draw.SimpleText(V.Name.Text, "bb_Chat_MainText", MessageX, MessageY, NameColor, 0, 0)
			
			-- Message X.
			MessageX = MessageX + Width
			
			-- Width.
			local Width = surface.GetTextSize(":")
			
			-- Text.
			draw.SimpleText(":", "bb_Chat_MainText", MessageX + 1, MessageY + 1, Color(0, 0, 0, V.Alpha), 0, 0)
			draw.SimpleText(":", "bb_Chat_MainText", MessageX, MessageY, Color(255, 255, 255, V.Alpha), 0, 0)
			
			-- Message X.
			MessageX = MessageX + Width + Space
		end
		
		-- Text Color.
		local TextColor = Color(V.Color.r, V.Color.g, V.Color.b, V.Alpha)
		local Tag = nil
		
		-- For Loop.
		for K2, V2 in pairs(V.Blocks) do
			if (V2.Type == "Text") then
				local Width = surface.GetTextSize(V2.Text)
				
				-- Draw.
				draw.SimpleText(V2.Text, "bb_Chat_MainText", MessageX + 1, MessageY + 1, Color(0, 0, 0, V.Alpha), 0, 0)
				draw.SimpleText(V2.Text, "bb_Chat_MainText", MessageX, MessageY, TextColor, 0, 0)
				
				-- Message X.
				MessageX = MessageX + Width + Space
			end
			
			-- Check Message X.
			if (MessageX - 8 > Box.Width) then Box.Width = MessageX - 8 end
			if (bb_Chat.GetY() - Y > Box.Height) then Box.Height = bb_Chat.GetY() - Y end
			
			-- Check Break.
			if (V2.Break) then
				MessageY = MessageY + bb_Chat.GetSpacing() + V.Spacing
				MessageX = X
			end
		end
	end
	
	-- Set Pos.
	bb_Chat.Derma.Scroll:SetPos(X, Y)
	bb_Chat.Derma.Scroll:SetSize(Box.Width, Box.Height)
end

-- Add.
hook.Add("HUDPaint", "bb_Chat.HUDPaint", bb_Chat.HUDPaint)

-- Start Chat.
function bb_Chat.StartChat(Team) return true end

-- Add.
hook.Add("StartChat", "bb_Chat.StartChat", bb_Chat.StartChat)

-- Chat Text.
function bb_Chat.ChatText(Index, Name, Text, Filter)
	local Type = Filter
	local Filtered = false
	
	-- Check Filter.
	if (Filter == "arrested" or Filter == "yell" or Filter == "whisper" or Filter == "looc"
	or Filter == "request") then
		Filter = "ic"
	end
	
	-- Check ConVar Exists.
	if (ConVarExists("bb_chat_"..Filter) and GetConVarNumber("bb_chat_"..Filter) == 0) then
		Filtered = true
	end
	
	-- Player.
	local Player = player.GetByID(Index)
	
	-- Check Player.
	if (ValidEntity(Player)) then
		local Team = Player:Team()
		local TeamColor = team.GetColor(Team)
		
		-- Check Filter.
		if (Type == "chat") then
			bb_Chat.MessageAdd(nil, {Name, TeamColor}, {Text}, Filtered)
		elseif (Type == "ic") then
			bb_Chat.MessageAdd(nil, nil, {Name..": "..Text, Color(255, 255, 150, 255)}, Filtered)
		elseif (Type == "advert") then
			bb_Chat.MessageAdd({"(Advert)"}, nil, {Name..": "..Text, Color(200, 150, 225, 255)}, Filtered)
		elseif (Type == "yell") then
			bb_Chat.MessageAdd({"(Yell)"}, nil, {Name..": "..Text, Color(255, 255, 150, 255)}, Filtered)
		elseif (Type == "whisper") then
			bb_Chat.MessageAdd({"(Whisper)"}, nil, {Name..": "..Text, Color(255, 255, 150, 255)}, Filtered)
		elseif (Type == "looc") then
			bb_Chat.MessageAdd({"(Local OOC)", Color(255, 75, 75, 255)}, nil, {Name..": "..Text, Color(255, 255, 150, 255)}, Filtered)
		elseif (Type == "radio") then
			bb_Chat.MessageAdd({"(Radio)"}, nil, {Name..": "..Text, Color(200, 255, 125, 255)}, Filtered)
		elseif (Type == "arrested") then
			bb_Chat.MessageAdd({"(Arrested)"}, nil, {Name..": "..Text, Color(255, 255, 150, 255)}, Filtered)
		elseif (Type == "request") then
			bb_Chat.MessageAdd({"(Request)"}, nil, {Name..": "..Text, Color(125, 200, 255, 255)}, Filtered)
		elseif (Type == "broadcast") then
			bb_Chat.MessageAdd({"(Broadcast)"}, nil, {Name..": "..Text, Color(255, 75, 75, 255)}, Filtered)
		elseif (Type == "pm") then
			bb_Chat.MessageAdd({"(PM)"}, nil, {Name..": "..Text, Color(255, 150, 125, 255)}, Filtered)
		elseif (Type == "ooc") then
			bb_Chat.MessageAdd({"(OOC)", Color(255, 75, 75, 255)}, {Name, TeamColor}, {Text}, Filtered)
		end
	else
		if (Name == "Console" and Type == "chat") then
			bb_Chat.MessageAdd({"(OOC)"}, {"Console", Color(150, 150, 150, 255)}, {Text}, Filtered)
		elseif (Filter == "joinleave") then
			Text = Text.."."
			
			-- Check Find.
			if (string.find(Text, "%(") and string.find(Text, "%)")) then
				Text = string.gsub(Text, "Kicked by Console :", "Kicked by Console:", 1)
				Text = string.gsub(Text, "%.%)", ")")
				
				-- Message Add.
				bb_Chat.MessageAdd(nil, nil, {Text, Color(255, 75, 75, 255)}, Filtered)
			else
				bb_Chat.MessageAdd(nil, nil, {Text, Color(175, 255, 125, 255)}, Filtered)
			end
		else
			bb_Chat.MessageAdd(nil, nil, {Text, Color(255, 255, 150, 255)}, Filtered)
		end
	end
	
	-- Return True.
	return true
end

-- Add.
hook.Add("ChatText", "bb_Chat.ChatText", bb_Chat.ChatText)

-- Create Derma All.
bb_Chat.CreateDermaAll()