-- moontest 0.6.5 by paramat
-- Licenses: code WTFPL, textures CC BY-SA

moontest = {}

dofile(minetest.get_modpath("moontest").."/nodes.lua")
dofile(minetest.get_modpath("moontest").."/crafting.lua")
dofile(minetest.get_modpath("moontest").."/craftitems.lua")
dofile(minetest.get_modpath("moontest").."/tools.lua")

local player_pos = {}
local player_pos_previous = {}

--[[minetest.register_globalstep(function(dtime)	FOOT is not declared
	for _, player in ipairs(minetest.get_connected_players()) do
        -- Footprints
		if FOOT and math.random() < 0.3 and player_pos_previous[player:get_player_name()] ~= nil then
			local pos = player:getpos()
			player_pos[player:get_player_name()] = {x=math.floor(pos.x+0.5),y=math.floor(pos.y+0.2),z=math.floor(pos.z+0.5)}
			local p_ground = {x=math.floor(pos.x+0.5),y=math.floor(pos.y+0.4),z=math.floor(pos.z+0.5)}
			local n_ground  = minetest.get_node(p_ground).name
			local p_groundpl = {x=math.floor(pos.x+0.5),y=math.floor(pos.y-0.5),z=math.floor(pos.z+0.5)}
			if player_pos[player:get_player_name()].x ~= player_pos_previous[player:get_player_name()].x
			or player_pos[player:get_player_name()].y < player_pos_previous[player:get_player_name()].y
			or player_pos[player:get_player_name()].z ~= player_pos_previous[player:get_player_name()].z then
				if n_ground == "moontest:dust" then
					if math.random() < 0.5 then
						minetest.add_node(p_groundpl,{name="moontest:dustprint1"})
					else
						minetest.add_node(p_groundpl,{name="moontest:dustprint2"})
					end
				end
			end
			player_pos_previous[player:get_player_name()] = {
				x=player_pos[player:get_player_name()].x,
				y=player_pos[player:get_player_name()].y,
				z=player_pos[player:get_player_name()].z
			}
		end
	end
end)]]

-- Vacuum or air flows into a dug hole
minetest.register_on_dignode(function(pos, oldnode, digger)
	local x = pos.x
	local y = pos.y
	local z = pos.z
	for i = -1,1 do
	for j = -1,1 do
	for k = -1,1 do
		if not (i == 0 and j == 0 and k == 0) then
			local nodename = minetest.get_node({x=x+i,y=y+j,z=z+k}).name
			if nodename == "moontest:air" then	
				local spread = minetest.get_meta({x=x+i,y=y+j,z=z+k}):get_int("spread")
				if spread > 0 then
					minetest.add_node({x=x,y=y,z=z},{name="moontest:air"})
					minetest.get_meta(pos):set_int("spread", (spread - 1))
					print ("[moontest] MR air flows into hole "..(spread - 1))
					return
				end
			elseif nodename == "moontest:vacuum" then
				minetest.add_node({x=x,y=y,z=z},{name="moontest:vacuum"})
				print ("[moontest] Vacuum flows into hole")
				return
			end
		end
	end
	end
	end
end)

