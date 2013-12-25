/*---------------------------------------------------------------------------------
	

Module.Name 	= "Hunger"
Module.Author 	= "Ben / Teddi"
Module.Email 	= "bbservers.co.uk"
Module.Website 	= "bbservers.co.uk"
---------------------------------------------------------------------------------*/

local META = FindMetaTable( "Player" )
if not META then return end

function StartingHunger( ply )
	if (!ply:GetNWBool("sleep")) then
		if ((ply.hungerSuicide or ply.Hunger == 100) and ply:Team() == ply.hungerLastTeam) then
			ply.Hunger = 5 
			ply:ChatPrint("You've arrived after a long journey and you're starving.")
		else
			ply.Hunger = 5
			ply:ChatPrint("There was no food on the train and you're hungry.")
			
		end
	end
	ply.hungerLastTeam = ply:Team()
	ply.hungerSuicide = false
end
hook.Add("PlayerSpawn","StartingHunger",StartingHunger)

timer.Create("bb_Hunger", 2, 0, function()
	for k, v in pairs(player.GetAll()) do
		if (!v:GetNWBool("sleep") and v:Alive() and !v.Arrested) then
			v.Hunger = math.Clamp(v.Hunger + 0.1, 0, 100)
			v:SetNetworkedFloat("bb_Hunger", v.Hunger)
						if (v.Hunger == 100) then
							v:SetNetworkedFloat("bb_Hunger", v.Hunger) 
							
				local World = GetWorldEntity()
				
				-- Take Damage.
				v:TakeDamage(1, World, World)
		    	end
	    	end
	   	end
		
end)
