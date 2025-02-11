local ffi = require("ffi")
----------warband_status----------


---warband_status: LSP types---

---Unique identificator for warband_status entity
---@class (exact) warband_status_id : table
---@field is_warband_status number
---@class (exact) fat_warband_status_id
---@field id warband_status_id Unique warband_status id
---@field name string 
---@field description string 
---@field time_used number 
---@field icon string 

---@class struct_warband_status
---@field time_used number 

---@class (exact) warband_status_id_data_blob_definition
---@field name string 
---@field description string 
---@field time_used number 
---@field icon string 
---Sets values of warband_status for given id
---@param id warband_status_id
---@param data warband_status_id_data_blob_definition
function DATA.setup_warband_status(id, data)
    DATA.warband_status_set_name(id, data.name)
    DATA.warband_status_set_description(id, data.description)
    DATA.warband_status_set_time_used(id, data.time_used)
    DATA.warband_status_set_icon(id, data.icon)
end

ffi.cdef[[
void dcon_warband_status_set_time_used(int32_t, float);
float dcon_warband_status_get_time_used(int32_t);
int32_t dcon_create_warband_status();
bool dcon_warband_status_is_valid(int32_t);
void dcon_warband_status_resize(uint32_t sz);
uint32_t dcon_warband_status_size();
]]

---warband_status: FFI arrays---
---@type (string)[]
DATA.warband_status_name= {}
---@type (string)[]
DATA.warband_status_description= {}
---@type (string)[]
DATA.warband_status_icon= {}

---warband_status: LUA bindings---

DATA.warband_status_size = 10
---@return warband_status_id
function DATA.create_warband_status()
    ---@type warband_status_id
    local i  = DCON.dcon_create_warband_status() + 1
    return i --[[@as warband_status_id]] 
end
---@param func fun(item: warband_status_id) 
function DATA.for_each_warband_status(func)
    ---@type number
    local range = DCON.dcon_warband_status_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as warband_status_id]])
    end
end
---@param func fun(item: warband_status_id):boolean 
---@return table<warband_status_id, warband_status_id> 
function DATA.filter_warband_status(func)
    ---@type table<warband_status_id, warband_status_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_warband_status_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as warband_status_id]]) then t[i + 1 --[[@as warband_status_id]]] = t[i + 1 --[[@as warband_status_id]]] end
    end
    return t
end

---@param warband_status_id warband_status_id valid warband_status id
---@return string name 
function DATA.warband_status_get_name(warband_status_id)
    return DATA.warband_status_name[warband_status_id]
end
---@param warband_status_id warband_status_id valid warband_status id
---@param value string valid string
function DATA.warband_status_set_name(warband_status_id, value)
    DATA.warband_status_name[warband_status_id] = value
end
---@param warband_status_id warband_status_id valid warband_status id
---@return string description 
function DATA.warband_status_get_description(warband_status_id)
    return DATA.warband_status_description[warband_status_id]
end
---@param warband_status_id warband_status_id valid warband_status id
---@param value string valid string
function DATA.warband_status_set_description(warband_status_id, value)
    DATA.warband_status_description[warband_status_id] = value
end
---@param warband_status_id warband_status_id valid warband_status id
---@return number time_used 
function DATA.warband_status_get_time_used(warband_status_id)
    return DCON.dcon_warband_status_get_time_used(warband_status_id - 1)
end
---@param warband_status_id warband_status_id valid warband_status id
---@param value number valid number
function DATA.warband_status_set_time_used(warband_status_id, value)
    DCON.dcon_warband_status_set_time_used(warband_status_id - 1, value)
end
---@param warband_status_id warband_status_id valid warband_status id
---@param value number valid number
function DATA.warband_status_inc_time_used(warband_status_id, value)
    ---@type number
    local current = DCON.dcon_warband_status_get_time_used(warband_status_id - 1)
    DCON.dcon_warband_status_set_time_used(warband_status_id - 1, current + value)
end
---@param warband_status_id warband_status_id valid warband_status id
---@return string icon 
function DATA.warband_status_get_icon(warband_status_id)
    return DATA.warband_status_icon[warband_status_id]
