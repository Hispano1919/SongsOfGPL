local JOBTYPE = require "game.raws.job_types"

local d = {}

function d.load()
	local ProductionMethod = require "game.raws.production-methods"
	local job = require "game.raws.raws-utils".job
	local good = require "game.raws.raws-utils".trade_good

	-- Keep in mind that outputs are per worker already!
	ProductionMethod:new {
		name = "none",
		description = "nothing at all!",
		icon = "triangle-target.png",
		r = 0.1,
		g = 0.1,
		b = 0.1,
		inputs = {},
		outputs = {},
		jobs = {},
		self_sourcing_fraction = 1,
	}
	ProductionMethod:new {
		name = "communal-fire",
		description = "communal fire",
		icon = "celebration-fire.png",
		r = 1,
		g = 0.1,
		b = 0.1,
		inputs = {},
		outputs = { ["administration"] = 10 },
		jobs = {},
		self_sourcing_fraction = 0,
	}
	ProductionMethod:new {
		name = "witch-doctor",
		description = "witch doctor",
		icon = "hut.png",
		r = 0,
		g = 1,
		b = 1,
		inputs = { ["tools-like"] = 0.125 },
		outputs = { ["healthcare"] = 5 },
		jobs = { [job("shamans")] = 1 },
		job_type = JOBTYPE.CLERK,
		foraging = true,
		self_sourcing_fraction = 0.05,
		nature_yield_dependence = 1,
	}

	-- FORAGING SPECIALIZATION
	-- using tools and tools-like to increase foraging output?

	-- 1.5x effciciency as foraging water
	ProductionMethod:new {
		name = "water-carrier",
		description = "water carrier",
		icon = "droplets.png",
		r = 0.1,
		g = 0.1,
		b = 1,
		inputs = { ["containers"] = 0.125 },
		outputs = { ["water"] = 3 },
		jobs = { [job("water-carriers")] = 1 },
		job_type = JOBTYPE.HAULING,
		hydration = true,
		self_sourcing_fraction = 0.05,
	}
	-- same effciciency as foraging berries, grain and timber at 2:2:1 ratios
	ProductionMethod:new {
		name = "gathering-0",
		description = "gathering",
		icon = "berries-bowl.png",
		r = 0.1,
		g = 1,
		b = 0.1,
		outputs = { ["berries"] = 0.6, ["grain"] = 0.75, ["timber"] = 0.25 },
		jobs = { [job("gatherers")] = 1 },
		job_type = JOBTYPE.FORAGER,
		self_sourcing_fraction = 0.05,
		foraging = true,
		nature_yield_dependence = 1,
	}
	-- 1.5x effciciency of foraging berries, grain and timber at 2:2:1 ratios
	ProductionMethod:new {
		name = "gathering-1",
		description = "gathering",
		icon = "fruit-bowl.png",
		r = 0.1,
		g = 1,
		b = 0.1,
		inputs = { ["tools-like"] = 0.125 },
		outputs = { ["berries"] = 0.9, ["grain"] = 1.125, ["timber"] = 0.375 },
		jobs = { [job("gatherers")] = 1 },
		job_type = JOBTYPE.FORAGER,
		self_sourcing_fraction = 0.05,
		foraging = true,
		nature_yield_dependence = 1,
	}
	-- 2x effciciency of foraging berries, grain and timber at 2:2:1 ratios
	ProductionMethod:new {
		name = "gathering-2",
		description = "gathering",
		icon = "basket.png",
		r = 0.1,
		g = 1,
		b = 0.1,
		inputs = { ["tools"] = 0.125 },
		outputs = { ["berries"] = 1.2, ["grain"] = 1.5, ["timber"] = 0.5 },
		jobs = { [job("gatherers")] = 1 },
		job_type = JOBTYPE.FORAGER,
		self_sourcing_fraction = 0.05,
		foraging = true,
		nature_yield_dependence = 1,
	}
	-- same effciciency as foraging game
	ProductionMethod:new {
		name = "hunting-0",
		description = "hunting",
		icon = "meat.png",
		r = 1,
		g = 0.2,
		b = 0.3,
		inputs = {},
		outputs = { ["meat"] = 1, ["hide"] = 0.25 },
		jobs = { [job("hunters")] = 1 },
		job_type = JOBTYPE.HUNTING,
		self_sourcing_fraction = 0.05,
		foraging = true,
		nature_yield_dependence = 1,
	}
	-- 1.5x effciciency of foraging game
	ProductionMethod:new {
		name = "hunting-1",
		description = "hunting",
		icon = "stone-spear.png",
		r = 1,
		g = 0.2,
		b = 0.3,
		inputs = { ["tools-like"] = 0.125 },
		outputs = { ["meat"] = 1.5, ["hide"] = 0.375 },
		jobs = { [job("hunters")] = 1 },
		job_type = JOBTYPE.HUNTING,
		self_sourcing_fraction = 0.05,
		foraging = true,
		nature_yield_dependence = 1,
	}
	-- 2x effciciency of foraging game
	ProductionMethod:new {
		name = "hunting-2",
		description = "hunting",
		icon = "bow-arrow.png",
		r = 1,
		g = 0.2,
		b = 0.3,
		inputs = { ["tools"] = 0.125 },
		outputs = { ["meat"] = 2, ["hide"] = 0.5 },
		jobs = { [job("hunters")] = 1 },
		job_type = JOBTYPE.HUNTING,
		self_sourcing_fraction = 0.05,
		foraging = true,
		nature_yield_dependence = 1,
	}

	ProductionMethod:new {
		name = "flint-extraction",
		description = "flint extraction",
		icon = "stone-stack.png",
		r = 0.1,
		g = 1,
		b = 0.1,
		inputs = {},
		outputs = { ["blanks-flint"] = 1 },
		jobs = { [job("knappers")] = 2 },
		job_type = JOBTYPE.LABOURER,
		self_sourcing_fraction = 0,
	}
	ProductionMethod:new {
		name = "blanks-knapping",
		description = "flint knapping",
		icon = "rock.png",
		r = 0.1,
		g = 1,
		b = 0.1,
		inputs = { ["blanks-core"] = 1 / 8 }, -- one blank can make 8 tools - made up value
		outputs = { ["tools-blanks"] = 1 },
		jobs = { [job("knappers")] = 1 },
		job_type = JOBTYPE.ARTISAN,
		self_sourcing_fraction = 0.8,
	}
	ProductionMethod:new {
		name = "obsidian-extraction",
		description = "obsidian extraction",
		icon = "stone-stack.png",
		r = 0.1,
		g = 1,
		b = 0.1,
		inputs = {},
		outputs = { ["blanks-obsidian"] = 1 },
		jobs = { [job("knappers")] = 2 },
		job_type = JOBTYPE.LABOURER,
		self_sourcing_fraction = 0,
	}

	ProductionMethod:new {
		name = "brewing-grain",
		description = "ale, beer made with hops or rarer ingredients",
		icon = "beer-stein.png",
		r = 0.7,
		g = 0.36,
		b = 0.9,
		inputs = { ["grain"] = 4 },
		outputs = { ["liquors"] = 4 },
		jobs = { [job("brewers")] = 2 },
		job_type = JOBTYPE.ARTISAN,
		self_sourcing_fraction = 0.2,
	}
	ProductionMethod:new {
		name = "brewing-fruit",
		description = "cider or wine made with fermented fruits",
		icon = "beer-stein.png",
		r = 0.7,
		g = 0.36,
		b = 0.9,
		inputs = { ["fruit"] = 4 },
		outputs = { ["liquors"] = 4 },
		jobs = { [job("brewers")] = 2 },
		job_type = JOBTYPE.ARTISAN,
		self_sourcing_fraction = 0.2,
	}

	-- COPPER PRODUCTION CHAIN

	ProductionMethod:new {
		name = "native-copper-gathering",
		description = "mining native ore close to the surface",
		icon = "gold-nugget.png",
		r = 0.65,
		g = 0.65,
		b = 0.65,
		inputs = { ["tools"] = 0.25 },
		outputs = { ["copper-native"] = 5 },
		jobs = { [job("miners")] = 1 },
		job_type = JOBTYPE.LABOURER,
	}
	ProductionMethod:new {
		name = "surface-copper-mining",
		description = "mining ore close to the surface",
		icon = "ore.png",
		r = 0.65,
		g = 0.65,
		b = 0.65,
		inputs = { ["tools"] = 0.5 },
		outputs = { ["copper-ore"] = 10 },
		jobs = { [job("miners")] = 1 },
		job_type = JOBTYPE.LABOURER,
	}
	ProductionMethod:new {
		name = "fire-copper-mining",
		description = "mining ore with help of fire",
		icon = "ore.png",
		r = 0.65,
		g = 0.65,
		b = 0.65,
		inputs = { ["tools"] = 1, ["fuel"] = 1 },
		outputs = { ["copper-ore"] = 20 },
		jobs = { [job("miners")] = 1 },
		job_type = JOBTYPE.LABOURER,
	}
	ProductionMethod:new {
		name = "copper-smelting",
		description = "smelting copper ore",
		icon = "metal-bars.png",
		r = 0.65,
		g = 0.65,
		b = 0.65,
		inputs = { ["copper-source"] = 1, ["structural-material"] = 0.1, ["fuel"] = 5 },
		outputs = { ["copper-bars"] = 1 },
		jobs = { [job("smelters")] = 1 },
		job_type = JOBTYPE.ARTISAN,
	}
	ProductionMethod:new {
		name = "smith-tools-native-copper",
		description = "forming native copper into tools",
		icon = "anvil.png",
		r = 0.65,
		g = 0.65,
		b = 0.65,
		inputs = { ["copper-native"] = 1, ["tools"] = 1 },
		outputs = { ["tools-native-copper"] = 5 },
		jobs = { [job("blacksmiths")] = 1 },
		job_type = JOBTYPE.ARTISAN,
		self_sourcing_fraction = 0.75
	}
	ProductionMethod:new {
		name = "smith-tools-cast-copper",
		description = "smithing copper into tools",
		icon = "anvil.png",
		r = 0.65,
		g = 0.65,
		b = 0.65,
		inputs = { ["copper-bars"] = 1, ["tools"] = 0.1, ["fuel"] = 5 },
		outputs = { ["tools-cast-copper"] = 5 },
		jobs = { [job("blacksmiths")] = 1 },
		job_type = JOBTYPE.ARTISAN,
		self_sourcing_fraction = 0.75
	}

	ProductionMethod:new {
		name = "clay-extraction",
		description = "clay extraction",
		icon = "powder.png",
		r = 0.25,
		g = 0.25,
		b = 0.25,
		inputs = { ["containers"] = 0.1 },
		outputs = { ["clay"] = 20 },
		jobs = { [job("gatherers")] = 1, },
		job_type = JOBTYPE.LABOURER,
		self_sourcing_fraction = 0.1,
		clay_extreme_max = 1,
		clay_ideal_max = 1,
		clay_ideal_min = 0.65,
		clay_extreme_min = 0.4,
	}

	ProductionMethod:new {
		name = "pottery",
		description = "pottery",
		icon = "amphora.png",
		r = 0.55,
		g = 0.25,
		b = 0.25,
		inputs = { ["clay"] = 10 },
		outputs = { ["containers"] = 10 },
		jobs = { [job("potterers")] = 1, },
		job_type = JOBTYPE.ARTISAN,
		self_sourcing_fraction = 0.5,
	}

	ProductionMethod:new {
		name = "woodcutting",
		description = "woodcutting",
		icon = "stone-axe.png",
		r = 0.35,
		g = 0.25,
		b = 0.65,
		inputs = { ["tools-advanced"] = 1 },
		outputs = { ["timber"] = 10 },
		jobs = { [job("woodcutters")] = 1, },
		job_type = JOBTYPE.LABOURER,
		self_sourcing_fraction = 0.5,
		forest_dependence = 1,
	}

	ProductionMethod:new {
		name = "stone-extraction",
		description = "stone-extraction",
		icon = "stone-block.png",
		r = 0.8,
		g = 0.8,
		b = 0.8,
		inputs = { ["tools-advanced"] = 1 },
		outputs = { ["stone"] = 10 },
		jobs = { [job("quarrymen")] = 1, },
		job_type = JOBTYPE.LABOURER,
		self_sourcing_fraction = 0.5,
	}

	ProductionMethod:new {
		name = "tanning",
		description = "tanning",
		icon = "animal-hide.png",
		r = 1,
		g = 0.55,
		b = 0.55,
		inputs = { ["tannin"] = 1, ["water"] = 2, ["hide"] = 5 },
		outputs = { ["leather"] = 5 },
		jobs = { [job("tanners")] = 1, },
		job_type = JOBTYPE.ARTISAN,
		self_sourcing_fraction = 0.7,
	}

	ProductionMethod:new {
		name = "leather-clothing",
		description = "leather clothing",
		icon = "kimono.png",
		r = 1,
		g = 0.75,
		b = 0.45,
		inputs = { ["tools"] = 0.25, ["leather"] = 4 },
		outputs = { ["clothes"] = 2 },
		jobs = { [job("artisans")] = 1, },
		job_type = JOBTYPE.ARTISAN,
		self_sourcing_fraction = 0.75,
	}

	ProductionMethod:new {
		name = "furniture",
		description = "furniture",
		icon = "wooden-chair.png",
		r = 1,
		g = 0.55,
		b = 0.65,
		inputs = { ["tools"] = 2, ["timber"] = 4 },
		outputs = { ["furniture"] = 3 },
		jobs = { [job("artisans")] = 1, },
		job_type = JOBTYPE.ARTISAN,
		self_sourcing_fraction = 0.85,
	}

	ProductionMethod:new {
		name = "rye-farming",
		description = "Rye",
		icon = "wheat.png",
		r = 0.2,
		g = 0.65,
		b = 0,
		inputs = { ["tools"] = 0.25 },
		outputs = { ["grain"] = 2 },
		jobs = { [job("farmers")] = 1, },
		job_type = JOBTYPE.FARMER,
		self_sourcing_fraction = 0.125,
		crop = true,
		temperature_ideal_min = 11,
		temperature_ideal_max = 13,
		temperature_extreme_min = 3,
		temperature_extreme_max = 30,
		rainfall_ideal_min = 40,
		rainfall_ideal_max = 70,
		rainfall_extreme_min = 5,
		rainfall_extreme_max = 200,
	}

	ProductionMethod:new {
		name = "beekeeping",
		description = "Beekeeping",
		icon = "high-grass.png",
		r = 0.2,
		g = 0.65,
		b = 0,
		inputs = { ["tools"] = 0.25 },
		outputs = { ["honey"] = 1 },
		jobs = { [job("farmers")] = 1, },
		job_type = JOBTYPE.FARMER,
		self_sourcing_fraction = 0.125,
		crop = true,
		temperature_ideal_min = 11,
		temperature_ideal_max = 20,
		temperature_extreme_min = 5,
		temperature_extreme_max = 30,
		rainfall_ideal_min = 40,
		rainfall_ideal_max = 70,
		rainfall_extreme_min = 5,
		rainfall_extreme_max = 200,
	}
end

return d
