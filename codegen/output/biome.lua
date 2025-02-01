local ffi = require("ffi")
----------biome----------


---biome: LSP types---

---Unique identificator for biome entity
---@class (exact) biome_id : table
---@field is_biome number
---@class (exact) fat_biome_id
---@field id biome_id Unique biome id
---@field name string 
---@field r number 
---@field g number 
---@field b number 
---@field aquatic boolean 
---@field marsh boolean 
---@field icy boolean 
---@field minimum_slope number m
---@field maximum_slope number m
---@field minimum_elevation number m
---@field maximum_elevation number m
---@field minimum_temperature number C
---@field maximum_temperature number C
---@field minimum_summer_temperature number C
---@field maximum_summer_temperature number C
---@field minimum_winter_temperature number C
---@field maximum_winter_temperature number C
---@field minimum_rain number mm
---@field maximum_rain number mm
---@field minimum_available_water number abstract, adjusted for permeability
---@field maximum_available_water number abstract, adjusted for permeability
---@field minimum_trees number %
---@field maximum_trees number %
---@field minimum_grass number %
---@field maximum_grass number %
---@field minimum_shrubs number %
---@field maximum_shrubs number %
---@field minimum_conifer_fraction number %
---@field maximum_conifer_fraction number %
---@field minimum_dead_land number %
---@field maximum_dead_land number %
---@field minimum_soil_depth number m
---@field maximum_soil_depth number m
---@field minimum_soil_richness number %
---@field maximum_soil_richness number %
---@field minimum_sand number %
---@field maximum_sand number %
---@field minimum_clay number %
---@field maximum_clay number %
---@field minimum_silt number %
---@field maximum_silt number %

---@class struct_biome
---@field r number 
---@field g number 
---@field b number 
---@field aquatic boolean 
---@field marsh boolean 
---@field icy boolean 
---@field minimum_slope number m
---@field maximum_slope number m
---@field minimum_elevation number m
---@field maximum_elevation number m
---@field minimum_temperature number C
---@field maximum_temperature number C
---@field minimum_summer_temperature number C
---@field maximum_summer_temperature number C
---@field minimum_winter_temperature number C
---@field maximum_winter_temperature number C
---@field minimum_rain number mm
---@field maximum_rain number mm
---@field minimum_available_water number abstract, adjusted for permeability
---@field maximum_available_water number abstract, adjusted for permeability
---@field minimum_trees number %
---@field maximum_trees number %
---@field minimum_grass number %
---@field maximum_grass number %
---@field minimum_shrubs number %
---@field maximum_shrubs number %
---@field minimum_conifer_fraction number %
---@field maximum_conifer_fraction number %
---@field minimum_dead_land number %
---@field maximum_dead_land number %
---@field minimum_soil_depth number m
---@field maximum_soil_depth number m
---@field minimum_soil_richness number %
---@field maximum_soil_richness number %
---@field minimum_sand number %
---@field maximum_sand number %
---@field minimum_clay number %
---@field maximum_clay number %
---@field minimum_silt number %
---@field maximum_silt number %

