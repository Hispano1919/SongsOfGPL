local emp = {}
local demography_effects = require "game.raws.effects.demography"

---Update pops employment in the province.
---@param province province_id
function emp.run(province)
	--- check if some contracts are expired
	---@type pop_id[]
	local fire_list = {}
	DATA.for_each_building_location_from_location(province, function (location)
		local building = DATA.building_location_get_building(location)
		DATA.for_each_employment_from_building(building, function (item)
			local start = DATA.employment_get_start_date(item)
			local now = WORLD.day + WORLD.month * 30 + WORLD.year * 12 *30

			if now - start > 12 * 30 * 2 then
				table.insert(fire_list, DATA.employment_get_worker(item))
			end
		end)
	end)

	for _, value in ipairs(fire_list) do
		demography_effects.fire_pop(value)
	end
end

return emp
