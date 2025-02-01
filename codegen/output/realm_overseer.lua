local ffi = require("ffi")
----------realm_overseer----------


---realm_overseer: LSP types---

---Unique identificator for realm_overseer entity
---@class (exact) realm_overseer_id : table
---@field is_realm_overseer number
---@class (exact) fat_realm_overseer_id
---@field id realm_overseer_id Unique realm_overseer id
---@field overseer pop_id 
---@field realm realm_id 

---@class struct_realm_overseer


ffi.cdef[[
void dcon_delete_realm_overseer(int32_t j);
int32_t dcon_force_create_realm_overseer(int32_t overseer, int32_t realm);
void dcon_realm_overseer_set_overseer(int32_t, int32_t);
int32_t dcon_realm_overseer_get_overseer(int32_t);
int32_t dcon_pop_get_realm_overseer_as_overseer(int32_t);
void dcon_realm_overseer_set_realm(int32_t, int32_t);
int32_t dcon_realm_overseer_get_realm(int32_t);
int32_t dcon_realm_get_realm_overseer_as_realm(int32_t);
bool dcon_realm_overseer_is_valid(int32_t);
void dcon_realm_overseer_resize(uint32_t sz);
uint32_t dcon_realm_overseer_size();
]]

---realm_overseer: FFI arrays---

---realm_overseer: LUA bindings---

DATA.realm_overseer_size = 15000
---@param overseer pop_id
---@param realm realm_id
---@return realm_overseer_id
function DATA.force_create_realm_overseer(overseer, realm)
    ---@type realm_overseer_id
    local i = DCON.dcon_force_create_realm_overseer(overseer - 1, realm - 1) + 1
    return i --[[@as realm_overseer_id]] 
end
---@param i realm_overseer_id
function DATA.delete_realm_overseer(i)
    assert(DCON.dcon_realm_overseer_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_realm_overseer(i - 1)
end
---@param func fun(item: realm_overseer_id) 
function DATA.for_each_realm_overseer(func)
    ---@type number
    local range = DCON.dcon_realm_overseer_size()
    for i = 0, range - 1 do
        if DCON.dcon_realm_overseer_is_valid(i) then func(i + 1 --[[@as realm_overseer_id]]) end
    end
end
---@param func fun(item: realm_overseer_id):boolean 
---@return table<realm_overseer_id, realm_overseer_id> 
function DATA.filter_realm_overseer(func)
    ---@type table<realm_overseer_id, realm_overseer_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_overseer_size()
    for i = 0, range - 1 do
        if DCON.dcon_realm_overseer_is_valid(i) and func(i + 1 --[[@as realm_overseer_id]]) then t[i + 1 --[[@as realm_overseer_id]]] = i + 1 --[[@as realm_overseer_id]] end
    end
    return t
end

---@param overseer realm_overseer_id valid pop_id
---@return pop_id Data retrieved from realm_overseer 
function DATA.realm_overseer_get_overseer(overseer)
    return DCON.dcon_realm_overseer_get_overseer(overseer - 1) + 1
end
---@param overseer pop_id valid pop_id
---@return realm_overseer_id realm_overseer 
function DATA.get_realm_overseer_from_overseer(overseer)
    return DCON.dcon_pop_get_realm_overseer_as_overseer(overseer - 1) + 1
end
---@param realm_overseer_id realm_overseer_id valid realm_overseer id
---@param value pop_id valid pop_id
function DATA.realm_overseer_set_overseer(realm_overseer_id, value)
    DCON.dcon_realm_overseer_set_overseer(realm_overseer_id - 1, value - 1)
end
---@param realm realm_overseer_id valid realm_id
---@return realm_id Data retrieved from realm_overseer 
function DATA.realm_overseer_get_realm(realm)
    return DCON.dcon_realm_overseer_get_realm(realm - 1) + 1
end
---@param realm realm_id valid realm_id
---@return realm_overseer_id realm_overseer 
function DATA.get_realm_overseer_from_realm(realm)
    return DCON.dcon_realm_get_realm_overseer_as_realm(realm - 1) + 1
end
---@param realm_overseer_id realm_overseer_id valid realm_overseer id
---@param value realm_id valid realm_id
function DATA.realm_overseer_set_realm(realm_overseer_id, value)
    DCON.dcon_realm_overseer_set_realm(realm_overseer_id - 1, value - 1)
end

local fat_realm_overseer_id_metatable = {
    __index = function (t,k)
        if (k == "overseer") then return DATA.realm_overseer_get_overseer(t.id) end
        if (k == "realm") then return DATA.realm_overseer_get_realm(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "overseer") then
            DATA.realm_overseer_set_overseer(t.id, v)
            return
        end
        if (k == "realm") then
            DATA.realm_overseer_set_realm(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id realm_overseer_id
---@return fat_realm_overseer_id fat_id
function DATA.fatten_realm_overseer(id)
    local result = {id = id}
    setmetatable(result, fat_realm_overseer_id_metatable)
    return result --[[@as fat_realm_overseer_id]]
end
