local utils = require "game.raws.raws-utils"
local Decision = require "game.raws.decisions"

local military_effects = require "game.raws.effects.military"
local economic_effects = require "game.raws.effects.economy"

local demography_effects = require "game.raws.effects.demography"

local pretriggers = require "game.raws.triggers.tooltiped_triggers".Pretrigger


return function ()
	local base_gift_size = 20

	Decision.CharacterSelf:new_from_trigger_lists(
		'gather-party',
		"Gather a party",
		function(root)
			return "Gather my own party?"
		end,
		1/12,
		{
			pretriggers.not_busy, pretriggers.not_dependent, pretriggers.not_in_party,
			pretriggers.not_in_party
		},
		{
			pretriggers.not_in_party
		},
		function(root)
			military_effects.gather_warband(root)
		end,
		function(root)
			root = root
			if LEADER_OF_WARBAND(root) == INVALID_ID and HAS_TRAIT(root, TRAIT.WARLIKE) then
				return 1
			end

			if LEADER_OF_WARBAND(root) == INVALID_ID and HAS_TRAIT(root, TRAIT.TRADER) then
				return 1
			end

			if LEADER_OF_WARBAND(root) == INVALID_ID and RANK(root) == CHARACTER_RANK.CHIEF then
				return 1
			end

			return 0
		end
	)

	Decision.CharacterSelf:new_from_trigger_lists(
		'disband-party',
		"Disband my party",
		function(root)
			return "Disband my party?"
		end,
		0,
		{
			pretriggers.not_busy, pretriggers.leading_idle_party,
			pretriggers.leading_party
		},
		{
			pretriggers.leading_party
		},
		function(root)
			military_effects.dissolve_warband(root)
		end,
		function(root)
			return 0 -- AI never disbands
		end
	)

	Decision.CharacterSelf:new_from_trigger_lists(
		'leave-party',
		"Leave my current party",
		function(root)
			return "Leave " .. WARBAND_NAME(UNIT_OF(root)) .."?"
		end,
		1/12,
		{
			pretriggers.not_busy, pretriggers.not_dependent,
			pretriggers.is_in_party, pretriggers.not_leading_party
		},
		{
			pretriggers.is_in_party,pretriggers.not_leading_party
		},
		function(root)
			local warband = UNIT_OF(root)
			demography_effects.unrecruit(root)
			if WORLD:does_player_see_province_news(TILE_PROVINCE(WARBAND_TILE(warband))) then
				WORLD:emit_notification(NAME(root) .. " quit " .. DATA.warband_get_name(warband) .. ".")
			end
		end,
		function(root)
			-- follower only want to leave if in a settlement
			local province = PROVINCE(root)
			if UNIT_TYPE_OF(root) == UNIT_TYPE.FOLLOWER and province ~= INVALID_ID then
				-- TODO get AI target province and leave if there?
				if province == HOME(root) then
					return 1
				end
			end
			return 0 -- AI only leaves with a reason
		end
	)

	Decision.CharacterSelf:new_from_trigger_lists(
		'change-unit-warrior',
		"Become a warrior in my party",
		function(root)
			return "Fight for " .. WARBAND_NAME(UNIT_OF(root))
		end,
		1/24,
		{
			pretriggers.not_busy, pretriggers.not_party_warrior,
			pretriggers.is_in_party, pretriggers.not_party_follower
		},
		{
			pretriggers.is_in_party, pretriggers.not_party_follower
		},
		function(root)
			local warband = UNIT_OF(root)
			demography_effects.recruit(root, warband, UNIT_TYPE.WARRIOR)
		end,
		function(root)
			if HAS_TRAIT(root, TRAIT.WARLIKE)
				or HAS_TRAIT(root, TRAIT.AMBITIOUS)
				or HAS_TRAIT(root, TRAIT.HARDWORKER)
			then
				return 1
			end
			if HAS_TRAIT(root, TRAIT.CONTENT)
				or HAS_TRAIT(root, TRAIT.LAZY)
			then
				return 0
			end
			return 0.5
		end
	)

	Decision.CharacterSelf:new_from_trigger_lists(
		'change-unit-civilian',
		"Become a civilian in my party",
		function(root)
			return "Stop fighting with " .. WARBAND_NAME(UNIT_OF(root))
		end,
		1/24,
		{
			pretriggers.not_busy, pretriggers.not_party_civilian,
			pretriggers.is_in_party, pretriggers.not_party_follower
		},
		{
			pretriggers.is_in_party, pretriggers.not_party_follower
		},
		function(root)
			local warband = UNIT_OF(root)
			demography_effects.recruit(root, warband, UNIT_TYPE.CIVILIAN)
		end,
		function(root)
			if HAS_TRAIT(root, TRAIT.WARLIKE)
				or HAS_TRAIT(root, TRAIT.AMBITIOUS)
				or HAS_TRAIT(root, TRAIT.HARDWORKER)
			then
				return 1
			end
			if HAS_TRAIT(root, TRAIT.CONTENT)
				or HAS_TRAIT(root, TRAIT.LAZY)
			then
				return 0
			end
			return 0.5
		end
	)

		---@type DecisionCharacter
	Decision.Character:new {
		name = 'donate-wealth-warband',
		ui_name = "Donate wealth to your warband.",
		tooltip = utils.constant_string("Donate wealth (" .. tostring(base_gift_size) .. ") to your warband treasury."),
		sorting = 1,
		primary_target = "none",
		secondary_target = 'none',
		base_probability = 1 / 3 , -- Once every 3 months on average
		pretrigger = function(root)
			if BUSY(root) then return false end
			if SAVINGS(root) < base_gift_size then
				return false
			end
			if LEADER_OF_WARBAND(root) == INVALID_ID then return false end
			return true
		end,
		clickable = function(root, primary_target)
			if LEADER_OF_WARBAND(root) == INVALID_ID then return false end
			if WORLD:is_player(root) then return false end
			return true
		end,
		available = function(root, primary_target)
			if SAVINGS(root) < 5 then
				return false
			end
			return true
		end,
		ai_secondary_target = function(root, primary_target)
			return nil, true
		end,
		ai_will_do = function(root, primary_target, secondary_target)
			if DATA.warband_get_treasury(LEADER_OF_WARBAND(root)) < SAVINGS(root) / 2 then
				return 1
			end

			return 0
		end,
		effect = function(root, primary_target, secondary_target)
			economic_effects.gift_to_warband(LEADER_OF_WARBAND(root), root, SAVINGS(root) / 3)
		end
	}
end