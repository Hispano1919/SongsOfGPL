local ffi = require("ffi")
----------warband_stance----------


---warband_stance: LSP types---

---Unique identificator for warband_stance entity
---@class (exact) warband_stance_id : table
---@field is_warband_stance number
---@class (exact) fat_warband_stance_id
---@field id warband_stance_id Unique warband_stance id
---@field name string 

---@class struct_warband_stance

---@class (exact) warband_stance_id_data_blob_definition
---@field name string 
---Sets values of warband_stance for given id
---@param id warband_stance_id
---@param data warband_stance_id_data_blob_definition
function DATA.setup_warband_stance(id, data)
    DATA.warband_stance_set_name(id, data.name)
end

ffi.cdef[[
int32_t dcon_create_warband_stance();
bool dcon_warband_stance_is_valid(int32_t);
void dcon_warband_stance_resize(uint32_t sz);
uint32_t dcon_warband_stance_size();
]]

---warband_stance: FFI arrays---
---@type (string)[]
DATA.warband_stance_name= {}

---warband_stance: LUA bindings---

DATA.warband_stance_size = 4
---@return warband_stance_id
function DATA.create_warband_stance()
    ---@type warband_stance_id
    local i  = DCON.dcon_create_warband_stance() + 1
    return i --[[@as warband_stance_id]] 
end
---@param func fun(item: warband_stance_id) 
function DATA.for_each_warband_stance(func)
    ---@type number
    local range = DCON.dcon_warband_stance_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as warband_stance_id]])
    end
end
---@param func fun(item: warband_stance_id):boolean 
---@return table<warband_stance_id, warband_stance_id> 
function DATA.filter_warband_stance(func)
    ---@type table<warband_stance_id, warband_stance_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_warband_stance_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as warband_stance_id]]) then t[i + 1 --[[@as warband_stance_id]]] = t[i + 1 --[[@as warband_stance_id]]] end
    end
    return t
end

---@param warband_stance_id warband_stance_id valid warband_stance id
---@return string name 
function DATA.warband_stance_get_name(warband_stance_id)
    return DATA.warband_stance_name[warband_stance_id]
end
---@param warband_stance_id warband_stance_id valid warband_stance id
---@param value string valid string
function DATA.warband_stance_set_name(warband_stance_id, value)
    DATA.warband_stance_name[warband_stance_id] = value
end

local fat_warband_stance_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.warband_stance_get_name(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.warband_stance_set_name(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id warband_stance_id
---@return fat_warband_stance_id fat_id
function DATA.fatten_warband_stance(id)
    local result = {id = id}
    setmetatable(result, fat_warband_stance_id_metatable)
    return result --[[@as fat_warband_stance_id]]
end
---@enum WARBAND_STANCE
WARBAND_STANCE = {
    INVALID = 0,
    WORK = 1,
    FORAGE = 2,
}
local index_warband_stance
index_warband_stance = DATA.create_warband_stance()
DATA.warband_stance_set_name(index_warband_stance, "work")
index_warband_stance = DATA.create_warband_stance()
DATA.warband_stance_set_name(index_warband_stance, "forage")
