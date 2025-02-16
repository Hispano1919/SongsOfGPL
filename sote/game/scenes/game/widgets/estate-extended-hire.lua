local tabb = require "engine.table"
local ui = require "engine.ui";
local ut = require "game.ui-utils"
local province_utils = require "game.entities.province".Province
local pv = require "game.raws.values.politics"
local ev = require "game.raws.values.economy"

local economy_effects = require "game.raws.effects.economy"

---@class local_estate_building_data
---@field id building_type_id
---@field cost number
---@field profit number
---@field can_build boolean

---@type TableState
local table_state_building = {
	header_height = UI_STYLE.table_header_height,
	individual_height = UI_STYLE.scrollable_list_small_item_height,
	slider_level = 0,
	slider_width = UI_STYLE.slider_width,
	sorted_field = 1,
	sorting_order = true
}
---@type TableState
local table_state_workers = {
	header_height = UI_STYLE.table_header_height,
	individual_height = UI_STYLE.scrollable_list_small_item_height,
	slider_level = 0,
	slider_width = UI_STYLE.slider_width,
	sorted_field = 1,
	sorting_order = true
}

---@param k trade_good_id
local function render_good_icon(rect, k)
	local good = DATA.fatten_trade_good(k)
	ut.render_icon(rect:copy():shrink(-1), good.icon, 1, 1, 1, 1)
	ut.render_icon(rect, good.icon, good.r, good.g, good.b, 1)
end

---@param k use_case_id
local function render_use_case_icon(rect, k)
	local case = DATA.fatten_use_case(k)
	ut.render_icon(rect:copy():shrink(-1), case.icon, 1, 1, 1, 1)
	ut.render_icon(rect, case.icon, case.r, case.g, case.b, 1)
end

---@type building_id
local selected_building = INVALID_ID

