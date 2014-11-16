--Spacesuit Mod, most code are derived from stu's minetest-3d-armor modpack with modifications in api and such by fishyWET
dofile(minetest.get_modpath(minetest.get_current_modname()).."/armor.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/wieldview.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/crafting.lua")

--Statistics from wikipedia, kept here for reference;

--Name: Skylab A7LB Spacesuit
--Function: Intra-vehicular activity (IVA) and orbital Extra-vehicular activity (EVA)
--Operating Pressure: 3.7 psi (25.5 kPa)
--Total EVA Suit Weight 143 lb (64.9 kg) (-0.3 speed total)
--Primary Life Support: Vehicle Provided (On hurt, +1 breath)
--Backup Life Support: 30 minutes (Destruction = +11 breath)

--Name: Apollo A7LB Spacesuit
--Function: Intra-vehicular activity (IVA), orbital Extra-vehicular activity and terrestrial Extra-vehicular activity (EVA)
--Operating Pressure: 3.7 psi (25.5 kPa)
--Total EVA Suit Weight 212 lb (96.2 kg) (-0.4 speed total)
--Primary Life Support: 7 hours (420 minutes) (On hurt, +4 breath)
--Backup Life Support: 30 minutes (Destruction = +11 breath)

--Name: Baseline EMU
--Function: orbital extra-vehicular activity
--Operating pressure: 4.3 psi (29.6 kPa)
--Total shuttle EVA suit weight: 254 lb (115 kg) (-0.5 speed total)
--Primary life support: 8 hours (480 minutes) (On hurt, +6 breath)
--Backup life support: 30 minutes (Destruction = +11 breath)

--Name: Enhanced EMU
--Function: orbital extra-vehicular activity
--Operating pressure: 4.3 psi (29.6 kPa)
--Total shuttle EVA suit weight: 275 lb (124.7 kg)
--Total ISS EVA suit weight: 319 lb (145 kg) (-0.6 speed total)
--Primary life support: 8 hours (480 minutes) (On hurt, +6 breath)
--Backup life support: 30 minutes (Destruction = +11 breath)

-- Spacesuits
--Skylab A7LB Spacesuit
minetest.register_tool("spacesuit:helmet_skylab_a7lb", {
	description = "Skylab A7LB Helmet",
	inventory_image = "spacesuit_inv_helmet_skylab_a7lb.png",
	groups = {armor_head=5, armor_heal=0, armor_use=2000, armor_healing=0, physics_speed=0, armor_drown=0},
	wear = 0,
})

minetest.register_tool("spacesuit:uppertorso_skylab_a7lb", {
	description = "Skylab A7LB Upper Torso",
	inventory_image = "spacesuit_inv_uppertorso_skylab_a7lb.png",
	groups = {armor_torso=5, armor_heal=0, armor_use=2000, armor_healing=0, physics_speed=-0.1, armor_drown=1},
	wear = 0,
})

minetest.register_tool("spacesuit:lowertorso_skylab_a7lb", {
	description = "Skylab A7LB Lower Torso",
	inventory_image = "spacesuit_inv_lowertorso_skylab_a7lb.png",
	groups = {armor_legs=5, armor_heal=0, armor_use=2000, armor_healing=0, physics_speed=-0.1, armor_drown=0},
	wear = 0,
})

minetest.register_tool("spacesuit:boots_skylab_a7lb", {
	description = "Skylab A7LB Boots",
	inventory_image = "spacesuit_inv_boots_skylab_a7lb.png",
	groups = {armor_feet=5, armor_heal=0, armor_use=2000, armor_healing=0, physics_speed=-0.1, armor_drown=0},
	wear = 0,
})

--Apollo A7LB Spacesuit
minetest.register_tool("spacesuit:helmet_apollo_a7lb", {
	description = "Apollo A7LB Helmet",
	inventory_image = "spacesuit_inv_helmet_apollo_a7lb.png",
	groups = {armor_head=5, armor_heal=0, armor_use=1500, armor_healing=0, physics_speed=-0.1, armor_drown=1},
	wear = 0,
})

minetest.register_tool("spacesuit:uppertorso_apollo_a7lb", {
	description = "Apollo A7LB Upper Torso",
	inventory_image = "spacesuit_inv_uppertorso_apollo_a7lb.png",
	groups = {armor_torso=7, armor_heal=0, armor_use=1500, armor_healing=0, physics_speed=-0.1, armor_drown=1},
	wear = 0,
})

