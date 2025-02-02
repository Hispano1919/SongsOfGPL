local Event = require "game.raws.events"
local warband_utils = require "game.entities.warband"

local function load()

    Event:new {
        name = "pick-commander-unit",
        automatic = false,
        event_background_path = "data/gfx/backgrounds/background.png",
        base_probability = 0,

        fallback = function (self, associated_data)
            return
        end,

        ---@param root Character
        ---@param associated_data Warband
        options = function(self, root, associated_data)
            local options_list = {}

            ---@type EventOption
            local option = {
                text = "Accept",
                tooltip = "You take command",
                viable = function() return true end,
                outcome = function()
                    warband_utils.set_commander(associated_data, root, UNIT_TYPE.WARRIOR)
                end,
                ai_preference = function()
                    return 1
                end
            }
            table.insert(options_list, option)

            local nothing_option = {
                text = "Cancel",
                tooltip = "Nothing happens",
                viable = function() return true end,
                outcome = function() end,
                ai_preference = function()
                    return 0
                end
            }
            table.insert(options_list, nothing_option)

            ---#logging LOGS:write("pick-commander-unit there are " .. tostring(#options_list) .. " options\n")
            ---#logging LOGS:flush()

            return options_list
        end
    }
end

return load
