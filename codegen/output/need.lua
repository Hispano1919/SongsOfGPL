local ffi = require("ffi")
----------need----------


---need: LSP types---

---Unique identificator for need entity
---@class (exact) need_id : table
---@field is_need number
---@class (exact) fat_need_id
---@field id need_id Unique need id
---@field name string 
---@field age_independent boolean 
---@field life_need boolean 
---@field tool boolean can we use satisfaction of this need in calculations related to production
---@field container boolean can we use satisfaction of this need in calculations related to gathering
---@field time_to_satisfy number Represents amount of time a pop should spend to satisfy a unit of this need.
---@field job_to_satisfy JOBTYPE represents a job type required to satisfy the need on your own

---@class struct_need
---@field age_independent boolean 
---@field life_need boolean 
---@field tool boolean can we use satisfaction of this need in calculations related to production
---@field container boolean can we use satisfaction of this need in calculations related to gathering
---@field time_to_satisfy number Represents amount of time a pop should spend to satisfy a unit of this need.
---@field job_to_satisfy JOBTYPE represents a job type required to satisfy the need on your own

---@class (exact) need_id_data_blob_definition
---@field name string 
---@field age_independent boolean 
---@field life_need boolean 
---@field tool boolean can we use satisfaction of this need in calculations related to production
---@field container boolean can we use satisfaction of this need in calculations related to gathering
---@field time_to_satisfy number Represents amount of time a pop should spend to satisfy a unit of this need.
---@field job_to_satisfy JOBTYPE represents a job type required to satisfy the need on your own
---Sets values of need for given id
---@param id need_id
---@param data need_id_data_blob_definition
function DATA.setup_need(id, data)
    DATA.need_set_name(id, data.name)
    DATA.need_set_age_independent(id, data.age_independent)
    DATA.need_set_life_need(id, data.life_need)
    DATA.need_set_tool(id, data.tool)
    DATA.need_set_container(id, data.container)
    DATA.need_set_time_to_satisfy(id, data.time_to_satisfy)
    DATA.need_set_job_to_satisfy(id, data.job_to_satisfy)
end

ffi.cdef[[
void dcon_need_set_age_independent(int32_t, bool);
bool dcon_need_get_age_independent(int32_t);
void dcon_need_set_life_need(int32_t, bool);
bool dcon_need_get_life_need(int32_t);
void dcon_need_set_tool(int32_t, bool);
bool dcon_need_get_tool(int32_t);
void dcon_need_set_container(int32_t, bool);
bool dcon_need_get_container(int32_t);
void dcon_need_set_time_to_satisfy(int32_t, float);
float dcon_need_get_time_to_satisfy(int32_t);
void dcon_need_set_job_to_satisfy(int32_t, uint8_t);
uint8_t dcon_need_get_job_to_satisfy(int32_t);
int32_t dcon_create_need();
bool dcon_need_is_valid(int32_t);
void dcon_need_resize(uint32_t sz);
uint32_t dcon_need_size();
]]

---need: FFI arrays---
---@type (string)[]
DATA.need_name= {}

---need: LUA bindings---

DATA.need_size = 9
---@return need_id
function DATA.create_need()
    ---@type need_id
    local i  = DCON.dcon_create_need() + 1
    return i --[[@as need_id]] 
end
---@param func fun(item: need_id) 
function DATA.for_each_need(func)
    ---@type number
    local range = DCON.dcon_need_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as need_id]])
    end
end
---@param func fun(item: need_id):boolean 
---@return table<need_id, need_id> 
function DATA.filter_need(func)
    ---@type table<need_id, need_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_need_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as need_id]]) then t[i + 1 --[[@as need_id]]] = t[i + 1 --[[@as need_id]]] end
    end
    return t
end

---@param need_id need_id valid need id
---@return string name 
function DATA.need_get_name(need_id)
    return DATA.need_name[need_id]
end
---@param need_id need_id valid need id
---@param value string valid string
function DATA.need_set_name(need_id, value)
    DATA.need_name[need_id] = value
end
---@param need_id need_id valid need id
---@return boolean age_independent 
function DATA.need_get_age_independent(need_id)
    return DCON.dcon_need_get_age_independent(need_id - 1)
end
---@param need_id need_id valid need id
---@param value boolean valid boolean
function DATA.need_set_age_independent(need_id, value)
    DCON.dcon_need_set_age_independent(need_id - 1, value)
end
---@param need_id need_id valid need id
---@return boolean life_need 
function DATA.need_get_life_need(need_id)
    return DCON.dcon_need_get_life_need(need_id - 1)
end
---@param need_id need_id valid need id
---@param value boolean valid boolean
function DATA.need_set_life_need(need_id, value)
    DCON.dcon_need_set_life_need(need_id - 1, value)
end
---@param need_id need_id valid need id
---@return boolean tool can we use satisfaction of this need in calculations related to production
function DATA.need_get_tool(need_id)
    return DCON.dcon_need_get_tool(need_id - 1)
end
---@param need_id need_id valid need id
---@param value boolean valid boolean
function DATA.need_set_tool(need_id, value)
    DCON.dcon_need_set_tool(need_id - 1, value)
end
---@param need_id need_id valid need id
---@return boolean container can we use satisfaction of this need in calculations related to gathering
function DATA.need_get_container(need_id)
    return DCON.dcon_need_get_container(need_id - 1)
end
---@param need_id need_id valid need id
---@param value boolean valid boolean
function DATA.need_set_container(need_id, value)
    DCON.dcon_need_set_container(need_id - 1, value)
end
---@param need_id need_id valid need id
---@return number time_to_satisfy Represents amount of time a pop should spend to satisfy a unit of this need.
function DATA.need_get_time_to_satisfy(need_id)
    return DCON.dcon_need_get_time_to_satisfy(need_id - 1)
