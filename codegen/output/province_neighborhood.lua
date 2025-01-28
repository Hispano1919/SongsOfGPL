local ffi = require("ffi")
----------province_neighborhood----------


---province_neighborhood: LSP types---

---Unique identificator for province_neighborhood entity
---@class (exact) province_neighborhood_id : table
---@field is_province_neighborhood number
---@class (exact) fat_province_neighborhood_id
---@field id province_neighborhood_id Unique province_neighborhood id
---@field origin province_id 
---@field target province_id 

---@class struct_province_neighborhood


ffi.cdef[[
void dcon_delete_province_neighborhood(int32_t j);
int32_t dcon_force_create_province_neighborhood(int32_t origin, int32_t target);
void dcon_province_neighborhood_set_origin(int32_t, int32_t);
int32_t dcon_province_neighborhood_get_origin(int32_t);
int32_t dcon_province_get_range_province_neighborhood_as_origin(int32_t);
int32_t dcon_province_get_index_province_neighborhood_as_origin(int32_t, int32_t);
void dcon_province_neighborhood_set_target(int32_t, int32_t);
int32_t dcon_province_neighborhood_get_target(int32_t);
int32_t dcon_province_get_range_province_neighborhood_as_target(int32_t);
int32_t dcon_province_get_index_province_neighborhood_as_target(int32_t, int32_t);
bool dcon_province_neighborhood_is_valid(int32_t);
void dcon_province_neighborhood_resize(uint32_t sz);
uint32_t dcon_province_neighborhood_size();
]]

---province_neighborhood: FFI arrays---

---province_neighborhood: LUA bindings---

DATA.province_neighborhood_size = 250000
---@param origin province_id
---@param target province_id
---@return province_neighborhood_id
function DATA.force_create_province_neighborhood(origin, target)
    ---@type province_neighborhood_id
    local i = DCON.dcon_force_create_province_neighborhood(origin - 1, target - 1) + 1
    return i --[[@as province_neighborhood_id]] 
