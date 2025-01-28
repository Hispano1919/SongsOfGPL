local ffi = require("ffi")
----------use_weight----------


---use_weight: LSP types---

---Unique identificator for use_weight entity
---@class (exact) use_weight_id : table
---@field is_use_weight number
---@class (exact) fat_use_weight_id
---@field id use_weight_id Unique use_weight id
---@field weight number efficiency of this relation
---@field trade_good trade_good_id index of trade good
---@field use_case use_case_id index of use case

---@class struct_use_weight
---@field weight number efficiency of this relation

---@class (exact) use_weight_id_data_blob_definition
---@field weight number efficiency of this relation
---Sets values of use_weight for given id
---@param id use_weight_id
---@param data use_weight_id_data_blob_definition
function DATA.setup_use_weight(id, data)
    DATA.use_weight_set_weight(id, data.weight)
end

ffi.cdef[[
void dcon_use_weight_set_weight(int32_t, float);
float dcon_use_weight_get_weight(int32_t);
int32_t dcon_force_create_use_weight(int32_t trade_good, int32_t use_case);
void dcon_use_weight_set_trade_good(int32_t, int32_t);
int32_t dcon_use_weight_get_trade_good(int32_t);
int32_t dcon_trade_good_get_range_use_weight_as_trade_good(int32_t);
int32_t dcon_trade_good_get_index_use_weight_as_trade_good(int32_t, int32_t);
void dcon_use_weight_set_use_case(int32_t, int32_t);
int32_t dcon_use_weight_get_use_case(int32_t);
int32_t dcon_use_case_get_range_use_weight_as_use_case(int32_t);
int32_t dcon_use_case_get_index_use_weight_as_use_case(int32_t, int32_t);
bool dcon_use_weight_is_valid(int32_t);
void dcon_use_weight_resize(uint32_t sz);
uint32_t dcon_use_weight_size();
]]

---use_weight: FFI arrays---

---use_weight: LUA bindings---

DATA.use_weight_size = 300
---@param trade_good trade_good_id
---@param use_case use_case_id
---@return use_weight_id
function DATA.force_create_use_weight(trade_good, use_case)
    ---@type use_weight_id
    local i = DCON.dcon_force_create_use_weight(trade_good - 1, use_case - 1) + 1
    return i --[[@as use_weight_id]] 
end
---@param func fun(item: use_weight_id) 
function DATA.for_each_use_weight(func)
    ---@type number
    local range = DCON.dcon_use_weight_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as use_weight_id]])
    end
end
---@param func fun(item: use_weight_id):boolean 
---@return table<use_weight_id, use_weight_id> 
function DATA.filter_use_weight(func)
    ---@type table<use_weight_id, use_weight_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_use_weight_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as use_weight_id]]) then t[i + 1 --[[@as use_weight_id]]] = t[i + 1 --[[@as use_weight_id]]] end
    end
    return t
end

---@param use_weight_id use_weight_id valid use_weight id
---@return number weight efficiency of this relation
function DATA.use_weight_get_weight(use_weight_id)
    return DCON.dcon_use_weight_get_weight(use_weight_id - 1)
end
---@param use_weight_id use_weight_id valid use_weight id
---@param value number valid number
function DATA.use_weight_set_weight(use_weight_id, value)
    DCON.dcon_use_weight_set_weight(use_weight_id - 1, value)
end
---@param use_weight_id use_weight_id valid use_weight id
---@param value number valid number
function DATA.use_weight_inc_weight(use_weight_id, value)
    ---@type number
    local current = DCON.dcon_use_weight_get_weight(use_weight_id - 1)
    DCON.dcon_use_weight_set_weight(use_weight_id - 1, current + value)
end
---@param trade_good use_weight_id valid trade_good_id
---@return trade_good_id Data retrieved from use_weight 
function DATA.use_weight_get_trade_good(trade_good)
    return DCON.dcon_use_weight_get_trade_good(trade_good - 1) + 1
