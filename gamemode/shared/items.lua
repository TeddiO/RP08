RP08.ItemData = {}

----------/* Shotgun + Automatic Weapons*/----------

------Shotgun-----
RP08.ItemData["weapon_pumpshotgun"] = 
{
	OnUse = function(item, pl) pl:Give( "weapon_pumpshotgun_bb") end,
	Workshop = true,
	UniqueID = "weapon_pumpshotgun",
	Desc = "A very high powered weapon, packing alot of punch.",
	Model = "models/weapons/w_shot_m3super90.mdl",
	BatchAmount = 10,
	Name = "Pump Shotgun",
	Weight = 5,
	Team = 6,
	Usable = true,
	Costperitem = 3500,
	Size = 2,
	Dropable=true,
}

-----------MP5------------
RP08.ItemData["weapon_mp5"] = 
{
	OnUse = function(item, pl) pl:Give( "weapon_mp5_bb") end,
	Workshop = true,
	UniqueID = "weapon_mp5",
	Desc = "A small sub-machine gun with alot of punch.",
	Model = "models/weapons/w_smg_mp5.mdl",
	BatchAmount = 10,
	Name = "MP5",
	Weight = 3,
	Team = 6,
	Usable = true,
	Costperitem = 1200,
	Size = 2,
	Dropable=true,
}
	
-----M4-----
RP08.ItemData["weapon_m4"] = 
{
	OnUse = function(item, pl) pl:Give( "weapon_m4_bb") end,
	Workshop = true,
	UniqueID = "weapon_m4",
	Desc = "A powerful rifle used in the special forces.",
	Model = "models/weapons/w_rif_m4a1.mdl",
	BatchAmount = 10,
	Name = "M16",
	Weight = 3,
	Team = 6,
	Usable = true,
	Costperitem = 2500,
	Size = 2,
	Dropable=true,
}
	
-------Mac10------
RP08.ItemData["weapon_mac10"] = 
{
	OnUse = function(item, pl) pl:Give( "weapon_mac10_bb") end,
	Workshop = true,
	UniqueID = "weapon_mac10",
	Desc = "The Mac 10 has a lot of punch for a small gun.",
	Model = "models/weapons/w_smg_mac10.mdl",
	BatchAmount = 10,
	Name = "Mac 10",
	Weight = 2,
	Team = 6,
	Usable = true,
	Costperitem = 1500,
	Size = 2,
	Dropable=true,
}

-------AK74------
RP08.ItemData["weapon_ak74"] = 
{
	OnUse = function(item, pl) pl:Give( "weapon_mayorram") end,
	Workshop = false,
	UniqueID = "weapon_ak74",
	Desc = "The Mac 10 has a lot of punch for a small gun.",
	Model = "models/weapons/w_smg_mac10.mdl",
	BatchAmount = 10,
	Name = "AK74",
	Weight = 0,
	Team = 6,
	Usable = true,
	Costperitem = 1500,
	Size = 0,
	Dropable=false,
}


-------P90------
RP08.ItemData["weapon_p90"] = 
{
	OnUse = function(item, pl) pl:Give( "weapon_p90_bb") end,
	Workshop = true,
	UniqueID = "weapon_p90",
	Desc = "The P90 is fast and accurate",
	Model = "models/weapons/w_smg_p90.mdl",
	BatchAmount = 10,
	Name = "P90",
	Weight = 3,
	Team = 6,
	Usable = true,
	Costperitem = 2500,
	Size = 2,
	Dropable=true,
}

-----------Krieg552---------
RP08.ItemData["weapon_krieg552"] = 
{
	OnUse = function(item, pl) pl:Give( "weapon_krieg552_bb") end,
	Workshop = true,
	UniqueID = "weapon_krieg552",
	Desc = "An automatic sniper",
	Model = "models/weapons/w_snip_sg550.mdl",
	BatchAmount = 10,
	Name = "Krieg552",
	Weight = 1,
	Team = 6,
	Usable = true,
	Costperitem = 4000,
	Size = 1,
	Dropable=true,
}

