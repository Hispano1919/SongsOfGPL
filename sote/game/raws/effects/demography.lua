local warband_utils = require "game.entities.warband"

local demo = {}

---Kills a single pop and removes it from all relevant references.
---@param pop pop_id
function demo.kill_pop(pop)
	-- print("kill " .. pop.name)
	demo.fire_pop(pop)
	warband_utils.unregister_military(pop)
	DATA.delete_pop(pop)
end

---Fires an employed pop and adds it to the unemployed pops list.
---It leaves the "job" set so that inference of social class can be performed.
---@param pop pop_id
function demo.fire_pop(pop)
	local employment = DATA.get_employment_from_worker(pop)
	if DATA.employment_get_building(employment) ~= INVALID_ID then
		DATA.delete_employment(employment)
		local building = DATA.employment_get_building(employment)
		if #DATA.get_employment_from_building(building) == 0 then
			local fat = DATA.fatten_building(building)
			fat.last_income = 0
			fat.last_donation_to_owner = 0
			fat.subsidy_last = 0
		end
	end
end

---@param province province_id
---@param pop pop_id
function demo.outlaw_pop(province, pop)
	-- ignore pops which are already outlawed
	if DATA.get_outlaw_location_from_outlaw(pop) then
		return
	end

	demo.fire_pop(pop)
	warband_utils.unregister_military(pop)
	DATA.force_create_outlaw_location(province, pop)

	local pop_location = DATA.get_pop_location_from_pop(pop)
	if pop_location then
		return
	end
	DATA.delete_pop_location(pop_location)
end

---Moves a pop from province to warband
---@param pop pop_id
---@param warband warband_id
---@param unit_type UNIT_TYPE
function demo.recruit(pop, warband, unit_type)
	local membership = DATA.get_warband_unit_from_unit(pop)
	-- if pop is already drafted, do nothing
	if membership ~= INVALID_ID then
		return
	end

	-- clean pop data
	demo.fire_pop(pop)
	warband_utils.unregister_military(pop)
	DATA.delete_character_location(DATA.get_character_location_from_character(pop))
	DATA.delete_pop_location(DATA.get_pop_location_from_pop(pop))

	-- set warband
	warband_utils.hire_unit(warband, pop, unit_type)
end

function demo.unrecruit(pop)
	local warband = UNIT_OF(pop)
	local province = TILE_PROVINCE(WARBAND_TILE(warband))

	if IS_CHARACTER(pop) then
		DATA.force_create_character_location(province, pop)
	else
		DATA.force_create_pop_location(province, pop)
	end

	warband_utils.fire_unit(warband, pop)
end

---Kills ratio of army
---@param warband warband_id
---@param ratio number
function demo.kill_off_warband(warband, ratio)
	local losses = 0
	---@type POP[]
	local pops_to_kill = {}

	for _, membership in ipairs(DATA.get_warband_unit_from_warband(warband)) do
		local pop = DATA.warband_unit_get_unit(membership)
		if not IS_CHARACTER(pop) and love.math.random() < ratio then
			table.insert(pops_to_kill, pop)
			losses = losses + 1
		end
	end

	for i, pop in ipairs(pops_to_kill) do
		demo.kill_pop(pop)
	end

	return losses
end

---kills of a ratio of army and returns the losses
---@param army warband_id[]
---@param ratio number
---@return number
function demo.kill_off_army(army, ratio)
	local losses = 0
	for _, warband in pairs(army) do
		losses = losses + demo.kill_off_warband(warband, ratio)
	end
	return losses
end

return demo