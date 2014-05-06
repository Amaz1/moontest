local YMIN = -33000
local YMAX = 33000
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
				if n_ground == "mapgen:dust" then
					if math.random() < 0.5 then
						minetest.add_node(p_groundpl,{name="mapgen:dustprint1"})
					else
						minetest.add_node(p_groundpl,{name="mapgen:dustprint2"})
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
			if player:get_inventory():contains_item("main", "mapgen:spacesuit")
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


-- Space apple tree

function moonrealm_appletree(pos)
	local x = pos.x
	local y = pos.y
	local z = pos.z
	for j = -2, -1 do
		local nodename = minetest.get_node({x=x,y=y+j,z=z}).name
		if nodename ~= "mapgen:soil" then
			return
		end
	end
	for j = 1, 5 do
		local nodename = minetest.get_node({x=x,y=y+j,z=z}).name
		if nodename ~= "mapgen:air" then
			return
		end
	end
	for j = -2, 4 do
		if j >= 1 then
			for i = -2, 2 do
			for k = -2, 2 do
				local nodename = minetest.get_node({x=x+i,y=y+j+1,z=z+k}).name
				if math.random() > (math.abs(i) + math.abs(k)) / 16 then
					if math.random(13) == 2 then
						minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="default:apple"})
					else
						minetest.add_node({x=pos.x+i,y=pos.y+j+1,z=pos.z+k},{name="mapgen:leaves"})
					end
				else
					minetest.add_node({x=x+i,y=y+j+1,z=z+k},{name="mapgen:air"})
					minetest.get_meta({x=x+i,y=y+j+1,z=z+k}):set_int("spread", 16)
				end
			end
			end
		end
		minetest.add_node({x=pos.x,y=pos.y+j,z=pos.z},{name="default:tree"})
	end
	print ("[moonrealm] Appletree sapling grows")
end

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
			if nodename == "mapgen:air" then	
				local spread = minetest.get_meta({x=x+i,y=y+j,z=z+k}):get_int("spread")
				if spread > 0 then
					minetest.add_node({x=x,y=y,z=z},{name="mapgen:air"})
					minetest.get_meta(pos):set_int("spread", (spread - 1))
					print ("[moonrealm] MR air flows into hole "..(spread - 1))
					return
				end
			elseif nodename == "mapgen:vacuum" then
				minetest.add_node({x=x,y=y,z=z},{name="mapgen:vacuum"})
				print ("[moonrealm] Vacuum flows into hole")
				return
			end
		end
	end
	end
	end
end)
-- ABMs

-- Air spreads

minetest.register_abm({
	nodenames = {"mapgen:air"},
	neighbors = {"mapgen:vacuum", "air"},
	interval = 11,
	chance = 9,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local spread = minetest.get_meta(pos):get_int("spread")
		if spread <= 0 then
			return
		end
		local x = pos.x
		local y = pos.y
		local z = pos.z
		for i = -1,1 do
		for j = -1,1 do
		for k = -1,1 do
			if not (i == 0 and j == 0 and k == 0) then
				local nodename = minetest.get_node({x=x+i,y=y+j,z=z+k}).name
				if nodename == "mapgen:vacuum"
				or nodename == "air" then
					minetest.add_node({x=x+i,y=y+j,z=z+k},{name="mapgen:air"})
					minetest.get_meta({x=x+i,y=y+j,z=z+k}):set_int("spread", (spread - 1))
					print ("[moonrealm] MR air spreads "..(spread - 1))
				end
			end
		end
		end
		end
	end
})

-- Hydroponic saturation

minetest.register_abm({
	nodenames = {"mapgen:hlsource", "mapgen:hlflowing"},
	neighbors = {"mapgen:dust", "mapgen:dustprint1", "mapgen:dustprint2"},
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
				if nodename == "mapgen:dust"
				or nodename == "mapgen:dustprint1"
				or nodename == "mapgen:dustprint2" then
					minetest.add_node({x=x+i,y=y+j,z=z+k},{name="mapgen:soil"})
					print ("[moonrealm] Hydroponic liquid saturates")
				end
			end
		end
		end
		end
	end
})

-- Soil drying

minetest.register_abm({
	nodenames = {"mapgen:soil"},
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
				if nodename == "mapgen:hlsource" or nodename == "mapgen:hlflowing" then
					return
				end
			end
		end
		end
		end
		minetest.add_node(pos,{name="mapgen:dust"})
		print ("[moonrealm] Moon soil dries")
	end,
})

-- Space appletree from sapling

minetest.register_abm({
	nodenames = {"mapgen:sapling"},
	interval = 57,
	chance = 3,
	action = function(pos, node, active_object_count, active_object_count_wider)
		moonrealm_appletree(pos)
	end,
})
