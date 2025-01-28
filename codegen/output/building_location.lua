local ffi = require("ffi")
----------building_location----------


---building_location: LSP types---

---Unique identificator for building_location entity
---@class (exact) building_location_id : table
---@field is_building_location number
---@class (exact) fat_building_location_id
---@field id building_location_id Unique building_location id
---@field location province_id location of the building
---@field building building_id 

---@class struct_building_location


ffi.cdef[[
void dcon_delete_building_location(int32_t j);
int32_t dcon_force_create_building_location(int32_t location, int32_t building);
void dcon_building_location_set_location(int32_t, int32_t);
int32_t dcon_building_location_get_location(int32_t);
int32_t dcon_province_get_range_building_location_as_location(int32_t);
int32_t dcon_province_get_index_building_location_as_location(int32_t, int32_t);
void dcon_building_location_set_building(int32_t, int32_t);
int32_t dcon_building_location_get_building(int32_t);
int32_t dcon_building_get_building_location_as_building(int32_t);
bool dcon_building_location_is_valid(int32_t);
void dcon_building_location_resize(uint32_t sz);
uint32_t dcon_building_location_size();
]]

---building_location: FFI arrays---

---building_location: LUA bindings---

DATA.building_location_size = 200000
---@param location province_id
---@param building building_id
---@return building_location_id
function DATA.force_create_building_location(location, building)
    ---@type building_location_id
    local i = DCON.dcon_force_create_building_location(location - 1, building - 1) + 1
    return i --[[@as building_location_id]] 
end
---@param i building_location_id
function DATA.delete_building_location(i)
    assert(DCON.dcon_building_location_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_building_location(i - 1)
end
---@param func fun(item: building_location_id) 
function DATA.for_each_building_location(func)
    ---@type number
    local range = DCON.dcon_building_location_size()
    for i = 0, range - 1 do
        if DCON.dcon_building_location_is_valid(i) then func(i + 1 --[[@as building_location_id]]) end
    end
end
---@param func fun(item: building_location_id):boolean 
---@return table<building_location_id, building_location_id> 
function DATA.filter_building_location(func)
    ---@type table<building_location_id, building_location_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_building_location_size()
    for i = 0, range - 1 do
        if DCON.dcon_building_location_is_valid(i) and func(i + 1 --[[@as building_location_id]]) then t[i + 1 --[[@as building_location_id]]] = i + 1 --[[@as building_location_id]] end
    end
    return t
end

---@param location building_location_id valid province_id
---@return province_id Data retrieved from building_location 
function DATA.building_location_get_location(location)
    return DCON.dcon_building_location_get_location(location - 1) + 1
end
---@param location province_id valid province_id
---@return building_location_id[] An array of building_location 
function DATA.get_building_location_from_location(location)
    local result = {}
    DATA.for_each_building_location_from_location(location, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param location province_id valid province_id
---@param func fun(item: building_location_id) valid province_id
function DATA.for_each_building_location_from_location(location, func)
    ---@type number
    local range = DCON.dcon_province_get_range_building_location_as_location(location - 1)
    for i = 0, range - 1 do
        ---@type building_location_id
        local accessed_element = DCON.dcon_province_get_index_building_location_as_location(location - 1, i) + 1
        if DCON.dcon_building_location_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param location province_id valid province_id
---@param func fun(item: building_location_id):boolean 
---@return building_location_id[]
function DATA.filter_array_building_location_from_location(location, func)
    ---@type table<building_location_id, building_location_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_province_get_range_building_location_as_location(location - 1)
    for i = 0, range - 1 do
        ---@type building_location_id
        local accessed_element = DCON.dcon_province_get_index_building_location_as_location(location - 1, i) + 1
        if DCON.dcon_building_location_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param location province_id valid province_id
---@param func fun(item: building_location_id):boolean 
---@return table<building_location_id, building_location_id> 
function DATA.filter_building_location_from_location(location, func)
    ---@type table<building_location_id, building_location_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_province_get_range_building_location_as_location(location - 1)
    for i = 0, range - 1 do
        ---@type building_location_id
        local accessed_element = DCON.dcon_province_get_index_building_location_as_location(location - 1, i) + 1
        if DCON.dcon_building_location_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param building_location_id building_location_id valid building_location id
---@param value province_id valid province_id
function DATA.building_location_set_location(building_location_id, value)
    DCON.dcon_building_location_set_location(building_location_id - 1, value - 1)
end
---@param building building_location_id valid building_id
---@return building_id Data retrieved from building_location 
function DATA.building_location_get_building(building)
    return DCON.dcon_building_location_get_building(building - 1) + 1
end
---@param building building_id valid building_id
---@return building_location_id building_location 
function DATA.get_building_location_from_building(building)
    return DCON.dcon_building_get_building_location_as_building(building - 1) + 1
end
---@param building_location_id building_location_id valid building_location id
---@param value building_id valid building_id
function DATA.building_location_set_building(building_location_id, value)
    DCON.dcon_building_location_set_building(building_location_id - 1, value - 1)
end

local fat_building_location_id_metatable = {
    __index = function (t,k)
        if (k == "location") then return DATA.building_location_get_location(t.id) end
        if (k == "building") then return DATA.building_location_get_building(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "location") then
            DATA.building_location_set_location(t.id, v)
            return
        end
        if (k == "building") then
            DATA.building_location_set_building(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id building_location_id
---@return fat_building_location_id fat_id
function DATA.fatten_building_location(id)
    local result = {id = id}
    setmetatable(result, fat_building_location_id_metatable)
    return result --[[@as fat_building_location_id]]
end
