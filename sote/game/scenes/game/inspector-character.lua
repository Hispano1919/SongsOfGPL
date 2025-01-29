local tabb = require "engine.table"
local strings = require "engine.string"

local ui = require "engine.ui"
local ut = require "game.ui-utils"

local pui = require "game.scenes.game.widgets.pop-ui-widgets"
local ib = require "game.scenes.game.widgets.inspector-redirect-buttons"

local character_name_widget = require "game.scenes.game.widgets.character-name"
local list_widget = require "game.scenes.game.widgets.list-widget"

local pop_utils = require "game.entities.pop".POP
local warband_utils = require "game.entities.warband"



local window = {}
local selected_decision = nil
local decision_target_primary = nil
local decision_target_secondary = nil

---@alias InspectorCharacterTabs "WRK"|"WAR"|"AST"|"REL"|"DCN"
---@type InspectorCharacterTabs
local character_tab = "WRK"
local forage_table_state = nil

---@alias InspectorRelationshipTabs "FAMILY"|"LOYALTY"
---@type InspectorRelationshipTabs
local relations_tab = "FAMILY"
local relations_family_state = nil
local relations_loyalty_state = nil

---@alias InspectorInventoryTabs "INVENTORY"|"BUILDINGS"
---@type InspectorInventoryTabs
local inventory_tab = "INVENTORY"
local inventory_goods_state = nil
local inventory_building_state  = nil

-- TODO GLOBALIZE
WARBAND_STATUS_ICON = {
    [WARBAND_STATUS.INVALID] = "uncertainty.png",
    [WARBAND_STATUS.IDLE] = "guards.png",
    [WARBAND_STATUS.RAIDING] = "stone-spear.png",
    [WARBAND_STATUS.PREPARING_RAID] = "minions.png",
    [WARBAND_STATUS.PREPARING_PATROL] = "ages.png",
    [WARBAND_STATUS.PATROL] = "round-shield.png",
    [WARBAND_STATUS.ATTACKING] = "stone-axe.png",
    [WARBAND_STATUS.TRAVELLING] = "horizon-road.png",
    [WARBAND_STATUS.OFF_DUTY] = "shrug.png",
}


---@return Rect
local function get_main_panel()
	local fs = ui.fullscreen()
	local panel = fs:subrect(ut.BASE_HEIGHT * 2, 0, ut.BASE_HEIGHT * 16, ut.BASE_HEIGHT * 25, "left", "down")
	return panel
end

function window.mask()
    if ui.trigger(get_main_panel()) then
		return false
	else
		return true
	end
end

