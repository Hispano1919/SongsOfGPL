local tabb = require "engine.table"
local ui = require "engine.ui"
local ut = require "game.ui-utils"

---@param rect Rect
---@param character_id Character
return function(rect, character_id)
    if character_id == INVALID_ID then
        return
    end

    local character = DATA.fatten_pop(character_id)

    if character.race == INVALID_ID then
        return
    end

    local race = DATA.fatten_race(character.race)

    -- drawing rectangles: remove boarder from space portrait image
    local border_width = math.max(1, math.floor(math.min(rect.height, rect.width) / ut.BASE_HEIGHT))
    local inner_rect = rect:copy():shrink(math.floor(math.max(1, border_width)))
    local square = inner_rect:centered_square()

    local style = ui.style.panel_outline
    if character.rank == CHARACTER_RANK.NOBLE then
        -- silver color rgba
        ui.style.panel_outline = {r = 165 / 255, g = 169 / 255, b = 180 / 255, a = 1}
    elseif character.rank == CHARACTER_RANK.CHIEF then
        -- gold color rgba
        ui.style.panel_outline = {r = 255 / 255, g = 215 / 255, b = 0 / 255, a = 1}
    end
    -- TODO: maybe we should draw background images related to current position
    local old_inside = ui.style["panel_inside"]
    ui.style["panel_inside"] = {r = 0 / 255, g = 20 / 255, b = 10 / 255, a = 0.3}
    ui.panel(inner_rect, 2, false)
    ui.style["panel_inside"] = old_inside

    love.graphics.setLineWidth( border_width )

    local portrait_set = race.male_portrait
    if character.female then
        portrait_set = race.female_portrait
    end

    local character_age = AGE_YEARS(character_id)

    if portrait_set then
        local portrait = portrait_set.fallback

        if portrait_set.elder then
            portrait = portrait_set.elder
        end

        if character_age < race.elder_age then
            if portrait_set.middle then
                portrait = portrait_set.middle
            end
        end

        if character_age < race.middle_age then
            if portrait_set.adult then
                portrait = portrait_set.adult
            end
        end

        if character_age < race.adult_age then
            if portrait_set.teen then
                portrait = portrait_set.teen
            end
        end

        if character_age < race.teen_age then
            if portrait_set.child then
                portrait = portrait_set.child
            end
        end

        assert(portrait ~= nil, "INVALID PORTRAIT: RACE " .. race.name)

        ---@type number[]
        local dna_per_layer = {}
        ---@type table<string, number>
        local layer_to_index = {}
        for i, layer in ipairs(portrait.layers) do
            table.insert(dna_per_layer, DATA.pop_get_dna(character_id, i))
            layer_to_index[layer] = i
        end

        for i, layers_group in pairs(portrait.layers_groups) do
            for j, layer in ipairs(layers_group) do
                dna_per_layer[layer_to_index[layer]] = dna_per_layer[layer_to_index[layers_group[1]]]
            end
        end

        assert(ASSETS.portraits[portrait.folder] ~= nil, portrait.folder .. " WAS NOT LOADED")

        for i, layer in ipairs(portrait.layers) do
            assert(ASSETS.portraits[portrait.folder][layer] ~= nil, layer .. " WAS NOT LOADED")
            assert(dna_per_layer[i] ~= nil, i)
            ui.image_ith(ASSETS.portraits[portrait.folder][layer], dna_per_layer[i], square)
        end
    else
        assert(race.icon ~= nil, "race " .. character.race .. " icon is nil")
        assert(ASSETS.icons[race.icon] ~= nil, "race " .. race.name .. " icon " .. race.icon .. " is missing ")
        ui.image(ASSETS.icons[race.icon], square)
    end

    ui.panel(square, 2, true, false)
    love.graphics.setLineWidth( 1 )
    ui.style.panel_outline = style
end