---@class (exact) biome_id_data_blob_definition
---@field name string 
---@field r number 
---@field g number 
---@field b number 
---@field aquatic boolean? 
---@field marsh boolean? 
---@field icy boolean? 
---@field minimum_slope number? m
---@field maximum_slope number? m
---@field minimum_elevation number? m
---@field maximum_elevation number? m
---@field minimum_temperature number? C
---@field maximum_temperature number? C
---@field minimum_summer_temperature number? C
---@field maximum_summer_temperature number? C
---@field minimum_winter_temperature number? C
---@field maximum_winter_temperature number? C
---@field minimum_rain number? mm
---@field maximum_rain number? mm
---@field minimum_available_water number? abstract, adjusted for permeability
---@field maximum_available_water number? abstract, adjusted for permeability
---@field minimum_trees number? %
---@field maximum_trees number? %
---@field minimum_grass number? %
---@field maximum_grass number? %
---@field minimum_shrubs number? %
---@field maximum_shrubs number? %
---@field minimum_conifer_fraction number? %
---@field maximum_conifer_fraction number? %
---@field minimum_dead_land number? %
---@field maximum_dead_land number? %
---@field minimum_soil_depth number? m
---@field maximum_soil_depth number? m
---@field minimum_soil_richness number? %
---@field maximum_soil_richness number? %
---@field minimum_sand number? %
---@field maximum_sand number? %
---@field minimum_clay number? %
---@field maximum_clay number? %
---@field minimum_silt number? %
---@field maximum_silt number? %
---Sets values of biome for given id
---@param id biome_id
---@param data biome_id_data_blob_definition
function DATA.setup_biome(id, data)
    DATA.biome_set_aquatic(id, false)
    DATA.biome_set_marsh(id, false)
    DATA.biome_set_icy(id, false)
    DATA.biome_set_minimum_slope(id, -99999999)
    DATA.biome_set_maximum_slope(id, 99999999)
    DATA.biome_set_minimum_elevation(id, -99999999)
    DATA.biome_set_maximum_elevation(id, 99999999)
    DATA.biome_set_minimum_temperature(id, -99999999)
    DATA.biome_set_maximum_temperature(id, 99999999)
    DATA.biome_set_minimum_summer_temperature(id, -99999999)
    DATA.biome_set_maximum_summer_temperature(id, 99999999)
    DATA.biome_set_minimum_winter_temperature(id, -99999999)
    DATA.biome_set_maximum_winter_temperature(id, 99999999)
    DATA.biome_set_minimum_rain(id, -99999999)
    DATA.biome_set_maximum_rain(id, 99999999)
    DATA.biome_set_minimum_available_water(id, -99999999)
    DATA.biome_set_maximum_available_water(id, 99999999)
    DATA.biome_set_minimum_trees(id, -99999999)
    DATA.biome_set_maximum_trees(id, 99999999)
    DATA.biome_set_minimum_grass(id, -99999999)
    DATA.biome_set_maximum_grass(id, 99999999)
    DATA.biome_set_minimum_shrubs(id, -99999999)
    DATA.biome_set_maximum_shrubs(id, 99999999)
    DATA.biome_set_minimum_conifer_fraction(id, -99999999)
    DATA.biome_set_maximum_conifer_fraction(id, 99999999)
    DATA.biome_set_minimum_dead_land(id, -99999999)
    DATA.biome_set_maximum_dead_land(id, 99999999)
    DATA.biome_set_minimum_soil_depth(id, -99999999)
    DATA.biome_set_maximum_soil_depth(id, 99999999)
    DATA.biome_set_minimum_soil_richness(id, -99999999)
    DATA.biome_set_maximum_soil_richness(id, 99999999)
    DATA.biome_set_minimum_sand(id, -99999999)
    DATA.biome_set_maximum_sand(id, 99999999)
    DATA.biome_set_minimum_clay(id, -99999999)
    DATA.biome_set_maximum_clay(id, 99999999)
    DATA.biome_set_minimum_silt(id, -99999999)
    DATA.biome_set_maximum_silt(id, 99999999)
    DATA.biome_set_name(id, data.name)
    DATA.biome_set_r(id, data.r)
    DATA.biome_set_g(id, data.g)
    DATA.biome_set_b(id, data.b)
    if data.aquatic ~= nil then
        DATA.biome_set_aquatic(id, data.aquatic)
    end
    if data.marsh ~= nil then
        DATA.biome_set_marsh(id, data.marsh)
    end
    if data.icy ~= nil then
        DATA.biome_set_icy(id, data.icy)
    end
    if data.minimum_slope ~= nil then
        DATA.biome_set_minimum_slope(id, data.minimum_slope)
    end
    if data.maximum_slope ~= nil then
        DATA.biome_set_maximum_slope(id, data.maximum_slope)
    end
    if data.minimum_elevation ~= nil then
        DATA.biome_set_minimum_elevation(id, data.minimum_elevation)
    end
    if data.maximum_elevation ~= nil then
        DATA.biome_set_maximum_elevation(id, data.maximum_elevation)
    end
    if data.minimum_temperature ~= nil then
        DATA.biome_set_minimum_temperature(id, data.minimum_temperature)
    end
    if data.maximum_temperature ~= nil then
        DATA.biome_set_maximum_temperature(id, data.maximum_temperature)
    end
    if data.minimum_summer_temperature ~= nil then
        DATA.biome_set_minimum_summer_temperature(id, data.minimum_summer_temperature)
    end
    if data.maximum_summer_temperature ~= nil then
        DATA.biome_set_maximum_summer_temperature(id, data.maximum_summer_temperature)
    end
    if data.minimum_winter_temperature ~= nil then
        DATA.biome_set_minimum_winter_temperature(id, data.minimum_winter_temperature)
    end
    if data.maximum_winter_temperature ~= nil then
        DATA.biome_set_maximum_winter_temperature(id, data.maximum_winter_temperature)
    end
    if data.minimum_rain ~= nil then
        DATA.biome_set_minimum_rain(id, data.minimum_rain)
    end
    if data.maximum_rain ~= nil then
        DATA.biome_set_maximum_rain(id, data.maximum_rain)
    end
    if data.minimum_available_water ~= nil then
        DATA.biome_set_minimum_available_water(id, data.minimum_available_water)
    end
    if data.maximum_available_water ~= nil then
        DATA.biome_set_maximum_available_water(id, data.maximum_available_water)
    end
    if data.minimum_trees ~= nil then
        DATA.biome_set_minimum_trees(id, data.minimum_trees)
    end
    if data.maximum_trees ~= nil then
        DATA.biome_set_maximum_trees(id, data.maximum_trees)
    end
    if data.minimum_grass ~= nil then
        DATA.biome_set_minimum_grass(id, data.minimum_grass)
    end
    if data.maximum_grass ~= nil then
        DATA.biome_set_maximum_grass(id, data.maximum_grass)
    end
    if data.minimum_shrubs ~= nil then
        DATA.biome_set_minimum_shrubs(id, data.minimum_shrubs)
    end
    if data.maximum_shrubs ~= nil then
        DATA.biome_set_maximum_shrubs(id, data.maximum_shrubs)
    end
    if data.minimum_conifer_fraction ~= nil then
        DATA.biome_set_minimum_conifer_fraction(id, data.minimum_conifer_fraction)
    end
    if data.maximum_conifer_fraction ~= nil then
        DATA.biome_set_maximum_conifer_fraction(id, data.maximum_conifer_fraction)
    end
    if data.minimum_dead_land ~= nil then
        DATA.biome_set_minimum_dead_land(id, data.minimum_dead_land)
    end
    if data.maximum_dead_land ~= nil then
        DATA.biome_set_maximum_dead_land(id, data.maximum_dead_land)
    end
    if data.minimum_soil_depth ~= nil then
        DATA.biome_set_minimum_soil_depth(id, data.minimum_soil_depth)
    end
    if data.maximum_soil_depth ~= nil then
        DATA.biome_set_maximum_soil_depth(id, data.maximum_soil_depth)
    end
    if data.minimum_soil_richness ~= nil then
        DATA.biome_set_minimum_soil_richness(id, data.minimum_soil_richness)
    end
    if data.maximum_soil_richness ~= nil then
        DATA.biome_set_maximum_soil_richness(id, data.maximum_soil_richness)
    end
    if data.minimum_sand ~= nil then
        DATA.biome_set_minimum_sand(id, data.minimum_sand)
    end
    if data.maximum_sand ~= nil then
        DATA.biome_set_maximum_sand(id, data.maximum_sand)
    end
    if data.minimum_clay ~= nil then
        DATA.biome_set_minimum_clay(id, data.minimum_clay)
    end
    if data.maximum_clay ~= nil then
        DATA.biome_set_maximum_clay(id, data.maximum_clay)
    end
    if data.minimum_silt ~= nil then
        DATA.biome_set_minimum_silt(id, data.minimum_silt)
    end
    if data.maximum_silt ~= nil then
        DATA.biome_set_maximum_silt(id, data.maximum_silt)
    end
