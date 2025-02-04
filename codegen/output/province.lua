local ffi = require("ffi")
----------province----------


---province: LSP types---

---Unique identificator for province entity
---@class (exact) province_id : table
---@field is_province number
---@class (exact) fat_province_id
---@field id province_id Unique province id
---@field name string 
---@field r number 
---@field g number 
---@field b number 
---@field is_land boolean 
---@field province_id number 
---@field size number 
---@field hydration number Number of humans that can live of off this provinces innate water
---@field movement_cost number 
---@field center tile_id The tile which contains this province's settlement, if there is any.
---@field infrastructure_needed number 
---@field infrastructure number 
---@field infrastructure_investment number 
---@field infrastructure_efficiency number 
---@field local_wealth number 
---@field trade_wealth number 
---@field local_income number 
---@field local_building_upkeep number 
---@field foragers number Keeps track of the number of foragers in the province. Used to calculate yields of independent foraging.
---@field foragers_water number amount foraged by pops and characters
---@field foragers_limit number amount of calories foraged by pops and characters
---@field forage_efficiency number 
---@field mood number how local population thinks about the state
---@field on_a_river boolean 
---@field on_a_forest boolean 

---@class struct_province
---@field r number 
---@field g number 
---@field b number 
---@field is_land boolean 
---@field province_id number 
---@field size number 
---@field hydration number Number of humans that can live of off this provinces innate water
---@field movement_cost number 
---@field center tile_id The tile which contains this province's settlement, if there is any.
---@field infrastructure_needed number 
---@field infrastructure number 
---@field infrastructure_investment number 
---@field infrastructure_efficiency number 
---@field technologies_present table<technology_id, number> 
---@field technologies_researchable table<technology_id, number> 
---@field buildable_buildings table<building_type_id, number> 
---@field local_production table<trade_good_id, number> 
---@field temp_buffer_0 table<trade_good_id, number> 
---@field local_consumption table<trade_good_id, number> 
---@field local_demand table<trade_good_id, number> 
---@field local_satisfaction table<trade_good_id, number> 
---@field temp_buffer_use_0 table<use_case_id, number> 
---@field temp_buffer_use_grad table<use_case_id, number> 
---@field local_use_satisfaction table<use_case_id, number> 
---@field local_use_buffer_demand table<use_case_id, number> 
---@field local_use_buffer_supply table<use_case_id, number> 
---@field local_use_buffer_cost table<use_case_id, number> 
---@field local_storage table<trade_good_id, number> 
---@field local_merchants_demand table<trade_good_id, number> 
---@field local_prices table<trade_good_id, number> 
---@field local_wealth number 
---@field trade_wealth number 
---@field local_income number 
---@field local_building_upkeep number 
---@field foragers number Keeps track of the number of foragers in the province. Used to calculate yields of independent foraging.
---@field foragers_water number amount foraged by pops and characters
---@field foragers_limit number amount of calories foraged by pops and characters
---@field forage_efficiency number 
---@field foragers_targets table<number, struct_forage_container> 
---@field local_resources table<number, struct_resource_location> An array of local resources and their positions
---@field total_resources table<resource_id, number> 
---@field used_resources table<resource_id, number> 
---@field mood number how local population thinks about the state
---@field unit_types table<unit_type_id, number> 
---@field throughput_boosts table<production_method_id, number> 
---@field input_efficiency_boosts table<production_method_id, number> 
---@field local_efficiency_boosts table<production_method_id, number> 
---@field output_efficiency_boosts table<production_method_id, number> 
---@field on_a_river boolean 
---@field on_a_forest boolean 


