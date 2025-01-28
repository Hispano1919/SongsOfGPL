local ffi = require("ffi")
----------race----------


---race: LSP types---

---Unique identificator for race entity
---@class (exact) race_id : table
---@field is_race number
---@class (exact) fat_race_id
---@field id race_id Unique race id
---@field name string 
---@field icon string 
---@field female_portrait nil|PortraitSet 
---@field male_portrait nil|PortraitSet 
---@field description string 
---@field r number 
---@field g number 
---@field b number 
---@field carrying_capacity_weight number 
---@field fecundity number 
---@field spotting number How good is this unit at scouting
---@field visibility number How visible is this unit in battles
---@field males_per_hundred_females number 
---@field child_age number 
---@field teen_age number 
---@field adult_age number 
---@field middle_age number 
---@field elder_age number 
---@field max_age number 
---@field minimum_comfortable_temperature number 
---@field minimum_absolute_temperature number 
---@field minimum_comfortable_elevation number 
---@field female_body_size number 
---@field male_body_size number 
---@field female_infrastructure_needs number 
---@field male_infrastructure_needs number 
---@field requires_large_river boolean 
---@field requires_large_forest boolean 

---@class struct_race
---@field r number 
---@field g number 
---@field b number 
---@field carrying_capacity_weight number 
---@field fecundity number 
---@field spotting number How good is this unit at scouting
---@field visibility number How visible is this unit in battles
---@field males_per_hundred_females number 
---@field child_age number 
---@field teen_age number 
---@field adult_age number 
---@field middle_age number 
---@field elder_age number 
---@field max_age number 
---@field minimum_comfortable_temperature number 
---@field minimum_absolute_temperature number 
---@field minimum_comfortable_elevation number 
---@field female_body_size number 
---@field male_body_size number 
---@field female_efficiency table<JOBTYPE, number> 
---@field male_efficiency table<JOBTYPE, number> 
---@field female_infrastructure_needs number 
---@field male_infrastructure_needs number 
---@field female_needs table<number, struct_need_definition> 
---@field male_needs table<number, struct_need_definition> 
---@field requires_large_river boolean 
---@field requires_large_forest boolean 

