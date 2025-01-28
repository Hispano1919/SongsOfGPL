local ffi = require("ffi")
----------warband----------


---warband: LSP types---

---Unique identificator for warband entity
---@class (exact) warband_id : table
---@field is_warband number
---@class (exact) fat_warband_id
---@field id warband_id Unique warband id
---@field name string 
---@field guard_of Realm? 
---@field current_status WARBAND_STATUS 
---@field idle_stance WARBAND_STANCE 
---@field current_free_time_ratio number How much of "idle" free time they are actually idle. Set by events.
---@field treasury number 
---@field total_upkeep number 
---@field predicted_upkeep number 
---@field supplies number 
---@field supplies_target_days number 
---@field morale number 
---@field current_path table<tile_id> 
---@field movement_progress number 

---@class struct_warband
---@field units_current table<unit_type_id, number> Current distribution of units in the warband
---@field units_target table<unit_type_id, number> Units to recruit
---@field current_status WARBAND_STATUS 
---@field idle_stance WARBAND_STANCE 
---@field current_free_time_ratio number How much of "idle" free time they are actually idle. Set by events.
---@field treasury number 
---@field total_upkeep number 
---@field predicted_upkeep number 
---@field supplies number 
---@field supplies_target_days number 
---@field morale number 


ffi.cdef[[
void dcon_warband_resize_units_current(uint32_t);
void dcon_warband_set_units_current(int32_t, int32_t, float);
float dcon_warband_get_units_current(int32_t, int32_t);
void dcon_warband_resize_units_target(uint32_t);
void dcon_warband_set_units_target(int32_t, int32_t, float);
float dcon_warband_get_units_target(int32_t, int32_t);
void dcon_warband_set_current_status(int32_t, uint8_t);
uint8_t dcon_warband_get_current_status(int32_t);
void dcon_warband_set_idle_stance(int32_t, uint8_t);
uint8_t dcon_warband_get_idle_stance(int32_t);
void dcon_warband_set_current_free_time_ratio(int32_t, float);
float dcon_warband_get_current_free_time_ratio(int32_t);
void dcon_warband_set_treasury(int32_t, float);
float dcon_warband_get_treasury(int32_t);
void dcon_warband_set_total_upkeep(int32_t, float);
float dcon_warband_get_total_upkeep(int32_t);
void dcon_warband_set_predicted_upkeep(int32_t, float);
float dcon_warband_get_predicted_upkeep(int32_t);
void dcon_warband_set_supplies(int32_t, float);
float dcon_warband_get_supplies(int32_t);
void dcon_warband_set_supplies_target_days(int32_t, float);
float dcon_warband_get_supplies_target_days(int32_t);
void dcon_warband_set_morale(int32_t, float);
float dcon_warband_get_morale(int32_t);
void dcon_delete_warband(int32_t j);
int32_t dcon_create_warband();
bool dcon_warband_is_valid(int32_t);
void dcon_warband_resize(uint32_t sz);
uint32_t dcon_warband_size();
]]

---warband: FFI arrays---
---@type (string)[]
DATA.warband_name= {}
---@type (Realm?)[]
DATA.warband_guard_of= {}
---@type (table<tile_id>)[]
DATA.warband_current_path= {}
---@type (number)[]
DATA.warband_movement_progress= {}

---warband: LUA bindings---

DATA.warband_size = 50000
DCON.dcon_warband_resize_units_current(5)
DCON.dcon_warband_resize_units_target(5)
---@return warband_id
function DATA.create_warband()
    ---@type warband_id
    local i  = DCON.dcon_create_warband() + 1
    return i --[[@as warband_id]] 
