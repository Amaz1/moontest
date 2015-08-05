-- Mapgen

function moontest.loadspawn()
    local input = io.open(minetest.get_worldpath() .. "/spawn.txt", "r")
    if input then
		repeat
            local x = input:read("*n")
            if x == nil then
				break
            end
            local y = input:read("*n")
            local z = input:read("*n")
            moontest.spawn = {x = x, y = y, z = z}
        until input:read(0) == nil
        io.close(input)
    else
        moontest.spawn = nil
    end
end

dofile(minetest.get_modpath("mapgen").."/ores.lua")
dofile(minetest.get_modpath("mapgen").."/apollo.lua")

-- Set mapgen mode to v7
minetest.register_on_mapgen_init(function(params)
	local mapgen = minetest.get_mapgen_params()
	if mapgen.mgname == "v5" then
		mapgen.mgname = "v5"
	else
		mapgen.mgname = "v7"
	end
	minetest.set_mapgen_params({
		mgname = mapgen.mgname,
		seed = params.seed,
		water_level = 1,
		flags = "caves, nodungeons",
	})
end)

-- Dust Biome
minetest.register_biome({
	name = "plains",
	node_top = "moontest:dust",
	depth_top = 2,
	y_min = 3,
	y_max = 75,
	heat_point = 50,
	humidity_point = 50,
})

-- Basalt Biome
minetest.register_biome({
	name = "basalt",
	node_top = "moontest:basalt",
	depth_top = 2,
	node_dust = "moontest:vacuum",
	y_min = -50,
	y_max = 5,
	heat_point = 75,
	humidity_point = 25,
})

-- Lunar Ice Cap Biome
minetest.register_biome({
	name = "ice",
	node_top = "moontest:waterice",
	depth_top = 2,
	node_filler = "moontest:dust",
	depth_filler = 5,
	y_min = 65,
	y_max = 1000,
	heat_point = 25,
	humidity_point = 75,
})

-- Aliases

minetest.register_alias("mapgen_lava_source", "default:lava_source")
minetest.register_alias("mapgen_stone", "moontest:stone")
minetest.register_alias("mapgen_dirt", "moontest:dust")
minetest.register_alias("mapgen_gravel", "moontest:compressed_dust")
minetest.register_alias("mapgen_water_source", "moontest:vacuum")
-- add these two in case dungeons are enabled
minetest.register_alias("mapgen_mossycobble", "moontest:cobble")
minetest.register_alias("mapgen_cobble", "moontest:cobble")
minetest.register_alias("mapgen_stair_cobble", "moontest:cobblestair")

-- treegen function
local function moontest_tree(x, y, z, area, data)

	local c_tree = minetest.get_content_id("moontest:tree")
	local c_leaves = minetest.get_content_id("moontest:leaves")
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local vi = area:index(x + i, y + j + 1, z + k)
				if math.random(3) ~= 2 then
					data[vi] = c_leaves
				end
			end
			end
		end
		local vi = area:index(x, y + j, z)
		data[vi] = c_tree
	end
end

--should spawn be set?
local players = 0
local gen_spawn = false
minetest.register_on_newplayer(function(player)
	players = players + 1
	if minetest.is_singleplayer() then
		gen_spawn = true
	elseif players <= 1 then
		gen_spawn = true
	else
		gen_spawn = false
		moontest.loadspawn()
		player:setpos(moontest.spawn)
	end
	minetest.after(3, function(param)
		moontest.loadspawn()
		if moontest.spawn then
			local point = moontest.spawn
			param:setpos(point)
			if minetest.is_singleplayer() then
				minetest.place_node({x=point.x, y=point.y, z=point.z+2}, {name="default:chest", param2=3})
				local meta = minetest.get_meta({x=point.x, y=point.y, z=point.z+2})
				local inv = meta:get_inventory()
				inv:add_item("main", 'default:stone')
				inv:add_item("main", 'ufos:ufo')
				inv:add_item("main", 'mesecons:wire_00000000_off 18')
				inv:add_item("main", 'mesecons_blinkyplant:blinky_plant')
			end
			minetest.place_node({x=point.x-1, y=point.y, z=point.z+2}, {name="default:furnace", param2=2})
			minetest.place_node({x=point.x+1, y=point.y, z=point.z+2}, {name="ufos:furnace", param2=0})
		end
	end, player)
end)

--Set everything to vacuum on generate
minetest.register_on_generated(function(minp, maxp, seed)
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z
	--fire up the voxel manipulator
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	--get the content ID #'s of air and vacuum
	local c_air = minetest.get_content_id("air")
	local c_vac = minetest.get_content_id("moontest:vacuum")
	local c_dust = minetest.get_content_id("moontest:dust")
	local c_hl = minetest.get_content_id("moontest:hlsource")


	--loop through every node of the chunk
	for z = z0, z1 do
		for x = x0, x1 do
			for y = y0, y1 do
			    --grab the location of the node in question
				local vi = area:index(x, y, z)
				--if it's air, it won't be now!
				if data[vi] == c_air then
					data[vi] = c_vac
				end
			end
			--gen trees
			--find surface
			local yasurf = false -- y of above surface node
			local lasurf = false -- if surface is liquid
			for y = y1, 2, -1 do --decrement, not increment
				local vi = area:index(x, y, z)
				local c_node = data[vi]
				if y == y1 and c_node ~= c_vac then -- if top node solid
					break
				elseif c_node == c_dust then --if first surface node
					yasurf = y + 1 --set the position of the surface
					break
				elseif c_node == c_hl then
					wasurf = y + 1
					break
				end
			end
			if yasurf or lasurf then
				if yasurf then --if surface was found
					if math.random() <= 0.0001337 then --much LEET
						moontest_tree(x, yasurf+1, z, area, data)--place a tree
					end
				end
				if gen_spawn then
					local spawnpoint = {x=0,y=0,z=0}
					if minetest.setting_get_pos("static_spawnpoint") then
						spawnpoint = minetest.setting_get_pos("static_spawnpoint")
						gen_spawn = false
						--read param2 data
						local p2data = vm:get_param2_data()
						mapgen:apollo_gen(area, data, p2data, spawnpoint)
						vm:set_param2_data(p2data)
					else
						if z >= z0 + 20 and z <= z1 -20 then
						if x >= x0 + 20 and x <= x1 -20 then
							if lasurf then
								spawnpoint = {x=x, y=lasurf, z=z}
							else
								spawnpoint = {x=x, y=yasurf, z=z}
							end
							print(spawnpoint.x)
							--newy = spawnpoint.y + 7
							gen_spawn = false
							--read param2 data
							local p2data = vm:get_param2_data()
							mapgen:apollo_gen(area, data, p2data, spawnpoint)
							vm:set_param2_data(p2data)
						end
						end
					end
					--read param2 data
					--local p2data = vm:get_param2_data()
					--mapgen:apollo_gen(area, data, p2data, spawnpoint)
					--vm:set_param2_data(p2data)
				end
			end
		end
	end
	--write the voxel manipulator data back to world
	vm:set_data(data)
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map(data)
end)

--make liquid delete vacuum and air nodes nearby so as to allow flowing
minetest.register_abm({
	nodenames = {"group:liquid"},
	neighbors = {"moontest:vacuum", "moontest:air"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		for x = -1,1 do
			for y = -1,0 do
				for z = -1,1 do
					n_pos = {x=x + pos.x,y=y+pos.y,z=z+pos.z}
					n_name = minetest.get_node(n_pos).name
					if n_name == "moontest:vacuum" or n_name == "moontest:air" then
						minetest.remove_node(n_pos)
					end
				end
			end
		end
	end,
})
