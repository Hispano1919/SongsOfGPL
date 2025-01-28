local ffi = require("ffi")
----------tax_collector----------


---tax_collector: LSP types---

---Unique identificator for tax_collector entity
---@class (exact) tax_collector_id : table
---@field is_tax_collector number
---@class (exact) fat_tax_collector_id
---@field id tax_collector_id Unique tax_collector id
---@field collector pop_id 
---@field realm realm_id 

---@class struct_tax_collector


ffi.cdef[[
void dcon_delete_tax_collector(int32_t j);
int32_t dcon_force_create_tax_collector(int32_t collector, int32_t realm);
void dcon_tax_collector_set_collector(int32_t, int32_t);
int32_t dcon_tax_collector_get_collector(int32_t);
int32_t dcon_pop_get_tax_collector_as_collector(int32_t);
void dcon_tax_collector_set_realm(int32_t, int32_t);
int32_t dcon_tax_collector_get_realm(int32_t);
int32_t dcon_realm_get_range_tax_collector_as_realm(int32_t);
int32_t dcon_realm_get_index_tax_collector_as_realm(int32_t, int32_t);
bool dcon_tax_collector_is_valid(int32_t);
void dcon_tax_collector_resize(uint32_t sz);
uint32_t dcon_tax_collector_size();
]]

---tax_collector: FFI arrays---

---tax_collector: LUA bindings---

DATA.tax_collector_size = 45000
---@param collector pop_id
---@param realm realm_id
---@return tax_collector_id
function DATA.force_create_tax_collector(collector, realm)
    ---@type tax_collector_id
    local i = DCON.dcon_force_create_tax_collector(collector - 1, realm - 1) + 1
    return i --[[@as tax_collector_id]] 
end
---@param i tax_collector_id
function DATA.delete_tax_collector(i)
    assert(DCON.dcon_tax_collector_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_tax_collector(i - 1)
end
---@param func fun(item: tax_collector_id) 
function DATA.for_each_tax_collector(func)
    ---@type number
    local range = DCON.dcon_tax_collector_size()
    for i = 0, range - 1 do
        if DCON.dcon_tax_collector_is_valid(i) then func(i + 1 --[[@as tax_collector_id]]) end
    end
end
---@param func fun(item: tax_collector_id):boolean 
---@return table<tax_collector_id, tax_collector_id> 
function DATA.filter_tax_collector(func)
    ---@type table<tax_collector_id, tax_collector_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_tax_collector_size()
    for i = 0, range - 1 do
        if DCON.dcon_tax_collector_is_valid(i) and func(i + 1 --[[@as tax_collector_id]]) then t[i + 1 --[[@as tax_collector_id]]] = i + 1 --[[@as tax_collector_id]] end
    end
    return t
end

---@param collector tax_collector_id valid pop_id
---@return pop_id Data retrieved from tax_collector 
function DATA.tax_collector_get_collector(collector)
    return DCON.dcon_tax_collector_get_collector(collector - 1) + 1
end
---@param collector pop_id valid pop_id
---@return tax_collector_id tax_collector 
function DATA.get_tax_collector_from_collector(collector)
    return DCON.dcon_pop_get_tax_collector_as_collector(collector - 1) + 1
end
---@param tax_collector_id tax_collector_id valid tax_collector id
---@param value pop_id valid pop_id
function DATA.tax_collector_set_collector(tax_collector_id, value)
    DCON.dcon_tax_collector_set_collector(tax_collector_id - 1, value - 1)
end
---@param realm tax_collector_id valid realm_id
---@return realm_id Data retrieved from tax_collector 
function DATA.tax_collector_get_realm(realm)
    return DCON.dcon_tax_collector_get_realm(realm - 1) + 1
end
---@param realm realm_id valid realm_id
---@return tax_collector_id[] An array of tax_collector 
function DATA.get_tax_collector_from_realm(realm)
    local result = {}
    DATA.for_each_tax_collector_from_realm(realm, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param realm realm_id valid realm_id
---@param func fun(item: tax_collector_id) valid realm_id
function DATA.for_each_tax_collector_from_realm(realm, func)
    ---@type number
    local range = DCON.dcon_realm_get_range_tax_collector_as_realm(realm - 1)
    for i = 0, range - 1 do
        ---@type tax_collector_id
        local accessed_element = DCON.dcon_realm_get_index_tax_collector_as_realm(realm - 1, i) + 1
        if DCON.dcon_tax_collector_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param realm realm_id valid realm_id
---@param func fun(item: tax_collector_id):boolean 
---@return tax_collector_id[]
function DATA.filter_array_tax_collector_from_realm(realm, func)
    ---@type table<tax_collector_id, tax_collector_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_get_range_tax_collector_as_realm(realm - 1)
    for i = 0, range - 1 do
        ---@type tax_collector_id
        local accessed_element = DCON.dcon_realm_get_index_tax_collector_as_realm(realm - 1, i) + 1
        if DCON.dcon_tax_collector_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param realm realm_id valid realm_id
---@param func fun(item: tax_collector_id):boolean 
---@return table<tax_collector_id, tax_collector_id> 
function DATA.filter_tax_collector_from_realm(realm, func)
    ---@type table<tax_collector_id, tax_collector_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_get_range_tax_collector_as_realm(realm - 1)
    for i = 0, range - 1 do
        ---@type tax_collector_id
        local accessed_element = DCON.dcon_realm_get_index_tax_collector_as_realm(realm - 1, i) + 1
        if DCON.dcon_tax_collector_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param tax_collector_id tax_collector_id valid tax_collector id
---@param value realm_id valid realm_id
function DATA.tax_collector_set_realm(tax_collector_id, value)
    DCON.dcon_tax_collector_set_realm(tax_collector_id - 1, value - 1)
end

local fat_tax_collector_id_metatable = {
    __index = function (t,k)
        if (k == "collector") then return DATA.tax_collector_get_collector(t.id) end
        if (k == "realm") then return DATA.tax_collector_get_realm(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "collector") then
            DATA.tax_collector_set_collector(t.id, v)
            return
        end
        if (k == "realm") then
            DATA.tax_collector_set_realm(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id tax_collector_id
---@return fat_tax_collector_id fat_id
function DATA.fatten_tax_collector(id)
    local result = {id = id}
    setmetatable(result, fat_tax_collector_id_metatable)
    return result --[[@as fat_tax_collector_id]]
end
