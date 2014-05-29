-- Crafting

minetest.register_craft({
    output = "moontest:airlock",
    recipe = {
        {"default:steel_ingot", "", "default:steel_ingot"},
        {"default:steel_ingot", "default:mese", "default:steel_ingot"},
        {"default:steel_ingot", "", "default:steel_ingot"},
    },
})

minetest.register_craft({
    output = "moontest:light",
    recipe = {
        {"moontest:light_crystal", "moontest:stone", "moontest:light_crystal"},
        {"moontest:light_crystal", "default:mese_crystal", "moontest:light_crystal"},
        {"moontest:light_crystal", "moontest:stone", "moontest:light_crystal"},
    },
})

minetest.register_craft({
    output = "moontest:light_stick",
    recipe = {
        {"moontest:light_crystal"},
        {"default:stick"},
        {"default:stick"},
    },
})

minetest.register_craft({
    output = "moontest:airgen",
    recipe = {
        {"default:steel_ingot", "moontest:waterice", "default:steel_ingot"},
        {"moontest:waterice", "default:mese", "moontest:waterice"},
        {"default:steel_ingot", "moontest:waterice", "default:steel_ingot"},
    },
})

minetest.register_craft({
	output = "default:wood",
	recipe = {
		{"moontest:tree"},
	},
})

minetest.register_craft({
	output = "default:water_source",
	recipe = {
		{"moontest:waterice"},
	},
})

minetest.register_craft({
    output = "moontest:hlsource",
    recipe = {
        {"moontest:leaves", "moontest:leaves", "moontest:leaves"},
        {"moontest:leaves", "moontest:waterice", "moontest:leaves"},
        {"moontest:leaves", "moontest:leaves", "moontest:leaves"},
    },
})

minetest.register_craft({
	output = "moontest:stonebrick 4",
	recipe = {
		{"moontest:stone", "moontest:stone"},
		{"moontest:stone", "moontest:stone"},
	}
})

minetest.register_craft({
    output = "default:furnace",
    recipe = {
        {"moontest:stone", "moontest:stone", "moontest:stone"},
        {"moontest:stone", "", "moontest:stone"},
        {"moontest:stone", "moontest:stone", "moontest:stone"},
    },
})

minetest.register_craft({
    output = "moontest:lunariumblock",
    recipe = {
        {"moontest:lunarium_ingot", "moontest:lunarium_ingot", "moontest:lunarium_ingot"},
        {"moontest:lunarium_ingot", "moontest:lunarium_ingot", "moontest:lunarium_ingot"},
        {"moontest:lunarium_ingot", "moontest:lunarium_ingot", "moontest:lunarium_ingot"},
    },
})

minetest.register_craft({
    output = "moontest:lunarium_ingot 9",
    recipe = {
        {"moontest:lunariumblock"},
    },
})

minetest.register_craft({
	output = "moontest:stoneslab 6", -- 4 --> 6 because of stone pressure plates
	recipe = {
		{"moontest:stone", "moontest:stone", "moontest:stone"},
	}
})

minetest.register_craft({
	output = "moontest:stonestair 4",
	recipe = {
		{"moontest:stone", ""},
		{"moontest:stone", "moontest:stone"},
	}
})

minetest.register_craft({
	output = "moontest:cobbleslab 6",
	recipe = {
		{"moontest:cobble", "moontest:cobble", "moontest:cobble"},
	}
})

minetest.register_craft({
	output = "moontest:cobblestair 4",
	recipe = {
		{"moontest:cobble", ""},
		{"moontest:cobble", "moontest:cobble"},
	}
})

