local ffi = require("ffi")
----------trade_good_category----------


---trade_good_category: LSP types---

---Unique identificator for trade_good_category entity
---@class (exact) trade_good_category_id : table
---@field is_trade_good_category number
---@class (exact) fat_trade_good_category_id
---@field id trade_good_category_id Unique trade_good_category id
---@field name string 

---@class struct_trade_good_category

---@class (exact) trade_good_category_id_data_blob_definition
---@field name string 
---Sets values of trade_good_category for given id
---@param id trade_good_category_id
---@param data trade_good_category_id_data_blob_definition
function DATA.setup_trade_good_category(id, data)
    DATA.trade_good_category_set_name(id, data.name)
end

ffi.cdef[[
int32_t dcon_create_trade_good_category();
bool dcon_trade_good_category_is_valid(int32_t);
void dcon_trade_good_category_resize(uint32_t sz);
uint32_t dcon_trade_good_category_size();
]]

---trade_good_category: FFI arrays---
---@type (string)[]
DATA.trade_good_category_name= {}

---trade_good_category: LUA bindings---

DATA.trade_good_category_size = 5
---@return trade_good_category_id
function DATA.create_trade_good_category()
    ---@type trade_good_category_id
    local i  = DCON.dcon_create_trade_good_category() + 1
    return i --[[@as trade_good_category_id]] 
end
---@param func fun(item: trade_good_category_id) 
function DATA.for_each_trade_good_category(func)
    ---@type number
    local range = DCON.dcon_trade_good_category_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as trade_good_category_id]])
    end
end
---@param func fun(item: trade_good_category_id):boolean 
---@return table<trade_good_category_id, trade_good_category_id> 
function DATA.filter_trade_good_category(func)
    ---@type table<trade_good_category_id, trade_good_category_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_trade_good_category_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as trade_good_category_id]]) then t[i + 1 --[[@as trade_good_category_id]]] = t[i + 1 --[[@as trade_good_category_id]]] end
    end
    return t
end

---@param trade_good_category_id trade_good_category_id valid trade_good_category id
---@return string name 
function DATA.trade_good_category_get_name(trade_good_category_id)
    return DATA.trade_good_category_name[trade_good_category_id]
end
---@param trade_good_category_id trade_good_category_id valid trade_good_category id
---@param value string valid string
function DATA.trade_good_category_set_name(trade_good_category_id, value)
    DATA.trade_good_category_name[trade_good_category_id] = value
end

local fat_trade_good_category_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.trade_good_category_get_name(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.trade_good_category_set_name(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id trade_good_category_id
---@return fat_trade_good_category_id fat_id
function DATA.fatten_trade_good_category(id)
    local result = {id = id}
    setmetatable(result, fat_trade_good_category_id_metatable)
    return result --[[@as fat_trade_good_category_id]]
end
---@enum TRADE_GOOD_CATEGORY
TRADE_GOOD_CATEGORY = {
    INVALID = 0,
    GOOD = 1,
    SERVICE = 2,
    CAPACITY = 3,
}
local index_trade_good_category
index_trade_good_category = DATA.create_trade_good_category()
DATA.trade_good_category_set_name(index_trade_good_category, "good")
index_trade_good_category = DATA.create_trade_good_category()
DATA.trade_good_category_set_name(index_trade_good_category, "service")
index_trade_good_category = DATA.create_trade_good_category()
DATA.trade_good_category_set_name(index_trade_good_category, "capacity")