---@param rect Rect
---@param estate estate_id
return function (rect, estate)
	local base_unit = UI_STYLE.scrollable_list_item_height
	ui.panel(rect)
	---@type pop_id
	local character = WORLD.player_character
	if character == INVALID_ID then
		ui.text("Can't hire workers as an observer", rect, "center", "center")
		return
	end

	if (estate == INVALID_ID) then
		ui.text("You have to expand estate before hiring new workers.", rect, "center", "center")
		return
	end

	local owner = OWNER(estate)
	local location = ESTATE_PROVINCE(estate)

	local realm = PROVINCE_REALM(location)
	local overseer = pv.overseer(realm)

	local is_public_estate = false
	if owner == INVALID_ID then
		is_public_estate = true
	end
	local can_build = false
	if owner == character then
		can_build = true
	end
	if is_public_estate and LEADER(realm) == character then
		can_build = true
	end
	if is_public_estate and overseer == character then
		can_build = true
	end

	if not can_build then
		ui.text("You are not allowed to hire workers in this estate.", rect, "center", "center")
		return
	end

	local funds = SAVINGS(character)
	if estate ~= INVALID_ID then
		funds = SAVINGS(character) + DATA.estate_get_savings(estate)
		if is_public_estate then
			funds = DATA.estate_get_savings(estate)
		end
	end

	local actual_manager = character
	if is_public_estate then
		actual_manager = overseer
	end

	---@type building_id[]
	local table_data = {}
	DATA.for_each_building_estate_from_estate(estate, function (item)
		table.insert(table_data, DATA.building_estate_get_building(item))
	end)

	---@type TableColumn<building_id>
	local name_column = {
		header = "name",
		width = base_unit * 10,
		active = true,
		render_closure = function (rect, k, v)
			local building_type = DATA.building_get_current_type(v)
			local name = DATA.building_type_get_name(building_type)
			if ut.text_button(name, rect, nil, nil, selected_building == v) then
				selected_building = v
			end
		end,
		value = function (k, v)
			return DATA.building_type_get_name(DATA.building_get_current_type(v))
		end
	}

	---@type TableColumn<building_id>
	local worker_column = {
		header = "worker",
		width = base_unit * 3,
		active = true,
		render_closure = function (rect, k, v)
			local worker = DATA.employment_get_worker(DATA.get_employment_from_building(v))
			if worker == INVALID_ID then
				ui.text("0", rect, "center", "center")
			else
				ui.text("1", rect, "center", "center")
			end
		end,
		value = function (k, v)
			local worker = DATA.employment_get_worker(DATA.get_employment_from_building(v))
			if worker == INVALID_ID then
				return 0
			else
				return 1
			end
		end
	}

	---@type TableColumn<building_id>
	local inputs_column = {
		header = "inputs",
		width = base_unit * 4,
		render_closure =  function (rect, k, v)
			local building_type = DATA.building_get_current_type(v)
			local method = DATA.building_type_get_production_method(building_type)
			local inputs = 0
			local tooltip = ""
			for i = 1, MAX_SIZE_ARRAYS_PRODUCTION_METHOD do
				local use = DATA.production_method_get_inputs_use(method, i)
				if use == INVALID_ID then
					break
				end
				inputs = inputs + 1
				local amount = DATA.production_method_get_inputs_amount(method, i)
				---@type string
				tooltip = tooltip .. DATA.use_case_get_description(use) .. " (" .. ut.to_fixed_point2(amount) .. "), "
			end

			local sub_rect = rect:copy()
			sub_rect.width = rect.width / inputs

			for i = 1, MAX_SIZE_ARRAYS_PRODUCTION_METHOD do
				local use = DATA.production_method_get_inputs_use(method, i)
				if use == INVALID_ID then
					break
				end
				render_use_case_icon(sub_rect, use)
				sub_rect.x = sub_rect.x + sub_rect.width
			end

			ui.tooltip(tooltip, rect)
		end,
		value = function (k, v)
			return DATA.building_type_get_name(DATA.building_get_current_type(v))
		end
	}

	---@type TableColumn<building_id>
	local outputs_column = {
		header = "outputs",
		width = base_unit * 4,
		render_closure =  function (rect, k, v)
			local building_type = DATA.building_get_current_type(v)
			local method = DATA.building_type_get_production_method(building_type)
			local outputs = 0
			local tooltip = ""
			for i = 1, MAX_SIZE_ARRAYS_PRODUCTION_METHOD do
				local output = DATA.production_method_get_outputs_good(method, i)
				if output == INVALID_ID then
					break
				end
				outputs = outputs + 1
				local amount = DATA.production_method_get_outputs_amount(method, i)
				---@type string
				tooltip = tooltip .. DATA.trade_good_get_description(output) .. " (" .. ut.to_fixed_point2(amount) .. "), "
			end

			local sub_rect = rect:copy()
			sub_rect.width = rect.width / outputs

			for i = 1, MAX_SIZE_ARRAYS_PRODUCTION_METHOD do
				local output = DATA.production_method_get_outputs_good(method, i)
				if output == INVALID_ID then
					break
				end
				render_good_icon(sub_rect, output)
				sub_rect.x = sub_rect.x + sub_rect.width
			end

			ui.tooltip(tooltip, rect)
		end,
		value = function (k, v)
			return DATA.building_type_get_name(DATA.building_get_current_type(v))
		end
	}

	local half = rect:copy()
	half.width = half.width / 2
	ut.table(half, table_data, {name_column, worker_column, inputs_column, outputs_column}, table_state_building)

	half.x = half.x + half.width

	local worker = INVALID_ID
	if selected_building ~= INVALID_ID then
		worker = DATA.employment_get_worker(DATA.get_employment_from_building(selected_building))
	end
	if worker == INVALID_ID then
		require "game.scenes.game.widgets.building-hire"(half, selected_building)
	else
		require "game.scenes.game.widgets.building-details"(half, selected_building)
	end
end
