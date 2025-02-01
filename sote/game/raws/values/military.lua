local character_values = require "game.raws.values.character"
local warband_utils = require "game.entities.warband"

local military_values = {}

---Returns scalar field representing how fast army can move in this tile
---@param army warband_id[]
---@return speed
function military_values.army_speed(army)
    -- speed is a minimal speed across all warbands
	---@type speed
	local result = {
		base = 9999,
		can_fly = true,
		forest_fast = true,
		river_fast = true
	}

	for _, warband in pairs(army) do
		local speed = military_values.warband_speed(warband)

		result.base = math.min(result.base, speed.base)
		result.can_fly = result.can_fly and speed.can_fly
		result.forest_fast = result.forest_fast and speed.forest_fast
		result.river_fast = result.river_fast and speed.river_fast
	end

	return result
end

---Returns scalar field representing how fast warband can move in this tile
---@param warband Warband
---@return speed
function military_values.warband_speed(warband)
	local leader = warband_utils.active_leader(warband)

	local total_hauling = warband_utils.total_hauling(warband)
	local total_weight = 1
	DATA.for_each_trade_good(function (item)
		-- TODO: implement weight of trade goods
		total_weight = total_weight + DATA.pop_get_inventory(leader, item) / 10
	end)

	---@type speed
	local result = character_values.travel_speed(leader)

    -- speed is a minimal speed across all warbands
	DATA.for_each_warband_unit_from_warband(warband, function (item)
		local pop = DATA.warband_unit_get_unit(item)
		local speed = character_values.travel_speed(pop)

		result.base = math.min(result.base, speed.base)
		result.can_fly = result.can_fly and speed.can_fly
		result.forest_fast = result.forest_fast and speed.forest_fast
		result.river_fast = result.river_fast and speed.river_fast
	end)

	result.base = result.base * math.min(2, (1 + total_hauling / total_weight / 50))

	return result
end

return military_values