---draws portrait with overlay and some info
---@param game GameScene
---@param rect Rect
---@param pop_id pop_id
---@param player_id pop_id
local function draw_top_panel(game,rect,pop_id,player_id)

    local name_panel = rect:subrect(0,0,rect.width,ut.BASE_HEIGHT,"left","up")
    local title_panel = rect:subrect(0,ut.BASE_HEIGHT,rect.width,ut.BASE_HEIGHT,"left","up")
    local name = NAME(pop_id)
    local parent = PARENT(pop_id)
    -- family name stand in
    if parent ~= INVALID_ID then
        if DATA.pop_get_female(pop_id) then
            name = name .. ", daughter of "
        else
            name = name .. ", son of "
        end
        name = name .. NAME(parent)
    end
    ui.text(name,name_panel,"left","center")
    ui.text(character_name_widget(pop_id),title_panel,"left","center")

    local portrait_size = math.max(ut.BASE_HEIGHT*3,rect.height-name_panel.height-title_panel.height)
    local portrait_rect = rect:subrect(0,0,portrait_size,portrait_size,"left","down")
    ib.render_portrait_with_overlay(game,portrait_rect,pop_id,player_id)

    local line_height = portrait_size/4
    local line_rect = rect:subrect(0,0,rect.width-portrait_rect.width,portrait_rect.height,"right","down")
    local line_builder = ui.layout_builder():position(line_rect.x,line_rect.y):vertical():build()
    local line_next, line_layout

    -- basic info
    line_next = line_builder:next(line_rect.width,line_height)
    line_layout = ui.layout_builder():position(line_next.x,line_next.y):horizontal():build()
    pui.render_age(line_layout:next(line_next.width-ut.BASE_HEIGHT*10,line_height),pop_id,"right")
    pui.render_female_icon(line_layout:next(ut.BASE_HEIGHT,line_height),pop_id)
    ui.render_race_icon(line_layout:next(ut.BASE_HEIGHT,line_height),RACE(pop_id),ui.race_tooltip(RACE(pop_id)))
    ui.render_culture_icon(line_layout:next(ut.BASE_HEIGHT,line_height),CULTURE(pop_id),ui.culture_tooltip(CULTURE(pop_id)))
    ui.render_faith_icon(line_layout:next(ut.BASE_HEIGHT,line_height),DATA.pop_get_faith(pop_id),ui.faith_tooltip(DATA.pop_get_faith(pop_id)))
    pui.render_basic_needs_satsifaction(line_layout:next(ut.BASE_HEIGHT*3,line_height),pop_id)
    pui.render_life_needs_satsifaction(line_layout:next(ut.BASE_HEIGHT*3,line_height),pop_id)

    -- econ info
    line_next = line_builder:next(line_rect.width,line_height)
    line_layout = ui.layout_builder():position(line_next.x,line_next.y):horizontal():build()
    pui.render_occupation_icon(line_layout:next(ut.BASE_HEIGHT,line_height),pop_id,pui.occupation_tooltip(pop_id))
    pui.render_pending_income(line_layout:next(ut.BASE_HEIGHT*4,line_height),pop_id)
    pui.render_savings(line_layout:next(line_next.width-ut.BASE_HEIGHT*8,line_height),pop_id)
    pui.render_spending_ratio(line_layout:next(ut.BASE_HEIGHT*3,line_height),pop_id)

    -- location and popularity
    line_next = line_builder:next(line_rect.width,line_height)
    line_layout = ui.layout_builder():position(line_next.x,line_next.y):horizontal():build()
    pui.render_location_buttons(game,line_layout:next(line_next.width-ut.BASE_HEIGHT*3,line_height),pop_id)
    pui.render_realm_popularity(line_layout:next(ut.BASE_HEIGHT*3,line_height),pop_id,PROVINCE_REALM(PROVINCE(pop_id)))

    -- home populatiry
    line_next = line_builder:next(line_rect.width,line_height)
    line_layout = ui.layout_builder():position(line_next.x,line_next.y):horizontal():build()
    pui.render_realm_popularity(line_layout:next(ut.BASE_HEIGHT*3,line_height),pop_id,REALM(pop_id))
    -- space for more stuff!

end
-- wrap grid in scrollview?
---draws grid of trait icons with name tooltip
---, has space for upto 22 icons
---@param rect Rect
---@param pop_id pop_id
local function draw_trait_panel(rect,pop_id)
    local spacing = 5
    local border_panel = rect:subrect(ut.BASE_HEIGHT,spacing,rect.width-ut.BASE_HEIGHT*2,rect.height-spacing*2,"left","up")
    ui.panel(border_panel,2,true,true)
    local line_count = math.floor((border_panel.width) / (ut.BASE_HEIGHT+spacing))
    local layout = ui.layout_builder():position(border_panel.x+spacing,border_panel.y+spacing):grid(line_count):spacing(spacing):build()

    for i = 1, MAX_TRAIT_INDEX do
        local trait = DATA.pop_get_traits(pop_id, i)
        if trait == INVALID_ID then
            break
        end
        local trait_rect = layout:next(ut.BASE_HEIGHT,ut.BASE_HEIGHT)
        ut.render_icon(trait_rect,DATA.trait_get_icon(trait),1,1,1,1)
        ui.tooltip(strings.title(DATA.trait_get_name(trait):lower()),trait_rect)
    end
