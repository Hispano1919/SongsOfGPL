local tabb = require "engine.table"
local ui = require "engine.ui"
local uit = require "game.ui-utils"
local ib = require "game.scenes.game.widgets.inspector-redirect-buttons"

local realm_utils = require "game.entities.realm".Realm
local warband_utils = require "game.entities.warband"

local window = {}

local slider_warbands = 0



---@return Rect
local function get_main_panel()
	local fs = ui.fullscreen()
	local panel = fs:subrect(uit.BASE_HEIGHT * 2, 0, uit.BASE_HEIGHT * 16, uit.BASE_HEIGHT * 25, "left", "down")
	return panel
end

function window.mask()
    if ui.trigger(get_main_panel()) then
		return false
	else
		return true
	end
end

---Draw military window
---@param game GameScene
function window.draw(game)
    local player_character = WORLD.player_character

    local realm = PROVINCE_REALM(game.selected.province)
    if realm == INVALID_ID and player_character ~= INVALID_ID then
        realm = LOCAL_REALM(player_character)
    end

    if realm == nil then
        return
    end

    local ui_panel = get_main_panel()
    -- draw a panel
    ui.panel(ui_panel)

    -- display warbands
    -- header
    ui_panel.height = ui_panel.height - uit.BASE_HEIGHT
    ui.text("Warbands", ui_panel, "left", "up")

    if uit.icon_button(ASSETS.icons["cancel.png"], ui_panel:subrect(0, 0, uit.BASE_HEIGHT, uit.BASE_HEIGHT, "right", "up")) then
        game.inspector = nil
    end

    -- substance
    ui_panel.y = ui_panel.y + uit.BASE_HEIGHT
    local warbands = realm_utils.get_warbands(realm)
    slider_warbands = uit.scrollview(ui_panel, function(i, rect)
        if i > 0 then
            local realm_icon_rect = rect:subrect(0, 0, rect.height, rect.height, "left", "up")
            local leader_icon_rect = rect:subrect(rect.height, 0, rect.height, rect.height, "left", "up")
            local warband_icon_rect = rect:subrect(rect.height*2, 0, rect.height, rect.height, "left", "up")
            local warband_name_rect = rect:subrect(rect.height*3, 0, (rect.width-rect.height*3)/2, rect.height, "left", "up")
            local warband_status_rect = rect:subrect(0, 0, (rect.width-rect.height*3)/2, rect.height, "right", "up")

            ---@type Warband
            local warband = warbands[i]
            local leader = require "game.entities.warband".active_leader(warband)
            local warband_realm = warband_utils.realm(warband)

            ib.icon_button_to_realm(game, warband_realm, realm_icon_rect)
            if leader and leader ~= INVALID_ID then
                ib.icon_button_to_character(game, leader, leader_icon_rect)
            else
                ib.icon_button_to_realm(game, warband_realm, leader_icon_rect)
            end
            ib.icon_button_to_warband(game, warband, warband_icon_rect,DATA.warband_get_name(warband))

            ui.centered_text(require "engine.string".title(DATA.warband_get_name(warband)), warband_name_rect)
            ui.centered_text(DATA.warband_status_get_name(DATA.warband_get_current_status(warband)), warband_status_rect)
        end
    end, uit.BASE_HEIGHT, tabb.size(warbands), uit.BASE_HEIGHT, slider_warbands)
end

return window