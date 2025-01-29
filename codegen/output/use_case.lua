local ffi = require("ffi")
----------use_case----------


---use_case: LSP types---

---Unique identificator for use_case entity
---@class (exact) use_case_id : table
---@field is_use_case number
---@class (exact) fat_use_case_id
---@field id use_case_id Unique use_case id
---@field name string 
---@field icon string 
---@field description string 
---@field good_consumption number 
---@field r number 
---@field g number 
---@field b number 

---@class struct_use_case
---@field good_consumption number 
---@field r number 
---@field g number 
---@field b number 

---@class (exact) use_case_id_data_blob_definition
---@field name string 
---@field icon string 
---@field description string 
---@field good_consumption number 
---@field r number 
---@field g number 
---@field b number 
---Sets values of use_case for given id
---@param id use_case_id
---@param data use_case_id_data_blob_definition
function DATA.setup_use_case(id, data)
    DATA.use_case_set_name(id, data.name)
    DATA.use_case_set_icon(id, data.icon)
    DATA.use_case_set_description(id, data.description)
    DATA.use_case_set_good_consumption(id, data.good_consumption)
    DATA.use_case_set_r(id, data.r)
    DATA.use_case_set_g(id, data.g)
    DATA.use_case_set_b(id, data.b)
end

ffi.cdef[[
void dcon_use_case_set_good_consumption(int32_t, float);
float dcon_use_case_get_good_consumption(int32_t);
void dcon_use_case_set_r(int32_t, float);
float dcon_use_case_get_r(int32_t);
void dcon_use_case_set_g(int32_t, float);
float dcon_use_case_get_g(int32_t);
void dcon_use_case_set_b(int32_t, float);
float dcon_use_case_get_b(int32_t);
int32_t dcon_create_use_case();
bool dcon_use_case_is_valid(int32_t);
void dcon_use_case_resize(uint32_t sz);
uint32_t dcon_use_case_size();
]]

---use_case: FFI arrays---
---@type (string)[]
DATA.use_case_name= {}
---@type (string)[]
DATA.use_case_icon= {}
---@type (string)[]
DATA.use_case_description= {}

---use_case: LUA bindings---

DATA.use_case_size = 100
---@return use_case_id
function DATA.create_use_case()
    ---@type use_case_id
    local i  = DCON.dcon_create_use_case() + 1
    return i --[[@as use_case_id]] 
end
---@param func fun(item: use_case_id) 
function DATA.for_each_use_case(func)
    ---@type number
    local range = DCON.dcon_use_case_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as use_case_id]])
    end
end
---@param func fun(item: use_case_id):boolean 
---@return table<use_case_id, use_case_id> 
function DATA.filter_use_case(func)
    ---@type table<use_case_id, use_case_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_use_case_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as use_case_id]]) then t[i + 1 --[[@as use_case_id]]] = t[i + 1 --[[@as use_case_id]]] end
    end
    return t
end

---@param use_case_id use_case_id valid use_case id
---@return string name 
function DATA.use_case_get_name(use_case_id)
    return DATA.use_case_name[use_case_id]
end
---@param use_case_id use_case_id valid use_case id
---@param value string valid string
function DATA.use_case_set_name(use_case_id, value)
    DATA.use_case_name[use_case_id] = value
end
---@param use_case_id use_case_id valid use_case id
---@return string icon 
function DATA.use_case_get_icon(use_case_id)
    return DATA.use_case_icon[use_case_id]
end
---@param use_case_id use_case_id valid use_case id
---@param value string valid string
function DATA.use_case_set_icon(use_case_id, value)
    DATA.use_case_icon[use_case_id] = value
end
---@param use_case_id use_case_id valid use_case id
---@return string description 
function DATA.use_case_get_description(use_case_id)
    return DATA.use_case_description[use_case_id]
end
---@param use_case_id use_case_id valid use_case id
---@param value string valid string
function DATA.use_case_set_description(use_case_id, value)
    DATA.use_case_description[use_case_id] = value
end
---@param use_case_id use_case_id valid use_case id
---@return number good_consumption 
function DATA.use_case_get_good_consumption(use_case_id)
    return DCON.dcon_use_case_get_good_consumption(use_case_id - 1)