----------Sniper--------	
RP08.ItemData["ls_sniper"] = 
{
	OnUse = function(item, pl) pl:Give( "ls_sniper_bb") end,
	Workshop = true,
	UniqueID = "ls_sniper",
	Desc = "A very powerful rifle. Manufactured by BiffCorp.",
	Model = "models/weapons/w_snip_awp.mdl",
	BatchAmount = 10,
	Name = "Sniper",
	Weight = 4,
	Team = 6,
	Usable = true,
	Costperitem = 5500,
	Size = 3,
	Dropable=true,
}

-----AK47---------
RP08.ItemData["weapon_ak47"] = 
{
	OnUse = function(item, pl) pl:Give( "weapon_ak47_bb") end,
	Workshop = true,
	UniqueID = "weapon_ak47",
	Desc = "A very powerful rifle with a lot of punch.",
	Model = "models/weapons/w_rif_ak47.mdl",
	BatchAmount = 10,
	Name = "AK47",
	Weight = 4,
	Team = 6,
	Usable = true,
	Costperitem = 2000,
	Size = 2,
	Dropable=true,
}

/*END OF AUTOMATICS*/

---------------/*PISTOLS*/------------

------------Five-Seven---------
RP08.ItemData["weapon_fiveseven"] = 
{
	OnUse = function(item, pl) pl:Give( "weapon_fiveseven_bb") end,
	Workshop = true,
	UniqueID = "weapon_fiveseven",
	Desc = "A small pistol which packs very little damage.",
	Model = "models/weapons/w_pist_fiveseven.mdl",
	BatchAmount = 10,
	Name = "FiveSeven",
	Weight = 2,
	Team = 6,
	Usable = true,
	Costperitem = 300,
	Size = 2,
	Dropable=true,
}

---------Deagle---------
RP08.ItemData["weapon_deagle"] = 
{
	OnUse = function(item, pl) pl:Give( "weapon_deagle_bb") end,
	Workshop = true,
	UniqueID = "weapon_deagle",
	Desc = "A very powerful pistol with a lot of punch.",
	Model = "models/weapons/w_pist_deagle.mdl",
	BatchAmount = 10,
	Name = "Deagle",
	Weight = 2,
	Team = 6,
	Usable = true,
	Costperitem = 400,
	Size = 2,
	Dropable=true,
}

-----------Glock---------
RP08.ItemData["weapon_glock"] = 
{
	OnUse = function(item, pl) pl:Give( "weapon_glock_bb") end,
	Workshop = true,
	UniqueID = "weapon_glock",
	Desc = "A small but effictive pistol.",
	Model = "models/weapons/w_pist_glock18.mdl",
	BatchAmount = 10,
	Name = "Glock",
	Weight = 2,
	Team = 6,
	Usable = true,
	Costperitem = 200,
	Size = 2,
	Dropable=true,
}

-----------USP---------
RP08.ItemData["weapon_usp"] = 
{
	OnUse = function(item, pl) pl:Give( "weapon_usp_bb") end,
	Workshop = true,
	UniqueID = "weapon_usp",
	Desc = "A small silenced pistol. Manufactured by BiffCorp.",
	Model = "models/weapons/w_pist_usp.mdl",
	BatchAmount = 10,
	Name = "USP",
	Weight = 1,
	Team = 6,
	Usable = true,
	Costperitem = 750,
	Size = 1,
	Dropable=true,
}

-----------357---------
RP08.ItemData["weapon_357"] = 
{
	OnUse = function(item, pl) pl:Give( "weapon_357_bb") end,
	Workshop = true,
	UniqueID = "weapon_357",
	Desc = "Powerful, but slow shooting weapon",
	Model = "models/weapons/w_357.mdl",
	BatchAmount = 10,
	Name = "357",
	Weight = 1,
	Team = 6,
	Usable = true,
	Costperitem = 2000,
	Size = 1,
	Dropable=true,
}

