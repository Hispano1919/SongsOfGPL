local ffi = require("ffi")
----------technology----------


---technology: LSP types---

---Unique identificator for technology entity
---@class (exact) technology_id : table
---@field is_technology number
---@class (exact) fat_technology_id
---@field id technology_id Unique technology id
---@field name string 
---@field icon string 
---@field description string 
---@field r number 
---@field g number 
---@field b number 
---@field research_cost number Amount of research points (education_endowment) per pop needed for the technology
---@field associated_job job_id The job that is needed to perform this research. Without it, the research odds will be significantly lower. We'll be using this to make technology implicitly tied to player decisions

---@class struct_technology
---@field r number 
---@field g number 
---@field b number 
---@field research_cost number Amount of research points (education_endowment) per pop needed for the technology
---@field required_biome table<number, biome_id> 
---@field required_resource table<number, resource_id> 
---@field associated_job job_id The job that is needed to perform this research. Without it, the research odds will be significantly lower. We'll be using this to make technology implicitly tied to player decisions
---@field throughput_boosts table<production_method_id, number> 
---@field input_efficiency_boosts table<production_method_id, number> 
---@field output_efficiency_boosts table<production_method_id, number> 

---@class (exact) technology_id_data_blob_definition
---@field name string 
---@field icon string 
---@field description string 
---@field r number 
---@field g number 
---@field b number 
---@field research_cost number Amount of research points (education_endowment) per pop needed for the technology
---@field required_biome biome_id[] 
---@field required_race race_id[] 
---@field required_resource resource_id[] 
---@field associated_job job_id The job that is needed to perform this research. Without it, the research odds will be significantly lower. We'll be using this to make technology implicitly tied to player decisions
---@field throughput_boosts table<production_method_id, number> 
---@field input_efficiency_boosts table<production_method_id, number> 
---@field output_efficiency_boosts table<production_method_id, number> 
---Sets values of technology for given id
---@param id technology_id
---@param data technology_id_data_blob_definition
function DATA.setup_technology(id, data)
    DATA.technology_set_name(id, data.name)
    DATA.technology_set_icon(id, data.icon)
    DATA.technology_set_description(id, data.description)
    DATA.technology_set_r(id, data.r)
    DATA.technology_set_g(id, data.g)
    DATA.technology_set_b(id, data.b)
    DATA.technology_set_research_cost(id, data.research_cost)
    for i, value in pairs(data.required_biome) do
        DATA.technology_set_required_biome(id, i, value)
    end
    for i, value in pairs(data.required_race) do
        DATA.technology_set_required_race(id, i, value)
    end
    for i, value in pairs(data.required_resource) do
        DATA.technology_set_required_resource(id, i, value)
    end
    DATA.technology_set_associated_job(id, data.associated_job)
    for i, value in pairs(data.throughput_boosts) do
        DATA.technology_set_throughput_boosts(id, i, value)
    end
    for i, value in pairs(data.input_efficiency_boosts) do
        DATA.technology_set_input_efficiency_boosts(id, i, value)
    end
    for i, value in pairs(data.output_efficiency_boosts) do
        DATA.technology_set_output_efficiency_boosts(id, i, value)
    end
end

ffi.cdef[[
void dcon_technology_set_r(int32_t, float);
float dcon_technology_get_r(int32_t);
void dcon_technology_set_g(int32_t, float);
float dcon_technology_get_g(int32_t);
void dcon_technology_set_b(int32_t, float);
float dcon_technology_get_b(int32_t);
void dcon_technology_set_research_cost(int32_t, float);
float dcon_technology_get_research_cost(int32_t);
void dcon_technology_resize_required_biome(uint32_t);
void dcon_technology_set_required_biome(int32_t, int32_t, int32_t);
int32_t dcon_technology_get_required_biome(int32_t, int32_t);
void dcon_technology_resize_required_resource(uint32_t);
void dcon_technology_set_required_resource(int32_t, int32_t, int32_t);
int32_t dcon_technology_get_required_resource(int32_t, int32_t);
void dcon_technology_set_associated_job(int32_t, int32_t);
int32_t dcon_technology_get_associated_job(int32_t);
void dcon_technology_resize_throughput_boosts(uint32_t);
void dcon_technology_set_throughput_boosts(int32_t, int32_t, float);
float dcon_technology_get_throughput_boosts(int32_t, int32_t);
void dcon_technology_resize_input_efficiency_boosts(uint32_t);
void dcon_technology_set_input_efficiency_boosts(int32_t, int32_t, float);
float dcon_technology_get_input_efficiency_boosts(int32_t, int32_t);
void dcon_technology_resize_output_efficiency_boosts(uint32_t);
void dcon_technology_set_output_efficiency_boosts(int32_t, int32_t, float);
float dcon_technology_get_output_efficiency_boosts(int32_t, int32_t);
int32_t dcon_create_technology();
bool dcon_technology_is_valid(int32_t);
void dcon_technology_resize(uint32_t sz);
uint32_t dcon_technology_size();
]]

