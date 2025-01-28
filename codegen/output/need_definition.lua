local ffi = require("ffi")
---@class struct_need_definition
---@field need NEED 
---@field use_case use_case_id 
---@field required number 
ffi.cdef[[
    typedef struct {
        uint8_t need;
        int32_t use_case;
        float required;
    } need_definition;
]]
