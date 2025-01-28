local ffi = require("ffi")
----------resource----------


---resource: LSP types---

---Unique identificator for resource entity
---@class (exact) resource_id : table
---@field is_resource number
---@class (exact) fat_resource_id
---@field id resource_id Unique resource id
---@field name string 
---@field icon string 
---@field description string 
---@field r number 
---@field g number 
---@field b number 
---@field base_frequency number number of tiles per which this resource is spawned
---@field coastal boolean 
---@field land boolean 
---@field water boolean 
---@field ice_age boolean requires presence of ice age ice
---@field minimum_trees number 
---@field maximum_trees number 
---@field minimum_elevation number 
---@field maximum_elevation number 

---@class struct_resource
---@field r number 
---@field g number 
---@field b number 
---@field required_biome table<number, biome_id> 
---@field required_bedrock table<number, bedrock_id> 
---@field base_frequency number number of tiles per which this resource is spawned
---@field coastal boolean 
---@field land boolean 
---@field water boolean 
---@field ice_age boolean requires presence of ice age ice
---@field minimum_trees number 
---@field maximum_trees number 
---@field minimum_elevation number 
---@field maximum_elevation number 

---@class (exact) resource_id_data_blob_definition
---@field name string 
---@field icon string 
---@field description string 
---@field r number 
---@field g number 
---@field b number 
---@field required_biome biome_id[] 
---@field required_bedrock bedrock_id[] 
---@field base_frequency number? number of tiles per which this resource is spawned
---@field coastal boolean? 
---@field land boolean? 
---@field water boolean? 
---@field ice_age boolean? requires presence of ice age ice
---@field minimum_trees number? 
---@field maximum_trees number? 
---@field minimum_elevation number? 
---@field maximum_elevation number? 
---Sets values of resource for given id
---@param id resource_id
---@param data resource_id_data_blob_definition
function DATA.setup_resource(id, data)
    DATA.resource_set_base_frequency(id, 1000)
    DATA.resource_set_coastal(id, false)
    DATA.resource_set_land(id, true)
    DATA.resource_set_water(id, false)
    DATA.resource_set_ice_age(id, false)
    DATA.resource_set_minimum_trees(id, 0)
    DATA.resource_set_maximum_trees(id, 1)
    DATA.resource_set_minimum_elevation(id, -math.huge)
    DATA.resource_set_maximum_elevation(id, math.huge)
    DATA.resource_set_name(id, data.name)
    DATA.resource_set_icon(id, data.icon)
    DATA.resource_set_description(id, data.description)
    DATA.resource_set_r(id, data.r)
    DATA.resource_set_g(id, data.g)
    DATA.resource_set_b(id, data.b)
    for i, value in pairs(data.required_biome) do
        DATA.resource_set_required_biome(id, i, value)
    end
    for i, value in pairs(data.required_bedrock) do
        DATA.resource_set_required_bedrock(id, i, value)
    end
    if data.base_frequency ~= nil then
        DATA.resource_set_base_frequency(id, data.base_frequency)
    end
    if data.coastal ~= nil then
        DATA.resource_set_coastal(id, data.coastal)
    end
    if data.land ~= nil then
        DATA.resource_set_land(id, data.land)
    end
    if data.water ~= nil then
        DATA.resource_set_water(id, data.water)
    end
    if data.ice_age ~= nil then
        DATA.resource_set_ice_age(id, data.ice_age)
    end
    if data.minimum_trees ~= nil then
        DATA.resource_set_minimum_trees(id, data.minimum_trees)
    end
    if data.maximum_trees ~= nil then
        DATA.resource_set_maximum_trees(id, data.maximum_trees)
    end
    if data.minimum_elevation ~= nil then
        DATA.resource_set_minimum_elevation(id, data.minimum_elevation)
    end
    if data.maximum_elevation ~= nil then
        DATA.resource_set_maximum_elevation(id, data.maximum_elevation)
    end
end

