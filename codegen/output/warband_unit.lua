local ffi = require("ffi")
----------warband_unit----------


---warband_unit: LSP types---

---Unique identificator for warband_unit entity
---@class (exact) warband_unit_id : table
---@field is_warband_unit number
---@class (exact) fat_warband_unit_id
---@field id warband_unit_id Unique warband_unit id
---@field type unit_type_id Current unit type
---@field unit pop_id 
---@field warband warband_id 

---@class struct_warband_unit
---@field type unit_type_id Current unit type


ffi.cdef[[
void dcon_warband_unit_set_type(int32_t, int32_t);
int32_t dcon_warband_unit_get_type(int32_t);
void dcon_delete_warband_unit(int32_t j);
int32_t dcon_force_create_warband_unit(int32_t unit, int32_t warband);
void dcon_warband_unit_set_unit(int32_t, int32_t);
int32_t dcon_warband_unit_get_unit(int32_t);
int32_t dcon_pop_get_warband_unit_as_unit(int32_t);
void dcon_warband_unit_set_warband(int32_t, int32_t);
int32_t dcon_warband_unit_get_warband(int32_t);
int32_t dcon_warband_get_range_warband_unit_as_warband(int32_t);
int32_t dcon_warband_get_index_warband_unit_as_warband(int32_t, int32_t);
bool dcon_warband_unit_is_valid(int32_t);
void dcon_warband_unit_resize(uint32_t sz);
uint32_t dcon_warband_unit_size();
]]

---warband_unit: FFI arrays---

---warband_unit: LUA bindings---

DATA.warband_unit_size = 50000
---@param unit pop_id
---@param warband warband_id
---@return warband_unit_id
function DATA.force_create_warband_unit(unit, warband)
    ---@type warband_unit_id
    local i = DCON.dcon_force_create_warband_unit(unit - 1, warband - 1) + 1
    return i --[[@as warband_unit_id]] 
end
---@param i warband_unit_id
function DATA.delete_warband_unit(i)
    assert(DCON.dcon_warband_unit_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_warband_unit(i - 1)
end
---@param func fun(item: warband_unit_id) 
function DATA.for_each_warband_unit(func)
    ---@type number
    local range = DCON.dcon_warband_unit_size()
    for i = 0, range - 1 do
        if DCON.dcon_warband_unit_is_valid(i) then func(i + 1 --[[@as warband_unit_id]]) end
    end
end
---@param func fun(item: warband_unit_id):boolean 
---@return table<warband_unit_id, warband_unit_id> 
function DATA.filter_warband_unit(func)
    ---@type table<warband_unit_id, warband_unit_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_warband_unit_size()
    for i = 0, range - 1 do
        if DCON.dcon_warband_unit_is_valid(i) and func(i + 1 --[[@as warband_unit_id]]) then t[i + 1 --[[@as warband_unit_id]]] = i + 1 --[[@as warband_unit_id]] end
    end
    return t
end

---@param warband_unit_id warband_unit_id valid warband_unit id
---@return unit_type_id type Current unit type
function DATA.warband_unit_get_type(warband_unit_id)
    return DCON.dcon_warband_unit_get_type(warband_unit_id - 1) + 1
end
---@param warband_unit_id warband_unit_id valid warband_unit id
---@param value unit_type_id valid unit_type_id
function DATA.warband_unit_set_type(warband_unit_id, value)
    DCON.dcon_warband_unit_set_type(warband_unit_id - 1, value - 1)
end
---@param unit warband_unit_id valid pop_id
---@return pop_id Data retrieved from warband_unit 
function DATA.warband_unit_get_unit(unit)
    return DCON.dcon_warband_unit_get_unit(unit - 1) + 1
end
---@param unit pop_id valid pop_id
---@return warband_unit_id warband_unit 
function DATA.get_warband_unit_from_unit(unit)
    return DCON.dcon_pop_get_warband_unit_as_unit(unit - 1) + 1
end
---@param warband_unit_id warband_unit_id valid warband_unit id
---@param value pop_id valid pop_id
function DATA.warband_unit_set_unit(warband_unit_id, value)
    DCON.dcon_warband_unit_set_unit(warband_unit_id - 1, value - 1)
end
---@param warband warband_unit_id valid warband_id
---@return warband_id Data retrieved from warband_unit 
function DATA.warband_unit_get_warband(warband)
    return DCON.dcon_warband_unit_get_warband(warband - 1) + 1
end
---@param warband warband_id valid warband_id
---@return warband_unit_id[] An array of warband_unit 
function DATA.get_warband_unit_from_warband(warband)
    local result = {}
    DATA.for_each_warband_unit_from_warband(warband, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param warband warband_id valid warband_id
---@param func fun(item: warband_unit_id) valid warband_id
function DATA.for_each_warband_unit_from_warband(warband, func)
    ---@type number
    local range = DCON.dcon_warband_get_range_warband_unit_as_warband(warband - 1)
    for i = 0, range - 1 do
        ---@type warband_unit_id
        local accessed_element = DCON.dcon_warband_get_index_warband_unit_as_warband(warband - 1, i) + 1
        if DCON.dcon_warband_unit_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param warband warband_id valid warband_id
---@param func fun(item: warband_unit_id):boolean 
---@return warband_unit_id[]
function DATA.filter_array_warband_unit_from_warband(warband, func)
    ---@type table<warband_unit_id, warband_unit_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_warband_get_range_warband_unit_as_warband(warband - 1)
    for i = 0, range - 1 do
        ---@type warband_unit_id
        local accessed_element = DCON.dcon_warband_get_index_warband_unit_as_warband(warband - 1, i) + 1
        if DCON.dcon_warband_unit_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param warband warband_id valid warband_id
---@param func fun(item: warband_unit_id):boolean 
---@return table<warband_unit_id, warband_unit_id> 
function DATA.filter_warband_unit_from_warband(warband, func)
    ---@type table<warband_unit_id, warband_unit_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_warband_get_range_warband_unit_as_warband(warband - 1)
    for i = 0, range - 1 do
        ---@type warband_unit_id
        local accessed_element = DCON.dcon_warband_get_index_warband_unit_as_warband(warband - 1, i) + 1
        if DCON.dcon_warband_unit_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param warband_unit_id warband_unit_id valid warband_unit id
---@param value warband_id valid warband_id
function DATA.warband_unit_set_warband(warband_unit_id, value)
    DCON.dcon_warband_unit_set_warband(warband_unit_id - 1, value - 1)
end

local fat_warband_unit_id_metatable = {
    __index = function (t,k)
        if (k == "type") then return DATA.warband_unit_get_type(t.id) end
        if (k == "unit") then return DATA.warband_unit_get_unit(t.id) end
        if (k == "warband") then return DATA.warband_unit_get_warband(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "type") then
            DATA.warband_unit_set_type(t.id, v)
            return
        end
        if (k == "unit") then
            DATA.warband_unit_set_unit(t.id, v)
            return
        end
        if (k == "warband") then
            DATA.warband_unit_set_warband(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id warband_unit_id
---@return fat_warband_unit_id fat_id
function DATA.fatten_warband_unit(id)
    local result = {id = id}
    setmetatable(result, fat_warband_unit_id_metatable)
    return result --[[@as fat_warband_unit_id]]
end
