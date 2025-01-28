local ffi = require("ffi")
----------technology_unlock----------


---technology_unlock: LSP types---

---Unique identificator for technology_unlock entity
---@class (exact) technology_unlock_id : table
---@field is_technology_unlock number
---@class (exact) fat_technology_unlock_id
---@field id technology_unlock_id Unique technology_unlock id
---@field origin technology_id 
---@field unlocked technology_id 

---@class struct_technology_unlock

---@class (exact) technology_unlock_id_data_blob_definition
---Sets values of technology_unlock for given id
---@param id technology_unlock_id
---@param data technology_unlock_id_data_blob_definition
function DATA.setup_technology_unlock(id, data)
end

ffi.cdef[[
int32_t dcon_force_create_technology_unlock(int32_t origin, int32_t unlocked);
void dcon_technology_unlock_set_origin(int32_t, int32_t);
int32_t dcon_technology_unlock_get_origin(int32_t);
int32_t dcon_technology_get_range_technology_unlock_as_origin(int32_t);
int32_t dcon_technology_get_index_technology_unlock_as_origin(int32_t, int32_t);
void dcon_technology_unlock_set_unlocked(int32_t, int32_t);
int32_t dcon_technology_unlock_get_unlocked(int32_t);
int32_t dcon_technology_get_range_technology_unlock_as_unlocked(int32_t);
int32_t dcon_technology_get_index_technology_unlock_as_unlocked(int32_t, int32_t);
bool dcon_technology_unlock_is_valid(int32_t);
void dcon_technology_unlock_resize(uint32_t sz);
uint32_t dcon_technology_unlock_size();
]]

---technology_unlock: FFI arrays---

---technology_unlock: LUA bindings---

DATA.technology_unlock_size = 800
---@param origin technology_id
---@param unlocked technology_id
---@return technology_unlock_id
function DATA.force_create_technology_unlock(origin, unlocked)
    ---@type technology_unlock_id
    local i = DCON.dcon_force_create_technology_unlock(origin - 1, unlocked - 1) + 1
    return i --[[@as technology_unlock_id]] 
end
---@param func fun(item: technology_unlock_id) 
function DATA.for_each_technology_unlock(func)
    ---@type number
    local range = DCON.dcon_technology_unlock_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as technology_unlock_id]])
    end
end
---@param func fun(item: technology_unlock_id):boolean 
---@return table<technology_unlock_id, technology_unlock_id> 
function DATA.filter_technology_unlock(func)
    ---@type table<technology_unlock_id, technology_unlock_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_technology_unlock_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as technology_unlock_id]]) then t[i + 1 --[[@as technology_unlock_id]]] = t[i + 1 --[[@as technology_unlock_id]]] end
    end
    return t
end

---@param origin technology_unlock_id valid technology_id
---@return technology_id Data retrieved from technology_unlock 
function DATA.technology_unlock_get_origin(origin)
    return DCON.dcon_technology_unlock_get_origin(origin - 1) + 1
