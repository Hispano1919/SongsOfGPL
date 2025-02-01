local ffi = require("ffi")
----------trade_good----------


---trade_good: LSP types---

---Unique identificator for trade_good entity
---@class (exact) trade_good_id : table
---@field is_trade_good number
---@class (exact) fat_trade_good_id
---@field id trade_good_id Unique trade_good id
---@field name string 
---@field icon string 
---@field description string 
---@field r number 
---@field g number 
---@field b number 
---@field belongs_to_category TRADE_GOOD_CATEGORY 
---@field base_price number 
---@field decay number 

---@class struct_trade_good
---@field r number 
---@field g number 
---@field b number 
---@field belongs_to_category TRADE_GOOD_CATEGORY 
---@field base_price number 
---@field decay number 

---@class (exact) trade_good_id_data_blob_definition
---@field name string 
---@field icon string 
---@field description string 
---@field r number 
---@field g number 
---@field b number 
---@field belongs_to_category TRADE_GOOD_CATEGORY 
---@field base_price number 
---@field decay number 
---Sets values of trade_good for given id
---@param id trade_good_id
---@param data trade_good_id_data_blob_definition
function DATA.setup_trade_good(id, data)
    DATA.trade_good_set_name(id, data.name)
    DATA.trade_good_set_icon(id, data.icon)
    DATA.trade_good_set_description(id, data.description)
    DATA.trade_good_set_r(id, data.r)
    DATA.trade_good_set_g(id, data.g)
    DATA.trade_good_set_b(id, data.b)
    DATA.trade_good_set_belongs_to_category(id, data.belongs_to_category)
    DATA.trade_good_set_base_price(id, data.base_price)
    DATA.trade_good_set_decay(id, data.decay)
end

ffi.cdef[[
void dcon_trade_good_set_r(int32_t, float);
float dcon_trade_good_get_r(int32_t);
void dcon_trade_good_set_g(int32_t, float);
float dcon_trade_good_get_g(int32_t);
void dcon_trade_good_set_b(int32_t, float);
float dcon_trade_good_get_b(int32_t);
void dcon_trade_good_set_belongs_to_category(int32_t, uint8_t);
uint8_t dcon_trade_good_get_belongs_to_category(int32_t);
void dcon_trade_good_set_base_price(int32_t, float);
float dcon_trade_good_get_base_price(int32_t);
void dcon_trade_good_set_decay(int32_t, float);
float dcon_trade_good_get_decay(int32_t);
int32_t dcon_create_trade_good();
bool dcon_trade_good_is_valid(int32_t);
void dcon_trade_good_resize(uint32_t sz);
uint32_t dcon_trade_good_size();
]]

---trade_good: FFI arrays---
---@type (string)[]
DATA.trade_good_name= {}
---@type (string)[]
DATA.trade_good_icon= {}
---@type (string)[]
DATA.trade_good_description= {}

---trade_good: LUA bindings---

DATA.trade_good_size = 100
---@return trade_good_id
function DATA.create_trade_good()
    ---@type trade_good_id
    local i  = DCON.dcon_create_trade_good() + 1
    return i --[[@as trade_good_id]] 
end
---@param func fun(item: trade_good_id) 
function DATA.for_each_trade_good(func)
    ---@type number
    local range = DCON.dcon_trade_good_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as trade_good_id]])
    end
end
---@param func fun(item: trade_good_id):boolean 
---@return table<trade_good_id, trade_good_id> 
function DATA.filter_trade_good(func)
    ---@type table<trade_good_id, trade_good_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_trade_good_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as trade_good_id]]) then t[i + 1 --[[@as trade_good_id]]] = t[i + 1 --[[@as trade_good_id]]] end
    end
    return t
end

---@param trade_good_id trade_good_id valid trade_good id
---@return string name 
function DATA.trade_good_get_name(trade_good_id)
    return DATA.trade_good_name[trade_good_id]
end
---@param trade_good_id trade_good_id valid trade_good id
---@param value string valid string
function DATA.trade_good_set_name(trade_good_id, value)
    DATA.trade_good_name[trade_good_id] = value
end
---@param trade_good_id trade_good_id valid trade_good id
---@return string icon 
function DATA.trade_good_get_icon(trade_good_id)
    return DATA.trade_good_icon[trade_good_id]
end
---@param trade_good_id trade_good_id valid trade_good id
---@param value string valid string
function DATA.trade_good_set_icon(trade_good_id, value)
    DATA.trade_good_icon[trade_good_id] = value
end
---@param trade_good_id trade_good_id valid trade_good id
---@return string description 
function DATA.trade_good_get_description(trade_good_id)
    return DATA.trade_good_description[trade_good_id]
end
---@param trade_good_id trade_good_id valid trade_good id
---@param value string valid string
function DATA.trade_good_set_description(trade_good_id, value)
    DATA.trade_good_description[trade_good_id] = value
end
---@param trade_good_id trade_good_id valid trade_good id
---@return number r 
function DATA.trade_good_get_r(trade_good_id)
    return DCON.dcon_trade_good_get_r(trade_good_id - 1)
end
---@param trade_good_id trade_good_id valid trade_good id
---@param value number valid number
function DATA.trade_good_set_r(trade_good_id, value)
    DCON.dcon_trade_good_set_r(trade_good_id - 1, value)
end
---@param trade_good_id trade_good_id valid trade_good id
---@param value number valid number
function DATA.trade_good_inc_r(trade_good_id, value)
    ---@type number
    local current = DCON.dcon_trade_good_get_r(trade_good_id - 1)
    DCON.dcon_trade_good_set_r(trade_good_id - 1, current + value)