---------------*/END OF PISTOLS/*--------

--------*/Ammo*/---------

-----Pistol Ammo--------
RP08.ItemData["ammo_pistol"] = 
{
	OnUse = function(item, pl) pl:GiveAmmo( 30, "pistol") end,
	Workshop = true,
	UniqueID = "ammo_pistol",
	Desc = "Used to fill up pistols.",
	Model = "models/Items/BoxSRounds.mdl",
	BatchAmount = 5,
	Name = "Pistol Ammo",
	Weight = 3,
	Team = 6,
	Usable = true,
	Costperitem = 60,
	Size = 1,
	Dropable=true,
}

--------Shotgun Ammo-------
RP08.ItemData["ammo_shotgun"] = 
{
	OnUse = function(item, pl) pl:GiveAmmo( 24, "buckshot") end,
	Workshop = true,
	UniqueID = "ammo_shotgun",
	Desc = "Used to fill up shotguns.",
	Model = "models/Items/BoxBuckshot.mdl",
	BatchAmount = 7,
	Name = "Shotgun Ammo",
	Weight = 2,
	Team = 6,
	Usable = true,
	Costperitem = 80,
	Size = 2,
	Dropable=true,
}

------Rifle Ammo---------------
RP08.ItemData["ammo_smg"] = 
{
	OnUse = function(item, pl) pl:GiveAmmo( 60, "smg1") end,
	Workshop = true,
	UniqueID = "ammo_smg",
	Desc = "Used to fill up rifles.",
	Model = "models/Items/BoxMRounds.mdl",
	BatchAmount = 5,
	Name = "Rifle Ammo",
	Weight = 4,
	Team = 6,
	Usable = true,
	Costperitem = 120,
	Size = 2,
	Dropable=true,
}

------357 Ammo---------------
RP08.ItemData["ammo_357"] = 
{
	OnUse = function(item, pl) pl:GiveAmmo( 12, "357") end,
	Workshop = true,
	UniqueID = "ammo_357",
	Desc = "Used to fill up 357s.",
	Model = "models//Items/357ammobox.mdl",
	BatchAmount = 5,
	Name = "357 Ammo",
	Weight = 2,
	Team = 6,
	Usable = true,
	Costperitem = 500,
	Size = 2,
	Dropable=true,
}

-----------/*END OF AMMO/*--------

-------/*Any extra weapons/*-----------

------CROWBAR--------
RP08.ItemData["weapon_crowbar"] = 
{
	OnUse = function(item, pl) pl:Give( "weapon_crowbar") end,
	Workshop = true,
	UniqueID = "weapon_crowbar",
	Desc = "Great for opening crates or killing zombies.",
	Model = "models/weapons/w_crowbar.mdl",
	BatchAmount = 10,
	Name = "CrowBar",
	Weight = 1,
	Team = 6,
	Usable = true,
	Costperitem = 600,
	Size = 2,
	Dropable=true,
}

-----------/*END OF ANY EXTRA WEAPONS/*-------

---------/*Healthpack stuff/*----------

-------Healthpack--------
RP08.ItemData["healthpack"] = 
{
	OnUse = function(item, pl)		
			if(pl:Health( ) > 129)then
				pl:PrintMessage(3, "You cannot be healed any futher!")
				return false
			end
			pl:SetHealth( math.Clamp( pl:Health() + 30, 0, 130 ) );
			pl:PrintMessage(3, "You feel very refreshed!")
		end,
	Workshop = true,
	UniqueID = "healthpack",
	Desc = "A large portable health pack.",
	Model = "models/Items/HealthKit.mdl",
	BatchAmount = 6,
	Name = "Health Pack",
	Weight = 2,
	Team = 7,
	Usable = true,
	Costperitem = 80,
	Size = 1,
	Dropable=true,
}

-----HealthVial--------
RP08.ItemData["healthvial"] = 
{
	OnUse = function(item, pl) 	if(pl:Health( ) > 101)then
		pl:PrintMessage(3, "You cannot be healed any futher!")
		return false
	end
	pl:SetHealth( math.Clamp( pl:Health() + 15, 0, 100 ) );
	pl:PrintMessage(3, "You feel very refreshed!") end,
	Workshop = true,
	UniqueID = "healthvial",
	Desc = "A small portable health vial.",
	Model = "models/healthvial.mdl",
	BatchAmount = 6,
	Name = "Health Vial",
	Weight = 1,
	Team = 7,
	Usable = true,
	Costperitem = 40,
	Size = 1,
	Dropable=true,
}

-------*/END OF HEALTHPACKS*/----------