end
-- tab drawing calls
---draws efficiencies and employer link
---@param game GameScene
---@param rect Rect
---@param pop_id pop_id
---@param player_id pop_id
local function draw_wrk_tab(game,rect,pop_id,player_id)
    local layout = ui.layout_builder():position(rect.x,rect.y):vertical():build()

    local efficiencies_rect = layout:next(rect.width,ut.BASE_HEIGHT*2)
    local draw_width = ut.BASE_HEIGHT*4
    local line_count = math.floor(efficiencies_rect.width/draw_width)
    local offset = math.floor((efficiencies_rect.width - line_count * draw_width)/2)
    local effic_layout = ui.layout_builder():position(efficiencies_rect.x+offset,efficiencies_rect.y):grid(line_count):build()
    for i=1, tabb.size(JOBTYPE)-1 do
        pui.render_job_efficiency(effic_layout:next(draw_width,ut.BASE_HEIGHT),pop_id,i)
    end

    local employer_id = pop_utils.get_employer_of(pop_id)
    if employer_id ~= INVALID_ID then
       local employer_rect = layout:next(rect.width,ut.BASE_HEIGHT*4)
       local building_type_id = DATA.building_get_current_type(employer_id)
       local employer_name = DATA.building_type_get_name(building_type_id)
       if employer_id ~= INVALID_ID then
           ui.text("Employer", employer_rect:subrect(0,0,employer_rect.width - ut.BASE_HEIGHT*3, ut.BASE_HEIGHT,"left", "up"),"left")
           employer_rect.y, employer_rect.height = employer_rect.y + ut.BASE_HEIGHT, employer_rect.height - ut.BASE_HEIGHT

           local employer_portrait = employer_rect:subrect(0,0,ut.BASE_HEIGHT*3,ut.BASE_HEIGHT*3,"left","down")
           local owner_id = OWNER(employer_id)
           local owner_name
           if owner_id ~= INVALID_ID then
               owner_name = NAME(owner_id) .. "'s "
               ib.render_portrait_with_overlay(game,employer_portrait,owner_id,player_id)
           else -- no owner means empty realm building
               local location_id = BUILDING_PROVINCE(employer_id)
               local realm_id = PROVINCE_REALM(location_id)
               if realm_id ~= INVALID_ID then
                   owner_name = REALM_NAME(realm_id) .. "'s "
                   ib.icon_button_to_realm(game,realm_id,employer_portrait,strings.title(REALM_NAME(realm_id)))
               else
                   owner_name = "Unowned "
                   ut.render_icon(employer_portrait, "uncertainty.png",.8,.8,.8,1,true)
               end
           end

           local line_rect = employer_rect:subrect(0,0,employer_rect.width-ut.BASE_HEIGHT*3,ut.BASE_HEIGHT*3,"right","down")
           local lines_layout = ui.layout_builder():position(line_rect.x,line_rect.y):vertical():build()
           local line_rect = lines_layout:next(line_rect.width,ut.BASE_HEIGHT)
           local line_layout = ui.layout_builder():position(line_rect.x,line_rect.y):horizontal():build()
           local building_icon_rect = line_layout:next(ut.BASE_HEIGHT,ut.BASE_HEIGHT)
           ut.render_icon(building_icon_rect,
               DATA.building_type_get_icon(building_type_id),
               DATA.building_type_get_r(building_type_id),
               DATA.building_type_get_g(building_type_id),
               DATA.building_type_get_b(building_type_id),
               1,
               true)
           ui.tooltip(strings.title(DATA.building_type_get_name(building_type_id))
               .. "\n " .. DATA.building_type_get_description(building_type_id)
               ,building_icon_rect)
           ib.text_button_to_building(game, employer_id,line_layout:next(line_rect.width-ut.BASE_HEIGHT,ut.BASE_HEIGHT),
               NAME(pop_id) .. " works at " .. owner_name .. employer_name .. " in " .. PROVINCE_NAME(BUILDING_PROVINCE(employer_id)) .. ".")

           line_rect = lines_layout:next(line_rect.width,ut.BASE_HEIGHT)
           line_layout = ui.layout_builder():position(line_rect.x,line_rect.y):horizontal():build()
           local job_rect = line_layout:next(line_rect.width-ut.BASE_HEIGHT*3,ut.BASE_HEIGHT)
           pui.render_job_icon(job_rect:subrect(0,0,ut.BASE_HEIGHT,ut.BASE_HEIGHT,"left","up"),pop_id)
           pui.render_job_text(job_rect:subrect(0,0,job_rect.width-ut.BASE_HEIGHT,ut.BASE_HEIGHT,"right","up"),pop_id)
           ui.tooltip(strings.title(pui.job_text(pop_id)) .. "\n " .. strings.title(DATA.job_get_description(pop_utils.get_job_of(pop_id))),job_rect)
           pui.render_worker_income(line_layout:next(ut.BASE_HEIGHT*3,ut.BASE_HEIGHT),pop_id)

           line_rect = lines_layout:next(line_rect.width,ut.BASE_HEIGHT)
           line_layout = ui.layout_builder():position(line_rect.x,line_rect.y):horizontal():build()
           local production_method_id = DATA.building_type_get_production_method(building_type_id)
           local method_icon_rect = line_layout:next(ut.BASE_HEIGHT,ut.BASE_HEIGHT)
           ut.render_icon(method_icon_rect,
               DATA.production_method_get_icon(production_method_id),
               DATA.production_method_get_r(production_method_id),
               DATA.production_method_get_g(production_method_id),
               DATA.production_method_get_b(production_method_id),
               1,
               true)
           ui.tooltip(strings.title(DATA.production_method_get_name(production_method_id))
               .. "\n " .. strings.title(DATA.production_method_get_description(production_method_id))
               ,method_icon_rect)
           local jobtype_id = DATA.production_method_get_job_type(production_method_id)
           pui.render_job_efficiency(line_layout:next(ut.BASE_HEIGHT*3,ut.BASE_HEIGHT),pop_id,jobtype_id)
           ui.panel(line_layout:next(line_rect.width-ut.BASE_HEIGHT*7,ut.BASE_HEIGHT),0)
           pui.render_work_time(line_layout:next(ut.BASE_HEIGHT*3,ut.BASE_HEIGHT),pop_id)
       end
       -- draw army information if part of one?
       -- link to local armies?
    end
    local forage_label = layout:next(rect.width,ut.BASE_HEIGHT)
    ui.text("Foraging", forage_label:subrect(0,0,forage_label.width - ut.BASE_HEIGHT*4, ut.BASE_HEIGHT,"left", "down"),"left")
    pui.render_forage_time(forage_label:subrect(0,0,ut.BASE_HEIGHT*3,ut.BASE_HEIGHT,"right","down"),pop_id)

    -- build forager methods table for list call
	local forager_methods = {}
    DATA.for_each_forage_resource(function (item)
		local ratio = DATA.culture_get_traditional_forager_targets(CULTURE(pop_id), item)
		forager_methods[item] = ratio
	end)

    -- build forager methods list columns
    local columns = {
        {
            header = ".",
            render_closure = function(rect, k, v)
                ut.render_icon(rect,DATA.forage_resource_get_icon(k),.8,.8,.8,1,true)
                ui.tooltip(strings.title(DATA.forage_resource_get_name(k)),rect)
            end,
            width = 1,
            value = function (k, v)
                return k
            end
        },
        {
            header = "name",
            render_closure = function(rect, k, v)
                local name = strings.title(DATA.forage_resource_get_name(k))
                ui.text(name,rect,"center","center")
                ui.tooltip(name,rect)
            end,
            width = 5,
            value = function (k, v)
                return DATA.forage_resource_get_name(k)
            end
        },
        {
            header = "plan",
            render_closure = function(rect, k, v)
                local culture_id = CULTURE(pop_id)
                ut.generic_number_field("chart.png",v,rect,DATA.culture_get_name(culture_id)
                    .. " plans to spend " .. ut.to_fixed_point2(v*100)
                    .. "% of foraging time harvesting " .. DATA.forage_resource_get_name(k) .. ".",
                    ut.NUMBER_MODE.PERCENTAGE,ut.NAME_MODE.ICON)
            end,
            width = 3,
            value = function (k, v)
                return v
            end
        },
        {
            header = "time",
            render_closure = function(rect, k, v)
                local hisher = "his"
                if DATA.pop_get_female(pop_id) then
                    hisher = "her"
                end
                local culture_id = CULTURE(pop_id)
                local forage_time, _, _, _ = pop_utils.get_time_allocation(pop_id)
                local composite_time = v * forage_time
                local composite_plan = v * DATA.pop_get_forage_ratio(pop_id)
                ut.generic_number_field("stopwatch.png",composite_time,rect,NAME(pop_id)
                    .. " actually spends " .. ut.to_fixed_point2(composite_time*100)
                    .. "% of " .. hisher .. " time harvesting " .. DATA.forage_resource_get_name(k) .. "."
                    .. "\n " .. NAME(pop_id) .. " desires to spend " .. ut.to_fixed_point2(composite_plan*100)
                    .. "% of " .. hisher .. " time " .. DATA.forage_resource_get_description(k) .. ".",
                    ut.NUMBER_MODE.PERCENTAGE,ut.NAME_MODE.ICON)
            end,
            width = 3,
            value = function (k, v)
                local forage_time, _, _, _ = pop_utils.get_time_allocation(pop_id)
                return v * forage_time
            end
        },
    }
    -- draw foraging table with remaining space
    local list_panel = layout:next(rect.width,rect.height-layout._pivot_y)
    forage_table_state = list_widget(list_panel, forager_methods, columns, forage_table_state)()
