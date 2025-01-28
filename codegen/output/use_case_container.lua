local ffi = require("ffi")
---@class struct_use_case_container
---@field use use_case_id 
---@field amount number 
ffi.cdef[[
    typedef struct {
        int32_t use;
        float amount;
    } use_case_container;
]]
