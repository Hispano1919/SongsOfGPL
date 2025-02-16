local ui = require "engine.ui"
local ut = require "game.ui-utils"

---@enum ESTATE_EXTENDED_TAB
local ESTATE_EXTENDED_TAB = {
	CONSTRUCTION = 1, HIRE = 2, INVENTORY = 3
}

local estate_tab = ESTATE_EXTENDED_TAB.CONSTRUCTION

---@param rect Rect
---@param estate estate_id
return function (rect, estate)
	local unit = ut.BASE_HEIGHT

	local header = rect:copy()
	header.height = unit

	local tab = header:copy()
	tab.width = tab.width / 4

	if ut.text_button("Expand estate", tab, nil, nil, estate_tab == ESTATE_EXTENDED_TAB.CONSTRUCTION) then
		estate_tab = ESTATE_EXTENDED_TAB.CONSTRUCTION
	end
	tab.x = tab.x + tab.width
	if ut.text_button("Hire workers", tab, nil, nil, estate_tab == ESTATE_EXTENDED_TAB.HIRE) then
		estate_tab = ESTATE_EXTENDED_TAB.HIRE
	end
	tab.x = tab.x + tab.width
	if ut.text_button("Inventory", tab, nil, nil, estate_tab == ESTATE_EXTENDED_TAB.INVENTORY) then
		estate_tab = ESTATE_EXTENDED_TAB.INVENTORY
	end
	tab.x = tab.x + tab.width

	require "game.scenes.game.widgets.subsidy" (tab, estate)

	local content = rect:copy()
	content.y = header.y + header.height
	content.height = rect.y + rect.height - content.y

	if estate_tab == ESTATE_EXTENDED_TAB.CONSTRUCTION then
		require "game.scenes.game.widgets.estate-extended-construction" (content, estate)
	end
	if estate_tab == ESTATE_EXTENDED_TAB.HIRE then
		require "game.scenes.game.widgets.estate-extended-hire" (content, estate)
	end
	if estate_tab == ESTATE_EXTENDED_TAB.INVENTORY then
		require "game.scenes.game.widgets.estate-extended-inventory" (content, estate)
	end
end