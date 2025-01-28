local ffi = require("ffi")
----------plate_tiles----------


---plate_tiles: LSP types---

---Unique identificator for plate_tiles entity
---@class (exact) plate_tiles_id : table
---@field is_plate_tiles number
---@class (exact) fat_plate_tiles_id
---@field id plate_tiles_id Unique plate_tiles id
---@field plate plate_id 
---@field tile tile_id 

---@class struct_plate_tiles


ffi.cdef[[
void dcon_delete_plate_tiles(int32_t j);
int32_t dcon_force_create_plate_tiles(int32_t plate, int32_t tile);
void dcon_plate_tiles_set_plate(int32_t, int32_t);
int32_t dcon_plate_tiles_get_plate(int32_t);
int32_t dcon_plate_get_range_plate_tiles_as_plate(int32_t);
int32_t dcon_plate_get_index_plate_tiles_as_plate(int32_t, int32_t);
void dcon_plate_tiles_set_tile(int32_t, int32_t);
int32_t dcon_plate_tiles_get_tile(int32_t);
int32_t dcon_tile_get_plate_tiles_as_tile(int32_t);
bool dcon_plate_tiles_is_valid(int32_t);
void dcon_plate_tiles_resize(uint32_t sz);
uint32_t dcon_plate_tiles_size();
]]

---plate_tiles: FFI arrays---

---plate_tiles: LUA bindings---

DATA.plate_tiles_size = 1500020
---@param plate plate_id
---@param tile tile_id
---@return plate_tiles_id
function DATA.force_create_plate_tiles(plate, tile)
    ---@type plate_tiles_id
    local i = DCON.dcon_force_create_plate_tiles(plate - 1, tile - 1) + 1
    return i --[[@as plate_tiles_id]] 
end
---@param i plate_tiles_id
function DATA.delete_plate_tiles(i)
    assert(DCON.dcon_plate_tiles_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_plate_tiles(i - 1)
end
---@param func fun(item: plate_tiles_id) 
function DATA.for_each_plate_tiles(func)
    ---@type number
    local range = DCON.dcon_plate_tiles_size()
    for i = 0, range - 1 do
        if DCON.dcon_plate_tiles_is_valid(i) then func(i + 1 --[[@as plate_tiles_id]]) end
    end
end
---@param func fun(item: plate_tiles_id):boolean 
---@return table<plate_tiles_id, plate_tiles_id> 
function DATA.filter_plate_tiles(func)
    ---@type table<plate_tiles_id, plate_tiles_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_plate_tiles_size()
    for i = 0, range - 1 do
        if DCON.dcon_plate_tiles_is_valid(i) and func(i + 1 --[[@as plate_tiles_id]]) then t[i + 1 --[[@as plate_tiles_id]]] = i + 1 --[[@as plate_tiles_id]] end
    end
    return t
end

---@param plate plate_tiles_id valid plate_id
---@return plate_id Data retrieved from plate_tiles 
function DATA.plate_tiles_get_plate(plate)
    return DCON.dcon_plate_tiles_get_plate(plate - 1) + 1
end
---@param plate plate_id valid plate_id
---@return plate_tiles_id[] An array of plate_tiles 
function DATA.get_plate_tiles_from_plate(plate)
    local result = {}
    DATA.for_each_plate_tiles_from_plate(plate, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param plate plate_id valid plate_id
---@param func fun(item: plate_tiles_id) valid plate_id
function DATA.for_each_plate_tiles_from_plate(plate, func)
    ---@type number
    local range = DCON.dcon_plate_get_range_plate_tiles_as_plate(plate - 1)
    for i = 0, range - 1 do
        ---@type plate_tiles_id
        local accessed_element = DCON.dcon_plate_get_index_plate_tiles_as_plate(plate - 1, i) + 1
        if DCON.dcon_plate_tiles_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param plate plate_id valid plate_id
---@param func fun(item: plate_tiles_id):boolean 
---@return plate_tiles_id[]
function DATA.filter_array_plate_tiles_from_plate(plate, func)
    ---@type table<plate_tiles_id, plate_tiles_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_plate_get_range_plate_tiles_as_plate(plate - 1)
    for i = 0, range - 1 do
        ---@type plate_tiles_id
        local accessed_element = DCON.dcon_plate_get_index_plate_tiles_as_plate(plate - 1, i) + 1
        if DCON.dcon_plate_tiles_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param plate plate_id valid plate_id
---@param func fun(item: plate_tiles_id):boolean 
---@return table<plate_tiles_id, plate_tiles_id> 
function DATA.filter_plate_tiles_from_plate(plate, func)
    ---@type table<plate_tiles_id, plate_tiles_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_plate_get_range_plate_tiles_as_plate(plate - 1)
    for i = 0, range - 1 do
        ---@type plate_tiles_id
        local accessed_element = DCON.dcon_plate_get_index_plate_tiles_as_plate(plate - 1, i) + 1
        if DCON.dcon_plate_tiles_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param plate_tiles_id plate_tiles_id valid plate_tiles id
---@param value plate_id valid plate_id
function DATA.plate_tiles_set_plate(plate_tiles_id, value)
    DCON.dcon_plate_tiles_set_plate(plate_tiles_id - 1, value - 1)
end
---@param tile plate_tiles_id valid tile_id
---@return tile_id Data retrieved from plate_tiles 
function DATA.plate_tiles_get_tile(tile)
    return DCON.dcon_plate_tiles_get_tile(tile - 1) + 1
end
---@param tile tile_id valid tile_id
---@return plate_tiles_id plate_tiles 
function DATA.get_plate_tiles_from_tile(tile)
    return DCON.dcon_tile_get_plate_tiles_as_tile(tile - 1) + 1
end
---@param plate_tiles_id plate_tiles_id valid plate_tiles id
---@param value tile_id valid tile_id
function DATA.plate_tiles_set_tile(plate_tiles_id, value)
    DCON.dcon_plate_tiles_set_tile(plate_tiles_id - 1, value - 1)
end

local fat_plate_tiles_id_metatable = {
    __index = function (t,k)
        if (k == "plate") then return DATA.plate_tiles_get_plate(t.id) end
        if (k == "tile") then return DATA.plate_tiles_get_tile(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "plate") then
            DATA.plate_tiles_set_plate(t.id, v)
            return
        end
        if (k == "tile") then
            DATA.plate_tiles_set_tile(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id plate_tiles_id
---@return fat_plate_tiles_id fat_id
function DATA.fatten_plate_tiles(id)
    local result = {id = id}
    setmetatable(result, fat_plate_tiles_id_metatable)
    return result --[[@as fat_plate_tiles_id]]
end
