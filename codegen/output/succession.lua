local ffi = require("ffi")
----------succession----------


---succession: LSP types---

---Unique identificator for succession entity
---@class (exact) succession_id : table
---@field is_succession number
---@class (exact) fat_succession_id
---@field id succession_id Unique succession id
---@field successor_of pop_id 
---@field successor pop_id 

---@class struct_succession


ffi.cdef[[
void dcon_delete_succession(int32_t j);
int32_t dcon_force_create_succession(int32_t successor_of, int32_t successor);
void dcon_succession_set_successor_of(int32_t, int32_t);
int32_t dcon_succession_get_successor_of(int32_t);
int32_t dcon_pop_get_succession_as_successor_of(int32_t);
void dcon_succession_set_successor(int32_t, int32_t);
int32_t dcon_succession_get_successor(int32_t);
int32_t dcon_pop_get_range_succession_as_successor(int32_t);
int32_t dcon_pop_get_index_succession_as_successor(int32_t, int32_t);
bool dcon_succession_is_valid(int32_t);
void dcon_succession_resize(uint32_t sz);
uint32_t dcon_succession_size();
]]

---succession: FFI arrays---

---succession: LUA bindings---

DATA.succession_size = 200000
---@param successor_of pop_id
---@param successor pop_id
---@return succession_id
function DATA.force_create_succession(successor_of, successor)
    ---@type succession_id
    local i = DCON.dcon_force_create_succession(successor_of - 1, successor - 1) + 1
    return i --[[@as succession_id]] 
end
---@param i succession_id
function DATA.delete_succession(i)
    assert(DCON.dcon_succession_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_succession(i - 1)
end
---@param func fun(item: succession_id) 
function DATA.for_each_succession(func)
    ---@type number
    local range = DCON.dcon_succession_size()
    for i = 0, range - 1 do
        if DCON.dcon_succession_is_valid(i) then func(i + 1 --[[@as succession_id]]) end
    end
end
---@param func fun(item: succession_id):boolean 
---@return table<succession_id, succession_id> 
function DATA.filter_succession(func)
    ---@type table<succession_id, succession_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_succession_size()
    for i = 0, range - 1 do
        if DCON.dcon_succession_is_valid(i) and func(i + 1 --[[@as succession_id]]) then t[i + 1 --[[@as succession_id]]] = i + 1 --[[@as succession_id]] end
    end
    return t
end

---@param successor_of succession_id valid pop_id
---@return pop_id Data retrieved from succession 
function DATA.succession_get_successor_of(successor_of)
    return DCON.dcon_succession_get_successor_of(successor_of - 1) + 1
end
---@param successor_of pop_id valid pop_id
---@return succession_id succession 
function DATA.get_succession_from_successor_of(successor_of)
    return DCON.dcon_pop_get_succession_as_successor_of(successor_of - 1) + 1
end
---@param succession_id succession_id valid succession id
---@param value pop_id valid pop_id
function DATA.succession_set_successor_of(succession_id, value)
    DCON.dcon_succession_set_successor_of(succession_id - 1, value - 1)
end
---@param successor succession_id valid pop_id
---@return pop_id Data retrieved from succession 
function DATA.succession_get_successor(successor)
    return DCON.dcon_succession_get_successor(successor - 1) + 1
end
---@param successor pop_id valid pop_id
---@return succession_id[] An array of succession 
function DATA.get_succession_from_successor(successor)
    local result = {}
    DATA.for_each_succession_from_successor(successor, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param successor pop_id valid pop_id
---@param func fun(item: succession_id) valid pop_id
function DATA.for_each_succession_from_successor(successor, func)
    ---@type number
    local range = DCON.dcon_pop_get_range_succession_as_successor(successor - 1)
    for i = 0, range - 1 do
        ---@type succession_id
        local accessed_element = DCON.dcon_pop_get_index_succession_as_successor(successor - 1, i) + 1
        if DCON.dcon_succession_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param successor pop_id valid pop_id
---@param func fun(item: succession_id):boolean 
---@return succession_id[]
function DATA.filter_array_succession_from_successor(successor, func)
    ---@type table<succession_id, succession_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_succession_as_successor(successor - 1)
    for i = 0, range - 1 do
        ---@type succession_id
        local accessed_element = DCON.dcon_pop_get_index_succession_as_successor(successor - 1, i) + 1
        if DCON.dcon_succession_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param successor pop_id valid pop_id
---@param func fun(item: succession_id):boolean 
---@return table<succession_id, succession_id> 
function DATA.filter_succession_from_successor(successor, func)
    ---@type table<succession_id, succession_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_succession_as_successor(successor - 1)
    for i = 0, range - 1 do
        ---@type succession_id
        local accessed_element = DCON.dcon_pop_get_index_succession_as_successor(successor - 1, i) + 1
        if DCON.dcon_succession_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param succession_id succession_id valid succession id
---@param value pop_id valid pop_id
function DATA.succession_set_successor(succession_id, value)
    DCON.dcon_succession_set_successor(succession_id - 1, value - 1)
end

local fat_succession_id_metatable = {
    __index = function (t,k)
        if (k == "successor_of") then return DATA.succession_get_successor_of(t.id) end
        if (k == "successor") then return DATA.succession_get_successor(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "successor_of") then
            DATA.succession_set_successor_of(t.id, v)
            return
        end
        if (k == "successor") then
            DATA.succession_set_successor(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id succession_id
---@return fat_succession_id fat_id
function DATA.fatten_succession(id)
    local result = {id = id}
    setmetatable(result, fat_succession_id_metatable)
    return result --[[@as fat_succession_id]]
end