minetest.register_craft({
	output = "moontest:helmet",
	recipe = {
		{"default:mese_crystal"},
		{"default:glass"},
		{"default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "moontest:lifesupport",
	recipe = {
		{"default:steel_ingot","default:steel_ingot" , "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "default:mese", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "moontest:spacesuit",
	recipe = {
		{"wool:white", "moontest:helmet", "wool:white"},
		{"", "moontest:lifesupport", ""},
		{"wool:white", "", "wool:white"},
	}
})

minetest.register_craft({
    output = "moontest:light 8",
    recipe = {
        {"moontest:glass", "moontest:glass", "moontest:glass"},
        {"moontest:glass", "default:mese", "moontest:glass"},
        {"moontest:glass", "moontest:glass", "moontest:glass"},
    },
})

minetest.register_craft({
	output = "moontest:sapling",
	recipe = {
		{"default:mese_crystal"},
		{"default:sapling"},
	}
})

--Recipe redefinitions for compatibility

--Mesecons
minetest.register_craft({
	output = "mesecons_powerplant:power_plant",
	recipe = {
		{"group:mesecon_conductor_craftable"},
		{"group:mesecon_conductor_craftable"},
		{"moontest:sapling"},
	}
})

minetest.register_craft({
	output = "mesecons_blinkyplant:blinky_plant_off 1",
	recipe = {
		{"","group:mesecon_conductor_craftable",""},
		{"","group:mesecon_conductor_craftable",""},
		{"moontest:sapling","moontest:sapling","moontest:sapling"},
	}
})

minetest.register_craft({
	output = "mesecons_switch:mesecon_switch_off 2",
	recipe = {
		{"default:steel_ingot","moontest:cobble","default:steel_ingot"},
		{"group:mesecon_conductor_craftable","","group:mesecon_conductor_craftable"},
	}
})

minetest.register_craft({
	output = "mesecons_walllever:wall_lever_off 2",
	recipe = {
	    {"group:mesecon_conductor_craftable"},
		{"moontest:stone"},
		{"default:stick"},
	}
})

minetest.register_craft({
	output = "mesecons_pressureplates:pressure_plate_stone_off",
	recipe = {
	    {"moontest:cobble","moontest:cobble"},
	}
})

minetest.register_craft({
	output = "mesecons_button:button_off 2",
	recipe = {
		{"group:mesecon_conductor_craftable","moontest:stone"},
	}
})

minetest.register_craft({
	output = "mesecons_lightstone:lightstone_gray_off",
	recipe = {
		{"","moontest:cobble",""},
		{"moontest:cobble","default:torch","moontest:cobble"},
		{"","group:mesecon_conductor_craftable",""}
	}
})

minetest.register_craft({
	output = "mesecons_pistons:piston_normal_off 2",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"moontest:cobble", "default:steel_ingot", "moontest:cobble"},
		{"moontest:cobble", "group:mesecon_conductor_craftable", "moontest:cobble"},
	}
})

minetest.register_craft({
	output = "mesecons_movestones:movestone 2",
	recipe = {
		{"moontest:stone", "moontest:stone", "moontest:stone"},
		{"group:mesecon_conductor_craftable", "group:mesecon_conductor_craftable", "group:mesecon_conductor_craftable"},
		{"moontest:stone", "moontest:stone", "moontest:stone"},
	}
})

minetest.register_craft({
	output = 'mesecons_random:removestone 4',
	recipe = {
		{"", "moontest:cobble", ""},
		{"moontest:cobble", "group:mesecon_conductor_craftable", "moontest:cobble"},
		{"", "moontest:cobble", ""},
	}
})

minetest.register_craft({
	output = 'mesecons_random:ghoststone 4',
	recipe = {
		{"default:steel_ingot", "moontest:cobble", "default:steel_ingot"},
		{"moontest:cobble", "group:mesecon_conductor_craftable", "moontest:cobble"},
		{"default:steel_ingot", "moontest:cobble", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "mesecons_delayer:delayer_off_1",
	recipe = {
		{"mesecons_torch:mesecon_torch_on", "group:mesecon_conductor_craftable", "mesecons_torch:mesecon_torch_on"},
		{"moontest:cobble","moontest:cobble", "moontest:cobble"},
	}
})

--Tools

minetest.register_craft({
	output = 'moontest:pick_lunarium',
	recipe = {
		{'moontest:lunarium_ingot', 'moontest:lunarium_ingot', 'moontest:lunarium_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'moontest:pick_titanium',
	recipe = {
		{'moontest:titanium_ingot', 'moontest:titanium_ingot', 'moontest:titanium_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'moontest:shovel_lunarium',
	recipe = {
		{'moontest:lunarium_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'moontest:shovel_titanium',
	recipe = {
		{'moontest:titanium_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'moontest:axe_lunarium',
	recipe = {
		{'moontest:lunarium_ingot', 'moontest:lunarium_ingot'},
		{'moontest:lunarium_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'moontest:axe_titanium',
	recipe = {
		{'moontest:titanium_ingot', 'moontest:titanium_ingot'},
		{'moontest:titanium_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'moontest:sword_lunarium',
	recipe = {
		{'moontest:lunarium_ingot'},
		{'moontest:lunarium_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'moontest:sword_titanium',
	recipe = {
		{'moontest:titanium_ingot'},
		{'moontest:titanium_ingot'},
		{'group:stick'},
	}
})

-- Cooking

minetest.register_craft({
	type = "cooking",
	output = "default:glass",
	recipe = "moontest:dust",
})

minetest.register_craft({
	type = "cooking",
	output = "moontest:stone",
	recipe = "moontest:cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "moontest:titanium_ingot",
	recipe = "moontest:titanium_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "moontest:lunarium_ingot",
	recipe = "moontest:lunarium_lump",
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:mese_crystal",
	burntime = 50,
})

minetest.register_craft({
	type = "fuel",
	recipe = "moontest:phosphorus_lump",
	burntime = 50,
})

--new recipe for glue from mesecons to keep compatibility
minetest.register_craft({
	output = "mesecons_materials:glue 2",
	type = "cooking",
	recipe = "moontest:sapling",
	cooktime = 2
})
