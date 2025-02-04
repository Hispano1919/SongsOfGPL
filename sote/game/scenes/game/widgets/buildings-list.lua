local ut = require "game.ui-utils"
local ui = require "engine.ui"
local buildings_utils = require "game.entities.building".Building
local economy_values = require "game.raws.values.economy"

---draws a list of local estates
---@param gam GameScene
---@param rect Rect
---@param estate estate_id
return function (gam, rect, estate)
	local columns = 6
	local width = rect.width / columns
	local height = math.max(width / 2, rect.height / 10)

	local item_rect = rect:copy()
	item_rect.width = width
	item_rect.height = height

	local current_row = 0
	local current_column = 0

	DATA.for_each_building_estate_from_estate(estate, function (item)
		local building = DATA.building_estate_get_building(item)
		item_rect.x = rect.x + current_column * item_rect.width
		item_rect.y = rect.y + current_row * item_rect.height

		current_column = current_column + 1
		if current_column >= columns then
			current_column = 0
			current_row = current_row + 1
		end

		local icon_rect = item_rect:subrect(0, 0, item_rect.width / 2, item_rect.height, "left", "up")

		local building_type = DATA.building_get_current_type(building)
		local icon_tag = DATA.building_type_get_icon(building_type)

		local icon = ASSETS.icons[icon_tag]
		if ut.icon_button(icon, icon_rect, DATA.building_type_get_description(building_type), nil, gam.selected.building == building) then
			gam.selected.building = building
		end

		icon_rect.x = icon_rect.x + icon_rect.width

		if economy_values.amount_of_workers(building) < 1 then
			ui.text("0/1", icon_rect, "center", "center")
		else
			ui.text("1/1", icon_rect, "center", "center")
		end
	end)
end