end
---@param trade_good_id trade_good_id valid trade_good id
---@return number g 
function DATA.trade_good_get_g(trade_good_id)
    return DCON.dcon_trade_good_get_g(trade_good_id - 1)
end
---@param trade_good_id trade_good_id valid trade_good id
---@param value number valid number
function DATA.trade_good_set_g(trade_good_id, value)
    DCON.dcon_trade_good_set_g(trade_good_id - 1, value)
end
---@param trade_good_id trade_good_id valid trade_good id
---@param value number valid number
function DATA.trade_good_inc_g(trade_good_id, value)
    ---@type number
    local current = DCON.dcon_trade_good_get_g(trade_good_id - 1)
    DCON.dcon_trade_good_set_g(trade_good_id - 1, current + value)
end
---@param trade_good_id trade_good_id valid trade_good id
---@return number b 
function DATA.trade_good_get_b(trade_good_id)
    return DCON.dcon_trade_good_get_b(trade_good_id - 1)
end
---@param trade_good_id trade_good_id valid trade_good id
---@param value number valid number
function DATA.trade_good_set_b(trade_good_id, value)
    DCON.dcon_trade_good_set_b(trade_good_id - 1, value)
end
---@param trade_good_id trade_good_id valid trade_good id
---@param value number valid number
function DATA.trade_good_inc_b(trade_good_id, value)
    ---@type number
    local current = DCON.dcon_trade_good_get_b(trade_good_id - 1)
    DCON.dcon_trade_good_set_b(trade_good_id - 1, current + value)
end
---@param trade_good_id trade_good_id valid trade_good id
---@return TRADE_GOOD_CATEGORY belongs_to_category 
function DATA.trade_good_get_belongs_to_category(trade_good_id)
    return DCON.dcon_trade_good_get_belongs_to_category(trade_good_id - 1)
end
---@param trade_good_id trade_good_id valid trade_good id
---@param value TRADE_GOOD_CATEGORY valid TRADE_GOOD_CATEGORY
function DATA.trade_good_set_belongs_to_category(trade_good_id, value)
    DCON.dcon_trade_good_set_belongs_to_category(trade_good_id - 1, value)
end
---@param trade_good_id trade_good_id valid trade_good id
---@return number base_price 
function DATA.trade_good_get_base_price(trade_good_id)
    return DCON.dcon_trade_good_get_base_price(trade_good_id - 1)
end
---@param trade_good_id trade_good_id valid trade_good id
---@param value number valid number
function DATA.trade_good_set_base_price(trade_good_id, value)
    DCON.dcon_trade_good_set_base_price(trade_good_id - 1, value)
end
---@param trade_good_id trade_good_id valid trade_good id
---@param value number valid number
function DATA.trade_good_inc_base_price(trade_good_id, value)
    ---@type number
    local current = DCON.dcon_trade_good_get_base_price(trade_good_id - 1)
    DCON.dcon_trade_good_set_base_price(trade_good_id - 1, current + value)
end
---@param trade_good_id trade_good_id valid trade_good id
---@return number decay 
function DATA.trade_good_get_decay(trade_good_id)
    return DCON.dcon_trade_good_get_decay(trade_good_id - 1)
end
---@param trade_good_id trade_good_id valid trade_good id
---@param value number valid number
function DATA.trade_good_set_decay(trade_good_id, value)
    DCON.dcon_trade_good_set_decay(trade_good_id - 1, value)
end
---@param trade_good_id trade_good_id valid trade_good id
---@param value number valid number
function DATA.trade_good_inc_decay(trade_good_id, value)
    ---@type number
    local current = DCON.dcon_trade_good_get_decay(trade_good_id - 1)
    DCON.dcon_trade_good_set_decay(trade_good_id - 1, current + value)
end

local fat_trade_good_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.trade_good_get_name(t.id) end
        if (k == "icon") then return DATA.trade_good_get_icon(t.id) end
        if (k == "description") then return DATA.trade_good_get_description(t.id) end
        if (k == "r") then return DATA.trade_good_get_r(t.id) end
        if (k == "g") then return DATA.trade_good_get_g(t.id) end
        if (k == "b") then return DATA.trade_good_get_b(t.id) end
        if (k == "belongs_to_category") then return DATA.trade_good_get_belongs_to_category(t.id) end
        if (k == "base_price") then return DATA.trade_good_get_base_price(t.id) end
        if (k == "decay") then return DATA.trade_good_get_decay(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.trade_good_set_name(t.id, v)
            return
        end
        if (k == "icon") then
            DATA.trade_good_set_icon(t.id, v)
            return
        end
        if (k == "description") then
            DATA.trade_good_set_description(t.id, v)
            return
        end
        if (k == "r") then
            DATA.trade_good_set_r(t.id, v)
            return
        end
        if (k == "g") then
            DATA.trade_good_set_g(t.id, v)
            return
        end
        if (k == "b") then
            DATA.trade_good_set_b(t.id, v)
            return
        end
        if (k == "belongs_to_category") then
            DATA.trade_good_set_belongs_to_category(t.id, v)
            return
        end
        if (k == "base_price") then
            DATA.trade_good_set_base_price(t.id, v)
            return
        end
        if (k == "decay") then
            DATA.trade_good_set_decay(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id trade_good_id
---@return fat_trade_good_id fat_id
function DATA.fatten_trade_good(id)
    local result = {id = id}
    setmetatable(result, fat_trade_good_id_metatable)
    return result --[[@as fat_trade_good_id]]
end
