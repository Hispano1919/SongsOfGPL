local ffi = require("ffi")
----------budget_category----------


---budget_category: LSP types---

---Unique identificator for budget_category entity
---@class (exact) budget_category_id : table
---@field is_budget_category number
---@class (exact) fat_budget_category_id
---@field id budget_category_id Unique budget_category id
---@field name string 

---@class struct_budget_category

---@class (exact) budget_category_id_data_blob_definition
---@field name string 
---Sets values of budget_category for given id
---@param id budget_category_id
---@param data budget_category_id_data_blob_definition
function DATA.setup_budget_category(id, data)
    DATA.budget_category_set_name(id, data.name)
end

ffi.cdef[[
int32_t dcon_create_budget_category();
bool dcon_budget_category_is_valid(int32_t);
void dcon_budget_category_resize(uint32_t sz);
uint32_t dcon_budget_category_size();
]]

---budget_category: FFI arrays---
---@type (string)[]
DATA.budget_category_name= {}

---budget_category: LUA bindings---

DATA.budget_category_size = 7
---@return budget_category_id
function DATA.create_budget_category()
    ---@type budget_category_id
    local i  = DCON.dcon_create_budget_category() + 1
    return i --[[@as budget_category_id]] 
end
---@param func fun(item: budget_category_id) 
function DATA.for_each_budget_category(func)
    ---@type number
    local range = DCON.dcon_budget_category_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as budget_category_id]])
    end
end
---@param func fun(item: budget_category_id):boolean 
---@return table<budget_category_id, budget_category_id> 
function DATA.filter_budget_category(func)
    ---@type table<budget_category_id, budget_category_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_budget_category_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as budget_category_id]]) then t[i + 1 --[[@as budget_category_id]]] = t[i + 1 --[[@as budget_category_id]]] end
    end
    return t
end

---@param budget_category_id budget_category_id valid budget_category id
---@return string name 
function DATA.budget_category_get_name(budget_category_id)
    return DATA.budget_category_name[budget_category_id]
end
---@param budget_category_id budget_category_id valid budget_category id
---@param value string valid string
function DATA.budget_category_set_name(budget_category_id, value)
    DATA.budget_category_name[budget_category_id] = value
end

local fat_budget_category_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.budget_category_get_name(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.budget_category_set_name(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id budget_category_id
---@return fat_budget_category_id fat_id
function DATA.fatten_budget_category(id)
    local result = {id = id}
    setmetatable(result, fat_budget_category_id_metatable)
    return result --[[@as fat_budget_category_id]]
end
---@enum BUDGET_CATEGORY
BUDGET_CATEGORY = {
    INVALID = 0,
    EDUCATION = 1,
    COURT = 2,
    INFRASTRUCTURE = 3,
    MILITARY = 4,
    TRIBUTE = 5,
}
local index_budget_category
index_budget_category = DATA.create_budget_category()
DATA.budget_category_set_name(index_budget_category, "education")
index_budget_category = DATA.create_budget_category()
DATA.budget_category_set_name(index_budget_category, "court")
index_budget_category = DATA.create_budget_category()
DATA.budget_category_set_name(index_budget_category, "infrastructure")
index_budget_category = DATA.create_budget_category()
DATA.budget_category_set_name(index_budget_category, "military")
index_budget_category = DATA.create_budget_category()
DATA.budget_category_set_name(index_budget_category, "tribute")
