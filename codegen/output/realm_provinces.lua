local ffi = require("ffi")
----------realm_provinces----------


---realm_provinces: LSP types---

---Unique identificator for realm_provinces entity
---@class (exact) realm_provinces_id : table
---@field is_realm_provinces number
---@class (exact) fat_realm_provinces_id
---@field id realm_provinces_id Unique realm_provinces id
---@field province province_id 
---@field realm realm_id 

---@class struct_realm_provinces


ffi.cdef[[
void dcon_delete_realm_provinces(int32_t j);
int32_t dcon_force_create_realm_provinces(int32_t province, int32_t realm);
void dcon_realm_provinces_set_province(int32_t, int32_t);
int32_t dcon_realm_provinces_get_province(int32_t);
int32_t dcon_province_get_realm_provinces_as_province(int32_t);
void dcon_realm_provinces_set_realm(int32_t, int32_t);
int32_t dcon_realm_provinces_get_realm(int32_t);
int32_t dcon_realm_get_range_realm_provinces_as_realm(int32_t);
int32_t dcon_realm_get_index_realm_provinces_as_realm(int32_t, int32_t);
bool dcon_realm_provinces_is_valid(int32_t);
void dcon_realm_provinces_resize(uint32_t sz);
uint32_t dcon_realm_provinces_size();
]]

---realm_provinces: FFI arrays---

---realm_provinces: LUA bindings---

DATA.realm_provinces_size = 30000
---@param province province_id
---@param realm realm_id
---@return realm_provinces_id
function DATA.force_create_realm_provinces(province, realm)
    ---@type realm_provinces_id
    local i = DCON.dcon_force_create_realm_provinces(province - 1, realm - 1) + 1
    return i --[[@as realm_provinces_id]] 
end
---@param i realm_provinces_id
function DATA.delete_realm_provinces(i)
    assert(DCON.dcon_realm_provinces_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_realm_provinces(i - 1)
end
---@param func fun(item: realm_provinces_id) 
function DATA.for_each_realm_provinces(func)
    ---@type number
    local range = DCON.dcon_realm_provinces_size()
    for i = 0, range - 1 do
        if DCON.dcon_realm_provinces_is_valid(i) then func(i + 1 --[[@as realm_provinces_id]]) end
    end
end
---@param func fun(item: realm_provinces_id):boolean 
---@return table<realm_provinces_id, realm_provinces_id> 
function DATA.filter_realm_provinces(func)
    ---@type table<realm_provinces_id, realm_provinces_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_provinces_size()
    for i = 0, range - 1 do
        if DCON.dcon_realm_provinces_is_valid(i) and func(i + 1 --[[@as realm_provinces_id]]) then t[i + 1 --[[@as realm_provinces_id]]] = i + 1 --[[@as realm_provinces_id]] end
    end
    return t
end

---@param province realm_provinces_id valid province_id
---@return province_id Data retrieved from realm_provinces 
function DATA.realm_provinces_get_province(province)
    return DCON.dcon_realm_provinces_get_province(province - 1) + 1
end
---@param province province_id valid province_id
---@return realm_provinces_id realm_provinces 
function DATA.get_realm_provinces_from_province(province)
    return DCON.dcon_province_get_realm_provinces_as_province(province - 1) + 1
end
---@param realm_provinces_id realm_provinces_id valid realm_provinces id
---@param value province_id valid province_id
function DATA.realm_provinces_set_province(realm_provinces_id, value)
    DCON.dcon_realm_provinces_set_province(realm_provinces_id - 1, value - 1)
end
---@param realm realm_provinces_id valid realm_id
---@return realm_id Data retrieved from realm_provinces 
function DATA.realm_provinces_get_realm(realm)
    return DCON.dcon_realm_provinces_get_realm(realm - 1) + 1
end
---@param realm realm_id valid realm_id
---@return realm_provinces_id[] An array of realm_provinces 
function DATA.get_realm_provinces_from_realm(realm)
    local result = {}
    DATA.for_each_realm_provinces_from_realm(realm, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param realm realm_id valid realm_id
---@param func fun(item: realm_provinces_id) valid realm_id
function DATA.for_each_realm_provinces_from_realm(realm, func)
    ---@type number
    local range = DCON.dcon_realm_get_range_realm_provinces_as_realm(realm - 1)
    for i = 0, range - 1 do
        ---@type realm_provinces_id
        local accessed_element = DCON.dcon_realm_get_index_realm_provinces_as_realm(realm - 1, i) + 1
        if DCON.dcon_realm_provinces_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param realm realm_id valid realm_id
---@param func fun(item: realm_provinces_id):boolean 
---@return realm_provinces_id[]
function DATA.filter_array_realm_provinces_from_realm(realm, func)
    ---@type table<realm_provinces_id, realm_provinces_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_get_range_realm_provinces_as_realm(realm - 1)
    for i = 0, range - 1 do
        ---@type realm_provinces_id
        local accessed_element = DCON.dcon_realm_get_index_realm_provinces_as_realm(realm - 1, i) + 1
        if DCON.dcon_realm_provinces_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param realm realm_id valid realm_id
---@param func fun(item: realm_provinces_id):boolean 
---@return table<realm_provinces_id, realm_provinces_id> 
function DATA.filter_realm_provinces_from_realm(realm, func)
    ---@type table<realm_provinces_id, realm_provinces_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_get_range_realm_provinces_as_realm(realm - 1)
    for i = 0, range - 1 do
        ---@type realm_provinces_id
        local accessed_element = DCON.dcon_realm_get_index_realm_provinces_as_realm(realm - 1, i) + 1
        if DCON.dcon_realm_provinces_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param realm_provinces_id realm_provinces_id valid realm_provinces id
---@param value realm_id valid realm_id
function DATA.realm_provinces_set_realm(realm_provinces_id, value)
    DCON.dcon_realm_provinces_set_realm(realm_provinces_id - 1, value - 1)
end

local fat_realm_provinces_id_metatable = {
    __index = function (t,k)
        if (k == "province") then return DATA.realm_provinces_get_province(t.id) end
        if (k == "realm") then return DATA.realm_provinces_get_realm(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "province") then
            DATA.realm_provinces_set_province(t.id, v)
            return
        end
        if (k == "realm") then
            DATA.realm_provinces_set_realm(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id realm_provinces_id
---@return fat_realm_provinces_id fat_id
function DATA.fatten_realm_provinces(id)
    local result = {id = id}
    setmetatable(result, fat_realm_provinces_id_metatable)
    return result --[[@as fat_realm_provinces_id]]
end