-- Air gets filled with vacuum or moontest:air, depending on surroudings
-- this is the hackiest code I've ever written
-- If neighbours worked as I would like it to, this wouldn't be necessary...
minetest.register_abm({
	nodenames = {"moontest:air", "air"},
	neighbors = {"moontest:vacuum", "moontest:air"},
	interval = 4,  --must be asynchronous with liquid ABM to avoid deadlock
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		--adjacent node positions
		local left = {x=x-1,y=y,z=z}
		local right = {x=x+1,y=y,z=z}
		local up  = {x=x,y=y+1,z=z}
		local down = {x=x,y=y-1,z=z}
		local forward = {x=x,y=y,z=z+1}
		local back = {x=x,y=y,z=z-1}
		--cross references those for vacuum, spread if true
		if minetest.get_node(left).name == "moontest:vacuum" then
			minetest.set_node(pos, {name="moontest:vacuum"})
		end
		if minetest.get_node(right).name == "moontest:vacuum" then
			minetest.set_node(pos, {name="moontest:vacuum"})
		end
		if minetest.get_node(up).name == "moontest:vacuum" then
			minetest.set_node(pos, {name="moontest:vacuum"})
		end
		if minetest.get_node(down).name == "moontest:vacuum" then
			minetest.set_node(pos, {name="moontest:vacuum"})
		end
		if minetest.get_node(forward).name == "moontest:vacuum" then
			minetest.set_node(pos, {name="moontest:vacuum"})
		end
		if minetest.get_node(back).name == "moontest:vacuum" then
			minetest.set_node(pos, {name="moontest:vacuum"})
		end
		--now cross reference if air should get filled with moontest:air
		if node.name == "air" then
			if minetest.get_node(left).name == "moontest:air" then
				minetest.set_node(pos, {name="moontest:air"})
			end
			if minetest.get_node(right).name == "moontest:air" then
				minetest.set_node(pos, {name="moontest:air"})
			end
			if minetest.get_node(up).name == "moontest:air" then
				minetest.set_node(pos, {name="moontest:air"})
			end
			if minetest.get_node(down).name == "moontest:air" then
				minetest.set_node(pos, {name="moontest:air"})
			end
			if minetest.get_node(forward).name == "moontest:air" then
				minetest.set_node(pos, {name="moontest:air"})
			end
			if minetest.get_node(back).name == "moontest:air" then
				minetest.set_node(pos, {name="moontest:air"})
			end
		end
	end
})

-- Hydroponic saturation
minetest.register_abm({
	nodenames = {"moontest:hlsource", "moontest:hlflowing"},
	neighbors = {"moontest:dust", "moontest:dustprint1", "moontest:dustprint2"},
	interval = 29,
	chance = 9,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		for i = -2,2 do
		for j = -4,0 do -- saturates out and downwards to pos.y - 4, a 5x5 cube.
		for k = -2,2 do
			if not (i == 0 and j == 0 and k == 0) then
				local nodename = minetest.get_node({x=x+i,y=y+j,z=z+k}).name
				if nodename == "moontest:dust"
				or nodename == "moontest:dustprint1"
				or nodename == "moontest:dustprint2" then
					minetest.add_node({x=x+i,y=y+j,z=z+k},{name="moontest:soil"})
					--print ("[moontest] Hydroponic liquid saturates") --huge lag
				end
			end
		end
		end
		end
	end
})

-- Soil drying
minetest.register_abm({
	nodenames = {"moontest:soil"},
	interval = 31,
	chance = 27,
	action = function(pos, node)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		for i = -2, 2 do
		for j = 0, 4 do -- search above for liquid
		for k = -2, 2 do
			if not (i == 0 and j == 0 and k == 0) then
				local nodename = minetest.get_node({x=x+i,y=y+j,z=z+k}).name
				if nodename == "moontest:hlsource" or nodename == "moontest:hlflowing" then
					return
				end
			end
		end
		end
		end
		minetest.add_node(pos,{name="moontest:dust"})
		print ("[moontest] Moon soil dries")
	end,
})

-- Space appletree from sapling
minetest.register_abm({
	nodenames = {"moontest:sapling"},
	interval = 57,
	chance = 3,
	action = function(pos, node, active_object_count, active_object_count_wider)
		moontest_appletree(pos)
	end,
})

--ABM to extinguish torches in vacuum
minetest.register_abm({
	nodenames = {"default:torch"},
	neighbors = {"moontest:vacuum"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local p2 = node.param2 --store rotation of old torch
		minetest.set_node(pos, {name = "moontest:unlit_torch", param2=p2})
	end,
})

--Physics
minetest.register_on_joinplayer(function(player)
    player:set_physics_override(1, 1, 0.27)
end)