end
---draw unit stats and warband link
---@param game GameScene
---@param rect Rect
---@param pop_id pop_id
---@param player_id pop_id
local function draw_war_tab(game,rect,pop_id,player_id)
    local layout = ui.layout_builder():position(rect.x,rect.y):vertical():build()

    local attrib_rect = layout:next(rect.width,ut.BASE_HEIGHT*2)
    local draw_width = ut.BASE_HEIGHT*4
    local offset = math.floor((attrib_rect.width - draw_width*4)/2)
    local attrib_layout = ui.layout_builder():position(attrib_rect.x+offset,attrib_rect.y):grid(4):build()
    -- top row
    pui.render_size(attrib_layout:next(draw_width,ut.BASE_HEIGHT),pop_id)
    pui.render_spotting(attrib_layout:next(draw_width,ut.BASE_HEIGHT),pop_id)
    pui.render_visibility(attrib_layout:next(draw_width,ut.BASE_HEIGHT),pop_id)
    pui.render_supply_capacity(attrib_layout:next(draw_width,ut.BASE_HEIGHT),pop_id)
    -- bottom row
    pui.render_health(attrib_layout:next(draw_width,ut.BASE_HEIGHT),pop_id)
    pui.render_armor(attrib_layout:next(draw_width,ut.BASE_HEIGHT),pop_id)
    pui.render_attack(attrib_layout:next(draw_width,ut.BASE_HEIGHT),pop_id)
    pui.render_speed(attrib_layout:next(draw_width,ut.BASE_HEIGHT),pop_id)

    local warband_id = pop_utils.get_warband_of(pop_id)
    if warband_id ~= INVALID_ID then
        local warband_rect = layout:next(rect.width,ut.BASE_HEIGHT*4)
        local leader = warband_utils.active_commander(warband_id)
        local warband_name = strings.title(DATA.warband_get_name(warband_id))
        local leader_name
            ui.text("Warband", warband_rect:subrect(0,0,warband_rect.width - ut.BASE_HEIGHT*3, ut.BASE_HEIGHT,"left", "up"),"left")
            warband_rect.y, warband_rect.height = warband_rect.y + ut.BASE_HEIGHT, warband_rect.height - ut.BASE_HEIGHT
        local warband_portrait = warband_rect:subrect(0,0,ut.BASE_HEIGHT*3,ut.BASE_HEIGHT*3,"left","down")
        if leader and leader ~= INVALID_ID then
            leader_name = NAME(leader) .. "'s "
            ib.render_portrait_with_overlay(game,warband_portrait,leader,player_id)
        else -- no leader means 'empty' realm guard
            local location_id = warband_utils.location(warband_id)
            local realm_id = PROVINCE_REALM(location_id)
            local guard_id = GUARD(realm_id)
            if guard_id == warband_id then -- if a member of the guard without a leader
                leader_name = REALM_NAME(realm_id) .. "'s "
                ib.icon_button_to_realm(game,realm_id,warband_portrait,strings.title(REALM_NAME(realm_id)))
            else -- otherwise a characterless band of pops?
                leader_name = "Vagabond "
                ut.render_icon(warband_portrait, "uncertainty.png",.8,.8,.8,1,true)
            end
        end

        local lines_rect = warband_rect:subrect(0,0,warband_rect.width-ut.BASE_HEIGHT*3,ut.BASE_HEIGHT*3,"right","down")
        local lines_layout = ui.layout_builder():position(lines_rect.x,lines_rect.y):vertical():build()
        local line_rect = lines_layout:next(lines_rect.width,ut.BASE_HEIGHT)
        local line_layout = ui.layout_builder():position(line_rect.x,line_rect.y):horizontal():build()
        local warband_icon_rect = line_layout:next(ut.BASE_HEIGHT,ut.BASE_HEIGHT)
        local guard_of = DATA.warband_get_guard_of(warband_id)
        if guard_of and guard_of ~= INVALID_ID then
            ut.render_icon(warband_icon_rect,"guards.png",.8,.8,.8,1,true)
            ui.tooltip("Guard of " .. REALM_NAME(guard_of),warband_icon_rect)
        else
            ut.render_icon(warband_icon_rect,"minions.png",.8,.8,.8,1,true)
            ui.tooltip("Warband of " .. NAME(WARBAND_LEADER(warband_id)),warband_icon_rect)
        end
        ib.text_button_to_warband(game, warband_id,line_layout:next(line_rect.width-ut.BASE_HEIGHT,ut.BASE_HEIGHT),
            warband_name, NAME(pop_id) .. " is part of the " .. warband_name .. ".")

        line_rect = lines_layout:next(lines_rect.width,ut.BASE_HEIGHT)
        line_layout = ui.layout_builder():position(line_rect.x,line_rect.y):horizontal():build()
        local unit_rect = line_layout:next(line_rect.width-ut.BASE_HEIGHT*3,ut.BASE_HEIGHT)
        pui.render_unit_icon(unit_rect:subrect(0,0,ut.BASE_HEIGHT,ut.BASE_HEIGHT,"left","up"),pop_id)
        pui.render_unit_text(unit_rect:subrect(0,0,unit_rect.width-ut.BASE_HEIGHT,ut.BASE_HEIGHT,"right","up"),pop_id)
        ui.tooltip(pui.unit_tooltip(pop_id),unit_rect)
        pui.render_warband_income(line_layout:next(ut.BASE_HEIGHT*3,ut.BASE_HEIGHT),pop_id)

        line_rect = lines_layout:next(lines_rect.width,ut.BASE_HEIGHT)
        line_layout = ui.layout_builder():position(line_rect.x,line_rect.y):horizontal():build()

        local status = DATA.warband_get_current_status(warband_id)
        local status_text = DATA.warband_status_get_name(status)
        local status_rect = line_layout:next(line_rect.width-ut.BASE_HEIGHT*3,ut.BASE_HEIGHT)
        ut.render_icon(status_rect:subrect(0,0,ut.BASE_HEIGHT,ut.BASE_HEIGHT,"left","up"),WARBAND_STATUS_ICON[status],.8,.8,.8,1,true)
        ui.panel(status_rect,2,true)
        ui.text(strings.title(status_text),status_rect:subrect(0,0,status_rect.width-ut.BASE_HEIGHT,ut.BASE_HEIGHT,"right","up"),"center","center")
        ui.tooltip(warband_name .. " is currently " .. status_text .. ".",status_rect)
        pui.render_warband_time(line_layout:next(ut.BASE_HEIGHT*3,ut.BASE_HEIGHT),pop_id)

    end