end
---@param i province_neighborhood_id
function DATA.delete_province_neighborhood(i)
    assert(DCON.dcon_province_neighborhood_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_province_neighborhood(i - 1)
end
---@param func fun(item: province_neighborhood_id) 
function DATA.for_each_province_neighborhood(func)
    ---@type number
    local range = DCON.dcon_province_neighborhood_size()
    for i = 0, range - 1 do
        if DCON.dcon_province_neighborhood_is_valid(i) then func(i + 1 --[[@as province_neighborhood_id]]) end
    end
end
---@param func fun(item: province_neighborhood_id):boolean 
---@return table<province_neighborhood_id, province_neighborhood_id> 
function DATA.filter_province_neighborhood(func)
    ---@type table<province_neighborhood_id, province_neighborhood_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_province_neighborhood_size()
    for i = 0, range - 1 do
        if DCON.dcon_province_neighborhood_is_valid(i) and func(i + 1 --[[@as province_neighborhood_id]]) then t[i + 1 --[[@as province_neighborhood_id]]] = i + 1 --[[@as province_neighborhood_id]] end
    end
    return t
end

---@param origin province_neighborhood_id valid province_id
---@return province_id Data retrieved from province_neighborhood 
function DATA.province_neighborhood_get_origin(origin)
    return DCON.dcon_province_neighborhood_get_origin(origin - 1) + 1
end
---@param origin province_id valid province_id
---@return province_neighborhood_id[] An array of province_neighborhood 
function DATA.get_province_neighborhood_from_origin(origin)
    local result = {}
    DATA.for_each_province_neighborhood_from_origin(origin, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param origin province_id valid province_id
---@param func fun(item: province_neighborhood_id) valid province_id
function DATA.for_each_province_neighborhood_from_origin(origin, func)
    ---@type number
    local range = DCON.dcon_province_get_range_province_neighborhood_as_origin(origin - 1)
    for i = 0, range - 1 do
        ---@type province_neighborhood_id
        local accessed_element = DCON.dcon_province_get_index_province_neighborhood_as_origin(origin - 1, i) + 1
        if DCON.dcon_province_neighborhood_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param origin province_id valid province_id
---@param func fun(item: province_neighborhood_id):boolean 
---@return province_neighborhood_id[]
function DATA.filter_array_province_neighborhood_from_origin(origin, func)
    ---@type table<province_neighborhood_id, province_neighborhood_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_province_get_range_province_neighborhood_as_origin(origin - 1)
    for i = 0, range - 1 do
        ---@type province_neighborhood_id
        local accessed_element = DCON.dcon_province_get_index_province_neighborhood_as_origin(origin - 1, i) + 1
        if DCON.dcon_province_neighborhood_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param origin province_id valid province_id
---@param func fun(item: province_neighborhood_id):boolean 
---@return table<province_neighborhood_id, province_neighborhood_id> 
function DATA.filter_province_neighborhood_from_origin(origin, func)
    ---@type table<province_neighborhood_id, province_neighborhood_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_province_get_range_province_neighborhood_as_origin(origin - 1)
    for i = 0, range - 1 do
        ---@type province_neighborhood_id
        local accessed_element = DCON.dcon_province_get_index_province_neighborhood_as_origin(origin - 1, i) + 1
        if DCON.dcon_province_neighborhood_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param province_neighborhood_id province_neighborhood_id valid province_neighborhood id
---@param value province_id valid province_id
function DATA.province_neighborhood_set_origin(province_neighborhood_id, value)
    DCON.dcon_province_neighborhood_set_origin(province_neighborhood_id - 1, value - 1)
end
---@param target province_neighborhood_id valid province_id
---@return province_id Data retrieved from province_neighborhood 
function DATA.province_neighborhood_get_target(target)
    return DCON.dcon_province_neighborhood_get_target(target - 1) + 1
end
---@param target province_id valid province_id
---@return province_neighborhood_id[] An array of province_neighborhood 
function DATA.get_province_neighborhood_from_target(target)
    local result = {}
    DATA.for_each_province_neighborhood_from_target(target, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param target province_id valid province_id
---@param func fun(item: province_neighborhood_id) valid province_id
function DATA.for_each_province_neighborhood_from_target(target, func)
    ---@type number
    local range = DCON.dcon_province_get_range_province_neighborhood_as_target(target - 1)
    for i = 0, range - 1 do
        ---@type province_neighborhood_id
        local accessed_element = DCON.dcon_province_get_index_province_neighborhood_as_target(target - 1, i) + 1
        if DCON.dcon_province_neighborhood_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param target province_id valid province_id
---@param func fun(item: province_neighborhood_id):boolean 
---@return province_neighborhood_id[]
function DATA.filter_array_province_neighborhood_from_target(target, func)
    ---@type table<province_neighborhood_id, province_neighborhood_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_province_get_range_province_neighborhood_as_target(target - 1)
    for i = 0, range - 1 do
        ---@type province_neighborhood_id
        local accessed_element = DCON.dcon_province_get_index_province_neighborhood_as_target(target - 1, i) + 1
        if DCON.dcon_province_neighborhood_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param target province_id valid province_id
---@param func fun(item: province_neighborhood_id):boolean 
---@return table<province_neighborhood_id, province_neighborhood_id> 
function DATA.filter_province_neighborhood_from_target(target, func)
    ---@type table<province_neighborhood_id, province_neighborhood_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_province_get_range_province_neighborhood_as_target(target - 1)
    for i = 0, range - 1 do
        ---@type province_neighborhood_id
        local accessed_element = DCON.dcon_province_get_index_province_neighborhood_as_target(target - 1, i) + 1
        if DCON.dcon_province_neighborhood_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param province_neighborhood_id province_neighborhood_id valid province_neighborhood id
---@param value province_id valid province_id
function DATA.province_neighborhood_set_target(province_neighborhood_id, value)
    DCON.dcon_province_neighborhood_set_target(province_neighborhood_id - 1, value - 1)
end

local fat_province_neighborhood_id_metatable = {
    __index = function (t,k)
        if (k == "origin") then return DATA.province_neighborhood_get_origin(t.id) end
        if (k == "target") then return DATA.province_neighborhood_get_target(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "origin") then
            DATA.province_neighborhood_set_origin(t.id, v)
            return
        end
        if (k == "target") then
            DATA.province_neighborhood_set_target(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id province_neighborhood_id
---@return fat_province_neighborhood_id fat_id
function DATA.fatten_province_neighborhood(id)
    local result = {id = id}
    setmetatable(result, fat_province_neighborhood_id_metatable)
    return result --[[@as fat_province_neighborhood_id]]
end
