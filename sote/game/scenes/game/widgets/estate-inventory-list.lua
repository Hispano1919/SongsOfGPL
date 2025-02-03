local strings = require "engine.string"
local ui = require "engine.ui"
local ut = require "game.ui-utils"

---comment
---@param state TableState?
---@param compact boolean
---@return TableState
local function init_state(state, compact)
    local entry_height = UI_STYLE.scrollable_list_item_height
    if compact then
        entry_height = UI_STYLE.scrollable_list_small_item_height
    end

    if state == nil then
        state = {
            header_height = UI_STYLE.table_header_height,
            individual_height = entry_height,
            slider_level = 0,
            slider_width = UI_STYLE.slider_width,
            sorted_field = 1,
            sorting_order = true
        }
    else
        state.header_height = UI_STYLE.table_header_height
        state.individual_height = entry_height
        state.slider_width = UI_STYLE.slider_width
    end
    return state
end

---@class EstateInventoryEntry
---@field id trade_good_id
---@field price number
---@field amount number
---@field sold number
---@field bought number
---@field demanded number

---@param game GameScene
---@param rect Rect
---@param estate estate_id
---@param state TableState?
---@param title string?
---@param compact boolean?
return function(game, rect, estate, state, title, compact)
    if compact == nil then
        compact = false
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

    return function()
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
                header = "bought",
                ---@param v EstateInventoryEntry
                render_closure = function (rect, _, v)
                    ut.generic_number_field(
                        "",
                        v.bought,
                        rect,
                        "Bought " .. ut.to_fixed_point2(v.bought) .. " out of demanded " .. ut.to_fixed_point2(v.demanded),
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
        state = init_state(state, compact)
        local bottom_height = rect.height
        local bottom_y = 0
        if title then
            bottom_height = bottom_height - UI_STYLE.table_header_height
            bottom_y = UI_STYLE.table_header_height
            local top = rect:subrect(0, 0, rect.width, UI_STYLE.table_header_height, "left", "up")
            ui.centered_text(title, top)
        end
        local bottom = rect:subrect(0, bottom_y, rect.width, bottom_height, "left", "up")
        ut.table(bottom, inventory, columns, state)
        return state
    end
end