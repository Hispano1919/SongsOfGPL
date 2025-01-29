local tabb = require "engine.table"

local values = {}

---@param province province_id
---@return pop_id[]
function values.unemployed_pops(province)
	return tabb.filter_array(
		tabb.map_array(DATA.get_pop_location_from_location(province), DATA.pop_location_get_pop),
		function (pop)
			local employment = DATA.get_employment_from_worker(pop)
			local building = DATA.employment_get_building(employment)
			local race = DATA.pop_get_race(pop)
			local teen_age = DATA.race_get_teen_age(race)
			return DATA.pop_get_age(pop) > teen_age and building == INVALID_ID and not IS_CHARACTER(pop)
		end
	)
end

---@param province province_id
---@return building_id[]
function values.vacant_buildings_owned_by_locally_present_pops(province)
	return tabb.filter_array(
		tabb.map_array(DATA.get_building_location_from_location(province), DATA.building_location_get_building),
		function (building)
			local owner = DATA.ownership_get_owner(DATA.get_ownership_from_building(building))
			return PROVINCE(owner) == province and values.potential_job(building) ~= nil
		end
	)
end

---commenting
---@param province_id Province
---@return Character|nil
function values.sample_character_from_province(province_id)
	local characters = tabb.map_array(
		DATA.filter_array_character_location_from_location(province_id, ACCEPT_ALL),
		DATA.character_location_get_character
	)

	local amount = #characters
	if amount == 0 then
		return nil
	end

	local sample_index = love.math.random(amount)
	return characters[sample_index]
end


---all characters are pops
---@param province_id Province
---@return pop_id|nil
function values.sample_pop_from_province(province_id)
	local pops = tabb.map_array(
		DATA.filter_array_pop_location_from_location(province_id, ACCEPT_ALL),
		DATA.pop_location_get_pop
	)

	local amount = #pops
	if amount == 0 then
		return nil
	end

	local sample_index = love.math.random(amount)
	return pops[sample_index]
end

---all characters are pops
---@param province_id Province
---@return pop_id|nil
function values.sample_non_character_pop_from_province(province_id)
	local pops = tabb.map_array(
		DATA.filter_array_pop_location_from_location(province_id, function (item)
			local pop = DATA.pop_location_get_pop(item)
			if IS_CHARACTER(pop) then
				return false
			end
			return true
		end),
		DATA.pop_location_get_pop
	)

	local amount = #pops
	if amount == 0 then
		return nil
	end

	local sample_index = love.math.random(amount)
	return pops[sample_index]
end

---Returns a potential job, if a pop was to be employed by this building.
---@param building building_id
---@return job_id?
function values.potential_job(building)
	local btype = DATA.building_get_current_type(building)
	local method = DATA.building_type_get_production_method(btype)

	for i = 1, MAX_SIZE_ARRAYS_PRODUCTION_METHOD - 1 do
		local job = DATA.production_method_get_jobs_job(method, i)
		if job == INVALID_ID then
			break
		end

		local workers_with_this_job = 0
		for _, employment in ipairs(DATA.get_employment_from_building(building)) do
			if DATA.employment_get_job(employment) == job then
				workers_with_this_job = workers_with_this_job + 1
			end
		end

		local max_amount = DATA.production_method_get_jobs_amount(method, i)
		if max_amount > workers_with_this_job then
			return job
		end
	end

	return nil
end

return values