end

ffi.cdef[[
void dcon_biome_set_r(int32_t, float);
float dcon_biome_get_r(int32_t);
void dcon_biome_set_g(int32_t, float);
float dcon_biome_get_g(int32_t);
void dcon_biome_set_b(int32_t, float);
float dcon_biome_get_b(int32_t);
void dcon_biome_set_aquatic(int32_t, bool);
bool dcon_biome_get_aquatic(int32_t);
void dcon_biome_set_marsh(int32_t, bool);
bool dcon_biome_get_marsh(int32_t);
void dcon_biome_set_icy(int32_t, bool);
bool dcon_biome_get_icy(int32_t);
void dcon_biome_set_minimum_slope(int32_t, float);
float dcon_biome_get_minimum_slope(int32_t);
void dcon_biome_set_maximum_slope(int32_t, float);
float dcon_biome_get_maximum_slope(int32_t);
void dcon_biome_set_minimum_elevation(int32_t, float);
float dcon_biome_get_minimum_elevation(int32_t);
void dcon_biome_set_maximum_elevation(int32_t, float);
float dcon_biome_get_maximum_elevation(int32_t);
void dcon_biome_set_minimum_temperature(int32_t, float);
float dcon_biome_get_minimum_temperature(int32_t);
void dcon_biome_set_maximum_temperature(int32_t, float);
float dcon_biome_get_maximum_temperature(int32_t);
void dcon_biome_set_minimum_summer_temperature(int32_t, float);
float dcon_biome_get_minimum_summer_temperature(int32_t);
void dcon_biome_set_maximum_summer_temperature(int32_t, float);
float dcon_biome_get_maximum_summer_temperature(int32_t);
void dcon_biome_set_minimum_winter_temperature(int32_t, float);
float dcon_biome_get_minimum_winter_temperature(int32_t);
void dcon_biome_set_maximum_winter_temperature(int32_t, float);
float dcon_biome_get_maximum_winter_temperature(int32_t);
void dcon_biome_set_minimum_rain(int32_t, float);
float dcon_biome_get_minimum_rain(int32_t);
void dcon_biome_set_maximum_rain(int32_t, float);
float dcon_biome_get_maximum_rain(int32_t);
void dcon_biome_set_minimum_available_water(int32_t, float);
float dcon_biome_get_minimum_available_water(int32_t);
void dcon_biome_set_maximum_available_water(int32_t, float);
float dcon_biome_get_maximum_available_water(int32_t);
void dcon_biome_set_minimum_trees(int32_t, float);
float dcon_biome_get_minimum_trees(int32_t);
void dcon_biome_set_maximum_trees(int32_t, float);
float dcon_biome_get_maximum_trees(int32_t);
void dcon_biome_set_minimum_grass(int32_t, float);
float dcon_biome_get_minimum_grass(int32_t);
void dcon_biome_set_maximum_grass(int32_t, float);
float dcon_biome_get_maximum_grass(int32_t);
void dcon_biome_set_minimum_shrubs(int32_t, float);
float dcon_biome_get_minimum_shrubs(int32_t);
void dcon_biome_set_maximum_shrubs(int32_t, float);
float dcon_biome_get_maximum_shrubs(int32_t);
void dcon_biome_set_minimum_conifer_fraction(int32_t, float);
float dcon_biome_get_minimum_conifer_fraction(int32_t);
void dcon_biome_set_maximum_conifer_fraction(int32_t, float);
float dcon_biome_get_maximum_conifer_fraction(int32_t);
void dcon_biome_set_minimum_dead_land(int32_t, float);
float dcon_biome_get_minimum_dead_land(int32_t);
void dcon_biome_set_maximum_dead_land(int32_t, float);
float dcon_biome_get_maximum_dead_land(int32_t);
void dcon_biome_set_minimum_soil_depth(int32_t, float);
float dcon_biome_get_minimum_soil_depth(int32_t);
void dcon_biome_set_maximum_soil_depth(int32_t, float);
float dcon_biome_get_maximum_soil_depth(int32_t);
void dcon_biome_set_minimum_soil_richness(int32_t, float);
float dcon_biome_get_minimum_soil_richness(int32_t);
void dcon_biome_set_maximum_soil_richness(int32_t, float);
float dcon_biome_get_maximum_soil_richness(int32_t);
void dcon_biome_set_minimum_sand(int32_t, float);
float dcon_biome_get_minimum_sand(int32_t);
void dcon_biome_set_maximum_sand(int32_t, float);
float dcon_biome_get_maximum_sand(int32_t);
void dcon_biome_set_minimum_clay(int32_t, float);
float dcon_biome_get_minimum_clay(int32_t);
void dcon_biome_set_maximum_clay(int32_t, float);
float dcon_biome_get_maximum_clay(int32_t);
void dcon_biome_set_minimum_silt(int32_t, float);
float dcon_biome_get_minimum_silt(int32_t);
void dcon_biome_set_maximum_silt(int32_t, float);
float dcon_biome_get_maximum_silt(int32_t);
int32_t dcon_create_biome();
bool dcon_biome_is_valid(int32_t);
void dcon_biome_resize(uint32_t sz);
uint32_t dcon_biome_size();
]]

