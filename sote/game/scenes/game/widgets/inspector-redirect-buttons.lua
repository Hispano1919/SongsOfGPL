local ui = require "engine.ui"
local ut = require "game.ui-utils"

local strings = require "engine.string"

local rank_name = require "game.raws.ranks.localisation"

local ib = {}

---checks if player and knows of province
---@param province_id any
---@param player_id any
---@return boolean
function ib.is_visible_to_player(province_id, player_id)
    if player_id ~= INVALID_ID then
        local player_realm = WORLD:player_realm()
        if DATA.realm_get_known_provinces(player_realm)[province_id] then
            return true
        end
        return false
    end
    return true
end

---@param gamescene GameScene
---@param rect Rect
function ib.icon_button_to_close(gamescene, rect)
    if ut.color_icon_button("cancel.png",1,0,0,1,rect) then
        gamescene.inspector = nil
    end
end

---@param gamescene GameScene
---@param realm Realm
---@param rect Rect
---@param tooltip string?
function ib.icon_button_to_realm(gamescene, realm, rect, tooltip)
    local player = WORLD.player_character

    ui.panel(rect:copy():shrink(1), 2, true)
    local center = rect:copy():shrink(2):centered_square()
    if realm ~= INVALID_ID then
        local province_id = DATA.realm_get_capitol(realm)
        if province_id ~= INVALID_ID and ib.is_visible_to_player(province_id,player) then
            if ut.coa(realm, center) then
                gamescene.selected.realm = realm
                gamescene.inspector = "realm"
            end
        else
            ut.coa(realm, center)
        end
    else
        ut.icon_button(ASSETS.icons["uncertainty"],center,"Unknown realm!",false)
    end
    if tooltip then
        ui.tooltip(tooltip,rect)
    end
end

---@param gamescene GameScene
---@param character Character
---@param rect Rect
---@param tooltip string?
function ib.icon_button_to_character(gamescene, character, rect, tooltip)
    require "game.scenes.game.widgets.portrait"(rect, character)
    if ui.invisible_button(rect) then
        gamescene.selected.character = character
        gamescene.inspector = "character"
    end
    if tooltip then
        ui.tooltip(tooltip, rect)
    end
end

---@param gamescene GameScene
---@param province Province
---@param rect Rect
---@param tooltip string?
function ib.text_button_to_province(gamescene, province, rect, tooltip)
    local player = WORLD.player_character
    local potential = true
    if province ~= INVALID_ID then
        if player ~= INVALID_ID and not ib.is_visible_to_player(province,player) then
            potential = false
        end
        if ut.text_button(PROVINCE_NAME(province), rect, tooltip, potential) then
            gamescene.selected.province = province
            gamescene.selected.tile = DATA.province_get_center(province)
            gamescene.inspector = "tile"
        end
    else
        ut.text_button("Unknown", rect, tooltip)
    end

end

---@param gamescene GameScene
---@param estate estate_id
---@param rect Rect
---@param tooltip string?
---@param potential boolean?
---@param active boolean?
function ib.text_button_to_estate(gamescene, estate, rect, text, tooltip, potential, active)
    if ut.text_button(text, rect, tooltip, potential, active) then
        gamescene.selected.building = INVALID_ID
        gamescene.selected.estate = estate
        gamescene.inspector = "building"
    end
end

---@param gamescene GameScene
---@param warband_id warband_id
---@param rect Rect
---@param tooltip string?
function ib.icon_button_to_warband(gamescene, warband_id, rect, tooltip)
    local warband_utils = require "game.entities.warband"
    local player = WORLD.player_character
    local potential = true
    if warband_id ~= INVALID_ID then
        local province = warband_utils.location(warband_id)
        if player ~= INVALID_ID and not ib.is_visible_to_player(province,player) then
            potential = false
        end
        if ut.icon_button(ASSETS.icons["minions.png"],rect,tooltip,potential) then
            gamescene.selected.warband = warband_id
            gamescene.inspector = "warband"
        end
    else
        ut.icon_button(ASSETS.icons["uncertainty.png"],rect,tooltip)
    end
end

---renders text and square close button to the right
---@param game any
---@param rect any
---@param inspector_name any
function ib.render_inspector_header(game,rect,inspector_name)
    ui.panel(rect,2,true,true)
    ui.text("Character View", rect:subrect(0,0,rect.width-rect.height,rect.height,"left","up"),"left","center")
    -- add a back (last inspector and target) button?
    ib.icon_button_to_close(game,rect:subrect(0,0,rect.height,rect.height,"right","up"))
end

