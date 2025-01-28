local travel_effects = {}


---@param party warband_id
---@param target tile_id
function travel_effects.move_party(party, target)
	local location =  DATA.get_warband_location_from_warband(party)
	DATA.warband_location_set_location(location, target)
end

---commenting
---@param character Character
function travel_effects.exit_settlement(character)
	local warband = LEADER_OF_WARBAND(character)
	if warband == INVALID_ID then
		return
	end

	local province = PROVINCE(character)
	if province == INVALID_ID then
		return
	end

	local location_character = DATA.get_character_location_from_character(character)
	if DATA.character_location_get_location(location_character) ~= INVALID_ID then
		DATA.delete_character_location(location_character)
	end

	local location_pop = DATA.get_pop_location_from_pop(character)
	if DATA.pop_location_get_location(location_pop) ~= INVALID_ID then
		DATA.delete_pop_location(location_pop)
	end

	DATA.for_each_warband_unit_from_warband(warband, function (item)
		local unit = DATA.warband_unit_get_unit(item)

		local location_unit_character = DATA.get_character_location_from_character(unit)
		if DATA.character_location_get_location(location_unit_character) ~= INVALID_ID then
			DATA.delete_character_location(location_unit_character)
		end

		local location_unit_pop = DATA.get_pop_location_from_pop(unit)
		if DATA.pop_location_get_location(location_unit_pop) ~= INVALID_ID then
			DATA.delete_pop_location(location_unit_pop)
		end
	end)
end

---commenting
---@param character Character
function travel_effects.enter_settlement(character)
	local warband = LEADER_OF_WARBAND(character)
	if warband == INVALID_ID then
		return
	end

	local province = PROVINCE(character)
	if province ~= INVALID_ID then
		return
	end

	local tile = WARBAND_TILE(warband)
	local local_province = TILE_PROVINCE(tile)

	if PROVINCE_REALM(local_province) == INVALID_ID then
		return
	end

	DATA.force_create_character_location(local_province, character)

	DATA.for_each_warband_unit_from_warband(warband, function (item)
		local unit = DATA.warband_unit_get_unit(item)

		if (IS_CHARACTER(unit)) then
			DATA.force_create_character_location(local_province, unit)
		else
			DATA.force_create_pop_location(local_province, unit)
		end
	end)
end

return travel_effects