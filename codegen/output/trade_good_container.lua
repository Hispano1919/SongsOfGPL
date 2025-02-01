local ffi = require("ffi")
---@class struct_trade_good_container
---@field good trade_good_id 
---@field amount number 
ffi.cdef[[
    typedef struct {
        int32_t good;
        float amount;
    } trade_good_container;
]]
