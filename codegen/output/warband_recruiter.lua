local ffi = require("ffi")
----------warband_recruiter----------


---warband_recruiter: LSP types---

---Unique identificator for warband_recruiter entity
---@class (exact) warband_recruiter_id : table
---@field is_warband_recruiter number
---@class (exact) fat_warband_recruiter_id
---@field id warband_recruiter_id Unique warband_recruiter id
---@field recruiter pop_id 
---@field warband warband_id 

---@class struct_warband_recruiter


ffi.cdef[[
void dcon_delete_warband_recruiter(int32_t j);
int32_t dcon_force_create_warband_recruiter(int32_t recruiter, int32_t warband);
void dcon_warband_recruiter_set_recruiter(int32_t, int32_t);
int32_t dcon_warband_recruiter_get_recruiter(int32_t);
int32_t dcon_pop_get_warband_recruiter_as_recruiter(int32_t);
void dcon_warband_recruiter_set_warband(int32_t, int32_t);
int32_t dcon_warband_recruiter_get_warband(int32_t);
int32_t dcon_warband_get_warband_recruiter_as_warband(int32_t);
bool dcon_warband_recruiter_is_valid(int32_t);
void dcon_warband_recruiter_resize(uint32_t sz);
uint32_t dcon_warband_recruiter_size();
]]

---warband_recruiter: FFI arrays---

---warband_recruiter: LUA bindings---

DATA.warband_recruiter_size = 50000
---@param recruiter pop_id
---@param warband warband_id
---@return warband_recruiter_id
function DATA.force_create_warband_recruiter(recruiter, warband)
    ---@type warband_recruiter_id
    local i = DCON.dcon_force_create_warband_recruiter(recruiter - 1, warband - 1) + 1
    return i --[[@as warband_recruiter_id]] 
end
---@param i warband_recruiter_id
function DATA.delete_warband_recruiter(i)
    assert(DCON.dcon_warband_recruiter_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_warband_recruiter(i - 1)
end
---@param func fun(item: warband_recruiter_id) 
function DATA.for_each_warband_recruiter(func)
    ---@type number
    local range = DCON.dcon_warband_recruiter_size()
    for i = 0, range - 1 do
        if DCON.dcon_warband_recruiter_is_valid(i) then func(i + 1 --[[@as warband_recruiter_id]]) end
    end
end
---@param func fun(item: warband_recruiter_id):boolean 
---@return table<warband_recruiter_id, warband_recruiter_id> 
function DATA.filter_warband_recruiter(func)
    ---@type table<warband_recruiter_id, warband_recruiter_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_warband_recruiter_size()
    for i = 0, range - 1 do
        if DCON.dcon_warband_recruiter_is_valid(i) and func(i + 1 --[[@as warband_recruiter_id]]) then t[i + 1 --[[@as warband_recruiter_id]]] = i + 1 --[[@as warband_recruiter_id]] end
    end
    return t
end

---@param recruiter warband_recruiter_id valid pop_id
---@return pop_id Data retrieved from warband_recruiter 
function DATA.warband_recruiter_get_recruiter(recruiter)
    return DCON.dcon_warband_recruiter_get_recruiter(recruiter - 1) + 1
end
---@param recruiter pop_id valid pop_id
---@return warband_recruiter_id warband_recruiter 
function DATA.get_warband_recruiter_from_recruiter(recruiter)
    return DCON.dcon_pop_get_warband_recruiter_as_recruiter(recruiter - 1) + 1
end
---@param warband_recruiter_id warband_recruiter_id valid warband_recruiter id
---@param value pop_id valid pop_id
function DATA.warband_recruiter_set_recruiter(warband_recruiter_id, value)
    DCON.dcon_warband_recruiter_set_recruiter(warband_recruiter_id - 1, value - 1)
end
---@param warband warband_recruiter_id valid warband_id
---@return warband_id Data retrieved from warband_recruiter 
function DATA.warband_recruiter_get_warband(warband)
    return DCON.dcon_warband_recruiter_get_warband(warband - 1) + 1
end
---@param warband warband_id valid warband_id
---@return warband_recruiter_id warband_recruiter 
function DATA.get_warband_recruiter_from_warband(warband)
    return DCON.dcon_warband_get_warband_recruiter_as_warband(warband - 1) + 1
end
---@param warband_recruiter_id warband_recruiter_id valid warband_recruiter id
---@param value warband_id valid warband_id
function DATA.warband_recruiter_set_warband(warband_recruiter_id, value)
    DCON.dcon_warband_recruiter_set_warband(warband_recruiter_id - 1, value - 1)
end

local fat_warband_recruiter_id_metatable = {
    __index = function (t,k)
        if (k == "recruiter") then return DATA.warband_recruiter_get_recruiter(t.id) end
        if (k == "warband") then return DATA.warband_recruiter_get_warband(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "recruiter") then
            DATA.warband_recruiter_set_recruiter(t.id, v)
            return
        end
        if (k == "warband") then
            DATA.warband_recruiter_set_warband(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id warband_recruiter_id
---@return fat_warband_recruiter_id fat_id
function DATA.fatten_warband_recruiter(id)
    local result = {id = id}
    setmetatable(result, fat_warband_recruiter_id_metatable)
    return result --[[@as fat_warband_recruiter_id]]
end
