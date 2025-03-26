local ffi = require("ffi")
----------unit_type----------


---unit_type: LSP types---

---Unique identificator for unit_type entity
---@class (exact) unit_type_id : table
---@field is_unit_type number
---@class (exact) fat_unit_type_id
---@field id unit_type_id Unique unit_type id
---@field name string 
---@field description string 
---@field icon string 
---@field base_cost number 

---@class struct_unit_type
---@field base_cost number 

---@class (exact) unit_type_id_data_blob_definition
---@field name string 
---@field description string 
---@field icon string 
---@field base_cost number 
---Sets values of unit_type for given id
---@param id unit_type_id
---@param data unit_type_id_data_blob_definition
function DATA.setup_unit_type(id, data)
    DATA.unit_type_set_name(id, data.name)
    DATA.unit_type_set_description(id, data.description)
    DATA.unit_type_set_icon(id, data.icon)
    DATA.unit_type_set_base_cost(id, data.base_cost)
end

ffi.cdef[[
void dcon_unit_type_set_base_cost(int32_t, float);
float dcon_unit_type_get_base_cost(int32_t);
int32_t dcon_create_unit_type();
bool dcon_unit_type_is_valid(int32_t);
void dcon_unit_type_resize(uint32_t sz);
uint32_t dcon_unit_type_size();
]]

---unit_type: FFI arrays---
---@type (string)[]
DATA.unit_type_name= {}
---@type (string)[]
DATA.unit_type_description= {}
---@type (string)[]
DATA.unit_type_icon= {}

---unit_type: LUA bindings---

DATA.unit_type_size = 5
---@return unit_type_id
function DATA.create_unit_type()
    ---@type unit_type_id
    local i  = DCON.dcon_create_unit_type() + 1
    return i --[[@as unit_type_id]] 
end
---@param func fun(item: unit_type_id) 
function DATA.for_each_unit_type(func)
    ---@type number
    local range = DCON.dcon_unit_type_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as unit_type_id]])
    end
end
---@param func fun(item: unit_type_id):boolean 
---@return table<unit_type_id, unit_type_id> 
function DATA.filter_unit_type(func)
    ---@type table<unit_type_id, unit_type_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_unit_type_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as unit_type_id]]) then t[i + 1 --[[@as unit_type_id]]] = t[i + 1 --[[@as unit_type_id]]] end
    end
    return t
end

---@param unit_type_id unit_type_id valid unit_type id
---@return string name 
function DATA.unit_type_get_name(unit_type_id)
    return DATA.unit_type_name[unit_type_id]
end
---@param unit_type_id unit_type_id valid unit_type id
---@param value string valid string
function DATA.unit_type_set_name(unit_type_id, value)
    DATA.unit_type_name[unit_type_id] = value
end
---@param unit_type_id unit_type_id valid unit_type id
---@return string description 
function DATA.unit_type_get_description(unit_type_id)
    return DATA.unit_type_description[unit_type_id]
end
---@param unit_type_id unit_type_id valid unit_type id
---@param value string valid string
function DATA.unit_type_set_description(unit_type_id, value)
    DATA.unit_type_description[unit_type_id] = value
end
---@param unit_type_id unit_type_id valid unit_type id
---@return string icon 
function DATA.unit_type_get_icon(unit_type_id)
    return DATA.unit_type_icon[unit_type_id]
end
---@param unit_type_id unit_type_id valid unit_type id
---@param value string valid string
function DATA.unit_type_set_icon(unit_type_id, value)
    DATA.unit_type_icon[unit_type_id] = value
end
---@param unit_type_id unit_type_id valid unit_type id
---@return number base_cost 
function DATA.unit_type_get_base_cost(unit_type_id)
    return DCON.dcon_unit_type_get_base_cost(unit_type_id - 1)
end
---@param unit_type_id unit_type_id valid unit_type id
---@param value number valid number
function DATA.unit_type_set_base_cost(unit_type_id, value)
    DCON.dcon_unit_type_set_base_cost(unit_type_id - 1, value)
end
---@param unit_type_id unit_type_id valid unit_type id
---@param value number valid number
function DATA.unit_type_inc_base_cost(unit_type_id, value)
    ---@type number
    local current = DCON.dcon_unit_type_get_base_cost(unit_type_id - 1)
    DCON.dcon_unit_type_set_base_cost(unit_type_id - 1, current + value)
end

local fat_unit_type_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.unit_type_get_name(t.id) end
        if (k == "description") then return DATA.unit_type_get_description(t.id) end
        if (k == "icon") then return DATA.unit_type_get_icon(t.id) end
        if (k == "base_cost") then return DATA.unit_type_get_base_cost(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.unit_type_set_name(t.id, v)
            return
        end
        if (k == "description") then
            DATA.unit_type_set_description(t.id, v)
            return
        end
        if (k == "icon") then
            DATA.unit_type_set_icon(t.id, v)
            return
        end
        if (k == "base_cost") then
            DATA.unit_type_set_base_cost(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id unit_type_id
---@return fat_unit_type_id fat_id
function DATA.fatten_unit_type(id)
    local result = {id = id}
    setmetatable(result, fat_unit_type_id_metatable)
    return result --[[@as fat_unit_type_id]]
end
---@enum UNIT_TYPE
UNIT_TYPE = {
    INVALID = 0,
    WARRIOR = 1,
    CIVILIAN = 2,
    FOLLOWER = 3,
}
local index_unit_type
index_unit_type = DATA.create_unit_type()
DATA.unit_type_set_name(index_unit_type, "warrior")
DATA.unit_type_set_description(index_unit_type, "combatant")
DATA.unit_type_set_icon(index_unit_type, "guards.png")
DATA.unit_type_set_base_cost(index_unit_type, 0.5)
index_unit_type = DATA.create_unit_type()
DATA.unit_type_set_name(index_unit_type, "civilian")
DATA.unit_type_set_description(index_unit_type, "noncombatant")
DATA.unit_type_set_icon(index_unit_type, "minions.png")
DATA.unit_type_set_base_cost(index_unit_type, 0.25)
index_unit_type = DATA.create_unit_type()
DATA.unit_type_set_name(index_unit_type, "follower")
DATA.unit_type_set_description(index_unit_type, "follower")
DATA.unit_type_set_icon(index_unit_type, "ages.png")
DATA.unit_type_set_base_cost(index_unit_type, 0)
