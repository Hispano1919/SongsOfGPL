local ffi = require("ffi")
----------bedrock----------


---bedrock: LSP types---

---Unique identificator for bedrock entity
---@class (exact) bedrock_id : table
---@field is_bedrock number
---@class (exact) fat_bedrock_id
---@field id bedrock_id Unique bedrock id
---@field name string 
---@field r number 
---@field g number 
---@field b number 
---@field color_id number 
---@field sand number 
---@field silt number 
---@field clay number 
---@field organics number 
---@field minerals number 
---@field weathering number 
---@field grain_size number 
---@field acidity number 
---@field igneous_extrusive boolean 
---@field igneous_intrusive boolean 
---@field sedimentary boolean 
---@field clastic boolean 
---@field evaporative boolean 
---@field metamorphic_marble boolean 
---@field metamorphic_slate boolean 
---@field oceanic boolean 
---@field sedimentary_ocean_deep boolean 
---@field sedimentary_ocean_shallow boolean 

---@class struct_bedrock
---@field r number 
---@field g number 
---@field b number 
---@field color_id number 
---@field sand number 
---@field silt number 
---@field clay number 
---@field organics number 
---@field minerals number 
---@field weathering number 
---@field grain_size number 
---@field acidity number 
---@field igneous_extrusive boolean 
---@field igneous_intrusive boolean 
---@field sedimentary boolean 
---@field clastic boolean 
---@field evaporative boolean 
---@field metamorphic_marble boolean 
---@field metamorphic_slate boolean 
---@field oceanic boolean 
---@field sedimentary_ocean_deep boolean 
---@field sedimentary_ocean_shallow boolean 

---@class (exact) bedrock_id_data_blob_definition
---@field name string 
---@field r number 
---@field g number 
---@field b number 
---@field sand number 
---@field silt number 
---@field clay number 
---@field organics number 
---@field minerals number 
---@field weathering number 
---@field grain_size number? 
---@field acidity number? 
---@field igneous_extrusive boolean? 
---@field igneous_intrusive boolean? 
---@field sedimentary boolean? 
---@field clastic boolean? 
---@field evaporative boolean? 
---@field metamorphic_marble boolean? 
---@field metamorphic_slate boolean? 
---@field oceanic boolean? 
---@field sedimentary_ocean_deep boolean? 
---@field sedimentary_ocean_shallow boolean? 
---Sets values of bedrock for given id
---@param id bedrock_id
---@param data bedrock_id_data_blob_definition
function DATA.setup_bedrock(id, data)
    DATA.bedrock_set_grain_size(id, 0.0)
    DATA.bedrock_set_acidity(id, 0.0)
    DATA.bedrock_set_igneous_extrusive(id, false)
    DATA.bedrock_set_igneous_intrusive(id, false)
    DATA.bedrock_set_sedimentary(id, false)
    DATA.bedrock_set_clastic(id, false)
    DATA.bedrock_set_evaporative(id, false)
    DATA.bedrock_set_metamorphic_marble(id, false)
    DATA.bedrock_set_metamorphic_slate(id, false)
    DATA.bedrock_set_oceanic(id, false)
    DATA.bedrock_set_sedimentary_ocean_deep(id, false)
    DATA.bedrock_set_sedimentary_ocean_shallow(id, false)
    DATA.bedrock_set_name(id, data.name)
    DATA.bedrock_set_r(id, data.r)
    DATA.bedrock_set_g(id, data.g)
    DATA.bedrock_set_b(id, data.b)
    DATA.bedrock_set_sand(id, data.sand)
    DATA.bedrock_set_silt(id, data.silt)
    DATA.bedrock_set_clay(id, data.clay)
    DATA.bedrock_set_organics(id, data.organics)
    DATA.bedrock_set_minerals(id, data.minerals)
    DATA.bedrock_set_weathering(id, data.weathering)
    if data.grain_size ~= nil then
        DATA.bedrock_set_grain_size(id, data.grain_size)
    end
    if data.acidity ~= nil then
        DATA.bedrock_set_acidity(id, data.acidity)
    end
    if data.igneous_extrusive ~= nil then
        DATA.bedrock_set_igneous_extrusive(id, data.igneous_extrusive)
    end
    if data.igneous_intrusive ~= nil then
        DATA.bedrock_set_igneous_intrusive(id, data.igneous_intrusive)
    end
    if data.sedimentary ~= nil then
        DATA.bedrock_set_sedimentary(id, data.sedimentary)
    end
    if data.clastic ~= nil then
        DATA.bedrock_set_clastic(id, data.clastic)
    end
    if data.evaporative ~= nil then
        DATA.bedrock_set_evaporative(id, data.evaporative)
    end
    if data.metamorphic_marble ~= nil then
        DATA.bedrock_set_metamorphic_marble(id, data.metamorphic_marble)
    end
    if data.metamorphic_slate ~= nil then
        DATA.bedrock_set_metamorphic_slate(id, data.metamorphic_slate)
    end
    if data.oceanic ~= nil then
        DATA.bedrock_set_oceanic(id, data.oceanic)
    end
    if data.sedimentary_ocean_deep ~= nil then
        DATA.bedrock_set_sedimentary_ocean_deep(id, data.sedimentary_ocean_deep)
    end
    if data.sedimentary_ocean_shallow ~= nil then
        DATA.bedrock_set_sedimentary_ocean_shallow(id, data.sedimentary_ocean_shallow)
    end
