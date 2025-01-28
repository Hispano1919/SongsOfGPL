local ffi = require("ffi")
----------warband_location----------


---warband_location: LSP types---

---Unique identificator for warband_location entity
---@class (exact) warband_location_id : table
---@field is_warband_location number
---@class (exact) fat_warband_location_id
---@field id warband_location_id Unique warband_location id
---@field location tile_id location of warband
---@field warband warband_id 

---@class struct_warband_location


ffi.cdef[[
void dcon_delete_warband_location(int32_t j);
int32_t dcon_force_create_warband_location(int32_t location, int32_t warband);
void dcon_warband_location_set_location(int32_t, int32_t);
int32_t dcon_warband_location_get_location(int32_t);
int32_t dcon_tile_get_range_warband_location_as_location(int32_t);
int32_t dcon_tile_get_index_warband_location_as_location(int32_t, int32_t);
void dcon_warband_location_set_warband(int32_t, int32_t);
int32_t dcon_warband_location_get_warband(int32_t);
int32_t dcon_warband_get_warband_location_as_warband(int32_t);
bool dcon_warband_location_is_valid(int32_t);
void dcon_warband_location_resize(uint32_t sz);
uint32_t dcon_warband_location_size();
]]

---warband_location: FFI arrays---

---warband_location: LUA bindings---

DATA.warband_location_size = 50000
---@param location tile_id
---@param warband warband_id
---@return warband_location_id
function DATA.force_create_warband_location(location, warband)
    ---@type warband_location_id
    local i = DCON.dcon_force_create_warband_location(location - 1, warband - 1) + 1
    return i --[[@as warband_location_id]] 
end
---@param i warband_location_id
function DATA.delete_warband_location(i)
    assert(DCON.dcon_warband_location_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_warband_location(i - 1)
end
---@param func fun(item: warband_location_id) 
function DATA.for_each_warband_location(func)
    ---@type number
    local range = DCON.dcon_warband_location_size()
    for i = 0, range - 1 do
        if DCON.dcon_warband_location_is_valid(i) then func(i + 1 --[[@as warband_location_id]]) end
    end
end
---@param func fun(item: warband_location_id):boolean 
---@return table<warband_location_id, warband_location_id> 
function DATA.filter_warband_location(func)
    ---@type table<warband_location_id, warband_location_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_warband_location_size()
    for i = 0, range - 1 do
        if DCON.dcon_warband_location_is_valid(i) and func(i + 1 --[[@as warband_location_id]]) then t[i + 1 --[[@as warband_location_id]]] = i + 1 --[[@as warband_location_id]] end
    end
    return t
end

---@param location warband_location_id valid tile_id
---@return tile_id Data retrieved from warband_location 
function DATA.warband_location_get_location(location)
    return DCON.dcon_warband_location_get_location(location - 1) + 1
end
---@param location tile_id valid tile_id
---@return warband_location_id[] An array of warband_location 
function DATA.get_warband_location_from_location(location)
    local result = {}
    DATA.for_each_warband_location_from_location(location, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param location tile_id valid tile_id
---@param func fun(item: warband_location_id) valid tile_id
function DATA.for_each_warband_location_from_location(location, func)
    ---@type number
    local range = DCON.dcon_tile_get_range_warband_location_as_location(location - 1)
    for i = 0, range - 1 do
        ---@type warband_location_id
        local accessed_element = DCON.dcon_tile_get_index_warband_location_as_location(location - 1, i) + 1
        if DCON.dcon_warband_location_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param location tile_id valid tile_id
---@param func fun(item: warband_location_id):boolean 
---@return warband_location_id[]
function DATA.filter_array_warband_location_from_location(location, func)
    ---@type table<warband_location_id, warband_location_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_tile_get_range_warband_location_as_location(location - 1)
    for i = 0, range - 1 do
        ---@type warband_location_id
        local accessed_element = DCON.dcon_tile_get_index_warband_location_as_location(location - 1, i) + 1
        if DCON.dcon_warband_location_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param location tile_id valid tile_id
---@param func fun(item: warband_location_id):boolean 
---@return table<warband_location_id, warband_location_id> 
function DATA.filter_warband_location_from_location(location, func)
    ---@type table<warband_location_id, warband_location_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_tile_get_range_warband_location_as_location(location - 1)
    for i = 0, range - 1 do
        ---@type warband_location_id
        local accessed_element = DCON.dcon_tile_get_index_warband_location_as_location(location - 1, i) + 1
        if DCON.dcon_warband_location_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param warband_location_id warband_location_id valid warband_location id
---@param value tile_id valid tile_id
function DATA.warband_location_set_location(warband_location_id, value)
    DCON.dcon_warband_location_set_location(warband_location_id - 1, value - 1)
end
---@param warband warband_location_id valid warband_id
---@return warband_id Data retrieved from warband_location 
function DATA.warband_location_get_warband(warband)
    return DCON.dcon_warband_location_get_warband(warband - 1) + 1
end
---@param warband warband_id valid warband_id
---@return warband_location_id warband_location 
function DATA.get_warband_location_from_warband(warband)
    return DCON.dcon_warband_get_warband_location_as_warband(warband - 1) + 1
end
---@param warband_location_id warband_location_id valid warband_location id
---@param value warband_id valid warband_id
function DATA.warband_location_set_warband(warband_location_id, value)
    DCON.dcon_warband_location_set_warband(warband_location_id - 1, value - 1)
end

local fat_warband_location_id_metatable = {
    __index = function (t,k)
        if (k == "location") then return DATA.warband_location_get_location(t.id) end
        if (k == "warband") then return DATA.warband_location_get_warband(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "location") then
            DATA.warband_location_set_location(t.id, v)
            return
        end
        if (k == "warband") then
            DATA.warband_location_set_warband(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id warband_location_id
---@return fat_warband_location_id fat_id
function DATA.fatten_warband_location(id)
    local result = {id = id}
    setmetatable(result, fat_warband_location_id_metatable)
    return result --[[@as fat_warband_location_id]]
end
