local ffi = require("ffi")
---@class struct_job_container
---@field job job_id 
---@field amount number 
ffi.cdef[[
    typedef struct {
        int32_t job;
        uint32_t amount;
    } job_container;
]]
