local ffi = require("ffi")
---@class struct_forage_container
---@field output_good trade_good_id 
---@field output_value number 
---@field amount number 
---@field forage FORAGE_RESOURCE 
ffi.cdef[[
    typedef struct {
        int32_t output_good;
        float output_value;
        float amount;
        uint8_t forage;
    } forage_container;
]]
