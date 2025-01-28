local ffi = require("ffi")
----------building_type----------


---building_type: LSP types---

---Unique identificator for building_type entity
---@class (exact) building_type_id : table
---@field is_building_type number
---@class (exact) fat_building_type_id
---@field id building_type_id Unique building_type id
---@field name string 
---@field icon string 
---@field description string 
---@field r number 
---@field g number 
---@field b number 
---@field production_method production_method_id 
---@field construction_cost number 
---@field upkeep number 
---@field unique boolean only one per province!
---@field movable boolean is it possible to migrate with this building?
---@field government boolean only the government can build this building!
---@field needed_infrastructure number 
---@field spotting number The amount of "spotting" a building provides. Spotting is used in warfare. Higher spotting makes it more difficult for foreign armies to sneak in.

---@class struct_building_type
---@field r number 
---@field g number 
---@field b number 
---@field production_method production_method_id 
---@field construction_cost number 
---@field upkeep number 
---@field required_biome table<number, biome_id> 
---@field required_resource table<number, resource_id> 
---@field unique boolean only one per province!
---@field movable boolean is it possible to migrate with this building?
---@field government boolean only the government can build this building!
---@field needed_infrastructure number 
---@field spotting number The amount of "spotting" a building provides. Spotting is used in warfare. Higher spotting makes it more difficult for foreign armies to sneak in.

---@class (exact) building_type_id_data_blob_definition
---@field name string 
---@field icon string 
---@field description string 
---@field r number 
---@field g number 
---@field b number 
---@field production_method production_method_id 
---@field archetype BUILDING_ARCHETYPE 
---@field unlocked_by technology_id 
---@field construction_cost number 
---@field upkeep number? 
---@field required_biome biome_id[] 
---@field required_resource resource_id[] 
---@field unique boolean? only one per province!
---@field movable boolean? is it possible to migrate with this building?
---@field government boolean? only the government can build this building!
---@field needed_infrastructure number? 
---@field spotting number? The amount of "spotting" a building provides. Spotting is used in warfare. Higher spotting makes it more difficult for foreign armies to sneak in.
---Sets values of building_type for given id
---@param id building_type_id
---@param data building_type_id_data_blob_definition
function DATA.setup_building_type(id, data)
    DATA.building_type_set_upkeep(id, 0)
    DATA.building_type_set_unique(id, false)
    DATA.building_type_set_movable(id, false)
    DATA.building_type_set_government(id, false)
    DATA.building_type_set_needed_infrastructure(id, 0)
    DATA.building_type_set_spotting(id, 0)
    DATA.building_type_set_name(id, data.name)
    DATA.building_type_set_icon(id, data.icon)
    DATA.building_type_set_description(id, data.description)
    DATA.building_type_set_r(id, data.r)
    DATA.building_type_set_g(id, data.g)
    DATA.building_type_set_b(id, data.b)
    DATA.building_type_set_production_method(id, data.production_method)
    DATA.building_type_set_construction_cost(id, data.construction_cost)
    if data.upkeep ~= nil then
        DATA.building_type_set_upkeep(id, data.upkeep)
    end
    for i, value in pairs(data.required_biome) do
        DATA.building_type_set_required_biome(id, i, value)
    end
    for i, value in pairs(data.required_resource) do
        DATA.building_type_set_required_resource(id, i, value)
    end
    if data.unique ~= nil then
        DATA.building_type_set_unique(id, data.unique)
    end
    if data.movable ~= nil then
        DATA.building_type_set_movable(id, data.movable)
    end
    if data.government ~= nil then
        DATA.building_type_set_government(id, data.government)
    end
    if data.needed_infrastructure ~= nil then
        DATA.building_type_set_needed_infrastructure(id, data.needed_infrastructure)
    end
    if data.spotting ~= nil then
        DATA.building_type_set_spotting(id, data.spotting)
    end
end

