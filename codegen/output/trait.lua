local ffi = require("ffi")
----------trait----------


---trait: LSP types---

---Unique identificator for trait entity
---@class (exact) trait_id : table
---@field is_trait number
---@class (exact) fat_trait_id
---@field id trait_id Unique trait id
---@field name string 
---@field ambition number 
---@field greed number 
---@field admin number 
---@field traveller number 
---@field aggression number 
---@field short_description string 
---@field full_description string 
---@field icon string 

---@class struct_trait
---@field ambition number 
---@field greed number 
---@field admin number 
---@field traveller number 
---@field aggression number 

---@class (exact) trait_id_data_blob_definition
---@field name string 
---@field ambition number 
---@field greed number 
---@field admin number 
---@field traveller number 
---@field aggression number 
---@field short_description string 
---@field full_description string 
---@field icon string 
---Sets values of trait for given id
---@param id trait_id
---@param data trait_id_data_blob_definition
function DATA.setup_trait(id, data)
    DATA.trait_set_name(id, data.name)
    DATA.trait_set_ambition(id, data.ambition)
    DATA.trait_set_greed(id, data.greed)
    DATA.trait_set_admin(id, data.admin)
    DATA.trait_set_traveller(id, data.traveller)
    DATA.trait_set_aggression(id, data.aggression)
    DATA.trait_set_short_description(id, data.short_description)
    DATA.trait_set_full_description(id, data.full_description)
    DATA.trait_set_icon(id, data.icon)
end

ffi.cdef[[
void dcon_trait_set_ambition(int32_t, float);
float dcon_trait_get_ambition(int32_t);
void dcon_trait_set_greed(int32_t, float);
float dcon_trait_get_greed(int32_t);
void dcon_trait_set_admin(int32_t, float);
float dcon_trait_get_admin(int32_t);
void dcon_trait_set_traveller(int32_t, float);
float dcon_trait_get_traveller(int32_t);
void dcon_trait_set_aggression(int32_t, float);
float dcon_trait_get_aggression(int32_t);
int32_t dcon_create_trait();
bool dcon_trait_is_valid(int32_t);
void dcon_trait_resize(uint32_t sz);
uint32_t dcon_trait_size();
]]

---trait: FFI arrays---
---@type (string)[]
DATA.trait_name= {}
---@type (string)[]
DATA.trait_short_description= {}
---@type (string)[]
DATA.trait_full_description= {}
---@type (string)[]
DATA.trait_icon= {}

---trait: LUA bindings---

DATA.trait_size = 12
---@return trait_id
function DATA.create_trait()
    ---@type trait_id
    local i  = DCON.dcon_create_trait() + 1
    return i --[[@as trait_id]] 
end
---@param func fun(item: trait_id) 
function DATA.for_each_trait(func)
    ---@type number
    local range = DCON.dcon_trait_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as trait_id]])
    end
end
---@param func fun(item: trait_id):boolean 
---@return table<trait_id, trait_id> 
function DATA.filter_trait(func)
    ---@type table<trait_id, trait_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_trait_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as trait_id]]) then t[i + 1 --[[@as trait_id]]] = t[i + 1 --[[@as trait_id]]] end
    end
    return t
end

---@param trait_id trait_id valid trait id
---@return string name 
function DATA.trait_get_name(trait_id)
    return DATA.trait_name[trait_id]
end
---@param trait_id trait_id valid trait id
---@param value string valid string
function DATA.trait_set_name(trait_id, value)
    DATA.trait_name[trait_id] = value
end
---@param trait_id trait_id valid trait id
---@return number ambition 
function DATA.trait_get_ambition(trait_id)
    return DCON.dcon_trait_get_ambition(trait_id - 1)
end
---@param trait_id trait_id valid trait id
---@param value number valid number
function DATA.trait_set_ambition(trait_id, value)
    DCON.dcon_trait_set_ambition(trait_id - 1, value)
