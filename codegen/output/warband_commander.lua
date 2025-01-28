local ffi = require("ffi")
----------warband_commander----------


---warband_commander: LSP types---

---Unique identificator for warband_commander entity
---@class (exact) warband_commander_id : table
---@field is_warband_commander number
---@class (exact) fat_warband_commander_id
---@field id warband_commander_id Unique warband_commander id
---@field commander pop_id 
---@field warband warband_id 

---@class struct_warband_commander


ffi.cdef[[
void dcon_delete_warband_commander(int32_t j);
int32_t dcon_force_create_warband_commander(int32_t commander, int32_t warband);
void dcon_warband_commander_set_commander(int32_t, int32_t);
int32_t dcon_warband_commander_get_commander(int32_t);
int32_t dcon_pop_get_warband_commander_as_commander(int32_t);
void dcon_warband_commander_set_warband(int32_t, int32_t);
int32_t dcon_warband_commander_get_warband(int32_t);
int32_t dcon_warband_get_warband_commander_as_warband(int32_t);
bool dcon_warband_commander_is_valid(int32_t);
void dcon_warband_commander_resize(uint32_t sz);
uint32_t dcon_warband_commander_size();
]]

---warband_commander: FFI arrays---

---warband_commander: LUA bindings---

DATA.warband_commander_size = 50000
---@param commander pop_id
---@param warband warband_id
---@return warband_commander_id
function DATA.force_create_warband_commander(commander, warband)
    ---@type warband_commander_id
    local i = DCON.dcon_force_create_warband_commander(commander - 1, warband - 1) + 1
    return i --[[@as warband_commander_id]] 
end
---@param i warband_commander_id
function DATA.delete_warband_commander(i)
    assert(DCON.dcon_warband_commander_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_warband_commander(i - 1)
end
---@param func fun(item: warband_commander_id) 
function DATA.for_each_warband_commander(func)
    ---@type number
    local range = DCON.dcon_warband_commander_size()
    for i = 0, range - 1 do
        if DCON.dcon_warband_commander_is_valid(i) then func(i + 1 --[[@as warband_commander_id]]) end
    end
end
---@param func fun(item: warband_commander_id):boolean 
---@return table<warband_commander_id, warband_commander_id> 
function DATA.filter_warband_commander(func)
    ---@type table<warband_commander_id, warband_commander_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_warband_commander_size()
    for i = 0, range - 1 do
        if DCON.dcon_warband_commander_is_valid(i) and func(i + 1 --[[@as warband_commander_id]]) then t[i + 1 --[[@as warband_commander_id]]] = i + 1 --[[@as warband_commander_id]] end
    end
    return t
end

---@param commander warband_commander_id valid pop_id
---@return pop_id Data retrieved from warband_commander 
function DATA.warband_commander_get_commander(commander)
    return DCON.dcon_warband_commander_get_commander(commander - 1) + 1
end
---@param commander pop_id valid pop_id
---@return warband_commander_id warband_commander 
function DATA.get_warband_commander_from_commander(commander)
    return DCON.dcon_pop_get_warband_commander_as_commander(commander - 1) + 1
end
---@param warband_commander_id warband_commander_id valid warband_commander id
---@param value pop_id valid pop_id
function DATA.warband_commander_set_commander(warband_commander_id, value)
    DCON.dcon_warband_commander_set_commander(warband_commander_id - 1, value - 1)
end
---@param warband warband_commander_id valid warband_id
---@return warband_id Data retrieved from warband_commander 
function DATA.warband_commander_get_warband(warband)
    return DCON.dcon_warband_commander_get_warband(warband - 1) + 1
end
---@param warband warband_id valid warband_id
---@return warband_commander_id warband_commander 
function DATA.get_warband_commander_from_warband(warband)
    return DCON.dcon_warband_get_warband_commander_as_warband(warband - 1) + 1
end
---@param warband_commander_id warband_commander_id valid warband_commander id
---@param value warband_id valid warband_id
function DATA.warband_commander_set_warband(warband_commander_id, value)
    DCON.dcon_warband_commander_set_warband(warband_commander_id - 1, value - 1)
end

local fat_warband_commander_id_metatable = {
    __index = function (t,k)
        if (k == "commander") then return DATA.warband_commander_get_commander(t.id) end
        if (k == "warband") then return DATA.warband_commander_get_warband(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "commander") then
            DATA.warband_commander_set_commander(t.id, v)
            return
        end
        if (k == "warband") then
            DATA.warband_commander_set_warband(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id warband_commander_id
---@return fat_warband_commander_id fat_id
function DATA.fatten_warband_commander(id)
    local result = {id = id}
    setmetatable(result, fat_warband_commander_id_metatable)
    return result --[[@as fat_warband_commander_id]]
end
