local strings = require "engine.string"
local ui = require "engine.ui"
local ut = require "game.ui-utils"

local state = {
	header_height = UI_STYLE.table_header_height,
	individual_height = UI_STYLE.scrollable_list_small_item_height,
	slider_level = 0,
	slider_width = UI_STYLE.slider_width,
	sorted_field = 1,
	sorting_order = true
}

---@param rect Rect
---@param estate estate_id
return function(rect, estate)
	-- we assume that this window could be accessed only by a character

	---@type pop_id
	local player = WORLD.player_character

	if player == INVALID_ID then
		return
	end

    ---@type EstateInventoryEntry[]
    local inventory = {}

    DATA.for_each_trade_good(function (item)
        ---@type EstateInventoryEntry
        local inventory_item = {
            id = item,
            price = DATA.province_get_local_prices(ESTATE_PROVINCE(estate), item),
            amount = DATA.estate_get_inventory(estate, item),
            sold = DATA.estate_get_inventory_sold_last_tick(estate, item),
            bought = DATA.estate_get_inventory_bought_last_tick(estate, item),
            demanded = DATA.estate_get_inventory_demanded_last_tick(estate, item)
        }

        table.insert(inventory, inventory_item)
    end)

	---@type TableColumn<EstateInventoryEntry>[]
	local columns = {
		{
			header = ".",
			---commenting
			---@param rect Rect
			---@param _ any
			---@param v EstateInventoryEntry
			render_closure = function(rect, _, v)
				ut.render_icon(rect,
					DATA.trade_good_get_icon(v.id),
					DATA.trade_good_get_r(v.id),
					DATA.trade_good_get_g(v.id),
					DATA.trade_good_get_b(v.id),
					1, true)
				ui.tooltip(strings.title(DATA.trade_good_get_name(v.id)),rect)
			end,
			width = 1,
			---@param v EstateInventoryEntry
			value = function(k, v)
				return k
			end
		},
		{
			header = "price",
			---@param v EstateInventoryEntry
			render_closure = function (rect, _, v)
				ut.generic_number_field(
					"",
					v.price,
					rect,
					nil,
					ut.NUMBER_MODE.MONEY,
					ut.NAME_MODE.NAME,
					true)
			end,
			width = 2,
			---@param v EstateInventoryEntry
			value = function(k, v)
				return v.price
			end
		},
		{
			header = "amount",
			---@param v EstateInventoryEntry
			render_closure = function (rect, _, v)
				ut.generic_number_field(
					"",
					v.amount,
					rect,
					ut.to_fixed_point2(v.amount) .. " " .. DATA.trade_good_get_name(v.id) .. " in inventory.",
					ut.NUMBER_MODE.NUMBER,
					ut.NAME_MODE.NAME,
					true)
			end,
			width = 2,
			---@param v EstateInventoryEntry
			value = function(k, v)
				return v.amount
			end
		},
		{
			header = "your",
			---@param v EstateInventoryEntry
			render_closure = function (rect, _, v)
				ut.generic_number_field(
					"",
					INVENTORY(player, v.id),
					rect,
					ut.to_fixed_point2(INVENTORY(player, v.id)) .. " " .. DATA.trade_good_get_name(v.id) .. " in your inventory.",
					ut.NUMBER_MODE.NUMBER,
					ut.NAME_MODE.NAME,
					true)
			end,
			width = 2,
			---@param v EstateInventoryEntry
			value = function(k, v)
				return INVENTORY(player, v.id)
			end
		},
		{
			header = ".",
			---@param v EstateInventoryEntry
			render_closure = function (rect, _, v)
				if ut.text_button("->e", rect, "Move a unit of goods to the estate inventory") then
					local amount = math.min(1, INVENTORY(player, v.id))
					DATA.pop_set_inventory(player, v.id, math.max(0, DATA.pop_get_inventory(player, v.id) - amount))
					DATA.estate_set_inventory(estate, v.id, DATA.estate_get_inventory(estate, v.id) + amount)
				end
			end,
			width = 2,
			---@param v EstateInventoryEntry
			value = function(k, v)
				return INVENTORY(player, v.id)
			end,
			active = true
		},
		{
			header = ".",
			---@param v EstateInventoryEntry
			render_closure = function (rect, _, v)
				if ut.text_button("e->", rect, "Move a unit of goods to your inventory") then
					local amount = math.min(1, DATA.estate_get_inventory(estate, v.id))
					DATA.pop_set_inventory(player, v.id, DATA.pop_get_inventory(player, v.id) + amount)
					DATA.estate_set_inventory(estate, v.id, math.max(0,DATA.estate_get_inventory(estate, v.id) - amount))
				end
			end,
			width = 2,
			---@param v EstateInventoryEntry
			value = function(k, v)
				return INVENTORY(player, v.id)
			end,
			active = true
		},
		{
			header = "bought",
			---@param v EstateInventoryEntry
			render_closure = function (rect, _, v)
				ut.generic_number_field(
					"",
					v.bought,
					rect,
					nil,
					ut.NUMBER_MODE.NUMBER,
					ut.NAME_MODE.NAME,
					true)
			end,
			width = 2,
			---@param v EstateInventoryEntry
			value = function(k, v)
				return v.bought
			end
		},
		{
			header = "demanded",
			---@param v EstateInventoryEntry
			render_closure = function (rect, _, v)
				ut.generic_number_field(
					"",
					v.demanded,
					rect,
					nil,
					ut.NUMBER_MODE.NUMBER,
					ut.NAME_MODE.NAME,
					true)
			end,
			width = 2,
			---@param v EstateInventoryEntry
			value = function(k, v)
				return v.bought
			end
		},
		{
			header = "sold",
			---@param v EstateInventoryEntry
			render_closure = function (rect, _, v)
				ut.generic_number_field(
					"",
					v.sold,
					rect,
					nil,
					ut.NUMBER_MODE.NUMBER,
					ut.NAME_MODE.NAME,
					true)
			end,
			width = 2,
			---@param v EstateInventoryEntry
			value = function(k, v)
				return v.sold
			end
		}
	}

	local bottom_height = rect.height
	local bottom_y = 0
	local bottom = rect:subrect(0, bottom_y, rect.width, bottom_height, "left", "up")
	ut.table(bottom, inventory, columns, state)
end