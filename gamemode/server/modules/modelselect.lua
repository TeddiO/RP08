/*
	Model Selection stuff.
*/

local function PlayerSelectModel( ply, cmd, args )
	if !ply:IsValid() then return end
	
	if !args[1] or args[1] == "" then return end
	
	local model = args[1]
	local gender = args[2]
	
	for _,authd in pairs(CivilianModels) do
		if authd[1] == model then
			if gender then
				ply.gender = true
			end
			ply.basemodel = model
			ply:SetModel(model)
			ply:UnSpectate()
			ply:Spawn()
		end
	end
end
concommand.Add( "rp08ModelSelect", PlayerSelectModel)

hook.Add("PlayerDataLoaded","RequestModel",function(ply)
	umsg.Start("SelectModel",ply)
	umsg.End()
end)

function RP08.SetModel( pl )
	

	if(pl:Team() > 99)then
	
		if(RP08.Groups.Clases[pl:GetNWInt("playergroup")][pl:GetTable().playerclass].type != "player")then
			return
		end
	
		pl:SetModel(RP08.Groups.Clases[playergroup].model, RP08.Groups.Clases[playergroup].skin)
		return
		
	end

	print(tostring((pl:Team() != 1 and pl:Team() != 10)))
	if((RP08.Teams.list[pl:Team()][3] or (not pl:GetTable().model)) and (pl:Team() != 1 and pl:Team() != 10))then--Is there  a male or female model
		--Are We Male or female
		if (not pl.sex)then--Male
			pl:SetModel( RP08.Teams.list[pl:Team()][3] );--yes
		else--Female
			pl:SetModel( RP08.Teams.list[pl:Team()][4] );--Does this team have a female model?
		end
		
	else
		if(pl:GetTable().model)then
			
			pl:SetModel(pl:GetTable().model);--Use the model selected at begining if no model
		else
			pl:SetModel(MaleCivModels[math.random( 1, #MaleCivModels )])
		end
	end
	return false	
end
hook.Add("PlayerSetModel", "PlayerSetModel", RP08.SetModel)