end
---@param need_id need_id valid need id
---@param value number valid number
function DATA.need_set_time_to_satisfy(need_id, value)
    DCON.dcon_need_set_time_to_satisfy(need_id - 1, value)
end
---@param need_id need_id valid need id
---@param value number valid number
function DATA.need_inc_time_to_satisfy(need_id, value)
    ---@type number
    local current = DCON.dcon_need_get_time_to_satisfy(need_id - 1)
    DCON.dcon_need_set_time_to_satisfy(need_id - 1, current + value)
end
---@param need_id need_id valid need id
---@return JOBTYPE job_to_satisfy represents a job type required to satisfy the need on your own
function DATA.need_get_job_to_satisfy(need_id)
    return DCON.dcon_need_get_job_to_satisfy(need_id - 1)
end
---@param need_id need_id valid need id
---@param value JOBTYPE valid JOBTYPE
function DATA.need_set_job_to_satisfy(need_id, value)
    DCON.dcon_need_set_job_to_satisfy(need_id - 1, value)
end

local fat_need_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.need_get_name(t.id) end
        if (k == "age_independent") then return DATA.need_get_age_independent(t.id) end
        if (k == "life_need") then return DATA.need_get_life_need(t.id) end
        if (k == "tool") then return DATA.need_get_tool(t.id) end
        if (k == "container") then return DATA.need_get_container(t.id) end
        if (k == "time_to_satisfy") then return DATA.need_get_time_to_satisfy(t.id) end
        if (k == "job_to_satisfy") then return DATA.need_get_job_to_satisfy(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.need_set_name(t.id, v)
            return
        end
        if (k == "age_independent") then
            DATA.need_set_age_independent(t.id, v)
            return
        end
        if (k == "life_need") then
            DATA.need_set_life_need(t.id, v)
            return
        end
        if (k == "tool") then
            DATA.need_set_tool(t.id, v)
            return
        end
        if (k == "container") then
            DATA.need_set_container(t.id, v)
            return
        end
        if (k == "time_to_satisfy") then
            DATA.need_set_time_to_satisfy(t.id, v)
            return
        end
        if (k == "job_to_satisfy") then
            DATA.need_set_job_to_satisfy(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id need_id
---@return fat_need_id fat_id
function DATA.fatten_need(id)
    local result = {id = id}
    setmetatable(result, fat_need_id_metatable)
    return result --[[@as fat_need_id]]
end
---@enum NEED
NEED = {
    INVALID = 0,
    FOOD = 1,
    TOOLS = 2,
    CONTAINER = 3,
    CLOTHING = 4,
    FURNITURE = 5,
    HEALTHCARE = 6,
    LUXURY = 7,
}
local index_need
index_need = DATA.create_need()
DATA.need_set_name(index_need, "food")
DATA.need_set_age_independent(index_need, false)
DATA.need_set_life_need(index_need, true)
DATA.need_set_tool(index_need, false)
DATA.need_set_container(index_need, false)
DATA.need_set_time_to_satisfy(index_need, 1.5)
DATA.need_set_job_to_satisfy(index_need, JOBTYPE.FORAGER)
index_need = DATA.create_need()
DATA.need_set_name(index_need, "tools")
DATA.need_set_age_independent(index_need, false)
DATA.need_set_life_need(index_need, false)
DATA.need_set_tool(index_need, true)
DATA.need_set_container(index_need, false)
DATA.need_set_time_to_satisfy(index_need, 1.0)
DATA.need_set_job_to_satisfy(index_need, JOBTYPE.ARTISAN)
index_need = DATA.create_need()
DATA.need_set_name(index_need, "container")
DATA.need_set_age_independent(index_need, false)
DATA.need_set_life_need(index_need, false)
DATA.need_set_tool(index_need, false)
DATA.need_set_container(index_need, true)
DATA.need_set_time_to_satisfy(index_need, 1.0)
DATA.need_set_job_to_satisfy(index_need, JOBTYPE.ARTISAN)
index_need = DATA.create_need()
DATA.need_set_name(index_need, "clothing")
DATA.need_set_age_independent(index_need, false)
DATA.need_set_life_need(index_need, false)
DATA.need_set_tool(index_need, false)
DATA.need_set_container(index_need, false)
DATA.need_set_time_to_satisfy(index_need, 0.5)
DATA.need_set_job_to_satisfy(index_need, JOBTYPE.LABOURER)
index_need = DATA.create_need()
DATA.need_set_name(index_need, "furniture")
DATA.need_set_age_independent(index_need, false)
DATA.need_set_life_need(index_need, false)
DATA.need_set_tool(index_need, false)
DATA.need_set_container(index_need, false)
DATA.need_set_time_to_satisfy(index_need, 2.0)
DATA.need_set_job_to_satisfy(index_need, JOBTYPE.LABOURER)
index_need = DATA.create_need()
DATA.need_set_name(index_need, "healthcare")
DATA.need_set_age_independent(index_need, false)
DATA.need_set_life_need(index_need, false)
DATA.need_set_tool(index_need, false)
DATA.need_set_container(index_need, false)
DATA.need_set_time_to_satisfy(index_need, 1.0)
DATA.need_set_job_to_satisfy(index_need, JOBTYPE.CLERK)
index_need = DATA.create_need()
DATA.need_set_name(index_need, "luxury")
DATA.need_set_age_independent(index_need, false)
DATA.need_set_life_need(index_need, false)
DATA.need_set_tool(index_need, false)
DATA.need_set_container(index_need, false)
DATA.need_set_time_to_satisfy(index_need, 3.0)
DATA.need_set_job_to_satisfy(index_need, JOBTYPE.ARTISAN)
