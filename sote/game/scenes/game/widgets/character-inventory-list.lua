local tabb = require "engine.table"
local strings = require "engine.string"
local ui = require "engine.ui"
local ut = require "game.ui-utils"
local ib = require "game.scenes.game.widgets.inspector-redirect-buttons"
local pui = require "game.scenes.game.widgets.pop-ui-widgets"
local portrait = require "game.scenes.game.widgets.portrait"

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

---@param rect Rect
---@param table trade_good_id[]
---@param state TableState?
---@param title string?
---@param compact boolean?
return function(game, rect, pop_id, table, state, title, compact)
    if compact == nil then
        compact = false
    end

    return function()
        ---@type TableColumn<trade_good_id>[]
        local columns = {
            {
                header = ".",
                render_closure = function(rect, k, v)
                    ut.render_icon(rect,
                        DATA.trade_good_get_icon(k),
                        DATA.trade_good_get_r(k),
                        DATA.trade_good_get_g(k),
                        DATA.trade_good_get_b(k),
                        1, true)
                    ui.tooltip(strings.title(DATA.trade_good_get_name(k)),rect)
                end,
                width = 1,
                value = function(k, v)
                    return k
                end
            },
            {
                header = "good",
                render_closure = function(rect, k, v)
                    ui.text(strings.title(DATA.trade_good_get_name(k)),rect,"center","center")
                    ui.tooltip(strings.title(DATA.trade_good_get_name(k)),rect)
                end,
                width = 5,
                value = function(k, v)
                    return DATA.trade_good_get_name(k)
                end
            },
            {
                header = "amount",
                render_closure = function (rect, k, v)
                    ut.generic_number_field(
                        "cardboard-box.png",
                        v,
                        rect,
                        ut.to_fixed_point2(v) .. " " .. DATA.trade_good_get_name(k) .. " in inventory.",
                        ut.NUMBER_MODE.BALANCE,
                        ut.NAME_MODE.ICON,
                        true)
                end,
                width = 3,
                value = function(k, v)
                    return v
                end
            },
            {
                header = "price",
                render_closure = function (rect, k, v)
                    ut.generic_number_field(
                        "bank.png",
                        DATA.pop_get_price_memory(pop_id,k),
                        rect,
                        NAME(pop_id) .. " values one unit of " .. DATA.trade_good_get_name(k) .. " at " .. ut.to_fixed_point2(DATA.pop_get_price_memory(pop_id,k)) .. MONEY_SYMBOL .. ".",
                        ut.NUMBER_MODE.MONEY,
                        ut.NAME_MODE.ICON,
                        true)
                end,
                width = 3,
                value = function(k, v)
                    return v
                end
            },
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
        ut.table(bottom, table, columns, state)
        return state
    end
end