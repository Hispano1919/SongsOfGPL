local Decision = require "game.raws.decisions"
local utils = require "game.raws.raws-utils"

local demography_effects = require "game.raws.effects.demography"

local function load()

	---@type DecisionCharacter
	Decision.Character:new {
		name = 'become-warrior-in-warband',
		ui_name = "Become warrior in warband",
		tooltip = function(root, primary_target)
			return "I have decided fight with my warband."
		end,
		sorting = 1,
		primary_target = "none",
		secondary_target = 'none',
		base_probability = 1 / 12 , -- Once every year on average
		pretrigger = function(root)
			if BUSY(root) then return false end
			if UNIT_OF(root) == INVALID_ID then return false end
			return true
		end,
		clickable = function(root, primary_target)
			if UNIT_OF(root) == INVALID_ID
				or UNITTYPE_OF(root) == UNIT_TYPE.WARRIOR
			then
				return false
			end
			return true
		end,
		available = function(root, primary_target)
			return true
		end,
		ai_secondary_target = function(root, primary_target)
			return nil, true
		end,
		ai_will_do = function(root, primary_target, secondary_target)
			if
				HAS_TRAIT(root, TRAIT.WARLIKE)
				or HAS_TRAIT(root, TRAIT.AMBITIOUS)
				or HAS_TRAIT(root, TRAIT.HARDWORKER)
			then
				return 1
			end

			if
				HAS_TRAIT(root, TRAIT.CONTENT)
				or HAS_TRAIT(root, TRAIT.LAZY)
			then
				return 0
			end

			return 0.5
		end,
		effect = function(root, primary_target, secondary_target)
			local warband = UNIT_OF(root)
			demography_effects.recruit(root, warband, UNIT_TYPE.WARRIOR)
		end
	}

	---@type DecisionCharacter
	Decision.Character:new {
		name = 'become-civilian-in-warband',
		ui_name = "Become civilian warband",
		tooltip = utils.constant_string("I have decided to no longer fight with my warband."),
		sorting = 1,
		primary_target = "none",
		secondary_target = 'none',
		base_probability = 1 / 12 , -- Once every year on average
		pretrigger = function(root)
			if BUSY(root) then return false end
			if UNIT_OF(root) == INVALID_ID then return false end
			return true
		end,
		clickable = function(root, primary_target)
			if UNIT_OF(root) == INVALID_ID
				or UNITTYPE_OF(root) == UNIT_TYPE.CIVILIAN
			then
				return false
			end
			return true
		end,
		available = function(root, primary_target)
			return true
		end,
		ai_secondary_target = function(root, primary_target)

			return nil, true
		end,
		ai_will_do = function(root, primary_target, secondary_target)
			if HAS_TRAIT(root, TRAIT.WARLIKE) or HAS_TRAIT(root, TRAIT.AMBITIOUS) or HAS_TRAIT(root, TRAIT.HARDWORKER) then
				return 0
			end

			if HAS_TRAIT(root, TRAIT.CONTENT) or HAS_TRAIT(root, TRAIT.LAZY) then
				return 1
			end

			return 0.1
		end,
		effect = function(root, primary_target, secondary_target)
			local warband = UNIT_OF(root)
			demography_effects.recruit(root, warband, UNIT_TYPE.CIVILIAN)
		end
	}

	---@type DecisionCharacter
	Decision.Character:new {
		name = 'leave-warband',
		ui_name = "Leave warband",
		tooltip = function(root, primary_target)
			return "I have decided leave my warband."
		end,
		sorting = 1,
		primary_target = "none",
		secondary_target = 'none',
		base_probability = 1 / 12 , -- Once every year on average
		pretrigger = function(root)
			if BUSY(root) then return false end
			if UNIT_OF(root) == INVALID_ID then return false end
			return true
		end,
		clickable = function(root, primary_target)
			if WARBAND_LEADER(UNIT_OF(root)) == root then
				return false
			end
			return true
		end,
		available = function(root, primary_target)
			if WARBAND_LEADER(UNIT_OF(root)) == root then
				return false
			end
			return true
		end,
		ai_secondary_target = function(root, primary_target)
			return nil, true
		end,
		ai_will_do = function(root, primary_target, secondary_target)
			if HAS_TRAIT(root, TRAIT.WARLIKE) or HAS_TRAIT(root, TRAIT.AMBITIOUS) or HAS_TRAIT(root, TRAIT.HARDWORKER) then
				return 0
			end

			if HAS_TRAIT(root, TRAIT.CONTENT) or HAS_TRAIT(root, TRAIT.LAZY) then
				return 1
			end

			return 0.1
		end,
		effect = function(root, primary_target, secondary_target)
			local warband = UNIT_OF(root)
			demography_effects.unrecruit(root)
			if WORLD:does_player_see_province_news(TILE_PROVINCE(WARBAND_TILE(warband))) then
				WORLD:emit_notification(NAME(root) .. " quit " .. DATA.warband_get_name(warband) .. ".")
			end
		end
	}
end

return load
