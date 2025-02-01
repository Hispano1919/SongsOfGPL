local ffi = require("ffi")
----------building----------


---building: LSP types---

---Unique identificator for building entity
---@class (exact) building_id : table
---@field is_building number
---@class (exact) fat_building_id
---@field id building_id Unique building id
---@field current_type building_type_id 
---@field work_ratio number 
---@field input_scale number 
---@field production_scale number 
---@field output_scale number 

---@class struct_building
---@field current_type building_type_id 
---@field work_ratio number 
---@field input_scale number 
---@field production_scale number 
---@field output_scale number 
---@field amount_of_inputs table<number, struct_use_case_container> 
---@field amount_of_outputs table<number, struct_trade_good_container> 


ffi.cdef[[
void dcon_building_set_current_type(int32_t, int32_t);
int32_t dcon_building_get_current_type(int32_t);
void dcon_building_set_work_ratio(int32_t, float);
float dcon_building_get_work_ratio(int32_t);
void dcon_building_set_input_scale(int32_t, float);
float dcon_building_get_input_scale(int32_t);
void dcon_building_set_production_scale(int32_t, float);
float dcon_building_get_production_scale(int32_t);
void dcon_building_set_output_scale(int32_t, float);
float dcon_building_get_output_scale(int32_t);
void dcon_building_resize_amount_of_inputs(uint32_t);
use_case_container* dcon_building_get_amount_of_inputs(int32_t, int32_t);
void dcon_building_resize_amount_of_outputs(uint32_t);
trade_good_container* dcon_building_get_amount_of_outputs(int32_t, int32_t);
void dcon_delete_building(int32_t j);
int32_t dcon_create_building();
bool dcon_building_is_valid(int32_t);
void dcon_building_resize(uint32_t sz);
uint32_t dcon_building_size();
]]

---building: FFI arrays---

---building: LUA bindings---

DATA.building_size = 600000
DCON.dcon_building_resize_amount_of_inputs(9)
DCON.dcon_building_resize_amount_of_outputs(9)
---@return building_id
function DATA.create_building()
    ---@type building_id
    local i  = DCON.dcon_create_building() + 1
    return i --[[@as building_id]] 
