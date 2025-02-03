local Decision = require "game.raws.decisions"
local utils = require "game.raws.raws-utils"

local warband_utils = require "game.entities.warband"

local function load()

	---@type DecisionCharacter
	Decision.Character:new {
		name = 'take-up-command-warband',
		ui_name = "Take command of my warband",
		tooltip = function(root, primary_target)
			local candidate_warband = RECRUITER_OF_WARBAND(root)
			if
				candidate_warband ~= INVALID_ID
				and WARBAND_LEADER(candidate_warband) ~= INVALID_ID
				and root ~= WARBAND_LEADER(candidate_warband)
			then
				return "Since I am not the leader, I must seek permission to take up command of this warband."
			end
			return "I have decided take up command of my warband."
		end,
		sorting = 1,
		primary_target = "none",
		secondary_target = 'none',
		base_probability = 1 / 12 , -- Once every year on average
		pretrigger = function(root)
			if BUSY(root) then return false end
			if RECRUITER_OF_WARBAND(root) == INVALID_ID and LEADER_OF_WARBAND(root) == INVALID_ID then return false end
			if UNIT_OF(root) ~= INVALID_ID then return false end
			return true
		end,
		clickable = function(root, primary_target)
			if
				(RECRUITER_OF_WARBAND(root) == INVALID_ID and LEADER_OF_WARBAND(root) == INVALID_ID)
				or UNIT_OF(root) ~= INVALID_ID
			then
				return false
			end
			return true
		end,
		available = function(root, primary_target)
			local candidate_warband = RECRUITER_OF_WARBAND(root)
			if
				candidate_warband ~= INVALID_ID
				and WARBAND_LEADER(candidate_warband) ~= INVALID_ID
				and root ~= WARBAND_LEADER(candidate_warband)
			then
				return false
			end
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
			-- for right now, one or the other
			local warband = LEADER_OF_WARBAND(root)
			if warband == INVALID_ID then
				warband = RECRUITER_OF_WARBAND(root)
			end
			warband_utils.set_commander(warband, root, UNIT_TYPE.WARRIOR)
		end
	}

	---@type DecisionCharacter
	Decision.Character:new {
		name = 'give-up-command-warband',
		ui_name = "Give up commanding my warband",
		tooltip = utils.constant_string("I have decided give up command of my warband."),
		sorting = 1,
		primary_target = "none",
		secondary_target = 'none',
		base_probability = 1 / 12 , -- Once every year on average
		pretrigger = function(root)
			if BUSY(root) then return false end
			if UNIT_OF(root) == INVALID_ID then return false end
			if root ~= WARBAND_COMMANDER(UNIT_OF(root)) then return false end
			return true
		end,
		clickable = function(root, primary_target)
			if UNIT_OF(root) == INVALID_ID then return false end
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
			-- commander is always a unit
			warband_utils.unset_commander(UNIT_OF(root))
		end
	}
end

return load
