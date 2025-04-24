local ffi = require("ffi")

----------deity----------

---deity: LSP types---

---Unique identificator for deity entity
---@class (exact) deity_id : table
---@field is_deity number
---@class (exact) fat_deity_id
---@field id deity_id
---@field name string 
---@field domain string
---@field rank number

ffi.cdef[[
int32_t dcon_create_deity();
bool dcon_deity_is_valid(int32_t);
void dcon_delete_deity(int32_t);
]]

---deity: FFI arrays---
---@type string[]
DATA.deity_name = {}
---@type string[]
DATA.deity_domain = {}
---@type number[]
DATA.deity_rank = {}

---deity: LUA bindings---

DATA.deity_size = 10000
---@return deity_id
function DATA.create_deity()
    ---@type deity_id
    local i  = DCON.dcon_create_deity() + 1
    return i --[[@as deity_id]] 
end

---@param i deity_id
function DATA.delete_deity(i)
    assert(DCON.dcon_deity_is_valid(i - 1), " ATTEMPT TO DELETE INVALID DEITY " .. tostring(i))
    return DCON.dcon_delete_deity(i - 1)
end

---@param deity_id deity_id
---@return string name 
function DATA.deity_get_name(deity_id)
    return DATA.deity_name[deity_id] or ""
end

---@param deity_id deity_id
---@param value string
function DATA.deity_set_name(deity_id, value)
    DATA.deity_name[deity_id] = value
end

---@param deity_id deity_id
---@return string domain 
function DATA.deity_get_domain(deity_id)
    return DATA.deity_domain[deity_id] or ""
end

---@param deity_id deity_id
---@param value string
function DATA.deity_set_domain(deity_id, value)
    DATA.deity_domain[deity_id] = value
end

---@param deity_id deity_id
---@return number rank 
function DATA.deity_get_rank(deity_id)
    return DATA.deity_rank[deity_id] or 0
end

---@param deity_id deity_id
---@param value number
function DATA.deity_set_rank(deity_id, value)
    DATA.deity_rank[deity_id] = value
end

local fat_deity_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.deity_get_name(t.id) end
        if (k == "domain") then return DATA.deity_get_domain(t.id) end
        if (k == "rank") then return DATA.deity_get_rank(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.deity_set_name(t.id, v)
            return
        end
        if (k == "domain") then
            DATA.deity_set_domain(t.id, v)
            return
        end
        if (k == "rank") then
            DATA.deity_set_rank(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}

---@param id deity_id
---@return fat_deity_id fat_id
function DATA.fatten_deity(id)
    local result = {id = id}
    setmetatable(result, fat_deity_id_metatable)
    return result --[[@as fat_deity_id]]
end

return DATA