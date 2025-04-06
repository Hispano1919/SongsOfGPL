local ut = require "game.ui-utils"
local economy_effects = require "game.raws.effects.economy"

---@param rect Rect
---@param estate estate_id
return function (rect, estate)
	local owner = OWNER(estate)
	local base_unit = rect.height

	local dec_rect = rect:subrect(0, 0, base_unit, base_unit, "left", "up")
	local inc_rect = rect:subrect(0, 0, base_unit, base_unit, "right", "up")

	if ut.icon_button(
		ASSETS.icons["minus.png"], dec_rect,
		"Take " .. ut.to_fixed_point2(KEY_PRESS_MODIFIER) .. MONEY_SYMBOL .. " out of your local estate treasury."
		.. "\nPress Ctrl and/or Shift to modify amount.", WORLD.player_character == OWNER(estate)
	) then
		local amount_to_transfer = KEY_PRESS_MODIFIER
		if amount_to_transfer > DATA.estate_get_savings(estate) then
			amount_to_transfer = DATA.estate_get_savings(estate)
		end
		economy_effects.add_pop_savings(owner, amount_to_transfer, ECONOMY_REASON.BUILDING)
		DATA.estate_inc_savings(estate, -amount_to_transfer)
	end
	if ut.icon_button(ASSETS.icons["plus.png"], inc_rect,
		"Invest " .. ut.to_fixed_point2(-KEY_PRESS_MODIFIER) .. MONEY_SYMBOL .. " into your local estate treasury."
		.. "\nPress Ctrl and/or Shift to modify amount.", WORLD.player_character == OWNER(estate)
	) then
		local amount_to_transfer = KEY_PRESS_MODIFIER
		if amount_to_transfer > SAVINGS(owner) then
			amount_to_transfer = SAVINGS(owner)
		end
		economy_effects.add_pop_savings(owner, -amount_to_transfer, ECONOMY_REASON.BUILDING)
		DATA.estate_inc_savings(estate, amount_to_transfer)
	end

	ut.money_entry_icon(DATA.estate_get_savings(estate), rect:subrect(base_unit, 0, rect.width - 2 * base_unit, base_unit, "left", "up"), "Your local estates treasury")
end