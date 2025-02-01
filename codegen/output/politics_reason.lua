local ffi = require("ffi")
----------politics_reason----------


---politics_reason: LSP types---

---Unique identificator for politics_reason entity
---@class (exact) politics_reason_id : table
---@field is_politics_reason number
---@class (exact) fat_politics_reason_id
---@field id politics_reason_id Unique politics_reason id
---@field name string 
---@field description string 

---@class struct_politics_reason

---@class (exact) politics_reason_id_data_blob_definition
---@field name string 
---@field description string 
---Sets values of politics_reason for given id
---@param id politics_reason_id
---@param data politics_reason_id_data_blob_definition
function DATA.setup_politics_reason(id, data)
    DATA.politics_reason_set_name(id, data.name)
    DATA.politics_reason_set_description(id, data.description)
end

ffi.cdef[[
int32_t dcon_create_politics_reason();
bool dcon_politics_reason_is_valid(int32_t);
void dcon_politics_reason_resize(uint32_t sz);
uint32_t dcon_politics_reason_size();
]]

---politics_reason: FFI arrays---
---@type (string)[]
DATA.politics_reason_name= {}
---@type (string)[]
DATA.politics_reason_description= {}

---politics_reason: LUA bindings---

DATA.politics_reason_size = 10
---@return politics_reason_id
function DATA.create_politics_reason()
    ---@type politics_reason_id
    local i  = DCON.dcon_create_politics_reason() + 1
    return i --[[@as politics_reason_id]] 
end
---@param func fun(item: politics_reason_id) 
function DATA.for_each_politics_reason(func)
    ---@type number
    local range = DCON.dcon_politics_reason_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as politics_reason_id]])
    end
end
---@param func fun(item: politics_reason_id):boolean 
---@return table<politics_reason_id, politics_reason_id> 
function DATA.filter_politics_reason(func)
    ---@type table<politics_reason_id, politics_reason_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_politics_reason_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as politics_reason_id]]) then t[i + 1 --[[@as politics_reason_id]]] = t[i + 1 --[[@as politics_reason_id]]] end
    end
    return t
end

---@param politics_reason_id politics_reason_id valid politics_reason id
---@return string name 
function DATA.politics_reason_get_name(politics_reason_id)
    return DATA.politics_reason_name[politics_reason_id]
end
---@param politics_reason_id politics_reason_id valid politics_reason id
---@param value string valid string
function DATA.politics_reason_set_name(politics_reason_id, value)
    DATA.politics_reason_name[politics_reason_id] = value
end
---@param politics_reason_id politics_reason_id valid politics_reason id
---@return string description 
function DATA.politics_reason_get_description(politics_reason_id)
    return DATA.politics_reason_description[politics_reason_id]
end
---@param politics_reason_id politics_reason_id valid politics_reason id
---@param value string valid string
function DATA.politics_reason_set_description(politics_reason_id, value)
    DATA.politics_reason_description[politics_reason_id] = value
end

local fat_politics_reason_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.politics_reason_get_name(t.id) end
        if (k == "description") then return DATA.politics_reason_get_description(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.politics_reason_set_name(t.id, v)
            return
        end
        if (k == "description") then
            DATA.politics_reason_set_description(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id politics_reason_id
---@return fat_politics_reason_id fat_id
function DATA.fatten_politics_reason(id)
    local result = {id = id}
    setmetatable(result, fat_politics_reason_id_metatable)
    return result --[[@as fat_politics_reason_id]]
end
---@enum POLITICS_REASON
POLITICS_REASON = {
    INVALID = 0,
    NOTENOUGHNOBLES = 1,
    INITIALNOBLE = 2,
    POPULATIONGROWTH = 3,
    EXPEDITIONLEADER = 4,
    SUCCESSION = 5,
    COUP = 6,
    INITIALRULER = 7,
    OTHER = 8,
}
local index_politics_reason
index_politics_reason = DATA.create_politics_reason()
DATA.politics_reason_set_name(index_politics_reason, "NotEnoughNobles")
DATA.politics_reason_set_description(index_politics_reason, "Political vacuum")
index_politics_reason = DATA.create_politics_reason()
DATA.politics_reason_set_name(index_politics_reason, "InitialNoble")
DATA.politics_reason_set_description(index_politics_reason, "Initial noble")
index_politics_reason = DATA.create_politics_reason()
DATA.politics_reason_set_name(index_politics_reason, "PopulationGrowth")
DATA.politics_reason_set_description(index_politics_reason, "Population growth")
index_politics_reason = DATA.create_politics_reason()
DATA.politics_reason_set_name(index_politics_reason, "ExpeditionLeader")
DATA.politics_reason_set_description(index_politics_reason, "Expedition leader")
index_politics_reason = DATA.create_politics_reason()
DATA.politics_reason_set_name(index_politics_reason, "Succession")
DATA.politics_reason_set_description(index_politics_reason, "Succession")
index_politics_reason = DATA.create_politics_reason()
DATA.politics_reason_set_name(index_politics_reason, "Coup")
DATA.politics_reason_set_description(index_politics_reason, "Coup")
index_politics_reason = DATA.create_politics_reason()
DATA.politics_reason_set_name(index_politics_reason, "InitialRuler")
DATA.politics_reason_set_description(index_politics_reason, "First ruler")
index_politics_reason = DATA.create_politics_reason()
DATA.politics_reason_set_name(index_politics_reason, "Other")
DATA.politics_reason_set_description(index_politics_reason, "Other")
