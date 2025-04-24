local ffi = require("ffi")

----------rite----------

---rite: LSP types---

---@class (exact) rite_id : table
---@field is_rite number
---@class (exact) fat_rite_id
---@field id rite_id
---@field name string
---@field faith faith_id
---@field spirits deity_id[]

---@class struct_rite
---@field faith faith_id

ffi.cdef[[
// Funciones FFI para rites (similar a faith.lua)
int32_t dcon_create_rite();
bool dcon_rite_is_valid(int32_t);
void dcon_delete_rite(int32_t);
]]

---rite: FFI arrays---
---@type string[]
DATA.rite_name = {}
---@type faith_id[]
DATA.rite_faith = {} -- Religión/fe asociada
---@type table<rite_id, deity_id[]> 
DATA.rite_spirits = {} -- Lista de deidades/espíritus

---rite: LUA bindings---

---@return rite_id
function DATA.create_rite()
    local id = DCON.dcon_create_rite() + 1
    return id --[[@as rite_id]]
end

---@param rite_id rite_id
function DATA.delete_rite(rite_id)
    assert(DCON.dcon_rite_is_valid(rite_id - 1), "Rite inválido")
    DCON.dcon_delete_rite(rite_id - 1)
end

---@param rite_id rite_id
---@return string
function DATA.rite_get_name(rite_id)
    return DATA.rite_name[rite_id] or ""
end

---@param rite_id rite_id
---@param value string
function DATA.rite_set_name(rite_id, value)
    DATA.rite_name[rite_id] = value
end

---@param rite_id rite_id
---@return faith_id
function DATA.rite_get_faith(rite_id)
    return DATA.rite_faith[rite_id]
end

---@param rite_id rite_id
---@param value faith_id
function DATA.rite_set_faith(rite_id, value)
    DATA.rite_faith[rite_id] = value
end

---@param rite_id rite_id
---@return deity_id[]
function DATA.rite_get_spirits(rite_id)
    return DATA.rite_spirits[rite_id] or {}
end

---@param rite_id rite_id
---@param deity_id deity_id
function DATA.rite_add_spirit(rite_id, deity_id)
    if not DATA.rite_spirits[rite_id] then
        DATA.rite_spirits[rite_id] = {}
    end
    table.insert(DATA.rite_spirits[rite_id], deity_id)
end

-- Metatable para fat_rite_id
local fat_rite_id_metatable = {
    __index = function(t, k)
        if k == "name" then return DATA.rite_get_name(t.id) end
        if k == "faith" then return DATA.rite_get_faith(t.id) end
        if k == "spirits" then return DATA.rite_get_spirits(t.id) end
        return rawget(t, k)
    end,
    __newindex = function(t, k, v)
        if k == "name" then
            DATA.rite_set_name(t.id, v)
        elseif k == "faith" then
            DATA.rite_set_faith(t.id, v)
        else
            rawset(t, k, v)
        end
    end
}

---@param id rite_id
---@return fat_rite_id
function DATA.fatten_rite(id)
    local result = { id = id }
    setmetatable(result, fat_rite_id_metatable)
    return result --[[@as fat_rite_id]]
end

return DATA