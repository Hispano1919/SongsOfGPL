local ffi = require("ffi")
----------employment----------


---employment: LSP types---

---Unique identificator for employment entity
---@class (exact) employment_id : table
---@field is_employment number
---@class (exact) fat_employment_id
---@field id employment_id Unique employment id
---@field worker_income number 
---@field job job_id 
---@field building building_id 
---@field worker pop_id 

---@class struct_employment
---@field worker_income number 
---@field job job_id 


ffi.cdef[[
void dcon_employment_set_worker_income(int32_t, float);
float dcon_employment_get_worker_income(int32_t);
void dcon_employment_set_job(int32_t, int32_t);
int32_t dcon_employment_get_job(int32_t);
void dcon_delete_employment(int32_t j);
int32_t dcon_force_create_employment(int32_t building, int32_t worker);
void dcon_employment_set_building(int32_t, int32_t);
int32_t dcon_employment_get_building(int32_t);
int32_t dcon_building_get_range_employment_as_building(int32_t);
int32_t dcon_building_get_index_employment_as_building(int32_t, int32_t);
void dcon_employment_set_worker(int32_t, int32_t);
int32_t dcon_employment_get_worker(int32_t);
int32_t dcon_pop_get_employment_as_worker(int32_t);
bool dcon_employment_is_valid(int32_t);
void dcon_employment_resize(uint32_t sz);
uint32_t dcon_employment_size();
]]

---employment: FFI arrays---

---employment: LUA bindings---

DATA.employment_size = 300000
---@param building building_id
---@param worker pop_id
---@return employment_id
function DATA.force_create_employment(building, worker)
    ---@type employment_id
    local i = DCON.dcon_force_create_employment(building - 1, worker - 1) + 1
    return i --[[@as employment_id]] 
end
---@param i employment_id
function DATA.delete_employment(i)
    assert(DCON.dcon_employment_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_employment(i - 1)
end
---@param func fun(item: employment_id) 
function DATA.for_each_employment(func)
    ---@type number
    local range = DCON.dcon_employment_size()
    for i = 0, range - 1 do
        if DCON.dcon_employment_is_valid(i) then func(i + 1 --[[@as employment_id]]) end
    end
end
---@param func fun(item: employment_id):boolean 
---@return table<employment_id, employment_id> 
function DATA.filter_employment(func)
    ---@type table<employment_id, employment_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_employment_size()
    for i = 0, range - 1 do
        if DCON.dcon_employment_is_valid(i) and func(i + 1 --[[@as employment_id]]) then t[i + 1 --[[@as employment_id]]] = i + 1 --[[@as employment_id]] end
    end
    return t
end

---@param employment_id employment_id valid employment id
---@return number worker_income 
function DATA.employment_get_worker_income(employment_id)
    return DCON.dcon_employment_get_worker_income(employment_id - 1)
end
---@param employment_id employment_id valid employment id
---@param value number valid number
function DATA.employment_set_worker_income(employment_id, value)
    DCON.dcon_employment_set_worker_income(employment_id - 1, value)
end
---@param employment_id employment_id valid employment id
---@param value number valid number
function DATA.employment_inc_worker_income(employment_id, value)
    ---@type number
    local current = DCON.dcon_employment_get_worker_income(employment_id - 1)
    DCON.dcon_employment_set_worker_income(employment_id - 1, current + value)
end
---@param employment_id employment_id valid employment id
---@return job_id job 
function DATA.employment_get_job(employment_id)
    return DCON.dcon_employment_get_job(employment_id - 1) + 1
end
---@param employment_id employment_id valid employment id
---@param value job_id valid job_id
function DATA.employment_set_job(employment_id, value)
    DCON.dcon_employment_set_job(employment_id - 1, value - 1)
end
---@param building employment_id valid building_id
---@return building_id Data retrieved from employment 
function DATA.employment_get_building(building)
    return DCON.dcon_employment_get_building(building - 1) + 1
end
---@param building building_id valid building_id
---@return employment_id[] An array of employment 
function DATA.get_employment_from_building(building)
    local result = {}
    DATA.for_each_employment_from_building(building, function(item) 
        table.insert(result, item)
    end)
    return result
end
---@param building building_id valid building_id
---@param func fun(item: employment_id) valid building_id
function DATA.for_each_employment_from_building(building, func)
    ---@type number
    local range = DCON.dcon_building_get_range_employment_as_building(building - 1)
    for i = 0, range - 1 do
        ---@type employment_id
        local accessed_element = DCON.dcon_building_get_index_employment_as_building(building - 1, i) + 1
        if DCON.dcon_employment_is_valid(accessed_element - 1) then func(accessed_element) end
    end
end
---@param building building_id valid building_id
---@param func fun(item: employment_id):boolean 
---@return employment_id[]
function DATA.filter_array_employment_from_building(building, func)
    ---@type table<employment_id, employment_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_building_get_range_employment_as_building(building - 1)
    for i = 0, range - 1 do
        ---@type employment_id
        local accessed_element = DCON.dcon_building_get_index_employment_as_building(building - 1, i) + 1
        if DCON.dcon_employment_is_valid(accessed_element - 1) and func(accessed_element) then table.insert(t, accessed_element) end
    end
    return t
end
---@param building building_id valid building_id
---@param func fun(item: employment_id):boolean 
---@return table<employment_id, employment_id> 
function DATA.filter_employment_from_building(building, func)
    ---@type table<employment_id, employment_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_building_get_range_employment_as_building(building - 1)
    for i = 0, range - 1 do
        ---@type employment_id
        local accessed_element = DCON.dcon_building_get_index_employment_as_building(building - 1, i) + 1
        if DCON.dcon_employment_is_valid(accessed_element - 1) and func(accessed_element) then t[accessed_element] = accessed_element end
    end
    return t
end
---@param employment_id employment_id valid employment id
---@param value building_id valid building_id
function DATA.employment_set_building(employment_id, value)
    DCON.dcon_employment_set_building(employment_id - 1, value - 1)
end
---@param worker employment_id valid pop_id
---@return pop_id Data retrieved from employment 
function DATA.employment_get_worker(worker)
    return DCON.dcon_employment_get_worker(worker - 1) + 1
end
---@param worker pop_id valid pop_id
---@return employment_id employment 
function DATA.get_employment_from_worker(worker)
    return DCON.dcon_pop_get_employment_as_worker(worker - 1) + 1
end
---@param employment_id employment_id valid employment id
---@param value pop_id valid pop_id
function DATA.employment_set_worker(employment_id, value)
    DCON.dcon_employment_set_worker(employment_id - 1, value - 1)
end

local fat_employment_id_metatable = {
    __index = function (t,k)
        if (k == "worker_income") then return DATA.employment_get_worker_income(t.id) end
        if (k == "job") then return DATA.employment_get_job(t.id) end
        if (k == "building") then return DATA.employment_get_building(t.id) end
        if (k == "worker") then return DATA.employment_get_worker(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "worker_income") then
            DATA.employment_set_worker_income(t.id, v)
            return
        end
        if (k == "job") then
            DATA.employment_set_job(t.id, v)
            return
        end
        if (k == "building") then
            DATA.employment_set_building(t.id, v)
            return
        end
        if (k == "worker") then
            DATA.employment_set_worker(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id employment_id
---@return fat_employment_id fat_id
function DATA.fatten_employment(id)
    local result = {id = id}
    setmetatable(result, fat_employment_id_metatable)
    return result --[[@as fat_employment_id]]
end