end
---@param i warband_id
function DATA.delete_warband(i)
    assert(DCON.dcon_warband_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_warband(i - 1)
end
---@param func fun(item: warband_id) 
function DATA.for_each_warband(func)
    ---@type number
    local range = DCON.dcon_warband_size()
    for i = 0, range - 1 do
        if DCON.dcon_warband_is_valid(i) then func(i + 1 --[[@as warband_id]]) end
    end
end
---@param func fun(item: warband_id):boolean 
---@return table<warband_id, warband_id> 
function DATA.filter_warband(func)
    ---@type table<warband_id, warband_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_warband_size()
    for i = 0, range - 1 do
        if DCON.dcon_warband_is_valid(i) and func(i + 1 --[[@as warband_id]]) then t[i + 1 --[[@as warband_id]]] = i + 1 --[[@as warband_id]] end
    end
    return t
end

---@param warband_id warband_id valid warband id
---@return string name 
function DATA.warband_get_name(warband_id)
    return DATA.warband_name[warband_id]
end
---@param warband_id warband_id valid warband id
---@param value string valid string
function DATA.warband_set_name(warband_id, value)
    DATA.warband_name[warband_id] = value
end
---@param warband_id warband_id valid warband id
---@return Realm? guard_of 
function DATA.warband_get_guard_of(warband_id)
    return DATA.warband_guard_of[warband_id]
end
---@param warband_id warband_id valid warband id
---@param value Realm? valid Realm?
function DATA.warband_set_guard_of(warband_id, value)
    DATA.warband_guard_of[warband_id] = value
end
---@param warband_id warband_id valid warband id
---@param index unit_type_id valid
---@return number units_current Current distribution of units in the warband
function DATA.warband_get_units_current(warband_id, index)
    assert(index ~= 0)
    return DCON.dcon_warband_get_units_current(warband_id - 1, index - 1)
end
---@param warband_id warband_id valid warband id
---@param index unit_type_id valid index
---@param value number valid number
function DATA.warband_set_units_current(warband_id, index, value)
    DCON.dcon_warband_set_units_current(warband_id - 1, index - 1, value)
end
---@param warband_id warband_id valid warband id
---@param index unit_type_id valid index
---@param value number valid number
function DATA.warband_inc_units_current(warband_id, index, value)
    ---@type number
    local current = DCON.dcon_warband_get_units_current(warband_id - 1, index - 1)
    DCON.dcon_warband_set_units_current(warband_id - 1, index - 1, current + value)
end
---@param warband_id warband_id valid warband id
---@param index unit_type_id valid
---@return number units_target Units to recruit
function DATA.warband_get_units_target(warband_id, index)
    assert(index ~= 0)
    return DCON.dcon_warband_get_units_target(warband_id - 1, index - 1)
end
---@param warband_id warband_id valid warband id
---@param index unit_type_id valid index
---@param value number valid number
function DATA.warband_set_units_target(warband_id, index, value)
    DCON.dcon_warband_set_units_target(warband_id - 1, index - 1, value)
end
---@param warband_id warband_id valid warband id
---@param index unit_type_id valid index
---@param value number valid number
function DATA.warband_inc_units_target(warband_id, index, value)
    ---@type number
    local current = DCON.dcon_warband_get_units_target(warband_id - 1, index - 1)
    DCON.dcon_warband_set_units_target(warband_id - 1, index - 1, current + value)
end
---@param warband_id warband_id valid warband id
---@return WARBAND_STATUS current_status 
function DATA.warband_get_current_status(warband_id)
    return DCON.dcon_warband_get_current_status(warband_id - 1)
end
---@param warband_id warband_id valid warband id
---@param value WARBAND_STATUS valid WARBAND_STATUS
function DATA.warband_set_current_status(warband_id, value)
    DCON.dcon_warband_set_current_status(warband_id - 1, value)
end
---@param warband_id warband_id valid warband id
---@return WARBAND_STANCE idle_stance 
function DATA.warband_get_idle_stance(warband_id)
    return DCON.dcon_warband_get_idle_stance(warband_id - 1)
end
---@param warband_id warband_id valid warband id
---@param value WARBAND_STANCE valid WARBAND_STANCE
function DATA.warband_set_idle_stance(warband_id, value)
    DCON.dcon_warband_set_idle_stance(warband_id - 1, value)
end
---@param warband_id warband_id valid warband id
---@return number current_free_time_ratio How much of "idle" free time they are actually idle. Set by events.
function DATA.warband_get_current_free_time_ratio(warband_id)
    return DCON.dcon_warband_get_current_free_time_ratio(warband_id - 1)
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_set_current_free_time_ratio(warband_id, value)
    DCON.dcon_warband_set_current_free_time_ratio(warband_id - 1, value)
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_inc_current_free_time_ratio(warband_id, value)
    ---@type number
    local current = DCON.dcon_warband_get_current_free_time_ratio(warband_id - 1)
    DCON.dcon_warband_set_current_free_time_ratio(warband_id - 1, current + value)
end
---@param warband_id warband_id valid warband id
---@return number treasury 
function DATA.warband_get_treasury(warband_id)
    return DCON.dcon_warband_get_treasury(warband_id - 1)
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_set_treasury(warband_id, value)
    DCON.dcon_warband_set_treasury(warband_id - 1, value)
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_inc_treasury(warband_id, value)
    ---@type number
    local current = DCON.dcon_warband_get_treasury(warband_id - 1)
    DCON.dcon_warband_set_treasury(warband_id - 1, current + value)
end
---@param warband_id warband_id valid warband id
---@return number total_upkeep 
function DATA.warband_get_total_upkeep(warband_id)
    return DCON.dcon_warband_get_total_upkeep(warband_id - 1)
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_set_total_upkeep(warband_id, value)
    DCON.dcon_warband_set_total_upkeep(warband_id - 1, value)
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_inc_total_upkeep(warband_id, value)
    ---@type number
    local current = DCON.dcon_warband_get_total_upkeep(warband_id - 1)
    DCON.dcon_warband_set_total_upkeep(warband_id - 1, current + value)
end
---@param warband_id warband_id valid warband id
---@return number predicted_upkeep 
function DATA.warband_get_predicted_upkeep(warband_id)
    return DCON.dcon_warband_get_predicted_upkeep(warband_id - 1)
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_set_predicted_upkeep(warband_id, value)
    DCON.dcon_warband_set_predicted_upkeep(warband_id - 1, value)
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_inc_predicted_upkeep(warband_id, value)
    ---@type number
    local current = DCON.dcon_warband_get_predicted_upkeep(warband_id - 1)
    DCON.dcon_warband_set_predicted_upkeep(warband_id - 1, current + value)
end
---@param warband_id warband_id valid warband id
---@return number supplies 
function DATA.warband_get_supplies(warband_id)
    return DCON.dcon_warband_get_supplies(warband_id - 1)
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_set_supplies(warband_id, value)
    DCON.dcon_warband_set_supplies(warband_id - 1, value)
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_inc_supplies(warband_id, value)
    ---@type number
    local current = DCON.dcon_warband_get_supplies(warband_id - 1)
    DCON.dcon_warband_set_supplies(warband_id - 1, current + value)
end
---@param warband_id warband_id valid warband id
---@return number supplies_target_days 
function DATA.warband_get_supplies_target_days(warband_id)
    return DCON.dcon_warband_get_supplies_target_days(warband_id - 1)
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_set_supplies_target_days(warband_id, value)
    DCON.dcon_warband_set_supplies_target_days(warband_id - 1, value)
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_inc_supplies_target_days(warband_id, value)
    ---@type number
    local current = DCON.dcon_warband_get_supplies_target_days(warband_id - 1)
    DCON.dcon_warband_set_supplies_target_days(warband_id - 1, current + value)
end
---@param warband_id warband_id valid warband id
---@return number morale 
function DATA.warband_get_morale(warband_id)
    return DCON.dcon_warband_get_morale(warband_id - 1)
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_set_morale(warband_id, value)
    DCON.dcon_warband_set_morale(warband_id - 1, value)
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_inc_morale(warband_id, value)
    ---@type number
    local current = DCON.dcon_warband_get_morale(warband_id - 1)
    DCON.dcon_warband_set_morale(warband_id - 1, current + value)
end
---@param warband_id warband_id valid warband id
---@return table<tile_id> current_path 
function DATA.warband_get_current_path(warband_id)
    return DATA.warband_current_path[warband_id]
end
---@param warband_id warband_id valid warband id
---@param value table<tile_id> valid table<tile_id>
function DATA.warband_set_current_path(warband_id, value)
    DATA.warband_current_path[warband_id] = value
end
---@param warband_id warband_id valid warband id
---@return number movement_progress 
function DATA.warband_get_movement_progress(warband_id)
    return DATA.warband_movement_progress[warband_id]
end
---@param warband_id warband_id valid warband id
---@param value number valid number
function DATA.warband_set_movement_progress(warband_id, value)
    DATA.warband_movement_progress[warband_id] = value
end

local fat_warband_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.warband_get_name(t.id) end
        if (k == "guard_of") then return DATA.warband_get_guard_of(t.id) end
        if (k == "current_status") then return DATA.warband_get_current_status(t.id) end
        if (k == "idle_stance") then return DATA.warband_get_idle_stance(t.id) end
        if (k == "current_free_time_ratio") then return DATA.warband_get_current_free_time_ratio(t.id) end
        if (k == "treasury") then return DATA.warband_get_treasury(t.id) end
        if (k == "total_upkeep") then return DATA.warband_get_total_upkeep(t.id) end
        if (k == "predicted_upkeep") then return DATA.warband_get_predicted_upkeep(t.id) end
        if (k == "supplies") then return DATA.warband_get_supplies(t.id) end
        if (k == "supplies_target_days") then return DATA.warband_get_supplies_target_days(t.id) end
        if (k == "morale") then return DATA.warband_get_morale(t.id) end
        if (k == "current_path") then return DATA.warband_get_current_path(t.id) end
        if (k == "movement_progress") then return DATA.warband_get_movement_progress(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.warband_set_name(t.id, v)
            return
        end
        if (k == "guard_of") then
            DATA.warband_set_guard_of(t.id, v)
            return
        end
        if (k == "current_status") then
            DATA.warband_set_current_status(t.id, v)
            return
        end
        if (k == "idle_stance") then
            DATA.warband_set_idle_stance(t.id, v)
            return
        end
        if (k == "current_free_time_ratio") then
            DATA.warband_set_current_free_time_ratio(t.id, v)
            return
        end
        if (k == "treasury") then
            DATA.warband_set_treasury(t.id, v)
            return
        end
        if (k == "total_upkeep") then
            DATA.warband_set_total_upkeep(t.id, v)
            return
        end
        if (k == "predicted_upkeep") then
            DATA.warband_set_predicted_upkeep(t.id, v)
            return
        end
        if (k == "supplies") then
            DATA.warband_set_supplies(t.id, v)
            return
        end
        if (k == "supplies_target_days") then
            DATA.warband_set_supplies_target_days(t.id, v)
            return
        end
        if (k == "morale") then
            DATA.warband_set_morale(t.id, v)
            return
        end
        if (k == "current_path") then
            DATA.warband_set_current_path(t.id, v)
            return
        end
        if (k == "movement_progress") then
            DATA.warband_set_movement_progress(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id warband_id
---@return fat_warband_id fat_id
function DATA.fatten_warband(id)
    local result = {id = id}
    setmetatable(result, fat_warband_id_metatable)
    return result --[[@as fat_warband_id]]
end