-------/*FOOD*/-----------

--------Baked Beans--------
RP08.ItemData["bakedbeans"] = {
	OnUse = function(item, pl)
		if (pl.Hunger == 0) then
			pl:ChatPrint("You're stuffed!")
		else
			pl:ChatPrint("You've eaten some saucy baked beans!")
			pl:SetHealth( math.Clamp( pl:Health() + 2, 0, 100 ) )
			pl.Hunger = math.Clamp(pl.Hunger - 25, 0, 100)
		end
	end,
	Workshop = true,
	UniqueID = "bakedbeans",
	Desc = "Some saucy baked beans which restore 25 hunger.",
	Model = "models//props_junk/garbage_metalcan001a.mdl",
	BatchAmount = 5,
	Name = "Baked Beans",
	Weight = 0.1,
	Team = 8,
	Usable = true,
	Costperitem = 50,
	Size = 1,
	Dropable=true,
}

----------Chinese Takeout----------
RP08.ItemData["chinesetakeout"] = {
	OnUse = function(item, pl)
		if (pl.Hunger == 0) then
			pl:ChatPrint("You're stuffed!")
		else	
			pl:ChatPrint("You've eaten a noodley chinese takeout!")
			pl:SetHealth( math.Clamp( pl:Health() + 2, 0, 100 ) )
			pl.Hunger = math.Clamp(pl.Hunger - 50, 0, 100)
		end
	end,
	Workshop = true,
	UniqueID = "chinesetakeout",
	Desc = "A noodley chinese takeout which restores 50 hunger.",
	Model = "models/props_junk/garbage_takeoutcarton001a.mdl",
	BatchAmount = 5,
	Name = "Chinese Takeout",
	Weight = 0.1,
	Team = 8,
	Usable = true,
	Costperitem = 100,
	Size = 1,
	Dropable=true,
}

----------Pickles----------
RP08.ItemData["pickles"] = {
	OnUse = function(item, pl)
		if (pl.Hunger == 0) then
			pl:ChatPrint("You're stuffed!")
		else
			pl:ChatPrint("You've eaten some pickles")
			pl:SetHealth( math.Clamp( pl:Health() + 2, 0, 100 ) )
			pl.Hunger = math.Clamp(pl.Hunger - 25, 0, 100)
		end
	end,
	Workshop = true,
	UniqueID = "pickles",
	Desc = "Some fresh pickles which restore 25 hunger.",
	Model = "models/props_lab/jar01b.mdl",
	BatchAmount = 5,
	Name = "Pickles",
	Weight = 0.1,
	Team = 8,
	Usable = true,
	Costperitem = 50,
	Size = 1,
	Dropable=true,
}

----------Soda----------
RP08.ItemData["soda"] = {
OnUse = function(item, pl)
if (pl.Hunger == 0) then
pl:ChatPrint("You're stuffed!")
else
pl:ChatPrint("You've drunk some hot coffee!")
pl.Hunger = math.Clamp(pl.Hunger - 25, 0, 100)
end
end,
Workshop = true,
UniqueID = "soda",
Desc = "Biff's private reserve. Restores 25 Hunger",
Model = "models/props_junk/PopCan01a.mdl",
BatchAmount = 10,
Name = "Soda",
Weight = 0.1,
Team = 8,
Usable = true,
Costperitem = 55,
Size = 1,
Dropable=true,
}

