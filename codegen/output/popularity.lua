local ffi = require("ffi")
----------popularity----------


---popularity: LSP types---

---Unique identificator for popularity entity
---@class (exact) popularity_id : table
---@field is_popularity number
---@class (exact) fat_popularity_id
---@field id popularity_id Unique popularity id
---@field value number efficiency of this relation
---@field who pop_id 
---@field where realm_id popularity where

---@class struct_popularity
---@field value number efficiency of this relation


ffi.cdef[[
void dcon_popularity_set_value(int32_t, float);
float dcon_popularity_get_value(int32_t);
void dcon_delete_popularity(int32_t j);
int32_t dcon_force_create_popularity(int32_t who, int32_t where);
void dcon_popularity_set_who(int32_t, int32_t);
int32_t dcon_popularity_get_who(int32_t);
int32_t dcon_pop_get_range_popularity_as_who(int32_t);
int32_t dcon_pop_get_index_popularity_as_who(int32_t, int32_t);
void dcon_popularity_set_where(int32_t, int32_t);
int32_t dcon_popularity_get_where(int32_t);
int32_t dcon_realm_get_range_popularity_as_where(int32_t);
int32_t dcon_realm_get_index_popularity_as_where(int32_t, int32_t);
bool dcon_popularity_is_valid(int32_t);
void dcon_popularity_resize(uint32_t sz);
uint32_t dcon_popularity_size();
]]

---popularity: FFI arrays---

---popularity: LUA bindings---

DATA.popularity_size = 450000
---@param who pop_id
---@param where realm_id
---@return popularity_id
function DATA.force_create_popularity(who, where)
    ---@type popularity_id
    local i = DCON.dcon_force_create_popularity(who - 1, where - 1) + 1
    return i --[[@as popularity_id]] 