end
---@param trait_id trait_id valid trait id
---@param value number valid number
function DATA.trait_inc_ambition(trait_id, value)
    ---@type number
    local current = DCON.dcon_trait_get_ambition(trait_id - 1)
    DCON.dcon_trait_set_ambition(trait_id - 1, current + value)
end
---@param trait_id trait_id valid trait id
---@return number greed 
function DATA.trait_get_greed(trait_id)
    return DCON.dcon_trait_get_greed(trait_id - 1)
end
---@param trait_id trait_id valid trait id
---@param value number valid number
function DATA.trait_set_greed(trait_id, value)
    DCON.dcon_trait_set_greed(trait_id - 1, value)
end
---@param trait_id trait_id valid trait id
---@param value number valid number
function DATA.trait_inc_greed(trait_id, value)
    ---@type number
    local current = DCON.dcon_trait_get_greed(trait_id - 1)
    DCON.dcon_trait_set_greed(trait_id - 1, current + value)
end
---@param trait_id trait_id valid trait id
---@return number admin 
function DATA.trait_get_admin(trait_id)
    return DCON.dcon_trait_get_admin(trait_id - 1)
end
---@param trait_id trait_id valid trait id
---@param value number valid number
function DATA.trait_set_admin(trait_id, value)
    DCON.dcon_trait_set_admin(trait_id - 1, value)
end
---@param trait_id trait_id valid trait id
---@param value number valid number
function DATA.trait_inc_admin(trait_id, value)
    ---@type number
    local current = DCON.dcon_trait_get_admin(trait_id - 1)
    DCON.dcon_trait_set_admin(trait_id - 1, current + value)
end
---@param trait_id trait_id valid trait id
---@return number traveller 
function DATA.trait_get_traveller(trait_id)
    return DCON.dcon_trait_get_traveller(trait_id - 1)
end
---@param trait_id trait_id valid trait id
---@param value number valid number
function DATA.trait_set_traveller(trait_id, value)
    DCON.dcon_trait_set_traveller(trait_id - 1, value)
end
---@param trait_id trait_id valid trait id
---@param value number valid number
function DATA.trait_inc_traveller(trait_id, value)
    ---@type number
    local current = DCON.dcon_trait_get_traveller(trait_id - 1)
    DCON.dcon_trait_set_traveller(trait_id - 1, current + value)
end
---@param trait_id trait_id valid trait id
---@return number aggression 
function DATA.trait_get_aggression(trait_id)
    return DCON.dcon_trait_get_aggression(trait_id - 1)
end
---@param trait_id trait_id valid trait id
---@param value number valid number
function DATA.trait_set_aggression(trait_id, value)
    DCON.dcon_trait_set_aggression(trait_id - 1, value)
end
---@param trait_id trait_id valid trait id
---@param value number valid number
function DATA.trait_inc_aggression(trait_id, value)
    ---@type number
    local current = DCON.dcon_trait_get_aggression(trait_id - 1)
    DCON.dcon_trait_set_aggression(trait_id - 1, current + value)
end
---@param trait_id trait_id valid trait id
---@return string short_description 
function DATA.trait_get_short_description(trait_id)
    return DATA.trait_short_description[trait_id]
end
---@param trait_id trait_id valid trait id
---@param value string valid string
function DATA.trait_set_short_description(trait_id, value)
    DATA.trait_short_description[trait_id] = value
end
---@param trait_id trait_id valid trait id
---@return string full_description 
function DATA.trait_get_full_description(trait_id)
    return DATA.trait_full_description[trait_id]
end
---@param trait_id trait_id valid trait id
---@param value string valid string
function DATA.trait_set_full_description(trait_id, value)
    DATA.trait_full_description[trait_id] = value
end
---@param trait_id trait_id valid trait id
---@return string icon 
function DATA.trait_get_icon(trait_id)
    return DATA.trait_icon[trait_id]
end
---@param trait_id trait_id valid trait id
---@param value string valid string
function DATA.trait_set_icon(trait_id, value)
    DATA.trait_icon[trait_id] = value
