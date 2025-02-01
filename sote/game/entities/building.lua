local bld = {}
bld.Building = {}

---@param estate estate_id estate to build the building in
---@param building_type building_type_id
---@return building_id
function bld.Building.new(estate, building_type)
	local new_id = DATA.create_building()
	DATA.building_set_current_type(new_id, building_type)
	DATA.force_create_building_estate(estate, new_id)
	return new_id
end

function bld.Building.amount_of_workers(building)
	local worker = DATA.employment_get_worker(DATA.get_employment_from_building(building))
	if worker == INVALID_ID then
		return 0
	end
	return 1
end


return bld