ffi.cdef[[
void dcon_building_type_set_r(int32_t, float);
float dcon_building_type_get_r(int32_t);
void dcon_building_type_set_g(int32_t, float);
float dcon_building_type_get_g(int32_t);
void dcon_building_type_set_b(int32_t, float);
float dcon_building_type_get_b(int32_t);
void dcon_building_type_set_production_method(int32_t, int32_t);
int32_t dcon_building_type_get_production_method(int32_t);
void dcon_building_type_set_archetype(int32_t, uint8_t);
uint8_t dcon_building_type_get_archetype(int32_t);
void dcon_building_type_set_unlocked_by(int32_t, int32_t);
int32_t dcon_building_type_get_unlocked_by(int32_t);
void dcon_building_type_set_construction_cost(int32_t, float);
float dcon_building_type_get_construction_cost(int32_t);
void dcon_building_type_set_upkeep(int32_t, float);
float dcon_building_type_get_upkeep(int32_t);
void dcon_building_type_resize_required_biome(uint32_t);
void dcon_building_type_set_required_biome(int32_t, int32_t, int32_t);
int32_t dcon_building_type_get_required_biome(int32_t, int32_t);
void dcon_building_type_resize_required_resource(uint32_t);
void dcon_building_type_set_required_resource(int32_t, int32_t, int32_t);
int32_t dcon_building_type_get_required_resource(int32_t, int32_t);
void dcon_building_type_set_unique(int32_t, bool);
bool dcon_building_type_get_unique(int32_t);
void dcon_building_type_set_movable(int32_t, bool);
bool dcon_building_type_get_movable(int32_t);
void dcon_building_type_set_government(int32_t, bool);
bool dcon_building_type_get_government(int32_t);
void dcon_building_type_set_needed_infrastructure(int32_t, float);
float dcon_building_type_get_needed_infrastructure(int32_t);
void dcon_building_type_set_spotting(int32_t, float);
float dcon_building_type_get_spotting(int32_t);
int32_t dcon_create_building_type();
bool dcon_building_type_is_valid(int32_t);
void dcon_building_type_resize(uint32_t sz);
uint32_t dcon_building_type_size();
]]

---building_type: FFI arrays---
---@type (string)[]
DATA.building_type_name= {}
---@type (string)[]
DATA.building_type_icon= {}
---@type (string)[]
DATA.building_type_description= {}

---building_type: LUA bindings---

DATA.building_type_size = 250
DCON.dcon_building_type_resize_required_biome(21)
DCON.dcon_building_type_resize_required_resource(21)
---@return building_type_id
function DATA.create_building_type()
    ---@type building_type_id
    local i  = DCON.dcon_create_building_type() + 1
    return i --[[@as building_type_id]] 
end
---@param func fun(item: building_type_id) 
function DATA.for_each_building_type(func)
    ---@type number
    local range = DCON.dcon_building_type_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as building_type_id]])
    end
end
---@param func fun(item: building_type_id):boolean 
---@return table<building_type_id, building_type_id> 
function DATA.filter_building_type(func)
    ---@type table<building_type_id, building_type_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_building_type_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as building_type_id]]) then t[i + 1 --[[@as building_type_id]]] = t[i + 1 --[[@as building_type_id]]] end
    end
    return t
end

---@param building_type_id building_type_id valid building_type id
---@return string name 
function DATA.building_type_get_name(building_type_id)
    return DATA.building_type_name[building_type_id]
end
---@param building_type_id building_type_id valid building_type id
---@param value string valid string
function DATA.building_type_set_name(building_type_id, value)
    DATA.building_type_name[building_type_id] = value
end
---@param building_type_id building_type_id valid building_type id
---@return string icon 
function DATA.building_type_get_icon(building_type_id)
    return DATA.building_type_icon[building_type_id]
end
---@param building_type_id building_type_id valid building_type id
---@param value string valid string
function DATA.building_type_set_icon(building_type_id, value)
    DATA.building_type_icon[building_type_id] = value
end
---@param building_type_id building_type_id valid building_type id
---@return string description 
function DATA.building_type_get_description(building_type_id)
    return DATA.building_type_description[building_type_id]
end
---@param building_type_id building_type_id valid building_type id
---@param value string valid string
function DATA.building_type_set_description(building_type_id, value)
    DATA.building_type_description[building_type_id] = value
end
---@param building_type_id building_type_id valid building_type id
---@return number r 
function DATA.building_type_get_r(building_type_id)
    return DCON.dcon_building_type_get_r(building_type_id - 1)
end
---@param building_type_id building_type_id valid building_type id
---@param value number valid number
function DATA.building_type_set_r(building_type_id, value)
    DCON.dcon_building_type_set_r(building_type_id - 1, value)
end
---@param building_type_id building_type_id valid building_type id
---@param value number valid number
function DATA.building_type_inc_r(building_type_id, value)
    ---@type number
    local current = DCON.dcon_building_type_get_r(building_type_id - 1)
    DCON.dcon_building_type_set_r(building_type_id - 1, current + value)
end
---@param building_type_id building_type_id valid building_type id
---@return number g 
function DATA.building_type_get_g(building_type_id)
    return DCON.dcon_building_type_get_g(building_type_id - 1)
end
---@param building_type_id building_type_id valid building_type id
---@param value number valid number
function DATA.building_type_set_g(building_type_id, value)
    DCON.dcon_building_type_set_g(building_type_id - 1, value)
end
---@param building_type_id building_type_id valid building_type id
---@param value number valid number
function DATA.building_type_inc_g(building_type_id, value)
    ---@type number
    local current = DCON.dcon_building_type_get_g(building_type_id - 1)
    DCON.dcon_building_type_set_g(building_type_id - 1, current + value)
