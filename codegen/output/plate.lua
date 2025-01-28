local ffi = require("ffi")
----------plate----------


---plate: LSP types---

---Unique identificator for plate entity
---@class (exact) plate_id : table
---@field is_plate number
---@class (exact) fat_plate_id
---@field id plate_id Unique plate id
---@field r number 
---@field g number 
---@field b number 
---@field speed number 
---@field direction number 
---@field expansion_rate number 
---@field done_expanding boolean 
---@field current_tiles table<number,tile_id> 
---@field next_tiles table<number,tile_id> 
---@field plate_neighbors table<number,plate_id> 
---@field plate_edge table<number,tile_id> 
---@field plate_boundaries table<number,tile_id> 

---@class struct_plate
---@field r number 
---@field g number 
---@field b number 
---@field speed number 
---@field direction number 
---@field expansion_rate number 


ffi.cdef[[
void dcon_plate_set_r(int32_t, float);
float dcon_plate_get_r(int32_t);
void dcon_plate_set_g(int32_t, float);
float dcon_plate_get_g(int32_t);
void dcon_plate_set_b(int32_t, float);
float dcon_plate_get_b(int32_t);
void dcon_plate_set_speed(int32_t, float);
float dcon_plate_get_speed(int32_t);
void dcon_plate_set_direction(int32_t, float);
float dcon_plate_get_direction(int32_t);
void dcon_plate_set_expansion_rate(int32_t, float);
float dcon_plate_get_expansion_rate(int32_t);
void dcon_delete_plate(int32_t j);
int32_t dcon_create_plate();
bool dcon_plate_is_valid(int32_t);
void dcon_plate_resize(uint32_t sz);
uint32_t dcon_plate_size();
]]

---plate: FFI arrays---
---@type (boolean)[]
DATA.plate_done_expanding= {}
---@type (table<number,tile_id>)[]
DATA.plate_current_tiles= {}
---@type (table<number,tile_id>)[]
DATA.plate_next_tiles= {}
---@type (table<number,plate_id>)[]
DATA.plate_plate_neighbors= {}
---@type (table<number,tile_id>)[]
DATA.plate_plate_edge= {}
---@type (table<number,tile_id>)[]
DATA.plate_plate_boundaries= {}

---plate: LUA bindings---

DATA.plate_size = 50
---@return plate_id
function DATA.create_plate()
    ---@type plate_id
    local i  = DCON.dcon_create_plate() + 1
    return i --[[@as plate_id]] 
