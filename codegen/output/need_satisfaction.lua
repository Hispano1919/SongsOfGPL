local ffi = require("ffi")
---@class struct_need_satisfaction
---@field need NEED 
---@field use_case use_case_id 
---@field consumed number 
---@field demanded number 
ffi.cdef[[
    typedef struct {
        uint8_t need;
        int32_t use_case;
        float consumed;
        float demanded;
    } need_satisfaction;
]]
