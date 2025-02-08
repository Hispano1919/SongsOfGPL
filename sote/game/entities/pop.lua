local language_utils = require "game.entities.language".Language

local rtab = {}
rtab.POP = {}

---Creates a new POP
---@param race race_id
---@param faith faith_id
---@param culture culture_id
---@param female boolean
---@param year number year pop was born
---@param birth_tick number tick in year pop was born
---@return pop_id
function rtab.POP.new(race, faith, culture, female, year, birth_tick)
	local r = DATA.fatten_pop(DATA.create_pop())

	assert(faith ~= nil)
	assert(culture ~= nil)

	r.unique_id = WORLD.unique_id
	WORLD.unique_id = WORLD.unique_id + 1

	r.rank = CHARACTER_RANK.POP

	assert(race ~= INVALID_ID)

	r.race = race
	r.faith = faith
	r.culture = culture
	r.female = female
	r.birth_year = year
	r.birth_tick = birth_tick

	r.name = language_utils.get_random_name(DATA.culture_get_language(culture))
	r.busy                     = false

	local total_consumed, total_demanded = 0, 0

	-- DATA.for_each_trade_good(function (item)
	-- 	DATA.pop_inc_inventory(r.id, item, 100)
	-- end)

	for index = 1, MAX_NEED_SATISFACTION_POSITIONS_INDEX do
		local need = DATA.race_get_male_needs_need(race, index)
		-- print(index, need, DATA.race_get_male_needs_use_case(race, index), DATA.race_get_male_needs_required(race, index))

		if need == NEED.INVALID then
			break
		end

		DATA.pop_set_need_satisfaction_need(r.id, index, need)
		DATA.pop_set_need_satisfaction_use_case(r.id, index, DATA.race_get_male_needs_use_case(race, index))

		local required = DATA.race_get_male_needs_required(race, index)
		if female then
			required = DATA.race_get_female_needs_required(race, index)
		end
		DATA.pop_set_need_satisfaction_consumed(r.id, index, 0)
		DATA.pop_set_need_satisfaction_demanded(r.id, index, required)
		assert(required > 0, DATA.race_get_name(race) .. " " .. DATA.need_get_name(need))
		if DATA.need_get_life_need(need) then
			DATA.pop_set_need_satisfaction_consumed(r.id, index, required * 0.5)
			total_consumed = total_consumed + required * 0.5
		end
		total_demanded = total_demanded + required
	end

	r.forage_ratio = 0.75
	r.work_ratio = 0.25
	r.spend_savings_ratio = 0.5
	r.free_will = true
	r.is_player = false

	r.basic_needs_satisfaction = total_consumed / total_demanded
	r.life_needs_satisfaction = 0.5

	r.savings                  = 0
	r.dead                     = false
	r.former_pop               = false

	for i = 0, 19 do
		DATA.pop_set_dna(r.id, i, love.math.random())
	end

	return r.id
end

---@param pop_id pop_id
function rtab.POP.get_age_multiplier(pop_id)
	return DCON.age_multiplier(pop_id)
end

---@param pop_id pop_id
---@return string age_range
function rtab.POP.get_age_string(pop_id)
	local age = AGE_YEARS(pop_id)
	local race = DATA.pop_get_race(pop_id)

	local child_age = DATA.race_get_child_age(race)
	local teen_age = DATA.race_get_teen_age(race)
	local adult_age = DATA.race_get_adult_age(race)
	local middle_age = DATA.race_get_middle_age(race)
	local elder_age = DATA.race_get_elder_age(race)
	local max_age = DATA.race_get_max_age(race)

	if age < child_age then
		return "baby"
	elseif age < teen_age then
		return "child"
	elseif age < adult_age then
		return "teen"
	elseif age < middle_age then
		return "adult"
	elseif age < elder_age then
		return "middle age"
	else
		return "elder"
	end
end

--- Recalculate and return satisfaction percentage
---comment
---@param pop_id pop_id
---@return number
---@return number
function rtab.POP.update_satisfaction(pop_id)
	local total_consumed, total_demanded = 0, 0
	local life_consumed, life_demanded = 0, 0
	for i = 1, MAX_NEED_SATISFACTION_POSITIONS_INDEX do
		local use_case = DATA.pop_get_need_satisfaction_use_case(pop_id, i)
		if use_case == INVALID_ID then
			break
		end
		local need = DATA.pop_get_need_satisfaction_need(pop_id, i)

		local consumed, demanded = 0, 0
		consumed = consumed + DATA.pop_get_need_satisfaction_consumed(pop_id, i)
		demanded = demanded + DATA.pop_get_need_satisfaction_demanded(pop_id, i)

		if DATA.need_get_life_need(need) then
			life_consumed = life_consumed + consumed
			life_demanded = life_demanded + demanded
		else
			total_consumed = total_consumed + consumed
			total_demanded = total_demanded + demanded
		end
	end
	local life_satisfaction = life_consumed / life_demanded
	local basic_satisfaction = (total_consumed + life_consumed) / (total_demanded + life_demanded)
	DATA.pop_set_life_needs_satisfaction(pop_id, life_satisfaction)
	DATA.pop_set_basic_needs_satisfaction(pop_id, basic_satisfaction)

	-- local s = tostring(life_consumed) .. " " .. tostring(life_demanded) .. " " .. tostring(total_consumed + life_consumed) .. " " .. tostring(total_demanded + life_demanded)
	assert(life_satisfaction == life_satisfaction)
	assert(basic_satisfaction == basic_satisfaction)
	return life_satisfaction, basic_satisfaction
