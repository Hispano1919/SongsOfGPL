local ffi = require("ffi")
----------realm_subject_relation----------


---realm_subject_relation: LSP types---

---Unique identificator for realm_subject_relation entity
---@class (exact) realm_subject_relation_id : table
---@field is_realm_subject_relation number
---@class (exact) fat_realm_subject_relation_id
---@field id realm_subject_relation_id Unique realm_subject_relation id
---@field wealth_transfer boolean 
---@field goods_transfer boolean 
---@field warriors_contribution boolean 
---@field protection boolean 
---@field local_ruler boolean 
---@field overlord realm_id 
---@field subject realm_id 

---@class struct_realm_subject_relation
---@field wealth_transfer boolean 
---@field goods_transfer boolean 
---@field warriors_contribution boolean 
---@field protection boolean 
---@field local_ruler boolean 


ffi.cdef[[
void dcon_realm_subject_relation_set_wealth_transfer(int32_t, bool);
bool dcon_realm_subject_relation_get_wealth_transfer(int32_t);
void dcon_realm_subject_relation_set_goods_transfer(int32_t, bool);
bool dcon_realm_subject_relation_get_goods_transfer(int32_t);
void dcon_realm_subject_relation_set_warriors_contribution(int32_t, bool);
bool dcon_realm_subject_relation_get_warriors_contribution(int32_t);
void dcon_realm_subject_relation_set_protection(int32_t, bool);
bool dcon_realm_subject_relation_get_protection(int32_t);
void dcon_realm_subject_relation_set_local_ruler(int32_t, bool);
bool dcon_realm_subject_relation_get_local_ruler(int32_t);
void dcon_delete_realm_subject_relation(int32_t j);
int32_t dcon_force_create_realm_subject_relation(int32_t overlord, int32_t subject);
void dcon_realm_subject_relation_set_overlord(int32_t, int32_t);
int32_t dcon_realm_subject_relation_get_overlord(int32_t);
int32_t dcon_realm_get_range_realm_subject_relation_as_overlord(int32_t);
int32_t dcon_realm_get_index_realm_subject_relation_as_overlord(int32_t, int32_t);
void dcon_realm_subject_relation_set_subject(int32_t, int32_t);
int32_t dcon_realm_subject_relation_get_subject(int32_t);
int32_t dcon_realm_get_range_realm_subject_relation_as_subject(int32_t);
int32_t dcon_realm_get_index_realm_subject_relation_as_subject(int32_t, int32_t);
bool dcon_realm_subject_relation_is_valid(int32_t);
void dcon_realm_subject_relation_resize(uint32_t sz);
uint32_t dcon_realm_subject_relation_size();
]]

---realm_subject_relation: FFI arrays---

---realm_subject_relation: LUA bindings---

DATA.realm_subject_relation_size = 15000
---@param overlord realm_id
---@param subject realm_id
---@return realm_subject_relation_id
function DATA.force_create_realm_subject_relation(overlord, subject)
    ---@type realm_subject_relation_id
    local i = DCON.dcon_force_create_realm_subject_relation(overlord - 1, subject - 1) + 1
    return i --[[@as realm_subject_relation_id]] 
