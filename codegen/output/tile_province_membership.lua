local ffi = require("ffi")
----------tile_province_membership----------


---tile_province_membership: LSP types---

---Unique identificator for tile_province_membership entity
---@class (exact) tile_province_membership_id : table
---@field is_tile_province_membership number
---@class (exact) fat_tile_province_membership_id
---@field id tile_province_membership_id Unique tile_province_membership id
---@field province province_id 
---@field tile tile_id 

---@class struct_tile_province_membership


ffi.cdef[[
void dcon_delete_tile_province_membership(int32_t j);
int32_t dcon_force_create_tile_province_membership(int32_t province, int32_t tile);
void dcon_tile_province_membership_set_province(int32_t, int32_t);
int32_t dcon_tile_province_membership_get_province(int32_t);
int32_t dcon_province_get_range_tile_province_membership_as_province(int32_t);
int32_t dcon_province_get_index_tile_province_membership_as_province(int32_t, int32_t);
void dcon_tile_province_membership_set_tile(int32_t, int32_t);
int32_t dcon_tile_province_membership_get_tile(int32_t);
int32_t dcon_tile_get_tile_province_membership_as_tile(int32_t);
bool dcon_tile_province_membership_is_valid(int32_t);
void dcon_tile_province_membership_resize(uint32_t sz);
uint32_t dcon_tile_province_membership_size();
]]

---tile_province_membership: FFI arrays---

---tile_province_membership: LUA bindings---

DATA.tile_province_membership_size = 1500000
---@param province province_id
---@param tile tile_id
---@return tile_province_membership_id
function DATA.force_create_tile_province_membership(province, tile)
    ---@type tile_province_membership_id
    local i = DCON.dcon_force_create_tile_province_membership(province - 1, tile - 1) + 1
    return i --[[@as tile_province_membership_id]] 
end
---@param i tile_province_membership_id
function DATA.delete_tile_province_membership(i)
    assert(DCON.dcon_tile_province_membership_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_tile_province_membership(i - 1)
end
---@param func fun(item: tile_province_membership_id) 
function DATA.for_each_tile_province_membership(func)
    ---@type number
    local range = DCON.dcon_tile_province_membership_size()
    for i = 0, range - 1 do
        if DCON.dcon_tile_province_membership_is_valid(i) then func(i + 1 --[[@as tile_province_membership_id]]) end
    end
end
---@param func fun(item: tile_province_membership_id):boolean 
---@return table<tile_province_membership_id, tile_province_membership_id> 
function DATA.filter_tile_province_membership(func)
    ---@type table<tile_province_membership_id, tile_province_membership_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_tile_province_membership_size()
    for i = 0, range - 1 do
        if DCON.dcon_tile_province_membership_is_valid(i) and func(i + 1 --[[@as tile_province_membership_id]]) then t[i + 1 --[[@as tile_province_membership_id]]] = i + 1 --[[@as tile_province_membership_id]] end
    end
    return t
end

---@param province tile_province_membership_id valid province_id
---@return province_id Data retrieved from tile_province_membership 
function DATA.tile_province_membership_get_province(province)
    return DCON.dcon_tile_province_membership_get_province(province - 1) + 1
end
---@param province province_id valid province_id
---@return tile_province_membership_id[] An array of tile_province_membership 
function DATA.get_tile_province_membership_from_province(province)
    local result = {}
    DATA.for_each_tile_province_membership_from_province(province, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param province province_id valid province_id
---@param func fun(item: tile_province_membership_id) valid province_id
function DATA.for_each_tile_province_membership_from_province(province, func)
    ---@type number
    local range = DCON.dcon_province_get_range_tile_province_membership_as_province(province - 1)
    for i = 0, range - 1 do
        ---@type tile_province_membership_id
        local accessed_element = DCON.dcon_province_get_index_tile_province_membership_as_province(province - 1, i) + 1
        if DCON.dcon_tile_province_membership_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param province province_id valid province_id
---@param func fun(item: tile_province_membership_id):boolean 
---@return tile_province_membership_id[]
function DATA.filter_array_tile_province_membership_from_province(province, func)
    ---@type table<tile_province_membership_id, tile_province_membership_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_province_get_range_tile_province_membership_as_province(province - 1)
    for i = 0, range - 1 do
        ---@type tile_province_membership_id
        local accessed_element = DCON.dcon_province_get_index_tile_province_membership_as_province(province - 1, i) + 1
        if DCON.dcon_tile_province_membership_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param province province_id valid province_id
---@param func fun(item: tile_province_membership_id):boolean 
---@return table<tile_province_membership_id, tile_province_membership_id> 
function DATA.filter_tile_province_membership_from_province(province, func)
    ---@type table<tile_province_membership_id, tile_province_membership_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_province_get_range_tile_province_membership_as_province(province - 1)
    for i = 0, range - 1 do
        ---@type tile_province_membership_id
        local accessed_element = DCON.dcon_province_get_index_tile_province_membership_as_province(province - 1, i) + 1
        if DCON.dcon_tile_province_membership_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param tile_province_membership_id tile_province_membership_id valid tile_province_membership id
---@param value province_id valid province_id
function DATA.tile_province_membership_set_province(tile_province_membership_id, value)
    DCON.dcon_tile_province_membership_set_province(tile_province_membership_id - 1, value - 1)
end
---@param tile tile_province_membership_id valid tile_id
---@return tile_id Data retrieved from tile_province_membership 
function DATA.tile_province_membership_get_tile(tile)
    return DCON.dcon_tile_province_membership_get_tile(tile - 1) + 1
end
---@param tile tile_id valid tile_id
---@return tile_province_membership_id tile_province_membership 
function DATA.get_tile_province_membership_from_tile(tile)
    return DCON.dcon_tile_get_tile_province_membership_as_tile(tile - 1) + 1
end
---@param tile_province_membership_id tile_province_membership_id valid tile_province_membership id
---@param value tile_id valid tile_id
function DATA.tile_province_membership_set_tile(tile_province_membership_id, value)
    DCON.dcon_tile_province_membership_set_tile(tile_province_membership_id - 1, value - 1)
end

local fat_tile_province_membership_id_metatable = {
    __index = function (t,k)
        if (k == "province") then return DATA.tile_province_membership_get_province(t.id) end
        if (k == "tile") then return DATA.tile_province_membership_get_tile(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "province") then
            DATA.tile_province_membership_set_province(t.id, v)
            return
        end
        if (k == "tile") then
            DATA.tile_province_membership_set_tile(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id tile_province_membership_id
---@return fat_tile_province_membership_id fat_id
function DATA.fatten_tile_province_membership(id)
    local result = {id = id}
    setmetatable(result, fat_tile_province_membership_id_metatable)
    return result --[[@as fat_tile_province_membership_id]]
end
