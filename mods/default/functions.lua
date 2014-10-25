-- mods/default/functions.lua

--
-- Lavacooling
--

default.cool_lava_source = function(pos)
	minetest.set_node(pos, {name="default:obsidian"})
	minetest.sound_play("default_cool_lava", {pos = pos,  gain = 0.25})
end

default.cool_lava_flowing = function(pos)
	minetest.set_node(pos, {name="default:stone"})
	minetest.sound_play("default_cool_lava", {pos = pos,  gain = 0.25})
end

minetest.register_abm({
	nodenames = {"default:lava_flowing"},
	neighbors = {"group:water"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		default.cool_lava_flowing(pos, node, active_object_count, active_object_count_wider)
	end,
})

minetest.register_abm({
	nodenames = {"default:lava_source"},
	neighbors = {"group:water"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		default.cool_lava_source(pos, node, active_object_count, active_object_count_wider)
	end,
})