---technology: FFI arrays---
---@type (string)[]
DATA.technology_name= {}
---@type (string)[]
DATA.technology_icon= {}
---@type (string)[]
DATA.technology_description= {}
---@type (table<number, race_id>)[]
DATA.technology_required_race= {}

---technology: LUA bindings---

DATA.technology_size = 400
DCON.dcon_technology_resize_required_biome(21)
DCON.dcon_technology_resize_required_resource(21)
DCON.dcon_technology_resize_throughput_boosts(251)
DCON.dcon_technology_resize_input_efficiency_boosts(251)
DCON.dcon_technology_resize_output_efficiency_boosts(251)
---@return technology_id
function DATA.create_technology()
    ---@type technology_id
    local i  = DCON.dcon_create_technology() + 1
    return i --[[@as technology_id]] 
end
---@param func fun(item: technology_id) 
function DATA.for_each_technology(func)
    ---@type number
    local range = DCON.dcon_technology_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as technology_id]])
    end
end
---@param func fun(item: technology_id):boolean 
---@return table<technology_id, technology_id> 
function DATA.filter_technology(func)
    ---@type table<technology_id, technology_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_technology_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as technology_id]]) then t[i + 1 --[[@as technology_id]]] = t[i + 1 --[[@as technology_id]]] end
    end
    return t
end

---@param technology_id technology_id valid technology id
---@return string name 
function DATA.technology_get_name(technology_id)
    return DATA.technology_name[technology_id]
end
---@param technology_id technology_id valid technology id
---@param value string valid string
function DATA.technology_set_name(technology_id, value)
    DATA.technology_name[technology_id] = value
end
---@param technology_id technology_id valid technology id
---@return string icon 
function DATA.technology_get_icon(technology_id)
    return DATA.technology_icon[technology_id]
end
---@param technology_id technology_id valid technology id
---@param value string valid string
function DATA.technology_set_icon(technology_id, value)
    DATA.technology_icon[technology_id] = value
end
---@param technology_id technology_id valid technology id
---@return string description 
function DATA.technology_get_description(technology_id)
    return DATA.technology_description[technology_id]
end
---@param technology_id technology_id valid technology id
---@param value string valid string
function DATA.technology_set_description(technology_id, value)
    DATA.technology_description[technology_id] = value
end
---@param technology_id technology_id valid technology id
---@return number r 
function DATA.technology_get_r(technology_id)
    return DCON.dcon_technology_get_r(technology_id - 1)
end
---@param technology_id technology_id valid technology id
---@param value number valid number
function DATA.technology_set_r(technology_id, value)
    DCON.dcon_technology_set_r(technology_id - 1, value)
end
---@param technology_id technology_id valid technology id
---@param value number valid number
function DATA.technology_inc_r(technology_id, value)
    ---@type number
    local current = DCON.dcon_technology_get_r(technology_id - 1)
    DCON.dcon_technology_set_r(technology_id - 1, current + value)
end
---@param technology_id technology_id valid technology id
---@return number g 
function DATA.technology_get_g(technology_id)
    return DCON.dcon_technology_get_g(technology_id - 1)
end
---@param technology_id technology_id valid technology id
---@param value number valid number
function DATA.technology_set_g(technology_id, value)
    DCON.dcon_technology_set_g(technology_id - 1, value)