---biome: FFI arrays---
---@type (string)[]
DATA.biome_name= {}

---biome: LUA bindings---

DATA.biome_size = 100
---@return biome_id
function DATA.create_biome()
    ---@type biome_id
    local i  = DCON.dcon_create_biome() + 1
    return i --[[@as biome_id]] 
end
---@param func fun(item: biome_id) 
function DATA.for_each_biome(func)
    ---@type number
    local range = DCON.dcon_biome_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as biome_id]])
    end
end
---@param func fun(item: biome_id):boolean 
---@return table<biome_id, biome_id> 
function DATA.filter_biome(func)
    ---@type table<biome_id, biome_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_biome_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as biome_id]]) then t[i + 1 --[[@as biome_id]]] = t[i + 1 --[[@as biome_id]]] end
    end
    return t
end

---@param biome_id biome_id valid biome id
---@return string name 
function DATA.biome_get_name(biome_id)
    return DATA.biome_name[biome_id]
end
---@param biome_id biome_id valid biome id
---@param value string valid string
function DATA.biome_set_name(biome_id, value)
    DATA.biome_name[biome_id] = value
end
---@param biome_id biome_id valid biome id
---@return number r 
function DATA.biome_get_r(biome_id)
    return DCON.dcon_biome_get_r(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_r(biome_id, value)
    DCON.dcon_biome_set_r(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_r(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_r(biome_id - 1)
    DCON.dcon_biome_set_r(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number g 
function DATA.biome_get_g(biome_id)
    return DCON.dcon_biome_get_g(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_g(biome_id, value)
    DCON.dcon_biome_set_g(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_g(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_g(biome_id - 1)
    DCON.dcon_biome_set_g(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number b 
function DATA.biome_get_b(biome_id)
    return DCON.dcon_biome_get_b(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_b(biome_id, value)
    DCON.dcon_biome_set_b(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_b(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_b(biome_id - 1)
    DCON.dcon_biome_set_b(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return boolean aquatic 
function DATA.biome_get_aquatic(biome_id)
    return DCON.dcon_biome_get_aquatic(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value boolean valid boolean
function DATA.biome_set_aquatic(biome_id, value)
    DCON.dcon_biome_set_aquatic(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@return boolean marsh 
function DATA.biome_get_marsh(biome_id)
    return DCON.dcon_biome_get_marsh(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value boolean valid boolean
function DATA.biome_set_marsh(biome_id, value)
    DCON.dcon_biome_set_marsh(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@return boolean icy 
function DATA.biome_get_icy(biome_id)
    return DCON.dcon_biome_get_icy(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value boolean valid boolean
function DATA.biome_set_icy(biome_id, value)
    DCON.dcon_biome_set_icy(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_slope m
function DATA.biome_get_minimum_slope(biome_id)
    return DCON.dcon_biome_get_minimum_slope(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_slope(biome_id, value)
    DCON.dcon_biome_set_minimum_slope(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_slope(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_slope(biome_id - 1)
    DCON.dcon_biome_set_minimum_slope(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_slope m
function DATA.biome_get_maximum_slope(biome_id)
    return DCON.dcon_biome_get_maximum_slope(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_slope(biome_id, value)
    DCON.dcon_biome_set_maximum_slope(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_slope(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_slope(biome_id - 1)
    DCON.dcon_biome_set_maximum_slope(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_elevation m
function DATA.biome_get_minimum_elevation(biome_id)
    return DCON.dcon_biome_get_minimum_elevation(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_elevation(biome_id, value)
    DCON.dcon_biome_set_minimum_elevation(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_elevation(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_elevation(biome_id - 1)
    DCON.dcon_biome_set_minimum_elevation(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_elevation m
function DATA.biome_get_maximum_elevation(biome_id)
    return DCON.dcon_biome_get_maximum_elevation(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_elevation(biome_id, value)
    DCON.dcon_biome_set_maximum_elevation(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_elevation(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_elevation(biome_id - 1)
    DCON.dcon_biome_set_maximum_elevation(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_temperature C
function DATA.biome_get_minimum_temperature(biome_id)
    return DCON.dcon_biome_get_minimum_temperature(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_temperature(biome_id, value)
    DCON.dcon_biome_set_minimum_temperature(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_temperature(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_temperature(biome_id - 1)
    DCON.dcon_biome_set_minimum_temperature(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_temperature C
function DATA.biome_get_maximum_temperature(biome_id)
    return DCON.dcon_biome_get_maximum_temperature(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_temperature(biome_id, value)
    DCON.dcon_biome_set_maximum_temperature(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_temperature(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_temperature(biome_id - 1)
    DCON.dcon_biome_set_maximum_temperature(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_summer_temperature C
function DATA.biome_get_minimum_summer_temperature(biome_id)
    return DCON.dcon_biome_get_minimum_summer_temperature(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_summer_temperature(biome_id, value)
    DCON.dcon_biome_set_minimum_summer_temperature(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_summer_temperature(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_summer_temperature(biome_id - 1)
    DCON.dcon_biome_set_minimum_summer_temperature(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_summer_temperature C
function DATA.biome_get_maximum_summer_temperature(biome_id)
    return DCON.dcon_biome_get_maximum_summer_temperature(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_summer_temperature(biome_id, value)
    DCON.dcon_biome_set_maximum_summer_temperature(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_summer_temperature(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_summer_temperature(biome_id - 1)
    DCON.dcon_biome_set_maximum_summer_temperature(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_winter_temperature C
function DATA.biome_get_minimum_winter_temperature(biome_id)
    return DCON.dcon_biome_get_minimum_winter_temperature(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_winter_temperature(biome_id, value)
    DCON.dcon_biome_set_minimum_winter_temperature(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_winter_temperature(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_winter_temperature(biome_id - 1)
    DCON.dcon_biome_set_minimum_winter_temperature(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_winter_temperature C
function DATA.biome_get_maximum_winter_temperature(biome_id)
    return DCON.dcon_biome_get_maximum_winter_temperature(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_winter_temperature(biome_id, value)
    DCON.dcon_biome_set_maximum_winter_temperature(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_winter_temperature(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_winter_temperature(biome_id - 1)
    DCON.dcon_biome_set_maximum_winter_temperature(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_rain mm
function DATA.biome_get_minimum_rain(biome_id)
    return DCON.dcon_biome_get_minimum_rain(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_rain(biome_id, value)
    DCON.dcon_biome_set_minimum_rain(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_rain(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_rain(biome_id - 1)
    DCON.dcon_biome_set_minimum_rain(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_rain mm
function DATA.biome_get_maximum_rain(biome_id)
    return DCON.dcon_biome_get_maximum_rain(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_rain(biome_id, value)
    DCON.dcon_biome_set_maximum_rain(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_rain(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_rain(biome_id - 1)
    DCON.dcon_biome_set_maximum_rain(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_available_water abstract, adjusted for permeability
function DATA.biome_get_minimum_available_water(biome_id)
    return DCON.dcon_biome_get_minimum_available_water(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_available_water(biome_id, value)
    DCON.dcon_biome_set_minimum_available_water(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_available_water(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_available_water(biome_id - 1)
    DCON.dcon_biome_set_minimum_available_water(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_available_water abstract, adjusted for permeability
function DATA.biome_get_maximum_available_water(biome_id)
    return DCON.dcon_biome_get_maximum_available_water(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_available_water(biome_id, value)
    DCON.dcon_biome_set_maximum_available_water(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_available_water(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_available_water(biome_id - 1)
    DCON.dcon_biome_set_maximum_available_water(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_trees %
function DATA.biome_get_minimum_trees(biome_id)
    return DCON.dcon_biome_get_minimum_trees(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_trees(biome_id, value)
    DCON.dcon_biome_set_minimum_trees(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_trees(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_trees(biome_id - 1)
    DCON.dcon_biome_set_minimum_trees(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_trees %
function DATA.biome_get_maximum_trees(biome_id)
    return DCON.dcon_biome_get_maximum_trees(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_trees(biome_id, value)
    DCON.dcon_biome_set_maximum_trees(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_trees(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_trees(biome_id - 1)
    DCON.dcon_biome_set_maximum_trees(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_grass %
function DATA.biome_get_minimum_grass(biome_id)
    return DCON.dcon_biome_get_minimum_grass(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_grass(biome_id, value)
    DCON.dcon_biome_set_minimum_grass(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_grass(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_grass(biome_id - 1)
    DCON.dcon_biome_set_minimum_grass(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_grass %
function DATA.biome_get_maximum_grass(biome_id)
    return DCON.dcon_biome_get_maximum_grass(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_grass(biome_id, value)
    DCON.dcon_biome_set_maximum_grass(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_grass(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_grass(biome_id - 1)
    DCON.dcon_biome_set_maximum_grass(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_shrubs %
function DATA.biome_get_minimum_shrubs(biome_id)
    return DCON.dcon_biome_get_minimum_shrubs(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_shrubs(biome_id, value)
    DCON.dcon_biome_set_minimum_shrubs(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_shrubs(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_shrubs(biome_id - 1)
    DCON.dcon_biome_set_minimum_shrubs(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_shrubs %
function DATA.biome_get_maximum_shrubs(biome_id)
    return DCON.dcon_biome_get_maximum_shrubs(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_shrubs(biome_id, value)
    DCON.dcon_biome_set_maximum_shrubs(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_shrubs(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_shrubs(biome_id - 1)
    DCON.dcon_biome_set_maximum_shrubs(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_conifer_fraction %
function DATA.biome_get_minimum_conifer_fraction(biome_id)
    return DCON.dcon_biome_get_minimum_conifer_fraction(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_conifer_fraction(biome_id, value)
    DCON.dcon_biome_set_minimum_conifer_fraction(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_conifer_fraction(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_conifer_fraction(biome_id - 1)
    DCON.dcon_biome_set_minimum_conifer_fraction(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_conifer_fraction %
function DATA.biome_get_maximum_conifer_fraction(biome_id)
    return DCON.dcon_biome_get_maximum_conifer_fraction(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_conifer_fraction(biome_id, value)
    DCON.dcon_biome_set_maximum_conifer_fraction(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_conifer_fraction(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_conifer_fraction(biome_id - 1)
    DCON.dcon_biome_set_maximum_conifer_fraction(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_dead_land %
function DATA.biome_get_minimum_dead_land(biome_id)
    return DCON.dcon_biome_get_minimum_dead_land(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_dead_land(biome_id, value)
    DCON.dcon_biome_set_minimum_dead_land(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_dead_land(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_dead_land(biome_id - 1)
    DCON.dcon_biome_set_minimum_dead_land(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_dead_land %
function DATA.biome_get_maximum_dead_land(biome_id)
    return DCON.dcon_biome_get_maximum_dead_land(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_dead_land(biome_id, value)
    DCON.dcon_biome_set_maximum_dead_land(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_dead_land(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_dead_land(biome_id - 1)
    DCON.dcon_biome_set_maximum_dead_land(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_soil_depth m
function DATA.biome_get_minimum_soil_depth(biome_id)
    return DCON.dcon_biome_get_minimum_soil_depth(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_soil_depth(biome_id, value)
    DCON.dcon_biome_set_minimum_soil_depth(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_soil_depth(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_soil_depth(biome_id - 1)
    DCON.dcon_biome_set_minimum_soil_depth(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_soil_depth m
function DATA.biome_get_maximum_soil_depth(biome_id)
    return DCON.dcon_biome_get_maximum_soil_depth(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_soil_depth(biome_id, value)
    DCON.dcon_biome_set_maximum_soil_depth(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_soil_depth(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_soil_depth(biome_id - 1)
    DCON.dcon_biome_set_maximum_soil_depth(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_soil_richness %
function DATA.biome_get_minimum_soil_richness(biome_id)
    return DCON.dcon_biome_get_minimum_soil_richness(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_soil_richness(biome_id, value)
    DCON.dcon_biome_set_minimum_soil_richness(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_soil_richness(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_soil_richness(biome_id - 1)
    DCON.dcon_biome_set_minimum_soil_richness(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_soil_richness %
function DATA.biome_get_maximum_soil_richness(biome_id)
    return DCON.dcon_biome_get_maximum_soil_richness(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_soil_richness(biome_id, value)
    DCON.dcon_biome_set_maximum_soil_richness(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_soil_richness(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_soil_richness(biome_id - 1)
    DCON.dcon_biome_set_maximum_soil_richness(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_sand %
function DATA.biome_get_minimum_sand(biome_id)
    return DCON.dcon_biome_get_minimum_sand(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_sand(biome_id, value)
    DCON.dcon_biome_set_minimum_sand(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_sand(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_sand(biome_id - 1)
    DCON.dcon_biome_set_minimum_sand(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_sand %
function DATA.biome_get_maximum_sand(biome_id)
    return DCON.dcon_biome_get_maximum_sand(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_sand(biome_id, value)
    DCON.dcon_biome_set_maximum_sand(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_sand(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_sand(biome_id - 1)
    DCON.dcon_biome_set_maximum_sand(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_clay %
function DATA.biome_get_minimum_clay(biome_id)
    return DCON.dcon_biome_get_minimum_clay(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_clay(biome_id, value)
    DCON.dcon_biome_set_minimum_clay(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_clay(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_clay(biome_id - 1)
    DCON.dcon_biome_set_minimum_clay(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_clay %
function DATA.biome_get_maximum_clay(biome_id)
    return DCON.dcon_biome_get_maximum_clay(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_clay(biome_id, value)
    DCON.dcon_biome_set_maximum_clay(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_clay(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_clay(biome_id - 1)
    DCON.dcon_biome_set_maximum_clay(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number minimum_silt %
function DATA.biome_get_minimum_silt(biome_id)
    return DCON.dcon_biome_get_minimum_silt(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_minimum_silt(biome_id, value)
    DCON.dcon_biome_set_minimum_silt(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_minimum_silt(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_minimum_silt(biome_id - 1)
    DCON.dcon_biome_set_minimum_silt(biome_id - 1, current + value)
end
---@param biome_id biome_id valid biome id
---@return number maximum_silt %
function DATA.biome_get_maximum_silt(biome_id)
    return DCON.dcon_biome_get_maximum_silt(biome_id - 1)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_set_maximum_silt(biome_id, value)
    DCON.dcon_biome_set_maximum_silt(biome_id - 1, value)
end
---@param biome_id biome_id valid biome id
---@param value number valid number
function DATA.biome_inc_maximum_silt(biome_id, value)
    ---@type number
    local current = DCON.dcon_biome_get_maximum_silt(biome_id - 1)
    DCON.dcon_biome_set_maximum_silt(biome_id - 1, current + value)
end

local fat_biome_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.biome_get_name(t.id) end
        if (k == "r") then return DATA.biome_get_r(t.id) end
        if (k == "g") then return DATA.biome_get_g(t.id) end
        if (k == "b") then return DATA.biome_get_b(t.id) end
        if (k == "aquatic") then return DATA.biome_get_aquatic(t.id) end
        if (k == "marsh") then return DATA.biome_get_marsh(t.id) end
        if (k == "icy") then return DATA.biome_get_icy(t.id) end
        if (k == "minimum_slope") then return DATA.biome_get_minimum_slope(t.id) end
        if (k == "maximum_slope") then return DATA.biome_get_maximum_slope(t.id) end
        if (k == "minimum_elevation") then return DATA.biome_get_minimum_elevation(t.id) end
        if (k == "maximum_elevation") then return DATA.biome_get_maximum_elevation(t.id) end
        if (k == "minimum_temperature") then return DATA.biome_get_minimum_temperature(t.id) end
        if (k == "maximum_temperature") then return DATA.biome_get_maximum_temperature(t.id) end
        if (k == "minimum_summer_temperature") then return DATA.biome_get_minimum_summer_temperature(t.id) end
        if (k == "maximum_summer_temperature") then return DATA.biome_get_maximum_summer_temperature(t.id) end
        if (k == "minimum_winter_temperature") then return DATA.biome_get_minimum_winter_temperature(t.id) end
        if (k == "maximum_winter_temperature") then return DATA.biome_get_maximum_winter_temperature(t.id) end
        if (k == "minimum_rain") then return DATA.biome_get_minimum_rain(t.id) end
        if (k == "maximum_rain") then return DATA.biome_get_maximum_rain(t.id) end
        if (k == "minimum_available_water") then return DATA.biome_get_minimum_available_water(t.id) end
        if (k == "maximum_available_water") then return DATA.biome_get_maximum_available_water(t.id) end
        if (k == "minimum_trees") then return DATA.biome_get_minimum_trees(t.id) end
        if (k == "maximum_trees") then return DATA.biome_get_maximum_trees(t.id) end
        if (k == "minimum_grass") then return DATA.biome_get_minimum_grass(t.id) end
        if (k == "maximum_grass") then return DATA.biome_get_maximum_grass(t.id) end
        if (k == "minimum_shrubs") then return DATA.biome_get_minimum_shrubs(t.id) end
        if (k == "maximum_shrubs") then return DATA.biome_get_maximum_shrubs(t.id) end
        if (k == "minimum_conifer_fraction") then return DATA.biome_get_minimum_conifer_fraction(t.id) end
        if (k == "maximum_conifer_fraction") then return DATA.biome_get_maximum_conifer_fraction(t.id) end
        if (k == "minimum_dead_land") then return DATA.biome_get_minimum_dead_land(t.id) end
        if (k == "maximum_dead_land") then return DATA.biome_get_maximum_dead_land(t.id) end
        if (k == "minimum_soil_depth") then return DATA.biome_get_minimum_soil_depth(t.id) end
        if (k == "maximum_soil_depth") then return DATA.biome_get_maximum_soil_depth(t.id) end
        if (k == "minimum_soil_richness") then return DATA.biome_get_minimum_soil_richness(t.id) end
        if (k == "maximum_soil_richness") then return DATA.biome_get_maximum_soil_richness(t.id) end
        if (k == "minimum_sand") then return DATA.biome_get_minimum_sand(t.id) end
        if (k == "maximum_sand") then return DATA.biome_get_maximum_sand(t.id) end
        if (k == "minimum_clay") then return DATA.biome_get_minimum_clay(t.id) end
        if (k == "maximum_clay") then return DATA.biome_get_maximum_clay(t.id) end
        if (k == "minimum_silt") then return DATA.biome_get_minimum_silt(t.id) end
        if (k == "maximum_silt") then return DATA.biome_get_maximum_silt(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.biome_set_name(t.id, v)
            return
        end
        if (k == "r") then
            DATA.biome_set_r(t.id, v)
            return
        end
        if (k == "g") then
            DATA.biome_set_g(t.id, v)
            return
        end
        if (k == "b") then
            DATA.biome_set_b(t.id, v)
            return
        end
        if (k == "aquatic") then
            DATA.biome_set_aquatic(t.id, v)
            return
        end
        if (k == "marsh") then
            DATA.biome_set_marsh(t.id, v)
            return
        end
        if (k == "icy") then
            DATA.biome_set_icy(t.id, v)
            return
        end
        if (k == "minimum_slope") then
            DATA.biome_set_minimum_slope(t.id, v)
            return
        end
        if (k == "maximum_slope") then
            DATA.biome_set_maximum_slope(t.id, v)
            return
        end
        if (k == "minimum_elevation") then
            DATA.biome_set_minimum_elevation(t.id, v)
            return
        end
        if (k == "maximum_elevation") then
            DATA.biome_set_maximum_elevation(t.id, v)
            return
        end
        if (k == "minimum_temperature") then
            DATA.biome_set_minimum_temperature(t.id, v)
            return
        end
        if (k == "maximum_temperature") then
            DATA.biome_set_maximum_temperature(t.id, v)
            return
        end
        if (k == "minimum_summer_temperature") then
            DATA.biome_set_minimum_summer_temperature(t.id, v)
            return
        end
        if (k == "maximum_summer_temperature") then
            DATA.biome_set_maximum_summer_temperature(t.id, v)
            return
        end
        if (k == "minimum_winter_temperature") then
            DATA.biome_set_minimum_winter_temperature(t.id, v)
            return
        end
        if (k == "maximum_winter_temperature") then
            DATA.biome_set_maximum_winter_temperature(t.id, v)
            return
        end
        if (k == "minimum_rain") then
            DATA.biome_set_minimum_rain(t.id, v)
            return
        end
        if (k == "maximum_rain") then
            DATA.biome_set_maximum_rain(t.id, v)
            return
        end
        if (k == "minimum_available_water") then
            DATA.biome_set_minimum_available_water(t.id, v)
            return
        end
        if (k == "maximum_available_water") then
            DATA.biome_set_maximum_available_water(t.id, v)
            return
        end
        if (k == "minimum_trees") then
            DATA.biome_set_minimum_trees(t.id, v)
            return
        end
        if (k == "maximum_trees") then
            DATA.biome_set_maximum_trees(t.id, v)
            return
        end
        if (k == "minimum_grass") then
            DATA.biome_set_minimum_grass(t.id, v)
            return
        end
        if (k == "maximum_grass") then
            DATA.biome_set_maximum_grass(t.id, v)
            return
        end
        if (k == "minimum_shrubs") then
            DATA.biome_set_minimum_shrubs(t.id, v)
            return
        end
        if (k == "maximum_shrubs") then
            DATA.biome_set_maximum_shrubs(t.id, v)
            return
        end
        if (k == "minimum_conifer_fraction") then
            DATA.biome_set_minimum_conifer_fraction(t.id, v)
            return
        end
        if (k == "maximum_conifer_fraction") then
            DATA.biome_set_maximum_conifer_fraction(t.id, v)
            return
        end
        if (k == "minimum_dead_land") then
            DATA.biome_set_minimum_dead_land(t.id, v)
            return
        end
        if (k == "maximum_dead_land") then
            DATA.biome_set_maximum_dead_land(t.id, v)
            return
        end
        if (k == "minimum_soil_depth") then
            DATA.biome_set_minimum_soil_depth(t.id, v)
            return
        end
        if (k == "maximum_soil_depth") then
            DATA.biome_set_maximum_soil_depth(t.id, v)
            return
        end
        if (k == "minimum_soil_richness") then
            DATA.biome_set_minimum_soil_richness(t.id, v)
            return
        end
        if (k == "maximum_soil_richness") then
            DATA.biome_set_maximum_soil_richness(t.id, v)
            return
        end
        if (k == "minimum_sand") then
            DATA.biome_set_minimum_sand(t.id, v)
            return
        end
        if (k == "maximum_sand") then
            DATA.biome_set_maximum_sand(t.id, v)
            return
        end
        if (k == "minimum_clay") then
            DATA.biome_set_minimum_clay(t.id, v)
            return
        end
        if (k == "maximum_clay") then
            DATA.biome_set_maximum_clay(t.id, v)
            return
        end
        if (k == "minimum_silt") then
            DATA.biome_set_minimum_silt(t.id, v)
            return
        end
        if (k == "maximum_silt") then
            DATA.biome_set_maximum_silt(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id biome_id
---@return fat_biome_id fat_id
function DATA.fatten_biome(id)
    local result = {id = id}
    setmetatable(result, fat_biome_id_metatable)
    return result --[[@as fat_biome_id]]
end
