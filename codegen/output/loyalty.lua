local ffi = require("ffi")
----------loyalty----------


---loyalty: LSP types---

---Unique identificator for loyalty entity
---@class (exact) loyalty_id : table
---@field is_loyalty number
---@class (exact) fat_loyalty_id
---@field id loyalty_id Unique loyalty id
---@field top pop_id 
---@field bottom pop_id 

---@class struct_loyalty


ffi.cdef[[
void dcon_delete_loyalty(int32_t j);
int32_t dcon_force_create_loyalty(int32_t top, int32_t bottom);
void dcon_loyalty_set_top(int32_t, int32_t);
int32_t dcon_loyalty_get_top(int32_t);
int32_t dcon_pop_get_range_loyalty_as_top(int32_t);
int32_t dcon_pop_get_index_loyalty_as_top(int32_t, int32_t);
void dcon_loyalty_set_bottom(int32_t, int32_t);
int32_t dcon_loyalty_get_bottom(int32_t);
int32_t dcon_pop_get_loyalty_as_bottom(int32_t);
bool dcon_loyalty_is_valid(int32_t);
void dcon_loyalty_resize(uint32_t sz);
uint32_t dcon_loyalty_size();
]]

---loyalty: FFI arrays---

---loyalty: LUA bindings---

DATA.loyalty_size = 200000
---@param top pop_id
---@param bottom pop_id
---@return loyalty_id
function DATA.force_create_loyalty(top, bottom)
    ---@type loyalty_id
    local i = DCON.dcon_force_create_loyalty(top - 1, bottom - 1) + 1
    return i --[[@as loyalty_id]] 
end
---@param i loyalty_id
function DATA.delete_loyalty(i)
    assert(DCON.dcon_loyalty_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_loyalty(i - 1)
end
---@param func fun(item: loyalty_id) 
function DATA.for_each_loyalty(func)
    ---@type number
    local range = DCON.dcon_loyalty_size()
    for i = 0, range - 1 do
        if DCON.dcon_loyalty_is_valid(i) then func(i + 1 --[[@as loyalty_id]]) end
    end
end
---@param func fun(item: loyalty_id):boolean 
---@return table<loyalty_id, loyalty_id> 
function DATA.filter_loyalty(func)
    ---@type table<loyalty_id, loyalty_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_loyalty_size()
    for i = 0, range - 1 do
        if DCON.dcon_loyalty_is_valid(i) and func(i + 1 --[[@as loyalty_id]]) then t[i + 1 --[[@as loyalty_id]]] = i + 1 --[[@as loyalty_id]] end
    end
    return t
end

---@param top loyalty_id valid pop_id
---@return pop_id Data retrieved from loyalty 
function DATA.loyalty_get_top(top)
    return DCON.dcon_loyalty_get_top(top - 1) + 1
end
---@param top pop_id valid pop_id
---@return loyalty_id[] An array of loyalty 
function DATA.get_loyalty_from_top(top)
    local result = {}
    DATA.for_each_loyalty_from_top(top, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param top pop_id valid pop_id
---@param func fun(item: loyalty_id) valid pop_id
function DATA.for_each_loyalty_from_top(top, func)
    ---@type number
    local range = DCON.dcon_pop_get_range_loyalty_as_top(top - 1)
    for i = 0, range - 1 do
        ---@type loyalty_id
        local accessed_element = DCON.dcon_pop_get_index_loyalty_as_top(top - 1, i) + 1
        if DCON.dcon_loyalty_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param top pop_id valid pop_id
---@param func fun(item: loyalty_id):boolean 
---@return loyalty_id[]
function DATA.filter_array_loyalty_from_top(top, func)
    ---@type table<loyalty_id, loyalty_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_loyalty_as_top(top - 1)
    for i = 0, range - 1 do
        ---@type loyalty_id
        local accessed_element = DCON.dcon_pop_get_index_loyalty_as_top(top - 1, i) + 1
        if DCON.dcon_loyalty_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param top pop_id valid pop_id
---@param func fun(item: loyalty_id):boolean 
---@return table<loyalty_id, loyalty_id> 
function DATA.filter_loyalty_from_top(top, func)
    ---@type table<loyalty_id, loyalty_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_loyalty_as_top(top - 1)
    for i = 0, range - 1 do
        ---@type loyalty_id
        local accessed_element = DCON.dcon_pop_get_index_loyalty_as_top(top - 1, i) + 1
        if DCON.dcon_loyalty_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param loyalty_id loyalty_id valid loyalty id
---@param value pop_id valid pop_id
function DATA.loyalty_set_top(loyalty_id, value)
    DCON.dcon_loyalty_set_top(loyalty_id - 1, value - 1)
end
---@param bottom loyalty_id valid pop_id
---@return pop_id Data retrieved from loyalty 
function DATA.loyalty_get_bottom(bottom)
    return DCON.dcon_loyalty_get_bottom(bottom - 1) + 1
end
---@param bottom pop_id valid pop_id
---@return loyalty_id loyalty 
function DATA.get_loyalty_from_bottom(bottom)
    return DCON.dcon_pop_get_loyalty_as_bottom(bottom - 1) + 1
end
---@param loyalty_id loyalty_id valid loyalty id
---@param value pop_id valid pop_id
function DATA.loyalty_set_bottom(loyalty_id, value)
    DCON.dcon_loyalty_set_bottom(loyalty_id - 1, value - 1)
end

local fat_loyalty_id_metatable = {
    __index = function (t,k)
        if (k == "top") then return DATA.loyalty_get_top(t.id) end
        if (k == "bottom") then return DATA.loyalty_get_bottom(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "top") then
            DATA.loyalty_set_top(t.id, v)
            return
        end
        if (k == "bottom") then
            DATA.loyalty_set_bottom(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id loyalty_id
---@return fat_loyalty_id fat_id
function DATA.fatten_loyalty(id)
    local result = {id = id}
    setmetatable(result, fat_loyalty_id_metatable)
    return result --[[@as fat_loyalty_id]]
end
