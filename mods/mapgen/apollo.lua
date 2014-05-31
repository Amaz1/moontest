mapgen = {}

function mapgen:apollo_gen(area, data, p2data, pos)--minetest.register_on_generated(function(minp, maxp, seed)

	local px = pos.x
	local py = pos.y
	local pz = pos.z
	
	--moontest node content_ids
	local c_dust = minetest.get_content_id("moontest:dust")
	local c_bas = minetest.get_content_id("moontest:basalt")
	local c_hl = minetest.get_content_id("moontest:hlsource")
	local c_msto = minetest.get_content_id("moontest:stone")
	local c_vac = minetest.get_content_id("moontest:vacuum")
	local c_mair = minetest.get_content_id("moontest:air")
	local c_ashield = minetest.get_content_id("moontest:air_shield")
	--default node content_ids
	local c_sto = minetest.get_content_id("default:stone")
	local c_wood = minetest.get_content_id("default:wood")
	local c_glass = minetest.get_content_id("default:glass")
	local c_sblock = minetest.get_content_id("default:steelblock")
	local c_gblock = minetest.get_content_id("default:goldblock")
	local c_cblock = minetest.get_content_id("default:copperblock")
	local c_chest = minetest.get_content_id("default:chest")
	local c_furnace =  minetest.get_content_id("default:furnace")
	--ufo charging furnace
	local c_ufurnace = minetest.get_content_id("ufos:furnace")
	--mesecons node content_ids
	local c_mlr = minetest.get_content_id("mesecons:wire_01010000_on") --left-right
	local c_mfb = minetest.get_content_id("mesecons:wire_10100000_on") --forward-back
	local c_mfw = minetest.get_content_id("mesecons:wire_11110000_on") --four-way
	local c_mbu = minetest.get_content_id("mesecons:wire_10101000_on") --back-up
	local c_mfu = minetest.get_content_id("mesecons:wire_10100010_on") --forward-up
	local c_mlu = minetest.get_content_id("mesecons:wire_01010001_on") --left-up
	local c_mru = minetest.get_content_id("mesecons:wire_01010100_on") --right-up
	local c_mfr = minetest.get_content_id("mesecons:wire_10010000_on") --forward-right
	local c_mfl = minetest.get_content_id("mesecons:wire_11000000_on") --forward-left
	local c_mbr = minetest.get_content_id("mesecons:wire_00110000_on") --back-right
	local c_mbl = minetest.get_content_id("mesecons:wire_01100000_on") --back-left
	local c_mflb = minetest.get_content_id("mesecons:wire_11100000_on") --forward-left-back
	local c_mfrb = minetest.get_content_id("mesecons:wire_10110000_on") --forward-right-back
	local c_mlrb = minetest.get_content_id("mesecons:wire_01110000_on") --left-right-back
	--more
	local c_lamp = minetest.get_content_id("mesecons_lamp:lamp_on")
	local c_power = minetest.get_content_id("mesecons_powerplant:power_plant")
	--air
	local c_air = minetest.get_content_id("air")
		
	local yasurf = py
	--clear out an area for the apollo module
	for x = px - 13, px + 13 do
		for z = pz - 13, pz + 13 do
			for y = yasurf, yasurf + 16 do
				local vi = area:index(x, y, z)
				data[vi] = c_vac
			end
		end
	end
	--add a layer ground beneath of it
	for x = px - 15, px + 15 do
		for z = pz - 15, pz + 15 do
			for y = yasurf - 10, yasurf do
				local vi = area:index(x, y, z)
				data[vi] = c_msto
			end
		end
	end
	--create the module
	--start with gold base
	for y = yasurf + 4, yasurf + 6 do
		for x = px-4, px+4 do
			for z = pz - 4, pz + 4 do
				local vi = area:index(x, y, z)
				data[vi] = c_gblock
			end
		end
		for x = px - 2, px + 2 do
			local vi = area:index(x, y, pz + 5)
			data[vi] = c_gblock
			local vi = area:index(x, y, pz - 5)
			data[vi] = c_gblock
		end
		for z = pz - 2, pz + 2 do
			local vi = area:index(px + 5, y, z)
			data[vi] = c_gblock
			local vi = area:index(px - 5, y, z)
			data[vi] = c_gblock
		end
	end
	--create air
	for y = yasurf + 7, yasurf + 13 do
		for x = px - 3, px + 3 do
			for z = pz - 3, pz + 3 do
				local vi = area:index(x,y,z)
				data[vi] = c_mair
			end
		end
	end
	--create cabin
	for y = yasurf + 9, yasurf + 10 do
		for x = px - 2, px + 2 do
			z = pz - 5
			local vi = area:index(x,y,z)
			data[vi] = c_sblock
			z =pz + 5
			local vi = area:index(x,y,z)
			data[vi] = c_sblock
		end
		for z = pz - 2, pz + 2 do
			x = px - 5
			local vi = area:index(x,y,z)
			data[vi] = c_sblock
			x = px + 5
			local vi = area:index(x,y,z)
			data[vi] = c_sblock
		end
	end
	for y = yasurf + 8, yasurf + 11 do
		for x = px - 3, px + 3 do
			z = pz - 4
			local vi = area:index(x,y,z)
			data[vi] = c_sblock
			z =pz + 4
			local vi = area:index(x,y,z)
			data[vi] = c_sblock
		end
		for z = pz - 3, pz + 3 do
			x = px - 4
			local vi = area:index(x,y,z)
			data[vi] = c_sblock
			x = px + 4
			local vi = area:index(x,y,z)
			data[vi] = c_sblock
		end
	end
	for y = yasurf + 7, yasurf + 12 do
		z = pz - 3
		x = px - 3
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
		x = px + 3
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
		z =pz + 3
		x = px - 3
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
		x = px + 3
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
	end
	for x = px - 2, px + 2 do
		y = yasurf + 7
		z = pz - 4
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
		z = pz + 4
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
		y = yasurf + 12
		z = pz - 4
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
		z = pz + 4
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
	end
	for z = pz - 2, pz + 2 do
		y = yasurf + 7
		x = px - 4
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
		x = px + 4
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
		y = yasurf + 12
		x = px - 4
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
		x = px + 4
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
	end
	for y = yasurf + 12, yasurf + 13 do
		for x = px - 2, px + 2 do
			z = pz - 2
			local vi = area:index(x,y,z)
			data[vi] = c_sblock
			z = pz + 2
			local vi = area:index(x,y,z)
			data[vi] = c_sblock
		end
		for z = pz - 1, pz + 1 do
			x = px - 2
			local vi = area:index(x,y,z)
			data[vi] = c_sblock
			x = px + 2
			local vi = area:index(x,y,z)
			data[vi] = c_sblock
		end
	end
	y = yasurf + 12
	for x = px - 3, px + 3 do
		z = pz - 3
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
		z = pz + 3
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
	end
	for z = pz - 2, pz + 2 do
		x = px - 3
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
		x = px + 3
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
	end
	y = yasurf + 13
	for x = px - 1, px + 1 do
		z = pz - 3
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
		z = pz + 3
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
	end
	for z = pz - 1, pz + 1 do
		x = px - 3
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
		x = px + 3
		local vi = area:index(x,y,z)
		data[vi] = c_sblock
	end
	--add glass roof to cabin
	for x = px - 1, px + 1 do
		for z = pz - 1, pz + 1 do
			local vi = area:index(x,y,z)
			if x == px and z == pz then
				data[vi] = c_mair
			else
				data[vi] = c_glass
			end
		end
	end
	y = yasurf + 14
	for x = px - 1, px + 1 do
		local vi = area:index(x,y,pz)
		data[vi] = c_glass
	end
	local vi = area:index(px,y,pz - 1)
	data[vi] = c_glass
	local vi = area:index(px,y,pz + 1)
	data[vi] = c_glass
	--add copper highlights to cabin
	y = yasurf + 7
	for x = px - 2, px + 2 do
		z = pz - 3
		local vi = area:index(x,y,z)
		data[vi] = c_cblock
		z = pz + 3
		local vi = area:index(x,y,z)
		data[vi] = c_cblock
	end
	for z = pz - 2, pz + 2 do
		x = px - 3
		local vi = area:index(x,y,z)
		data[vi] = c_cblock
	end
	local vi = area:index(px - 2,y,pz - 2)
	data[vi] = c_cblock
	local vi = area:index(px - 2,y,pz + 2)
	data[vi] = c_cblock
	local vi = area:index(px + 2,y,pz - 2)
	data[vi] = c_cblock
	local vi = area:index(px + 2,y,pz + 2)
	data[vi] = c_cblock
	local vi = area:index(px + 3,y,pz - 2)
	data[vi] = c_cblock
	local vi = area:index(px + 3,y,pz + 2)
	data[vi] = c_cblock
	--add airshield
	local vi = area:index(px + 4,y,pz)
	data[vi] = c_ashield
	local vi = area:index(px + 4,y + 1,pz)
	data[vi] = c_ashield
	--doorway
	for y = yasurf + 7, yasurf + 8 do
		local vi = area:index(px + 5,y,pz - 1)
		data[vi] = c_sblock
		local vi = area:index(px + 5,y,pz + 1)
		data[vi] = c_sblock
	end
	--gold landing gear
	y = yasurf + 6
	local vi = area:index(px - 6,y,pz)
	data[vi] = c_gblock
	local vi = area:index(px - 7,y,pz)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz - 6)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz - 7)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz + 6)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz + 7)
	data[vi] = c_gblock
	y = yasurf + 5
	local vi = area:index(px - 7,y,pz)
	data[vi] = c_gblock
	local vi = area:index(px - 8,y,pz)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz - 7)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz - 8)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz + 7)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz + 8)
	data[vi] = c_gblock
	y = yasurf + 4
	local vi = area:index(px - 8,y,pz)
	data[vi] = c_gblock
	local vi = area:index(px - 9,y,pz)
	data[vi] = c_gblock
	local vi = area:index(px - 6,y,pz)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz - 8)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz - 9)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz - 6)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz + 8)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz + 9)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz + 6)
	data[vi] = c_gblock
	
	y = yasurf + 3
	local vi = area:index(px - 9,y,pz)
	data[vi] = c_gblock
	local vi = area:index(px - 10,y,pz)
	data[vi] = c_gblock
	local vi = area:index(px - 6,y,pz)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz - 9)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz - 10)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz - 6)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz + 9)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz + 10)
	data[vi] = c_gblock
	local vi = area:index(px,y,pz + 6)
	data[vi] = c_gblock
	y = yasurf + 2
	for x = px - 11, px - 7 do
		local vi = area:index(x,y,pz)
		data[vi] = c_gblock
	end
	for z = pz - 11, pz - 7 do
		local vi = area:index(px,y,z)
		data[vi] = c_gblock
	end
	for z = pz + 7, pz + 11 do
		local vi = area:index(px,y,z)
		data[vi] = c_gblock
	end
	local vi = area:index(px - 11,yasurf + 1,pz)
	data[vi] = c_gblock
	local vi = area:index(px,yasurf + 1,pz - 11)
	data[vi] = c_gblock
	local vi = area:index(px,yasurf + 1,pz + 11)
	data[vi] = c_gblock
	--create thrusters
	--rear
	local vi = area:index(px - 3,yasurf + 3,pz)
	data[vi] = c_sto
	y = yasurf + 2
	local vi = area:index(px - 4,y,pz)
	data[vi] = c_sto
	local vi = area:index(px - 2,y,pz)
	data[vi] = c_sto
	local vi = area:index(px - 3,y,pz - 1)
	data[vi] = c_sto
	local vi = area:index(px - 3,y,pz + 1)
	data[vi] = c_sto
	--sides
	--left
	local vi = area:index(px,yasurf + 3,pz - 2)
	data[vi] = c_sto
	local vi = area:index(px,yasurf + 3,pz - 3)
	data[vi] = c_sto
	local vi = area:index(px,y,pz - 2)
	data[vi] = c_sto
	local vi = area:index(px - 1,y,pz - 2)
	data[vi] = c_sto
	local vi = area:index(px + 1,y,pz - 2)
	data[vi] = c_sto
	local vi = area:index(px - 1,y,pz - 3)
	data[vi] = c_sto
	local vi = area:index(px + 1,y,pz - 3)
	data[vi] = c_sto
	local vi = area:index(px,y,pz - 4)
	data[vi] = c_sto
	--right
	local vi = area:index(px,yasurf + 3,pz + 2)
	data[vi] = c_sto
	local vi = area:index(px,yasurf + 3,pz + 3)
	data[vi] = c_sto
	local vi = area:index(px,y,pz + 2)
	data[vi] = c_sto
	local vi = area:index(px - 1,y,pz + 2)
	data[vi] = c_sto
	local vi = area:index(px + 1,y,pz + 2)
	data[vi] = c_sto
	local vi = area:index(px - 1,y,pz + 3)
	data[vi] = c_sto
	local vi = area:index(px + 1,y,pz + 3)
	data[vi] = c_sto
	local vi = area:index(px,y,pz + 4)
	data[vi] = c_sto
	--Mesecons! :D
	y = yasurf + 11
	for x = px - 2, px + 2 do
		if x == px - 2 then
			local vi = area:index(x,y,pz - 3)
			data[vi] = c_mfl
		elseif x == px + 2 then
			local vi = area:index(x,y,pz - 3)
			data[vi] = c_mbl
		elseif x == px then
			local vi = area:index(x,y,pz - 3)
			data[vi] = c_mflb
		else
			local vi = area:index(x,y,pz - 3)
			data[vi] = c_mfb
		end
		if x == px - 2 then
			local vi = area:index(x,y,pz + 3)
			data[vi] = c_mfr
		elseif x == px + 2 then
			local vi = area:index(x,y,pz + 3)
			data[vi] = c_mbr
		elseif x == px then
			local vi = area:index(x,y,pz + 3)
			data[vi] = c_mfrb
		else
			local vi = area:index(x,y,pz + 3)
			data[vi] = c_mfb
		end
	end
	for z = pz - 2, pz + 2 do
		if z == pz - 2 then
			local vi = area:index(px - 3,y,z)
			data[vi] = c_mfl
			local vi = area:index(px + 3,y,z)
			data[vi] = c_mbl
		elseif z == pz + 2 then
			local vi = area:index(px - 3,y,z)
			data[vi] = c_mfr
			local vi = area:index(px + 3,y,z)
			data[vi] = c_mbr
		elseif z == pz then
			local vi = area:index(px - 3,y,z)
			data[vi] = c_mfw
			local vi = area:index(px + 3,y,z)
			data[vi] = c_mlrb
		else
			local vi = area:index(px - 3,y,z)
			data[vi] = c_mlr
			local vi = area:index(px + 3,y,z)
			data[vi] = c_mlr
		end
	end
	local vi = area:index(px - 2,y,pz - 2)
	data[vi] = c_mbr
	local vi = area:index(px - 2,y,pz + 2)
	data[vi] = c_mbl
	local vi = area:index(px + 2,y,pz - 2)
	data[vi] = c_mfr
	local vi = area:index(px + 2,y,pz + 2)
	data[vi] = c_mfl
	
	local vi = area:index(px - 2,y,pz)
	data[vi] = c_mbu
	local vi = area:index(px + 2,y,pz)
	data[vi] = c_mfu
	local vi = area:index(px,y,pz - 2)
	data[vi] = c_mru
	local vi = area:index(px,y,pz + 2)
	data[vi] = c_mlu
	
	--power plant and lamps
	y = yasurf + 12
	local vi = area:index(px - 1,y,pz)
	data[vi] = c_lamp
	p2data[vi] = 3
	local vi = area:index(px + 1,y,pz)
	data[vi] = c_lamp
	p2data[vi] = 2
	local vi = area:index(px,y,pz - 1)
	data[vi] = c_lamp
	p2data[vi] = 5
	local vi = area:index(px,y,pz + 1)
	data[vi] = c_lamp
	p2data[vi] = 4
	
	y = yasurf + 10
	local vi = area:index(px - 3,y,pz - 2)
	data[vi] = c_lamp
	p2data[vi] = 3
	local vi = area:index(px - 3,y,pz + 2)
	data[vi] = c_lamp
	p2data[vi] = 3
	local vi = area:index(px + 3,y,pz - 2)
	data[vi] = c_lamp
	p2data[vi] = 2
	local vi = area:index(px + 3,y,pz + 2)
	data[vi] = c_lamp
	p2data[vi] = 2
	local vi = area:index(px - 2,y,pz - 3)
	data[vi] = c_lamp
	p2data[vi] = 5
	local vi = area:index(px + 2,y,pz - 3)
	data[vi] = c_lamp
	p2data[vi] = 5
	local vi = area:index(px - 2,y,pz + 3)
	data[vi] = c_lamp
	p2data[vi] = 4
	local vi = area:index(px + 2,y,pz + 3)
	data[vi] = c_lamp
	p2data[vi] = 4
	local vi = area:index(px - 4,y,pz)
	data[vi] = c_power
	
	
	--create exit stairs
	for z = pz - 1, pz + 1 do
		local ydiff = 6
		local xdiff = 6
		while ydiff > 0 do
			local vi = area:index(px + xdiff,yasurf + ydiff,z)
			data[vi] = c_wood
			ydiff = ydiff - 1
			local vi = area:index(px + xdiff,yasurf + ydiff,z)
			data[vi] = c_wood
			xdiff = xdiff + 1
		end
	end
	
	newy = pos.y + 7
	minetest.setting_set("static_spawnpoint", pos.x..","..newy..","..pos.z)
end
