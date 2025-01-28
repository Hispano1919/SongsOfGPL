local ffi = require("ffi")
----------jobtype----------


---jobtype: LSP types---

---Unique identificator for jobtype entity
---@class (exact) jobtype_id : table
---@field is_jobtype number
---@class (exact) fat_jobtype_id
---@field id jobtype_id Unique jobtype id
---@field name string 
---@field action_word string 

---@class struct_jobtype

---@class (exact) jobtype_id_data_blob_definition
---@field name string 
---@field action_word string 
---Sets values of jobtype for given id
---@param id jobtype_id
---@param data jobtype_id_data_blob_definition
function DATA.setup_jobtype(id, data)
    DATA.jobtype_set_name(id, data.name)
    DATA.jobtype_set_action_word(id, data.action_word)
end

ffi.cdef[[
int32_t dcon_create_jobtype();
bool dcon_jobtype_is_valid(int32_t);
void dcon_jobtype_resize(uint32_t sz);
uint32_t dcon_jobtype_size();
]]

---jobtype: FFI arrays---
---@type (string)[]
DATA.jobtype_name= {}
---@type (string)[]
DATA.jobtype_action_word= {}

---jobtype: LUA bindings---

DATA.jobtype_size = 10
---@return jobtype_id
function DATA.create_jobtype()
    ---@type jobtype_id
    local i  = DCON.dcon_create_jobtype() + 1
    return i --[[@as jobtype_id]] 
end
---@param func fun(item: jobtype_id) 
function DATA.for_each_jobtype(func)
    ---@type number
    local range = DCON.dcon_jobtype_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as jobtype_id]])
    end
end
---@param func fun(item: jobtype_id):boolean 
---@return table<jobtype_id, jobtype_id> 
function DATA.filter_jobtype(func)
    ---@type table<jobtype_id, jobtype_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_jobtype_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as jobtype_id]]) then t[i + 1 --[[@as jobtype_id]]] = t[i + 1 --[[@as jobtype_id]]] end
    end
    return t
end

---@param jobtype_id jobtype_id valid jobtype id
---@return string name 
function DATA.jobtype_get_name(jobtype_id)
    return DATA.jobtype_name[jobtype_id]
end
---@param jobtype_id jobtype_id valid jobtype id
---@param value string valid string
function DATA.jobtype_set_name(jobtype_id, value)
    DATA.jobtype_name[jobtype_id] = value
end
---@param jobtype_id jobtype_id valid jobtype id
---@return string action_word 
function DATA.jobtype_get_action_word(jobtype_id)
    return DATA.jobtype_action_word[jobtype_id]
end
---@param jobtype_id jobtype_id valid jobtype id
---@param value string valid string
function DATA.jobtype_set_action_word(jobtype_id, value)
    DATA.jobtype_action_word[jobtype_id] = value
end

local fat_jobtype_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.jobtype_get_name(t.id) end
        if (k == "action_word") then return DATA.jobtype_get_action_word(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.jobtype_set_name(t.id, v)
            return
        end
        if (k == "action_word") then
            DATA.jobtype_set_action_word(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id jobtype_id
---@return fat_jobtype_id fat_id
function DATA.fatten_jobtype(id)
    local result = {id = id}
    setmetatable(result, fat_jobtype_id_metatable)
    return result --[[@as fat_jobtype_id]]
end
---@enum JOBTYPE
JOBTYPE = {
    INVALID = 0,
    FORAGER = 1,
    FARMER = 2,
    LABOURER = 3,
    ARTISAN = 4,
    CLERK = 5,
    WARRIOR = 6,
    HAULING = 7,
    HUNTING = 8,
}
local index_jobtype
index_jobtype = DATA.create_jobtype()
DATA.jobtype_set_name(index_jobtype, "FORAGER")
DATA.jobtype_set_action_word(index_jobtype, "foraging")
index_jobtype = DATA.create_jobtype()
DATA.jobtype_set_name(index_jobtype, "FARMER")
DATA.jobtype_set_action_word(index_jobtype, "farming")
index_jobtype = DATA.create_jobtype()
DATA.jobtype_set_name(index_jobtype, "LABOURER")
DATA.jobtype_set_action_word(index_jobtype, "labouring")
index_jobtype = DATA.create_jobtype()
DATA.jobtype_set_name(index_jobtype, "ARTISAN")
DATA.jobtype_set_action_word(index_jobtype, "artisianship")
index_jobtype = DATA.create_jobtype()
DATA.jobtype_set_name(index_jobtype, "CLERK")
DATA.jobtype_set_action_word(index_jobtype, "recalling")
index_jobtype = DATA.create_jobtype()
DATA.jobtype_set_name(index_jobtype, "WARRIOR")
DATA.jobtype_set_action_word(index_jobtype, "fighting")
index_jobtype = DATA.create_jobtype()
DATA.jobtype_set_name(index_jobtype, "HAULING")
DATA.jobtype_set_action_word(index_jobtype, "hauling")
index_jobtype = DATA.create_jobtype()
DATA.jobtype_set_name(index_jobtype, "HUNTING")
DATA.jobtype_set_action_word(index_jobtype, "hunting")
