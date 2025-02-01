local ffi = require("ffi")
----------character_rank----------


---character_rank: LSP types---

---Unique identificator for character_rank entity
---@class (exact) character_rank_id : table
---@field is_character_rank number
---@class (exact) fat_character_rank_id
---@field id character_rank_id Unique character_rank id
---@field name string 
---@field localisation string 

---@class struct_character_rank

---@class (exact) character_rank_id_data_blob_definition
---@field name string 
---@field localisation string 
---Sets values of character_rank for given id
---@param id character_rank_id
---@param data character_rank_id_data_blob_definition
function DATA.setup_character_rank(id, data)
    DATA.character_rank_set_name(id, data.name)
    DATA.character_rank_set_localisation(id, data.localisation)
end

ffi.cdef[[
int32_t dcon_create_character_rank();
bool dcon_character_rank_is_valid(int32_t);
void dcon_character_rank_resize(uint32_t sz);
uint32_t dcon_character_rank_size();
]]

---character_rank: FFI arrays---
---@type (string)[]
DATA.character_rank_name= {}
---@type (string)[]
DATA.character_rank_localisation= {}

---character_rank: LUA bindings---

DATA.character_rank_size = 5
---@return character_rank_id
function DATA.create_character_rank()
    ---@type character_rank_id
    local i  = DCON.dcon_create_character_rank() + 1
    return i --[[@as character_rank_id]] 
end
---@param func fun(item: character_rank_id) 
function DATA.for_each_character_rank(func)
    ---@type number
    local range = DCON.dcon_character_rank_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as character_rank_id]])
    end
end
---@param func fun(item: character_rank_id):boolean 
---@return table<character_rank_id, character_rank_id> 
function DATA.filter_character_rank(func)
    ---@type table<character_rank_id, character_rank_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_character_rank_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as character_rank_id]]) then t[i + 1 --[[@as character_rank_id]]] = t[i + 1 --[[@as character_rank_id]]] end
    end
    return t
end

---@param character_rank_id character_rank_id valid character_rank id
---@return string name 
function DATA.character_rank_get_name(character_rank_id)
    return DATA.character_rank_name[character_rank_id]
end
---@param character_rank_id character_rank_id valid character_rank id
---@param value string valid string
function DATA.character_rank_set_name(character_rank_id, value)
    DATA.character_rank_name[character_rank_id] = value
end
---@param character_rank_id character_rank_id valid character_rank id
---@return string localisation 
function DATA.character_rank_get_localisation(character_rank_id)
    return DATA.character_rank_localisation[character_rank_id]
end
---@param character_rank_id character_rank_id valid character_rank id
---@param value string valid string
function DATA.character_rank_set_localisation(character_rank_id, value)
    DATA.character_rank_localisation[character_rank_id] = value
end

local fat_character_rank_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.character_rank_get_name(t.id) end
        if (k == "localisation") then return DATA.character_rank_get_localisation(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.character_rank_set_name(t.id, v)
            return
        end
        if (k == "localisation") then
            DATA.character_rank_set_localisation(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id character_rank_id
---@return fat_character_rank_id fat_id
function DATA.fatten_character_rank(id)
    local result = {id = id}
    setmetatable(result, fat_character_rank_id_metatable)
    return result --[[@as fat_character_rank_id]]
end
---@enum CHARACTER_RANK
CHARACTER_RANK = {
    INVALID = 0,
    POP = 1,
    NOBLE = 2,
    CHIEF = 3,
}
local index_character_rank
index_character_rank = DATA.create_character_rank()
DATA.character_rank_set_name(index_character_rank, "POP")
DATA.character_rank_set_localisation(index_character_rank, "Commoner")
index_character_rank = DATA.create_character_rank()
DATA.character_rank_set_name(index_character_rank, "NOBLE")
DATA.character_rank_set_localisation(index_character_rank, "Noble")
index_character_rank = DATA.create_character_rank()
DATA.character_rank_set_name(index_character_rank, "CHIEF")
DATA.character_rank_set_localisation(index_character_rank, "Chief")