ffi.cdef[[
void dcon_resource_set_r(int32_t, float);
float dcon_resource_get_r(int32_t);
void dcon_resource_set_g(int32_t, float);
float dcon_resource_get_g(int32_t);
void dcon_resource_set_b(int32_t, float);
float dcon_resource_get_b(int32_t);
void dcon_resource_resize_required_biome(uint32_t);
void dcon_resource_set_required_biome(int32_t, int32_t, int32_t);
int32_t dcon_resource_get_required_biome(int32_t, int32_t);
void dcon_resource_resize_required_bedrock(uint32_t);
void dcon_resource_set_required_bedrock(int32_t, int32_t, int32_t);
int32_t dcon_resource_get_required_bedrock(int32_t, int32_t);
void dcon_resource_set_base_frequency(int32_t, float);
float dcon_resource_get_base_frequency(int32_t);
void dcon_resource_set_coastal(int32_t, bool);
bool dcon_resource_get_coastal(int32_t);
void dcon_resource_set_land(int32_t, bool);
bool dcon_resource_get_land(int32_t);
void dcon_resource_set_water(int32_t, bool);
bool dcon_resource_get_water(int32_t);
void dcon_resource_set_ice_age(int32_t, bool);
bool dcon_resource_get_ice_age(int32_t);
void dcon_resource_set_minimum_trees(int32_t, float);
float dcon_resource_get_minimum_trees(int32_t);
void dcon_resource_set_maximum_trees(int32_t, float);
float dcon_resource_get_maximum_trees(int32_t);
void dcon_resource_set_minimum_elevation(int32_t, float);
float dcon_resource_get_minimum_elevation(int32_t);
void dcon_resource_set_maximum_elevation(int32_t, float);
float dcon_resource_get_maximum_elevation(int32_t);
int32_t dcon_create_resource();
bool dcon_resource_is_valid(int32_t);
void dcon_resource_resize(uint32_t sz);
uint32_t dcon_resource_size();
]]

---resource: FFI arrays---
---@type (string)[]
DATA.resource_name= {}
---@type (string)[]
DATA.resource_icon= {}
---@type (string)[]
DATA.resource_description= {}

---resource: LUA bindings---

DATA.resource_size = 300
DCON.dcon_resource_resize_required_biome(21)
DCON.dcon_resource_resize_required_bedrock(21)
---@return resource_id
function DATA.create_resource()
    ---@type resource_id
    local i  = DCON.dcon_create_resource() + 1
    return i --[[@as resource_id]] 
end
---@param func fun(item: resource_id) 
function DATA.for_each_resource(func)
    ---@type number
    local range = DCON.dcon_resource_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as resource_id]])
    end
end
---@param func fun(item: resource_id):boolean 
---@return table<resource_id, resource_id> 
function DATA.filter_resource(func)
    ---@type table<resource_id, resource_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_resource_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as resource_id]]) then t[i + 1 --[[@as resource_id]]] = t[i + 1 --[[@as resource_id]]] end
    end
    return t
end

---@param resource_id resource_id valid resource id
---@return string name 
function DATA.resource_get_name(resource_id)
    return DATA.resource_name[resource_id]
end
---@param resource_id resource_id valid resource id
---@param value string valid string
function DATA.resource_set_name(resource_id, value)
    DATA.resource_name[resource_id] = value
end
---@param resource_id resource_id valid resource id
---@return string icon 
function DATA.resource_get_icon(resource_id)
    return DATA.resource_icon[resource_id]
end
---@param resource_id resource_id valid resource id
---@param value string valid string
function DATA.resource_set_icon(resource_id, value)
    DATA.resource_icon[resource_id] = value
end
---@param resource_id resource_id valid resource id
---@return string description 
function DATA.resource_get_description(resource_id)
    return DATA.resource_description[resource_id]
end
---@param resource_id resource_id valid resource id
---@param value string valid string
function DATA.resource_set_description(resource_id, value)
    DATA.resource_description[resource_id] = value
end
---@param resource_id resource_id valid resource id
---@return number r 
function DATA.resource_get_r(resource_id)
    return DCON.dcon_resource_get_r(resource_id - 1)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_set_r(resource_id, value)
    DCON.dcon_resource_set_r(resource_id - 1, value)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_inc_r(resource_id, value)
    ---@type number
    local current = DCON.dcon_resource_get_r(resource_id - 1)
    DCON.dcon_resource_set_r(resource_id - 1, current + value)
end
---@param resource_id resource_id valid resource id
---@return number g 
function DATA.resource_get_g(resource_id)
    return DCON.dcon_resource_get_g(resource_id - 1)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_set_g(resource_id, value)
    DCON.dcon_resource_set_g(resource_id - 1, value)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_inc_g(resource_id, value)
    ---@type number
    local current = DCON.dcon_resource_get_g(resource_id - 1)
    DCON.dcon_resource_set_g(resource_id - 1, current + value)
