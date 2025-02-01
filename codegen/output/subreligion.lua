local ffi = require("ffi")
----------subreligion----------


---subreligion: LSP types---

---Unique identificator for subreligion entity
---@class (exact) subreligion_id : table
---@field is_subreligion number
---@class (exact) fat_subreligion_id
---@field id subreligion_id Unique subreligion id
---@field religion religion_id 
---@field faith faith_id 

---@class struct_subreligion


ffi.cdef[[
void dcon_delete_subreligion(int32_t j);
int32_t dcon_force_create_subreligion(int32_t religion, int32_t faith);
void dcon_subreligion_set_religion(int32_t, int32_t);
int32_t dcon_subreligion_get_religion(int32_t);
int32_t dcon_religion_get_range_subreligion_as_religion(int32_t);
int32_t dcon_religion_get_index_subreligion_as_religion(int32_t, int32_t);
void dcon_subreligion_set_faith(int32_t, int32_t);
int32_t dcon_subreligion_get_faith(int32_t);
int32_t dcon_faith_get_subreligion_as_faith(int32_t);
bool dcon_subreligion_is_valid(int32_t);
void dcon_subreligion_resize(uint32_t sz);
uint32_t dcon_subreligion_size();
]]

---subreligion: FFI arrays---

---subreligion: LUA bindings---

DATA.subreligion_size = 10000
---@param religion religion_id
---@param faith faith_id
---@return subreligion_id
function DATA.force_create_subreligion(religion, faith)
    ---@type subreligion_id
    local i = DCON.dcon_force_create_subreligion(religion - 1, faith - 1) + 1
    return i --[[@as subreligion_id]] 
end
---@param i subreligion_id
function DATA.delete_subreligion(i)
    assert(DCON.dcon_subreligion_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_subreligion(i - 1)
end
---@param func fun(item: subreligion_id) 
function DATA.for_each_subreligion(func)
    ---@type number
    local range = DCON.dcon_subreligion_size()
    for i = 0, range - 1 do
        if DCON.dcon_subreligion_is_valid(i) then func(i + 1 --[[@as subreligion_id]]) end
    end
end
---@param func fun(item: subreligion_id):boolean 
---@return table<subreligion_id, subreligion_id> 
function DATA.filter_subreligion(func)
    ---@type table<subreligion_id, subreligion_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_subreligion_size()
    for i = 0, range - 1 do
        if DCON.dcon_subreligion_is_valid(i) and func(i + 1 --[[@as subreligion_id]]) then t[i + 1 --[[@as subreligion_id]]] = i + 1 --[[@as subreligion_id]] end
    end
    return t
end

---@param religion subreligion_id valid religion_id
---@return religion_id Data retrieved from subreligion 
function DATA.subreligion_get_religion(religion)
    return DCON.dcon_subreligion_get_religion(religion - 1) + 1
end
---@param religion religion_id valid religion_id
---@return subreligion_id[] An array of subreligion 
function DATA.get_subreligion_from_religion(religion)
    local result = {}
    DATA.for_each_subreligion_from_religion(religion, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param religion religion_id valid religion_id
---@param func fun(item: subreligion_id) valid religion_id
function DATA.for_each_subreligion_from_religion(religion, func)
    ---@type number
    local range = DCON.dcon_religion_get_range_subreligion_as_religion(religion - 1)
    for i = 0, range - 1 do
        ---@type subreligion_id
        local accessed_element = DCON.dcon_religion_get_index_subreligion_as_religion(religion - 1, i) + 1
        if DCON.dcon_subreligion_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param religion religion_id valid religion_id
---@param func fun(item: subreligion_id):boolean 
---@return subreligion_id[]
function DATA.filter_array_subreligion_from_religion(religion, func)
    ---@type table<subreligion_id, subreligion_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_religion_get_range_subreligion_as_religion(religion - 1)
    for i = 0, range - 1 do
        ---@type subreligion_id
        local accessed_element = DCON.dcon_religion_get_index_subreligion_as_religion(religion - 1, i) + 1
        if DCON.dcon_subreligion_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param religion religion_id valid religion_id
---@param func fun(item: subreligion_id):boolean 
---@return table<subreligion_id, subreligion_id> 
function DATA.filter_subreligion_from_religion(religion, func)
    ---@type table<subreligion_id, subreligion_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_religion_get_range_subreligion_as_religion(religion - 1)
    for i = 0, range - 1 do
        ---@type subreligion_id
        local accessed_element = DCON.dcon_religion_get_index_subreligion_as_religion(religion - 1, i) + 1
        if DCON.dcon_subreligion_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param subreligion_id subreligion_id valid subreligion id
---@param value religion_id valid religion_id
function DATA.subreligion_set_religion(subreligion_id, value)
    DCON.dcon_subreligion_set_religion(subreligion_id - 1, value - 1)
end
---@param faith subreligion_id valid faith_id
---@return faith_id Data retrieved from subreligion 
function DATA.subreligion_get_faith(faith)
    return DCON.dcon_subreligion_get_faith(faith - 1) + 1
end
---@param faith faith_id valid faith_id
---@return subreligion_id subreligion 
function DATA.get_subreligion_from_faith(faith)
    return DCON.dcon_faith_get_subreligion_as_faith(faith - 1) + 1
end
---@param subreligion_id subreligion_id valid subreligion id
---@param value faith_id valid faith_id
function DATA.subreligion_set_faith(subreligion_id, value)
    DCON.dcon_subreligion_set_faith(subreligion_id - 1, value - 1)
end

local fat_subreligion_id_metatable = {
    __index = function (t,k)
        if (k == "religion") then return DATA.subreligion_get_religion(t.id) end
        if (k == "faith") then return DATA.subreligion_get_faith(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "religion") then
            DATA.subreligion_set_religion(t.id, v)
            return
        end
        if (k == "faith") then
            DATA.subreligion_set_faith(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id subreligion_id
---@return fat_subreligion_id fat_id
function DATA.fatten_subreligion(id)
    local result = {id = id}
    setmetatable(result, fat_subreligion_id_metatable)
    return result --[[@as fat_subreligion_id]]
end
