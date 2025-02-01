local ffi = require("ffi")
----------parent_child_relation----------


---parent_child_relation: LSP types---

---Unique identificator for parent_child_relation entity
---@class (exact) parent_child_relation_id : table
---@field is_parent_child_relation number
---@class (exact) fat_parent_child_relation_id
---@field id parent_child_relation_id Unique parent_child_relation id
---@field parent pop_id 
---@field child pop_id 

---@class struct_parent_child_relation


ffi.cdef[[
void dcon_delete_parent_child_relation(int32_t j);
int32_t dcon_force_create_parent_child_relation(int32_t parent, int32_t child);
void dcon_parent_child_relation_set_parent(int32_t, int32_t);
int32_t dcon_parent_child_relation_get_parent(int32_t);
int32_t dcon_pop_get_range_parent_child_relation_as_parent(int32_t);
int32_t dcon_pop_get_index_parent_child_relation_as_parent(int32_t, int32_t);
void dcon_parent_child_relation_set_child(int32_t, int32_t);
int32_t dcon_parent_child_relation_get_child(int32_t);
int32_t dcon_pop_get_parent_child_relation_as_child(int32_t);
bool dcon_parent_child_relation_is_valid(int32_t);
void dcon_parent_child_relation_resize(uint32_t sz);
uint32_t dcon_parent_child_relation_size();
]]

---parent_child_relation: FFI arrays---

---parent_child_relation: LUA bindings---

DATA.parent_child_relation_size = 900000
---@param parent pop_id
---@param child pop_id
---@return parent_child_relation_id
function DATA.force_create_parent_child_relation(parent, child)
    ---@type parent_child_relation_id
    local i = DCON.dcon_force_create_parent_child_relation(parent - 1, child - 1) + 1
    return i --[[@as parent_child_relation_id]] 
end
---@param i parent_child_relation_id
function DATA.delete_parent_child_relation(i)
    assert(DCON.dcon_parent_child_relation_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_parent_child_relation(i - 1)
end
---@param func fun(item: parent_child_relation_id) 
function DATA.for_each_parent_child_relation(func)
    ---@type number
    local range = DCON.dcon_parent_child_relation_size()
    for i = 0, range - 1 do
        if DCON.dcon_parent_child_relation_is_valid(i) then func(i + 1 --[[@as parent_child_relation_id]]) end
    end
end
---@param func fun(item: parent_child_relation_id):boolean 
---@return table<parent_child_relation_id, parent_child_relation_id> 
function DATA.filter_parent_child_relation(func)
    ---@type table<parent_child_relation_id, parent_child_relation_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_parent_child_relation_size()
    for i = 0, range - 1 do
        if DCON.dcon_parent_child_relation_is_valid(i) and func(i + 1 --[[@as parent_child_relation_id]]) then t[i + 1 --[[@as parent_child_relation_id]]] = i + 1 --[[@as parent_child_relation_id]] end
    end
    return t
end

---@param parent parent_child_relation_id valid pop_id
---@return pop_id Data retrieved from parent_child_relation 
function DATA.parent_child_relation_get_parent(parent)
    return DCON.dcon_parent_child_relation_get_parent(parent - 1) + 1
end
---@param parent pop_id valid pop_id
---@return parent_child_relation_id[] An array of parent_child_relation 
function DATA.get_parent_child_relation_from_parent(parent)
    local result = {}
    DATA.for_each_parent_child_relation_from_parent(parent, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param parent pop_id valid pop_id
---@param func fun(item: parent_child_relation_id) valid pop_id
function DATA.for_each_parent_child_relation_from_parent(parent, func)
    ---@type number
    local range = DCON.dcon_pop_get_range_parent_child_relation_as_parent(parent - 1)
    for i = 0, range - 1 do
        ---@type parent_child_relation_id
        local accessed_element = DCON.dcon_pop_get_index_parent_child_relation_as_parent(parent - 1, i) + 1
        if DCON.dcon_parent_child_relation_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param parent pop_id valid pop_id
---@param func fun(item: parent_child_relation_id):boolean 
---@return parent_child_relation_id[]
function DATA.filter_array_parent_child_relation_from_parent(parent, func)
    ---@type table<parent_child_relation_id, parent_child_relation_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_parent_child_relation_as_parent(parent - 1)
    for i = 0, range - 1 do
        ---@type parent_child_relation_id
        local accessed_element = DCON.dcon_pop_get_index_parent_child_relation_as_parent(parent - 1, i) + 1
        if DCON.dcon_parent_child_relation_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param parent pop_id valid pop_id
---@param func fun(item: parent_child_relation_id):boolean 
---@return table<parent_child_relation_id, parent_child_relation_id> 
function DATA.filter_parent_child_relation_from_parent(parent, func)
    ---@type table<parent_child_relation_id, parent_child_relation_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_parent_child_relation_as_parent(parent - 1)
    for i = 0, range - 1 do
        ---@type parent_child_relation_id
        local accessed_element = DCON.dcon_pop_get_index_parent_child_relation_as_parent(parent - 1, i) + 1
        if DCON.dcon_parent_child_relation_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param parent_child_relation_id parent_child_relation_id valid parent_child_relation id
---@param value pop_id valid pop_id
function DATA.parent_child_relation_set_parent(parent_child_relation_id, value)
    DCON.dcon_parent_child_relation_set_parent(parent_child_relation_id - 1, value - 1)
end
---@param child parent_child_relation_id valid pop_id
---@return pop_id Data retrieved from parent_child_relation 
function DATA.parent_child_relation_get_child(child)
    return DCON.dcon_parent_child_relation_get_child(child - 1) + 1
end
---@param child pop_id valid pop_id
---@return parent_child_relation_id parent_child_relation 
function DATA.get_parent_child_relation_from_child(child)
    return DCON.dcon_pop_get_parent_child_relation_as_child(child - 1) + 1
end
---@param parent_child_relation_id parent_child_relation_id valid parent_child_relation id
---@param value pop_id valid pop_id
function DATA.parent_child_relation_set_child(parent_child_relation_id, value)
    DCON.dcon_parent_child_relation_set_child(parent_child_relation_id - 1, value - 1)
end

local fat_parent_child_relation_id_metatable = {
    __index = function (t,k)
        if (k == "parent") then return DATA.parent_child_relation_get_parent(t.id) end
        if (k == "child") then return DATA.parent_child_relation_get_child(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "parent") then
            DATA.parent_child_relation_set_parent(t.id, v)
            return
        end
        if (k == "child") then
            DATA.parent_child_relation_set_child(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id parent_child_relation_id
---@return fat_parent_child_relation_id fat_id
function DATA.fatten_parent_child_relation(id)
    local result = {id = id}
    setmetatable(result, fat_parent_child_relation_id_metatable)
    return result --[[@as fat_parent_child_relation_id]]
end
