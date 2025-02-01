local ffi = require("ffi")
----------cultural_union----------


---cultural_union: LSP types---

---Unique identificator for cultural_union entity
---@class (exact) cultural_union_id : table
---@field is_cultural_union number
---@class (exact) fat_cultural_union_id
---@field id cultural_union_id Unique cultural_union id
---@field culture_group culture_group_id 
---@field culture culture_id 

---@class struct_cultural_union


ffi.cdef[[
void dcon_delete_cultural_union(int32_t j);
int32_t dcon_force_create_cultural_union(int32_t culture_group, int32_t culture);
void dcon_cultural_union_set_culture_group(int32_t, int32_t);
int32_t dcon_cultural_union_get_culture_group(int32_t);
int32_t dcon_culture_group_get_range_cultural_union_as_culture_group(int32_t);
int32_t dcon_culture_group_get_index_cultural_union_as_culture_group(int32_t, int32_t);
void dcon_cultural_union_set_culture(int32_t, int32_t);
int32_t dcon_cultural_union_get_culture(int32_t);
int32_t dcon_culture_get_cultural_union_as_culture(int32_t);
bool dcon_cultural_union_is_valid(int32_t);
void dcon_cultural_union_resize(uint32_t sz);
uint32_t dcon_cultural_union_size();
]]

---cultural_union: FFI arrays---

---cultural_union: LUA bindings---

DATA.cultural_union_size = 10000
---@param culture_group culture_group_id
---@param culture culture_id
---@return cultural_union_id
function DATA.force_create_cultural_union(culture_group, culture)
    ---@type cultural_union_id
    local i = DCON.dcon_force_create_cultural_union(culture_group - 1, culture - 1) + 1
    return i --[[@as cultural_union_id]] 
end
---@param i cultural_union_id
function DATA.delete_cultural_union(i)
    assert(DCON.dcon_cultural_union_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_cultural_union(i - 1)
end
---@param func fun(item: cultural_union_id) 
function DATA.for_each_cultural_union(func)
    ---@type number
    local range = DCON.dcon_cultural_union_size()
    for i = 0, range - 1 do
        if DCON.dcon_cultural_union_is_valid(i) then func(i + 1 --[[@as cultural_union_id]]) end
    end
end
---@param func fun(item: cultural_union_id):boolean 
---@return table<cultural_union_id, cultural_union_id> 
function DATA.filter_cultural_union(func)
    ---@type table<cultural_union_id, cultural_union_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_cultural_union_size()
    for i = 0, range - 1 do
        if DCON.dcon_cultural_union_is_valid(i) and func(i + 1 --[[@as cultural_union_id]]) then t[i + 1 --[[@as cultural_union_id]]] = i + 1 --[[@as cultural_union_id]] end
    end
    return t
end

---@param culture_group cultural_union_id valid culture_group_id
---@return culture_group_id Data retrieved from cultural_union 
function DATA.cultural_union_get_culture_group(culture_group)
    return DCON.dcon_cultural_union_get_culture_group(culture_group - 1) + 1
end
---@param culture_group culture_group_id valid culture_group_id
---@return cultural_union_id[] An array of cultural_union 
function DATA.get_cultural_union_from_culture_group(culture_group)
    local result = {}
    DATA.for_each_cultural_union_from_culture_group(culture_group, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param culture_group culture_group_id valid culture_group_id
---@param func fun(item: cultural_union_id) valid culture_group_id
function DATA.for_each_cultural_union_from_culture_group(culture_group, func)
    ---@type number
    local range = DCON.dcon_culture_group_get_range_cultural_union_as_culture_group(culture_group - 1)
    for i = 0, range - 1 do
        ---@type cultural_union_id
        local accessed_element = DCON.dcon_culture_group_get_index_cultural_union_as_culture_group(culture_group - 1, i) + 1
        if DCON.dcon_cultural_union_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param culture_group culture_group_id valid culture_group_id
---@param func fun(item: cultural_union_id):boolean 
---@return cultural_union_id[]
function DATA.filter_array_cultural_union_from_culture_group(culture_group, func)
    ---@type table<cultural_union_id, cultural_union_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_culture_group_get_range_cultural_union_as_culture_group(culture_group - 1)
    for i = 0, range - 1 do
        ---@type cultural_union_id
        local accessed_element = DCON.dcon_culture_group_get_index_cultural_union_as_culture_group(culture_group - 1, i) + 1
        if DCON.dcon_cultural_union_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param culture_group culture_group_id valid culture_group_id
---@param func fun(item: cultural_union_id):boolean 
---@return table<cultural_union_id, cultural_union_id> 
function DATA.filter_cultural_union_from_culture_group(culture_group, func)
    ---@type table<cultural_union_id, cultural_union_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_culture_group_get_range_cultural_union_as_culture_group(culture_group - 1)
    for i = 0, range - 1 do
        ---@type cultural_union_id
        local accessed_element = DCON.dcon_culture_group_get_index_cultural_union_as_culture_group(culture_group - 1, i) + 1
        if DCON.dcon_cultural_union_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param cultural_union_id cultural_union_id valid cultural_union id
---@param value culture_group_id valid culture_group_id
function DATA.cultural_union_set_culture_group(cultural_union_id, value)
    DCON.dcon_cultural_union_set_culture_group(cultural_union_id - 1, value - 1)
end
---@param culture cultural_union_id valid culture_id
---@return culture_id Data retrieved from cultural_union 
function DATA.cultural_union_get_culture(culture)
    return DCON.dcon_cultural_union_get_culture(culture - 1) + 1
end
---@param culture culture_id valid culture_id
---@return cultural_union_id cultural_union 
function DATA.get_cultural_union_from_culture(culture)
    return DCON.dcon_culture_get_cultural_union_as_culture(culture - 1) + 1
end
---@param cultural_union_id cultural_union_id valid cultural_union id
---@param value culture_id valid culture_id
function DATA.cultural_union_set_culture(cultural_union_id, value)
    DCON.dcon_cultural_union_set_culture(cultural_union_id - 1, value - 1)
end

local fat_cultural_union_id_metatable = {
    __index = function (t,k)
        if (k == "culture_group") then return DATA.cultural_union_get_culture_group(t.id) end
        if (k == "culture") then return DATA.cultural_union_get_culture(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "culture_group") then
            DATA.cultural_union_set_culture_group(t.id, v)
            return
        end
        if (k == "culture") then
            DATA.cultural_union_set_culture(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id cultural_union_id
---@return fat_cultural_union_id fat_id
function DATA.fatten_cultural_union(id)
    local result = {id = id}
    setmetatable(result, fat_cultural_union_id_metatable)
    return result --[[@as fat_cultural_union_id]]
end
