local ffi = require("ffi")
----------building_archetype----------


---building_archetype: LSP types---

---Unique identificator for building_archetype entity
---@class (exact) building_archetype_id : table
---@field is_building_archetype number
---@class (exact) fat_building_archetype_id
---@field id building_archetype_id Unique building_archetype id
---@field name string 

---@class struct_building_archetype

---@class (exact) building_archetype_id_data_blob_definition
---@field name string 
---Sets values of building_archetype for given id
---@param id building_archetype_id
---@param data building_archetype_id_data_blob_definition
function DATA.setup_building_archetype(id, data)
    DATA.building_archetype_set_name(id, data.name)
end

ffi.cdef[[
int32_t dcon_create_building_archetype();
bool dcon_building_archetype_is_valid(int32_t);
void dcon_building_archetype_resize(uint32_t sz);
uint32_t dcon_building_archetype_size();
]]

---building_archetype: FFI arrays---
---@type (string)[]
DATA.building_archetype_name= {}

---building_archetype: LUA bindings---

DATA.building_archetype_size = 7
---@return building_archetype_id
function DATA.create_building_archetype()
    ---@type building_archetype_id
    local i  = DCON.dcon_create_building_archetype() + 1
    return i --[[@as building_archetype_id]] 
end
---@param func fun(item: building_archetype_id) 
function DATA.for_each_building_archetype(func)
    ---@type number
    local range = DCON.dcon_building_archetype_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as building_archetype_id]])
    end
end
---@param func fun(item: building_archetype_id):boolean 
---@return table<building_archetype_id, building_archetype_id> 
function DATA.filter_building_archetype(func)
    ---@type table<building_archetype_id, building_archetype_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_building_archetype_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as building_archetype_id]]) then t[i + 1 --[[@as building_archetype_id]]] = t[i + 1 --[[@as building_archetype_id]]] end
    end
    return t
end

---@param building_archetype_id building_archetype_id valid building_archetype id
---@return string name 
function DATA.building_archetype_get_name(building_archetype_id)
    return DATA.building_archetype_name[building_archetype_id]
end
---@param building_archetype_id building_archetype_id valid building_archetype id
---@param value string valid string
function DATA.building_archetype_set_name(building_archetype_id, value)
    DATA.building_archetype_name[building_archetype_id] = value
end

local fat_building_archetype_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.building_archetype_get_name(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.building_archetype_set_name(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id building_archetype_id
---@return fat_building_archetype_id fat_id
function DATA.fatten_building_archetype(id)
    local result = {id = id}
    setmetatable(result, fat_building_archetype_id_metatable)
    return result --[[@as fat_building_archetype_id]]
end
---@enum BUILDING_ARCHETYPE
BUILDING_ARCHETYPE = {
    INVALID = 0,
    GROUNDS = 1,
    FARM = 2,
    MINE = 3,
    WORKSHOP = 4,
    DEFENSE = 5,
}
local index_building_archetype
index_building_archetype = DATA.create_building_archetype()
DATA.building_archetype_set_name(index_building_archetype, "GROUNDS")
index_building_archetype = DATA.create_building_archetype()
DATA.building_archetype_set_name(index_building_archetype, "FARM")
index_building_archetype = DATA.create_building_archetype()
DATA.building_archetype_set_name(index_building_archetype, "MINE")
index_building_archetype = DATA.create_building_archetype()
DATA.building_archetype_set_name(index_building_archetype, "WORKSHOP")
index_building_archetype = DATA.create_building_archetype()
DATA.building_archetype_set_name(index_building_archetype, "DEFENSE")
