-- Crafting

--Skylab
minetest.register_craft({
    output = "spacesuit:helmet_skylab_a7lb",
    recipe = {
        {"", "default:steel_ingot", ""},
        {"", "default:glass", ""},
        {"", "default:steel_ingot", ""},
    },
})

minetest.register_craft({
    output = "spacesuit:uppertorso_skylab_a7lb",
    recipe = {
        {"default:steel_ingot", "", "default:steel_ingot"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
    },
})

minetest.register_craft({
    output = "spacesuit:lowertorso_skylab_a7lb",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "", "default:steel_ingot"},
        {"default:steel_ingot", "", "default:steel_ingot"},
    },
})

minetest.register_craft({
    output = "spacesuit:boots_skylab_a7lb",
    recipe = {
        {"default:steel_ingot", "", "default:steel_ingot"},
        {"default:steel_ingot", "", "default:steel_ingot"},
    },
})

--Apollo
minetest.register_craft({
    output = "spacesuit:helmet_apollo_a7lb",
    recipe = {
        {"", "default:copper_ingot", ""},
        {"", "default:glass", ""},
        {"", "default:copper_ingot", ""},
    },
})

minetest.register_craft({
    output = "spacesuit:uppertorso_apollo_a7lb",
    recipe = {
        {"default:copper_ingot", "", "default:copper_ingot"},
        {"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
        {"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
    },
})

minetest.register_craft({
    output = "spacesuit:lowertorso_apollo_a7lb",
    recipe = {
        {"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
        {"default:copper_ingot", "", "default:copper_ingot"},
        {"default:copper_ingot", "", "default:copper_ingot"},
    },
})

minetest.register_craft({
    output = "spacesuit:boots_apollo_a7lb",
    recipe = {
        {"default:copper_ingot", "", "default:copper_ingot"},
        {"default:copper_ingot", "", "default:copper_ingot"},
    },
})

--baseline emu
minetest.register_craft({
    output = "spacesuit:helmet_baseline_emu",
    recipe = {
        {"", "moontest:titanium_ingot", ""},
        {"", "default:glass", ""},
        {"", "moontest:titanium_ingot", ""},
    },
})

minetest.register_craft({
    output = "spacesuit:uppertorso_baseline_emu",
    recipe = {
        {"moontest:titanium_ingot", "", "moontest:titanium_ingot"},
        {"moontest:titanium_ingot", "moontest:titanium_ingot", "moontest:titanium_ingot"},
        {"moontest:titanium_ingot", "moontest:titanium_ingot", "moontest:titanium_ingot"},
    },
})

minetest.register_craft({
    output = "spacesuit:lowertorso_baseline_emu",
    recipe = {
        {"moontest:titanium_ingot", "moontest:titanium_ingot", "moontest:titanium_ingot"},
        {"moontest:titanium_ingot", "", "moontest:titanium_ingot"},
        {"moontest:titanium_ingot", "", "moontest:titanium_ingot"},
    },
})

minetest.register_craft({
    output = "spacesuit:boots_baseline_emu",
    recipe = {
        {"moontest:titanium_ingot", "", "moontest:titanium_ingot"},
        {"moontest:titanium_ingot", "", "moontest:titanium_ingot"},
    },
})

--enhanced emu
minetest.register_craft({
    output = "spacesuit:helmet_enhanced_emu",
    recipe = {
        {"", "default:mese_crystal", ""},
        {"", "default:glass", ""},
        {"", "default:mese_crystal", ""},
    },
})

minetest.register_craft({
    output = "spacesuit:uppertorso_enhanced_emu",
    recipe = {
        {"default:mese_crystal", "", "default:mese_crystal"},
        {"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
        {"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
    },
})

minetest.register_craft({
    output = "spacesuit:lowertorso_enhanced_emu",
    recipe = {
        {"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
        {"default:mese_crystal", "", "default:mese_crystal"},
        {"default:mese_crystal", "", "default:mese_crystal"},
    },
})

minetest.register_craft({
    output = "spacesuit:boots_enhanced_emu",
    recipe = {
        {"default:mese_crystal", "", "default:mese_crystal"},
        {"default:mese_crystal", "", "default:mese_crystal"},
    },
})

--Oxygen Tanks

minetest.register_craft({
    output = "spacesuit:steel_oxygen_tank",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"default:steel_ingot", "", "default:steel_ingot"},
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
    },
})

minetest.register_craft({
    output = "spacesuit:titanium_oxygen_tank",
    recipe = {
        {"moontest:titanium_ingot", "moontest:titanium_ingot", "moontest:titanium_ingot"},
        {"moontest:titanium_ingot", "", "moontest:titanium_ingot"},
        {"moontest:titanium_ingot", "moontest:titanium_ingot", "moontest:titanium_ingot"},
    },
})

minetest.register_craft({
    output = "spacesuit:mese_oxygen_tank",
    recipe = {
        {"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
        {"default:mese_crystal", "", "default:mese_crystal"},
        {"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
    },
})