ffi.cdef[[
void dcon_province_set_r(int32_t, float);
float dcon_province_get_r(int32_t);
void dcon_province_set_g(int32_t, float);
float dcon_province_get_g(int32_t);
void dcon_province_set_b(int32_t, float);
float dcon_province_get_b(int32_t);
void dcon_province_set_is_land(int32_t, bool);
bool dcon_province_get_is_land(int32_t);
void dcon_province_set_province_id(int32_t, float);
float dcon_province_get_province_id(int32_t);
void dcon_province_set_size(int32_t, float);
float dcon_province_get_size(int32_t);
void dcon_province_set_hydration(int32_t, float);
float dcon_province_get_hydration(int32_t);
void dcon_province_set_movement_cost(int32_t, float);
float dcon_province_get_movement_cost(int32_t);
void dcon_province_set_center(int32_t, int32_t);
int32_t dcon_province_get_center(int32_t);
void dcon_province_set_infrastructure_needed(int32_t, float);
float dcon_province_get_infrastructure_needed(int32_t);
void dcon_province_set_infrastructure(int32_t, float);
float dcon_province_get_infrastructure(int32_t);
void dcon_province_set_infrastructure_investment(int32_t, float);
float dcon_province_get_infrastructure_investment(int32_t);
void dcon_province_set_infrastructure_efficiency(int32_t, float);
float dcon_province_get_infrastructure_efficiency(int32_t);
void dcon_province_resize_technologies_present(uint32_t);
void dcon_province_set_technologies_present(int32_t, int32_t, uint8_t);
uint8_t dcon_province_get_technologies_present(int32_t, int32_t);
void dcon_province_resize_technologies_researchable(uint32_t);
void dcon_province_set_technologies_researchable(int32_t, int32_t, uint8_t);
uint8_t dcon_province_get_technologies_researchable(int32_t, int32_t);
void dcon_province_resize_buildable_buildings(uint32_t);
void dcon_province_set_buildable_buildings(int32_t, int32_t, uint8_t);
uint8_t dcon_province_get_buildable_buildings(int32_t, int32_t);
void dcon_province_resize_local_production(uint32_t);
void dcon_province_set_local_production(int32_t, int32_t, float);
float dcon_province_get_local_production(int32_t, int32_t);
void dcon_province_resize_temp_buffer_0(uint32_t);
void dcon_province_set_temp_buffer_0(int32_t, int32_t, float);
float dcon_province_get_temp_buffer_0(int32_t, int32_t);
void dcon_province_resize_local_consumption(uint32_t);
void dcon_province_set_local_consumption(int32_t, int32_t, float);
float dcon_province_get_local_consumption(int32_t, int32_t);
void dcon_province_resize_local_demand(uint32_t);
void dcon_province_set_local_demand(int32_t, int32_t, float);
float dcon_province_get_local_demand(int32_t, int32_t);
void dcon_province_resize_local_satisfaction(uint32_t);
void dcon_province_set_local_satisfaction(int32_t, int32_t, float);
float dcon_province_get_local_satisfaction(int32_t, int32_t);
void dcon_province_resize_temp_buffer_use_0(uint32_t);
void dcon_province_set_temp_buffer_use_0(int32_t, int32_t, float);
float dcon_province_get_temp_buffer_use_0(int32_t, int32_t);
void dcon_province_resize_temp_buffer_use_grad(uint32_t);
void dcon_province_set_temp_buffer_use_grad(int32_t, int32_t, float);
float dcon_province_get_temp_buffer_use_grad(int32_t, int32_t);
void dcon_province_resize_local_use_satisfaction(uint32_t);
void dcon_province_set_local_use_satisfaction(int32_t, int32_t, float);
float dcon_province_get_local_use_satisfaction(int32_t, int32_t);
void dcon_province_resize_local_use_buffer_demand(uint32_t);
void dcon_province_set_local_use_buffer_demand(int32_t, int32_t, float);
float dcon_province_get_local_use_buffer_demand(int32_t, int32_t);
void dcon_province_resize_local_use_buffer_supply(uint32_t);
void dcon_province_set_local_use_buffer_supply(int32_t, int32_t, float);
float dcon_province_get_local_use_buffer_supply(int32_t, int32_t);
void dcon_province_resize_local_use_buffer_cost(uint32_t);
void dcon_province_set_local_use_buffer_cost(int32_t, int32_t, float);
float dcon_province_get_local_use_buffer_cost(int32_t, int32_t);
void dcon_province_resize_local_storage(uint32_t);
void dcon_province_set_local_storage(int32_t, int32_t, float);
float dcon_province_get_local_storage(int32_t, int32_t);
void dcon_province_resize_local_merchants_demand(uint32_t);
void dcon_province_set_local_merchants_demand(int32_t, int32_t, float);
float dcon_province_get_local_merchants_demand(int32_t, int32_t);
void dcon_province_resize_local_prices(uint32_t);
void dcon_province_set_local_prices(int32_t, int32_t, float);
float dcon_province_get_local_prices(int32_t, int32_t);
void dcon_province_set_local_wealth(int32_t, float);
float dcon_province_get_local_wealth(int32_t);
void dcon_province_set_trade_wealth(int32_t, float);
float dcon_province_get_trade_wealth(int32_t);
void dcon_province_set_local_income(int32_t, float);
float dcon_province_get_local_income(int32_t);
void dcon_province_set_local_building_upkeep(int32_t, float);
float dcon_province_get_local_building_upkeep(int32_t);
void dcon_province_set_foragers(int32_t, float);
float dcon_province_get_foragers(int32_t);
void dcon_province_set_foragers_water(int32_t, float);
float dcon_province_get_foragers_water(int32_t);
void dcon_province_set_foragers_limit(int32_t, float);
float dcon_province_get_foragers_limit(int32_t);
void dcon_province_set_forage_efficiency(int32_t, float);
float dcon_province_get_forage_efficiency(int32_t);
void dcon_province_resize_foragers_targets(uint32_t);
forage_container* dcon_province_get_foragers_targets(int32_t, int32_t);
void dcon_province_resize_local_resources(uint32_t);
resource_location* dcon_province_get_local_resources(int32_t, int32_t);
void dcon_province_resize_total_resources(uint32_t);
void dcon_province_set_total_resources(int32_t, int32_t, uint32_t);
uint32_t dcon_province_get_total_resources(int32_t, int32_t);
void dcon_province_resize_used_resources(uint32_t);
void dcon_province_set_used_resources(int32_t, int32_t, uint32_t);
uint32_t dcon_province_get_used_resources(int32_t, int32_t);
void dcon_province_set_mood(int32_t, float);
float dcon_province_get_mood(int32_t);
void dcon_province_resize_unit_types(uint32_t);
void dcon_province_set_unit_types(int32_t, int32_t, uint8_t);
uint8_t dcon_province_get_unit_types(int32_t, int32_t);
void dcon_province_resize_throughput_boosts(uint32_t);
void dcon_province_set_throughput_boosts(int32_t, int32_t, float);
float dcon_province_get_throughput_boosts(int32_t, int32_t);
void dcon_province_resize_input_efficiency_boosts(uint32_t);
void dcon_province_set_input_efficiency_boosts(int32_t, int32_t, float);
float dcon_province_get_input_efficiency_boosts(int32_t, int32_t);
void dcon_province_resize_local_efficiency_boosts(uint32_t);
void dcon_province_set_local_efficiency_boosts(int32_t, int32_t, float);
float dcon_province_get_local_efficiency_boosts(int32_t, int32_t);
void dcon_province_resize_output_efficiency_boosts(uint32_t);
void dcon_province_set_output_efficiency_boosts(int32_t, int32_t, float);
float dcon_province_get_output_efficiency_boosts(int32_t, int32_t);
void dcon_province_set_on_a_river(int32_t, bool);
bool dcon_province_get_on_a_river(int32_t);
void dcon_province_set_on_a_forest(int32_t, bool);
bool dcon_province_get_on_a_forest(int32_t);
void dcon_delete_province(int32_t j);
int32_t dcon_create_province();
bool dcon_province_is_valid(int32_t);
void dcon_province_resize(uint32_t sz);
uint32_t dcon_province_size();
]]

