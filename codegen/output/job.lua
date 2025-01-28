local ffi = require("ffi")
----------job----------


---job: LSP types---

---Unique identificator for job entity
---@class (exact) job_id : table
---@field is_job number
---@class (exact) fat_job_id
---@field id job_id Unique job id
---@field name string 
---@field icon string 
---@field description string 
---@field r number 
---@field g number 
---@field b number 

---@class struct_job
---@field r number 
---@field g number 
---@field b number 

---@class (exact) job_id_data_blob_definition
---@field name string 
---@field icon string 
---@field description string 
---@field r number 
---@field g number 
---@field b number 
---Sets values of job for given id
---@param id job_id
---@param data job_id_data_blob_definition
function DATA.setup_job(id, data)
    DATA.job_set_name(id, data.name)
    DATA.job_set_icon(id, data.icon)
    DATA.job_set_description(id, data.description)
    DATA.job_set_r(id, data.r)
    DATA.job_set_g(id, data.g)
    DATA.job_set_b(id, data.b)
end

ffi.cdef[[
void dcon_job_set_r(int32_t, float);
float dcon_job_get_r(int32_t);
void dcon_job_set_g(int32_t, float);
float dcon_job_get_g(int32_t);
void dcon_job_set_b(int32_t, float);
float dcon_job_get_b(int32_t);
int32_t dcon_create_job();
bool dcon_job_is_valid(int32_t);
void dcon_job_resize(uint32_t sz);
uint32_t dcon_job_size();
]]

---job: FFI arrays---
---@type (string)[]
DATA.job_name= {}
---@type (string)[]
DATA.job_icon= {}
---@type (string)[]
DATA.job_description= {}

---job: LUA bindings---

DATA.job_size = 250
---@return job_id
function DATA.create_job()
    ---@type job_id
    local i  = DCON.dcon_create_job() + 1
    return i --[[@as job_id]] 
end
---@param func fun(item: job_id) 
function DATA.for_each_job(func)
    ---@type number
    local range = DCON.dcon_job_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as job_id]])
    end
end
---@param func fun(item: job_id):boolean 
---@return table<job_id, job_id> 
function DATA.filter_job(func)
    ---@type table<job_id, job_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_job_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as job_id]]) then t[i + 1 --[[@as job_id]]] = t[i + 1 --[[@as job_id]]] end
    end
    return t
end

---@param job_id job_id valid job id
---@return string name 
function DATA.job_get_name(job_id)
    return DATA.job_name[job_id]
end
---@param job_id job_id valid job id
---@param value string valid string
function DATA.job_set_name(job_id, value)
    DATA.job_name[job_id] = value
end
---@param job_id job_id valid job id
---@return string icon 
function DATA.job_get_icon(job_id)
    return DATA.job_icon[job_id]
end
---@param job_id job_id valid job id
---@param value string valid string
function DATA.job_set_icon(job_id, value)
    DATA.job_icon[job_id] = value
end
---@param job_id job_id valid job id
---@return string description 
function DATA.job_get_description(job_id)
    return DATA.job_description[job_id]
end
---@param job_id job_id valid job id
---@param value string valid string
function DATA.job_set_description(job_id, value)
    DATA.job_description[job_id] = value
end
---@param job_id job_id valid job id
---@return number r 
function DATA.job_get_r(job_id)
    return DCON.dcon_job_get_r(job_id - 1)
end
---@param job_id job_id valid job id
---@param value number valid number
function DATA.job_set_r(job_id, value)
    DCON.dcon_job_set_r(job_id - 1, value)
end
---@param job_id job_id valid job id
---@param value number valid number
function DATA.job_inc_r(job_id, value)
    ---@type number
    local current = DCON.dcon_job_get_r(job_id - 1)
    DCON.dcon_job_set_r(job_id - 1, current + value)
end
---@param job_id job_id valid job id
---@return number g 
function DATA.job_get_g(job_id)
    return DCON.dcon_job_get_g(job_id - 1)
end
---@param job_id job_id valid job id
---@param value number valid number
function DATA.job_set_g(job_id, value)
    DCON.dcon_job_set_g(job_id - 1, value)
end
---@param job_id job_id valid job id
---@param value number valid number
function DATA.job_inc_g(job_id, value)
    ---@type number
    local current = DCON.dcon_job_get_g(job_id - 1)
    DCON.dcon_job_set_g(job_id - 1, current + value)
end
---@param job_id job_id valid job id
---@return number b 
function DATA.job_get_b(job_id)
    return DCON.dcon_job_get_b(job_id - 1)
end
---@param job_id job_id valid job id
---@param value number valid number
function DATA.job_set_b(job_id, value)
    DCON.dcon_job_set_b(job_id - 1, value)
end
---@param job_id job_id valid job id
---@param value number valid number
function DATA.job_inc_b(job_id, value)
    ---@type number
    local current = DCON.dcon_job_get_b(job_id - 1)
    DCON.dcon_job_set_b(job_id - 1, current + value)
end

local fat_job_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.job_get_name(t.id) end
        if (k == "icon") then return DATA.job_get_icon(t.id) end
        if (k == "description") then return DATA.job_get_description(t.id) end
        if (k == "r") then return DATA.job_get_r(t.id) end
        if (k == "g") then return DATA.job_get_g(t.id) end
        if (k == "b") then return DATA.job_get_b(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.job_set_name(t.id, v)
            return
        end
        if (k == "icon") then
            DATA.job_set_icon(t.id, v)
            return
        end
        if (k == "description") then
            DATA.job_set_description(t.id, v)
            return
        end
        if (k == "r") then
            DATA.job_set_r(t.id, v)
            return
        end
        if (k == "g") then
            DATA.job_set_g(t.id, v)
            return
        end
        if (k == "b") then
            DATA.job_set_b(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id job_id
---@return fat_job_id fat_id
function DATA.fatten_job(id)
    local result = {id = id}
    setmetatable(result, fat_job_id_metatable)
    return result --[[@as fat_job_id]]
end
