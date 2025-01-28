local ffi = require("ffi")
----------negotiation----------


---negotiation: LSP types---

---Unique identificator for negotiation entity
---@class (exact) negotiation_id : table
---@field is_negotiation number
---@class (exact) fat_negotiation_id
---@field id negotiation_id Unique negotiation id
---@field initiator pop_id 
---@field target pop_id 

---@class struct_negotiation


ffi.cdef[[
void dcon_delete_negotiation(int32_t j);
int32_t dcon_force_create_negotiation(int32_t initiator, int32_t target);
void dcon_negotiation_set_initiator(int32_t, int32_t);
int32_t dcon_negotiation_get_initiator(int32_t);
int32_t dcon_pop_get_range_negotiation_as_initiator(int32_t);
int32_t dcon_pop_get_index_negotiation_as_initiator(int32_t, int32_t);
void dcon_negotiation_set_target(int32_t, int32_t);
int32_t dcon_negotiation_get_target(int32_t);
int32_t dcon_pop_get_range_negotiation_as_target(int32_t);
int32_t dcon_pop_get_index_negotiation_as_target(int32_t, int32_t);
bool dcon_negotiation_is_valid(int32_t);
void dcon_negotiation_resize(uint32_t sz);
uint32_t dcon_negotiation_size();
]]

---negotiation: FFI arrays---

---negotiation: LUA bindings---

DATA.negotiation_size = 45000
---@param initiator pop_id
---@param target pop_id
---@return negotiation_id
function DATA.force_create_negotiation(initiator, target)
    ---@type negotiation_id
    local i = DCON.dcon_force_create_negotiation(initiator - 1, target - 1) + 1
    return i --[[@as negotiation_id]] 
end
---@param i negotiation_id
function DATA.delete_negotiation(i)
    assert(DCON.dcon_negotiation_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_negotiation(i - 1)
end
---@param func fun(item: negotiation_id) 
function DATA.for_each_negotiation(func)
    ---@type number
    local range = DCON.dcon_negotiation_size()
    for i = 0, range - 1 do
        if DCON.dcon_negotiation_is_valid(i) then func(i + 1 --[[@as negotiation_id]]) end
    end
end
---@param func fun(item: negotiation_id):boolean 
---@return table<negotiation_id, negotiation_id> 
function DATA.filter_negotiation(func)
    ---@type table<negotiation_id, negotiation_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_negotiation_size()
    for i = 0, range - 1 do
        if DCON.dcon_negotiation_is_valid(i) and func(i + 1 --[[@as negotiation_id]]) then t[i + 1 --[[@as negotiation_id]]] = i + 1 --[[@as negotiation_id]] end
    end
    return t
end

---@param initiator negotiation_id valid pop_id
---@return pop_id Data retrieved from negotiation 
function DATA.negotiation_get_initiator(initiator)
    return DCON.dcon_negotiation_get_initiator(initiator - 1) + 1
end
---@param initiator pop_id valid pop_id
---@return negotiation_id[] An array of negotiation 
function DATA.get_negotiation_from_initiator(initiator)
    local result = {}
    DATA.for_each_negotiation_from_initiator(initiator, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param initiator pop_id valid pop_id
---@param func fun(item: negotiation_id) valid pop_id
function DATA.for_each_negotiation_from_initiator(initiator, func)
    ---@type number
    local range = DCON.dcon_pop_get_range_negotiation_as_initiator(initiator - 1)
    for i = 0, range - 1 do
        ---@type negotiation_id
        local accessed_element = DCON.dcon_pop_get_index_negotiation_as_initiator(initiator - 1, i) + 1
        if DCON.dcon_negotiation_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param initiator pop_id valid pop_id
---@param func fun(item: negotiation_id):boolean 
---@return negotiation_id[]
function DATA.filter_array_negotiation_from_initiator(initiator, func)
    ---@type table<negotiation_id, negotiation_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_negotiation_as_initiator(initiator - 1)
    for i = 0, range - 1 do
        ---@type negotiation_id
        local accessed_element = DCON.dcon_pop_get_index_negotiation_as_initiator(initiator - 1, i) + 1
        if DCON.dcon_negotiation_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param initiator pop_id valid pop_id
---@param func fun(item: negotiation_id):boolean 
---@return table<negotiation_id, negotiation_id> 
function DATA.filter_negotiation_from_initiator(initiator, func)
    ---@type table<negotiation_id, negotiation_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_negotiation_as_initiator(initiator - 1)
    for i = 0, range - 1 do
        ---@type negotiation_id
        local accessed_element = DCON.dcon_pop_get_index_negotiation_as_initiator(initiator - 1, i) + 1
        if DCON.dcon_negotiation_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param negotiation_id negotiation_id valid negotiation id
---@param value pop_id valid pop_id
function DATA.negotiation_set_initiator(negotiation_id, value)
    DCON.dcon_negotiation_set_initiator(negotiation_id - 1, value - 1)
end
---@param target negotiation_id valid pop_id
---@return pop_id Data retrieved from negotiation 
function DATA.negotiation_get_target(target)
    return DCON.dcon_negotiation_get_target(target - 1) + 1
end
---@param target pop_id valid pop_id
---@return negotiation_id[] An array of negotiation 
function DATA.get_negotiation_from_target(target)
    local result = {}
    DATA.for_each_negotiation_from_target(target, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param target pop_id valid pop_id
---@param func fun(item: negotiation_id) valid pop_id
function DATA.for_each_negotiation_from_target(target, func)
    ---@type number
    local range = DCON.dcon_pop_get_range_negotiation_as_target(target - 1)
    for i = 0, range - 1 do
        ---@type negotiation_id
        local accessed_element = DCON.dcon_pop_get_index_negotiation_as_target(target - 1, i) + 1
        if DCON.dcon_negotiation_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param target pop_id valid pop_id
---@param func fun(item: negotiation_id):boolean 
---@return negotiation_id[]
function DATA.filter_array_negotiation_from_target(target, func)
    ---@type table<negotiation_id, negotiation_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_negotiation_as_target(target - 1)
    for i = 0, range - 1 do
        ---@type negotiation_id
        local accessed_element = DCON.dcon_pop_get_index_negotiation_as_target(target - 1, i) + 1
        if DCON.dcon_negotiation_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param target pop_id valid pop_id
---@param func fun(item: negotiation_id):boolean 
---@return table<negotiation_id, negotiation_id> 
function DATA.filter_negotiation_from_target(target, func)
    ---@type table<negotiation_id, negotiation_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_negotiation_as_target(target - 1)
    for i = 0, range - 1 do
        ---@type negotiation_id
        local accessed_element = DCON.dcon_pop_get_index_negotiation_as_target(target - 1, i) + 1
        if DCON.dcon_negotiation_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param negotiation_id negotiation_id valid negotiation id
---@param value pop_id valid pop_id
function DATA.negotiation_set_target(negotiation_id, value)
    DCON.dcon_negotiation_set_target(negotiation_id - 1, value - 1)
end

local fat_negotiation_id_metatable = {
    __index = function (t,k)
        if (k == "initiator") then return DATA.negotiation_get_initiator(t.id) end
        if (k == "target") then return DATA.negotiation_get_target(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "initiator") then
            DATA.negotiation_set_initiator(t.id, v)
            return
        end
        if (k == "target") then
            DATA.negotiation_set_target(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id negotiation_id
---@return fat_negotiation_id fat_id
function DATA.fatten_negotiation(id)
    local result = {id = id}
    setmetatable(result, fat_negotiation_id_metatable)
    return result --[[@as fat_negotiation_id]]
end