end
---draws pop weight and inventory
---@param game GameScene
---@param rect Rect
---@param pop_id pop_id
---@param player_id pop_id
local function draw_prp_tab(game,rect,pop_id,player_id)
    -- ???, cc_weight,   infra_effic,    supply_capacity
    -- ???, ???,         infra_needs,    supply_used
    -- inventory goods tab(list)
        -- 1, 1, 3, 1, 1, 3, 1, 3
        -- icon, a-, amount, a+, d-, demand, d+, price
    -- building tab(list)
        -- 1, 3, 3, 3, 4, 1
        -- icon, donation, income, subsidy, location, coa
end

---comment
---@param game GameScene
---@param rect Rect
---@param pop_id pop_id
---@param player_id pop_id
---@param title string
local function draw_character_view(game,rect,pop_id,player_id, title)
    -- name and title?
    -- location, coa, popularity
    -- popularity, money, needs
    local title_rect = rect:subrect(0,0,rect.width,ut.BASE_HEIGHT,"left","up")
    ui.text(title,title_rect,"left","center")

    local portrait_size = rect.height-ut.BASE_HEIGHT
    local portrait_rect = rect:subrect(0,0,portrait_size,portrait_size,"left","down")
    ib.render_portrait_with_overlay(game,portrait_rect,pop_id,player_id,pui.pop_tooltip(pop_id))
    local lines_rect = rect:subrect(0,0,rect.width-portrait_size,portrait_size,"right","down")
    local lines_layout = ui.layout_builder():position(lines_rect.x,lines_rect.y):vertical():build()

    -- basic info
    local line_rect = lines_layout:next(lines_rect.width,ut.BASE_HEIGHT)
    local line_layout = ui.layout_builder():position(line_rect.x,line_rect.y):horizontal():build()
    pui.render_age(line_layout:next(line_rect.width-ut.BASE_HEIGHT*10,ut.BASE_HEIGHT),pop_id,"right")
    pui.render_female_icon(line_layout:next(ut.BASE_HEIGHT,ut.BASE_HEIGHT),pop_id)
    ui.render_race_icon(line_layout:next(ut.BASE_HEIGHT,ut.BASE_HEIGHT),RACE(pop_id),ui.race_tooltip(RACE(pop_id)))
    ui.render_culture_icon(line_layout:next(ut.BASE_HEIGHT,ut.BASE_HEIGHT),CULTURE(pop_id),ui.culture_tooltip(CULTURE(pop_id)))
    ui.render_faith_icon(line_layout:next(ut.BASE_HEIGHT,ut.BASE_HEIGHT),DATA.pop_get_faith(pop_id),ui.faith_tooltip(DATA.pop_get_faith(pop_id)))
    pui.render_basic_needs_satsifaction(line_layout:next(ut.BASE_HEIGHT*3,ut.BASE_HEIGHT),pop_id)
    pui.render_life_needs_satsifaction(line_layout:next(ut.BASE_HEIGHT*3,ut.BASE_HEIGHT),pop_id)

    -- location and popularity
    line_rect = lines_layout:next(lines_rect.width,ut.BASE_HEIGHT)
    line_layout = ui.layout_builder():position(line_rect.x,line_rect.y):horizontal():build()
    pui.render_location_buttons(game,line_layout:next(line_rect.width-ut.BASE_HEIGHT*3,ut.BASE_HEIGHT),pop_id)
    pui.render_realm_popularity(line_layout:next(ut.BASE_HEIGHT*3,ut.BASE_HEIGHT),pop_id,PROVINCE_REALM(PROVINCE(pop_id)))

    -- home populatiry
    line_rect = lines_layout:next(lines_rect.width,ut.BASE_HEIGHT)
    line_layout = ui.layout_builder():position(line_rect.x,line_rect.y):horizontal():build()
    pui.render_realm_popularity(line_layout:next(ut.BASE_HEIGHT*3,ut.BASE_HEIGHT),pop_id,REALM(pop_id))
