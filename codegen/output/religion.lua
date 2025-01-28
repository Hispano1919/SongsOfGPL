local ffi = require("ffi")
----------religion----------


---religion: LSP types---

---Unique identificator for religion entity
---@class (exact) religion_id : table
---@field is_religion number
---@class (exact) fat_religion_id
---@field id religion_id Unique religion id
---@field name string 
---@field r number 
---@field g number 
---@field b number 

---@class struct_religion


ffi.cdef[[
void dcon_delete_religion(int32_t j);
int32_t dcon_create_religion();
bool dcon_religion_is_valid(int32_t);
void dcon_religion_resize(uint32_t sz);
uint32_t dcon_religion_size();
]]

---religion: FFI arrays---
---@type (string)[]
DATA.religion_name= {}
---@type (number)[]
DATA.religion_r= {}
---@type (number)[]
DATA.religion_g= {}
---@type (number)[]
DATA.religion_b= {}

---religion: LUA bindings---

DATA.religion_size = 10000
---@return religion_id
function DATA.create_religion()
    ---@type religion_id
    local i  = DCON.dcon_create_religion() + 1
    return i --[[@as religion_id]] 
end
---@param i religion_id
function DATA.delete_religion(i)
    assert(DCON.dcon_religion_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_religion(i - 1)
end
---@param func fun(item: religion_id) 
function DATA.for_each_religion(func)
    ---@type number
    local range = DCON.dcon_religion_size()
    for i = 0, range - 1 do
        if DCON.dcon_religion_is_valid(i) then func(i + 1 --[[@as religion_id]]) end
    end
end
---@param func fun(item: religion_id):boolean 
---@return table<religion_id, religion_id> 
function DATA.filter_religion(func)
    ---@type table<religion_id, religion_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_religion_size()
    for i = 0, range - 1 do
        if DCON.dcon_religion_is_valid(i) and func(i + 1 --[[@as religion_id]]) then t[i + 1 --[[@as religion_id]]] = i + 1 --[[@as religion_id]] end
    end
    return t
end

---@param religion_id religion_id valid religion id
---@return string name 
function DATA.religion_get_name(religion_id)
    return DATA.religion_name[religion_id]
end
---@param religion_id religion_id valid religion id
---@param value string valid string
function DATA.religion_set_name(religion_id, value)
    DATA.religion_name[religion_id] = value
end
---@param religion_id religion_id valid religion id
---@return number r 
function DATA.religion_get_r(religion_id)
    return DATA.religion_r[religion_id]
end
---@param religion_id religion_id valid religion id
---@param value number valid number
function DATA.religion_set_r(religion_id, value)
    DATA.religion_r[religion_id] = value
end
---@param religion_id religion_id valid religion id
---@return number g 
function DATA.religion_get_g(religion_id)
    return DATA.religion_g[religion_id]
end
---@param religion_id religion_id valid religion id
---@param value number valid number
function DATA.religion_set_g(religion_id, value)
    DATA.religion_g[religion_id] = value
end
---@param religion_id religion_id valid religion id
---@return number b 
function DATA.religion_get_b(religion_id)
    return DATA.religion_b[religion_id]
end
---@param religion_id religion_id valid religion id
---@param value number valid number
function DATA.religion_set_b(religion_id, value)
    DATA.religion_b[religion_id] = value
end

local fat_religion_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.religion_get_name(t.id) end
        if (k == "r") then return DATA.religion_get_r(t.id) end
        if (k == "g") then return DATA.religion_get_g(t.id) end
        if (k == "b") then return DATA.religion_get_b(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.religion_set_name(t.id, v)
            return
        end
        if (k == "r") then
            DATA.religion_set_r(t.id, v)
            return
        end
        if (k == "g") then
            DATA.religion_set_g(t.id, v)
            return
        end
        if (k == "b") then
            DATA.religion_set_b(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id religion_id
---@return fat_religion_id fat_id
function DATA.fatten_religion(id)
    local result = {id = id}
    setmetatable(result, fat_religion_id_metatable)
    return result --[[@as fat_religion_id]]
end