---@class (exact) race_id_data_blob_definition
---@field name string 
---@field icon string 
---@field female_portrait nil|PortraitSet 
---@field male_portrait nil|PortraitSet 
---@field description string 
---@field r number 
---@field g number 
---@field b number 
---@field carrying_capacity_weight number 
---@field fecundity number 
---@field spotting number How good is this unit at scouting
---@field visibility number How visible is this unit in battles
---@field males_per_hundred_females number 
---@field child_age number 
---@field teen_age number 
---@field adult_age number 
---@field middle_age number 
---@field elder_age number 
---@field max_age number 
---@field minimum_comfortable_temperature number 
---@field minimum_absolute_temperature number 
---@field minimum_comfortable_elevation number? 
---@field female_body_size number 
---@field male_body_size number 
---@field female_efficiency number[] 
---@field male_efficiency number[] 
---@field female_infrastructure_needs number 
---@field male_infrastructure_needs number 
---@field requires_large_river boolean? 
---@field requires_large_forest boolean? 
---Sets values of race for given id
---@param id race_id
---@param data race_id_data_blob_definition
function DATA.setup_race(id, data)
    DATA.race_set_minimum_comfortable_elevation(id, 0.0)
    DATA.race_set_requires_large_river(id, false)
    DATA.race_set_requires_large_forest(id, false)
    DATA.race_set_name(id, data.name)
    DATA.race_set_icon(id, data.icon)
    DATA.race_set_female_portrait(id, data.female_portrait)
    DATA.race_set_male_portrait(id, data.male_portrait)
    DATA.race_set_description(id, data.description)
    DATA.race_set_r(id, data.r)
    DATA.race_set_g(id, data.g)
    DATA.race_set_b(id, data.b)
    DATA.race_set_carrying_capacity_weight(id, data.carrying_capacity_weight)
    DATA.race_set_fecundity(id, data.fecundity)
    DATA.race_set_spotting(id, data.spotting)
    DATA.race_set_visibility(id, data.visibility)
    DATA.race_set_males_per_hundred_females(id, data.males_per_hundred_females)
    DATA.race_set_child_age(id, data.child_age)
    DATA.race_set_teen_age(id, data.teen_age)
    DATA.race_set_adult_age(id, data.adult_age)
    DATA.race_set_middle_age(id, data.middle_age)
    DATA.race_set_elder_age(id, data.elder_age)
    DATA.race_set_max_age(id, data.max_age)
    DATA.race_set_minimum_comfortable_temperature(id, data.minimum_comfortable_temperature)
    DATA.race_set_minimum_absolute_temperature(id, data.minimum_absolute_temperature)
    if data.minimum_comfortable_elevation ~= nil then
        DATA.race_set_minimum_comfortable_elevation(id, data.minimum_comfortable_elevation)
    end
    DATA.race_set_female_body_size(id, data.female_body_size)
    DATA.race_set_male_body_size(id, data.male_body_size)
    for i, value in pairs(data.female_efficiency) do
        DATA.race_set_female_efficiency(id, i, value)
    end
    for i, value in pairs(data.male_efficiency) do
        DATA.race_set_male_efficiency(id, i, value)
    end
    DATA.race_set_female_infrastructure_needs(id, data.female_infrastructure_needs)
    DATA.race_set_male_infrastructure_needs(id, data.male_infrastructure_needs)
    if data.requires_large_river ~= nil then
        DATA.race_set_requires_large_river(id, data.requires_large_river)
    end
    if data.requires_large_forest ~= nil then
        DATA.race_set_requires_large_forest(id, data.requires_large_forest)
    end
end

ffi.cdef[[
void dcon_race_set_r(int32_t, float);
float dcon_race_get_r(int32_t);
void dcon_race_set_g(int32_t, float);
float dcon_race_get_g(int32_t);
void dcon_race_set_b(int32_t, float);
float dcon_race_get_b(int32_t);
void dcon_race_set_carrying_capacity_weight(int32_t, float);
float dcon_race_get_carrying_capacity_weight(int32_t);
void dcon_race_set_fecundity(int32_t, float);
float dcon_race_get_fecundity(int32_t);
void dcon_race_set_spotting(int32_t, float);
float dcon_race_get_spotting(int32_t);
void dcon_race_set_visibility(int32_t, float);
float dcon_race_get_visibility(int32_t);
void dcon_race_set_males_per_hundred_females(int32_t, float);
float dcon_race_get_males_per_hundred_females(int32_t);
void dcon_race_set_child_age(int32_t, float);
float dcon_race_get_child_age(int32_t);
void dcon_race_set_teen_age(int32_t, float);
float dcon_race_get_teen_age(int32_t);
void dcon_race_set_adult_age(int32_t, float);
float dcon_race_get_adult_age(int32_t);
void dcon_race_set_middle_age(int32_t, float);
float dcon_race_get_middle_age(int32_t);
void dcon_race_set_elder_age(int32_t, float);
float dcon_race_get_elder_age(int32_t);
void dcon_race_set_max_age(int32_t, float);
float dcon_race_get_max_age(int32_t);
void dcon_race_set_minimum_comfortable_temperature(int32_t, float);
float dcon_race_get_minimum_comfortable_temperature(int32_t);
void dcon_race_set_minimum_absolute_temperature(int32_t, float);
float dcon_race_get_minimum_absolute_temperature(int32_t);
void dcon_race_set_minimum_comfortable_elevation(int32_t, float);
float dcon_race_get_minimum_comfortable_elevation(int32_t);
void dcon_race_set_female_body_size(int32_t, float);
float dcon_race_get_female_body_size(int32_t);
void dcon_race_set_male_body_size(int32_t, float);
float dcon_race_get_male_body_size(int32_t);
void dcon_race_resize_female_efficiency(uint32_t);
void dcon_race_set_female_efficiency(int32_t, int32_t, float);
float dcon_race_get_female_efficiency(int32_t, int32_t);
void dcon_race_resize_male_efficiency(uint32_t);
void dcon_race_set_male_efficiency(int32_t, int32_t, float);
float dcon_race_get_male_efficiency(int32_t, int32_t);
void dcon_race_set_female_infrastructure_needs(int32_t, float);
float dcon_race_get_female_infrastructure_needs(int32_t);
void dcon_race_set_male_infrastructure_needs(int32_t, float);
float dcon_race_get_male_infrastructure_needs(int32_t);
void dcon_race_resize_female_needs(uint32_t);
need_definition* dcon_race_get_female_needs(int32_t, int32_t);
void dcon_race_resize_male_needs(uint32_t);
need_definition* dcon_race_get_male_needs(int32_t, int32_t);
void dcon_race_set_requires_large_river(int32_t, bool);
bool dcon_race_get_requires_large_river(int32_t);
void dcon_race_set_requires_large_forest(int32_t, bool);
bool dcon_race_get_requires_large_forest(int32_t);
int32_t dcon_create_race();
bool dcon_race_is_valid(int32_t);
void dcon_race_resize(uint32_t sz);
uint32_t dcon_race_size();
]]

