local ffi = require("ffi")
----------personal_rights----------


---personal_rights: LSP types---

---Unique identificator for personal_rights entity
---@class (exact) personal_rights_id : table
---@field is_personal_rights number
---@class (exact) fat_personal_rights_id
---@field id personal_rights_id Unique personal_rights id
---@field can_trade boolean 
---@field can_build boolean 
---@field person pop_id 
---@field realm realm_id 

---@class struct_personal_rights
---@field can_trade boolean 
---@field can_build boolean 


ffi.cdef[[
void dcon_personal_rights_set_can_trade(int32_t, bool);
bool dcon_personal_rights_get_can_trade(int32_t);
void dcon_personal_rights_set_can_build(int32_t, bool);
bool dcon_personal_rights_get_can_build(int32_t);
void dcon_delete_personal_rights(int32_t j);
int32_t dcon_force_create_personal_rights(int32_t person, int32_t realm);
void dcon_personal_rights_set_person(int32_t, int32_t);
int32_t dcon_personal_rights_get_person(int32_t);
int32_t dcon_pop_get_range_personal_rights_as_person(int32_t);
int32_t dcon_pop_get_index_personal_rights_as_person(int32_t, int32_t);
void dcon_personal_rights_set_realm(int32_t, int32_t);
int32_t dcon_personal_rights_get_realm(int32_t);
int32_t dcon_realm_get_range_personal_rights_as_realm(int32_t);
int32_t dcon_realm_get_index_personal_rights_as_realm(int32_t, int32_t);
bool dcon_personal_rights_is_valid(int32_t);
void dcon_personal_rights_resize(uint32_t sz);
uint32_t dcon_personal_rights_size();
]]

---personal_rights: FFI arrays---

---personal_rights: LUA bindings---

DATA.personal_rights_size = 450000
---@param person pop_id
---@param realm realm_id
---@return personal_rights_id
function DATA.force_create_personal_rights(person, realm)
    ---@type personal_rights_id
    local i = DCON.dcon_force_create_personal_rights(person - 1, realm - 1) + 1
    return i --[[@as personal_rights_id]] 