minetest.register_tool("spacesuit:lowertorso_apollo_a7lb", {
	description = "Apollo A7LB Lower Torso",
	inventory_image = "spacesuit_inv_lowertorso_apollo_a7lb.png",
	groups = {armor_legs=7, armor_heal=0, armor_use=1500, armor_healing=0, physics_speed=-0.1, armor_drown=1},
	wear = 0,
})

minetest.register_tool("spacesuit:boots_apollo_a7lb", {
	description = "Apollo A7LB Boots",
	inventory_image = "spacesuit_inv_boots_apollo_a7lb.png",
	groups = {armor_feet=5, armor_heal=0, armor_use=1500, armor_healing=0, physics_speed=-0.1, armor_drown=1},
	wear = 0,
})

--Baseline EMU
minetest.register_tool("spacesuit:helmet_baseline_emu", {
	description = "Baseline EMU Helmet",
	inventory_image = "spacesuit_inv_helmet_baseline_emu.png",
	groups = {armor_head=7, armor_heal=0, armor_use=1000, armor_healing=0, physics_speed=-0.1, armor_drown=2},
	wear = 0,
})

minetest.register_tool("spacesuit:uppertorso_baseline_emu", {
	description = "Baseline EMU Upper Torso",
	inventory_image = "spacesuit_inv_uppertorso_baseline_emu.png",
	groups = {armor_torso=7, armor_heal=0, armor_use=1000, armor_healing=0, physics_speed=-0.2, armor_drown=2},
	wear = 0,
})

minetest.register_tool("spacesuit:lowertorso_baseline_emu", {
	description = "Baseline EMU Lower Torso",
	inventory_image = "spacesuit_inv_lowertorso_baseline_emu.png",
	groups = {armor_legs=7, armor_heal=0, armor_use=1000, armor_healing=0, physics_speed=-0.1, armor_drown=1},
	wear = 0,
})

minetest.register_tool("spacesuit:boots_baseline_emu", {
	description = "Baseline EMU Boots",
	inventory_image = "spacesuit_inv_boots_baseline_emu.png",
	groups = {armor_feet=7, armor_heal=0, armor_use=1000, armor_healing=0, physics_speed=-0.1, armor_drown=1},
	wear = 0,
})

--Enhanced EMU
minetest.register_tool("spacesuit:helmet_enhanced_emu", {
	description = "Enhanced EMU Helmet",
	inventory_image = "spacesuit_inv_helmet_enhanced_emu.png",
	groups = {armor_head=7, armor_heal=0, armor_use=500, armor_healing=0, physics_speed=-0.1, armor_drown=2},
	wear = 0,
})

minetest.register_tool("spacesuit:uppertorso_enhanced_emu", {
	description = "Enhanced EMU Upper Torso",
	inventory_image = "spacesuit_inv_uppertorso_enhanced_emu.png",
	groups = {armor_torso=10, armor_heal=0, armor_use=500, armor_healing=0, physics_speed=-0.2, armor_drown=2},
	wear = 0,
})

minetest.register_tool("spacesuit:lowertorso_enhanced_emu", {
	description = "Enhanced EMU Lower Torso",
	inventory_image = "spacesuit_inv_lowertorso_enhanced_emu.png",
	groups = {armor_legs=10, armor_heal=0, armor_use=500, armor_healing=0, physics_speed=-0.2, armor_drown=1},
	wear = 0,
})

minetest.register_tool("spacesuit:boots_enhanced_emu", {
	description = "Enhanced EMU Boots",
	inventory_image = "spacesuit_inv_boots_enhanced_emu.png",
	groups = {armor_feet=7, armor_heal=0, armor_use=500, armor_healing=0, physics_speed=-0.1, armor_drown=1},
	wear = 0,
})


-- Oxygen Tanks

minetest.register_tool("spacesuit:steel_oxygen_tank", {
	description = "Steel Oxygen Tank",
	inventory_image = "spacesuit_tank_steel.png",
	groups = {oxygen_level=1000, breath_use=10, armor_use=50000},
	wear = 0,
})

minetest.register_tool("spacesuit:titanium_oxygen_tank", {
	description = "Titanium Oxygen Tank",
	inventory_image = "spacesuit_tank_titanium.png",
	groups = {oxygen_level=500, breath_use=10, armor_use=40000},
	wear = 0,
})

minetest.register_tool("spacesuit:mese_oxygen_tank", {
	description = "Mese Oxygen Tank",
	inventory_image = "spacesuit_tank_mese.png",
	groups = {oxygen_level=250, breath_use=10, armor_use=30000},
	wear = 0,
})