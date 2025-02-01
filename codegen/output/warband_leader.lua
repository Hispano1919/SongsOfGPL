local ffi = require("ffi")
----------warband_leader----------


---warband_leader: LSP types---

---Unique identificator for warband_leader entity
---@class (exact) warband_leader_id : table
---@field is_warband_leader number
---@class (exact) fat_warband_leader_id
---@field id warband_leader_id Unique warband_leader id
---@field leader pop_id 
---@field warband warband_id 

---@class struct_warband_leader


ffi.cdef[[
void dcon_delete_warband_leader(int32_t j);
int32_t dcon_force_create_warband_leader(int32_t leader, int32_t warband);
void dcon_warband_leader_set_leader(int32_t, int32_t);
int32_t dcon_warband_leader_get_leader(int32_t);
int32_t dcon_pop_get_warband_leader_as_leader(int32_t);
void dcon_warband_leader_set_warband(int32_t, int32_t);
int32_t dcon_warband_leader_get_warband(int32_t);
int32_t dcon_warband_get_warband_leader_as_warband(int32_t);
bool dcon_warband_leader_is_valid(int32_t);
void dcon_warband_leader_resize(uint32_t sz);
uint32_t dcon_warband_leader_size();
]]

---warband_leader: FFI arrays---

---warband_leader: LUA bindings---

DATA.warband_leader_size = 50000
---@param leader pop_id
---@param warband warband_id
---@return warband_leader_id
function DATA.force_create_warband_leader(leader, warband)
    ---@type warband_leader_id
    local i = DCON.dcon_force_create_warband_leader(leader - 1, warband - 1) + 1
    return i --[[@as warband_leader_id]] 
end
---@param i warband_leader_id
function DATA.delete_warband_leader(i)
    assert(DCON.dcon_warband_leader_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_warband_leader(i - 1)
end
---@param func fun(item: warband_leader_id) 
function DATA.for_each_warband_leader(func)
    ---@type number
    local range = DCON.dcon_warband_leader_size()
    for i = 0, range - 1 do
        if DCON.dcon_warband_leader_is_valid(i) then func(i + 1 --[[@as warband_leader_id]]) end
    end
end
---@param func fun(item: warband_leader_id):boolean 
---@return table<warband_leader_id, warband_leader_id> 
function DATA.filter_warband_leader(func)
    ---@type table<warband_leader_id, warband_leader_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_warband_leader_size()
    for i = 0, range - 1 do
        if DCON.dcon_warband_leader_is_valid(i) and func(i + 1 --[[@as warband_leader_id]]) then t[i + 1 --[[@as warband_leader_id]]] = i + 1 --[[@as warband_leader_id]] end
    end
    return t
end

---@param leader warband_leader_id valid pop_id
---@return pop_id Data retrieved from warband_leader 
function DATA.warband_leader_get_leader(leader)
    return DCON.dcon_warband_leader_get_leader(leader - 1) + 1
end
---@param leader pop_id valid pop_id
---@return warband_leader_id warband_leader 
function DATA.get_warband_leader_from_leader(leader)
    return DCON.dcon_pop_get_warband_leader_as_leader(leader - 1) + 1
end
---@param warband_leader_id warband_leader_id valid warband_leader id
---@param value pop_id valid pop_id
function DATA.warband_leader_set_leader(warband_leader_id, value)
    DCON.dcon_warband_leader_set_leader(warband_leader_id - 1, value - 1)
end
---@param warband warband_leader_id valid warband_id
---@return warband_id Data retrieved from warband_leader 
function DATA.warband_leader_get_warband(warband)
    return DCON.dcon_warband_leader_get_warband(warband - 1) + 1
end
---@param warband warband_id valid warband_id
---@return warband_leader_id warband_leader 
function DATA.get_warband_leader_from_warband(warband)
    return DCON.dcon_warband_get_warband_leader_as_warband(warband - 1) + 1
end
---@param warband_leader_id warband_leader_id valid warband_leader id
---@param value warband_id valid warband_id
function DATA.warband_leader_set_warband(warband_leader_id, value)
    DCON.dcon_warband_leader_set_warband(warband_leader_id - 1, value - 1)
end

local fat_warband_leader_id_metatable = {
    __index = function (t,k)
        if (k == "leader") then return DATA.warband_leader_get_leader(t.id) end
        if (k == "warband") then return DATA.warband_leader_get_warband(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "leader") then
            DATA.warband_leader_set_leader(t.id, v)
            return
        end
        if (k == "warband") then
            DATA.warband_leader_set_warband(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id warband_leader_id
---@return fat_warband_leader_id fat_id
function DATA.fatten_warband_leader(id)
    local result = {id = id}
    setmetatable(result, fat_warband_leader_id_metatable)
    return result --[[@as fat_warband_leader_id]]
end
