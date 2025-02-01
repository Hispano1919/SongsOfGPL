local ffi = require("ffi")
----------realm_leadership----------


---realm_leadership: LSP types---

---Unique identificator for realm_leadership entity
---@class (exact) realm_leadership_id : table
---@field is_realm_leadership number
---@class (exact) fat_realm_leadership_id
---@field id realm_leadership_id Unique realm_leadership id
---@field leader pop_id 
---@field realm realm_id 

---@class struct_realm_leadership


ffi.cdef[[
void dcon_delete_realm_leadership(int32_t j);
int32_t dcon_force_create_realm_leadership(int32_t leader, int32_t realm);
void dcon_realm_leadership_set_leader(int32_t, int32_t);
int32_t dcon_realm_leadership_get_leader(int32_t);
int32_t dcon_pop_get_range_realm_leadership_as_leader(int32_t);
int32_t dcon_pop_get_index_realm_leadership_as_leader(int32_t, int32_t);
void dcon_realm_leadership_set_realm(int32_t, int32_t);
int32_t dcon_realm_leadership_get_realm(int32_t);
int32_t dcon_realm_get_realm_leadership_as_realm(int32_t);
bool dcon_realm_leadership_is_valid(int32_t);
void dcon_realm_leadership_resize(uint32_t sz);
uint32_t dcon_realm_leadership_size();
]]

---realm_leadership: FFI arrays---

---realm_leadership: LUA bindings---

DATA.realm_leadership_size = 15000
---@param leader pop_id
---@param realm realm_id
---@return realm_leadership_id
function DATA.force_create_realm_leadership(leader, realm)
    ---@type realm_leadership_id
    local i = DCON.dcon_force_create_realm_leadership(leader - 1, realm - 1) + 1
    return i --[[@as realm_leadership_id]] 
end
---@param i realm_leadership_id
function DATA.delete_realm_leadership(i)
    assert(DCON.dcon_realm_leadership_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_realm_leadership(i - 1)
end
---@param func fun(item: realm_leadership_id) 
function DATA.for_each_realm_leadership(func)
    ---@type number
    local range = DCON.dcon_realm_leadership_size()
    for i = 0, range - 1 do
        if DCON.dcon_realm_leadership_is_valid(i) then func(i + 1 --[[@as realm_leadership_id]]) end
    end
end
---@param func fun(item: realm_leadership_id):boolean 
---@return table<realm_leadership_id, realm_leadership_id> 
function DATA.filter_realm_leadership(func)
    ---@type table<realm_leadership_id, realm_leadership_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_leadership_size()
    for i = 0, range - 1 do
        if DCON.dcon_realm_leadership_is_valid(i) and func(i + 1 --[[@as realm_leadership_id]]) then t[i + 1 --[[@as realm_leadership_id]]] = i + 1 --[[@as realm_leadership_id]] end
    end
    return t
end

---@param leader realm_leadership_id valid pop_id
---@return pop_id Data retrieved from realm_leadership 
function DATA.realm_leadership_get_leader(leader)
    return DCON.dcon_realm_leadership_get_leader(leader - 1) + 1
end
---@param leader pop_id valid pop_id
---@return realm_leadership_id[] An array of realm_leadership 
function DATA.get_realm_leadership_from_leader(leader)
    local result = {}
    DATA.for_each_realm_leadership_from_leader(leader, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param leader pop_id valid pop_id
---@param func fun(item: realm_leadership_id) valid pop_id
function DATA.for_each_realm_leadership_from_leader(leader, func)
    ---@type number
    local range = DCON.dcon_pop_get_range_realm_leadership_as_leader(leader - 1)
    for i = 0, range - 1 do
        ---@type realm_leadership_id
        local accessed_element = DCON.dcon_pop_get_index_realm_leadership_as_leader(leader - 1, i) + 1
        if DCON.dcon_realm_leadership_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param leader pop_id valid pop_id
---@param func fun(item: realm_leadership_id):boolean 
---@return realm_leadership_id[]
function DATA.filter_array_realm_leadership_from_leader(leader, func)
    ---@type table<realm_leadership_id, realm_leadership_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_realm_leadership_as_leader(leader - 1)
    for i = 0, range - 1 do
        ---@type realm_leadership_id
        local accessed_element = DCON.dcon_pop_get_index_realm_leadership_as_leader(leader - 1, i) + 1
        if DCON.dcon_realm_leadership_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param leader pop_id valid pop_id
---@param func fun(item: realm_leadership_id):boolean 
---@return table<realm_leadership_id, realm_leadership_id> 
function DATA.filter_realm_leadership_from_leader(leader, func)
    ---@type table<realm_leadership_id, realm_leadership_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_realm_leadership_as_leader(leader - 1)
    for i = 0, range - 1 do
        ---@type realm_leadership_id
        local accessed_element = DCON.dcon_pop_get_index_realm_leadership_as_leader(leader - 1, i) + 1
        if DCON.dcon_realm_leadership_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param realm_leadership_id realm_leadership_id valid realm_leadership id
---@param value pop_id valid pop_id
function DATA.realm_leadership_set_leader(realm_leadership_id, value)
    DCON.dcon_realm_leadership_set_leader(realm_leadership_id - 1, value - 1)
end
---@param realm realm_leadership_id valid realm_id
---@return realm_id Data retrieved from realm_leadership 
function DATA.realm_leadership_get_realm(realm)
    return DCON.dcon_realm_leadership_get_realm(realm - 1) + 1
end
---@param realm realm_id valid realm_id
---@return realm_leadership_id realm_leadership 
function DATA.get_realm_leadership_from_realm(realm)
    return DCON.dcon_realm_get_realm_leadership_as_realm(realm - 1) + 1
end
---@param realm_leadership_id realm_leadership_id valid realm_leadership id
---@param value realm_id valid realm_id
function DATA.realm_leadership_set_realm(realm_leadership_id, value)
    DCON.dcon_realm_leadership_set_realm(realm_leadership_id - 1, value - 1)
end

local fat_realm_leadership_id_metatable = {
    __index = function (t,k)
        if (k == "leader") then return DATA.realm_leadership_get_leader(t.id) end
        if (k == "realm") then return DATA.realm_leadership_get_realm(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "leader") then
            DATA.realm_leadership_set_leader(t.id, v)
            return
        end
        if (k == "realm") then
            DATA.realm_leadership_set_realm(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id realm_leadership_id
---@return fat_realm_leadership_id fat_id
function DATA.fatten_realm_leadership(id)
    local result = {id = id}
    setmetatable(result, fat_realm_leadership_id_metatable)
    return result --[[@as fat_realm_leadership_id]]
end
