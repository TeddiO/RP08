function DrugPlayer(pl)
	pl:GetTable().Drugged = true
	pl:ConCommand("pp_sharpen 1")
	pl:ConCommand("pp_sharpen_contrast 5.05" )
	pl:ConCommand("pp_sharpen_distance 0.51")
	timer.Simple( 20, UnDrugPlayer, pl)
end

function UnDrugPlayer(pl)
	pl:GetTable().Drugged = false
	pl:ConCommand("pp_sharpen 0")
end