end

---Returns age adjusted size of pop
---@param pop pop_id
---@return number size
function rtab.POP.get_size(pop)
	local race = RACE(pop)
	local age_multiplier = rtab.POP.get_age_multiplier(pop)
	if DATA.pop_get_female(pop) then
		return DATA.race_get_female_body_size(race) * age_multiplier
	end
	return DATA.race_get_male_body_size(race) * age_multiplier
end

---Returns age adjusted size of pop
---@param pop pop_id
---@return number size
function rtab.POP.get_carry_capacity_weight(pop)
	local race = RACE(pop)
	local age_multiplier = rtab.POP.get_age_multiplier(pop)
	return DATA.race_get_carrying_capacity_weight(race) * age_multiplier
end

---Returns age adjusted size of pop
---@param pop pop_id
---@return number infrastructure_need
function rtab.POP.get_infrastructure_need(pop)
	local race = RACE(pop)
	local age_multiplier = rtab.POP.get_age_multiplier(pop)
	if DATA.pop_get_female(pop) then
		return DATA.race_get_female_infrastructure_needs(race) * age_multiplier
	end
	return DATA.race_get_male_infrastructure_needs(race) * age_multiplier
end

---Returns age adjust racial efficiency
---@param pop pop_id
---@param jobtype JOBTYPE
---@return number
function rtab.POP.job_efficiency(pop, jobtype)
	local female = DATA.pop_get_female(pop)
	local race = RACE(pop)
	local age_multiplier = rtab.POP.get_age_multiplier(pop)
	if female then
		return DATA.race_get_female_efficiency(race, jobtype) * age_multiplier
	end
	return DATA.race_get_male_efficiency(race, jobtype) * age_multiplier
end

---returns division of time for a given pop_id base on age, forage_ratio, employment and warband
---@param pop_id pop_id
---@return number forage_time
---@return number warband_time
---@return number work_time
---@return number learning_time
function rtab.POP.get_time_allocation(pop_id)
	local free_time, forage_time, warband_time, learning_time = 1, 0, 0, 0
	-- first remove time spend growing and learning
	local age = AGE_YEARS(pop_id)
	local teen_age = DATA.race_get_teen_age(RACE(pop_id))
	if age < teen_age then
		free_time = age / teen_age
		learning_time = 1 - free_time
	end
	-- then work for warband if part of one
	local warband_id = rtab.POP.get_warband_of(pop_id)
	if warband_id ~= INVALID_ID then
		if DATA.warband_get_current_status == WARBAND_STATUS.IDLE and DATA.warband_get_idle_stance == WARBAND_STANCE.FORAGE then
			local unit_type_id = rtab.POP.get_unit_type_of(pop_id)
			if unit_type_id ~= INVALID_ID then
				warband_time = math.min(free_time, DATA.unit_type_get_foraging(unit_type_id))
			else -- officers use a quarter time to forage
				warband_time = 0.25
			end
		else
			warband_time = DATA.warband_get_current_free_time_ratio(warband_id)
		end
		free_time = math.max(0,free_time - warband_time)
	end
	-- remaining time is used to forage for life needs
	forage_time = math.min(free_time, DATA.pop_get_forage_ratio(pop_id))
	free_time = math.max(0, free_time - forage_time)
	-- finally any remaining free time can be used to work
	return forage_time, warband_time, free_time, learning_time
end

---Returns age adjust demand for a (need, use case) pair
---@param pop pop_id
---@param need NEED
---@param use_case use_case_id
---@return number
function rtab.POP.calculate_need_use_case_satisfaction(pop, need, use_case)
	for i = 1, MAX_NEED_SATISFACTION_POSITIONS_INDEX do
		if DATA.pop_get_need_satisfaction_use_case(pop, i) == 0 then
			break
		end
		if use_case == DATA.pop_get_need_satisfaction_use_case(pop, i) then
			if need == DATA.pop_get_need_satisfaction_need(pop, i) then
				return DATA.pop_get_need_satisfaction_demanded(pop, i)
			end
		end
	end
	return 0
end