---province: FFI arrays---
---@type (string)[]
DATA.province_name= {}

---province: LUA bindings---

DATA.province_size = 20000
DCON.dcon_province_resize_technologies_present(401)
DCON.dcon_province_resize_technologies_researchable(401)
DCON.dcon_province_resize_buildable_buildings(251)
DCON.dcon_province_resize_local_production(101)
DCON.dcon_province_resize_temp_buffer_0(101)
DCON.dcon_province_resize_local_consumption(101)
DCON.dcon_province_resize_local_demand(101)
DCON.dcon_province_resize_local_satisfaction(101)
DCON.dcon_province_resize_temp_buffer_use_0(101)
DCON.dcon_province_resize_temp_buffer_use_grad(101)
DCON.dcon_province_resize_local_use_satisfaction(101)
DCON.dcon_province_resize_local_use_buffer_demand(101)
DCON.dcon_province_resize_local_use_buffer_supply(101)
DCON.dcon_province_resize_local_use_buffer_cost(101)
DCON.dcon_province_resize_local_storage(101)
DCON.dcon_province_resize_local_merchants_demand(101)
DCON.dcon_province_resize_local_prices(101)
DCON.dcon_province_resize_foragers_targets(26)
DCON.dcon_province_resize_local_resources(26)
DCON.dcon_province_resize_total_resources(301)
DCON.dcon_province_resize_used_resources(301)
DCON.dcon_province_resize_unit_types(5)
DCON.dcon_province_resize_throughput_boosts(251)
DCON.dcon_province_resize_input_efficiency_boosts(251)
DCON.dcon_province_resize_local_efficiency_boosts(251)
DCON.dcon_province_resize_output_efficiency_boosts(251)
---@return province_id
function DATA.create_province()
    ---@type province_id
    local i  = DCON.dcon_create_province() + 1
    return i --[[@as province_id]] 
