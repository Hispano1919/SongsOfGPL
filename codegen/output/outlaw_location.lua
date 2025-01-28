local ffi = require("ffi")
----------outlaw_location----------


---outlaw_location: LSP types---

---Unique identificator for outlaw_location entity
---@class (exact) outlaw_location_id : table
---@field is_outlaw_location number
---@class (exact) fat_outlaw_location_id
---@field id outlaw_location_id Unique outlaw_location id
---@field location province_id location of the outlaw
---@field outlaw pop_id 

---@class struct_outlaw_location


ffi.cdef[[
void dcon_delete_outlaw_location(int32_t j);
int32_t dcon_force_create_outlaw_location(int32_t location, int32_t outlaw);
void dcon_outlaw_location_set_location(int32_t, int32_t);
int32_t dcon_outlaw_location_get_location(int32_t);
int32_t dcon_province_get_range_outlaw_location_as_location(int32_t);
int32_t dcon_province_get_index_outlaw_location_as_location(int32_t, int32_t);
void dcon_outlaw_location_set_outlaw(int32_t, int32_t);
int32_t dcon_outlaw_location_get_outlaw(int32_t);
int32_t dcon_pop_get_outlaw_location_as_outlaw(int32_t);
bool dcon_outlaw_location_is_valid(int32_t);
void dcon_outlaw_location_resize(uint32_t sz);
uint32_t dcon_outlaw_location_size();
]]

---outlaw_location: FFI arrays---

---outlaw_location: LUA bindings---

DATA.outlaw_location_size = 300000
---@param location province_id
---@param outlaw pop_id
---@return outlaw_location_id
function DATA.force_create_outlaw_location(location, outlaw)
    ---@type outlaw_location_id
    local i = DCON.dcon_force_create_outlaw_location(location - 1, outlaw - 1) + 1
    return i --[[@as outlaw_location_id]] 
end
---@param i outlaw_location_id
function DATA.delete_outlaw_location(i)
    assert(DCON.dcon_outlaw_location_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_outlaw_location(i - 1)
end
---@param func fun(item: outlaw_location_id) 
function DATA.for_each_outlaw_location(func)
    ---@type number
    local range = DCON.dcon_outlaw_location_size()
    for i = 0, range - 1 do
        if DCON.dcon_outlaw_location_is_valid(i) then func(i + 1 --[[@as outlaw_location_id]]) end
    end
end
---@param func fun(item: outlaw_location_id):boolean 
---@return table<outlaw_location_id, outlaw_location_id> 
function DATA.filter_outlaw_location(func)
    ---@type table<outlaw_location_id, outlaw_location_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_outlaw_location_size()
    for i = 0, range - 1 do
        if DCON.dcon_outlaw_location_is_valid(i) and func(i + 1 --[[@as outlaw_location_id]]) then t[i + 1 --[[@as outlaw_location_id]]] = i + 1 --[[@as outlaw_location_id]] end
    end
    return t
end

---@param location outlaw_location_id valid province_id
---@return province_id Data retrieved from outlaw_location 
function DATA.outlaw_location_get_location(location)
    return DCON.dcon_outlaw_location_get_location(location - 1) + 1
end
---@param location province_id valid province_id
---@return outlaw_location_id[] An array of outlaw_location 
function DATA.get_outlaw_location_from_location(location)
    local result = {}
    DATA.for_each_outlaw_location_from_location(location, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param location province_id valid province_id
---@param func fun(item: outlaw_location_id) valid province_id
function DATA.for_each_outlaw_location_from_location(location, func)
    ---@type number
    local range = DCON.dcon_province_get_range_outlaw_location_as_location(location - 1)
    for i = 0, range - 1 do
        ---@type outlaw_location_id
        local accessed_element = DCON.dcon_province_get_index_outlaw_location_as_location(location - 1, i) + 1
        if DCON.dcon_outlaw_location_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param location province_id valid province_id
---@param func fun(item: outlaw_location_id):boolean 
---@return outlaw_location_id[]
function DATA.filter_array_outlaw_location_from_location(location, func)
    ---@type table<outlaw_location_id, outlaw_location_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_province_get_range_outlaw_location_as_location(location - 1)
    for i = 0, range - 1 do
        ---@type outlaw_location_id
        local accessed_element = DCON.dcon_province_get_index_outlaw_location_as_location(location - 1, i) + 1
        if DCON.dcon_outlaw_location_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param location province_id valid province_id
---@param func fun(item: outlaw_location_id):boolean 
---@return table<outlaw_location_id, outlaw_location_id> 
function DATA.filter_outlaw_location_from_location(location, func)
    ---@type table<outlaw_location_id, outlaw_location_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_province_get_range_outlaw_location_as_location(location - 1)
    for i = 0, range - 1 do
        ---@type outlaw_location_id
        local accessed_element = DCON.dcon_province_get_index_outlaw_location_as_location(location - 1, i) + 1
        if DCON.dcon_outlaw_location_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param outlaw_location_id outlaw_location_id valid outlaw_location id
---@param value province_id valid province_id
function DATA.outlaw_location_set_location(outlaw_location_id, value)
    DCON.dcon_outlaw_location_set_location(outlaw_location_id - 1, value - 1)
end
---@param outlaw outlaw_location_id valid pop_id
---@return pop_id Data retrieved from outlaw_location 
function DATA.outlaw_location_get_outlaw(outlaw)
    return DCON.dcon_outlaw_location_get_outlaw(outlaw - 1) + 1
end
---@param outlaw pop_id valid pop_id
---@return outlaw_location_id outlaw_location 
function DATA.get_outlaw_location_from_outlaw(outlaw)
    return DCON.dcon_pop_get_outlaw_location_as_outlaw(outlaw - 1) + 1
end
---@param outlaw_location_id outlaw_location_id valid outlaw_location id
---@param value pop_id valid pop_id
function DATA.outlaw_location_set_outlaw(outlaw_location_id, value)
    DCON.dcon_outlaw_location_set_outlaw(outlaw_location_id - 1, value - 1)
end

local fat_outlaw_location_id_metatable = {
    __index = function (t,k)
        if (k == "location") then return DATA.outlaw_location_get_location(t.id) end
        if (k == "outlaw") then return DATA.outlaw_location_get_outlaw(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "location") then
            DATA.outlaw_location_set_location(t.id, v)
            return
        end
        if (k == "outlaw") then
            DATA.outlaw_location_set_outlaw(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id outlaw_location_id
---@return fat_outlaw_location_id fat_id
function DATA.fatten_outlaw_location(id)
    local result = {id = id}
    setmetatable(result, fat_outlaw_location_id_metatable)
    return result --[[@as fat_outlaw_location_id]]
end