---race: FFI arrays---
---@type (string)[]
DATA.race_name= {}
---@type (string)[]
DATA.race_icon= {}
---@type (nil|PortraitSet)[]
DATA.race_female_portrait= {}
---@type (nil|PortraitSet)[]
DATA.race_male_portrait= {}
---@type (string)[]
DATA.race_description= {}

---race: LUA bindings---

DATA.race_size = 15
DCON.dcon_race_resize_female_efficiency(11)
DCON.dcon_race_resize_male_efficiency(11)
DCON.dcon_race_resize_female_needs(21)
DCON.dcon_race_resize_male_needs(21)
---@return race_id
function DATA.create_race()
    ---@type race_id
    local i  = DCON.dcon_create_race() + 1
    return i --[[@as race_id]] 
end
---@param func fun(item: race_id) 
function DATA.for_each_race(func)
    ---@type number
    local range = DCON.dcon_race_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as race_id]])
    end
end
---@param func fun(item: race_id):boolean 
---@return table<race_id, race_id> 
function DATA.filter_race(func)
    ---@type table<race_id, race_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_race_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as race_id]]) then t[i + 1 --[[@as race_id]]] = t[i + 1 --[[@as race_id]]] end
    end
    return t
end

---@param race_id race_id valid race id
---@return string name 
function DATA.race_get_name(race_id)
    return DATA.race_name[race_id]
end
---@param race_id race_id valid race id
---@param value string valid string
function DATA.race_set_name(race_id, value)
    DATA.race_name[race_id] = value
end
---@param race_id race_id valid race id
---@return string icon 
function DATA.race_get_icon(race_id)
    return DATA.race_icon[race_id]
end
---@param race_id race_id valid race id
---@param value string valid string
function DATA.race_set_icon(race_id, value)
    DATA.race_icon[race_id] = value
end
---@param race_id race_id valid race id
---@return nil|PortraitSet female_portrait 
function DATA.race_get_female_portrait(race_id)
    return DATA.race_female_portrait[race_id]
end
---@param race_id race_id valid race id
---@param value nil|PortraitSet valid nil|PortraitSet
function DATA.race_set_female_portrait(race_id, value)
    DATA.race_female_portrait[race_id] = value
end
---@param race_id race_id valid race id
---@return nil|PortraitSet male_portrait 
function DATA.race_get_male_portrait(race_id)
    return DATA.race_male_portrait[race_id]
end
---@param race_id race_id valid race id
---@param value nil|PortraitSet valid nil|PortraitSet
function DATA.race_set_male_portrait(race_id, value)
    DATA.race_male_portrait[race_id] = value