end
---@param origin technology_id valid technology_id
---@return technology_unlock_id[] An array of technology_unlock 
function DATA.get_technology_unlock_from_origin(origin)
    local result = {}
    DATA.for_each_technology_unlock_from_origin(origin, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param origin technology_id valid technology_id
---@param func fun(item: technology_unlock_id) valid technology_id
function DATA.for_each_technology_unlock_from_origin(origin, func)
    ---@type number
    local range = DCON.dcon_technology_get_range_technology_unlock_as_origin(origin - 1)
    for i = 0, range - 1 do
        ---@type technology_unlock_id
        local accessed_element = DCON.dcon_technology_get_index_technology_unlock_as_origin(origin - 1, i) + 1
        if DCON.dcon_technology_unlock_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param origin technology_id valid technology_id
---@param func fun(item: technology_unlock_id):boolean 
---@return technology_unlock_id[]
function DATA.filter_array_technology_unlock_from_origin(origin, func)
    ---@type table<technology_unlock_id, technology_unlock_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_technology_get_range_technology_unlock_as_origin(origin - 1)
    for i = 0, range - 1 do
        ---@type technology_unlock_id
        local accessed_element = DCON.dcon_technology_get_index_technology_unlock_as_origin(origin - 1, i) + 1
        if DCON.dcon_technology_unlock_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param origin technology_id valid technology_id
---@param func fun(item: technology_unlock_id):boolean 
---@return table<technology_unlock_id, technology_unlock_id> 
function DATA.filter_technology_unlock_from_origin(origin, func)
    ---@type table<technology_unlock_id, technology_unlock_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_technology_get_range_technology_unlock_as_origin(origin - 1)
    for i = 0, range - 1 do
        ---@type technology_unlock_id
        local accessed_element = DCON.dcon_technology_get_index_technology_unlock_as_origin(origin - 1, i) + 1
        if DCON.dcon_technology_unlock_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param technology_unlock_id technology_unlock_id valid technology_unlock id
---@param value technology_id valid technology_id
function DATA.technology_unlock_set_origin(technology_unlock_id, value)
    DCON.dcon_technology_unlock_set_origin(technology_unlock_id - 1, value - 1)
end
---@param unlocked technology_unlock_id valid technology_id
---@return technology_id Data retrieved from technology_unlock 
function DATA.technology_unlock_get_unlocked(unlocked)
    return DCON.dcon_technology_unlock_get_unlocked(unlocked - 1) + 1
end
---@param unlocked technology_id valid technology_id
---@return technology_unlock_id[] An array of technology_unlock 
function DATA.get_technology_unlock_from_unlocked(unlocked)
    local result = {}
    DATA.for_each_technology_unlock_from_unlocked(unlocked, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param unlocked technology_id valid technology_id
---@param func fun(item: technology_unlock_id) valid technology_id
function DATA.for_each_technology_unlock_from_unlocked(unlocked, func)
    ---@type number
    local range = DCON.dcon_technology_get_range_technology_unlock_as_unlocked(unlocked - 1)
    for i = 0, range - 1 do
        ---@type technology_unlock_id
        local accessed_element = DCON.dcon_technology_get_index_technology_unlock_as_unlocked(unlocked - 1, i) + 1
        if DCON.dcon_technology_unlock_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param unlocked technology_id valid technology_id
---@param func fun(item: technology_unlock_id):boolean 
---@return technology_unlock_id[]
function DATA.filter_array_technology_unlock_from_unlocked(unlocked, func)
    ---@type table<technology_unlock_id, technology_unlock_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_technology_get_range_technology_unlock_as_unlocked(unlocked - 1)
    for i = 0, range - 1 do
        ---@type technology_unlock_id
        local accessed_element = DCON.dcon_technology_get_index_technology_unlock_as_unlocked(unlocked - 1, i) + 1
        if DCON.dcon_technology_unlock_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param unlocked technology_id valid technology_id
---@param func fun(item: technology_unlock_id):boolean 
---@return table<technology_unlock_id, technology_unlock_id> 
function DATA.filter_technology_unlock_from_unlocked(unlocked, func)
    ---@type table<technology_unlock_id, technology_unlock_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_technology_get_range_technology_unlock_as_unlocked(unlocked - 1)
    for i = 0, range - 1 do
        ---@type technology_unlock_id
        local accessed_element = DCON.dcon_technology_get_index_technology_unlock_as_unlocked(unlocked - 1, i) + 1
        if DCON.dcon_technology_unlock_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param technology_unlock_id technology_unlock_id valid technology_unlock id
---@param value technology_id valid technology_id
function DATA.technology_unlock_set_unlocked(technology_unlock_id, value)
    DCON.dcon_technology_unlock_set_unlocked(technology_unlock_id - 1, value - 1)
end

local fat_technology_unlock_id_metatable = {
    __index = function (t,k)
        if (k == "origin") then return DATA.technology_unlock_get_origin(t.id) end
        if (k == "unlocked") then return DATA.technology_unlock_get_unlocked(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "origin") then
            DATA.technology_unlock_set_origin(t.id, v)
            return
        end
        if (k == "unlocked") then
            DATA.technology_unlock_set_unlocked(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id technology_unlock_id
---@return fat_technology_unlock_id fat_id
function DATA.fatten_technology_unlock(id)
    local result = {id = id}
    setmetatable(result, fat_technology_unlock_id_metatable)
    return result --[[@as fat_technology_unlock_id]]
end
