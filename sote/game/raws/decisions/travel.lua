local tabb = require "engine.table"

local Decision = require "game.raws.decisions"

local economy_values = require "game.raws.values.economy"

local economy_effects = require "game.raws.effects.economy"
local travel_effects = require "game.raws.effects.travel"
local military_effects = require "game.raws.effects.military"

local economy_triggers = require "game.raws.triggers.economy"



local function load()
	Decision.Character:new {
		name = 'raid-settlement',
		ui_name = "Raid settlement",
		tooltip = function(root, primary_target)
			if BUSY(root) then
				return "You are too busy to consider it."
			end
			if LEADER_OF_WARBAND(root) == INVALID_ID then
				return "You have to be a leader of a party to raid settlements on your own."
			end
			return "Raid settlement"
		end,
		sorting = 2,
		primary_target = 'none',
		secondary_target = 'none',
		base_probability = 1 / 30,
		pretrigger = function(root)
			if BUSY(root) then return false end
			if LEADER_OF_WARBAND(root) == INVALID_ID then
				return false
			end
			return true
		end,
		clickable = function(root, primary_target)
			if PROVINCE(root) ~= INVALID_ID then
				return false
			end
			local party = LEADER_OF_WARBAND(root)
			if party == INVALID_ID then
				return false
			end
			if WARBAND_TILE(party) ~= DATA.province_get_center(TILE_PROVINCE(WARBAND_TILE(party))) then
				return false
			end
			if PROVINCE_REALM(TILE_PROVINCE(WARBAND_TILE(party))) == INVALID_ID then
				return false
			end
			return true
		end,
		available = function(root, primary_target, secondary_target)
			return true
		end,
		ai_will_do = function(root, primary_target, secondary_target)
			if PROVINCE_REALM(LOCAL_PROVINCE(root)) == REALM(root) then
				return 0
			end
			if not HAS_TRAIT(root, TRAIT.WARLIKE) then
				return 0
			end
			return 0.5
		end,
		effect = function(root, primary_target, secondary_target)
			military_effects.raid(root, false)
		end
	}

	Decision.Character:new {
		name = 'enter-settlement',
		ui_name = "Enter settlement",
		tooltip = function(root, primary_target)
			if BUSY(root) then
				return "You are too busy to consider it."
			end
			if LEADER_OF_WARBAND(root) == INVALID_ID then
				return "You have to be a leader of a party to enter settlements on your own."
			end
			return "Enter settlement and settle down for a while"
		end,
		sorting = 2,
		primary_target = 'none',
		secondary_target = 'none',
		base_probability = 1 / 30,
		pretrigger = function(root)
			if BUSY(root) then return false end
			if LEADER_OF_WARBAND(root) == INVALID_ID then
				return false
			end
			return true
		end,
		clickable = function(root, primary_target)
			if PROVINCE(root) ~= INVALID_ID then
				return false
			end
			local party = LEADER_OF_WARBAND(root)
			if party == INVALID_ID then
				return false
			end
			if WARBAND_TILE(party) ~= DATA.province_get_center(TILE_PROVINCE(WARBAND_TILE(party))) then
				return false
			end
			if PROVINCE_REALM(TILE_PROVINCE(WARBAND_TILE(party))) == INVALID_ID then
				return false
			end
			return true
		end,
		available = function(root, primary_target, secondary_target)
			return true
		end,
		ai_will_do = function(root, primary_target, secondary_target)
			--- raiding AI doesn't enter settlements
			local ai_state = DATA.pop_get_ai_data(root)
			if (ai_state == nil) then
				return 0
			end
			if ai_state.current_goal == AI_GOAL.RAID then
				return 0
			end
			if ai_state.target_province == LOCAL_PROVINCE(root) then
				return 1
			end
			return 0.5
		end,
		effect = function(root, primary_target, secondary_target)
			travel_effects.enter_settlement(root)
		end
	}

	Decision.Character:new {
		name = 'exit-settlement',
		ui_name = "Exit settlement",
		tooltip = function(root, primary_target)
			if BUSY(root) then
				return "You are too busy to consider it."
			end
			if LEADER_OF_WARBAND(root) == INVALID_ID then
				return "You have to be a leader of a party to travel on your own."
			end

			return "Exit settlement and start your travel"
		end,
		sorting = 2,
		primary_target = 'none',
		secondary_target = 'none',
		base_probability = 1 / 30,
		pretrigger = function(root)
			if BUSY(root) then return false end

			if LEADER_OF_WARBAND(root) == INVALID_ID then
				return false
			end

			return true
		end,
		clickable = function(root, primary_target)
			if PROVINCE(root) == INVALID_ID then
				return false
			end
			return true
		end,
		available = function(root, primary_target, secondary_target)
			return true
		end,
		ai_will_do = function(root, primary_target, secondary_target)
			local ai_state = DATA.pop_get_ai_data(root)
			if (ai_state == nil) then
				return 0
			end
			if ai_state.target_province == LOCAL_PROVINCE(root) then
				return 0
			end
			if ai_state.current_goal ==	AI_GOAL.IDLE then
				return 0
			end
			return 1
		end,
		effect = function(root, primary_target, secondary_target)
			travel_effects.exit_settlement(root)
		end
	}

	Decision.Character:new {
		name = 'explore-province',
		ui_name = "Explore local province",
		tooltip = function(root, primary_target)
			if BUSY(root) then
				return "You are too busy to consider it."
			end
			if LEADER_OF_WARBAND(root) == INVALID_ID then
				return "You have to be a leader of a party to explore."
			end
			return "Explore province"
		end,
		sorting = 2,
		primary_target = 'none',
		secondary_target = 'none',
		base_probability = 0.5,
		pretrigger = function(root)
			if BUSY(root) then return false end

			if LEADER_OF_WARBAND(root) == INVALID_ID then
				return false
			end

			local potential_to_explore = false

			DATA.for_each_province_neighborhood_from_origin(PROVINCE(root), function (item)
				local neighbor = DATA.province_neighborhood_get_target(item)
				if DATA.realm_get_known_provinces(REALM(root))[neighbor] == nil then
					potential_to_explore = true
				end
			end)

			return potential_to_explore
		end,
		clickable = function(root, primary_target)
			return true
		end,
		available = function(root, primary_target, secondary_target)
			return true
		end,
		ai_will_do = function(root, primary_target, secondary_target)
			local reward = DATA.realm_get_quests_explore(REALM(root))[PROVINCE(root)] or 0

			if HAS_TRAIT(root, TRAIT.TRADER) then
				return 1 / 36 + reward / 40 -- explore sometimes
			end
			return 0
		end,
		effect = function(root, primary_target, secondary_target)
			SET_BUSY(root)

			if WORLD.player_character ~= root then
				WORLD:emit_immediate_event("exploration-preparation", root, PROVINCE(root))
			elseif OPTIONS["exploration"] == 0 then
				WORLD:emit_immediate_event("exploration-preparation", root, PROVINCE(root))
			elseif OPTIONS["exploration"] == 1 then
				WORLD:emit_immediate_action("exploration-preparation-by-yourself", root, PROVINCE(root))
			elseif OPTIONS["exploration"] == 2 then
				WORLD:emit_immediate_action("exploration-preparation-ask-for-help", root, PROVINCE(root))
			end
		end
	}

	Decision.Character:new {
		name = 'ai-party-forage',
		ui_name = "(AI) Set party to forage stance",
		tooltip = function(root, primary_target)
			if LEADER_OF_WARBAND(root) == INVALID_ID then
				return "You are not leading any party"
			end
			if BUSY(root) then
				return "You are too busy to consider it."
			end
			return "Explore province"
		end,
		sorting = 2,
		primary_target = 'none',
		secondary_target = 'none',
		base_probability = 0.2,
		pretrigger = function(root)
			if LEADER_OF_WARBAND(root) == INVALID_ID then
				return false
			end

			if WORLD:is_player(root) then
				if OPTIONS.debug_mode then
					return true
				else
					return false
				end
			end

			return true
		end,
		clickable = function(root, primary_target)
			if WORLD:is_player(root) then
				if OPTIONS.debug_mode then
					return true
				else
					return false
				end
			end
			return true
		end,
		available = function(root, primary_target, secondary_target)
			return true
		end,
		ai_will_do = function(root, primary_target, secondary_target)
			if LEADER_OF_WARBAND(root) ~= INVALID_ID then
				if economy_values.days_of_travel(LEADER_OF_WARBAND(root)) < 15 then
					return 1
				end
			end

			return 0
		end,
		effect = function(root, primary_target, secondary_target)
			DATA.warband_set_idle_stance(LEADER_OF_WARBAND(root), WARBAND_STANCE.FORAGE)
		end
	}


	Decision.Character:new {
		name = 'ai-party-supplies',
		ui_name = "(AI) Buy supplies",
		tooltip = function(root, primary_target)
			if LEADER_OF_WARBAND(root) == INVALID_ID then
				return "You are not leading any party"
			end
			if BUSY(root) then
				return "You are too busy to consider it."
			end
			return "Explore province"
		end,
		sorting = 2,
		primary_target = 'none',
		secondary_target = 'none',
		base_probability = 1,
		pretrigger = function(root)
			if LEADER_OF_WARBAND(root) == INVALID_ID then
				return false
			end
			if WORLD:is_player(root) then
				if OPTIONS.debug_mode then
					return true
				else
					return false
				end
			end

			if not economy_triggers.can_buy_use(PROVINCE(root), SAVINGS(root), CALORIES_USE_CASE, 1) then
				return false
			end

			if (economy_values.days_of_travel(LEADER_OF_WARBAND(root)) > 30) then
				return false
			end

			return true
		end,
		clickable = function(root, primary_target)
			if WORLD:is_player(root) then
				if OPTIONS.debug_mode then
					return true
				else
					return false
				end
			end
			return true
		end,
		available = function(root, primary_target, secondary_target)
			return true
		end,
		ai_will_do = function(root, primary_target, secondary_target)
			return 1
		end,
		effect = function(root, primary_target, secondary_target)
			economy_effects.character_buy_use(root, CALORIES_USE_CASE, 1)
			DATA.warband_set_idle_stance(LEADER_OF_WARBAND(root), WARBAND_STANCE.FORAGE)
		end
	}

	Decision.Character:new {
		name = 'ai-party-work',
		ui_name = "(AI) Set party to work stance",
		tooltip = function(root, primary_target)
			if LEADER_OF_WARBAND(root) == INVALID_ID then
				return "You are not leading any party"
			end
			if BUSY(root) then
				return "You are too busy to consider it."
			end
			return "Explore province"
		end,
		sorting = 2,
		primary_target = 'none',
		secondary_target = 'none',
		base_probability = 0.2,
		pretrigger = function(root)
			if LEADER_OF_WARBAND(root) == INVALID_ID then
				return false
			end

			if WORLD:is_player(root) then
				if OPTIONS.debug_mode then
					return true
				else
					return false
				end
			end

			return true
		end,
		clickable = function(root, primary_target)
			if WORLD:is_player(root) then
				if OPTIONS.debug_mode then
					return true
				else
					return false
				end
			end
			return true
		end,
		available = function(root, primary_target, secondary_target)
			return true
		end,
		ai_will_do = function(root, primary_target, secondary_target)
			if RECRUITER_OF_WARBAND(root) ~= INVALID_ID then
				return 1
			end

			if LEADER_OF_WARBAND(root) ~= INVALID_ID then
				if economy_values.days_of_travel(LEADER_OF_WARBAND(root)) > 50 then
					return 1
				end
			end

			return 0
		end,
		effect = function(root, primary_target, secondary_target)
			DATA.warband_set_idle_stance(LEADER_OF_WARBAND(root), WARBAND_STANCE.WORK)
		end
	}
end


return load