end
---@param race_id race_id valid race id
---@return string description 
function DATA.race_get_description(race_id)
    return DATA.race_description[race_id]
end
---@param race_id race_id valid race id
---@param value string valid string
function DATA.race_set_description(race_id, value)
    DATA.race_description[race_id] = value
end
---@param race_id race_id valid race id
---@return number r 
function DATA.race_get_r(race_id)
    return DCON.dcon_race_get_r(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_r(race_id, value)
    DCON.dcon_race_set_r(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_r(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_r(race_id - 1)
    DCON.dcon_race_set_r(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number g 
function DATA.race_get_g(race_id)
    return DCON.dcon_race_get_g(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_g(race_id, value)
    DCON.dcon_race_set_g(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_g(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_g(race_id - 1)
    DCON.dcon_race_set_g(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number b 
function DATA.race_get_b(race_id)
    return DCON.dcon_race_get_b(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_b(race_id, value)
    DCON.dcon_race_set_b(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_b(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_b(race_id - 1)
    DCON.dcon_race_set_b(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number carrying_capacity_weight 
function DATA.race_get_carrying_capacity_weight(race_id)
    return DCON.dcon_race_get_carrying_capacity_weight(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_carrying_capacity_weight(race_id, value)
    DCON.dcon_race_set_carrying_capacity_weight(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_carrying_capacity_weight(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_carrying_capacity_weight(race_id - 1)
    DCON.dcon_race_set_carrying_capacity_weight(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number fecundity 
function DATA.race_get_fecundity(race_id)
    return DCON.dcon_race_get_fecundity(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_fecundity(race_id, value)
    DCON.dcon_race_set_fecundity(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_fecundity(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_fecundity(race_id - 1)
    DCON.dcon_race_set_fecundity(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number spotting How good is this unit at scouting
function DATA.race_get_spotting(race_id)
    return DCON.dcon_race_get_spotting(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_spotting(race_id, value)
    DCON.dcon_race_set_spotting(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_spotting(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_spotting(race_id - 1)
    DCON.dcon_race_set_spotting(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number visibility How visible is this unit in battles
function DATA.race_get_visibility(race_id)
    return DCON.dcon_race_get_visibility(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_visibility(race_id, value)
    DCON.dcon_race_set_visibility(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_visibility(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_visibility(race_id - 1)
    DCON.dcon_race_set_visibility(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number males_per_hundred_females 
function DATA.race_get_males_per_hundred_females(race_id)
    return DCON.dcon_race_get_males_per_hundred_females(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_males_per_hundred_females(race_id, value)
    DCON.dcon_race_set_males_per_hundred_females(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_males_per_hundred_females(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_males_per_hundred_females(race_id - 1)
    DCON.dcon_race_set_males_per_hundred_females(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number child_age 
function DATA.race_get_child_age(race_id)
    return DCON.dcon_race_get_child_age(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_child_age(race_id, value)
    DCON.dcon_race_set_child_age(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_child_age(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_child_age(race_id - 1)
    DCON.dcon_race_set_child_age(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number teen_age 
function DATA.race_get_teen_age(race_id)
    return DCON.dcon_race_get_teen_age(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_teen_age(race_id, value)
    DCON.dcon_race_set_teen_age(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_teen_age(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_teen_age(race_id - 1)
    DCON.dcon_race_set_teen_age(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number adult_age 
function DATA.race_get_adult_age(race_id)
    return DCON.dcon_race_get_adult_age(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_adult_age(race_id, value)
    DCON.dcon_race_set_adult_age(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_adult_age(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_adult_age(race_id - 1)
    DCON.dcon_race_set_adult_age(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number middle_age 
function DATA.race_get_middle_age(race_id)
    return DCON.dcon_race_get_middle_age(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_middle_age(race_id, value)
    DCON.dcon_race_set_middle_age(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_middle_age(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_middle_age(race_id - 1)
    DCON.dcon_race_set_middle_age(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number elder_age 
function DATA.race_get_elder_age(race_id)
    return DCON.dcon_race_get_elder_age(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_elder_age(race_id, value)
    DCON.dcon_race_set_elder_age(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_elder_age(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_elder_age(race_id - 1)
    DCON.dcon_race_set_elder_age(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number max_age 
function DATA.race_get_max_age(race_id)
    return DCON.dcon_race_get_max_age(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_max_age(race_id, value)
    DCON.dcon_race_set_max_age(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_max_age(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_max_age(race_id - 1)
    DCON.dcon_race_set_max_age(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number minimum_comfortable_temperature 
function DATA.race_get_minimum_comfortable_temperature(race_id)
    return DCON.dcon_race_get_minimum_comfortable_temperature(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_minimum_comfortable_temperature(race_id, value)
    DCON.dcon_race_set_minimum_comfortable_temperature(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_minimum_comfortable_temperature(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_minimum_comfortable_temperature(race_id - 1)
    DCON.dcon_race_set_minimum_comfortable_temperature(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number minimum_absolute_temperature 
function DATA.race_get_minimum_absolute_temperature(race_id)
    return DCON.dcon_race_get_minimum_absolute_temperature(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_minimum_absolute_temperature(race_id, value)
    DCON.dcon_race_set_minimum_absolute_temperature(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_minimum_absolute_temperature(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_minimum_absolute_temperature(race_id - 1)
    DCON.dcon_race_set_minimum_absolute_temperature(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number minimum_comfortable_elevation 
function DATA.race_get_minimum_comfortable_elevation(race_id)
    return DCON.dcon_race_get_minimum_comfortable_elevation(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_minimum_comfortable_elevation(race_id, value)
    DCON.dcon_race_set_minimum_comfortable_elevation(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_minimum_comfortable_elevation(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_minimum_comfortable_elevation(race_id - 1)
    DCON.dcon_race_set_minimum_comfortable_elevation(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number female_body_size 
function DATA.race_get_female_body_size(race_id)
    return DCON.dcon_race_get_female_body_size(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_female_body_size(race_id, value)
    DCON.dcon_race_set_female_body_size(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_female_body_size(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_female_body_size(race_id - 1)
    DCON.dcon_race_set_female_body_size(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number male_body_size 
function DATA.race_get_male_body_size(race_id)
    return DCON.dcon_race_get_male_body_size(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_male_body_size(race_id, value)
    DCON.dcon_race_set_male_body_size(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_male_body_size(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_male_body_size(race_id - 1)
    DCON.dcon_race_set_male_body_size(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@param index JOBTYPE valid
---@return number female_efficiency 
function DATA.race_get_female_efficiency(race_id, index)
    assert(index ~= 0)
    return DCON.dcon_race_get_female_efficiency(race_id - 1, index)
end
---@param race_id race_id valid race id
---@param index JOBTYPE valid index
---@param value number valid number
function DATA.race_set_female_efficiency(race_id, index, value)
    DCON.dcon_race_set_female_efficiency(race_id - 1, index, value)
end
---@param race_id race_id valid race id
---@param index JOBTYPE valid index
---@param value number valid number
function DATA.race_inc_female_efficiency(race_id, index, value)
    ---@type number
    local current = DCON.dcon_race_get_female_efficiency(race_id - 1, index)
    DCON.dcon_race_set_female_efficiency(race_id - 1, index, current + value)
end
---@param race_id race_id valid race id
---@param index JOBTYPE valid
---@return number male_efficiency 
function DATA.race_get_male_efficiency(race_id, index)
    assert(index ~= 0)
    return DCON.dcon_race_get_male_efficiency(race_id - 1, index)
end
---@param race_id race_id valid race id
---@param index JOBTYPE valid index
---@param value number valid number
function DATA.race_set_male_efficiency(race_id, index, value)
    DCON.dcon_race_set_male_efficiency(race_id - 1, index, value)
end
---@param race_id race_id valid race id
---@param index JOBTYPE valid index
---@param value number valid number
function DATA.race_inc_male_efficiency(race_id, index, value)
    ---@type number
    local current = DCON.dcon_race_get_male_efficiency(race_id - 1, index)
    DCON.dcon_race_set_male_efficiency(race_id - 1, index, current + value)
end
---@param race_id race_id valid race id
---@return number female_infrastructure_needs 
function DATA.race_get_female_infrastructure_needs(race_id)
    return DCON.dcon_race_get_female_infrastructure_needs(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_female_infrastructure_needs(race_id, value)
    DCON.dcon_race_set_female_infrastructure_needs(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_female_infrastructure_needs(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_female_infrastructure_needs(race_id - 1)
    DCON.dcon_race_set_female_infrastructure_needs(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@return number male_infrastructure_needs 
function DATA.race_get_male_infrastructure_needs(race_id)
    return DCON.dcon_race_get_male_infrastructure_needs(race_id - 1)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_set_male_infrastructure_needs(race_id, value)
    DCON.dcon_race_set_male_infrastructure_needs(race_id - 1, value)
end
---@param race_id race_id valid race id
---@param value number valid number
function DATA.race_inc_male_infrastructure_needs(race_id, value)
    ---@type number
    local current = DCON.dcon_race_get_male_infrastructure_needs(race_id - 1)
    DCON.dcon_race_set_male_infrastructure_needs(race_id - 1, current + value)
end
---@param race_id race_id valid race id
---@param index number valid
---@return NEED female_needs 
function DATA.race_get_female_needs_need(race_id, index)
    assert(index ~= 0)
    return DCON.dcon_race_get_female_needs(race_id - 1, index - 1)[0].need
end
---@param race_id race_id valid race id
---@param index number valid
---@return use_case_id female_needs 
function DATA.race_get_female_needs_use_case(race_id, index)
    assert(index ~= 0)
    return DCON.dcon_race_get_female_needs(race_id - 1, index - 1)[0].use_case
end
---@param race_id race_id valid race id
---@param index number valid
---@return number female_needs 
function DATA.race_get_female_needs_required(race_id, index)
    assert(index ~= 0)
    return DCON.dcon_race_get_female_needs(race_id - 1, index - 1)[0].required
end
---@param race_id race_id valid race id
---@param index number valid index
---@param value NEED valid NEED
function DATA.race_set_female_needs_need(race_id, index, value)
    DCON.dcon_race_get_female_needs(race_id - 1, index - 1)[0].need = value
end
---@param race_id race_id valid race id
---@param index number valid index
---@param value use_case_id valid use_case_id
function DATA.race_set_female_needs_use_case(race_id, index, value)
    DCON.dcon_race_get_female_needs(race_id - 1, index - 1)[0].use_case = value
end
---@param race_id race_id valid race id
---@param index number valid index
---@param value number valid number
function DATA.race_set_female_needs_required(race_id, index, value)
    DCON.dcon_race_get_female_needs(race_id - 1, index - 1)[0].required = value
end
---@param race_id race_id valid race id
---@param index number valid index
---@param value number valid number
function DATA.race_inc_female_needs_required(race_id, index, value)
    ---@type number
    local current = DCON.dcon_race_get_female_needs(race_id - 1, index - 1)[0].required
    DCON.dcon_race_get_female_needs(race_id - 1, index - 1)[0].required = current + value
end
---@param race_id race_id valid race id
---@param index number valid
---@return NEED male_needs 
function DATA.race_get_male_needs_need(race_id, index)
    assert(index ~= 0)
    return DCON.dcon_race_get_male_needs(race_id - 1, index - 1)[0].need
end
---@param race_id race_id valid race id
---@param index number valid
---@return use_case_id male_needs 
function DATA.race_get_male_needs_use_case(race_id, index)
    assert(index ~= 0)
    return DCON.dcon_race_get_male_needs(race_id - 1, index - 1)[0].use_case
end
---@param race_id race_id valid race id
---@param index number valid
---@return number male_needs 
function DATA.race_get_male_needs_required(race_id, index)
    assert(index ~= 0)
    return DCON.dcon_race_get_male_needs(race_id - 1, index - 1)[0].required
end
---@param race_id race_id valid race id
---@param index number valid index
---@param value NEED valid NEED
function DATA.race_set_male_needs_need(race_id, index, value)
    DCON.dcon_race_get_male_needs(race_id - 1, index - 1)[0].need = value
end
---@param race_id race_id valid race id
---@param index number valid index
---@param value use_case_id valid use_case_id
function DATA.race_set_male_needs_use_case(race_id, index, value)
    DCON.dcon_race_get_male_needs(race_id - 1, index - 1)[0].use_case = value
end
---@param race_id race_id valid race id
---@param index number valid index
---@param value number valid number
function DATA.race_set_male_needs_required(race_id, index, value)
    DCON.dcon_race_get_male_needs(race_id - 1, index - 1)[0].required = value
end
---@param race_id race_id valid race id
---@param index number valid index
---@param value number valid number
function DATA.race_inc_male_needs_required(race_id, index, value)
    ---@type number
    local current = DCON.dcon_race_get_male_needs(race_id - 1, index - 1)[0].required
    DCON.dcon_race_get_male_needs(race_id - 1, index - 1)[0].required = current + value
end
---@param race_id race_id valid race id
---@return boolean requires_large_river 
function DATA.race_get_requires_large_river(race_id)
    return DCON.dcon_race_get_requires_large_river(race_id - 1)
end
---@param race_id race_id valid race id
---@param value boolean valid boolean
function DATA.race_set_requires_large_river(race_id, value)
    DCON.dcon_race_set_requires_large_river(race_id - 1, value)
end
---@param race_id race_id valid race id
---@return boolean requires_large_forest 
function DATA.race_get_requires_large_forest(race_id)
    return DCON.dcon_race_get_requires_large_forest(race_id - 1)
end
---@param race_id race_id valid race id
---@param value boolean valid boolean
function DATA.race_set_requires_large_forest(race_id, value)
    DCON.dcon_race_set_requires_large_forest(race_id - 1, value)
end

local fat_race_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.race_get_name(t.id) end
        if (k == "icon") then return DATA.race_get_icon(t.id) end
        if (k == "female_portrait") then return DATA.race_get_female_portrait(t.id) end
        if (k == "male_portrait") then return DATA.race_get_male_portrait(t.id) end
        if (k == "description") then return DATA.race_get_description(t.id) end
        if (k == "r") then return DATA.race_get_r(t.id) end
        if (k == "g") then return DATA.race_get_g(t.id) end
        if (k == "b") then return DATA.race_get_b(t.id) end
        if (k == "carrying_capacity_weight") then return DATA.race_get_carrying_capacity_weight(t.id) end
        if (k == "fecundity") then return DATA.race_get_fecundity(t.id) end
        if (k == "spotting") then return DATA.race_get_spotting(t.id) end
        if (k == "visibility") then return DATA.race_get_visibility(t.id) end
        if (k == "males_per_hundred_females") then return DATA.race_get_males_per_hundred_females(t.id) end
        if (k == "child_age") then return DATA.race_get_child_age(t.id) end
        if (k == "teen_age") then return DATA.race_get_teen_age(t.id) end
        if (k == "adult_age") then return DATA.race_get_adult_age(t.id) end
        if (k == "middle_age") then return DATA.race_get_middle_age(t.id) end
        if (k == "elder_age") then return DATA.race_get_elder_age(t.id) end
        if (k == "max_age") then return DATA.race_get_max_age(t.id) end
        if (k == "minimum_comfortable_temperature") then return DATA.race_get_minimum_comfortable_temperature(t.id) end
        if (k == "minimum_absolute_temperature") then return DATA.race_get_minimum_absolute_temperature(t.id) end
        if (k == "minimum_comfortable_elevation") then return DATA.race_get_minimum_comfortable_elevation(t.id) end
        if (k == "female_body_size") then return DATA.race_get_female_body_size(t.id) end
        if (k == "male_body_size") then return DATA.race_get_male_body_size(t.id) end
        if (k == "female_infrastructure_needs") then return DATA.race_get_female_infrastructure_needs(t.id) end
        if (k == "male_infrastructure_needs") then return DATA.race_get_male_infrastructure_needs(t.id) end
        if (k == "requires_large_river") then return DATA.race_get_requires_large_river(t.id) end
        if (k == "requires_large_forest") then return DATA.race_get_requires_large_forest(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.race_set_name(t.id, v)
            return
        end
        if (k == "icon") then
            DATA.race_set_icon(t.id, v)
            return
        end
        if (k == "female_portrait") then
            DATA.race_set_female_portrait(t.id, v)
            return
        end
        if (k == "male_portrait") then
            DATA.race_set_male_portrait(t.id, v)
            return
        end
        if (k == "description") then
            DATA.race_set_description(t.id, v)
            return
        end
        if (k == "r") then
            DATA.race_set_r(t.id, v)
            return
        end
        if (k == "g") then
            DATA.race_set_g(t.id, v)
            return
        end
        if (k == "b") then
            DATA.race_set_b(t.id, v)
            return
        end
        if (k == "carrying_capacity_weight") then
            DATA.race_set_carrying_capacity_weight(t.id, v)
            return
        end
        if (k == "fecundity") then
            DATA.race_set_fecundity(t.id, v)
            return
        end
        if (k == "spotting") then
            DATA.race_set_spotting(t.id, v)
            return
        end
        if (k == "visibility") then
            DATA.race_set_visibility(t.id, v)
            return
        end
        if (k == "males_per_hundred_females") then
            DATA.race_set_males_per_hundred_females(t.id, v)
            return
        end
        if (k == "child_age") then
            DATA.race_set_child_age(t.id, v)
            return
        end
        if (k == "teen_age") then
            DATA.race_set_teen_age(t.id, v)
            return
        end
        if (k == "adult_age") then
            DATA.race_set_adult_age(t.id, v)
            return
        end
        if (k == "middle_age") then
            DATA.race_set_middle_age(t.id, v)
            return
        end
        if (k == "elder_age") then
            DATA.race_set_elder_age(t.id, v)
            return
        end
        if (k == "max_age") then
            DATA.race_set_max_age(t.id, v)
            return
        end
        if (k == "minimum_comfortable_temperature") then
            DATA.race_set_minimum_comfortable_temperature(t.id, v)
            return
        end
        if (k == "minimum_absolute_temperature") then
            DATA.race_set_minimum_absolute_temperature(t.id, v)
            return
        end
        if (k == "minimum_comfortable_elevation") then
            DATA.race_set_minimum_comfortable_elevation(t.id, v)
            return
        end
        if (k == "female_body_size") then
            DATA.race_set_female_body_size(t.id, v)
            return
        end
        if (k == "male_body_size") then
            DATA.race_set_male_body_size(t.id, v)
            return
        end
        if (k == "female_infrastructure_needs") then
            DATA.race_set_female_infrastructure_needs(t.id, v)
            return
        end
        if (k == "male_infrastructure_needs") then
            DATA.race_set_male_infrastructure_needs(t.id, v)
            return
        end
        if (k == "requires_large_river") then
            DATA.race_set_requires_large_river(t.id, v)
            return
        end
        if (k == "requires_large_forest") then
            DATA.race_set_requires_large_forest(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id race_id
---@return fat_race_id fat_id
function DATA.fatten_race(id)
    local result = {id = id}
    setmetatable(result, fat_race_id_metatable)
    return result --[[@as fat_race_id]]
end