end

local fat_trait_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.trait_get_name(t.id) end
        if (k == "ambition") then return DATA.trait_get_ambition(t.id) end
        if (k == "greed") then return DATA.trait_get_greed(t.id) end
        if (k == "admin") then return DATA.trait_get_admin(t.id) end
        if (k == "traveller") then return DATA.trait_get_traveller(t.id) end
        if (k == "aggression") then return DATA.trait_get_aggression(t.id) end
        if (k == "short_description") then return DATA.trait_get_short_description(t.id) end
        if (k == "full_description") then return DATA.trait_get_full_description(t.id) end
        if (k == "icon") then return DATA.trait_get_icon(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.trait_set_name(t.id, v)
            return
        end
        if (k == "ambition") then
            DATA.trait_set_ambition(t.id, v)
            return
        end
        if (k == "greed") then
            DATA.trait_set_greed(t.id, v)
            return
        end
        if (k == "admin") then
            DATA.trait_set_admin(t.id, v)
            return
        end
        if (k == "traveller") then
            DATA.trait_set_traveller(t.id, v)
            return
        end
        if (k == "aggression") then
            DATA.trait_set_aggression(t.id, v)
            return
        end
        if (k == "short_description") then
            DATA.trait_set_short_description(t.id, v)
            return
        end
        if (k == "full_description") then
            DATA.trait_set_full_description(t.id, v)
            return
        end
        if (k == "icon") then
            DATA.trait_set_icon(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id trait_id
---@return fat_trait_id fat_id
function DATA.fatten_trait(id)
    local result = {id = id}
    setmetatable(result, fat_trait_id_metatable)
    return result --[[@as fat_trait_id]]
end
---@enum TRAIT
TRAIT = {
    INVALID = 0,
    AMBITIOUS = 1,
    CONTENT = 2,
    LOYAL = 3,
    GREEDY = 4,
    WARLIKE = 5,
    BAD_ORGANISER = 6,
    GOOD_ORGANISER = 7,
    LAZY = 8,
    HARDWORKER = 9,
    TRADER = 10,
}
local index_trait
index_trait = DATA.create_trait()
DATA.trait_set_name(index_trait, "AMBITIOUS")
DATA.trait_set_ambition(index_trait, 1)
DATA.trait_set_greed(index_trait, 0.05)
DATA.trait_set_admin(index_trait, 0)
DATA.trait_set_traveller(index_trait, 0)
DATA.trait_set_aggression(index_trait, 0.2)
DATA.trait_set_short_description(index_trait, "ambitious")
DATA.trait_set_full_description(index_trait, "TODO")
DATA.trait_set_icon(index_trait, "mountaintop.png")
index_trait = DATA.create_trait()
DATA.trait_set_name(index_trait, "CONTENT")
DATA.trait_set_ambition(index_trait, -0.5)
DATA.trait_set_greed(index_trait, 0)
DATA.trait_set_admin(index_trait, 0)
DATA.trait_set_traveller(index_trait, 0)
DATA.trait_set_aggression(index_trait, -0.1)
DATA.trait_set_short_description(index_trait, "content")
DATA.trait_set_full_description(index_trait, "This person has no ambitions: it would be hard to persuade them to change occupation")
DATA.trait_set_icon(index_trait, "inner-self.png")
index_trait = DATA.create_trait()
DATA.trait_set_name(index_trait, "LOYAL")
DATA.trait_set_ambition(index_trait, -0.02)
DATA.trait_set_greed(index_trait, 0)
DATA.trait_set_admin(index_trait, 0)
DATA.trait_set_traveller(index_trait, 0)
DATA.trait_set_aggression(index_trait, 0)
DATA.trait_set_short_description(index_trait, "loyal")
DATA.trait_set_full_description(index_trait, "This person rarely betrays people")
DATA.trait_set_icon(index_trait, "check-mark.png")
index_trait = DATA.create_trait()
DATA.trait_set_name(index_trait, "GREEDY")
DATA.trait_set_ambition(index_trait, 0)
DATA.trait_set_greed(index_trait, 0.5)
DATA.trait_set_admin(index_trait, 0)
DATA.trait_set_traveller(index_trait, 0)
DATA.trait_set_aggression(index_trait, 0)
DATA.trait_set_short_description(index_trait, "greedy")
DATA.trait_set_full_description(index_trait, "Desire for money drives this person's actions")
DATA.trait_set_icon(index_trait, "receive-money.png")
index_trait = DATA.create_trait()
DATA.trait_set_name(index_trait, "WARLIKE")
DATA.trait_set_ambition(index_trait, 0.1)
DATA.trait_set_greed(index_trait, 0)
DATA.trait_set_admin(index_trait, 0)
DATA.trait_set_traveller(index_trait, 0)
DATA.trait_set_aggression(index_trait, 1)
DATA.trait_set_short_description(index_trait, "warlike")
DATA.trait_set_full_description(index_trait, "TODO")
DATA.trait_set_icon(index_trait, "barbute.png")
index_trait = DATA.create_trait()
DATA.trait_set_name(index_trait, "BAD_ORGANISER")
DATA.trait_set_ambition(index_trait, 0)
DATA.trait_set_greed(index_trait, 0)
DATA.trait_set_admin(index_trait, -0.2)
DATA.trait_set_traveller(index_trait, 0)
DATA.trait_set_aggression(index_trait, 0)
DATA.trait_set_short_description(index_trait, "bad organiser")
DATA.trait_set_full_description(index_trait, "TODO")
DATA.trait_set_icon(index_trait, "shrug.png")
index_trait = DATA.create_trait()
DATA.trait_set_name(index_trait, "GOOD_ORGANISER")
DATA.trait_set_ambition(index_trait, 0.01)
DATA.trait_set_greed(index_trait, 0)
DATA.trait_set_admin(index_trait, 0.2)
DATA.trait_set_traveller(index_trait, 0)
DATA.trait_set_aggression(index_trait, 0)
DATA.trait_set_short_description(index_trait, "good organiser")
DATA.trait_set_full_description(index_trait, "TODO")
DATA.trait_set_icon(index_trait, "pitchfork.png")
index_trait = DATA.create_trait()
DATA.trait_set_name(index_trait, "LAZY")
DATA.trait_set_ambition(index_trait, -0.5)
DATA.trait_set_greed(index_trait, 0)
DATA.trait_set_admin(index_trait, -0.1)
DATA.trait_set_traveller(index_trait, 0)
DATA.trait_set_aggression(index_trait, -0.1)
DATA.trait_set_short_description(index_trait, "lazy")
DATA.trait_set_full_description(index_trait, "This person prefers to do nothing")
DATA.trait_set_icon(index_trait, "parmecia.png")
index_trait = DATA.create_trait()
DATA.trait_set_name(index_trait, "HARDWORKER")
DATA.trait_set_ambition(index_trait, 0.01)
DATA.trait_set_greed(index_trait, 0)
DATA.trait_set_admin(index_trait, 0.1)
DATA.trait_set_traveller(index_trait, 0)
DATA.trait_set_aggression(index_trait, 0)
DATA.trait_set_short_description(index_trait, "hard worker")
DATA.trait_set_full_description(index_trait, "TODO")
DATA.trait_set_icon(index_trait, "miner.png")
index_trait = DATA.create_trait()
DATA.trait_set_name(index_trait, "TRADER")
DATA.trait_set_ambition(index_trait, -0.5)
DATA.trait_set_greed(index_trait, 0.2)
DATA.trait_set_admin(index_trait, 0.05)
DATA.trait_set_traveller(index_trait, 1)
DATA.trait_set_aggression(index_trait, -0.1)
DATA.trait_set_short_description(index_trait, "trader")
DATA.trait_set_full_description(index_trait, "TODO")
DATA.trait_set_icon(index_trait, "scales.png")
