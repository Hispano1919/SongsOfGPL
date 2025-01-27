local uit = require "game.ui-utils"
local Event = require "game.raws.events"
local AiPreferences = require "game.raws.values.ai"

local pop_utils = require "game.entities.pop".POP
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
            ---#logging LOGS:write("pick-commander-unit " .. tostring(root) .. " " .. tostring(province).. "\n")
            ---#logging LOGS:flush()

            ---#logging LOGS:write("pick-commander-unit retrieve unlocked units\n")
            ---#logging LOGS:flush()
            -- get all unit types

            ---#logging LOGS:write("pick-commander-unit generate options\n")
            ---#logging LOGS:flush()
            local health, attack, armor, speed = pop_utils.get_strength(root)
            local spotting = pop_utils.get_spotting(root)
            local visibility = pop_utils.get_visibility(root)
            local supply = pop_utils.get_supply_use(root)
            local capacity = pop_utils.get_supply_capacity(root)

            ---@type EventOption
            local option = {
                text = " (" .. uit.to_fixed_point2(warband_utils.base_unit_price) .. MONEY_SYMBOL .. ")",
                tooltip = "Price: " .. uit.to_fixed_point2(warband_utils.base_unit_price) .. MONEY_SYMBOL .. " (" .. uit.to_fixed_point2(warband_utils.upkeep_per_unit) .. MONEY_SYMBOL .. ")\n"
                    .. "Health: " .. uit.to_fixed_point2(health) .. " Attack: " .. uit.to_fixed_point2(attack)
                    .. " Armor: " .. uit.to_fixed_point2(armor) .. " Speed: " .. uit.to_fixed_point2(speed)
                    .. "\nSpotting: " .. uit.to_fixed_point2(spotting) .. " Visibility: " .. uit.to_fixed_point2(visibility)
                    .. " Travel cost: " .. uit.to_fixed_point2(supply) .. " Hauling capacity: " .. uit.to_fixed_point2(capacity),
                viable = function() return true end,
                outcome = function()
                    warband_utils.set_commander(associated_data, root, UNIT_TYPE.WARRIOR)
                end,
                ai_preference = function()
                    -- TODO FIGURE OUT BETTER WEIGHTING THE FOLLOWING IS A PLACEHOLDER
                    local base = health + attack + armor + speed + spotting + visibility + supply + capacity
                    -- greedy characters care more about upkeep cost (payment) and loot capacity
                    if HAS_TRAIT(root, TRAIT.GREEDY) then
                        base = base + capacity * 8 + 12 * warband_utils.upkeep_per_unit * AiPreferences.money_utility(root)
                    end
                    -- aggressive characters care more about combat stats
                    if HAS_TRAIT(root, TRAIT.WARLIKE) then
                        base = base + health + attack + armor
                    end
                    return base
                end
            }
            table.insert(options_list, option)

            local nothing_option = {
                text = "Nothing",
                tooltip = "Nothing",
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