end

---draws successor and tabs for parent-children or loyal_to-loyalty
---@param game GameScene
---@param rect Rect
---@param pop_id pop_id
---@param player_id pop_id
local function draw_rel_tab(game,rect,pop_id,player_id)
    local layout = ui.layout_builder():position(rect.x,rect.y):vertical():build()

    local successor_rect = layout:next(rect.width,ut.BASE_HEIGHT*4)
    local successor_id = pop_utils.get_successor_of(pop_id)
    if successor_id ~= INVALID_ID then
        draw_character_view(game,successor_rect,successor_id,player_id,"Successor")
    else
        ui.text("Successor",successor_rect:subrect(0,0,rect.width,ut.BASE_HEIGHT,"right","up"),"left","center")
        local portrait_rect = successor_rect:subrect(0,0,ut.BASE_HEIGHT*3,ut.BASE_HEIGHT*3,"left","down")
        ui.panel(portrait_rect,2,true)
        ut.render_icon(portrait_rect,"uncertainty.png",.8,.8,.8,1,true)
        local text_rect = successor_rect:subrect(0,ut.BASE_HEIGHT,rect.width-ut.BASE_HEIGHT*3,ut.BASE_HEIGHT,"right","up")
        ui.panel(text_rect,2,true)
        ui.text("None",text_rect,"left","center")
    end
    local relation_tabs_rect = layout:next(rect.width,ut.BASE_HEIGHT)
    local relation_list_rect = layout:next(rect.width,rect.height-layout._pivot_y)
    local relations_layout = ui.layout_builder():position(relation_tabs_rect.x,relation_tabs_rect.y):horizontal():build()
    relations_tab = ut.tabs(relations_tab, relations_layout, {
        {
            text = "FAMILY",
            tooltip = "Parent and children",
            closure = function()
                local parent = PARENT(pop_id)
                local list_rect
                if parent and parent ~= INVALID_ID then
                    list_rect = relation_list_rect:subrect(0,0,relation_list_rect.width,relation_list_rect.height-ut.BASE_HEIGHT*4,"left","down")
                    draw_character_view(game,relation_list_rect:subrect(0,0,relation_list_rect.width,ut.BASE_HEIGHT*4,"left","up"),parent,player_id,"Parent")
                else
                    list_rect = relation_list_rect
                end
                relations_family_state = require "game.scenes.game.widgets.character-list" (
                    game,
                    list_rect,
                    tabb.map_array(
                        DATA.filter_array_parent_child_relation_from_parent(
                            pop_id,
                            function (item) return true end
                        ),
                        DATA.parent_child_relation_get_child
                    ),
                    relations_family_state
                )()
            end
        },
        {
            text = "LOYALTY",
            tooltip = "Loyalties to and from " .. NAME(pop_id),
            closure = function()
                local loyal_to = LOYAL_TO(pop_id)
                local list_rect
                if loyal_to and loyal_to ~= INVALID_ID then
                    list_rect = relation_list_rect:subrect(0,0,relation_list_rect.width,relation_list_rect.height-ut.BASE_HEIGHT*4,"left","down")
                    draw_character_view(game,relation_list_rect:subrect(0,0,relation_list_rect.width,ut.BASE_HEIGHT*4,"left","up"),loyal_to,player_id,"Liege")
                else
                    list_rect = relation_list_rect
                end
                relations_loyalty_state = require "game.scenes.game.widgets.character-list" (
                    game,
                    list_rect,
                    tabb.map_array(
                        DATA.filter_array_loyalty_from_top(
                            pop_id,
                            function (item) return true end
                        ),
                        DATA.loyalty_get_bottom
                    ),
                    relations_loyalty_state
                )()
            end
        }
    }, 1, ut.BASE_HEIGHT * 7)