---Returns the adjusted health value for the provided pop.
---@param pop pop_id
---@return number attack health modified by pop race and sex
function rtab.POP.get_health(pop)
	return rtab.POP.get_size(pop)
end

---Returns the adjusted attack value for the provided pop.
---@param pop pop_id
---@return number pop_adjusted attack modified by pop race and sex
function rtab.POP.get_attack(pop)
	return rtab.POP.job_efficiency(pop, JOBTYPE.WARRIOR)
end

---Returns the adjusted armor value for the provided pop.
---@param pop pop_id
---@return number pop_adjusted armor modified by pop race and sex
function rtab.POP.get_armor(pop)
	return 1
end

---Returns the adjusted speed value for the provided pop.
---@param pop pop_id
---@return speed pop_adjusted speed modified by pop race and sex
function rtab.POP.get_speed(pop)
	---@type speed
	local result = {
		base = rtab.POP.get_age_multiplier(pop),
		can_fly = false,
		forest_fast = DATA.race_get_requires_large_forest(DATA.pop_get_race(pop)),
		river_fast = DATA.race_get_requires_large_river(DATA.pop_get_race(pop))
	}

	return result
end

---Returns the adjusted combat strength values for the provided pop.
---@param pop pop_id
---@return number health
---@return number attack
---@return number armor
---@return number speed
function rtab.POP.get_strength(pop)
	return rtab.POP.get_health(pop), rtab.POP.get_attack(pop), rtab.POP.get_armor(pop), rtab.POP.get_speed(pop).base
end

---Returns the adjusted spotting value for the provided pop.
---@param pop pop_id
---@return number pop_adjusted spotting modified by pop race and sex
function rtab.POP.get_spotting(pop)
	local race = DATA.pop_get_race(pop)
	local spotting = DATA.race_get_spotting(race)
	return spotting * rtab.POP.get_age_multiplier(pop)
end

---Returns the adjusted visibility value for the provided pop.
---@param pop pop_id
---@return number pop_adjusted visibility modified by pop race and sex
function rtab.POP.get_visibility(pop)
	local race = DATA.pop_get_race(pop)
	local visibility = DATA.race_get_visibility(race)
	local mod = visibility * rtab.POP.get_size(pop)
	return mod
end

---Returns the adjusted travel day cost value for the provided pop.
---@param pop pop_id
---@return number pop_adjusted food need modified by pop race and sex
function rtab.POP.get_supply_use(pop)
	local pop_food = rtab.POP.calculate_need_use_case_satisfaction(pop, NEED.FOOD, CALORIES_USE_CASE)
	return pop_food / 30 * rtab.POP.get_size(pop)
end

---Returns the adjusted hauling capacity value for the provided pop.
---@param pop pop_id
---@return number pop_adjusted hauling modified by pop race and sex
function rtab.POP.get_supply_capacity(pop)
	return rtab.POP.job_efficiency(pop, JOBTYPE.HAULING)
end



---adds new trait to character
---@param pop pop_id
---@param trait TRAIT
function rtab.POP.add_trait(pop, trait)
	for i = 1, MAX_TRAIT_INDEX  do
		if DATA.pop_get_traits(pop, i) == TRAIT.INVALID then
			DATA.pop_set_traits(pop, i, trait)
			return
		end
	end
end

---checks trait of character
---@param pop pop_id
---@param trait TRAIT
function rtab.POP.has_trait(pop, trait)
	return HAS_TRAIT(pop, trait)
end

--fetch/check helper functions

---returns building_id if pop is employed or INVALID_ID if not
---@param pop_id pop_id
---@return building_id
function rtab.POP.get_employer_of(pop_id)
	if pop_id ~= INVALID_ID then
		local occupation = DATA.get_employment_from_worker(pop_id)
		if occupation and DCON.dcon_employment_is_valid(occupation-1) then
			local employer_id = DATA.employment_get_building(occupation)
			if occupation and DCON.dcon_building_is_valid(employer_id-1) then
				return employer_id
			end
		end
	end
	return INVALID_ID
end
---returns job_id if pop is employed or INVALID_ID if not
---@param pop_id pop_id
---@return job_id
function rtab.POP.get_job_of(pop_id)
	if pop_id ~= INVALID_ID then
		local occupation = DATA.get_employment_from_worker(pop_id)
		if occupation and DCON.dcon_employment_is_valid(occupation-1) then
			local job_id = DATA.employment_get_job(occupation)
			if job_id and DCON.dcon_job_is_valid(job_id-1) then
				return job_id
			end
		end
	end
	return INVALID_ID
end

