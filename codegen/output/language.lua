local ffi = require("ffi")
----------language----------


---language: LSP types---

---Unique identificator for language entity
---@class (exact) language_id : table
---@field is_language number
---@class (exact) fat_language_id
---@field id language_id Unique language id
---@field syllables table<number,string> 
---@field consonants table<number,string> 
---@field vowels table<number,string> 
---@field ending_province table<number,string> 
---@field ending_realm table<number,string> 
---@field ending_adj table<number,string> 
---@field ranks table<number,string> 

---@class struct_language


ffi.cdef[[
void dcon_delete_language(int32_t j);
int32_t dcon_create_language();
bool dcon_language_is_valid(int32_t);
void dcon_language_resize(uint32_t sz);
uint32_t dcon_language_size();
]]

---language: FFI arrays---
---@type (table<number,string>)[]
DATA.language_syllables= {}
---@type (table<number,string>)[]
DATA.language_consonants= {}
---@type (table<number,string>)[]
DATA.language_vowels= {}
---@type (table<number,string>)[]
DATA.language_ending_province= {}
---@type (table<number,string>)[]
DATA.language_ending_realm= {}
---@type (table<number,string>)[]
DATA.language_ending_adj= {}
---@type (table<number,string>)[]
DATA.language_ranks= {}

---language: LUA bindings---

DATA.language_size = 10000
---@return language_id
function DATA.create_language()
    ---@type language_id
    local i  = DCON.dcon_create_language() + 1
    return i --[[@as language_id]] 
end
---@param i language_id
function DATA.delete_language(i)
    assert(DCON.dcon_language_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_language(i - 1)
end
---@param func fun(item: language_id) 
function DATA.for_each_language(func)
    ---@type number
    local range = DCON.dcon_language_size()
    for i = 0, range - 1 do
        if DCON.dcon_language_is_valid(i) then func(i + 1 --[[@as language_id]]) end
    end
end
---@param func fun(item: language_id):boolean 
---@return table<language_id, language_id> 
function DATA.filter_language(func)
    ---@type table<language_id, language_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_language_size()
    for i = 0, range - 1 do
        if DCON.dcon_language_is_valid(i) and func(i + 1 --[[@as language_id]]) then t[i + 1 --[[@as language_id]]] = i + 1 --[[@as language_id]] end
    end
    return t
end

---@param language_id language_id valid language id
---@return table<number,string> syllables 
function DATA.language_get_syllables(language_id)
    return DATA.language_syllables[language_id]
end
---@param language_id language_id valid language id
---@param value table<number,string> valid table<number,string>
function DATA.language_set_syllables(language_id, value)
    DATA.language_syllables[language_id] = value
end
---@param language_id language_id valid language id
---@return table<number,string> consonants 
function DATA.language_get_consonants(language_id)
    return DATA.language_consonants[language_id]
end
---@param language_id language_id valid language id
---@param value table<number,string> valid table<number,string>
function DATA.language_set_consonants(language_id, value)
    DATA.language_consonants[language_id] = value
end
---@param language_id language_id valid language id
---@return table<number,string> vowels 
function DATA.language_get_vowels(language_id)
    return DATA.language_vowels[language_id]
end
---@param language_id language_id valid language id
---@param value table<number,string> valid table<number,string>
function DATA.language_set_vowels(language_id, value)
    DATA.language_vowels[language_id] = value
end
---@param language_id language_id valid language id
---@return table<number,string> ending_province 
function DATA.language_get_ending_province(language_id)
    return DATA.language_ending_province[language_id]
end
---@param language_id language_id valid language id
---@param value table<number,string> valid table<number,string>
function DATA.language_set_ending_province(language_id, value)
    DATA.language_ending_province[language_id] = value
end
---@param language_id language_id valid language id
---@return table<number,string> ending_realm 
function DATA.language_get_ending_realm(language_id)
    return DATA.language_ending_realm[language_id]
end
---@param language_id language_id valid language id
---@param value table<number,string> valid table<number,string>
function DATA.language_set_ending_realm(language_id, value)
    DATA.language_ending_realm[language_id] = value
end
---@param language_id language_id valid language id
---@return table<number,string> ending_adj 
function DATA.language_get_ending_adj(language_id)
    return DATA.language_ending_adj[language_id]
end
---@param language_id language_id valid language id
---@param value table<number,string> valid table<number,string>
function DATA.language_set_ending_adj(language_id, value)
    DATA.language_ending_adj[language_id] = value
end
---@param language_id language_id valid language id
---@return table<number,string> ranks 
function DATA.language_get_ranks(language_id)
    return DATA.language_ranks[language_id]
end
---@param language_id language_id valid language id
---@param value table<number,string> valid table<number,string>
function DATA.language_set_ranks(language_id, value)
    DATA.language_ranks[language_id] = value
end

local fat_language_id_metatable = {
    __index = function (t,k)
        if (k == "syllables") then return DATA.language_get_syllables(t.id) end
        if (k == "consonants") then return DATA.language_get_consonants(t.id) end
        if (k == "vowels") then return DATA.language_get_vowels(t.id) end
        if (k == "ending_province") then return DATA.language_get_ending_province(t.id) end
        if (k == "ending_realm") then return DATA.language_get_ending_realm(t.id) end
        if (k == "ending_adj") then return DATA.language_get_ending_adj(t.id) end
        if (k == "ranks") then return DATA.language_get_ranks(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "syllables") then
            DATA.language_set_syllables(t.id, v)
            return
        end
        if (k == "consonants") then
            DATA.language_set_consonants(t.id, v)
            return
        end
        if (k == "vowels") then
            DATA.language_set_vowels(t.id, v)
            return
        end
        if (k == "ending_province") then
            DATA.language_set_ending_province(t.id, v)
            return
        end
        if (k == "ending_realm") then
            DATA.language_set_ending_realm(t.id, v)
            return
        end
        if (k == "ending_adj") then
            DATA.language_set_ending_adj(t.id, v)
            return
        end
        if (k == "ranks") then
            DATA.language_set_ranks(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id language_id
---@return fat_language_id fat_id
function DATA.fatten_language(id)
    local result = {id = id}
    setmetatable(result, fat_language_id_metatable)
    return result --[[@as fat_language_id]]
end