end
---@param i plate_id
function DATA.delete_plate(i)
    assert(DCON.dcon_plate_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_plate(i - 1)
end
---@param func fun(item: plate_id) 
function DATA.for_each_plate(func)
    ---@type number
    local range = DCON.dcon_plate_size()
    for i = 0, range - 1 do
        if DCON.dcon_plate_is_valid(i) then func(i + 1 --[[@as plate_id]]) end
    end
end
---@param func fun(item: plate_id):boolean 
---@return table<plate_id, plate_id> 
function DATA.filter_plate(func)
    ---@type table<plate_id, plate_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_plate_size()
    for i = 0, range - 1 do
        if DCON.dcon_plate_is_valid(i) and func(i + 1 --[[@as plate_id]]) then t[i + 1 --[[@as plate_id]]] = i + 1 --[[@as plate_id]] end
    end
    return t
end

---@param plate_id plate_id valid plate id
---@return number r 
function DATA.plate_get_r(plate_id)
    return DCON.dcon_plate_get_r(plate_id - 1)
end
---@param plate_id plate_id valid plate id
---@param value number valid number
function DATA.plate_set_r(plate_id, value)
    DCON.dcon_plate_set_r(plate_id - 1, value)
end
---@param plate_id plate_id valid plate id
---@param value number valid number
function DATA.plate_inc_r(plate_id, value)
    ---@type number
    local current = DCON.dcon_plate_get_r(plate_id - 1)
    DCON.dcon_plate_set_r(plate_id - 1, current + value)
end
---@param plate_id plate_id valid plate id
---@return number g 
function DATA.plate_get_g(plate_id)
    return DCON.dcon_plate_get_g(plate_id - 1)
end
---@param plate_id plate_id valid plate id
---@param value number valid number
function DATA.plate_set_g(plate_id, value)
    DCON.dcon_plate_set_g(plate_id - 1, value)
end
---@param plate_id plate_id valid plate id
---@param value number valid number
function DATA.plate_inc_g(plate_id, value)
    ---@type number
    local current = DCON.dcon_plate_get_g(plate_id - 1)
    DCON.dcon_plate_set_g(plate_id - 1, current + value)
end
---@param plate_id plate_id valid plate id
---@return number b 
function DATA.plate_get_b(plate_id)
    return DCON.dcon_plate_get_b(plate_id - 1)
end
---@param plate_id plate_id valid plate id
---@param value number valid number
function DATA.plate_set_b(plate_id, value)
    DCON.dcon_plate_set_b(plate_id - 1, value)
end
---@param plate_id plate_id valid plate id
---@param value number valid number
function DATA.plate_inc_b(plate_id, value)
    ---@type number
    local current = DCON.dcon_plate_get_b(plate_id - 1)
    DCON.dcon_plate_set_b(plate_id - 1, current + value)
end
---@param plate_id plate_id valid plate id
---@return number speed 
function DATA.plate_get_speed(plate_id)
    return DCON.dcon_plate_get_speed(plate_id - 1)
end
---@param plate_id plate_id valid plate id
---@param value number valid number
function DATA.plate_set_speed(plate_id, value)
    DCON.dcon_plate_set_speed(plate_id - 1, value)
end
---@param plate_id plate_id valid plate id
---@param value number valid number
function DATA.plate_inc_speed(plate_id, value)
    ---@type number
    local current = DCON.dcon_plate_get_speed(plate_id - 1)
    DCON.dcon_plate_set_speed(plate_id - 1, current + value)
end
---@param plate_id plate_id valid plate id
---@return number direction 
function DATA.plate_get_direction(plate_id)
    return DCON.dcon_plate_get_direction(plate_id - 1)
end
---@param plate_id plate_id valid plate id
---@param value number valid number
function DATA.plate_set_direction(plate_id, value)
    DCON.dcon_plate_set_direction(plate_id - 1, value)
end
---@param plate_id plate_id valid plate id
---@param value number valid number
function DATA.plate_inc_direction(plate_id, value)
    ---@type number
    local current = DCON.dcon_plate_get_direction(plate_id - 1)
    DCON.dcon_plate_set_direction(plate_id - 1, current + value)
end
---@param plate_id plate_id valid plate id
---@return number expansion_rate 
function DATA.plate_get_expansion_rate(plate_id)
    return DCON.dcon_plate_get_expansion_rate(plate_id - 1)
end
---@param plate_id plate_id valid plate id
---@param value number valid number
function DATA.plate_set_expansion_rate(plate_id, value)
    DCON.dcon_plate_set_expansion_rate(plate_id - 1, value)
end
---@param plate_id plate_id valid plate id
---@param value number valid number
function DATA.plate_inc_expansion_rate(plate_id, value)
    ---@type number
    local current = DCON.dcon_plate_get_expansion_rate(plate_id - 1)
    DCON.dcon_plate_set_expansion_rate(plate_id - 1, current + value)
end
---@param plate_id plate_id valid plate id
---@return boolean done_expanding 
function DATA.plate_get_done_expanding(plate_id)
    return DATA.plate_done_expanding[plate_id]
end
---@param plate_id plate_id valid plate id
---@param value boolean valid boolean
function DATA.plate_set_done_expanding(plate_id, value)
    DATA.plate_done_expanding[plate_id] = value
end
---@param plate_id plate_id valid plate id
---@return table<number,tile_id> current_tiles 
function DATA.plate_get_current_tiles(plate_id)
    return DATA.plate_current_tiles[plate_id]
end
---@param plate_id plate_id valid plate id
---@param value table<number,tile_id> valid table<number,tile_id>
function DATA.plate_set_current_tiles(plate_id, value)
    DATA.plate_current_tiles[plate_id] = value
end
---@param plate_id plate_id valid plate id
---@return table<number,tile_id> next_tiles 
function DATA.plate_get_next_tiles(plate_id)
    return DATA.plate_next_tiles[plate_id]
end
---@param plate_id plate_id valid plate id
---@param value table<number,tile_id> valid table<number,tile_id>
function DATA.plate_set_next_tiles(plate_id, value)
    DATA.plate_next_tiles[plate_id] = value
end
---@param plate_id plate_id valid plate id
---@return table<number,plate_id> plate_neighbors 
function DATA.plate_get_plate_neighbors(plate_id)
    return DATA.plate_plate_neighbors[plate_id]
end
---@param plate_id plate_id valid plate id
---@param value table<number,plate_id> valid table<number,plate_id>
function DATA.plate_set_plate_neighbors(plate_id, value)
    DATA.plate_plate_neighbors[plate_id] = value
end
---@param plate_id plate_id valid plate id
---@return table<number,tile_id> plate_edge 
function DATA.plate_get_plate_edge(plate_id)
    return DATA.plate_plate_edge[plate_id]
end
---@param plate_id plate_id valid plate id
---@param value table<number,tile_id> valid table<number,tile_id>
function DATA.plate_set_plate_edge(plate_id, value)
    DATA.plate_plate_edge[plate_id] = value
end
---@param plate_id plate_id valid plate id
---@return table<number,tile_id> plate_boundaries 
function DATA.plate_get_plate_boundaries(plate_id)
    return DATA.plate_plate_boundaries[plate_id]
end
---@param plate_id plate_id valid plate id
---@param value table<number,tile_id> valid table<number,tile_id>
function DATA.plate_set_plate_boundaries(plate_id, value)
    DATA.plate_plate_boundaries[plate_id] = value
end

local fat_plate_id_metatable = {
    __index = function (t,k)
        if (k == "r") then return DATA.plate_get_r(t.id) end
        if (k == "g") then return DATA.plate_get_g(t.id) end
        if (k == "b") then return DATA.plate_get_b(t.id) end
        if (k == "speed") then return DATA.plate_get_speed(t.id) end
        if (k == "direction") then return DATA.plate_get_direction(t.id) end
        if (k == "expansion_rate") then return DATA.plate_get_expansion_rate(t.id) end
        if (k == "done_expanding") then return DATA.plate_get_done_expanding(t.id) end
        if (k == "current_tiles") then return DATA.plate_get_current_tiles(t.id) end
        if (k == "next_tiles") then return DATA.plate_get_next_tiles(t.id) end
        if (k == "plate_neighbors") then return DATA.plate_get_plate_neighbors(t.id) end
        if (k == "plate_edge") then return DATA.plate_get_plate_edge(t.id) end
        if (k == "plate_boundaries") then return DATA.plate_get_plate_boundaries(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "r") then
            DATA.plate_set_r(t.id, v)
            return
        end
        if (k == "g") then
            DATA.plate_set_g(t.id, v)
            return
        end
        if (k == "b") then
            DATA.plate_set_b(t.id, v)
            return
        end
        if (k == "speed") then
            DATA.plate_set_speed(t.id, v)
            return
        end
        if (k == "direction") then
            DATA.plate_set_direction(t.id, v)
            return
        end
        if (k == "expansion_rate") then
            DATA.plate_set_expansion_rate(t.id, v)
            return
        end
        if (k == "done_expanding") then
            DATA.plate_set_done_expanding(t.id, v)
            return
        end
        if (k == "current_tiles") then
            DATA.plate_set_current_tiles(t.id, v)
            return
        end
        if (k == "next_tiles") then
            DATA.plate_set_next_tiles(t.id, v)
            return
        end
        if (k == "plate_neighbors") then
            DATA.plate_set_plate_neighbors(t.id, v)
            return
        end
        if (k == "plate_edge") then
            DATA.plate_set_plate_edge(t.id, v)
            return
        end
        if (k == "plate_boundaries") then
            DATA.plate_set_plate_boundaries(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id plate_id
---@return fat_plate_id fat_id
function DATA.fatten_plate(id)
    local result = {id = id}
    setmetatable(result, fat_plate_id_metatable)
    return result --[[@as fat_plate_id]]
end