end
---@param i realm_subject_relation_id
function DATA.delete_realm_subject_relation(i)
    assert(DCON.dcon_realm_subject_relation_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_realm_subject_relation(i - 1)
end
---@param func fun(item: realm_subject_relation_id) 
function DATA.for_each_realm_subject_relation(func)
    ---@type number
    local range = DCON.dcon_realm_subject_relation_size()
    for i = 0, range - 1 do
        if DCON.dcon_realm_subject_relation_is_valid(i) then func(i + 1 --[[@as realm_subject_relation_id]]) end
    end
end
---@param func fun(item: realm_subject_relation_id):boolean 
---@return table<realm_subject_relation_id, realm_subject_relation_id> 
function DATA.filter_realm_subject_relation(func)
    ---@type table<realm_subject_relation_id, realm_subject_relation_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_subject_relation_size()
    for i = 0, range - 1 do
        if DCON.dcon_realm_subject_relation_is_valid(i) and func(i + 1 --[[@as realm_subject_relation_id]]) then t[i + 1 --[[@as realm_subject_relation_id]]] = i + 1 --[[@as realm_subject_relation_id]] end
    end
    return t
end

---@param realm_subject_relation_id realm_subject_relation_id valid realm_subject_relation id
---@return boolean wealth_transfer 
function DATA.realm_subject_relation_get_wealth_transfer(realm_subject_relation_id)
    return DCON.dcon_realm_subject_relation_get_wealth_transfer(realm_subject_relation_id - 1)
end
---@param realm_subject_relation_id realm_subject_relation_id valid realm_subject_relation id
---@param value boolean valid boolean
function DATA.realm_subject_relation_set_wealth_transfer(realm_subject_relation_id, value)
    DCON.dcon_realm_subject_relation_set_wealth_transfer(realm_subject_relation_id - 1, value)
end
---@param realm_subject_relation_id realm_subject_relation_id valid realm_subject_relation id
---@return boolean goods_transfer 
function DATA.realm_subject_relation_get_goods_transfer(realm_subject_relation_id)
    return DCON.dcon_realm_subject_relation_get_goods_transfer(realm_subject_relation_id - 1)
end
---@param realm_subject_relation_id realm_subject_relation_id valid realm_subject_relation id
---@param value boolean valid boolean
function DATA.realm_subject_relation_set_goods_transfer(realm_subject_relation_id, value)
    DCON.dcon_realm_subject_relation_set_goods_transfer(realm_subject_relation_id - 1, value)
end
---@param realm_subject_relation_id realm_subject_relation_id valid realm_subject_relation id
---@return boolean warriors_contribution 
function DATA.realm_subject_relation_get_warriors_contribution(realm_subject_relation_id)
    return DCON.dcon_realm_subject_relation_get_warriors_contribution(realm_subject_relation_id - 1)
end
---@param realm_subject_relation_id realm_subject_relation_id valid realm_subject_relation id
---@param value boolean valid boolean
function DATA.realm_subject_relation_set_warriors_contribution(realm_subject_relation_id, value)
    DCON.dcon_realm_subject_relation_set_warriors_contribution(realm_subject_relation_id - 1, value)
end
---@param realm_subject_relation_id realm_subject_relation_id valid realm_subject_relation id
---@return boolean protection 
function DATA.realm_subject_relation_get_protection(realm_subject_relation_id)
    return DCON.dcon_realm_subject_relation_get_protection(realm_subject_relation_id - 1)
end
---@param realm_subject_relation_id realm_subject_relation_id valid realm_subject_relation id
---@param value boolean valid boolean
function DATA.realm_subject_relation_set_protection(realm_subject_relation_id, value)
    DCON.dcon_realm_subject_relation_set_protection(realm_subject_relation_id - 1, value)
end
---@param realm_subject_relation_id realm_subject_relation_id valid realm_subject_relation id
---@return boolean local_ruler 
function DATA.realm_subject_relation_get_local_ruler(realm_subject_relation_id)
    return DCON.dcon_realm_subject_relation_get_local_ruler(realm_subject_relation_id - 1)
end
---@param realm_subject_relation_id realm_subject_relation_id valid realm_subject_relation id
---@param value boolean valid boolean
function DATA.realm_subject_relation_set_local_ruler(realm_subject_relation_id, value)
    DCON.dcon_realm_subject_relation_set_local_ruler(realm_subject_relation_id - 1, value)
end
---@param overlord realm_subject_relation_id valid realm_id
---@return realm_id Data retrieved from realm_subject_relation 
function DATA.realm_subject_relation_get_overlord(overlord)
    return DCON.dcon_realm_subject_relation_get_overlord(overlord - 1) + 1
end
---@param overlord realm_id valid realm_id
---@return realm_subject_relation_id[] An array of realm_subject_relation 
function DATA.get_realm_subject_relation_from_overlord(overlord)
    local result = {}
    DATA.for_each_realm_subject_relation_from_overlord(overlord, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param overlord realm_id valid realm_id
---@param func fun(item: realm_subject_relation_id) valid realm_id
function DATA.for_each_realm_subject_relation_from_overlord(overlord, func)
    ---@type number
    local range = DCON.dcon_realm_get_range_realm_subject_relation_as_overlord(overlord - 1)
    for i = 0, range - 1 do
        ---@type realm_subject_relation_id
        local accessed_element = DCON.dcon_realm_get_index_realm_subject_relation_as_overlord(overlord - 1, i) + 1
        if DCON.dcon_realm_subject_relation_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param overlord realm_id valid realm_id
---@param func fun(item: realm_subject_relation_id):boolean 
---@return realm_subject_relation_id[]
function DATA.filter_array_realm_subject_relation_from_overlord(overlord, func)
    ---@type table<realm_subject_relation_id, realm_subject_relation_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_get_range_realm_subject_relation_as_overlord(overlord - 1)
    for i = 0, range - 1 do
        ---@type realm_subject_relation_id
        local accessed_element = DCON.dcon_realm_get_index_realm_subject_relation_as_overlord(overlord - 1, i) + 1
        if DCON.dcon_realm_subject_relation_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param overlord realm_id valid realm_id
---@param func fun(item: realm_subject_relation_id):boolean 
---@return table<realm_subject_relation_id, realm_subject_relation_id> 
function DATA.filter_realm_subject_relation_from_overlord(overlord, func)
    ---@type table<realm_subject_relation_id, realm_subject_relation_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_get_range_realm_subject_relation_as_overlord(overlord - 1)
    for i = 0, range - 1 do
        ---@type realm_subject_relation_id
        local accessed_element = DCON.dcon_realm_get_index_realm_subject_relation_as_overlord(overlord - 1, i) + 1
        if DCON.dcon_realm_subject_relation_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param realm_subject_relation_id realm_subject_relation_id valid realm_subject_relation id
---@param value realm_id valid realm_id
function DATA.realm_subject_relation_set_overlord(realm_subject_relation_id, value)
    DCON.dcon_realm_subject_relation_set_overlord(realm_subject_relation_id - 1, value - 1)
end
---@param subject realm_subject_relation_id valid realm_id
---@return realm_id Data retrieved from realm_subject_relation 
function DATA.realm_subject_relation_get_subject(subject)
    return DCON.dcon_realm_subject_relation_get_subject(subject - 1) + 1
end
---@param subject realm_id valid realm_id
---@return realm_subject_relation_id[] An array of realm_subject_relation 
function DATA.get_realm_subject_relation_from_subject(subject)
    local result = {}
    DATA.for_each_realm_subject_relation_from_subject(subject, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param subject realm_id valid realm_id
---@param func fun(item: realm_subject_relation_id) valid realm_id
function DATA.for_each_realm_subject_relation_from_subject(subject, func)
    ---@type number
    local range = DCON.dcon_realm_get_range_realm_subject_relation_as_subject(subject - 1)
    for i = 0, range - 1 do
        ---@type realm_subject_relation_id
        local accessed_element = DCON.dcon_realm_get_index_realm_subject_relation_as_subject(subject - 1, i) + 1
        if DCON.dcon_realm_subject_relation_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param subject realm_id valid realm_id
---@param func fun(item: realm_subject_relation_id):boolean 
---@return realm_subject_relation_id[]
function DATA.filter_array_realm_subject_relation_from_subject(subject, func)
    ---@type table<realm_subject_relation_id, realm_subject_relation_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_get_range_realm_subject_relation_as_subject(subject - 1)
    for i = 0, range - 1 do
        ---@type realm_subject_relation_id
        local accessed_element = DCON.dcon_realm_get_index_realm_subject_relation_as_subject(subject - 1, i) + 1
        if DCON.dcon_realm_subject_relation_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param subject realm_id valid realm_id
---@param func fun(item: realm_subject_relation_id):boolean 
---@return table<realm_subject_relation_id, realm_subject_relation_id> 
function DATA.filter_realm_subject_relation_from_subject(subject, func)
    ---@type table<realm_subject_relation_id, realm_subject_relation_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_get_range_realm_subject_relation_as_subject(subject - 1)
    for i = 0, range - 1 do
        ---@type realm_subject_relation_id
        local accessed_element = DCON.dcon_realm_get_index_realm_subject_relation_as_subject(subject - 1, i) + 1
        if DCON.dcon_realm_subject_relation_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param realm_subject_relation_id realm_subject_relation_id valid realm_subject_relation id
---@param value realm_id valid realm_id
function DATA.realm_subject_relation_set_subject(realm_subject_relation_id, value)
    DCON.dcon_realm_subject_relation_set_subject(realm_subject_relation_id - 1, value - 1)
end

local fat_realm_subject_relation_id_metatable = {
    __index = function (t,k)
        if (k == "wealth_transfer") then return DATA.realm_subject_relation_get_wealth_transfer(t.id) end
        if (k == "goods_transfer") then return DATA.realm_subject_relation_get_goods_transfer(t.id) end
        if (k == "warriors_contribution") then return DATA.realm_subject_relation_get_warriors_contribution(t.id) end
        if (k == "protection") then return DATA.realm_subject_relation_get_protection(t.id) end
        if (k == "local_ruler") then return DATA.realm_subject_relation_get_local_ruler(t.id) end
        if (k == "overlord") then return DATA.realm_subject_relation_get_overlord(t.id) end
        if (k == "subject") then return DATA.realm_subject_relation_get_subject(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "wealth_transfer") then
            DATA.realm_subject_relation_set_wealth_transfer(t.id, v)
            return
        end
        if (k == "goods_transfer") then
            DATA.realm_subject_relation_set_goods_transfer(t.id, v)
            return
        end
        if (k == "warriors_contribution") then
            DATA.realm_subject_relation_set_warriors_contribution(t.id, v)
            return
        end
        if (k == "protection") then
            DATA.realm_subject_relation_set_protection(t.id, v)
            return
        end
        if (k == "local_ruler") then
            DATA.realm_subject_relation_set_local_ruler(t.id, v)
            return
        end
        if (k == "overlord") then
            DATA.realm_subject_relation_set_overlord(t.id, v)
            return
        end
        if (k == "subject") then
            DATA.realm_subject_relation_set_subject(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id realm_subject_relation_id
---@return fat_realm_subject_relation_id fat_id
function DATA.fatten_realm_subject_relation(id)
    local result = {id = id}
    setmetatable(result, fat_realm_subject_relation_id_metatable)
    return result --[[@as fat_realm_subject_relation_id]]
end
