local ffi = require("ffi")
----------technology_building----------


---technology_building: LSP types---

---Unique identificator for technology_building entity
---@class (exact) technology_building_id : table
---@field is_technology_building number
---@class (exact) fat_technology_building_id
---@field id technology_building_id Unique technology_building id
---@field technology technology_id 
---@field unlocked building_type_id 

---@class struct_technology_building

---@class (exact) technology_building_id_data_blob_definition
---Sets values of technology_building for given id
---@param id technology_building_id
---@param data technology_building_id_data_blob_definition
function DATA.setup_technology_building(id, data)
end

ffi.cdef[[
int32_t dcon_force_create_technology_building(int32_t technology, int32_t unlocked);
void dcon_technology_building_set_technology(int32_t, int32_t);
int32_t dcon_technology_building_get_technology(int32_t);
int32_t dcon_technology_get_range_technology_building_as_technology(int32_t);
int32_t dcon_technology_get_index_technology_building_as_technology(int32_t, int32_t);
void dcon_technology_building_set_unlocked(int32_t, int32_t);
int32_t dcon_technology_building_get_unlocked(int32_t);
int32_t dcon_building_type_get_technology_building_as_unlocked(int32_t);
bool dcon_technology_building_is_valid(int32_t);
void dcon_technology_building_resize(uint32_t sz);
uint32_t dcon_technology_building_size();
]]

---technology_building: FFI arrays---

---technology_building: LUA bindings---

DATA.technology_building_size = 400
---@param technology technology_id
---@param unlocked building_type_id
---@return technology_building_id
function DATA.force_create_technology_building(technology, unlocked)
    ---@type technology_building_id
    local i = DCON.dcon_force_create_technology_building(technology - 1, unlocked - 1) + 1
    return i --[[@as technology_building_id]] 
end
---@param func fun(item: technology_building_id) 
function DATA.for_each_technology_building(func)
    ---@type number
    local range = DCON.dcon_technology_building_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as technology_building_id]])
    end
end
---@param func fun(item: technology_building_id):boolean 
---@return table<technology_building_id, technology_building_id> 
function DATA.filter_technology_building(func)
    ---@type table<technology_building_id, technology_building_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_technology_building_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as technology_building_id]]) then t[i + 1 --[[@as technology_building_id]]] = t[i + 1 --[[@as technology_building_id]]] end
    end
    return t
end

---@param technology technology_building_id valid technology_id
---@return technology_id Data retrieved from technology_building 
function DATA.technology_building_get_technology(technology)
    return DCON.dcon_technology_building_get_technology(technology - 1) + 1
end
---@param technology technology_id valid technology_id
---@return technology_building_id[] An array of technology_building 
function DATA.get_technology_building_from_technology(technology)
    local result = {}
    DATA.for_each_technology_building_from_technology(technology, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param technology technology_id valid technology_id
---@param func fun(item: technology_building_id) valid technology_id
function DATA.for_each_technology_building_from_technology(technology, func)
    ---@type number
    local range = DCON.dcon_technology_get_range_technology_building_as_technology(technology - 1)
    for i = 0, range - 1 do
        ---@type technology_building_id
        local accessed_element = DCON.dcon_technology_get_index_technology_building_as_technology(technology - 1, i) + 1
        if DCON.dcon_technology_building_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param technology technology_id valid technology_id
---@param func fun(item: technology_building_id):boolean 
---@return technology_building_id[]
function DATA.filter_array_technology_building_from_technology(technology, func)
    ---@type table<technology_building_id, technology_building_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_technology_get_range_technology_building_as_technology(technology - 1)
    for i = 0, range - 1 do
        ---@type technology_building_id
        local accessed_element = DCON.dcon_technology_get_index_technology_building_as_technology(technology - 1, i) + 1
        if DCON.dcon_technology_building_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param technology technology_id valid technology_id
---@param func fun(item: technology_building_id):boolean 
---@return table<technology_building_id, technology_building_id> 
function DATA.filter_technology_building_from_technology(technology, func)
    ---@type table<technology_building_id, technology_building_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_technology_get_range_technology_building_as_technology(technology - 1)
    for i = 0, range - 1 do
        ---@type technology_building_id
        local accessed_element = DCON.dcon_technology_get_index_technology_building_as_technology(technology - 1, i) + 1
        if DCON.dcon_technology_building_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param technology_building_id technology_building_id valid technology_building id
---@param value technology_id valid technology_id
function DATA.technology_building_set_technology(technology_building_id, value)
    DCON.dcon_technology_building_set_technology(technology_building_id - 1, value - 1)
end
---@param unlocked technology_building_id valid building_type_id
---@return building_type_id Data retrieved from technology_building 
function DATA.technology_building_get_unlocked(unlocked)
    return DCON.dcon_technology_building_get_unlocked(unlocked - 1) + 1
end
---@param unlocked building_type_id valid building_type_id
---@return technology_building_id technology_building 
function DATA.get_technology_building_from_unlocked(unlocked)
    return DCON.dcon_building_type_get_technology_building_as_unlocked(unlocked - 1) + 1
end
---@param technology_building_id technology_building_id valid technology_building id
---@param value building_type_id valid building_type_id
function DATA.technology_building_set_unlocked(technology_building_id, value)
    DCON.dcon_technology_building_set_unlocked(technology_building_id - 1, value - 1)
end

local fat_technology_building_id_metatable = {
    __index = function (t,k)
        if (k == "technology") then return DATA.technology_building_get_technology(t.id) end
        if (k == "unlocked") then return DATA.technology_building_get_unlocked(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "technology") then
            DATA.technology_building_set_technology(t.id, v)
            return
        end
        if (k == "unlocked") then
            DATA.technology_building_set_unlocked(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id technology_building_id
---@return fat_technology_building_id fat_id
function DATA.fatten_technology_building(id)
    local result = {id = id}
    setmetatable(result, fat_technology_building_id_metatable)
    return result --[[@as fat_technology_building_id]]
end
