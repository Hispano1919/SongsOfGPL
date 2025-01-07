local ut = require "game.ui-utils"

local warband_utils = require "game.entities.warband"

local Event = require "game.raws.events"
local event_utils = require "game.raws.events._utils"
local ge = require "game.raws.effects.generic"

local economy_effects = require "game.raws.effects.economy"
local economy_values = require "game.raws.values.economy"
local et = require "game.raws.triggers.economy"

local retrieve_use_case = require "game.raws.raws-utils".trade_good_use_case

local function load()
    Event:new {
        name = "travel-start-action",
        automatic = false,
        event_background_path = "data/gfx/backgrounds/background.png",
        base_probability = 0,

        fallback = function (self, associated_data)
            return
        end,

        on_trigger = function (self, root, associated_data)
            ---@type TravelData
            associated_data = associated_data
            local party = LEADER_OF_WARBAND(root)
            assert(party ~= INVALID_ID)
            DATA.warband_set_current_status(party, WARBAND_STATUS.TRAVELLING)
            economy_effects.consume_supplies(party, associated_data.travel_time)
            WORLD:emit_action("travel", root, associated_data.destination, associated_data.travel_time, true)
        end
    }

    Event:new {
        name = "travel-start",
        automatic = false,
        event_background_path = "data/gfx/backgrounds/background.png",
        base_probability = 0,

        fallback = function (self, associated_data)
            return
        end,

        event_text = function (self, root, associated_data)
            ---@type TravelData
            associated_data = associated_data

            local action = "travel"
            if associated_data.goal == "migration" then
                action = "migrate"
            end

            local text =
                "We plan to " .. action .. " toward " .. PROVINCE_NAME(associated_data.destination) .. ". " ..
                "We will spend " .. ut.to_fixed_point2(associated_data.travel_time) .. " days. " ..
                "We have enough supplies to travel for " .. ut.to_fixed_point2(economy_values.days_of_travel(LEADER_OF_WARBAND(root))) .. " days."

            return text
        end,

        options = function (self, root, associated_data)
            ---@type TravelData
            associated_data = associated_data

            ---@type EventOption
            local option_proceed = {
                text = "Start the journey.",
                tooltip = "We depart from the province",
                ai_preference = function ()
                    return 1
                end,
                outcome = function ()
                    local party = LEADER_OF_WARBAND(root)
                    assert(party ~= INVALID_ID)
                    DATA.warband_set_current_status(party, WARBAND_STATUS.TRAVELLING)
                    economy_effects.consume_supplies(party, associated_data.travel_time)
                    WORLD:emit_action("travel", root, associated_data.destination, associated_data.travel_time, true)
                end,
                viable =function ()
                    return true
                end
            }

            return {
                option_proceed,
                event_utils.option_stop("I am not ready", "Abandon the journey", 0, root)
            }
        end
    }

    Event:new {
		name = "travel",
		automatic = false,
        base_probability = 0,
        event_background_path = "data/gfx/backgrounds/background.png",

        fallback = function (self, associated_data)
        end,

		on_trigger = function(self, root, associated_data)
			---@type Province
			associated_data = associated_data
            ge.travel(root, associated_data)
            if LEADER_OF_WARBAND(root) ~= INVALID_ID then
                DATA.warband_set_current_status(LEADER_OF_WARBAND(root), WARBAND_STATUS.IDLE)
            end
            UNSET_BUSY(root)
            if root == WORLD.player_character and OPTIONS["travel-end"] == 0 then
                WORLD:emit_immediate_event('travel-end-notification', root, associated_data)
            end

            if root == WORLD.player_character and OPTIONS["travel-end"] == 2 then
                PAUSE_REQUESTED = true
            end
		end,
	}

    event_utils.notification_event(
        "travel-end-notification",
        function (self, root, data)
            ---@type Province
            data = data
            return "I have arrived at " .. PROVINCE_NAME(data) .. ". "
                .. "This land is controlled by people of " .. REALM_NAME(PROVINCE_REALM(data)) .. ". "
                .. F_RACE(LEADER(PROVINCE_REALM(data))).name .. " " .. NAME(LEADER(PROVINCE_REALM(data))) .. " rules over them."
        end,
        function (root, data)
            return "Finally!"
        end,
        function (root, data)
            return "What should I do now?"
        end
    )

end

return load