---returns warband_id if pop is in one or INVALID_ID if not
---@param pop_id pop_id
---@return warband_id
function rtab.POP.get_warband_of(pop_id)
	-- a little heavy on the if checks
	if pop_id ~= INVALID_ID then
		local warband_id = rtab.POP.get_warband_of_leader(pop_id)
		if warband_id ~= INVALID_ID then
			return warband_id
		end
		local warband_id = rtab.POP.get_warband_of_recruiter(pop_id)
		if warband_id ~= INVALID_ID then
			return warband_id
		end
		local warband_id = rtab.POP.get_warband_of_commander(pop_id)
		if warband_id ~= INVALID_ID then
			return warband_id
		end
		local warband_id = rtab.POP.get_warband_of_unit(pop_id)
		if warband_id ~= INVALID_ID then
			return warband_id
		end
	end
	return INVALID_ID
end
---returns warband_id if a pop is a leader of one or INVALID_ID
---@param pop_id pop_id
---@return warband_id
function rtab.POP.get_warband_of_leader(pop_id)
	if pop_id ~= INVALID_ID then
		local leadership = DATA.get_warband_leader_from_leader(pop_id)
		if leadership and DCON.dcon_warband_leader_is_valid(leadership-1) then
			local warband_id = DATA.warband_leader_get_warband(leadership)
			if warband_id and DCON.dcon_warband_is_valid(warband_id-1) then
				return warband_id
			end
		end
	end
	return INVALID_ID
end
---returns warband_id if a pop is a recruiter of one or INVALID_ID
---@param pop_id pop_id
---@return warband_id
function rtab.POP.get_warband_of_recruiter(pop_id)
	if pop_id ~= INVALID_ID then
		local leadership = DATA.get_warband_recruiter_from_recruiter(pop_id)
		if leadership and DCON.dcon_warband_recruiter_is_valid(leadership-1) then
			local warband_id = DATA.warband_recruiter_get_warband(leadership)
			if warband_id and DCON.dcon_warband_is_valid(warband_id-1) then
				return warband_id
			end
		end
	end
	return INVALID_ID
end
---returns warband_id if a pop is a commander of one or INVALID_ID
---@param pop_id pop_id
---@return warband_id
function rtab.POP.get_warband_of_commander(pop_id)
	if pop_id ~= INVALID_ID then
		local leadership = DATA.get_warband_commander_from_commander(pop_id)
		if leadership and DCON.dcon_warband_commander_is_valid(leadership-1) then
			local warband_id = DATA.warband_commander_get_warband(leadership)
			if warband_id and DCON.dcon_warband_is_valid(warband_id-1) then
				return warband_id
			end
		end
	end
	return INVALID_ID
end
---returns warband_id if a pop is a unit of one or INVALID_ID
---@param pop_id pop_id
---@return warband_id
function rtab.POP.get_warband_of_unit(pop_id)
	if pop_id ~= INVALID_ID then
		local unit = DATA.get_warband_unit_from_unit(pop_id)
		if unit and DCON.dcon_warband_unit_is_valid(unit-1) then
			local warband_id = DATA.warband_unit_get_warband(unit)
			if warband_id and DCON.dcon_warband_is_valid(warband_id-1) then
				return warband_id
			end
		end
	end
	return INVALID_ID
end
---returns unit_type_d if pop is a unit in a warband or INVALID_ID
---@param pop_id pop_id
---@return unit_type_id
function rtab.POP.get_unit_type_of(pop_id)
	if pop_id ~= INVALID_ID then
		local unit = DATA.get_warband_unit_from_unit(pop_id)
		if unit and DCON.dcon_warband_unit_is_valid(unit-1) then
			local unit_type_id = DATA.warband_unit_get_type(unit)
			if unit_type_id and DCON.dcon_unit_type_is_valid(unit_type_id-1) then
				return unit_type_id
			end
		end
	end
	return INVALID_ID
end

---returns sucessor if pop has one or INVALID_ID
---@param pop_id pop_id
---@return pop_id
function rtab.POP.get_successor_of(pop_id)
	if pop_id ~= INVALID_ID then
		local succession = DATA.get_succession_from_successor_of(pop_id)
		if succession and DCON.dcon_succession_is_valid(succession-1) then
			local successor_id = DATA.succession_get_successor(succession)
			if successor_id and DCON.dcon_pop_is_valid(successor_id-1) then
				return successor_id
			end
		end
	end
	return INVALID_ID
end

---returns loyal_to if pop has one or INVALID_ID
---@param pop_id pop_id
---@return pop_id
function rtab.POP.get_loyal_to_of(pop_id)
	if pop_id ~= INVALID_ID then
		local loyalty = DATA.get_loyalty_from_bottom(pop_id)
		if loyalty and DCON.dcon_loyalty_is_valid(loyalty-1) then
			local loyal_to_id = DATA.loyalty_get_top(loyalty)
			if loyal_to_id and DCON.dcon_pop_is_valid(loyal_to_id-1) then
				return loyal_to_id
			end
		end
	end
	return INVALID_ID
end



return rtab