end


---draw actions/decisions panel tab
---@param game GameScene
---@param rect Rect
---@param pop_id pop_id
---@param player_id pop_id
local function draw_dcs_tab(game, rect, pop_id, player_id)
    -- decision panel
    local decisions_layout = ui.layout_builder():position(rect.x,rect.y):vertical():build()
    local decisions_label_panel =           decisions_layout:next(rect.width, ut.BASE_HEIGHT * 1)
    local decisions_panel =                 decisions_layout:next(rect.width, rect.height-ut.BASE_HEIGHT*2)
    local decisions_confirmation_panel =    decisions_layout:next(rect.width, ut.BASE_HEIGHT * 1)
    ui.panel(decisions_confirmation_panel,2,true)

    -- decisions view

    -- First, we need to check if the player is controlling a realm
    if player_id ~= INVALID_ID then
        ui.centered_text("Decisions:", decisions_label_panel)
        selected_decision, decision_target_primary, decision_target_secondary = require "game.scenes.game.widgets.decision-selection-character"(
            decisions_panel,
            "character",
            pop_id,
            selected_decision
        )
    else
        -- No player realm: no decisions to draw
    end
    local res = require "game.scenes.game.widgets.decision-desc"(
        decisions_confirmation_panel,
        player_id,
        selected_decision,
        decision_target_primary,
        decision_target_secondary
    )
    if res ~= "nothing" then
        selected_decision = nil
        decision_target_primary = nil
        decision_target_secondary = nil
    end