end
---@param i personal_rights_id
function DATA.delete_personal_rights(i)
    assert(DCON.dcon_personal_rights_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_personal_rights(i - 1)
end
---@param func fun(item: personal_rights_id) 
function DATA.for_each_personal_rights(func)
    ---@type number
    local range = DCON.dcon_personal_rights_size()
    for i = 0, range - 1 do
        if DCON.dcon_personal_rights_is_valid(i) then func(i + 1 --[[@as personal_rights_id]]) end
    end
end
---@param func fun(item: personal_rights_id):boolean 
---@return table<personal_rights_id, personal_rights_id> 
function DATA.filter_personal_rights(func)
    ---@type table<personal_rights_id, personal_rights_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_personal_rights_size()
    for i = 0, range - 1 do
        if DCON.dcon_personal_rights_is_valid(i) and func(i + 1 --[[@as personal_rights_id]]) then t[i + 1 --[[@as personal_rights_id]]] = i + 1 --[[@as personal_rights_id]] end
    end
    return t
end

---@param personal_rights_id personal_rights_id valid personal_rights id
---@return boolean can_trade 
function DATA.personal_rights_get_can_trade(personal_rights_id)
    return DCON.dcon_personal_rights_get_can_trade(personal_rights_id - 1)
end
---@param personal_rights_id personal_rights_id valid personal_rights id
---@param value boolean valid boolean
function DATA.personal_rights_set_can_trade(personal_rights_id, value)
    DCON.dcon_personal_rights_set_can_trade(personal_rights_id - 1, value)
end
---@param personal_rights_id personal_rights_id valid personal_rights id
---@return boolean can_build 
function DATA.personal_rights_get_can_build(personal_rights_id)
    return DCON.dcon_personal_rights_get_can_build(personal_rights_id - 1)
end
---@param personal_rights_id personal_rights_id valid personal_rights id
---@param value boolean valid boolean
function DATA.personal_rights_set_can_build(personal_rights_id, value)
    DCON.dcon_personal_rights_set_can_build(personal_rights_id - 1, value)
end
---@param person personal_rights_id valid pop_id
---@return pop_id Data retrieved from personal_rights 
function DATA.personal_rights_get_person(person)
    return DCON.dcon_personal_rights_get_person(person - 1) + 1
end
---@param person pop_id valid pop_id
---@return personal_rights_id[] An array of personal_rights 
function DATA.get_personal_rights_from_person(person)
    local result = {}
    DATA.for_each_personal_rights_from_person(person, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param person pop_id valid pop_id
---@param func fun(item: personal_rights_id) valid pop_id
function DATA.for_each_personal_rights_from_person(person, func)
    ---@type number
    local range = DCON.dcon_pop_get_range_personal_rights_as_person(person - 1)
    for i = 0, range - 1 do
        ---@type personal_rights_id
        local accessed_element = DCON.dcon_pop_get_index_personal_rights_as_person(person - 1, i) + 1
        if DCON.dcon_personal_rights_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param person pop_id valid pop_id
---@param func fun(item: personal_rights_id):boolean 
---@return personal_rights_id[]
function DATA.filter_array_personal_rights_from_person(person, func)
    ---@type table<personal_rights_id, personal_rights_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_personal_rights_as_person(person - 1)
    for i = 0, range - 1 do
        ---@type personal_rights_id
        local accessed_element = DCON.dcon_pop_get_index_personal_rights_as_person(person - 1, i) + 1
        if DCON.dcon_personal_rights_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param person pop_id valid pop_id
---@param func fun(item: personal_rights_id):boolean 
---@return table<personal_rights_id, personal_rights_id> 
function DATA.filter_personal_rights_from_person(person, func)
    ---@type table<personal_rights_id, personal_rights_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_pop_get_range_personal_rights_as_person(person - 1)
    for i = 0, range - 1 do
        ---@type personal_rights_id
        local accessed_element = DCON.dcon_pop_get_index_personal_rights_as_person(person - 1, i) + 1
        if DCON.dcon_personal_rights_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param personal_rights_id personal_rights_id valid personal_rights id
---@param value pop_id valid pop_id
function DATA.personal_rights_set_person(personal_rights_id, value)
    DCON.dcon_personal_rights_set_person(personal_rights_id - 1, value - 1)
end
---@param realm personal_rights_id valid realm_id
---@return realm_id Data retrieved from personal_rights 
function DATA.personal_rights_get_realm(realm)
    return DCON.dcon_personal_rights_get_realm(realm - 1) + 1
end
---@param realm realm_id valid realm_id
---@return personal_rights_id[] An array of personal_rights 
function DATA.get_personal_rights_from_realm(realm)
    local result = {}
    DATA.for_each_personal_rights_from_realm(realm, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param realm realm_id valid realm_id
---@param func fun(item: personal_rights_id) valid realm_id
function DATA.for_each_personal_rights_from_realm(realm, func)
    ---@type number
    local range = DCON.dcon_realm_get_range_personal_rights_as_realm(realm - 1)
    for i = 0, range - 1 do
        ---@type personal_rights_id
        local accessed_element = DCON.dcon_realm_get_index_personal_rights_as_realm(realm - 1, i) + 1
        if DCON.dcon_personal_rights_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param realm realm_id valid realm_id
---@param func fun(item: personal_rights_id):boolean 
---@return personal_rights_id[]
function DATA.filter_array_personal_rights_from_realm(realm, func)
    ---@type table<personal_rights_id, personal_rights_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_get_range_personal_rights_as_realm(realm - 1)
    for i = 0, range - 1 do
        ---@type personal_rights_id
        local accessed_element = DCON.dcon_realm_get_index_personal_rights_as_realm(realm - 1, i) + 1
        if DCON.dcon_personal_rights_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param realm realm_id valid realm_id
---@param func fun(item: personal_rights_id):boolean 
---@return table<personal_rights_id, personal_rights_id> 
function DATA.filter_personal_rights_from_realm(realm, func)
    ---@type table<personal_rights_id, personal_rights_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_get_range_personal_rights_as_realm(realm - 1)
    for i = 0, range - 1 do
        ---@type personal_rights_id
        local accessed_element = DCON.dcon_realm_get_index_personal_rights_as_realm(realm - 1, i) + 1
        if DCON.dcon_personal_rights_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param personal_rights_id personal_rights_id valid personal_rights id
---@param value realm_id valid realm_id
function DATA.personal_rights_set_realm(personal_rights_id, value)
    DCON.dcon_personal_rights_set_realm(personal_rights_id - 1, value - 1)
end

local fat_personal_rights_id_metatable = {
    __index = function (t,k)
        if (k == "can_trade") then return DATA.personal_rights_get_can_trade(t.id) end
        if (k == "can_build") then return DATA.personal_rights_get_can_build(t.id) end
        if (k == "person") then return DATA.personal_rights_get_person(t.id) end
        if (k == "realm") then return DATA.personal_rights_get_realm(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "can_trade") then
            DATA.personal_rights_set_can_trade(t.id, v)
            return
        end
        if (k == "can_build") then
            DATA.personal_rights_set_can_build(t.id, v)
            return
        end
        if (k == "person") then
            DATA.personal_rights_set_person(t.id, v)
            return
        end
        if (k == "realm") then
            DATA.personal_rights_set_realm(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id personal_rights_id
---@return fat_personal_rights_id fat_id
function DATA.fatten_personal_rights(id)
    local result = {id = id}
    setmetatable(result, fat_personal_rights_id_metatable)
    return result --[[@as fat_personal_rights_id]]
end