---renders clickable portrait redirect with additional icons and tooltips on top
---@param rect Rect
---@param pop_id pop_id
---@param player_id pop_id
---@param tooltip string?
function ib.render_portrait_with_overlay(game, rect, pop_id, player_id, tooltip)

    -- first validate that pop_id is valid
    if pop_id == INVALID_ID then
        return
    -- should have DATA validate calls for all objects
    elseif not DCON.dcon_pop_is_valid(pop_id-1) then
        return
    end

    local left_up_rect = rect:subrect(0,0,ut.BASE_HEIGHT,ut.BASE_HEIGHT,"left","up")
    local center_up_rect = rect:subrect(0,0,ut.BASE_HEIGHT,ut.BASE_HEIGHT,"center","up")
    local right_up_rect  = rect:subrect(0,0,ut.BASE_HEIGHT,ut.BASE_HEIGHT,"right","up")
    local right_center_rect  = rect:subrect(0,0,ut.BASE_HEIGHT,ut.BASE_HEIGHT,"right","center")
    local left_center_rect  = rect:subrect(0,0,ut.BASE_HEIGHT,ut.BASE_HEIGHT,"left","center")
    local left_down_rect  = rect:subrect(0,0,ut.BASE_HEIGHT,ut.BASE_HEIGHT,"left","down")
    local center_down_rect  = rect:subrect(0,0,ut.BASE_HEIGHT,ut.BASE_HEIGHT,"center","down")
    local right_down_rect   = rect:subrect(0,0,ut.BASE_HEIGHT,ut.BASE_HEIGHT,"right","down")

    local pop_name = NAME(pop_id)

    -- draw portrait
    ib.icon_button_to_character(game,pop_id,rect,tooltip)

    -- draw over portrait
    local realm_id = REALM(pop_id)
    ib.icon_button_to_realm(game, realm_id, right_down_rect, pop_name .. " is a " .. rank_name(pop_id)
        .. " of " .. DATA.realm_get_name(realm_id) .. ".")
    if DATA.pop_get_busy(pop_id) then
        ut.render_icon(right_center_rect,"stopwatch.png",.8,.8,.8,1,true)
        ui.tooltip(pop_name .. " is currently busy.",right_center_rect)
    end
    -- only draw loyalty and blood if player
    if player_id and player_id ~= INVALID_ID then
		local character_loyalty = LOYAL_TO(pop_id)
        local player_loyalty = LOYAL_TO(player_id)--player_id and player_id ~= INVALID_ID and LOYAL_TO(player_id) or INVALID_ID -- something weird going on with player_id...
        if character_loyalty ~= INVALID_ID and character_loyalty == player_id then
            ut.render_icon(center_up_rect,"kneeling.png",0,1,0,1,true)
            ui.tooltip(pop_name .. " has sorn loyalty to me.",center_up_rect)
        elseif player_loyalty ~= INVALID_ID and player_loyalty == pop_id then
            ut.render_icon(center_up_rect,"despair.png",0,1,0,1,true)
            ui.tooltip("I have sworn loyalty to " .. pop_name .. ".",center_up_rect)
        end
		-- blood relationship
        if player_id == pop_id then
            ut.render_icon(center_down_rect,"self-love.png",0.72,0.13,0.27,1,true)
            ui.tooltip("This is me!",center_down_rect)
		else -- only check for relations and not looking at player character
			local is_child, is_parent = false, false
			local parent = PARENT(pop_id)
			if parent ~= INVALID_ID and parent == player_id then
				is_parent = true
			end
            local player_parent = PARENT(player_id)
			if player_parent ~= INVALID_ID and player_parent == pop_id then
				is_child = true
			end
			-- draw blood relation only if there is one
			if is_parent then
				ut.render_icon(center_down_rect,"inner-self.png",0.72,0.13,0.27,1,true)
                ui.tooltip(pop_name .. " is my child.",center_down_rect)
            elseif is_child then
				ut.render_icon(center_down_rect,"droplets.png",0.72,0.13,0.27,1,true)
                ui.tooltip(pop_name .. " is my parent.",center_down_rect)
			end
        end
    end
    -- ??? free_will ???
    if DATA.pop_get_free_will(pop_id) then
        ut.render_icon(left_down_rect,"uncertainty.png",.8,.8,.8,1,true)
        ui.tooltip(pop_name .. " has free will?",left_down_rect)
    else
        ut.render_icon(left_down_rect,"uncertainty.png",1,0,0,1,true)
        ui.tooltip(pop_name .. " does not have free will?",left_down_rect)
    end
end

return ib