end
---@param technology_id technology_id valid technology id
---@param value number valid number
function DATA.technology_inc_g(technology_id, value)
    ---@type number
    local current = DCON.dcon_technology_get_g(technology_id - 1)
    DCON.dcon_technology_set_g(technology_id - 1, current + value)
end
---@param technology_id technology_id valid technology id
---@return number b 
function DATA.technology_get_b(technology_id)
    return DCON.dcon_technology_get_b(technology_id - 1)
end
---@param technology_id technology_id valid technology id
---@param value number valid number
function DATA.technology_set_b(technology_id, value)
    DCON.dcon_technology_set_b(technology_id - 1, value)
end
---@param technology_id technology_id valid technology id
---@param value number valid number
function DATA.technology_inc_b(technology_id, value)
    ---@type number
    local current = DCON.dcon_technology_get_b(technology_id - 1)
    DCON.dcon_technology_set_b(technology_id - 1, current + value)
end
---@param technology_id technology_id valid technology id
---@return number research_cost Amount of research points (education_endowment) per pop needed for the technology
function DATA.technology_get_research_cost(technology_id)
    return DCON.dcon_technology_get_research_cost(technology_id - 1)
end
---@param technology_id technology_id valid technology id
---@param value number valid number
function DATA.technology_set_research_cost(technology_id, value)
    DCON.dcon_technology_set_research_cost(technology_id - 1, value)
end
---@param technology_id technology_id valid technology id
---@param value number valid number
function DATA.technology_inc_research_cost(technology_id, value)
    ---@type number
    local current = DCON.dcon_technology_get_research_cost(technology_id - 1)
    DCON.dcon_technology_set_research_cost(technology_id - 1, current + value)
end
---@param technology_id technology_id valid technology id
---@param index number valid
---@return biome_id required_biome 
function DATA.technology_get_required_biome(technology_id, index)
    assert(index ~= 0)
    return DCON.dcon_technology_get_required_biome(technology_id - 1, index - 1) + 1
end
---@param technology_id technology_id valid technology id
---@param index number valid index
---@param value biome_id valid biome_id
function DATA.technology_set_required_biome(technology_id, index, value)
    DCON.dcon_technology_set_required_biome(technology_id - 1, index - 1, value - 1)
end
---@param technology_id technology_id valid technology id
---@param index number valid
---@return race_id required_race 
function DATA.technology_get_required_race(technology_id, index)
    if DATA.technology_required_race[technology_id] == nil then return 0 end
    return DATA.technology_required_race[technology_id][index]
end
---@param technology_id technology_id valid technology id
---@param index number valid index
---@param value race_id valid race_id
function DATA.technology_set_required_race(technology_id, index, value)
    DATA.technology_required_race[technology_id][index] = value
end
---@param technology_id technology_id valid technology id
---@param index number valid
---@return resource_id required_resource 
function DATA.technology_get_required_resource(technology_id, index)
    assert(index ~= 0)
    return DCON.dcon_technology_get_required_resource(technology_id - 1, index - 1) + 1
end
---@param technology_id technology_id valid technology id
---@param index number valid index
---@param value resource_id valid resource_id
function DATA.technology_set_required_resource(technology_id, index, value)
    DCON.dcon_technology_set_required_resource(technology_id - 1, index - 1, value - 1)
end
---@param technology_id technology_id valid technology id
---@return job_id associated_job The job that is needed to perform this research. Without it, the research odds will be significantly lower. We'll be using this to make technology implicitly tied to player decisions
function DATA.technology_get_associated_job(technology_id)
    return DCON.dcon_technology_get_associated_job(technology_id - 1) + 1
end
---@param technology_id technology_id valid technology id
---@param value job_id valid job_id
function DATA.technology_set_associated_job(technology_id, value)
    DCON.dcon_technology_set_associated_job(technology_id - 1, value - 1)
end
---@param technology_id technology_id valid technology id
---@param index production_method_id valid
---@return number throughput_boosts 
function DATA.technology_get_throughput_boosts(technology_id, index)
    assert(index ~= 0)
    return DCON.dcon_technology_get_throughput_boosts(technology_id - 1, index - 1)
