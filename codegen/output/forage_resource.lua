local ffi = require("ffi")
----------forage_resource----------


---forage_resource: LSP types---

---Unique identificator for forage_resource entity
---@class (exact) forage_resource_id : table
---@field is_forage_resource number
---@class (exact) fat_forage_resource_id
---@field id forage_resource_id Unique forage_resource id
---@field name string 
---@field description string 
---@field icon string 
---@field handle JOBTYPE 

---@class struct_forage_resource
---@field handle JOBTYPE 

---@class (exact) forage_resource_id_data_blob_definition
---@field name string 
---@field description string 
---@field icon string 
---@field handle JOBTYPE 
---Sets values of forage_resource for given id
---@param id forage_resource_id
---@param data forage_resource_id_data_blob_definition
function DATA.setup_forage_resource(id, data)
    DATA.forage_resource_set_name(id, data.name)
    DATA.forage_resource_set_description(id, data.description)
    DATA.forage_resource_set_icon(id, data.icon)
    DATA.forage_resource_set_handle(id, data.handle)
end

ffi.cdef[[
void dcon_forage_resource_set_handle(int32_t, uint8_t);
uint8_t dcon_forage_resource_get_handle(int32_t);
int32_t dcon_create_forage_resource();
bool dcon_forage_resource_is_valid(int32_t);
void dcon_forage_resource_resize(uint32_t sz);
uint32_t dcon_forage_resource_size();
]]

---forage_resource: FFI arrays---
---@type (string)[]
DATA.forage_resource_name= {}
---@type (string)[]
DATA.forage_resource_description= {}
---@type (string)[]
DATA.forage_resource_icon= {}

---forage_resource: LUA bindings---

DATA.forage_resource_size = 10
---@return forage_resource_id
function DATA.create_forage_resource()
    ---@type forage_resource_id
    local i  = DCON.dcon_create_forage_resource() + 1
    return i --[[@as forage_resource_id]] 
end
---@param func fun(item: forage_resource_id) 
function DATA.for_each_forage_resource(func)
    ---@type number
    local range = DCON.dcon_forage_resource_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as forage_resource_id]])
    end
end
---@param func fun(item: forage_resource_id):boolean 
---@return table<forage_resource_id, forage_resource_id> 
function DATA.filter_forage_resource(func)
    ---@type table<forage_resource_id, forage_resource_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_forage_resource_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as forage_resource_id]]) then t[i + 1 --[[@as forage_resource_id]]] = t[i + 1 --[[@as forage_resource_id]]] end
    end
    return t
end

---@param forage_resource_id forage_resource_id valid forage_resource id
---@return string name 
function DATA.forage_resource_get_name(forage_resource_id)
    return DATA.forage_resource_name[forage_resource_id]
end
---@param forage_resource_id forage_resource_id valid forage_resource id
---@param value string valid string
function DATA.forage_resource_set_name(forage_resource_id, value)
    DATA.forage_resource_name[forage_resource_id] = value
end
---@param forage_resource_id forage_resource_id valid forage_resource id
---@return string description 
function DATA.forage_resource_get_description(forage_resource_id)
    return DATA.forage_resource_description[forage_resource_id]
end
---@param forage_resource_id forage_resource_id valid forage_resource id
---@param value string valid string
function DATA.forage_resource_set_description(forage_resource_id, value)
    DATA.forage_resource_description[forage_resource_id] = value
end
---@param forage_resource_id forage_resource_id valid forage_resource id
---@return string icon 
function DATA.forage_resource_get_icon(forage_resource_id)
    return DATA.forage_resource_icon[forage_resource_id]
end
---@param forage_resource_id forage_resource_id valid forage_resource id
---@param value string valid string
function DATA.forage_resource_set_icon(forage_resource_id, value)
    DATA.forage_resource_icon[forage_resource_id] = value
end
---@param forage_resource_id forage_resource_id valid forage_resource id
---@return JOBTYPE handle 
function DATA.forage_resource_get_handle(forage_resource_id)
    return DCON.dcon_forage_resource_get_handle(forage_resource_id - 1)
end
---@param forage_resource_id forage_resource_id valid forage_resource id
---@param value JOBTYPE valid JOBTYPE
function DATA.forage_resource_set_handle(forage_resource_id, value)
    DCON.dcon_forage_resource_set_handle(forage_resource_id - 1, value)