end

---Draw character window
---@param game GameScene
function window.draw(game)
    local character_id = game.selected.character
    local player_id = WORLD.player_character


    --display at least that character inspector is open
    local ui_panel = get_main_panel()
    -- draw a panel
    ui.panel(ui_panel)

    -- validate player_id
    if not DCON.dcon_pop_is_valid(player_id-1) then
        player_id = INVALID_ID
    end

    -- validate character_id
    if character_id == INVALID_ID then
        return
    -- should have DATA validate calls for all objects
    elseif not DCON.dcon_pop_is_valid(character_id) then
        return
    end

    if DEAD(character_id) then
        return
    end

    local layout = ui.layout_builder():position(ui_panel.x, ui_panel.y):vertical():build()

    -- header : inspector name and close button
    ib.render_inspector_header(game,layout:next(ui_panel.width,ut.BASE_HEIGHT))
    -- top panel : portrait and general info
    draw_top_panel(game,layout:next(ui_panel.width,ut.BASE_HEIGHT*6),character_id,player_id)
    -- trait panel : grid of trait icons with tooltips
    draw_trait_panel(layout:next(ui_panel.width,ut.BASE_HEIGHT*3.25),character_id)
    -- bot panel : tabs to general, work, warband,, inventory, relationships, decisions
    local tabs_layout_rect = layout:next(ui_panel.width,ut.BASE_HEIGHT)
    local tabs_layout = ui.layout_builder():position(tabs_layout_rect.x,tabs_layout_rect.y):horizontal():spacing(4):build()
    local tabs_panel_rect = layout:next(ui_panel.width, ui_panel.height-layout._pivot_y)
    ui.panel(tabs_panel_rect,2,true)

    local character_tabs = {
		{
			text = "REL",
			tooltip = "Family and loyalties",
			closure = function()
				draw_rel_tab(game,tabs_panel_rect,character_id,player_id)
			end
		},
		{
			text = "WRK",
			tooltip = "Work and foraging",
			closure = function()
				draw_wrk_tab(game,tabs_panel_rect,character_id,player_id)
			end
		},
		{
			text = "WAR",
			tooltip = "Warband",
			closure = function()
				draw_war_tab(game,tabs_panel_rect,character_id,player_id)
			end
		},
		{
			text = "PRP",
			tooltip = "Property and inventory",
			closure = function()
				draw_prp_tab(game,tabs_panel_rect,character_id,player_id)
			end
		},
        {
			text = "DCS",
			tooltip = "Actions and decisions",
			closure = function()
				draw_dcs_tab(game,tabs_panel_rect,character_id,player_id)
			end
		}
	}
--[[
    -- only add decision tab if playing a character
    if player_id ~= INVALID_ID then
        character_tabs[#character_tabs+1] = {
			text = "DCS",
			tooltip = "Actions and decisions",
			closure = function()
				draw_dcs_tab(game,tabs_panel_rect,character_id,player_id)
			end
		}
    end
--]]

    character_tab = ut.tabs(character_tab, tabs_layout, character_tabs, 1, ut.BASE_HEIGHT * 3)

end

return window