end
---@param warband_status_id warband_status_id valid warband_status id
---@param value string valid string
function DATA.warband_status_set_icon(warband_status_id, value)
    DATA.warband_status_icon[warband_status_id] = value
end

local fat_warband_status_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.warband_status_get_name(t.id) end
        if (k == "description") then return DATA.warband_status_get_description(t.id) end
        if (k == "time_used") then return DATA.warband_status_get_time_used(t.id) end
        if (k == "icon") then return DATA.warband_status_get_icon(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.warband_status_set_name(t.id, v)
            return
        end
        if (k == "description") then
            DATA.warband_status_set_description(t.id, v)
            return
        end
        if (k == "time_used") then
            DATA.warband_status_set_time_used(t.id, v)
            return
        end
        if (k == "icon") then
            DATA.warband_status_set_icon(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id warband_status_id
---@return fat_warband_status_id fat_id
function DATA.fatten_warband_status(id)
    local result = {id = id}
    setmetatable(result, fat_warband_status_id_metatable)
    return result --[[@as fat_warband_status_id]]
end
---@enum WARBAND_STATUS
WARBAND_STATUS = {
    INVALID = 0,
    IDLE = 1,
    RAIDING = 2,
    PREPARING_RAID = 3,
    PREPARING_PATROL = 4,
    PATROL = 5,
    ATTACKING = 6,
    TRAVELING = 7,
    OFF_DUTY = 8,
}
local index_warband_status
index_warband_status = DATA.create_warband_status()
DATA.warband_status_set_name(index_warband_status, "idle")
DATA.warband_status_set_description(index_warband_status, "idle")
DATA.warband_status_set_time_used(index_warband_status, 0.25)
DATA.warband_status_set_icon(index_warband_status, "guards.png")
index_warband_status = DATA.create_warband_status()
DATA.warband_status_set_name(index_warband_status, "raiding")
DATA.warband_status_set_description(index_warband_status, "raiding")
DATA.warband_status_set_time_used(index_warband_status, 0.5)
DATA.warband_status_set_icon(index_warband_status, "stone-spear.png")
index_warband_status = DATA.create_warband_status()
DATA.warband_status_set_name(index_warband_status, "preparing_raid")
DATA.warband_status_set_description(index_warband_status, "preparing to raid")
DATA.warband_status_set_time_used(index_warband_status, 0.5)
DATA.warband_status_set_icon(index_warband_status, "minions.png")
index_warband_status = DATA.create_warband_status()
DATA.warband_status_set_name(index_warband_status, "preparing_patrol")
DATA.warband_status_set_description(index_warband_status, "preparing to patrol")
DATA.warband_status_set_time_used(index_warband_status, 0.25)
DATA.warband_status_set_icon(index_warband_status, "ages.png")
index_warband_status = DATA.create_warband_status()
DATA.warband_status_set_name(index_warband_status, "patrol")
DATA.warband_status_set_description(index_warband_status, "patrolling")
DATA.warband_status_set_time_used(index_warband_status, 0.5)
DATA.warband_status_set_icon(index_warband_status, "round-shield.png")
index_warband_status = DATA.create_warband_status()
DATA.warband_status_set_name(index_warband_status, "attacking")
DATA.warband_status_set_description(index_warband_status, "attacking")
DATA.warband_status_set_time_used(index_warband_status, 0.5)
DATA.warband_status_set_icon(index_warband_status, "hammer-drop.png")
index_warband_status = DATA.create_warband_status()
DATA.warband_status_set_name(index_warband_status, "traveling")
DATA.warband_status_set_description(index_warband_status, "traveling")
DATA.warband_status_set_time_used(index_warband_status, 0.5)
DATA.warband_status_set_icon(index_warband_status, "horizon-road.png")
index_warband_status = DATA.create_warband_status()
DATA.warband_status_set_name(index_warband_status, "off_duty")
DATA.warband_status_set_description(index_warband_status, "off duty")
DATA.warband_status_set_time_used(index_warband_status, 0.0)
DATA.warband_status_set_icon(index_warband_status, "shrug.png")