end
---@param i popularity_id
function DATA.delete_popularity(i)
    assert(DCON.dcon_popularity_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_popularity(i - 1)
end
---@param func fun(item: popularity_id) 
function DATA.for_each_popularity(func)
    ---@type number
    local range = DCON.dcon_popularity_size()
    for i = 0, range - 1 do
        if DCON.dcon_popularity_is_valid(i) then func(i + 1 --[[@as popularity_id]]) end
    end
end
---@param func fun(item: popularity_id):boolean 
---@return table<popularity_id, popularity_id> 
function DATA.filter_popularity(func)
    ---@type table<popularity_id, popularity_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_popularity_size()
    for i = 0, range - 1 do
        if DCON.dcon_popularity_is_valid(i) and func(i + 1 --[[@as popularity_id]]) then t[i + 1 --[[@as popularity_id]]] = i + 1 --[[@as popularity_id]] end
    end
    return t
end

---@param popularity_id popularity_id valid popularity id
---@return number value efficiency of this relation
function DATA.popularity_get_value(popularity_id)
    return DCON.dcon_popularity_get_value(popularity_id - 1)
end
---@param popularity_id popularity_id valid popularity id
---@param value number valid number
function DATA.popularity_set_value(popularity_id, value)
    DCON.dcon_popularity_set_value(popularity_id - 1, value)
end
---@param popularity_id popularity_id valid popularity id
---@param value number valid number
function DATA.popularity_inc_value(popularity_id, value)
    ---@type number
    local current = DCON.dcon_popularity_get_value(popularity_id - 1)
    DCON.dcon_popularity_set_value(popularity_id - 1, current + value)
end
---@param who popularity_id valid pop_id
---@return pop_id Data retrieved from popularity 
function DATA.popularity_get_who(who)
    return DCON.dcon_popularity_get_who(who - 1) + 1
end
---@param who pop_id valid pop_id
---@return popularity_id[] An array of popularity 
function DATA.get_popularity_from_who(who)
    local result = {}
    DATA.for_each_popularity_from_who(who, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param who pop_id valid pop_id
---@param func fun(item: popularity_id) valid pop_id
function DATA.for_each_popularity_from_who(who, func)
    ---@type number
    local range = DCON.dcon_pop_get_range_popularity_as_who(who - 1)
    for i = 0, range - 1 do
        ---@type popularity_id
        local accessed_element = DCON.dcon_pop_get_index_popularity_as_who(who - 1, i) + 1
        if DCON.dcon_popularity_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param who pop_id valid pop_id
---@param func fun(item: popularity_id):boolean 
---@return popularity_id[]
function DATA.filter_array_popularity_from_who(who, func)
    ---@type table<popularity_id, popularity_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_popularity_as_who(who - 1)
    for i = 0, range - 1 do
        ---@type popularity_id
        local accessed_element = DCON.dcon_pop_get_index_popularity_as_who(who - 1, i) + 1
        if DCON.dcon_popularity_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param who pop_id valid pop_id
---@param func fun(item: popularity_id):boolean 
---@return table<popularity_id, popularity_id> 
function DATA.filter_popularity_from_who(who, func)
    ---@type table<popularity_id, popularity_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_popularity_as_who(who - 1)
    for i = 0, range - 1 do
        ---@type popularity_id
        local accessed_element = DCON.dcon_pop_get_index_popularity_as_who(who - 1, i) + 1
        if DCON.dcon_popularity_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param popularity_id popularity_id valid popularity id
---@param value pop_id valid pop_id
function DATA.popularity_set_who(popularity_id, value)
    DCON.dcon_popularity_set_who(popularity_id - 1, value - 1)
end
---@param where popularity_id valid realm_id
---@return realm_id Data retrieved from popularity 
function DATA.popularity_get_where(where)
    return DCON.dcon_popularity_get_where(where - 1) + 1
end
---@param where realm_id valid realm_id
---@return popularity_id[] An array of popularity 
function DATA.get_popularity_from_where(where)
    local result = {}
    DATA.for_each_popularity_from_where(where, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param where realm_id valid realm_id
---@param func fun(item: popularity_id) valid realm_id
function DATA.for_each_popularity_from_where(where, func)
    ---@type number
    local range = DCON.dcon_realm_get_range_popularity_as_where(where - 1)
    for i = 0, range - 1 do
        ---@type popularity_id
        local accessed_element = DCON.dcon_realm_get_index_popularity_as_where(where - 1, i) + 1
        if DCON.dcon_popularity_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param where realm_id valid realm_id
---@param func fun(item: popularity_id):boolean 
---@return popularity_id[]
function DATA.filter_array_popularity_from_where(where, func)
    ---@type table<popularity_id, popularity_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_get_range_popularity_as_where(where - 1)
    for i = 0, range - 1 do
        ---@type popularity_id
        local accessed_element = DCON.dcon_realm_get_index_popularity_as_where(where - 1, i) + 1
        if DCON.dcon_popularity_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param where realm_id valid realm_id
---@param func fun(item: popularity_id):boolean 
---@return table<popularity_id, popularity_id> 
function DATA.filter_popularity_from_where(where, func)
    ---@type table<popularity_id, popularity_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_get_range_popularity_as_where(where - 1)
    for i = 0, range - 1 do
        ---@type popularity_id
        local accessed_element = DCON.dcon_realm_get_index_popularity_as_where(where - 1, i) + 1
        if DCON.dcon_popularity_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param popularity_id popularity_id valid popularity id
---@param value realm_id valid realm_id
function DATA.popularity_set_where(popularity_id, value)
    DCON.dcon_popularity_set_where(popularity_id - 1, value - 1)
end

local fat_popularity_id_metatable = {
    __index = function (t,k)
        if (k == "value") then return DATA.popularity_get_value(t.id) end
        if (k == "who") then return DATA.popularity_get_who(t.id) end
        if (k == "where") then return DATA.popularity_get_where(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "value") then
            DATA.popularity_set_value(t.id, v)
            return
        end
        if (k == "who") then
            DATA.popularity_set_who(t.id, v)
            return
        end
        if (k == "where") then
            DATA.popularity_set_where(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id popularity_id
---@return fat_popularity_id fat_id
function DATA.fatten_popularity(id)
    local result = {id = id}
    setmetatable(result, fat_popularity_id_metatable)
    return result --[[@as fat_popularity_id]]
end
