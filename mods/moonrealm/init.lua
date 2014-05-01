-- moonrealm 0.6.5 by paramat
-- For latest stable Minetest and back to 0.4.8
-- Depends default
-- Licenses: code WTFPL, textures CC BY-SA

-- TODO
-- Craters
-- Exclusive ores

-- Parameters

local XMIN = -33000 --  -- Approx horizontal limits
local XMAX = 33000
local ZMIN = -33000
local ZMAX = 33000

local YMIN = -33000 --  -- Approx lower limit
local GRADCEN = 15 --  -- Gradient centre / terrain centre average level
local YMAX = 0 --  -- Approx upper limit

local FOOT = true --  -- Footprints in dust
local CENAMP = 64 --  -- Grad centre amplitude, terrain centre is varied by this
local HIGRAD = 128 --  -- Surface generating noise gradient above gradcen, controls depth of upper terrain
local LOGRAD = 128 --  -- Surface generating noise gradient below gradcen, controls depth of lower terrain
local HEXP = 0.5 --  -- Noise offset exponent above gradcen, 1 = normal 3D perlin terrain
local LEXP = 2 --  -- Noise offset exponent below gradcen
local STOT = 1 --  -- Stone density threshold, depth of dust
local ICECHA = 1 / (13*13*13) --  -- Ice chance per dust node at terrain centre, decreases with altitude
local ICEGRAD = 128 --  -- Ice gradient, vertical distance for no ice
local ORECHA = 7*7*7 --  -- Ore 1/x chance per stone node

local FISTS = 0 --  -- Fissure threshold at surface. Controls size of fissure entrances at surface
local FISEXP = 0.05 --  -- Fissure expansion rate under surface


-- 3D noise for terrain

local np_terrain = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 58588900033,
	octaves = 6,
	persist = 0.67
}

-- 3D noise for alt terrain, 414 / 256 = golden ratio

local np_terralt = {
	offset = 0,
	scale = 1,
	spread = {x=414, y=414, z=414},
	seed = 13331930910,
	octaves = 6,
	persist = 0.67
}

-- 3D noise for smooth terrain

local np_smooth = {
	offset = 0,
	scale = 1,
	spread = {x=828, y=828, z=828},
	seed = 113,
	octaves = 4,
	persist = 0.4
}

-- 3D noise for fissures

local np_fissure = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=256, z=256},
	seed = 8181112,
	octaves = 5,
	persist = 0.5
}


-- 3D noise for faults

local np_fault = {
	offset = 0,
	scale = 1,
	spread = {x=414, y=828, z=414},
	seed = 14440002,
	octaves = 4,
	persist = 0.5
}

-- 2D noise for terrain centre

local np_gradcen = {
	offset = 0,
	scale = 1,
	spread = {x=1024, y=1024, z=1024},
	seed = 9344,
	octaves = 4,
	persist = 0.4
}

-- 2D noise for terrain blend

local np_terblen = {
	offset = 0,
	scale = 1,
	spread = {x=2048, y=2048, z=2048},
	seed = -13002,
	octaves = 3,
	persist = 0.4
}

-- Stuff

moonrealm = {}

dofile(minetest.get_modpath("moonrealm").."/nodes.lua")
dofile(minetest.get_modpath("moonrealm").."/functions.lua")

-- Player positions

local player_pos = {}
local player_pos_previous = {}
minetest.register_on_joinplayer(function(player)
	player_pos_previous[player:get_player_name()] = {x=0,y=0,z=0}
end)
minetest.register_on_leaveplayer(function(player)
	player_pos_previous[player:get_player_name()] = nil
end)

-- Globalstep function

minetest.register_globalstep(function(dtime)
	for _, player in ipairs(minetest.get_connected_players()) do
		if FOOT and math.random() < 0.3 and player_pos_previous[player:get_player_name()] ~= nil then -- eternal footprints
			local pos = player:getpos()
			player_pos[player:get_player_name()] = {x=math.floor(pos.x+0.5),y=math.floor(pos.y+0.2),z=math.floor(pos.z+0.5)}
			local p_ground = {x=math.floor(pos.x+0.5),y=math.floor(pos.y+0.4),z=math.floor(pos.z+0.5)}
			local n_ground  = minetest.get_node(p_ground).name
			local p_groundpl = {x=math.floor(pos.x+0.5),y=math.floor(pos.y-0.5),z=math.floor(pos.z+0.5)}
			if player_pos[player:get_player_name()].x ~= player_pos_previous[player:get_player_name()].x
			or player_pos[player:get_player_name()].y < player_pos_previous[player:get_player_name()].y
			or player_pos[player:get_player_name()].z ~= player_pos_previous[player:get_player_name()].z then
				if n_ground == "moonrealm:dust" then
					if math.random() < 0.5 then
						minetest.add_node(p_groundpl,{name="moonrealm:dustprint1"})
					else
						minetest.add_node(p_groundpl,{name="moonrealm:dustprint2"})
					end
				end
			end
			player_pos_previous[player:get_player_name()] = {
				x=player_pos[player:get_player_name()].x,
				y=player_pos[player:get_player_name()].y,
				z=player_pos[player:get_player_name()].z
			}
		end
		if math.random() < 0.1 then
			if player:get_inventory():contains_item("main", "moonrealm:spacesuit")
			and player:get_breath() < 10 then
				player:set_breath(10)
			end
		end
		if math.random() > 0.99 then
			local pos = player:getpos()
			if pos.y > YMIN and pos.y < YMAX then
				player:set_physics_override(1, 0.6, 0.2)
			else
				player:set_physics_override(1, 1, 1) -- speed, jump, gravity
			end
		end
	end
end)