end
---@param use_case_id use_case_id valid use_case id
---@param value number valid number
function DATA.use_case_set_good_consumption(use_case_id, value)
    DCON.dcon_use_case_set_good_consumption(use_case_id - 1, value)
end
---@param use_case_id use_case_id valid use_case id
---@param value number valid number
function DATA.use_case_inc_good_consumption(use_case_id, value)
    ---@type number
    local current = DCON.dcon_use_case_get_good_consumption(use_case_id - 1)
    DCON.dcon_use_case_set_good_consumption(use_case_id - 1, current + value)
end
---@param use_case_id use_case_id valid use_case id
---@return number r 
function DATA.use_case_get_r(use_case_id)
    return DCON.dcon_use_case_get_r(use_case_id - 1)
end
---@param use_case_id use_case_id valid use_case id
---@param value number valid number
function DATA.use_case_set_r(use_case_id, value)
    DCON.dcon_use_case_set_r(use_case_id - 1, value)
end
---@param use_case_id use_case_id valid use_case id
---@param value number valid number
function DATA.use_case_inc_r(use_case_id, value)
    ---@type number
    local current = DCON.dcon_use_case_get_r(use_case_id - 1)
    DCON.dcon_use_case_set_r(use_case_id - 1, current + value)
end
---@param use_case_id use_case_id valid use_case id
---@return number g 
function DATA.use_case_get_g(use_case_id)
    return DCON.dcon_use_case_get_g(use_case_id - 1)
end
---@param use_case_id use_case_id valid use_case id
---@param value number valid number
function DATA.use_case_set_g(use_case_id, value)
    DCON.dcon_use_case_set_g(use_case_id - 1, value)
end
---@param use_case_id use_case_id valid use_case id
---@param value number valid number
function DATA.use_case_inc_g(use_case_id, value)
    ---@type number
    local current = DCON.dcon_use_case_get_g(use_case_id - 1)
    DCON.dcon_use_case_set_g(use_case_id - 1, current + value)
end
---@param use_case_id use_case_id valid use_case id
---@return number b 
function DATA.use_case_get_b(use_case_id)
    return DCON.dcon_use_case_get_b(use_case_id - 1)
end
---@param use_case_id use_case_id valid use_case id
---@param value number valid number
function DATA.use_case_set_b(use_case_id, value)
    DCON.dcon_use_case_set_b(use_case_id - 1, value)
end
---@param use_case_id use_case_id valid use_case id
---@param value number valid number
function DATA.use_case_inc_b(use_case_id, value)
    ---@type number
    local current = DCON.dcon_use_case_get_b(use_case_id - 1)
    DCON.dcon_use_case_set_b(use_case_id - 1, current + value)
end

local fat_use_case_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.use_case_get_name(t.id) end
        if (k == "icon") then return DATA.use_case_get_icon(t.id) end
        if (k == "description") then return DATA.use_case_get_description(t.id) end
        if (k == "good_consumption") then return DATA.use_case_get_good_consumption(t.id) end
        if (k == "r") then return DATA.use_case_get_r(t.id) end
        if (k == "g") then return DATA.use_case_get_g(t.id) end
        if (k == "b") then return DATA.use_case_get_b(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.use_case_set_name(t.id, v)
            return
        end
        if (k == "icon") then
            DATA.use_case_set_icon(t.id, v)
            return
        end
        if (k == "description") then
            DATA.use_case_set_description(t.id, v)
            return
        end
        if (k == "good_consumption") then
            DATA.use_case_set_good_consumption(t.id, v)
            return
        end
        if (k == "r") then
            DATA.use_case_set_r(t.id, v)
            return
        end
        if (k == "g") then
            DATA.use_case_set_g(t.id, v)
            return
        end
        if (k == "b") then
            DATA.use_case_set_b(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id use_case_id
---@return fat_use_case_id fat_id
function DATA.fatten_use_case(id)
    local result = {id = id}
    setmetatable(result, fat_use_case_id_metatable)
    return result --[[@as fat_use_case_id]]
end