----------Coffee----------
RP08.ItemData["coffee"] = {
OnUse = function(item, pl)
if (pl.Hunger == 0) then
pl:ChatPrint("You're stuffed!")
else
pl:ChatPrint("You've drunk some hot coffee!")
pl:SetHealth( math.Clamp( pl:Health() + 3, 0, 100 ) )
pl.Hunger = math.Clamp(pl.Hunger - 25, 0, 100)
pl.Sprint = math.Clamp(pl.Sprint + 200, 0, 200)
end
end,
Workshop = true,
UniqueID = "coffee",
Desc = "Fresh coffee brewed from Tox's kitchen. Restores 25 Hunger and Stamina",
Model = "models/props_junk/garbage_coffeemug001a.mdl",
BatchAmount = 10,
Name = "Coffee",
Weight = 0.1,
Team = 8,
Usable = true,
Costperitem = 50,
Size = 1,
Dropable=true,
}

----------Milk----------
RP08.ItemData["milk"] = {
OnUse = function(item, pl)
if (pl.Hunger == 0) then
pl:ChatPrint("You're stuffed!")
else
pl:ChatPrint("You've drunk some cold milk")
pl.Hunger = math.Clamp(pl.Hunger - 20, 0, 100)
end
end,
Workshop = true,
UniqueID = "milk",
Desc = "Fresh milk which restores 20 Hunger",
Model = "models//props_junk/garbage_milkcarton002a.mdl",
BatchAmount = 10,
Name = "Milk",
Weight = 0.1,
Team = 8,
Usable = true,
Costperitem = 50,
Size = 1,
Dropable=true,
}

----------MelonChunk----------
RP08.ItemData["melonchunk"] = {
OnUse = function(item, pl)
if (pl.Hunger == 0) then
pl:ChatPrint("You're stuffed!")
else
pl:ChatPrint("You've eaten the melon chunk")
pl:SetHealth( math.Clamp( pl:Health() + 2, 0, 100 ) )
pl.Hunger = math.Clamp(pl.Hunger - 45, 0, 100)
end
end,
Workshop = true,
UniqueID = "melonchunk",
Desc = "A nice melon slice which will reduce your hunger by 45",
Model = "models//props_junk/watermelon01_chunk01c.mdl",
BatchAmount = 10,
Name = "Melon Chunk",
Weight = 0.1,
Team = 8,
Usable = true,
Costperitem = 90,
Size = 1,
Dropable=true,
}

----------Wine----------
RP08.ItemData["wine"] = {
OnUse = function(item, pl)
if (pl.Hunger == 0) then
pl:ChatPrint("You're stuffed!")
else
pl:ChatPrint("You've drank the wine")
pl.Hunger = math.Clamp(pl.Hunger - 10, 0, 100)
end
end,
Workshop = true,
UniqueID = "wine",
Desc = "An aged wine reducing your hunger by 10",
Model = "models//props_junk/GlassBottle01a.mdl",
BatchAmount = 10,
Name = "Aged Wine",
Weight = 0.1,
Team = 8,
Usable = true,
Costperitem = 20,
Size = 1,
Dropable=true,
}

----------Whisky----------
RP08.ItemData["whisky"] = {
OnUse = function(item, pl)
if (pl.Hunger == 0) then
pl:ChatPrint("You're stuffed!")
else
pl:ChatPrint("You've drank the whisky")
pl.Hunger = math.Clamp(pl.Hunger - 20, 0, 100)
end
end,
Workshop = true,
UniqueID = "whisky",
Desc = "Large jug of wisky which fills you up by 20",
Model = "models//props_junk/glassjug01.mdl",
BatchAmount = 10,
Name = "Whisky",
Weight = 0.1,
Team = 8,
Usable = true,
Costperitem = 40,
Size = 1,
Dropable=true,
}

