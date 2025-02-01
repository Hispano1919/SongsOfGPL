local ffi = require("ffi")
----------estate_location----------


---estate_location: LSP types---

---Unique identificator for estate_location entity
---@class (exact) estate_location_id : table
---@field is_estate_location number
---@class (exact) fat_estate_location_id
---@field id estate_location_id Unique estate_location id
---@field province province_id location of the estate
---@field estate estate_id 

---@class struct_estate_location


ffi.cdef[[
void dcon_delete_estate_location(int32_t j);
int32_t dcon_force_create_estate_location(int32_t province, int32_t estate);
void dcon_estate_location_set_province(int32_t, int32_t);
int32_t dcon_estate_location_get_province(int32_t);
int32_t dcon_province_get_range_estate_location_as_province(int32_t);
int32_t dcon_province_get_index_estate_location_as_province(int32_t, int32_t);
void dcon_estate_location_set_estate(int32_t, int32_t);
int32_t dcon_estate_location_get_estate(int32_t);
int32_t dcon_estate_get_estate_location_as_estate(int32_t);
bool dcon_estate_location_is_valid(int32_t);
void dcon_estate_location_resize(uint32_t sz);
uint32_t dcon_estate_location_size();
]]

---estate_location: FFI arrays---

---estate_location: LUA bindings---

DATA.estate_location_size = 200000
---@param province province_id
---@param estate estate_id
---@return estate_location_id
function DATA.force_create_estate_location(province, estate)
    ---@type estate_location_id
    local i = DCON.dcon_force_create_estate_location(province - 1, estate - 1) + 1
    return i --[[@as estate_location_id]] 
end
---@param i estate_location_id
function DATA.delete_estate_location(i)
    assert(DCON.dcon_estate_location_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_estate_location(i - 1)
end
---@param func fun(item: estate_location_id) 
function DATA.for_each_estate_location(func)
    ---@type number
    local range = DCON.dcon_estate_location_size()
    for i = 0, range - 1 do
        if DCON.dcon_estate_location_is_valid(i) then func(i + 1 --[[@as estate_location_id]]) end
    end
end
---@param func fun(item: estate_location_id):boolean 
---@return table<estate_location_id, estate_location_id> 
function DATA.filter_estate_location(func)
    ---@type table<estate_location_id, estate_location_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_estate_location_size()
    for i = 0, range - 1 do
        if DCON.dcon_estate_location_is_valid(i) and func(i + 1 --[[@as estate_location_id]]) then t[i + 1 --[[@as estate_location_id]]] = i + 1 --[[@as estate_location_id]] end
    end
    return t
end

---@param province estate_location_id valid province_id
---@return province_id Data retrieved from estate_location 
function DATA.estate_location_get_province(province)
    return DCON.dcon_estate_location_get_province(province - 1) + 1
end
---@param province province_id valid province_id
---@return estate_location_id[] An array of estate_location 
function DATA.get_estate_location_from_province(province)
    local result = {}
    DATA.for_each_estate_location_from_province(province, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param province province_id valid province_id
---@param func fun(item: estate_location_id) valid province_id
function DATA.for_each_estate_location_from_province(province, func)
    ---@type number
    local range = DCON.dcon_province_get_range_estate_location_as_province(province - 1)
    for i = 0, range - 1 do
        ---@type estate_location_id
        local accessed_element = DCON.dcon_province_get_index_estate_location_as_province(province - 1, i) + 1
        if DCON.dcon_estate_location_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param province province_id valid province_id
---@param func fun(item: estate_location_id):boolean 
---@return estate_location_id[]
function DATA.filter_array_estate_location_from_province(province, func)
    ---@type table<estate_location_id, estate_location_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_province_get_range_estate_location_as_province(province - 1)
    for i = 0, range - 1 do
        ---@type estate_location_id
        local accessed_element = DCON.dcon_province_get_index_estate_location_as_province(province - 1, i) + 1
        if DCON.dcon_estate_location_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param province province_id valid province_id
---@param func fun(item: estate_location_id):boolean 
---@return table<estate_location_id, estate_location_id> 
function DATA.filter_estate_location_from_province(province, func)
    ---@type table<estate_location_id, estate_location_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_province_get_range_estate_location_as_province(province - 1)
    for i = 0, range - 1 do
        ---@type estate_location_id
        local accessed_element = DCON.dcon_province_get_index_estate_location_as_province(province - 1, i) + 1
        if DCON.dcon_estate_location_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param estate_location_id estate_location_id valid estate_location id
---@param value province_id valid province_id
function DATA.estate_location_set_province(estate_location_id, value)
    DCON.dcon_estate_location_set_province(estate_location_id - 1, value - 1)
end
---@param estate estate_location_id valid estate_id
---@return estate_id Data retrieved from estate_location 
function DATA.estate_location_get_estate(estate)
    return DCON.dcon_estate_location_get_estate(estate - 1) + 1
end
---@param estate estate_id valid estate_id
---@return estate_location_id estate_location 
function DATA.get_estate_location_from_estate(estate)
    return DCON.dcon_estate_get_estate_location_as_estate(estate - 1) + 1
end
---@param estate_location_id estate_location_id valid estate_location id
---@param value estate_id valid estate_id
function DATA.estate_location_set_estate(estate_location_id, value)
    DCON.dcon_estate_location_set_estate(estate_location_id - 1, value - 1)
end

local fat_estate_location_id_metatable = {
    __index = function (t,k)
        if (k == "province") then return DATA.estate_location_get_province(t.id) end
        if (k == "estate") then return DATA.estate_location_get_estate(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "province") then
            DATA.estate_location_set_province(t.id, v)
            return
        end
        if (k == "estate") then
            DATA.estate_location_set_estate(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id estate_location_id
---@return fat_estate_location_id fat_id
function DATA.fatten_estate_location(id)
    local result = {id = id}
    setmetatable(result, fat_estate_location_id_metatable)
    return result --[[@as fat_estate_location_id]]
end
