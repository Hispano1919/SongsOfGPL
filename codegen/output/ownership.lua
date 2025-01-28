local ffi = require("ffi")
----------ownership----------


---ownership: LSP types---

---Unique identificator for ownership entity
---@class (exact) ownership_id : table
---@field is_ownership number
---@class (exact) fat_ownership_id
---@field id ownership_id Unique ownership id
---@field building building_id 
---@field owner pop_id 

---@class struct_ownership


ffi.cdef[[
void dcon_delete_ownership(int32_t j);
int32_t dcon_force_create_ownership(int32_t building, int32_t owner);
void dcon_ownership_set_building(int32_t, int32_t);
int32_t dcon_ownership_get_building(int32_t);
int32_t dcon_building_get_ownership_as_building(int32_t);
void dcon_ownership_set_owner(int32_t, int32_t);
int32_t dcon_ownership_get_owner(int32_t);
int32_t dcon_pop_get_range_ownership_as_owner(int32_t);
int32_t dcon_pop_get_index_ownership_as_owner(int32_t, int32_t);
bool dcon_ownership_is_valid(int32_t);
void dcon_ownership_resize(uint32_t sz);
uint32_t dcon_ownership_size();
]]

---ownership: FFI arrays---

---ownership: LUA bindings---

DATA.ownership_size = 200000
---@param building building_id
---@param owner pop_id
---@return ownership_id
function DATA.force_create_ownership(building, owner)
    ---@type ownership_id
    local i = DCON.dcon_force_create_ownership(building - 1, owner - 1) + 1
    return i --[[@as ownership_id]] 
end
---@param i ownership_id
function DATA.delete_ownership(i)
    assert(DCON.dcon_ownership_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_ownership(i - 1)
end
---@param func fun(item: ownership_id) 
function DATA.for_each_ownership(func)
    ---@type number
    local range = DCON.dcon_ownership_size()
    for i = 0, range - 1 do
        if DCON.dcon_ownership_is_valid(i) then func(i + 1 --[[@as ownership_id]]) end
    end
end
---@param func fun(item: ownership_id):boolean 
---@return table<ownership_id, ownership_id> 
function DATA.filter_ownership(func)
    ---@type table<ownership_id, ownership_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_ownership_size()
    for i = 0, range - 1 do
        if DCON.dcon_ownership_is_valid(i) and func(i + 1 --[[@as ownership_id]]) then t[i + 1 --[[@as ownership_id]]] = i + 1 --[[@as ownership_id]] end
    end
    return t
end

---@param building ownership_id valid building_id
---@return building_id Data retrieved from ownership 
function DATA.ownership_get_building(building)
    return DCON.dcon_ownership_get_building(building - 1) + 1
end
---@param building building_id valid building_id
---@return ownership_id ownership 
function DATA.get_ownership_from_building(building)
    return DCON.dcon_building_get_ownership_as_building(building - 1) + 1
end
---@param ownership_id ownership_id valid ownership id
---@param value building_id valid building_id
function DATA.ownership_set_building(ownership_id, value)
    DCON.dcon_ownership_set_building(ownership_id - 1, value - 1)
end
---@param owner ownership_id valid pop_id
---@return pop_id Data retrieved from ownership 
function DATA.ownership_get_owner(owner)
    return DCON.dcon_ownership_get_owner(owner - 1) + 1
end
---@param owner pop_id valid pop_id
---@return ownership_id[] An array of ownership 
function DATA.get_ownership_from_owner(owner)
    local result = {}
    DATA.for_each_ownership_from_owner(owner, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param owner pop_id valid pop_id
---@param func fun(item: ownership_id) valid pop_id
function DATA.for_each_ownership_from_owner(owner, func)
    ---@type number
    local range = DCON.dcon_pop_get_range_ownership_as_owner(owner - 1)
    for i = 0, range - 1 do
        ---@type ownership_id
        local accessed_element = DCON.dcon_pop_get_index_ownership_as_owner(owner - 1, i) + 1
        if DCON.dcon_ownership_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param owner pop_id valid pop_id
---@param func fun(item: ownership_id):boolean 
---@return ownership_id[]
function DATA.filter_array_ownership_from_owner(owner, func)
    ---@type table<ownership_id, ownership_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_ownership_as_owner(owner - 1)
    for i = 0, range - 1 do
        ---@type ownership_id
        local accessed_element = DCON.dcon_pop_get_index_ownership_as_owner(owner - 1, i) + 1
        if DCON.dcon_ownership_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param owner pop_id valid pop_id
---@param func fun(item: ownership_id):boolean 
---@return table<ownership_id, ownership_id> 
function DATA.filter_ownership_from_owner(owner, func)
    ---@type table<ownership_id, ownership_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_ownership_as_owner(owner - 1)
    for i = 0, range - 1 do
        ---@type ownership_id
        local accessed_element = DCON.dcon_pop_get_index_ownership_as_owner(owner - 1, i) + 1
        if DCON.dcon_ownership_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param ownership_id ownership_id valid ownership id
---@param value pop_id valid pop_id
function DATA.ownership_set_owner(ownership_id, value)
    DCON.dcon_ownership_set_owner(ownership_id - 1, value - 1)
end

local fat_ownership_id_metatable = {
    __index = function (t,k)
        if (k == "building") then return DATA.ownership_get_building(t.id) end
        if (k == "owner") then return DATA.ownership_get_owner(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "building") then
            DATA.ownership_set_building(t.id, v)
            return
        end
        if (k == "owner") then
            DATA.ownership_set_owner(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id ownership_id
---@return fat_ownership_id fat_id
function DATA.fatten_ownership(id)
    local result = {id = id}
    setmetatable(result, fat_ownership_id_metatable)
    return result --[[@as fat_ownership_id]]
end