----------Beer----------
RP08.ItemData["beer"] = {
OnUse = function(item, pl)
if (pl.Hunger == 0) then
pl:ChatPrint("You don't need to drink anymore!")
else
pl:ChatPrint("You've downed the bottle")
pl.Hunger = math.Clamp(pl.Hunger - 15, 0, 100)
end
end,
Workshop = true,
UniqueID = "beer",
Desc = "Good old fasion beer which restores 15 hunger",
Model = "models//props_junk/garbage_glassbottle001a.mdl",
BatchAmount = 10,
Name = "Beer",
Weight = 0.1,
Team = 8,
Usable = true,
Costperitem = 35,
Size = 1,
Dropable=true,
}

----------Water----------
RP08.ItemData["water"] = {
OnUse = function(item, pl)
if (pl.Hunger == 0) then
pl:ChatPrint("You don't need to drink anymore!")
else
pl:ChatPrint("You've drank the fresh water")
pl.Hunger = math.Clamp(pl.Hunger - 30, 0, 100)
end
end,
Workshop = true,
UniqueID = "water",
Desc = "Fresh pure water. Restores 30 Hunger.",
Model = "models/\props/cs_office/Water_bottle.mdl",
BatchAmount = 10,
Name = "Fresh Water",
Weight = 0.1,
Team = 8,
Usable = true,
Costperitem = 70,
Size = 1,
Dropable=true,
}

----------Carrot----------
RP08.ItemData["carrot"] = {
OnUse = function(item, pl)
if (pl.Hunger == 0) then
pl:ChatPrint("You're stuffed!")
else
pl:ChatPrint("You've eaten the carrot")
pl:SetHealth( math.Clamp( pl:Health() + 2, 0, 100 ) )
pl.Hunger = math.Clamp(pl.Hunger - 30, 0, 100)
end
end,
Workshop = true,
UniqueID = "carrot",
Desc = "Crunchy goddamn carrot. Restores 30 Hunger. Healthy!",
Model = "models/\props/cs_office/Snowman_nose.mdl",
BatchAmount = 10,
Name = "Crunchy Carrot",
Weight = 0.1,
Team = 8,
Usable = true,
Costperitem = 75,
Size = 1,
Dropable=true,
}

----------Banana----------
RP08.ItemData["banana"] = {
OnUse = function(item, pl)
if (pl.Hunger == 0) then
pl:ChatPrint("You're stuffed!")
else
pl:ChatPrint("You've eaten the banana")
pl:SetHealth( math.Clamp( pl:Health() + 2, 0, 100 ) )
pl.Hunger = math.Clamp(pl.Hunger - 40, 0, 100)
end
end,
Workshop = true,
UniqueID = "banana",
Desc = "Try not to slip on the peel. Restores 40 Hunger",
Model = "models/\props/cs_italy/bananna.mdl",
BatchAmount = 10,
Name = "Banana",
Weight = 0.1,
Team = 8,
Usable = true,
Costperitem = 80,
Size = 1,
Dropable=true,
}

----------Orange----------
RP08.ItemData["orange"] = {
OnUse = function(item, pl)
if (pl.Hunger == 0) then
pl:ChatPrint("You're stuffed!")
else
pl:ChatPrint("You've eaten the orange")
pl:SetHealth( math.Clamp( pl:Health() + 2, 0, 100 ) )
pl.Hunger = math.Clamp(pl.Hunger - 20, 0, 100)
end
end,
Workshop = true,
UniqueID = "orange",
Desc = "Nice orange orange. Restores 20 Hunger",
Model = "models/\props/cs_italy/orange.mdl",
BatchAmount = 10,
Name = "Orange",
Weight = 0.1,
Team = 8,
Usable = true,
Costperitem = 50,
Size = 1,
Dropable=true,
}

----------Vodka----------
RP08.ItemData["vodka"] = {
OnUse = function(item, pl)
if (pl.Hunger == 0) then
pl:ChatPrint("You're stuffed!")
else
pl:ChatPrint("You've drank the vodka")
pl:SetHealth( math.Clamp( pl:Health() + 5, 0, 100 ) )
pl.Hunger = math.Clamp(pl.Hunger - 50, 0, 100)
end
end,
Workshop = true,
UniqueID = "vodka",
Desc = "High class Russian vodka. Filling you up since 19'50'.",
Model = "models/\props/CS_militia/bottle01.mdl",
BatchAmount = 10,
Name = "Vodka",
Weight = 0.1,
Team = 8,
Usable = true,
Costperitem = 200,
Size = 1,
Dropable=true,
}