end
---@param building_type_id building_type_id valid building_type id
---@return number b 
function DATA.building_type_get_b(building_type_id)
    return DCON.dcon_building_type_get_b(building_type_id - 1)
end
---@param building_type_id building_type_id valid building_type id
---@param value number valid number
function DATA.building_type_set_b(building_type_id, value)
    DCON.dcon_building_type_set_b(building_type_id - 1, value)
end
---@param building_type_id building_type_id valid building_type id
---@param value number valid number
function DATA.building_type_inc_b(building_type_id, value)
    ---@type number
    local current = DCON.dcon_building_type_get_b(building_type_id - 1)
    DCON.dcon_building_type_set_b(building_type_id - 1, current + value)
end
---@param building_type_id building_type_id valid building_type id
---@return production_method_id production_method 
function DATA.building_type_get_production_method(building_type_id)
    return DCON.dcon_building_type_get_production_method(building_type_id - 1) + 1
end
---@param building_type_id building_type_id valid building_type id
---@param value production_method_id valid production_method_id
function DATA.building_type_set_production_method(building_type_id, value)
    DCON.dcon_building_type_set_production_method(building_type_id - 1, value - 1)
end
---@param building_type_id building_type_id valid building_type id
---@return number construction_cost 
function DATA.building_type_get_construction_cost(building_type_id)
    return DCON.dcon_building_type_get_construction_cost(building_type_id - 1)
end
---@param building_type_id building_type_id valid building_type id
---@param value number valid number
function DATA.building_type_set_construction_cost(building_type_id, value)
    DCON.dcon_building_type_set_construction_cost(building_type_id - 1, value)
end
---@param building_type_id building_type_id valid building_type id
---@param value number valid number
function DATA.building_type_inc_construction_cost(building_type_id, value)
    ---@type number
    local current = DCON.dcon_building_type_get_construction_cost(building_type_id - 1)
    DCON.dcon_building_type_set_construction_cost(building_type_id - 1, current + value)
end
---@param building_type_id building_type_id valid building_type id
---@return number upkeep 
function DATA.building_type_get_upkeep(building_type_id)
    return DCON.dcon_building_type_get_upkeep(building_type_id - 1)
end
---@param building_type_id building_type_id valid building_type id
---@param value number valid number
function DATA.building_type_set_upkeep(building_type_id, value)
    DCON.dcon_building_type_set_upkeep(building_type_id - 1, value)
end
---@param building_type_id building_type_id valid building_type id
---@param value number valid number
function DATA.building_type_inc_upkeep(building_type_id, value)
    ---@type number
    local current = DCON.dcon_building_type_get_upkeep(building_type_id - 1)
    DCON.dcon_building_type_set_upkeep(building_type_id - 1, current + value)
end
---@param building_type_id building_type_id valid building_type id
---@param index number valid
---@return biome_id required_biome 
function DATA.building_type_get_required_biome(building_type_id, index)
    assert(index ~= 0)
    return DCON.dcon_building_type_get_required_biome(building_type_id - 1, index - 1) + 1
end
---@param building_type_id building_type_id valid building_type id
---@param index number valid index
---@param value biome_id valid biome_id
function DATA.building_type_set_required_biome(building_type_id, index, value)
    DCON.dcon_building_type_set_required_biome(building_type_id - 1, index - 1, value - 1)
end
---@param building_type_id building_type_id valid building_type id
---@param index number valid
---@return resource_id required_resource 
function DATA.building_type_get_required_resource(building_type_id, index)
    assert(index ~= 0)
    return DCON.dcon_building_type_get_required_resource(building_type_id - 1, index - 1) + 1
end
---@param building_type_id building_type_id valid building_type id
---@param index number valid index
---@param value resource_id valid resource_id
function DATA.building_type_set_required_resource(building_type_id, index, value)
    DCON.dcon_building_type_set_required_resource(building_type_id - 1, index - 1, value - 1)
end
---@param building_type_id building_type_id valid building_type id
---@return boolean unique only one per province!
function DATA.building_type_get_unique(building_type_id)
    return DCON.dcon_building_type_get_unique(building_type_id - 1)
end
---@param building_type_id building_type_id valid building_type id
---@param value boolean valid boolean
function DATA.building_type_set_unique(building_type_id, value)
    DCON.dcon_building_type_set_unique(building_type_id - 1, value)
end
---@param building_type_id building_type_id valid building_type id
---@return boolean movable is it possible to migrate with this building?
function DATA.building_type_get_movable(building_type_id)
    return DCON.dcon_building_type_get_movable(building_type_id - 1)
end
---@param building_type_id building_type_id valid building_type id
---@param value boolean valid boolean
function DATA.building_type_set_movable(building_type_id, value)
    DCON.dcon_building_type_set_movable(building_type_id - 1, value)