-- On generated function

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.x < XMIN or maxp.x > XMAX
	or minp.y < YMIN or maxp.y > YMAX
	or minp.z < ZMIN or maxp.z > ZMAX then
		return
	end
	
	local t1 = os.clock()
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z
	
	print ("[moonrealm] chunk minp ("..x0.." "..y0.." "..z0..")")
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	
	local c_mese = minetest.get_content_id("default:mese")
	local c_mrironore = minetest.get_content_id("moonrealm:ironore")
	local c_mrcopperore = minetest.get_content_id("moonrealm:copperore")
	local c_mrgoldore = minetest.get_content_id("moonrealm:goldore")
	local c_mrdiamondore = minetest.get_content_id("moonrealm:diamondore")
	local c_mrstone = minetest.get_content_id("moonrealm:stone")
	local c_waterice = minetest.get_content_id("moonrealm:waterice")
	local c_dust = minetest.get_content_id("moonrealm:dust")
	local c_vacuum = minetest.get_content_id("moonrealm:vacuum")
	
	local sidelen = x1 - x0 + 1
	local chulens = {x=sidelen, y=sidelen, z=sidelen}
	local minpos = {x=x0, y=y0, z=z0}
	local minposd = {x=x0, y=z0}
	
	local nvals_terrain = minetest.get_perlin_map(np_terrain, chulens):get3dMap_flat(minpos)
	local nvals_terralt = minetest.get_perlin_map(np_terralt, chulens):get3dMap_flat(minpos)
	local nvals_smooth = minetest.get_perlin_map(np_smooth, chulens):get3dMap_flat(minpos)
	local nvals_fissure = minetest.get_perlin_map(np_fissure, chulens):get3dMap_flat(minpos)
	local nvals_fault = minetest.get_perlin_map(np_fault, chulens):get3dMap_flat(minpos)
	
	local nvals_terblen = minetest.get_perlin_map(np_terblen, chulens):get2dMap_flat(minposd)
	local nvals_gradcen = minetest.get_perlin_map(np_gradcen, chulens):get2dMap_flat(minposd)
	
	local ni = 1
	local nid = 1 -- 2D noise index
	local stable = {}
	for z = z0, z1 do
		for x = x0, x1 do
			local si = x - x0 + 1
			local nodename = minetest.get_node({x=x,y=y0-1,z=z}).name
			if nodename == "moonrealm:vacuum" then
				stable[si] = false
			else -- solid nodes and ignore in ungenerated chunks
				stable[si] = true
			end
		end
		for y = y0, y1 do
			local vi = area:index(x0, y, z) -- LVM index for first node in x row
			local icecha = ICECHA * (1 + (GRADCEN - y) / ICEGRAD)
			for x = x0, x1 do -- for each node
				local grad
				local density
				local si = x - x0 + 1 -- indexes start from 1
				local terblen = math.max(math.min(math.abs(nvals_terblen[nid]) * 4, 1.5), 0.5) - 0.5 -- terrain blend with smooth
				local gradcen = GRADCEN + nvals_gradcen[nid] * CENAMP
				if y > gradcen then
					grad = -((y - gradcen) / HIGRAD) ^ HEXP
				else
					grad = ((gradcen - y) / LOGRAD) ^ LEXP
				end
				if nvals_fault[ni] >= 0 then
					density = (nvals_terrain[ni] + nvals_terralt[ni]) / 2 * (1 - terblen) + nvals_smooth[ni] * terblen + grad
				else	
					density = (nvals_terrain[ni] - nvals_terralt[ni]) / 2 * (1 - terblen) - nvals_smooth[ni] * terblen + grad
				end
				if density > 0 then -- if terrain
					local nofis = false
					if math.abs(nvals_fissure[ni]) > FISTS + math.sqrt(density) * FISEXP then
						nofis = true
					end
					if density >= STOT and nofis then -- stone, ores 
						if math.random(ORECHA) == 2 then
							local osel = math.random(25)
							if osel == 25 then
								data[vi] = c_mese
							elseif osel >= 22 then
								data[vi] = c_mrdiamondore
							elseif osel >= 19 then
								data[vi] = c_mrgoldore
							elseif osel >= 10 then
								data[vi] = c_mrcopperore
							else
								data[vi] = c_mrironore
							end
						else
							data[vi] = c_mrstone
						end
						stable[si] = true
					elseif density < STOT then -- fine materials
						if nofis and stable[si] then
							if math.random() < icecha then
								data[vi] = c_waterice
							else
								data[vi] = c_dust
							end
						else -- fissure
							data[vi] = c_vacuum
							stable[si] = false
						end
					else -- fissure or unstable missing node
						data[vi] = c_vacuum
						stable[si] = false
					end
				else -- vacuum
					data[vi] = c_vacuum
					stable[si] = false
				end
				ni = ni + 1
				nid = nid + 1
				vi = vi + 1
			end
			nid = nid - 80
		end
		nid = nid + 80
	end
	
	vm:set_data(data)
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map(data)
	local chugent = math.ceil((os.clock() - t1) * 1000)
	print ("[moonrealm] "..chugent.." ms")
end)