----------Lemon----------
RP08.ItemData["lemon"] = {
OnUse = function(item, pl)
if (pl.Hunger == 0) then
pl:ChatPrint("You're stuffed!")
else
pl:ChatPrint("You've eaten the lemon slice")
pl.Hunger = math.Clamp(pl.Hunger - 5, 0, 100)
end
end,
Workshop = true,
UniqueID = "lemon",
Desc = "Really sour, not a pratical food. Restores 5 hunger.",
Model = "models/\props/de_inferno/crate_fruit_break_gib3.mdl",
BatchAmount = 10,
Name = "Lemon Slice",
Weight = 0.1,
Team = 8,
Usable = true,
Costperitem = 15,
Size = 1,
Dropable=true,
}
----------Juice----------
RP08.ItemData["juice"] = {
	OnUse = function(item, pl)
		if (pl.Hunger == 0) then
			pl:ChatPrint("You're stuffed!")
		else
			pl:ChatPrint("You've drank the juice")
			pl.Hunger = math.Clamp(pl.Hunger - 25, 0, 100)
		end
	end,
	Workshop = true,
	UniqueID = "juice",
	Desc = "A big carton of juice",
	Model = "models//props_junk/garbage_milkcarton001a.mdl",
	BatchAmount = 5,
	Name = "Juice",
	Weight = 0.1,
	Team = 8,
	Usable = true,
	Costperitem = 40,
	Size = 1,
	Dropable=true,
}

----------Orange Juice----------
RP08.ItemData["oj"] = {
	OnUse = function(item, pl)
		if (pl.Hunger == 0) then
			pl:ChatPrint("You're stuffed!")
		else
			pl:ChatPrint("You've drank the juice")
			pl.Hunger = math.Clamp(pl.Hunger - 25, 0, 100)
		end
	end,
	Workshop = true,
	UniqueID = "oj",
	Desc = "A carton of orange juice. Restores 25 hunger.",
	Model = "models//props_junk/garbage_plasticbottle001a.mdl",
	BatchAmount = 5,
	Name = "Orange Juice",
	Weight = 0.1,
	Team = 8,
	Usable = true,
	Costperitem = 40,
	Size = 1,
	Dropable=true,
}

----------Fake Wine----------
RP08.ItemData["fwine"] = {
	OnUse = function(item, pl)
		if (pl.Hunger == 0) then
			pl:ChatPrint("You're stuffed!")
		else
			pl:ChatPrint("You've drank the fake wine")
			pl.Hunger = math.Clamp(pl.Hunger - 10, 0, 100)
		end
	end,
	Workshop = true,
	UniqueID = "fwine",
	Desc = "Now you can pretend to drink like the adults! Restoring 10 hunger",
	Model = "models//props_junk/garbage_glassbottle003a.mdl",
	BatchAmount = 5,
	Name = "Fake Wine",
	Weight = 0.1,
	Team = 8,
	Usable = true,
	Costperitem = 20,
	Size = 1,
	Dropable=true,
}

----------Soda Can----------
RP08.ItemData["sodacan"] = {
	OnUse = function(item, pl)
		if (pl.Hunger == 0) then
			pl:ChatPrint("You're stuffed!")
		else
			pl:ChatPrint("You've drank the Bottle of Soda")
			pl.Hunger = math.Clamp(pl.Hunger - 30, 0, 100)
		end
	end,
	Workshop = true,
	UniqueID = "sodacan",
	Desc = "Big fizzy soda bottle. Restores 30 hunger.",
	Model = "models//props_junk/garbage_plasticbottle003a.mdl",
	BatchAmount = 5,
	Name = "Bottle of Soda",
	Weight = 0.1,
	Team = 8,
	Usable = true,
	Costperitem = 60,
	Size = 1,
	Dropable=true,
}