end
---@param building_type_id building_type_id valid building_type id
---@return boolean government only the government can build this building!
function DATA.building_type_get_government(building_type_id)
    return DCON.dcon_building_type_get_government(building_type_id - 1)
end
---@param building_type_id building_type_id valid building_type id
---@param value boolean valid boolean
function DATA.building_type_set_government(building_type_id, value)
    DCON.dcon_building_type_set_government(building_type_id - 1, value)
end
---@param building_type_id building_type_id valid building_type id
---@return number needed_infrastructure 
function DATA.building_type_get_needed_infrastructure(building_type_id)
    return DCON.dcon_building_type_get_needed_infrastructure(building_type_id - 1)
end
---@param building_type_id building_type_id valid building_type id
---@param value number valid number
function DATA.building_type_set_needed_infrastructure(building_type_id, value)
    DCON.dcon_building_type_set_needed_infrastructure(building_type_id - 1, value)
end
---@param building_type_id building_type_id valid building_type id
---@param value number valid number
function DATA.building_type_inc_needed_infrastructure(building_type_id, value)
    ---@type number
    local current = DCON.dcon_building_type_get_needed_infrastructure(building_type_id - 1)
    DCON.dcon_building_type_set_needed_infrastructure(building_type_id - 1, current + value)
end
---@param building_type_id building_type_id valid building_type id
---@return number spotting The amount of "spotting" a building provides. Spotting is used in warfare. Higher spotting makes it more difficult for foreign armies to sneak in.
function DATA.building_type_get_spotting(building_type_id)
    return DCON.dcon_building_type_get_spotting(building_type_id - 1)
end
---@param building_type_id building_type_id valid building_type id
---@param value number valid number
function DATA.building_type_set_spotting(building_type_id, value)
    DCON.dcon_building_type_set_spotting(building_type_id - 1, value)
end
---@param building_type_id building_type_id valid building_type id
---@param value number valid number
function DATA.building_type_inc_spotting(building_type_id, value)
    ---@type number
    local current = DCON.dcon_building_type_get_spotting(building_type_id - 1)
    DCON.dcon_building_type_set_spotting(building_type_id - 1, current + value)
end

local fat_building_type_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.building_type_get_name(t.id) end
        if (k == "icon") then return DATA.building_type_get_icon(t.id) end
        if (k == "description") then return DATA.building_type_get_description(t.id) end
        if (k == "r") then return DATA.building_type_get_r(t.id) end
        if (k == "g") then return DATA.building_type_get_g(t.id) end
        if (k == "b") then return DATA.building_type_get_b(t.id) end
        if (k == "production_method") then return DATA.building_type_get_production_method(t.id) end
        if (k == "construction_cost") then return DATA.building_type_get_construction_cost(t.id) end
        if (k == "upkeep") then return DATA.building_type_get_upkeep(t.id) end
        if (k == "unique") then return DATA.building_type_get_unique(t.id) end
        if (k == "movable") then return DATA.building_type_get_movable(t.id) end
        if (k == "government") then return DATA.building_type_get_government(t.id) end
        if (k == "needed_infrastructure") then return DATA.building_type_get_needed_infrastructure(t.id) end
        if (k == "spotting") then return DATA.building_type_get_spotting(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.building_type_set_name(t.id, v)
            return
        end
        if (k == "icon") then
            DATA.building_type_set_icon(t.id, v)
            return
        end
        if (k == "description") then
            DATA.building_type_set_description(t.id, v)
            return
        end
        if (k == "r") then
            DATA.building_type_set_r(t.id, v)
            return
        end
        if (k == "g") then
            DATA.building_type_set_g(t.id, v)
            return
        end
        if (k == "b") then
            DATA.building_type_set_b(t.id, v)
            return
        end
        if (k == "production_method") then
            DATA.building_type_set_production_method(t.id, v)
            return
        end
        if (k == "construction_cost") then
            DATA.building_type_set_construction_cost(t.id, v)
            return
        end
        if (k == "upkeep") then
            DATA.building_type_set_upkeep(t.id, v)
            return
        end
        if (k == "unique") then
            DATA.building_type_set_unique(t.id, v)
            return
        end
        if (k == "movable") then
            DATA.building_type_set_movable(t.id, v)
            return
        end
        if (k == "government") then
            DATA.building_type_set_government(t.id, v)
            return
        end
        if (k == "needed_infrastructure") then
            DATA.building_type_set_needed_infrastructure(t.id, v)
            return
        end
        if (k == "spotting") then
            DATA.building_type_set_spotting(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id building_type_id
---@return fat_building_type_id fat_id
function DATA.fatten_building_type(id)
    local result = {id = id}
    setmetatable(result, fat_building_type_id_metatable)
    return result --[[@as fat_building_type_id]]
end
