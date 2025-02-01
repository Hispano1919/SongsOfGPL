local ffi = require("ffi")
----------law_trade----------


---law_trade: LSP types---

---Unique identificator for law_trade entity
---@class (exact) law_trade_id : table
---@field is_law_trade number
---@class (exact) fat_law_trade_id
---@field id law_trade_id Unique law_trade id
---@field name string 

---@class struct_law_trade

---@class (exact) law_trade_id_data_blob_definition
---@field name string 
---Sets values of law_trade for given id
---@param id law_trade_id
---@param data law_trade_id_data_blob_definition
function DATA.setup_law_trade(id, data)
    DATA.law_trade_set_name(id, data.name)
end

ffi.cdef[[
int32_t dcon_create_law_trade();
bool dcon_law_trade_is_valid(int32_t);
void dcon_law_trade_resize(uint32_t sz);
uint32_t dcon_law_trade_size();
]]

---law_trade: FFI arrays---
---@type (string)[]
DATA.law_trade_name= {}

---law_trade: LUA bindings---

DATA.law_trade_size = 5
---@return law_trade_id
function DATA.create_law_trade()
    ---@type law_trade_id
    local i  = DCON.dcon_create_law_trade() + 1
    return i --[[@as law_trade_id]] 
end
---@param func fun(item: law_trade_id) 
function DATA.for_each_law_trade(func)
    ---@type number
    local range = DCON.dcon_law_trade_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as law_trade_id]])
    end
end
---@param func fun(item: law_trade_id):boolean 
---@return table<law_trade_id, law_trade_id> 
function DATA.filter_law_trade(func)
    ---@type table<law_trade_id, law_trade_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_law_trade_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as law_trade_id]]) then t[i + 1 --[[@as law_trade_id]]] = t[i + 1 --[[@as law_trade_id]]] end
    end
    return t
end

---@param law_trade_id law_trade_id valid law_trade id
---@return string name 
function DATA.law_trade_get_name(law_trade_id)
    return DATA.law_trade_name[law_trade_id]
end
---@param law_trade_id law_trade_id valid law_trade id
---@param value string valid string
function DATA.law_trade_set_name(law_trade_id, value)
    DATA.law_trade_name[law_trade_id] = value
end

local fat_law_trade_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.law_trade_get_name(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.law_trade_set_name(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id law_trade_id
---@return fat_law_trade_id fat_id
function DATA.fatten_law_trade(id)
    local result = {id = id}
    setmetatable(result, fat_law_trade_id_metatable)
    return result --[[@as fat_law_trade_id]]
end
---@enum LAW_TRADE
LAW_TRADE = {
    INVALID = 0,
    NO_REGULATION = 1,
    LOCALS_ONLY = 2,
    PERMISSION_ONLY = 3,
}
local index_law_trade
index_law_trade = DATA.create_law_trade()
DATA.law_trade_set_name(index_law_trade, "NO_REGULATION")
index_law_trade = DATA.create_law_trade()
DATA.law_trade_set_name(index_law_trade, "LOCALS_ONLY")
index_law_trade = DATA.create_law_trade()
DATA.law_trade_set_name(index_law_trade, "PERMISSION_ONLY")