----------Grape Drank----------
RP08.ItemData["grape"] = {
	OnUse = function(item, pl)
		if (pl.Hunger == 0) then
			pl:ChatPrint("You're stuffed!")
		else
			pl:ChatPrint("You've drank the grape drink")
			pl:SetHealth( math.Clamp( pl:Health() + 2, 0, 100 ) )
			pl.Hunger = math.Clamp(pl.Hunger - 40, 0, 100)
		end
	end,
	Workshop = true,
	UniqueID = "grape",
	Desc = "Grape soda. Restores 30 hunger.",
	Model = "models/\props/cs_office/trash_can_p7.mdl",
	BatchAmount = 5,
	Name = "Grape Drink",
	Weight = 0.1,
	Team = 8,
	Usable = true,
	Costperitem = 100,
	Size = 1,
	Dropable=true,
}

----------Fizz----------
RP08.ItemData["fizz"] = {
	OnUse = function(item, pl)
		if (pl.Hunger == 0) then
			pl:ChatPrint("You're stuffed!")
		else
			pl:ChatPrint("You've drank the Big Fizz")
			pl:SetHealth( math.Clamp( pl:Health() + 2, 0, 100 ) )
			pl.Hunger = math.Clamp(pl.Hunger - 30, 0, 100)
		end
	end,
	Workshop = true,
	UniqueID = "fizz",
	Desc = "Big fizzy soda. Restores 30 hunger.",
	Model = "models/\props/cs_office/trash_can_p8.mdl",
	BatchAmount = 5,
	Name = "Big Fizz",
	Weight = 0.1,
	Team = 8,
	Usable = true,
	Costperitem = 60,
	Size = 1,
	Dropable=true,
}

----------Fish----------
RP08.ItemData["fish"] = {
	OnUse = function(item, pl)
		if (pl.Hunger == 0) then
			pl:ChatPrint("You're stuffed!")
		else
			pl:ChatPrint("You've eaten the fish")
			pl:SetHealth( math.Clamp( pl:Health() + 2, 0, 100 ) )
			pl.Hunger = math.Clamp(pl.Hunger - 30, 0, 100)
		end
	end,
	Workshop = true,
	UniqueID = "fish",
	Desc = "Raw fish. Restores 30 hunger.",
	Model = "models/\props/CS_militia/fishriver01.mdl",
	BatchAmount = 5,
	Name = "Dan Sushi",
	Weight = 0.1,
	Team = 8,
	Usable = true,
	Costperitem = 60,
	Size = 1,
	Dropable=true,
}

-------*/END OF FOOD*/--------

--------*/Inventoy Misc*/-------

----Backpack-----
RP08.ItemData["backpack"] = 
{
	Desc = "A large backpack which allows you to hold more.",
	maxallowed = 1,
	Name = "Backpack",
	UniqueID = "backpack",
	Model = "models/props_junk/garbage_bag001a.mdl",
	Usable = false,
	Weight = 2,
	Size = -10,
	Dropable=true,
}


--------Boxed Backpack--------
RP08.ItemData["boxedbackpack"] = 
{
	OnUse = function(item, pl)		
			if(pl:GetTable().Inventory["backpack"] and pl:GetTable().Inventory["backpack"] >= 1)then
				pl:PrintMessage(3, "You cannot hold two backpacks!")
				return false
			else
				RP08.Item_Update(pl, "backpack", 1)
				--It removes one by default
			end
		end,
	Workshop = true,
	UniqueID = "boxedbackpack",
	Desc = "Open this to reveal a backpack.",
	Model = "models/props_junk/cardboard_box003a.mdl",
	BatchAmount = 7,
	Name = "Boxed Backpack",
	Weight = 3,
	Team = 1,
	Usable = true,
	Costperitem = 1500,
	Size = 2,
	Dropable=true,
}