end
---@param trade_good trade_good_id valid trade_good_id
---@return use_weight_id[] An array of use_weight 
function DATA.get_use_weight_from_trade_good(trade_good)
    local result = {}
    DATA.for_each_use_weight_from_trade_good(trade_good, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param trade_good trade_good_id valid trade_good_id
---@param func fun(item: use_weight_id) valid trade_good_id
function DATA.for_each_use_weight_from_trade_good(trade_good, func)
    ---@type number
    local range = DCON.dcon_trade_good_get_range_use_weight_as_trade_good(trade_good - 1)
    for i = 0, range - 1 do
        ---@type use_weight_id
        local accessed_element = DCON.dcon_trade_good_get_index_use_weight_as_trade_good(trade_good - 1, i) + 1
        if DCON.dcon_use_weight_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param trade_good trade_good_id valid trade_good_id
---@param func fun(item: use_weight_id):boolean 
---@return use_weight_id[]
function DATA.filter_array_use_weight_from_trade_good(trade_good, func)
    ---@type table<use_weight_id, use_weight_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_trade_good_get_range_use_weight_as_trade_good(trade_good - 1)
    for i = 0, range - 1 do
        ---@type use_weight_id
        local accessed_element = DCON.dcon_trade_good_get_index_use_weight_as_trade_good(trade_good - 1, i) + 1
        if DCON.dcon_use_weight_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param trade_good trade_good_id valid trade_good_id
---@param func fun(item: use_weight_id):boolean 
---@return table<use_weight_id, use_weight_id> 
function DATA.filter_use_weight_from_trade_good(trade_good, func)
    ---@type table<use_weight_id, use_weight_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_trade_good_get_range_use_weight_as_trade_good(trade_good - 1)
    for i = 0, range - 1 do
        ---@type use_weight_id
        local accessed_element = DCON.dcon_trade_good_get_index_use_weight_as_trade_good(trade_good - 1, i) + 1
        if DCON.dcon_use_weight_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param use_weight_id use_weight_id valid use_weight id
---@param value trade_good_id valid trade_good_id
function DATA.use_weight_set_trade_good(use_weight_id, value)
    DCON.dcon_use_weight_set_trade_good(use_weight_id - 1, value - 1)
end
---@param use_case use_weight_id valid use_case_id
---@return use_case_id Data retrieved from use_weight 
function DATA.use_weight_get_use_case(use_case)
    return DCON.dcon_use_weight_get_use_case(use_case - 1) + 1
end
---@param use_case use_case_id valid use_case_id
---@return use_weight_id[] An array of use_weight 
function DATA.get_use_weight_from_use_case(use_case)
    local result = {}
    DATA.for_each_use_weight_from_use_case(use_case, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param use_case use_case_id valid use_case_id
---@param func fun(item: use_weight_id) valid use_case_id
function DATA.for_each_use_weight_from_use_case(use_case, func)
    ---@type number
    local range = DCON.dcon_use_case_get_range_use_weight_as_use_case(use_case - 1)
    for i = 0, range - 1 do
        ---@type use_weight_id
        local accessed_element = DCON.dcon_use_case_get_index_use_weight_as_use_case(use_case - 1, i) + 1
        if DCON.dcon_use_weight_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param use_case use_case_id valid use_case_id
---@param func fun(item: use_weight_id):boolean 
---@return use_weight_id[]
function DATA.filter_array_use_weight_from_use_case(use_case, func)
    ---@type table<use_weight_id, use_weight_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_use_case_get_range_use_weight_as_use_case(use_case - 1)
    for i = 0, range - 1 do
        ---@type use_weight_id
        local accessed_element = DCON.dcon_use_case_get_index_use_weight_as_use_case(use_case - 1, i) + 1
        if DCON.dcon_use_weight_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param use_case use_case_id valid use_case_id
---@param func fun(item: use_weight_id):boolean 
---@return table<use_weight_id, use_weight_id> 
function DATA.filter_use_weight_from_use_case(use_case, func)
    ---@type table<use_weight_id, use_weight_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_use_case_get_range_use_weight_as_use_case(use_case - 1)
    for i = 0, range - 1 do
        ---@type use_weight_id
        local accessed_element = DCON.dcon_use_case_get_index_use_weight_as_use_case(use_case - 1, i) + 1
        if DCON.dcon_use_weight_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param use_weight_id use_weight_id valid use_weight id
---@param value use_case_id valid use_case_id
function DATA.use_weight_set_use_case(use_weight_id, value)
    DCON.dcon_use_weight_set_use_case(use_weight_id - 1, value - 1)
end

local fat_use_weight_id_metatable = {
    __index = function (t,k)
        if (k == "weight") then return DATA.use_weight_get_weight(t.id) end
        if (k == "trade_good") then return DATA.use_weight_get_trade_good(t.id) end
        if (k == "use_case") then return DATA.use_weight_get_use_case(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "weight") then
            DATA.use_weight_set_weight(t.id, v)
            return
        end
        if (k == "trade_good") then
            DATA.use_weight_set_trade_good(t.id, v)
            return
        end
        if (k == "use_case") then
            DATA.use_weight_set_use_case(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id use_weight_id
---@return fat_use_weight_id fat_id
function DATA.fatten_use_weight(id)
    local result = {id = id}
    setmetatable(result, fat_use_weight_id_metatable)
    return result --[[@as fat_use_weight_id]]
end