end
---@param i building_id
function DATA.delete_building(i)
    assert(DCON.dcon_building_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_building(i - 1)
end
---@param func fun(item: building_id) 
function DATA.for_each_building(func)
    ---@type number
    local range = DCON.dcon_building_size()
    for i = 0, range - 1 do
        if DCON.dcon_building_is_valid(i) then func(i + 1 --[[@as building_id]]) end
    end
end
---@param func fun(item: building_id):boolean 
---@return table<building_id, building_id> 
function DATA.filter_building(func)
    ---@type table<building_id, building_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_building_size()
    for i = 0, range - 1 do
        if DCON.dcon_building_is_valid(i) and func(i + 1 --[[@as building_id]]) then t[i + 1 --[[@as building_id]]] = i + 1 --[[@as building_id]] end
    end
    return t
end

---@param building_id building_id valid building id
---@return building_type_id current_type 
function DATA.building_get_current_type(building_id)
    return DCON.dcon_building_get_current_type(building_id - 1) + 1
end
---@param building_id building_id valid building id
---@param value building_type_id valid building_type_id
function DATA.building_set_current_type(building_id, value)
    DCON.dcon_building_set_current_type(building_id - 1, value - 1)
end
---@param building_id building_id valid building id
---@return number work_ratio 
function DATA.building_get_work_ratio(building_id)
    return DCON.dcon_building_get_work_ratio(building_id - 1)
end
---@param building_id building_id valid building id
---@param value number valid number
function DATA.building_set_work_ratio(building_id, value)
    DCON.dcon_building_set_work_ratio(building_id - 1, value)
end
---@param building_id building_id valid building id
---@param value number valid number
function DATA.building_inc_work_ratio(building_id, value)
    ---@type number
    local current = DCON.dcon_building_get_work_ratio(building_id - 1)
    DCON.dcon_building_set_work_ratio(building_id - 1, current + value)
end
---@param building_id building_id valid building id
---@return number input_scale 
function DATA.building_get_input_scale(building_id)
    return DCON.dcon_building_get_input_scale(building_id - 1)
end
---@param building_id building_id valid building id
---@param value number valid number
function DATA.building_set_input_scale(building_id, value)
    DCON.dcon_building_set_input_scale(building_id - 1, value)
end
---@param building_id building_id valid building id
---@param value number valid number
function DATA.building_inc_input_scale(building_id, value)
    ---@type number
    local current = DCON.dcon_building_get_input_scale(building_id - 1)
    DCON.dcon_building_set_input_scale(building_id - 1, current + value)
end
---@param building_id building_id valid building id
---@return number production_scale 
function DATA.building_get_production_scale(building_id)
    return DCON.dcon_building_get_production_scale(building_id - 1)
end
---@param building_id building_id valid building id
---@param value number valid number
function DATA.building_set_production_scale(building_id, value)
    DCON.dcon_building_set_production_scale(building_id - 1, value)
end
---@param building_id building_id valid building id
---@param value number valid number
function DATA.building_inc_production_scale(building_id, value)
    ---@type number
    local current = DCON.dcon_building_get_production_scale(building_id - 1)
    DCON.dcon_building_set_production_scale(building_id - 1, current + value)
end
---@param building_id building_id valid building id
---@return number output_scale 
function DATA.building_get_output_scale(building_id)
    return DCON.dcon_building_get_output_scale(building_id - 1)
end
---@param building_id building_id valid building id
---@param value number valid number
function DATA.building_set_output_scale(building_id, value)
    DCON.dcon_building_set_output_scale(building_id - 1, value)
end
---@param building_id building_id valid building id
---@param value number valid number
function DATA.building_inc_output_scale(building_id, value)
    ---@type number
    local current = DCON.dcon_building_get_output_scale(building_id - 1)
    DCON.dcon_building_set_output_scale(building_id - 1, current + value)
end
---@param building_id building_id valid building id
---@param index number valid
---@return use_case_id amount_of_inputs 
function DATA.building_get_amount_of_inputs_use(building_id, index)
    assert(index ~= 0)
    return DCON.dcon_building_get_amount_of_inputs(building_id - 1, index - 1)[0].use
end
---@param building_id building_id valid building id
---@param index number valid
---@return number amount_of_inputs 
function DATA.building_get_amount_of_inputs_amount(building_id, index)
    assert(index ~= 0)
    return DCON.dcon_building_get_amount_of_inputs(building_id - 1, index - 1)[0].amount
end
---@param building_id building_id valid building id
---@param index number valid index
---@param value use_case_id valid use_case_id
function DATA.building_set_amount_of_inputs_use(building_id, index, value)
    DCON.dcon_building_get_amount_of_inputs(building_id - 1, index - 1)[0].use = value
end
---@param building_id building_id valid building id
---@param index number valid index
---@param value number valid number
function DATA.building_set_amount_of_inputs_amount(building_id, index, value)
    DCON.dcon_building_get_amount_of_inputs(building_id - 1, index - 1)[0].amount = value
end
---@param building_id building_id valid building id
---@param index number valid index
---@param value number valid number
function DATA.building_inc_amount_of_inputs_amount(building_id, index, value)
    ---@type number
    local current = DCON.dcon_building_get_amount_of_inputs(building_id - 1, index - 1)[0].amount
    DCON.dcon_building_get_amount_of_inputs(building_id - 1, index - 1)[0].amount = current + value
end
---@param building_id building_id valid building id
---@param index number valid
---@return trade_good_id amount_of_outputs 
function DATA.building_get_amount_of_outputs_good(building_id, index)
    assert(index ~= 0)
    return DCON.dcon_building_get_amount_of_outputs(building_id - 1, index - 1)[0].good
end
---@param building_id building_id valid building id
---@param index number valid
---@return number amount_of_outputs 
function DATA.building_get_amount_of_outputs_amount(building_id, index)
    assert(index ~= 0)
    return DCON.dcon_building_get_amount_of_outputs(building_id - 1, index - 1)[0].amount
end
---@param building_id building_id valid building id
---@param index number valid index
---@param value trade_good_id valid trade_good_id
function DATA.building_set_amount_of_outputs_good(building_id, index, value)
    DCON.dcon_building_get_amount_of_outputs(building_id - 1, index - 1)[0].good = value
end
---@param building_id building_id valid building id
---@param index number valid index
---@param value number valid number
function DATA.building_set_amount_of_outputs_amount(building_id, index, value)
    DCON.dcon_building_get_amount_of_outputs(building_id - 1, index - 1)[0].amount = value
end
---@param building_id building_id valid building id
---@param index number valid index
---@param value number valid number
function DATA.building_inc_amount_of_outputs_amount(building_id, index, value)
    ---@type number
    local current = DCON.dcon_building_get_amount_of_outputs(building_id - 1, index - 1)[0].amount
    DCON.dcon_building_get_amount_of_outputs(building_id - 1, index - 1)[0].amount = current + value
end

local fat_building_id_metatable = {
    __index = function (t,k)
        if (k == "current_type") then return DATA.building_get_current_type(t.id) end
        if (k == "work_ratio") then return DATA.building_get_work_ratio(t.id) end
        if (k == "input_scale") then return DATA.building_get_input_scale(t.id) end
        if (k == "production_scale") then return DATA.building_get_production_scale(t.id) end
        if (k == "output_scale") then return DATA.building_get_output_scale(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "current_type") then
            DATA.building_set_current_type(t.id, v)
            return
        end
        if (k == "work_ratio") then
            DATA.building_set_work_ratio(t.id, v)
            return
        end
        if (k == "input_scale") then
            DATA.building_set_input_scale(t.id, v)
            return
        end
        if (k == "production_scale") then
            DATA.building_set_production_scale(t.id, v)
            return
        end
        if (k == "output_scale") then
            DATA.building_set_output_scale(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id building_id
---@return fat_building_id fat_id
function DATA.fatten_building(id)
    local result = {id = id}
    setmetatable(result, fat_building_id_metatable)
    return result --[[@as fat_building_id]]
end