end
---@param resource_id resource_id valid resource id
---@return number b 
function DATA.resource_get_b(resource_id)
    return DCON.dcon_resource_get_b(resource_id - 1)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_set_b(resource_id, value)
    DCON.dcon_resource_set_b(resource_id - 1, value)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_inc_b(resource_id, value)
    ---@type number
    local current = DCON.dcon_resource_get_b(resource_id - 1)
    DCON.dcon_resource_set_b(resource_id - 1, current + value)
end
---@param resource_id resource_id valid resource id
---@param index number valid
---@return biome_id required_biome 
function DATA.resource_get_required_biome(resource_id, index)
    assert(index ~= 0)
    return DCON.dcon_resource_get_required_biome(resource_id - 1, index - 1) + 1
end
---@param resource_id resource_id valid resource id
---@param index number valid index
---@param value biome_id valid biome_id
function DATA.resource_set_required_biome(resource_id, index, value)
    DCON.dcon_resource_set_required_biome(resource_id - 1, index - 1, value - 1)
end
---@param resource_id resource_id valid resource id
---@param index number valid
---@return bedrock_id required_bedrock 
function DATA.resource_get_required_bedrock(resource_id, index)
    assert(index ~= 0)
    return DCON.dcon_resource_get_required_bedrock(resource_id - 1, index - 1) + 1
end
---@param resource_id resource_id valid resource id
---@param index number valid index
---@param value bedrock_id valid bedrock_id
function DATA.resource_set_required_bedrock(resource_id, index, value)
    DCON.dcon_resource_set_required_bedrock(resource_id - 1, index - 1, value - 1)
end
---@param resource_id resource_id valid resource id
---@return number base_frequency number of tiles per which this resource is spawned
function DATA.resource_get_base_frequency(resource_id)
    return DCON.dcon_resource_get_base_frequency(resource_id - 1)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_set_base_frequency(resource_id, value)
    DCON.dcon_resource_set_base_frequency(resource_id - 1, value)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_inc_base_frequency(resource_id, value)
    ---@type number
    local current = DCON.dcon_resource_get_base_frequency(resource_id - 1)
    DCON.dcon_resource_set_base_frequency(resource_id - 1, current + value)
end
---@param resource_id resource_id valid resource id
---@return boolean coastal 
function DATA.resource_get_coastal(resource_id)
    return DCON.dcon_resource_get_coastal(resource_id - 1)
end
---@param resource_id resource_id valid resource id
---@param value boolean valid boolean
function DATA.resource_set_coastal(resource_id, value)
    DCON.dcon_resource_set_coastal(resource_id - 1, value)
end
---@param resource_id resource_id valid resource id
---@return boolean land 
function DATA.resource_get_land(resource_id)
    return DCON.dcon_resource_get_land(resource_id - 1)
end
---@param resource_id resource_id valid resource id
---@param value boolean valid boolean
function DATA.resource_set_land(resource_id, value)
    DCON.dcon_resource_set_land(resource_id - 1, value)
end
---@param resource_id resource_id valid resource id
---@return boolean water 
function DATA.resource_get_water(resource_id)
    return DCON.dcon_resource_get_water(resource_id - 1)
end
---@param resource_id resource_id valid resource id
---@param value boolean valid boolean
function DATA.resource_set_water(resource_id, value)
    DCON.dcon_resource_set_water(resource_id - 1, value)
end
---@param resource_id resource_id valid resource id
---@return boolean ice_age requires presence of ice age ice
function DATA.resource_get_ice_age(resource_id)
    return DCON.dcon_resource_get_ice_age(resource_id - 1)
end
---@param resource_id resource_id valid resource id
---@param value boolean valid boolean
function DATA.resource_set_ice_age(resource_id, value)
    DCON.dcon_resource_set_ice_age(resource_id - 1, value)
end
---@param resource_id resource_id valid resource id
---@return number minimum_trees 
function DATA.resource_get_minimum_trees(resource_id)
    return DCON.dcon_resource_get_minimum_trees(resource_id - 1)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_set_minimum_trees(resource_id, value)
    DCON.dcon_resource_set_minimum_trees(resource_id - 1, value)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_inc_minimum_trees(resource_id, value)
    ---@type number
    local current = DCON.dcon_resource_get_minimum_trees(resource_id - 1)
    DCON.dcon_resource_set_minimum_trees(resource_id - 1, current + value)