end

ffi.cdef[[
void dcon_bedrock_set_r(int32_t, float);
float dcon_bedrock_get_r(int32_t);
void dcon_bedrock_set_g(int32_t, float);
float dcon_bedrock_get_g(int32_t);
void dcon_bedrock_set_b(int32_t, float);
float dcon_bedrock_get_b(int32_t);
void dcon_bedrock_set_color_id(int32_t, uint32_t);
uint32_t dcon_bedrock_get_color_id(int32_t);
void dcon_bedrock_set_sand(int32_t, float);
float dcon_bedrock_get_sand(int32_t);
void dcon_bedrock_set_silt(int32_t, float);
float dcon_bedrock_get_silt(int32_t);
void dcon_bedrock_set_clay(int32_t, float);
float dcon_bedrock_get_clay(int32_t);
void dcon_bedrock_set_organics(int32_t, float);
float dcon_bedrock_get_organics(int32_t);
void dcon_bedrock_set_minerals(int32_t, float);
float dcon_bedrock_get_minerals(int32_t);
void dcon_bedrock_set_weathering(int32_t, float);
float dcon_bedrock_get_weathering(int32_t);
void dcon_bedrock_set_grain_size(int32_t, float);
float dcon_bedrock_get_grain_size(int32_t);
void dcon_bedrock_set_acidity(int32_t, float);
float dcon_bedrock_get_acidity(int32_t);
void dcon_bedrock_set_igneous_extrusive(int32_t, bool);
bool dcon_bedrock_get_igneous_extrusive(int32_t);
void dcon_bedrock_set_igneous_intrusive(int32_t, bool);
bool dcon_bedrock_get_igneous_intrusive(int32_t);
void dcon_bedrock_set_sedimentary(int32_t, bool);
bool dcon_bedrock_get_sedimentary(int32_t);
void dcon_bedrock_set_clastic(int32_t, bool);
bool dcon_bedrock_get_clastic(int32_t);
void dcon_bedrock_set_evaporative(int32_t, bool);
bool dcon_bedrock_get_evaporative(int32_t);
void dcon_bedrock_set_metamorphic_marble(int32_t, bool);
bool dcon_bedrock_get_metamorphic_marble(int32_t);
void dcon_bedrock_set_metamorphic_slate(int32_t, bool);
bool dcon_bedrock_get_metamorphic_slate(int32_t);
void dcon_bedrock_set_oceanic(int32_t, bool);
bool dcon_bedrock_get_oceanic(int32_t);
void dcon_bedrock_set_sedimentary_ocean_deep(int32_t, bool);
bool dcon_bedrock_get_sedimentary_ocean_deep(int32_t);
void dcon_bedrock_set_sedimentary_ocean_shallow(int32_t, bool);
bool dcon_bedrock_get_sedimentary_ocean_shallow(int32_t);
int32_t dcon_create_bedrock();
bool dcon_bedrock_is_valid(int32_t);
void dcon_bedrock_resize(uint32_t sz);
uint32_t dcon_bedrock_size();
]]

