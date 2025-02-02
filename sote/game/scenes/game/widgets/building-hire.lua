local demography_values = require "game.raws.values.demography"
local demography_effects = require "game.raws.effects.demography"
local economy_effects = require "game.raws.effects.economy"

local ut = require "game.ui-utils"
local ui = require "engine.ui"
local pui = require "game.scenes.game.widgets.pop-ui-widgets"
local portrait_widget = require "game.scenes.game.widgets.portrait"
local pop_utils = require "game.entities.pop".POP
local province_utils = require "game.entities.province".Province
local production_method_utils = require "game.raws.production-methods"
local dbm = require "game.economy.diet-breadth-model"
local warband_utils = require "game.entities.warband"

---@param rect Rect
---@param building building_id
return function (rect, building)
	if building == INVALID_ID then
		ui.text("Select any building", rect, "center", "center")
		return
	end

	local estate = BUILDING_ESTATE(building)
	local owner = OWNER(estate)
	local province = ESTATE_PROVINCE(estate)

	---@type pop_id
	local player = WORLD.player_character

	if player == INVALID_ID then
		ui.text("Observer can't hire workers", rect, "center", "center")
		return
	end

	if owner ~= WORLD.player_character then
		ui.text("Can't hire workers in this estate", rect, "center", "center")
		return
	end

	if province == INVALID_ID then
		return
	end

	if PROVINCE(owner) ~= province then
		ui.text("Enter the settlement to manage estate", rect, "center", "center")
		return
	end

	local building_type = DATA.building_get_current_type(building)
	local method = DATA.building_type_get_production_method(building_type)
	local inf = province_utils.get_infrastructure_efficiency(province)
	local efficiency_from_infrastructure = math.min(1.5, 0.5 + 0.5 * math.sqrt(2 * inf))
	local local_method_efficiency = production_method_utils.get_efficiency(method, province)
	local foragers = DATA.province_get_foragers(province)
	local foragers_limit = DATA.province_get_foragers_limit(province)
	local forage_efficiency = 1
	if DATA.production_method_get_foraging(method) then
		forage_efficiency = dbm.foraging_efficiency(foragers_limit, foragers)
	end

	local unemployed_pops = demography_values.unemployed_pops(province)
	local rows = 7
	local columns = 4
	local width = rect.width / columns
	local height = rect.height / rows
	local rect_for_item = ui.rect(0, 0, width, height)
	local index = 1

	for row = 1, rows do
		if unemployed_pops[index] == nil then
			break
		end
		for column = 1, columns do
			if unemployed_pops[index] == nil then
				break
			end

			local worker = unemployed_pops[index]

			rect_for_item.x = rect.x + (column - 1) * width
			rect_for_item.y = rect.y + (row - 1) * height
			ui.panel(rect_for_item)
			local portrait_rect = rect_for_item:copy():shrink(2)
			portrait_rect.width = portrait_rect.height
			portrait_widget(portrait_rect, worker)

			local info_rect = rect_for_item:copy():shrink(2)
			info_rect.x = portrait_rect.x + portrait_rect.width
			info_rect.width = info_rect.width - portrait_rect.width
			info_rect.height = info_rect.height / 2

			if ut.text_button(
				tostring(warband_utils.base_unit_price) .. MONEY_SYMBOL,
				info_rect,
				"Cost: " .. tostring(warband_utils.base_unit_price),
				SAVINGS(player) > warband_utils.base_unit_price
			) then
				demography_effects.employ_pop(worker, building)
				economy_effects.gift_to_pop(
					player,
					unemployed_pops[index],
					warband_utils.base_unit_price
				)
			end

			info_rect.y = info_rect.y + info_rect.height
			pui.render_job_efficiency(info_rect, worker, DATA.production_method_get_job_type(method))
			index = index + 1
		end
	end
end