minetest.register_node("moontest:stone", {
	description = "Moon Stone",
	tiles = {"moontest_stone.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moontest:dust", {
	description = "Moon Dust",
	tiles = {"moontest_dust.png"},
	groups = {crumbly=3, falling_node=1},
	sounds = default.node_sound_sand_defaults({
		footstep = {name="default_sand_footstep", gain=0.1},
	}),
})

minetest.register_node("moontest:dustprint1", {
	description = "Moon Dust Footprint1",
	tiles = {"moontest_dustprint1.png", "moontest_dust.png"},
	groups = {crumbly=3, falling_node=1},
	drop = "moontest:dust",
	sounds = default.node_sound_sand_defaults({
		footstep = {name="default_sand_footstep", gain=0.1},
	}),
})

minetest.register_node("moontest:dustprint2", {
	description = "Moon Dust Footprint2",
	tiles = {"moontest_dustprint2.png", "moontest_dust.png"},
	groups = {crumbly=3, falling_node=1},
	drop = "moontest:dust",
	sounds = default.node_sound_sand_defaults({
		footstep = {name="default_sand_footstep", gain=0.1},
	}),
})

minetest.register_node("moontest:vacuum", {
	description = "Vacuum",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = 1,
})

minetest.register_node("moontest:air", {
	description = "Life Support Air",
	drawtype = "glasslike",
	tiles = {"moontest_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
})

minetest.register_node("moontest:airgen", {
	description = "Air Generator",
	tiles = {"moontest_airgen.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		for i = -1,1 do
		for j = -1,1 do
		for k = -1,1 do
			if not (i == 0 and j == 0 and k == 0) then
				local nodename = minetest.get_node({x=x+i,y=y+j,z=z+k}).name
				if nodename == "moontest:vacuum" then
					minetest.add_node({x=x+i,y=y+j,z=z+k},{name="moontest:air"})
					minetest.get_meta({x=x+i,y=y+j,z=z+k}):set_int("spread", 16)
					print ("[moontest] Added MR air node")
				end
			end
		end
		end
		end
		
	end
})

minetest.register_node("moontest:waterice", {
	description = "Water Ice",
	tiles = {"moontest_waterice.png"},
	light_source = 1,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3,melts=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("moontest:hlflowing", {
	description = "Flowing Hydroponics",
	inventory_image = minetest.inventorycube("moontest_hl.png"),
	drawtype = "flowingliquid",
	tiles = {"moontest_hl.png"},
	special_tiles = {
		{
			image="moontest_hlflowing_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2}
		},
		{
			image="moontest_hlflowing_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2}
		},
	},
	alpha = 224,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "moontest:hlflowing",
	liquid_alternative_source = "moontest:hlsource",
	liquid_viscosity = 1,
	post_effect_color = {a=224, r=115, g=55, b=24},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1},
})

minetest.register_node("moontest:hlsource", {
	description = "Hydroponic Source",
	inventory_image = minetest.inventorycube("moontest_hl.png"),
	drawtype = "liquid",
	tiles = {"moontest_hl.png"},
	alpha = 224,
	paramtype = "light",
	walkable = false,
	pointable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "moontest:hlflowing",
	liquid_alternative_source = "moontest:hlsource",
	liquid_viscosity = 1,
	post_effect_color = {a=224, r=115, g=55, b=24},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("moontest:soil", {
	description = "Moonsoil",
	tiles = {"moontest_soil.png"},
	groups = {crumbly=3, falling_node=1, soil=3},
	drop = "moontest:dust",
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("moontest:airlock", {
	description = "Airlock",
	tiles = {"moontest_airlock.png"},
	light_source = 14,
	walkable = false,
	post_effect_color = {a=255, r=0, g=0, b=0},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moontest:glass", {
	description = "MR Glass",
	drawtype = "glasslike",
	tiles = {"default_obsidian_glass.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("moontest:sapling", {
	description = "Moon Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_sapling.png"},
	inventory_image = "default_sapling.png",
	wield_image = "default_sapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("moontest:leaves", {
	description = "Moon Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_leaves.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{items = {"moontest:sapling"},rarity = 20,},
			{items = {"moontest:leaves"},}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("moontest:light", {
	description = "Light",
	tiles = {"moontest_light.png"},
	light_source = 14,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("moontest:stonebrick", {
	description = "Moon Stone Brick",
	tiles = {"moontest_stonebricktop.png", "moontest_stonebrickbot.png", "moontest_stonebrick.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moontest:stoneslab", {
	description = "Moon Stone Slab",
	tiles = {"moontest_stonebricktop.png", "moontest_stonebrickbot.png", "moontest_stonebrick.png"},
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	buildable_to = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5}
		},
	},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moontest:stonestair", {
	description = "Moon Stone Stair",
	tiles = {"moontest_stonebricktop.png", "moontest_stonebrickbot.png", "moontest_stonebrick.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

-- Items

minetest.register_craftitem("moontest:spacesuit", {
	description = "Spacesuit",
	inventory_image = "moontest_spacesuit.png",
	groups = {not_in_creative_inventory=1},
})

minetest.register_craftitem("moontest:helmet", {
	description = "Helmet",
	inventory_image = "moontest_helmet.png",
	groups = {not_in_creative_inventory=1},
})

minetest.register_craftitem("moontest:lifesupport", {
	description = "Life Support",
	inventory_image = "moontest_lifesupport.png",
	groups = {not_in_creative_inventory=1},
})