end

local fat_forage_resource_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.forage_resource_get_name(t.id) end
        if (k == "description") then return DATA.forage_resource_get_description(t.id) end
        if (k == "icon") then return DATA.forage_resource_get_icon(t.id) end
        if (k == "handle") then return DATA.forage_resource_get_handle(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.forage_resource_set_name(t.id, v)
            return
        end
        if (k == "description") then
            DATA.forage_resource_set_description(t.id, v)
            return
        end
        if (k == "icon") then
            DATA.forage_resource_set_icon(t.id, v)
            return
        end
        if (k == "handle") then
            DATA.forage_resource_set_handle(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id forage_resource_id
---@return fat_forage_resource_id fat_id
function DATA.fatten_forage_resource(id)
    local result = {id = id}
    setmetatable(result, fat_forage_resource_id_metatable)
    return result --[[@as fat_forage_resource_id]]
end
---@enum FORAGE_RESOURCE
FORAGE_RESOURCE = {
    INVALID = 0,
    WATER = 1,
    FRUIT = 2,
    GRAIN = 3,
    GAME = 4,
    FUNGI = 5,
    SHELL = 6,
    FISH = 7,
    WOOD = 8,
}
local index_forage_resource
index_forage_resource = DATA.create_forage_resource()
DATA.forage_resource_set_name(index_forage_resource, "Water")
DATA.forage_resource_set_description(index_forage_resource, "water")
DATA.forage_resource_set_icon(index_forage_resource, "droplets.png")
DATA.forage_resource_set_handle(index_forage_resource, JOBTYPE.HAULING)
index_forage_resource = DATA.create_forage_resource()
DATA.forage_resource_set_name(index_forage_resource, "Fruit")
DATA.forage_resource_set_description(index_forage_resource, "berries")
DATA.forage_resource_set_icon(index_forage_resource, "berries-bowl.png")
DATA.forage_resource_set_handle(index_forage_resource, JOBTYPE.FORAGER)
index_forage_resource = DATA.create_forage_resource()
DATA.forage_resource_set_name(index_forage_resource, "Grain")
DATA.forage_resource_set_description(index_forage_resource, "seeds")
DATA.forage_resource_set_icon(index_forage_resource, "wheat.png")
DATA.forage_resource_set_handle(index_forage_resource, JOBTYPE.FARMER)
index_forage_resource = DATA.create_forage_resource()
DATA.forage_resource_set_name(index_forage_resource, "Game")
DATA.forage_resource_set_description(index_forage_resource, "game")
DATA.forage_resource_set_icon(index_forage_resource, "bison.png")
DATA.forage_resource_set_handle(index_forage_resource, JOBTYPE.HUNTING)
index_forage_resource = DATA.create_forage_resource()
DATA.forage_resource_set_name(index_forage_resource, "Fungi")
DATA.forage_resource_set_description(index_forage_resource, "mushrooms")
DATA.forage_resource_set_icon(index_forage_resource, "chanterelles.png")
DATA.forage_resource_set_handle(index_forage_resource, JOBTYPE.CLERK)
index_forage_resource = DATA.create_forage_resource()
DATA.forage_resource_set_name(index_forage_resource, "Shell")
DATA.forage_resource_set_description(index_forage_resource, "shellfish")
DATA.forage_resource_set_icon(index_forage_resource, "oyster.png")
DATA.forage_resource_set_handle(index_forage_resource, JOBTYPE.HAULING)
index_forage_resource = DATA.create_forage_resource()
DATA.forage_resource_set_name(index_forage_resource, "Fish")
DATA.forage_resource_set_description(index_forage_resource, "fish")
DATA.forage_resource_set_icon(index_forage_resource, "salmon.png")
DATA.forage_resource_set_handle(index_forage_resource, JOBTYPE.LABOURER)
index_forage_resource = DATA.create_forage_resource()
DATA.forage_resource_set_name(index_forage_resource, "Wood")
DATA.forage_resource_set_description(index_forage_resource, "timber")
DATA.forage_resource_set_icon(index_forage_resource, "pine-tree.png")
DATA.forage_resource_set_handle(index_forage_resource, JOBTYPE.ARTISAN)