---bedrock: FFI arrays---
---@type (string)[]
DATA.bedrock_name= {}

---bedrock: LUA bindings---

DATA.bedrock_size = 150
---@return bedrock_id
function DATA.create_bedrock()
    ---@type bedrock_id
    local i  = DCON.dcon_create_bedrock() + 1
    return i --[[@as bedrock_id]] 
end
---@param func fun(item: bedrock_id) 
function DATA.for_each_bedrock(func)
    ---@type number
    local range = DCON.dcon_bedrock_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as bedrock_id]])
    end
end
---@param func fun(item: bedrock_id):boolean 
---@return table<bedrock_id, bedrock_id> 
function DATA.filter_bedrock(func)
    ---@type table<bedrock_id, bedrock_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_bedrock_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as bedrock_id]]) then t[i + 1 --[[@as bedrock_id]]] = t[i + 1 --[[@as bedrock_id]]] end
    end
    return t
end

---@param bedrock_id bedrock_id valid bedrock id
---@return string name 
function DATA.bedrock_get_name(bedrock_id)
    return DATA.bedrock_name[bedrock_id]
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value string valid string
function DATA.bedrock_set_name(bedrock_id, value)
    DATA.bedrock_name[bedrock_id] = value
end
---@param bedrock_id bedrock_id valid bedrock id
---@return number r 
function DATA.bedrock_get_r(bedrock_id)
    return DCON.dcon_bedrock_get_r(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_set_r(bedrock_id, value)
    DCON.dcon_bedrock_set_r(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_inc_r(bedrock_id, value)
    ---@type number
    local current = DCON.dcon_bedrock_get_r(bedrock_id - 1)
    DCON.dcon_bedrock_set_r(bedrock_id - 1, current + value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return number g 
function DATA.bedrock_get_g(bedrock_id)
    return DCON.dcon_bedrock_get_g(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_set_g(bedrock_id, value)
    DCON.dcon_bedrock_set_g(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_inc_g(bedrock_id, value)
    ---@type number
    local current = DCON.dcon_bedrock_get_g(bedrock_id - 1)
    DCON.dcon_bedrock_set_g(bedrock_id - 1, current + value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return number b 
function DATA.bedrock_get_b(bedrock_id)
    return DCON.dcon_bedrock_get_b(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_set_b(bedrock_id, value)
    DCON.dcon_bedrock_set_b(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_inc_b(bedrock_id, value)
    ---@type number
    local current = DCON.dcon_bedrock_get_b(bedrock_id - 1)
    DCON.dcon_bedrock_set_b(bedrock_id - 1, current + value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return number color_id 
function DATA.bedrock_get_color_id(bedrock_id)
    return DCON.dcon_bedrock_get_color_id(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_set_color_id(bedrock_id, value)
    DCON.dcon_bedrock_set_color_id(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_inc_color_id(bedrock_id, value)
    ---@type number
    local current = DCON.dcon_bedrock_get_color_id(bedrock_id - 1)
    DCON.dcon_bedrock_set_color_id(bedrock_id - 1, current + value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return number sand 
function DATA.bedrock_get_sand(bedrock_id)
    return DCON.dcon_bedrock_get_sand(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_set_sand(bedrock_id, value)
    DCON.dcon_bedrock_set_sand(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_inc_sand(bedrock_id, value)
    ---@type number
    local current = DCON.dcon_bedrock_get_sand(bedrock_id - 1)
    DCON.dcon_bedrock_set_sand(bedrock_id - 1, current + value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return number silt 
function DATA.bedrock_get_silt(bedrock_id)
    return DCON.dcon_bedrock_get_silt(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_set_silt(bedrock_id, value)
    DCON.dcon_bedrock_set_silt(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_inc_silt(bedrock_id, value)
    ---@type number
    local current = DCON.dcon_bedrock_get_silt(bedrock_id - 1)
    DCON.dcon_bedrock_set_silt(bedrock_id - 1, current + value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return number clay 
function DATA.bedrock_get_clay(bedrock_id)
    return DCON.dcon_bedrock_get_clay(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_set_clay(bedrock_id, value)
    DCON.dcon_bedrock_set_clay(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_inc_clay(bedrock_id, value)
    ---@type number
    local current = DCON.dcon_bedrock_get_clay(bedrock_id - 1)
    DCON.dcon_bedrock_set_clay(bedrock_id - 1, current + value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return number organics 
function DATA.bedrock_get_organics(bedrock_id)
    return DCON.dcon_bedrock_get_organics(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_set_organics(bedrock_id, value)
    DCON.dcon_bedrock_set_organics(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_inc_organics(bedrock_id, value)
    ---@type number
    local current = DCON.dcon_bedrock_get_organics(bedrock_id - 1)
    DCON.dcon_bedrock_set_organics(bedrock_id - 1, current + value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return number minerals 
function DATA.bedrock_get_minerals(bedrock_id)
    return DCON.dcon_bedrock_get_minerals(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_set_minerals(bedrock_id, value)
    DCON.dcon_bedrock_set_minerals(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_inc_minerals(bedrock_id, value)
    ---@type number
    local current = DCON.dcon_bedrock_get_minerals(bedrock_id - 1)
    DCON.dcon_bedrock_set_minerals(bedrock_id - 1, current + value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return number weathering 
function DATA.bedrock_get_weathering(bedrock_id)
    return DCON.dcon_bedrock_get_weathering(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_set_weathering(bedrock_id, value)
    DCON.dcon_bedrock_set_weathering(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_inc_weathering(bedrock_id, value)
    ---@type number
    local current = DCON.dcon_bedrock_get_weathering(bedrock_id - 1)
    DCON.dcon_bedrock_set_weathering(bedrock_id - 1, current + value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return number grain_size 
function DATA.bedrock_get_grain_size(bedrock_id)
    return DCON.dcon_bedrock_get_grain_size(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_set_grain_size(bedrock_id, value)
    DCON.dcon_bedrock_set_grain_size(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_inc_grain_size(bedrock_id, value)
    ---@type number
    local current = DCON.dcon_bedrock_get_grain_size(bedrock_id - 1)
    DCON.dcon_bedrock_set_grain_size(bedrock_id - 1, current + value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return number acidity 
function DATA.bedrock_get_acidity(bedrock_id)
    return DCON.dcon_bedrock_get_acidity(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_set_acidity(bedrock_id, value)
    DCON.dcon_bedrock_set_acidity(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value number valid number
function DATA.bedrock_inc_acidity(bedrock_id, value)
    ---@type number
    local current = DCON.dcon_bedrock_get_acidity(bedrock_id - 1)
    DCON.dcon_bedrock_set_acidity(bedrock_id - 1, current + value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return boolean igneous_extrusive 
function DATA.bedrock_get_igneous_extrusive(bedrock_id)
    return DCON.dcon_bedrock_get_igneous_extrusive(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value boolean valid boolean
function DATA.bedrock_set_igneous_extrusive(bedrock_id, value)
    DCON.dcon_bedrock_set_igneous_extrusive(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return boolean igneous_intrusive 
function DATA.bedrock_get_igneous_intrusive(bedrock_id)
    return DCON.dcon_bedrock_get_igneous_intrusive(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value boolean valid boolean
function DATA.bedrock_set_igneous_intrusive(bedrock_id, value)
    DCON.dcon_bedrock_set_igneous_intrusive(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return boolean sedimentary 
function DATA.bedrock_get_sedimentary(bedrock_id)
    return DCON.dcon_bedrock_get_sedimentary(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value boolean valid boolean
function DATA.bedrock_set_sedimentary(bedrock_id, value)
    DCON.dcon_bedrock_set_sedimentary(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return boolean clastic 
function DATA.bedrock_get_clastic(bedrock_id)
    return DCON.dcon_bedrock_get_clastic(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value boolean valid boolean
function DATA.bedrock_set_clastic(bedrock_id, value)
    DCON.dcon_bedrock_set_clastic(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return boolean evaporative 
function DATA.bedrock_get_evaporative(bedrock_id)
    return DCON.dcon_bedrock_get_evaporative(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value boolean valid boolean
function DATA.bedrock_set_evaporative(bedrock_id, value)
    DCON.dcon_bedrock_set_evaporative(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return boolean metamorphic_marble 
function DATA.bedrock_get_metamorphic_marble(bedrock_id)
    return DCON.dcon_bedrock_get_metamorphic_marble(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value boolean valid boolean
function DATA.bedrock_set_metamorphic_marble(bedrock_id, value)
    DCON.dcon_bedrock_set_metamorphic_marble(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return boolean metamorphic_slate 
function DATA.bedrock_get_metamorphic_slate(bedrock_id)
    return DCON.dcon_bedrock_get_metamorphic_slate(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value boolean valid boolean
function DATA.bedrock_set_metamorphic_slate(bedrock_id, value)
    DCON.dcon_bedrock_set_metamorphic_slate(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return boolean oceanic 
function DATA.bedrock_get_oceanic(bedrock_id)
    return DCON.dcon_bedrock_get_oceanic(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value boolean valid boolean
function DATA.bedrock_set_oceanic(bedrock_id, value)
    DCON.dcon_bedrock_set_oceanic(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return boolean sedimentary_ocean_deep 
function DATA.bedrock_get_sedimentary_ocean_deep(bedrock_id)
    return DCON.dcon_bedrock_get_sedimentary_ocean_deep(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value boolean valid boolean
function DATA.bedrock_set_sedimentary_ocean_deep(bedrock_id, value)
    DCON.dcon_bedrock_set_sedimentary_ocean_deep(bedrock_id - 1, value)
end
---@param bedrock_id bedrock_id valid bedrock id
---@return boolean sedimentary_ocean_shallow 
function DATA.bedrock_get_sedimentary_ocean_shallow(bedrock_id)
    return DCON.dcon_bedrock_get_sedimentary_ocean_shallow(bedrock_id - 1)
end
---@param bedrock_id bedrock_id valid bedrock id
---@param value boolean valid boolean
function DATA.bedrock_set_sedimentary_ocean_shallow(bedrock_id, value)
    DCON.dcon_bedrock_set_sedimentary_ocean_shallow(bedrock_id - 1, value)
end

local fat_bedrock_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.bedrock_get_name(t.id) end
        if (k == "r") then return DATA.bedrock_get_r(t.id) end
        if (k == "g") then return DATA.bedrock_get_g(t.id) end
        if (k == "b") then return DATA.bedrock_get_b(t.id) end
        if (k == "color_id") then return DATA.bedrock_get_color_id(t.id) end
        if (k == "sand") then return DATA.bedrock_get_sand(t.id) end
        if (k == "silt") then return DATA.bedrock_get_silt(t.id) end
        if (k == "clay") then return DATA.bedrock_get_clay(t.id) end
        if (k == "organics") then return DATA.bedrock_get_organics(t.id) end
        if (k == "minerals") then return DATA.bedrock_get_minerals(t.id) end
        if (k == "weathering") then return DATA.bedrock_get_weathering(t.id) end
        if (k == "grain_size") then return DATA.bedrock_get_grain_size(t.id) end
        if (k == "acidity") then return DATA.bedrock_get_acidity(t.id) end
        if (k == "igneous_extrusive") then return DATA.bedrock_get_igneous_extrusive(t.id) end
        if (k == "igneous_intrusive") then return DATA.bedrock_get_igneous_intrusive(t.id) end
        if (k == "sedimentary") then return DATA.bedrock_get_sedimentary(t.id) end
        if (k == "clastic") then return DATA.bedrock_get_clastic(t.id) end
        if (k == "evaporative") then return DATA.bedrock_get_evaporative(t.id) end
        if (k == "metamorphic_marble") then return DATA.bedrock_get_metamorphic_marble(t.id) end
        if (k == "metamorphic_slate") then return DATA.bedrock_get_metamorphic_slate(t.id) end
        if (k == "oceanic") then return DATA.bedrock_get_oceanic(t.id) end
        if (k == "sedimentary_ocean_deep") then return DATA.bedrock_get_sedimentary_ocean_deep(t.id) end
        if (k == "sedimentary_ocean_shallow") then return DATA.bedrock_get_sedimentary_ocean_shallow(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.bedrock_set_name(t.id, v)
            return
        end
        if (k == "r") then
            DATA.bedrock_set_r(t.id, v)
            return
        end
        if (k == "g") then
            DATA.bedrock_set_g(t.id, v)
            return
        end
        if (k == "b") then
            DATA.bedrock_set_b(t.id, v)
            return
        end
        if (k == "color_id") then
            DATA.bedrock_set_color_id(t.id, v)
            return
        end
        if (k == "sand") then
            DATA.bedrock_set_sand(t.id, v)
            return
        end
        if (k == "silt") then
            DATA.bedrock_set_silt(t.id, v)
            return
        end
        if (k == "clay") then
            DATA.bedrock_set_clay(t.id, v)
            return
        end
        if (k == "organics") then
            DATA.bedrock_set_organics(t.id, v)
            return
        end
        if (k == "minerals") then
            DATA.bedrock_set_minerals(t.id, v)
            return
        end
        if (k == "weathering") then
            DATA.bedrock_set_weathering(t.id, v)
            return
        end
        if (k == "grain_size") then
            DATA.bedrock_set_grain_size(t.id, v)
            return
        end
        if (k == "acidity") then
            DATA.bedrock_set_acidity(t.id, v)
            return
        end
        if (k == "igneous_extrusive") then
            DATA.bedrock_set_igneous_extrusive(t.id, v)
            return
        end
        if (k == "igneous_intrusive") then
            DATA.bedrock_set_igneous_intrusive(t.id, v)
            return
        end
        if (k == "sedimentary") then
            DATA.bedrock_set_sedimentary(t.id, v)
            return
        end
        if (k == "clastic") then
            DATA.bedrock_set_clastic(t.id, v)
            return
        end
        if (k == "evaporative") then
            DATA.bedrock_set_evaporative(t.id, v)
            return
        end
        if (k == "metamorphic_marble") then
            DATA.bedrock_set_metamorphic_marble(t.id, v)
            return
        end
        if (k == "metamorphic_slate") then
            DATA.bedrock_set_metamorphic_slate(t.id, v)
            return
        end
        if (k == "oceanic") then
            DATA.bedrock_set_oceanic(t.id, v)
            return
        end
        if (k == "sedimentary_ocean_deep") then
            DATA.bedrock_set_sedimentary_ocean_deep(t.id, v)
            return
        end
        if (k == "sedimentary_ocean_shallow") then
            DATA.bedrock_set_sedimentary_ocean_shallow(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id bedrock_id
---@return fat_bedrock_id fat_id
function DATA.fatten_bedrock(id)
    local result = {id = id}
    setmetatable(result, fat_bedrock_id_metatable)
    return result --[[@as fat_bedrock_id]]
end
