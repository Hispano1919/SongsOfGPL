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
---@param table POP[]
---@param state TableState?
---@param title string?
---@param compact boolean?
return function(game, rect, table, state, title, compact)
    if compact == nil then
        compact = false
    end

    return function()
        ---@type TableColumn<pop_id>[]
        local columns = {
            {
                header = "rlm",
                render_closure = function(rect, k, v)
                    local realm_id = REALM(v)
                    ib.icon_button_to_realm(game,realm_id,rect,NAME(v) .. " is a "
                        .. require "game.raws.ranks.localisation"(v) .. " of " .. REALM_NAME(realm_id) .. ".")
                end,
                width = 1,
                value = function(k, v)
                    return REALM_NAME(REALM(v))
                end
            },
            {
                header = ".",
                render_closure = function(rect, k, v)
                    ib.icon_button_to_character(game, v, rect, pui.pop_tooltip(v))
                end,
                width = 1,
                value = function(k, v)
                    return RANK(v)
                end
            },
            {
                header = "name",
                render_closure = function(rect, k, v)
                    ui.text(NAME(v), rect)
                end,
                width = 4,
                value = function(k, v)
                    ---@type POP
                    v = v
                    return NAME(v)
                end,
                active = true
            },
            {
                header = "sex",
                render_closure = function (rect, k, v)
                    pui.render_female_icon(rect,v)
                end,
                width = 1,
                value = function(k, v)
                    return DATA.pop_get_female(v) and "f" or "m"
                end
            },
            {
                header = "age",
                render_closure = function (rect, k, v)
                    pui.render_age(rect,v)
                end,
                width = 2,
                value = function(k, v)
                    return DATA.pop_get_age(v)
                end
            },
            {
                header = "r",
                render_closure = function (rect, k, v)
                    local race_id = RACE(v)
                    ui.render_race_icon(rect,race_id,ui.race_tooltip(race_id))
                end,
                width = 1,
                value = function(k, v)
                    return DATA.race_get_name(RACE(v))
                end
            },
            {
                header = "c",
                render_closure = function (rect, k, v)
                    local culture_id = CULTURE(v)
                    ui.render_culture_icon(rect,culture_id,ui.culture_tooltip(culture_id))
                end,
                width = 1,
                value = function(k, v)
                    return DATA.culture_get_name(CULTURE(v))
                end
            },
            {
                header = "f",
                render_closure = function (rect, k, v)
                    local faith_id = DATA.pop_get_faith(v)
                    ui.render_faith_icon(rect,faith_id,ui.faith_tooltip(faith_id))
                end,
                width = 1,
                value = function(k, v)
                    return DATA.faith_get_name(DATA.pop_get_faith(v))
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