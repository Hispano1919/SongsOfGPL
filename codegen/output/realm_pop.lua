local ffi = require("ffi")
----------realm_pop----------


---realm_pop: LSP types---

---Unique identificator for realm_pop entity
---@class (exact) realm_pop_id : table
---@field is_realm_pop number
---@class (exact) fat_realm_pop_id
---@field id realm_pop_id Unique realm_pop id
---@field realm realm_id Represents the home realm of the character
---@field pop pop_id 

---@class struct_realm_pop


ffi.cdef[[
void dcon_delete_realm_pop(int32_t j);
int32_t dcon_force_create_realm_pop(int32_t realm, int32_t pop);
void dcon_realm_pop_set_realm(int32_t, int32_t);
int32_t dcon_realm_pop_get_realm(int32_t);
int32_t dcon_realm_get_range_realm_pop_as_realm(int32_t);
int32_t dcon_realm_get_index_realm_pop_as_realm(int32_t, int32_t);
void dcon_realm_pop_set_pop(int32_t, int32_t);
int32_t dcon_realm_pop_get_pop(int32_t);
int32_t dcon_pop_get_realm_pop_as_pop(int32_t);
bool dcon_realm_pop_is_valid(int32_t);
void dcon_realm_pop_resize(uint32_t sz);
uint32_t dcon_realm_pop_size();
]]

---realm_pop: FFI arrays---

---realm_pop: LUA bindings---

DATA.realm_pop_size = 300000
---@param realm realm_id
---@param pop pop_id
---@return realm_pop_id
function DATA.force_create_realm_pop(realm, pop)
    ---@type realm_pop_id
    local i = DCON.dcon_force_create_realm_pop(realm - 1, pop - 1) + 1
    return i --[[@as realm_pop_id]] 
end
---@param i realm_pop_id
function DATA.delete_realm_pop(i)
    assert(DCON.dcon_realm_pop_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_realm_pop(i - 1)
end
---@param func fun(item: realm_pop_id) 
function DATA.for_each_realm_pop(func)
    ---@type number
    local range = DCON.dcon_realm_pop_size()
    for i = 0, range - 1 do
        if DCON.dcon_realm_pop_is_valid(i) then func(i + 1 --[[@as realm_pop_id]]) end
    end
end
---@param func fun(item: realm_pop_id):boolean 
---@return table<realm_pop_id, realm_pop_id> 
function DATA.filter_realm_pop(func)
    ---@type table<realm_pop_id, realm_pop_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_pop_size()
    for i = 0, range - 1 do
        if DCON.dcon_realm_pop_is_valid(i) and func(i + 1 --[[@as realm_pop_id]]) then t[i + 1 --[[@as realm_pop_id]]] = i + 1 --[[@as realm_pop_id]] end
    end
    return t
end

---@param realm realm_pop_id valid realm_id
---@return realm_id Data retrieved from realm_pop 
function DATA.realm_pop_get_realm(realm)
    return DCON.dcon_realm_pop_get_realm(realm - 1) + 1
end
---@param realm realm_id valid realm_id
---@return realm_pop_id[] An array of realm_pop 
function DATA.get_realm_pop_from_realm(realm)
    local result = {}
    DATA.for_each_realm_pop_from_realm(realm, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param realm realm_id valid realm_id
---@param func fun(item: realm_pop_id) valid realm_id
function DATA.for_each_realm_pop_from_realm(realm, func)
    ---@type number
    local range = DCON.dcon_realm_get_range_realm_pop_as_realm(realm - 1)
    for i = 0, range - 1 do
        ---@type realm_pop_id
        local accessed_element = DCON.dcon_realm_get_index_realm_pop_as_realm(realm - 1, i) + 1
        if DCON.dcon_realm_pop_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param realm realm_id valid realm_id
---@param func fun(item: realm_pop_id):boolean 
---@return realm_pop_id[]
function DATA.filter_array_realm_pop_from_realm(realm, func)
    ---@type table<realm_pop_id, realm_pop_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_get_range_realm_pop_as_realm(realm - 1)
    for i = 0, range - 1 do
        ---@type realm_pop_id
        local accessed_element = DCON.dcon_realm_get_index_realm_pop_as_realm(realm - 1, i) + 1
        if DCON.dcon_realm_pop_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param realm realm_id valid realm_id
---@param func fun(item: realm_pop_id):boolean 
---@return table<realm_pop_id, realm_pop_id> 
function DATA.filter_realm_pop_from_realm(realm, func)
    ---@type table<realm_pop_id, realm_pop_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_get_range_realm_pop_as_realm(realm - 1)
    for i = 0, range - 1 do
        ---@type realm_pop_id
        local accessed_element = DCON.dcon_realm_get_index_realm_pop_as_realm(realm - 1, i) + 1
        if DCON.dcon_realm_pop_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param realm_pop_id realm_pop_id valid realm_pop id
---@param value realm_id valid realm_id
function DATA.realm_pop_set_realm(realm_pop_id, value)
    DCON.dcon_realm_pop_set_realm(realm_pop_id - 1, value - 1)
end
---@param pop realm_pop_id valid pop_id
---@return pop_id Data retrieved from realm_pop 
function DATA.realm_pop_get_pop(pop)
    return DCON.dcon_realm_pop_get_pop(pop - 1) + 1
end
---@param pop pop_id valid pop_id
---@return realm_pop_id realm_pop 
function DATA.get_realm_pop_from_pop(pop)
    return DCON.dcon_pop_get_realm_pop_as_pop(pop - 1) + 1
end
---@param realm_pop_id realm_pop_id valid realm_pop id
---@param value pop_id valid pop_id
function DATA.realm_pop_set_pop(realm_pop_id, value)
    DCON.dcon_realm_pop_set_pop(realm_pop_id - 1, value - 1)
end

local fat_realm_pop_id_metatable = {
    __index = function (t,k)
        if (k == "realm") then return DATA.realm_pop_get_realm(t.id) end
        if (k == "pop") then return DATA.realm_pop_get_pop(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "realm") then
            DATA.realm_pop_set_realm(t.id, v)
            return
        end
        if (k == "pop") then
            DATA.realm_pop_set_pop(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id realm_pop_id
---@return fat_realm_pop_id fat_id
function DATA.fatten_realm_pop(id)
    local result = {id = id}
    setmetatable(result, fat_realm_pop_id_metatable)
    return result --[[@as fat_realm_pop_id]]
end
