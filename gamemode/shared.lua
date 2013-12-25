
RP08.Teams = {}
RP08.Teams.list = {}




function RP08.Teams.AddNew(id, name, color, malemodel, femalemodel, maxallowed, needvote)
	team.SetUp(id, name, color)
	if not(malemodel) then 
		malemodel = false
	end

	if not(femalemodel)then
		femalemodel = malemodel
	end
	
	if not(maxallowed)then
		maxallowed = 64
	end
	
	
	RP08.Teams.list[id] = {name, color, malemodel, femalemodel, maxallowed, needvote}
end


RP08.Teams.AddNew( TEAM_CITIZEN, "Citizen" , Color( 20, 150, 20, 255 ), "models/player/Group01/male_02.mdl", nil, 50, false);
RP08.Teams.AddNew( TEAM_POLICE, "Police" , Color( 25, 25, 170, 255 ), "models/player/police.mdl",nil, 8, true );
RP08.Teams.AddNew( TEAM_MAYOR, "Mayor" , Color( 150, 20, 20, 255 ), "models/player/breen.mdl", nil, 1, true );
RP08.Teams.AddNew( TEAM_GANGSTER, "Gangster" , Color( 75, 75, 75, 255 ), "models/player/Group03/male_03.mdl", "models/player/Group03/Female_03.mdl", 10 );
RP08.Teams.AddNew( TEAM_MOBBOSS, "Mob Boss" , Color( 25, 25, 25, 255 ), "models/player/eli.mdl", "models/player/Group03/Female_07.mdl", 1, false);
RP08.Teams.AddNew( TEAM_WEPDEALER, "Weapon Dealer" , Color( 255, 140, 0, 255 ), "models/player/leet.mdl", nil, 3, false );
RP08.Teams.AddNew( TEAM_MEDIC, "Medic" , Color( 47, 79, 79, 255 ), "models/player/Barney.mdl", "models/player/alyx.mdl", 4, false );
RP08.Teams.AddNew( TEAM_COOK, "Cook" , Color( 238, 99, 99, 255 ), "models/player/monk.mdl", "models/player/mossman.mdl",4 );
RP08.Teams.AddNew( TEAM_POLCHIEF, "Police Chief" , Color( 20, 20, 255, 255 ), "models/player/combine_super_soldier.mdl", nil, 1, false );


local pm = FindMetaTable("Player")

function pm:IsPolice()
	return self:Team()==TEAM_POLICE or self:Team() == TEAM_POLCHIEF 
end