end
---@param resource_id resource_id valid resource id
---@return number maximum_trees 
function DATA.resource_get_maximum_trees(resource_id)
    return DCON.dcon_resource_get_maximum_trees(resource_id - 1)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_set_maximum_trees(resource_id, value)
    DCON.dcon_resource_set_maximum_trees(resource_id - 1, value)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_inc_maximum_trees(resource_id, value)
    ---@type number
    local current = DCON.dcon_resource_get_maximum_trees(resource_id - 1)
    DCON.dcon_resource_set_maximum_trees(resource_id - 1, current + value)
end
---@param resource_id resource_id valid resource id
---@return number minimum_elevation 
function DATA.resource_get_minimum_elevation(resource_id)
    return DCON.dcon_resource_get_minimum_elevation(resource_id - 1)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_set_minimum_elevation(resource_id, value)
    DCON.dcon_resource_set_minimum_elevation(resource_id - 1, value)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_inc_minimum_elevation(resource_id, value)
    ---@type number
    local current = DCON.dcon_resource_get_minimum_elevation(resource_id - 1)
    DCON.dcon_resource_set_minimum_elevation(resource_id - 1, current + value)
end
---@param resource_id resource_id valid resource id
---@return number maximum_elevation 
function DATA.resource_get_maximum_elevation(resource_id)
    return DCON.dcon_resource_get_maximum_elevation(resource_id - 1)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_set_maximum_elevation(resource_id, value)
    DCON.dcon_resource_set_maximum_elevation(resource_id - 1, value)
end
---@param resource_id resource_id valid resource id
---@param value number valid number
function DATA.resource_inc_maximum_elevation(resource_id, value)
    ---@type number
    local current = DCON.dcon_resource_get_maximum_elevation(resource_id - 1)
    DCON.dcon_resource_set_maximum_elevation(resource_id - 1, current + value)
end

local fat_resource_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.resource_get_name(t.id) end
        if (k == "icon") then return DATA.resource_get_icon(t.id) end
        if (k == "description") then return DATA.resource_get_description(t.id) end
        if (k == "r") then return DATA.resource_get_r(t.id) end
        if (k == "g") then return DATA.resource_get_g(t.id) end
        if (k == "b") then return DATA.resource_get_b(t.id) end
        if (k == "base_frequency") then return DATA.resource_get_base_frequency(t.id) end
        if (k == "coastal") then return DATA.resource_get_coastal(t.id) end
        if (k == "land") then return DATA.resource_get_land(t.id) end
        if (k == "water") then return DATA.resource_get_water(t.id) end
        if (k == "ice_age") then return DATA.resource_get_ice_age(t.id) end
        if (k == "minimum_trees") then return DATA.resource_get_minimum_trees(t.id) end
        if (k == "maximum_trees") then return DATA.resource_get_maximum_trees(t.id) end
        if (k == "minimum_elevation") then return DATA.resource_get_minimum_elevation(t.id) end
        if (k == "maximum_elevation") then return DATA.resource_get_maximum_elevation(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.resource_set_name(t.id, v)
            return
        end
        if (k == "icon") then
            DATA.resource_set_icon(t.id, v)
            return
        end
        if (k == "description") then
            DATA.resource_set_description(t.id, v)
            return
        end
        if (k == "r") then
            DATA.resource_set_r(t.id, v)
            return
        end
        if (k == "g") then
            DATA.resource_set_g(t.id, v)
            return
        end
        if (k == "b") then
            DATA.resource_set_b(t.id, v)
            return
        end
        if (k == "base_frequency") then
            DATA.resource_set_base_frequency(t.id, v)
            return
        end
        if (k == "coastal") then
            DATA.resource_set_coastal(t.id, v)
            return
        end
        if (k == "land") then
            DATA.resource_set_land(t.id, v)
            return
        end
        if (k == "water") then
            DATA.resource_set_water(t.id, v)
            return
        end
        if (k == "ice_age") then
            DATA.resource_set_ice_age(t.id, v)
            return
        end
        if (k == "minimum_trees") then
            DATA.resource_set_minimum_trees(t.id, v)
            return
        end
        if (k == "maximum_trees") then
            DATA.resource_set_maximum_trees(t.id, v)
            return
        end
        if (k == "minimum_elevation") then
            DATA.resource_set_minimum_elevation(t.id, v)
            return
        end
        if (k == "maximum_elevation") then
            DATA.resource_set_maximum_elevation(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id resource_id
---@return fat_resource_id fat_id
function DATA.fatten_resource(id)
    local result = {id = id}
    setmetatable(result, fat_resource_id_metatable)
    return result --[[@as fat_resource_id]]
end
