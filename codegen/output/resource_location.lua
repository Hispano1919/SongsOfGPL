local ffi = require("ffi")
---@class struct_resource_location
---@field resource resource_id 
---@field location tile_id 
ffi.cdef[[
    typedef struct {
        int32_t resource;
        int32_t location;
    } resource_location;
]]
