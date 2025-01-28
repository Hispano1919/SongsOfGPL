local ffi = require("ffi")
----------law_building----------


---law_building: LSP types---

---Unique identificator for law_building entity
---@class (exact) law_building_id : table
---@field is_law_building number
---@class (exact) fat_law_building_id
---@field id law_building_id Unique law_building id
---@field name string 

---@class struct_law_building

---@class (exact) law_building_id_data_blob_definition
---@field name string 
---Sets values of law_building for given id
---@param id law_building_id
---@param data law_building_id_data_blob_definition
function DATA.setup_law_building(id, data)
    DATA.law_building_set_name(id, data.name)
end

ffi.cdef[[
int32_t dcon_create_law_building();
bool dcon_law_building_is_valid(int32_t);
void dcon_law_building_resize(uint32_t sz);
uint32_t dcon_law_building_size();
]]

---law_building: FFI arrays---
---@type (string)[]
DATA.law_building_name= {}

---law_building: LUA bindings---

DATA.law_building_size = 5
---@return law_building_id
function DATA.create_law_building()
    ---@type law_building_id
    local i  = DCON.dcon_create_law_building() + 1
    return i --[[@as law_building_id]] 
end
---@param func fun(item: law_building_id) 
function DATA.for_each_law_building(func)
    ---@type number
    local range = DCON.dcon_law_building_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as law_building_id]])
    end
end
---@param func fun(item: law_building_id):boolean 
---@return table<law_building_id, law_building_id> 
function DATA.filter_law_building(func)
    ---@type table<law_building_id, law_building_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_law_building_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as law_building_id]]) then t[i + 1 --[[@as law_building_id]]] = t[i + 1 --[[@as law_building_id]]] end
    end
    return t
end

---@param law_building_id law_building_id valid law_building id
---@return string name 
function DATA.law_building_get_name(law_building_id)
    return DATA.law_building_name[law_building_id]
end
---@param law_building_id law_building_id valid law_building id
---@param value string valid string
function DATA.law_building_set_name(law_building_id, value)
    DATA.law_building_name[law_building_id] = value
end

local fat_law_building_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.law_building_get_name(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.law_building_set_name(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id law_building_id
---@return fat_law_building_id fat_id
function DATA.fatten_law_building(id)
    local result = {id = id}
    setmetatable(result, fat_law_building_id_metatable)
    return result --[[@as fat_law_building_id]]
end
---@enum LAW_BUILDING
LAW_BUILDING = {
    INVALID = 0,
    NO_REGULATION = 1,
    LOCALS_ONLY = 2,
    PERMISSION_ONLY = 3,
}
local index_law_building
index_law_building = DATA.create_law_building()
DATA.law_building_set_name(index_law_building, "NO_REGULATION")
index_law_building = DATA.create_law_building()
DATA.law_building_set_name(index_law_building, "LOCALS_ONLY")
index_law_building = DATA.create_law_building()
DATA.law_building_set_name(index_law_building, "PERMISSION_ONLY")
