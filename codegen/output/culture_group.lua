local ffi = require("ffi")
----------culture_group----------


---culture_group: LSP types---

---Unique identificator for culture_group entity
---@class (exact) culture_group_id : table
---@field is_culture_group number
---@class (exact) fat_culture_group_id
---@field id culture_group_id Unique culture_group id
---@field name string 
---@field r number 
---@field g number 
---@field b number 
---@field language language_id 
---@field view_on_treason number 

---@class struct_culture_group
---@field language language_id 


ffi.cdef[[
void dcon_culture_group_set_language(int32_t, int32_t);
int32_t dcon_culture_group_get_language(int32_t);
void dcon_delete_culture_group(int32_t j);
int32_t dcon_create_culture_group();
bool dcon_culture_group_is_valid(int32_t);
void dcon_culture_group_resize(uint32_t sz);
uint32_t dcon_culture_group_size();
]]

---culture_group: FFI arrays---
---@type (string)[]
DATA.culture_group_name= {}
---@type (number)[]
DATA.culture_group_r= {}
---@type (number)[]
DATA.culture_group_g= {}
---@type (number)[]
DATA.culture_group_b= {}
---@type (number)[]
DATA.culture_group_view_on_treason= {}

---culture_group: LUA bindings---

DATA.culture_group_size = 10000
---@return culture_group_id
function DATA.create_culture_group()
    ---@type culture_group_id
    local i  = DCON.dcon_create_culture_group() + 1
    return i --[[@as culture_group_id]] 
end
---@param i culture_group_id
function DATA.delete_culture_group(i)
    assert(DCON.dcon_culture_group_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_culture_group(i - 1)
end
---@param func fun(item: culture_group_id) 
function DATA.for_each_culture_group(func)
    ---@type number
    local range = DCON.dcon_culture_group_size()
    for i = 0, range - 1 do
        if DCON.dcon_culture_group_is_valid(i) then func(i + 1 --[[@as culture_group_id]]) end
    end
end
---@param func fun(item: culture_group_id):boolean 
---@return table<culture_group_id, culture_group_id> 
function DATA.filter_culture_group(func)
    ---@type table<culture_group_id, culture_group_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_culture_group_size()
    for i = 0, range - 1 do
        if DCON.dcon_culture_group_is_valid(i) and func(i + 1 --[[@as culture_group_id]]) then t[i + 1 --[[@as culture_group_id]]] = i + 1 --[[@as culture_group_id]] end
    end
    return t
end

---@param culture_group_id culture_group_id valid culture_group id
---@return string name 
function DATA.culture_group_get_name(culture_group_id)
    return DATA.culture_group_name[culture_group_id]
end
---@param culture_group_id culture_group_id valid culture_group id
---@param value string valid string
function DATA.culture_group_set_name(culture_group_id, value)
    DATA.culture_group_name[culture_group_id] = value
end
---@param culture_group_id culture_group_id valid culture_group id
---@return number r 
function DATA.culture_group_get_r(culture_group_id)
    return DATA.culture_group_r[culture_group_id]
end
---@param culture_group_id culture_group_id valid culture_group id
---@param value number valid number
function DATA.culture_group_set_r(culture_group_id, value)
    DATA.culture_group_r[culture_group_id] = value
end
---@param culture_group_id culture_group_id valid culture_group id
---@return number g 
function DATA.culture_group_get_g(culture_group_id)
    return DATA.culture_group_g[culture_group_id]
end
---@param culture_group_id culture_group_id valid culture_group id
---@param value number valid number
function DATA.culture_group_set_g(culture_group_id, value)
    DATA.culture_group_g[culture_group_id] = value
end
---@param culture_group_id culture_group_id valid culture_group id
---@return number b 
function DATA.culture_group_get_b(culture_group_id)
    return DATA.culture_group_b[culture_group_id]
end
---@param culture_group_id culture_group_id valid culture_group id
---@param value number valid number
function DATA.culture_group_set_b(culture_group_id, value)
    DATA.culture_group_b[culture_group_id] = value
end
---@param culture_group_id culture_group_id valid culture_group id
---@return language_id language 
function DATA.culture_group_get_language(culture_group_id)
    return DCON.dcon_culture_group_get_language(culture_group_id - 1) + 1
end
---@param culture_group_id culture_group_id valid culture_group id
---@param value language_id valid language_id
function DATA.culture_group_set_language(culture_group_id, value)
    DCON.dcon_culture_group_set_language(culture_group_id - 1, value - 1)
end
---@param culture_group_id culture_group_id valid culture_group id
---@return number view_on_treason 
function DATA.culture_group_get_view_on_treason(culture_group_id)
    return DATA.culture_group_view_on_treason[culture_group_id]
end
---@param culture_group_id culture_group_id valid culture_group id
---@param value number valid number
function DATA.culture_group_set_view_on_treason(culture_group_id, value)
    DATA.culture_group_view_on_treason[culture_group_id] = value
end

local fat_culture_group_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.culture_group_get_name(t.id) end
        if (k == "r") then return DATA.culture_group_get_r(t.id) end
        if (k == "g") then return DATA.culture_group_get_g(t.id) end
        if (k == "b") then return DATA.culture_group_get_b(t.id) end
        if (k == "language") then return DATA.culture_group_get_language(t.id) end
        if (k == "view_on_treason") then return DATA.culture_group_get_view_on_treason(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.culture_group_set_name(t.id, v)
            return
        end
        if (k == "r") then
            DATA.culture_group_set_r(t.id, v)
            return
        end
        if (k == "g") then
            DATA.culture_group_set_g(t.id, v)
            return
        end
        if (k == "b") then
            DATA.culture_group_set_b(t.id, v)
            return
        end
        if (k == "language") then
            DATA.culture_group_set_language(t.id, v)
            return
        end
        if (k == "view_on_treason") then
            DATA.culture_group_set_view_on_treason(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id culture_group_id
---@return fat_culture_group_id fat_id
function DATA.fatten_culture_group(id)
    local result = {id = id}
    setmetatable(result, fat_culture_group_id_metatable)
    return result --[[@as fat_culture_group_id]]
end
