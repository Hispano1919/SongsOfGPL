local ffi = require("ffi")
---@class struct_budget_per_category_data
---@field ratio number 
---@field budget number 
---@field to_be_invested number 
---@field target number 
ffi.cdef[[
    typedef struct {
        float ratio;
        float budget;
        float to_be_invested;
        float target;
    } budget_per_category_data;
]]