end
---@param technology_id technology_id valid technology id
---@param index production_method_id valid index
---@param value number valid number
function DATA.technology_set_throughput_boosts(technology_id, index, value)
    DCON.dcon_technology_set_throughput_boosts(technology_id - 1, index - 1, value)
end
---@param technology_id technology_id valid technology id
---@param index production_method_id valid index
---@param value number valid number
function DATA.technology_inc_throughput_boosts(technology_id, index, value)
    ---@type number
    local current = DCON.dcon_technology_get_throughput_boosts(technology_id - 1, index - 1)
    DCON.dcon_technology_set_throughput_boosts(technology_id - 1, index - 1, current + value)
end
---@param technology_id technology_id valid technology id
---@param index production_method_id valid
---@return number input_efficiency_boosts 
function DATA.technology_get_input_efficiency_boosts(technology_id, index)
    assert(index ~= 0)
    return DCON.dcon_technology_get_input_efficiency_boosts(technology_id - 1, index - 1)
end
---@param technology_id technology_id valid technology id
---@param index production_method_id valid index
---@param value number valid number
function DATA.technology_set_input_efficiency_boosts(technology_id, index, value)
    DCON.dcon_technology_set_input_efficiency_boosts(technology_id - 1, index - 1, value)
end
---@param technology_id technology_id valid technology id
---@param index production_method_id valid index
---@param value number valid number
function DATA.technology_inc_input_efficiency_boosts(technology_id, index, value)
    ---@type number
    local current = DCON.dcon_technology_get_input_efficiency_boosts(technology_id - 1, index - 1)
    DCON.dcon_technology_set_input_efficiency_boosts(technology_id - 1, index - 1, current + value)
end
---@param technology_id technology_id valid technology id
---@param index production_method_id valid
---@return number output_efficiency_boosts 
function DATA.technology_get_output_efficiency_boosts(technology_id, index)
    assert(index ~= 0)
    return DCON.dcon_technology_get_output_efficiency_boosts(technology_id - 1, index - 1)
end
---@param technology_id technology_id valid technology id
---@param index production_method_id valid index
---@param value number valid number
function DATA.technology_set_output_efficiency_boosts(technology_id, index, value)
    DCON.dcon_technology_set_output_efficiency_boosts(technology_id - 1, index - 1, value)
end
---@param technology_id technology_id valid technology id
---@param index production_method_id valid index
---@param value number valid number
function DATA.technology_inc_output_efficiency_boosts(technology_id, index, value)
    ---@type number
    local current = DCON.dcon_technology_get_output_efficiency_boosts(technology_id - 1, index - 1)
    DCON.dcon_technology_set_output_efficiency_boosts(technology_id - 1, index - 1, current + value)
end

local fat_technology_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.technology_get_name(t.id) end
        if (k == "icon") then return DATA.technology_get_icon(t.id) end
        if (k == "description") then return DATA.technology_get_description(t.id) end
        if (k == "r") then return DATA.technology_get_r(t.id) end
        if (k == "g") then return DATA.technology_get_g(t.id) end
        if (k == "b") then return DATA.technology_get_b(t.id) end
        if (k == "research_cost") then return DATA.technology_get_research_cost(t.id) end
        if (k == "associated_job") then return DATA.technology_get_associated_job(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.technology_set_name(t.id, v)
            return
        end
        if (k == "icon") then
            DATA.technology_set_icon(t.id, v)
            return
        end
        if (k == "description") then
            DATA.technology_set_description(t.id, v)
            return
        end
        if (k == "r") then
            DATA.technology_set_r(t.id, v)
            return
        end
        if (k == "g") then
            DATA.technology_set_g(t.id, v)
            return
        end
        if (k == "b") then
            DATA.technology_set_b(t.id, v)
            return
        end
        if (k == "research_cost") then
            DATA.technology_set_research_cost(t.id, v)
            return
        end
        if (k == "associated_job") then
            DATA.technology_set_associated_job(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id technology_id
---@return fat_technology_id fat_id
function DATA.fatten_technology(id)
    local result = {id = id}
    setmetatable(result, fat_technology_id_metatable)
    return result --[[@as fat_technology_id]]
end