end
---@param i province_id
function DATA.delete_province(i)
    assert(DCON.dcon_province_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_province(i - 1)
end
---@param func fun(item: province_id) 
function DATA.for_each_province(func)
    ---@type number
    local range = DCON.dcon_province_size()
    for i = 0, range - 1 do
        if DCON.dcon_province_is_valid(i) then func(i + 1 --[[@as province_id]]) end
    end
end
---@param func fun(item: province_id):boolean 
---@return table<province_id, province_id> 
function DATA.filter_province(func)
    ---@type table<province_id, province_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_province_size()
    for i = 0, range - 1 do
        if DCON.dcon_province_is_valid(i) and func(i + 1 --[[@as province_id]]) then t[i + 1 --[[@as province_id]]] = i + 1 --[[@as province_id]] end
    end
    return t
end

---@param province_id province_id valid province id
---@return string name 
function DATA.province_get_name(province_id)
    return DATA.province_name[province_id]
end
---@param province_id province_id valid province id
---@param value string valid string
function DATA.province_set_name(province_id, value)
    DATA.province_name[province_id] = value
end
---@param province_id province_id valid province id
---@return number r 
function DATA.province_get_r(province_id)
    return DCON.dcon_province_get_r(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_r(province_id, value)
    DCON.dcon_province_set_r(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_r(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_r(province_id - 1)
    DCON.dcon_province_set_r(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number g 
function DATA.province_get_g(province_id)
    return DCON.dcon_province_get_g(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_g(province_id, value)
    DCON.dcon_province_set_g(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_g(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_g(province_id - 1)
    DCON.dcon_province_set_g(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number b 
function DATA.province_get_b(province_id)
    return DCON.dcon_province_get_b(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_b(province_id, value)
    DCON.dcon_province_set_b(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_b(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_b(province_id - 1)
    DCON.dcon_province_set_b(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return boolean is_land 
function DATA.province_get_is_land(province_id)
    return DCON.dcon_province_get_is_land(province_id - 1)
end
---@param province_id province_id valid province id
---@param value boolean valid boolean
function DATA.province_set_is_land(province_id, value)
    DCON.dcon_province_set_is_land(province_id - 1, value)
end
---@param province_id province_id valid province id
---@return number province_id 
function DATA.province_get_province_id(province_id)
    return DCON.dcon_province_get_province_id(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_province_id(province_id, value)
    DCON.dcon_province_set_province_id(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_province_id(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_province_id(province_id - 1)
    DCON.dcon_province_set_province_id(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number size 
function DATA.province_get_size(province_id)
    return DCON.dcon_province_get_size(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_size(province_id, value)
    DCON.dcon_province_set_size(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_size(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_size(province_id - 1)
    DCON.dcon_province_set_size(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number hydration Number of humans that can live of off this provinces innate water
function DATA.province_get_hydration(province_id)
    return DCON.dcon_province_get_hydration(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_hydration(province_id, value)
    DCON.dcon_province_set_hydration(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_hydration(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_hydration(province_id - 1)
    DCON.dcon_province_set_hydration(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number movement_cost 
function DATA.province_get_movement_cost(province_id)
    return DCON.dcon_province_get_movement_cost(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_movement_cost(province_id, value)
    DCON.dcon_province_set_movement_cost(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_movement_cost(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_movement_cost(province_id - 1)
    DCON.dcon_province_set_movement_cost(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return tile_id center The tile which contains this province's settlement, if there is any.
function DATA.province_get_center(province_id)
    return DCON.dcon_province_get_center(province_id - 1) + 1
end
---@param province_id province_id valid province id
---@param value tile_id valid tile_id
function DATA.province_set_center(province_id, value)
    DCON.dcon_province_set_center(province_id - 1, value - 1)
end
---@param province_id province_id valid province id
---@return number infrastructure_needed 
function DATA.province_get_infrastructure_needed(province_id)
    return DCON.dcon_province_get_infrastructure_needed(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_infrastructure_needed(province_id, value)
    DCON.dcon_province_set_infrastructure_needed(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_infrastructure_needed(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_infrastructure_needed(province_id - 1)
    DCON.dcon_province_set_infrastructure_needed(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number infrastructure 
function DATA.province_get_infrastructure(province_id)
    return DCON.dcon_province_get_infrastructure(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_infrastructure(province_id, value)
    DCON.dcon_province_set_infrastructure(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_infrastructure(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_infrastructure(province_id - 1)
    DCON.dcon_province_set_infrastructure(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number infrastructure_investment 
function DATA.province_get_infrastructure_investment(province_id)
    return DCON.dcon_province_get_infrastructure_investment(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_infrastructure_investment(province_id, value)
    DCON.dcon_province_set_infrastructure_investment(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_infrastructure_investment(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_infrastructure_investment(province_id - 1)
    DCON.dcon_province_set_infrastructure_investment(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number infrastructure_efficiency 
function DATA.province_get_infrastructure_efficiency(province_id)
    return DCON.dcon_province_get_infrastructure_efficiency(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_infrastructure_efficiency(province_id, value)
    DCON.dcon_province_set_infrastructure_efficiency(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_infrastructure_efficiency(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_infrastructure_efficiency(province_id - 1)
    DCON.dcon_province_set_infrastructure_efficiency(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@param index technology_id valid
---@return number technologies_present 
function DATA.province_get_technologies_present(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_technologies_present(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index technology_id valid index
---@param value number valid number
function DATA.province_set_technologies_present(province_id, index, value)
    DCON.dcon_province_set_technologies_present(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index technology_id valid index
---@param value number valid number
function DATA.province_inc_technologies_present(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_technologies_present(province_id - 1, index - 1)
    DCON.dcon_province_set_technologies_present(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index technology_id valid
---@return number technologies_researchable 
function DATA.province_get_technologies_researchable(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_technologies_researchable(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index technology_id valid index
---@param value number valid number
function DATA.province_set_technologies_researchable(province_id, index, value)
    DCON.dcon_province_set_technologies_researchable(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index technology_id valid index
---@param value number valid number
function DATA.province_inc_technologies_researchable(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_technologies_researchable(province_id - 1, index - 1)
    DCON.dcon_province_set_technologies_researchable(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index building_type_id valid
---@return number buildable_buildings 
function DATA.province_get_buildable_buildings(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_buildable_buildings(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index building_type_id valid index
---@param value number valid number
function DATA.province_set_buildable_buildings(province_id, index, value)
    DCON.dcon_province_set_buildable_buildings(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index building_type_id valid index
---@param value number valid number
function DATA.province_inc_buildable_buildings(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_buildable_buildings(province_id - 1, index - 1)
    DCON.dcon_province_set_buildable_buildings(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid
---@return number local_production 
function DATA.province_get_local_production(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_local_production(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_set_local_production(province_id, index, value)
    DCON.dcon_province_set_local_production(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_inc_local_production(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_local_production(province_id - 1, index - 1)
    DCON.dcon_province_set_local_production(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid
---@return number temp_buffer_0 
function DATA.province_get_temp_buffer_0(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_temp_buffer_0(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_set_temp_buffer_0(province_id, index, value)
    DCON.dcon_province_set_temp_buffer_0(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_inc_temp_buffer_0(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_temp_buffer_0(province_id - 1, index - 1)
    DCON.dcon_province_set_temp_buffer_0(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid
---@return number local_consumption 
function DATA.province_get_local_consumption(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_local_consumption(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_set_local_consumption(province_id, index, value)
    DCON.dcon_province_set_local_consumption(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_inc_local_consumption(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_local_consumption(province_id - 1, index - 1)
    DCON.dcon_province_set_local_consumption(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid
---@return number local_demand 
function DATA.province_get_local_demand(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_local_demand(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_set_local_demand(province_id, index, value)
    DCON.dcon_province_set_local_demand(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_inc_local_demand(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_local_demand(province_id - 1, index - 1)
    DCON.dcon_province_set_local_demand(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid
---@return number local_satisfaction 
function DATA.province_get_local_satisfaction(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_local_satisfaction(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_set_local_satisfaction(province_id, index, value)
    DCON.dcon_province_set_local_satisfaction(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_inc_local_satisfaction(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_local_satisfaction(province_id - 1, index - 1)
    DCON.dcon_province_set_local_satisfaction(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index use_case_id valid
---@return number temp_buffer_use_0 
function DATA.province_get_temp_buffer_use_0(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_temp_buffer_use_0(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index use_case_id valid index
---@param value number valid number
function DATA.province_set_temp_buffer_use_0(province_id, index, value)
    DCON.dcon_province_set_temp_buffer_use_0(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index use_case_id valid index
---@param value number valid number
function DATA.province_inc_temp_buffer_use_0(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_temp_buffer_use_0(province_id - 1, index - 1)
    DCON.dcon_province_set_temp_buffer_use_0(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index use_case_id valid
---@return number temp_buffer_use_grad 
function DATA.province_get_temp_buffer_use_grad(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_temp_buffer_use_grad(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index use_case_id valid index
---@param value number valid number
function DATA.province_set_temp_buffer_use_grad(province_id, index, value)
    DCON.dcon_province_set_temp_buffer_use_grad(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index use_case_id valid index
---@param value number valid number
function DATA.province_inc_temp_buffer_use_grad(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_temp_buffer_use_grad(province_id - 1, index - 1)
    DCON.dcon_province_set_temp_buffer_use_grad(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index use_case_id valid
---@return number local_use_satisfaction 
function DATA.province_get_local_use_satisfaction(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_local_use_satisfaction(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index use_case_id valid index
---@param value number valid number
function DATA.province_set_local_use_satisfaction(province_id, index, value)
    DCON.dcon_province_set_local_use_satisfaction(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index use_case_id valid index
---@param value number valid number
function DATA.province_inc_local_use_satisfaction(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_local_use_satisfaction(province_id - 1, index - 1)
    DCON.dcon_province_set_local_use_satisfaction(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index use_case_id valid
---@return number local_use_buffer_demand 
function DATA.province_get_local_use_buffer_demand(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_local_use_buffer_demand(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index use_case_id valid index
---@param value number valid number
function DATA.province_set_local_use_buffer_demand(province_id, index, value)
    DCON.dcon_province_set_local_use_buffer_demand(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index use_case_id valid index
---@param value number valid number
function DATA.province_inc_local_use_buffer_demand(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_local_use_buffer_demand(province_id - 1, index - 1)
    DCON.dcon_province_set_local_use_buffer_demand(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index use_case_id valid
---@return number local_use_buffer_supply 
function DATA.province_get_local_use_buffer_supply(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_local_use_buffer_supply(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index use_case_id valid index
---@param value number valid number
function DATA.province_set_local_use_buffer_supply(province_id, index, value)
    DCON.dcon_province_set_local_use_buffer_supply(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index use_case_id valid index
---@param value number valid number
function DATA.province_inc_local_use_buffer_supply(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_local_use_buffer_supply(province_id - 1, index - 1)
    DCON.dcon_province_set_local_use_buffer_supply(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index use_case_id valid
---@return number local_use_buffer_cost 
function DATA.province_get_local_use_buffer_cost(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_local_use_buffer_cost(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index use_case_id valid index
---@param value number valid number
function DATA.province_set_local_use_buffer_cost(province_id, index, value)
    DCON.dcon_province_set_local_use_buffer_cost(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index use_case_id valid index
---@param value number valid number
function DATA.province_inc_local_use_buffer_cost(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_local_use_buffer_cost(province_id - 1, index - 1)
    DCON.dcon_province_set_local_use_buffer_cost(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid
---@return number local_storage 
function DATA.province_get_local_storage(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_local_storage(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_set_local_storage(province_id, index, value)
    DCON.dcon_province_set_local_storage(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_inc_local_storage(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_local_storage(province_id - 1, index - 1)
    DCON.dcon_province_set_local_storage(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid
---@return number local_merchants_demand 
function DATA.province_get_local_merchants_demand(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_local_merchants_demand(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_set_local_merchants_demand(province_id, index, value)
    DCON.dcon_province_set_local_merchants_demand(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_inc_local_merchants_demand(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_local_merchants_demand(province_id - 1, index - 1)
    DCON.dcon_province_set_local_merchants_demand(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid
---@return number local_prices 
function DATA.province_get_local_prices(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_local_prices(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_set_local_prices(province_id, index, value)
    DCON.dcon_province_set_local_prices(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.province_inc_local_prices(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_local_prices(province_id - 1, index - 1)
    DCON.dcon_province_set_local_prices(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@return number local_wealth 
function DATA.province_get_local_wealth(province_id)
    return DCON.dcon_province_get_local_wealth(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_local_wealth(province_id, value)
    DCON.dcon_province_set_local_wealth(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_local_wealth(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_local_wealth(province_id - 1)
    DCON.dcon_province_set_local_wealth(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number trade_wealth 
function DATA.province_get_trade_wealth(province_id)
    return DCON.dcon_province_get_trade_wealth(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_trade_wealth(province_id, value)
    DCON.dcon_province_set_trade_wealth(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_trade_wealth(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_trade_wealth(province_id - 1)
    DCON.dcon_province_set_trade_wealth(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number local_income 
function DATA.province_get_local_income(province_id)
    return DCON.dcon_province_get_local_income(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_local_income(province_id, value)
    DCON.dcon_province_set_local_income(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_local_income(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_local_income(province_id - 1)
    DCON.dcon_province_set_local_income(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number local_building_upkeep 
function DATA.province_get_local_building_upkeep(province_id)
    return DCON.dcon_province_get_local_building_upkeep(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_local_building_upkeep(province_id, value)
    DCON.dcon_province_set_local_building_upkeep(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_local_building_upkeep(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_local_building_upkeep(province_id - 1)
    DCON.dcon_province_set_local_building_upkeep(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number foragers Keeps track of the number of foragers in the province. Used to calculate yields of independent foraging.
function DATA.province_get_foragers(province_id)
    return DCON.dcon_province_get_foragers(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_foragers(province_id, value)
    DCON.dcon_province_set_foragers(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_foragers(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_foragers(province_id - 1)
    DCON.dcon_province_set_foragers(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number foragers_water amount foraged by pops and characters
function DATA.province_get_foragers_water(province_id)
    return DCON.dcon_province_get_foragers_water(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_foragers_water(province_id, value)
    DCON.dcon_province_set_foragers_water(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_foragers_water(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_foragers_water(province_id - 1)
    DCON.dcon_province_set_foragers_water(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number foragers_limit amount of calories foraged by pops and characters
function DATA.province_get_foragers_limit(province_id)
    return DCON.dcon_province_get_foragers_limit(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_foragers_limit(province_id, value)
    DCON.dcon_province_set_foragers_limit(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_foragers_limit(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_foragers_limit(province_id - 1)
    DCON.dcon_province_set_foragers_limit(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@return number forage_efficiency 
function DATA.province_get_forage_efficiency(province_id)
    return DCON.dcon_province_get_forage_efficiency(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_forage_efficiency(province_id, value)
    DCON.dcon_province_set_forage_efficiency(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_forage_efficiency(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_forage_efficiency(province_id - 1)
    DCON.dcon_province_set_forage_efficiency(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@param index number valid
---@return trade_good_id foragers_targets 
function DATA.province_get_foragers_targets_output_good(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_foragers_targets(province_id - 1, index - 1)[0].output_good
end
---@param province_id province_id valid province id
---@param index number valid
---@return number foragers_targets 
function DATA.province_get_foragers_targets_output_value(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_foragers_targets(province_id - 1, index - 1)[0].output_value
end
---@param province_id province_id valid province id
---@param index number valid
---@return number foragers_targets 
function DATA.province_get_foragers_targets_amount(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_foragers_targets(province_id - 1, index - 1)[0].amount
end
---@param province_id province_id valid province id
---@param index number valid
---@return FORAGE_RESOURCE foragers_targets 
function DATA.province_get_foragers_targets_forage(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_foragers_targets(province_id - 1, index - 1)[0].forage
end
---@param province_id province_id valid province id
---@param index number valid index
---@param value trade_good_id valid trade_good_id
function DATA.province_set_foragers_targets_output_good(province_id, index, value)
    DCON.dcon_province_get_foragers_targets(province_id - 1, index - 1)[0].output_good = value
end
---@param province_id province_id valid province id
---@param index number valid index
---@param value number valid number
function DATA.province_set_foragers_targets_output_value(province_id, index, value)
    DCON.dcon_province_get_foragers_targets(province_id - 1, index - 1)[0].output_value = value
end
---@param province_id province_id valid province id
---@param index number valid index
---@param value number valid number
function DATA.province_inc_foragers_targets_output_value(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_foragers_targets(province_id - 1, index - 1)[0].output_value
    DCON.dcon_province_get_foragers_targets(province_id - 1, index - 1)[0].output_value = current + value
end
---@param province_id province_id valid province id
---@param index number valid index
---@param value number valid number
function DATA.province_set_foragers_targets_amount(province_id, index, value)
    DCON.dcon_province_get_foragers_targets(province_id - 1, index - 1)[0].amount = value
end
---@param province_id province_id valid province id
---@param index number valid index
---@param value number valid number
function DATA.province_inc_foragers_targets_amount(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_foragers_targets(province_id - 1, index - 1)[0].amount
    DCON.dcon_province_get_foragers_targets(province_id - 1, index - 1)[0].amount = current + value
end
---@param province_id province_id valid province id
---@param index number valid index
---@param value FORAGE_RESOURCE valid FORAGE_RESOURCE
function DATA.province_set_foragers_targets_forage(province_id, index, value)
    DCON.dcon_province_get_foragers_targets(province_id - 1, index - 1)[0].forage = value
end
---@param province_id province_id valid province id
---@param index number valid
---@return resource_id local_resources An array of local resources and their positions
function DATA.province_get_local_resources_resource(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_local_resources(province_id - 1, index - 1)[0].resource
end
---@param province_id province_id valid province id
---@param index number valid
---@return tile_id local_resources An array of local resources and their positions
function DATA.province_get_local_resources_location(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_local_resources(province_id - 1, index - 1)[0].location
end
---@param province_id province_id valid province id
---@param index number valid index
---@param value resource_id valid resource_id
function DATA.province_set_local_resources_resource(province_id, index, value)
    DCON.dcon_province_get_local_resources(province_id - 1, index - 1)[0].resource = value
end
---@param province_id province_id valid province id
---@param index number valid index
---@param value tile_id valid tile_id
function DATA.province_set_local_resources_location(province_id, index, value)
    DCON.dcon_province_get_local_resources(province_id - 1, index - 1)[0].location = value
end
---@param province_id province_id valid province id
---@param index resource_id valid
---@return number total_resources 
function DATA.province_get_total_resources(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_total_resources(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index resource_id valid index
---@param value number valid number
function DATA.province_set_total_resources(province_id, index, value)
    DCON.dcon_province_set_total_resources(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index resource_id valid index
---@param value number valid number
function DATA.province_inc_total_resources(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_total_resources(province_id - 1, index - 1)
    DCON.dcon_province_set_total_resources(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index resource_id valid
---@return number used_resources 
function DATA.province_get_used_resources(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_used_resources(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index resource_id valid index
---@param value number valid number
function DATA.province_set_used_resources(province_id, index, value)
    DCON.dcon_province_set_used_resources(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index resource_id valid index
---@param value number valid number
function DATA.province_inc_used_resources(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_used_resources(province_id - 1, index - 1)
    DCON.dcon_province_set_used_resources(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@return number mood how local population thinks about the state
function DATA.province_get_mood(province_id)
    return DCON.dcon_province_get_mood(province_id - 1)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_set_mood(province_id, value)
    DCON.dcon_province_set_mood(province_id - 1, value)
end
---@param province_id province_id valid province id
---@param value number valid number
function DATA.province_inc_mood(province_id, value)
    ---@type number
    local current = DCON.dcon_province_get_mood(province_id - 1)
    DCON.dcon_province_set_mood(province_id - 1, current + value)
end
---@param province_id province_id valid province id
---@param index unit_type_id valid
---@return number unit_types 
function DATA.province_get_unit_types(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_unit_types(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index unit_type_id valid index
---@param value number valid number
function DATA.province_set_unit_types(province_id, index, value)
    DCON.dcon_province_set_unit_types(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index unit_type_id valid index
---@param value number valid number
function DATA.province_inc_unit_types(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_unit_types(province_id - 1, index - 1)
    DCON.dcon_province_set_unit_types(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index production_method_id valid
---@return number throughput_boosts 
function DATA.province_get_throughput_boosts(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_throughput_boosts(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index production_method_id valid index
---@param value number valid number
function DATA.province_set_throughput_boosts(province_id, index, value)
    DCON.dcon_province_set_throughput_boosts(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index production_method_id valid index
---@param value number valid number
function DATA.province_inc_throughput_boosts(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_throughput_boosts(province_id - 1, index - 1)
    DCON.dcon_province_set_throughput_boosts(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index production_method_id valid
---@return number input_efficiency_boosts 
function DATA.province_get_input_efficiency_boosts(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_input_efficiency_boosts(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index production_method_id valid index
---@param value number valid number
function DATA.province_set_input_efficiency_boosts(province_id, index, value)
    DCON.dcon_province_set_input_efficiency_boosts(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index production_method_id valid index
---@param value number valid number
function DATA.province_inc_input_efficiency_boosts(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_input_efficiency_boosts(province_id - 1, index - 1)
    DCON.dcon_province_set_input_efficiency_boosts(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index production_method_id valid
---@return number local_efficiency_boosts 
function DATA.province_get_local_efficiency_boosts(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_local_efficiency_boosts(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index production_method_id valid index
---@param value number valid number
function DATA.province_set_local_efficiency_boosts(province_id, index, value)
    DCON.dcon_province_set_local_efficiency_boosts(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index production_method_id valid index
---@param value number valid number
function DATA.province_inc_local_efficiency_boosts(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_local_efficiency_boosts(province_id - 1, index - 1)
    DCON.dcon_province_set_local_efficiency_boosts(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@param index production_method_id valid
---@return number output_efficiency_boosts 
function DATA.province_get_output_efficiency_boosts(province_id, index)
    assert(index ~= 0)
    return DCON.dcon_province_get_output_efficiency_boosts(province_id - 1, index - 1)
end
---@param province_id province_id valid province id
---@param index production_method_id valid index
---@param value number valid number
function DATA.province_set_output_efficiency_boosts(province_id, index, value)
    DCON.dcon_province_set_output_efficiency_boosts(province_id - 1, index - 1, value)
end
---@param province_id province_id valid province id
---@param index production_method_id valid index
---@param value number valid number
function DATA.province_inc_output_efficiency_boosts(province_id, index, value)
    ---@type number
    local current = DCON.dcon_province_get_output_efficiency_boosts(province_id - 1, index - 1)
    DCON.dcon_province_set_output_efficiency_boosts(province_id - 1, index - 1, current + value)
end
---@param province_id province_id valid province id
---@return boolean on_a_river 
function DATA.province_get_on_a_river(province_id)
    return DCON.dcon_province_get_on_a_river(province_id - 1)
end
---@param province_id province_id valid province id
---@param value boolean valid boolean
function DATA.province_set_on_a_river(province_id, value)
    DCON.dcon_province_set_on_a_river(province_id - 1, value)
end
---@param province_id province_id valid province id
---@return boolean on_a_forest 
function DATA.province_get_on_a_forest(province_id)
    return DCON.dcon_province_get_on_a_forest(province_id - 1)
end
---@param province_id province_id valid province id
---@param value boolean valid boolean
function DATA.province_set_on_a_forest(province_id, value)
    DCON.dcon_province_set_on_a_forest(province_id - 1, value)
end

local fat_province_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.province_get_name(t.id) end
        if (k == "r") then return DATA.province_get_r(t.id) end
        if (k == "g") then return DATA.province_get_g(t.id) end
        if (k == "b") then return DATA.province_get_b(t.id) end
        if (k == "is_land") then return DATA.province_get_is_land(t.id) end
        if (k == "province_id") then return DATA.province_get_province_id(t.id) end
        if (k == "size") then return DATA.province_get_size(t.id) end
        if (k == "hydration") then return DATA.province_get_hydration(t.id) end
        if (k == "movement_cost") then return DATA.province_get_movement_cost(t.id) end
        if (k == "center") then return DATA.province_get_center(t.id) end
        if (k == "infrastructure_needed") then return DATA.province_get_infrastructure_needed(t.id) end
        if (k == "infrastructure") then return DATA.province_get_infrastructure(t.id) end
        if (k == "infrastructure_investment") then return DATA.province_get_infrastructure_investment(t.id) end
        if (k == "infrastructure_efficiency") then return DATA.province_get_infrastructure_efficiency(t.id) end
        if (k == "local_wealth") then return DATA.province_get_local_wealth(t.id) end
        if (k == "trade_wealth") then return DATA.province_get_trade_wealth(t.id) end
        if (k == "local_income") then return DATA.province_get_local_income(t.id) end
        if (k == "local_building_upkeep") then return DATA.province_get_local_building_upkeep(t.id) end
        if (k == "foragers") then return DATA.province_get_foragers(t.id) end
        if (k == "foragers_water") then return DATA.province_get_foragers_water(t.id) end
        if (k == "foragers_limit") then return DATA.province_get_foragers_limit(t.id) end
        if (k == "forage_efficiency") then return DATA.province_get_forage_efficiency(t.id) end
        if (k == "mood") then return DATA.province_get_mood(t.id) end
        if (k == "on_a_river") then return DATA.province_get_on_a_river(t.id) end
        if (k == "on_a_forest") then return DATA.province_get_on_a_forest(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.province_set_name(t.id, v)
            return
        end
        if (k == "r") then
            DATA.province_set_r(t.id, v)
            return
        end
        if (k == "g") then
            DATA.province_set_g(t.id, v)
            return
        end
        if (k == "b") then
            DATA.province_set_b(t.id, v)
            return
        end
        if (k == "is_land") then
            DATA.province_set_is_land(t.id, v)
            return
        end
        if (k == "province_id") then
            DATA.province_set_province_id(t.id, v)
            return
        end
        if (k == "size") then
            DATA.province_set_size(t.id, v)
            return
        end
        if (k == "hydration") then
            DATA.province_set_hydration(t.id, v)
            return
        end
        if (k == "movement_cost") then
            DATA.province_set_movement_cost(t.id, v)
            return
        end
        if (k == "center") then
            DATA.province_set_center(t.id, v)
            return
        end
        if (k == "infrastructure_needed") then
            DATA.province_set_infrastructure_needed(t.id, v)
            return
        end
        if (k == "infrastructure") then
            DATA.province_set_infrastructure(t.id, v)
            return
        end
        if (k == "infrastructure_investment") then
            DATA.province_set_infrastructure_investment(t.id, v)
            return
        end
        if (k == "infrastructure_efficiency") then
            DATA.province_set_infrastructure_efficiency(t.id, v)
            return
        end
        if (k == "local_wealth") then
            DATA.province_set_local_wealth(t.id, v)
            return
        end
        if (k == "trade_wealth") then
            DATA.province_set_trade_wealth(t.id, v)
            return
        end
        if (k == "local_income") then
            DATA.province_set_local_income(t.id, v)
            return
        end
        if (k == "local_building_upkeep") then
            DATA.province_set_local_building_upkeep(t.id, v)
            return
        end
        if (k == "foragers") then
            DATA.province_set_foragers(t.id, v)
            return
        end
        if (k == "foragers_water") then
            DATA.province_set_foragers_water(t.id, v)
            return
        end
        if (k == "foragers_limit") then
            DATA.province_set_foragers_limit(t.id, v)
            return
        end
        if (k == "forage_efficiency") then
            DATA.province_set_forage_efficiency(t.id, v)
            return
        end
        if (k == "mood") then
            DATA.province_set_mood(t.id, v)
            return
        end
        if (k == "on_a_river") then
            DATA.province_set_on_a_river(t.id, v)
            return
        end
        if (k == "on_a_forest") then
            DATA.province_set_on_a_forest(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id province_id
---@return fat_province_id fat_id
function DATA.fatten_province(id)
    local result = {id = id}
    setmetatable(result, fat_province_id_metatable)
    return result --[[@as fat_province_id]]
end
