local ffi = require("ffi")
----------realm----------


---realm: LSP types---

---Unique identificator for realm entity
---@class (exact) realm_id : table
---@field is_realm number
---@class (exact) fat_realm_id
---@field id realm_id Unique realm id
---@field exists boolean 
---@field name string 
---@field budget_change number 
---@field budget_saved_change number 
---@field budget_treasury number 
---@field budget_treasury_target number 
---@field budget_tax_target number 
---@field budget_tax_collected_this_year number 
---@field r number 
---@field g number 
---@field b number 
---@field primary_race race_id 
---@field primary_culture culture_id 
---@field primary_faith faith_id 
---@field capitol province_id 
---@field trading_right_cost number 
---@field building_right_cost number 
---@field law_trade LAW_TRADE 
---@field law_building LAW_BUILDING 
---@field quests_raid table<province_id,nil|number> reward for raid
---@field quests_explore table<province_id,nil|number> reward for exploration
---@field quests_patrol table<province_id,nil|number> reward for patrol
---@field patrols table<province_id,table<warband_id,warband_id>> 
---@field prepare_attack_flag boolean 
---@field known_provinces table<province_id,province_id> For terra incognita.
---@field coa_base_r number 
---@field coa_base_g number 
---@field coa_base_b number 
---@field coa_background_r number 
---@field coa_background_g number 
---@field coa_background_b number 
---@field coa_foreground_r number 
---@field coa_foreground_g number 
---@field coa_foreground_b number 
---@field coa_emblem_r number 
---@field coa_emblem_g number 
---@field coa_emblem_b number 
---@field coa_background_image number 
---@field coa_foreground_image number 
---@field coa_emblem_image number 
---@field expected_food_consumption number 

---@class struct_realm
---@field budget_change number 
---@field budget_saved_change number 
---@field budget_spending_by_category table<ECONOMY_REASON, number> 
---@field budget_income_by_category table<ECONOMY_REASON, number> 
---@field budget_treasury_change_by_category table<ECONOMY_REASON, number> 
---@field budget_treasury number 
---@field budget_treasury_target number 
---@field budget table<BUDGET_CATEGORY, struct_budget_per_category_data> 
---@field budget_tax_target number 
---@field budget_tax_collected_this_year number 
---@field r number 
---@field g number 
---@field b number 
---@field primary_race race_id 
---@field primary_culture culture_id 
---@field primary_faith faith_id 
---@field capitol province_id 
---@field trading_right_cost number 
---@field building_right_cost number 
---@field law_trade LAW_TRADE 
---@field law_building LAW_BUILDING 
---@field prepare_attack_flag boolean 
---@field coa_base_r number 
---@field coa_base_g number 
---@field coa_base_b number 
---@field coa_background_r number 
---@field coa_background_g number 
---@field coa_background_b number 
---@field coa_foreground_r number 
---@field coa_foreground_g number 
---@field coa_foreground_b number 
---@field coa_emblem_r number 
---@field coa_emblem_g number 
---@field coa_emblem_b number 
---@field coa_background_image number 
---@field coa_foreground_image number 
---@field coa_emblem_image number 
---@field resources table<trade_good_id, number> Currently stockpiled resources
---@field production table<trade_good_id, number> A "balance" of resource creation
---@field bought table<trade_good_id, number> 
---@field sold table<trade_good_id, number> 
---@field expected_food_consumption number 


ffi.cdef[[
void dcon_realm_set_budget_change(int32_t, float);
float dcon_realm_get_budget_change(int32_t);
void dcon_realm_set_budget_saved_change(int32_t, float);
float dcon_realm_get_budget_saved_change(int32_t);
void dcon_realm_resize_budget_spending_by_category(uint32_t);
void dcon_realm_set_budget_spending_by_category(int32_t, int32_t, float);
float dcon_realm_get_budget_spending_by_category(int32_t, int32_t);
void dcon_realm_resize_budget_income_by_category(uint32_t);
void dcon_realm_set_budget_income_by_category(int32_t, int32_t, float);
float dcon_realm_get_budget_income_by_category(int32_t, int32_t);
void dcon_realm_resize_budget_treasury_change_by_category(uint32_t);
void dcon_realm_set_budget_treasury_change_by_category(int32_t, int32_t, float);
float dcon_realm_get_budget_treasury_change_by_category(int32_t, int32_t);
void dcon_realm_set_budget_treasury(int32_t, float);
float dcon_realm_get_budget_treasury(int32_t);
void dcon_realm_set_budget_treasury_target(int32_t, float);
float dcon_realm_get_budget_treasury_target(int32_t);
void dcon_realm_resize_budget(uint32_t);
budget_per_category_data* dcon_realm_get_budget(int32_t, int32_t);
void dcon_realm_set_budget_tax_target(int32_t, float);
float dcon_realm_get_budget_tax_target(int32_t);
void dcon_realm_set_budget_tax_collected_this_year(int32_t, float);
float dcon_realm_get_budget_tax_collected_this_year(int32_t);
void dcon_realm_set_r(int32_t, float);
float dcon_realm_get_r(int32_t);
void dcon_realm_set_g(int32_t, float);
float dcon_realm_get_g(int32_t);
void dcon_realm_set_b(int32_t, float);
float dcon_realm_get_b(int32_t);
void dcon_realm_set_primary_race(int32_t, int32_t);
int32_t dcon_realm_get_primary_race(int32_t);
void dcon_realm_set_primary_culture(int32_t, int32_t);
int32_t dcon_realm_get_primary_culture(int32_t);
void dcon_realm_set_primary_faith(int32_t, int32_t);
int32_t dcon_realm_get_primary_faith(int32_t);
void dcon_realm_set_capitol(int32_t, int32_t);
int32_t dcon_realm_get_capitol(int32_t);
void dcon_realm_set_trading_right_cost(int32_t, float);
float dcon_realm_get_trading_right_cost(int32_t);
void dcon_realm_set_building_right_cost(int32_t, float);
float dcon_realm_get_building_right_cost(int32_t);
void dcon_realm_set_law_trade(int32_t, uint8_t);
uint8_t dcon_realm_get_law_trade(int32_t);
void dcon_realm_set_law_building(int32_t, uint8_t);
uint8_t dcon_realm_get_law_building(int32_t);
void dcon_realm_set_prepare_attack_flag(int32_t, bool);
bool dcon_realm_get_prepare_attack_flag(int32_t);
void dcon_realm_set_coa_base_r(int32_t, float);
float dcon_realm_get_coa_base_r(int32_t);
void dcon_realm_set_coa_base_g(int32_t, float);
float dcon_realm_get_coa_base_g(int32_t);
void dcon_realm_set_coa_base_b(int32_t, float);
float dcon_realm_get_coa_base_b(int32_t);
void dcon_realm_set_coa_background_r(int32_t, float);
float dcon_realm_get_coa_background_r(int32_t);
void dcon_realm_set_coa_background_g(int32_t, float);
float dcon_realm_get_coa_background_g(int32_t);
void dcon_realm_set_coa_background_b(int32_t, float);
float dcon_realm_get_coa_background_b(int32_t);
void dcon_realm_set_coa_foreground_r(int32_t, float);
float dcon_realm_get_coa_foreground_r(int32_t);
void dcon_realm_set_coa_foreground_g(int32_t, float);
float dcon_realm_get_coa_foreground_g(int32_t);
void dcon_realm_set_coa_foreground_b(int32_t, float);
float dcon_realm_get_coa_foreground_b(int32_t);
void dcon_realm_set_coa_emblem_r(int32_t, float);
float dcon_realm_get_coa_emblem_r(int32_t);
void dcon_realm_set_coa_emblem_g(int32_t, float);
float dcon_realm_get_coa_emblem_g(int32_t);
void dcon_realm_set_coa_emblem_b(int32_t, float);
float dcon_realm_get_coa_emblem_b(int32_t);
void dcon_realm_set_coa_background_image(int32_t, uint32_t);
uint32_t dcon_realm_get_coa_background_image(int32_t);
void dcon_realm_set_coa_foreground_image(int32_t, uint32_t);
uint32_t dcon_realm_get_coa_foreground_image(int32_t);
void dcon_realm_set_coa_emblem_image(int32_t, uint32_t);
uint32_t dcon_realm_get_coa_emblem_image(int32_t);
void dcon_realm_resize_resources(uint32_t);
void dcon_realm_set_resources(int32_t, int32_t, float);
float dcon_realm_get_resources(int32_t, int32_t);
void dcon_realm_resize_production(uint32_t);
void dcon_realm_set_production(int32_t, int32_t, float);
float dcon_realm_get_production(int32_t, int32_t);
void dcon_realm_resize_bought(uint32_t);
void dcon_realm_set_bought(int32_t, int32_t, float);
float dcon_realm_get_bought(int32_t, int32_t);
void dcon_realm_resize_sold(uint32_t);
void dcon_realm_set_sold(int32_t, int32_t, float);
float dcon_realm_get_sold(int32_t, int32_t);
void dcon_realm_set_expected_food_consumption(int32_t, float);
float dcon_realm_get_expected_food_consumption(int32_t);
void dcon_delete_realm(int32_t j);
int32_t dcon_create_realm();
bool dcon_realm_is_valid(int32_t);
void dcon_realm_resize(uint32_t sz);
uint32_t dcon_realm_size();
]]

---realm: FFI arrays---
---@type (boolean)[]
DATA.realm_exists= {}
---@type (string)[]
DATA.realm_name= {}
---@type (table<province_id,nil|number>)[]
DATA.realm_quests_raid= {}
---@type (table<province_id,nil|number>)[]
DATA.realm_quests_explore= {}
---@type (table<province_id,nil|number>)[]
DATA.realm_quests_patrol= {}
---@type (table<province_id,table<warband_id,warband_id>>)[]
DATA.realm_patrols= {}
---@type (table<province_id,province_id>)[]
DATA.realm_known_provinces= {}

---realm: LUA bindings---

DATA.realm_size = 15000
DCON.dcon_realm_resize_budget_spending_by_category(39)
DCON.dcon_realm_resize_budget_income_by_category(39)
DCON.dcon_realm_resize_budget_treasury_change_by_category(39)
DCON.dcon_realm_resize_budget(8)
DCON.dcon_realm_resize_resources(101)
DCON.dcon_realm_resize_production(101)
DCON.dcon_realm_resize_bought(101)
DCON.dcon_realm_resize_sold(101)
---@return realm_id
function DATA.create_realm()
    ---@type realm_id
    local i  = DCON.dcon_create_realm() + 1
    return i --[[@as realm_id]] 
end
---@param i realm_id
function DATA.delete_realm(i)
    assert(DCON.dcon_realm_is_valid(i - 1), " ATTEMPT TO DELETE INVALID OBJECT " .. tostring(i))
    return DCON.dcon_delete_realm(i - 1)
end
---@param func fun(item: realm_id) 
function DATA.for_each_realm(func)
    ---@type number
    local range = DCON.dcon_realm_size()
    for i = 0, range - 1 do
        if DCON.dcon_realm_is_valid(i) then func(i + 1 --[[@as realm_id]]) end
    end
end
---@param func fun(item: realm_id):boolean 
---@return table<realm_id, realm_id> 
function DATA.filter_realm(func)
    ---@type table<realm_id, realm_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_realm_size()
    for i = 0, range - 1 do
        if DCON.dcon_realm_is_valid(i) and func(i + 1 --[[@as realm_id]]) then t[i + 1 --[[@as realm_id]]] = i + 1 --[[@as realm_id]] end
    end
    return t
end

---@param realm_id realm_id valid realm id
---@return boolean exists 
function DATA.realm_get_exists(realm_id)
    return DATA.realm_exists[realm_id]
end
---@param realm_id realm_id valid realm id
---@param value boolean valid boolean
function DATA.realm_set_exists(realm_id, value)
    DATA.realm_exists[realm_id] = value
end
---@param realm_id realm_id valid realm id
---@return string name 
function DATA.realm_get_name(realm_id)
    return DATA.realm_name[realm_id]
end
---@param realm_id realm_id valid realm id
---@param value string valid string
function DATA.realm_set_name(realm_id, value)
    DATA.realm_name[realm_id] = value
end
---@param realm_id realm_id valid realm id
---@return number budget_change 
function DATA.realm_get_budget_change(realm_id)
    return DCON.dcon_realm_get_budget_change(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_budget_change(realm_id, value)
    DCON.dcon_realm_set_budget_change(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_budget_change(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_budget_change(realm_id - 1)
    DCON.dcon_realm_set_budget_change(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number budget_saved_change 
function DATA.realm_get_budget_saved_change(realm_id)
    return DCON.dcon_realm_get_budget_saved_change(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_budget_saved_change(realm_id, value)
    DCON.dcon_realm_set_budget_saved_change(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_budget_saved_change(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_budget_saved_change(realm_id - 1)
    DCON.dcon_realm_set_budget_saved_change(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@param index ECONOMY_REASON valid
---@return number budget_spending_by_category 
function DATA.realm_get_budget_spending_by_category(realm_id, index)
    assert(index ~= 0)
    return DCON.dcon_realm_get_budget_spending_by_category(realm_id - 1, index)
end
---@param realm_id realm_id valid realm id
---@param index ECONOMY_REASON valid index
---@param value number valid number
function DATA.realm_set_budget_spending_by_category(realm_id, index, value)
    DCON.dcon_realm_set_budget_spending_by_category(realm_id - 1, index, value)
end
---@param realm_id realm_id valid realm id
---@param index ECONOMY_REASON valid index
---@param value number valid number
function DATA.realm_inc_budget_spending_by_category(realm_id, index, value)
    ---@type number
    local current = DCON.dcon_realm_get_budget_spending_by_category(realm_id - 1, index)
    DCON.dcon_realm_set_budget_spending_by_category(realm_id - 1, index, current + value)
end
---@param realm_id realm_id valid realm id
---@param index ECONOMY_REASON valid
---@return number budget_income_by_category 
function DATA.realm_get_budget_income_by_category(realm_id, index)
    assert(index ~= 0)
    return DCON.dcon_realm_get_budget_income_by_category(realm_id - 1, index)
end
---@param realm_id realm_id valid realm id
---@param index ECONOMY_REASON valid index
---@param value number valid number
function DATA.realm_set_budget_income_by_category(realm_id, index, value)
    DCON.dcon_realm_set_budget_income_by_category(realm_id - 1, index, value)
end
---@param realm_id realm_id valid realm id
---@param index ECONOMY_REASON valid index
---@param value number valid number
function DATA.realm_inc_budget_income_by_category(realm_id, index, value)
    ---@type number
    local current = DCON.dcon_realm_get_budget_income_by_category(realm_id - 1, index)
    DCON.dcon_realm_set_budget_income_by_category(realm_id - 1, index, current + value)
end
---@param realm_id realm_id valid realm id
---@param index ECONOMY_REASON valid
---@return number budget_treasury_change_by_category 
function DATA.realm_get_budget_treasury_change_by_category(realm_id, index)
    assert(index ~= 0)
    return DCON.dcon_realm_get_budget_treasury_change_by_category(realm_id - 1, index)
end
---@param realm_id realm_id valid realm id
---@param index ECONOMY_REASON valid index
---@param value number valid number
function DATA.realm_set_budget_treasury_change_by_category(realm_id, index, value)
    DCON.dcon_realm_set_budget_treasury_change_by_category(realm_id - 1, index, value)
end
---@param realm_id realm_id valid realm id
---@param index ECONOMY_REASON valid index
---@param value number valid number
function DATA.realm_inc_budget_treasury_change_by_category(realm_id, index, value)
    ---@type number
    local current = DCON.dcon_realm_get_budget_treasury_change_by_category(realm_id - 1, index)
    DCON.dcon_realm_set_budget_treasury_change_by_category(realm_id - 1, index, current + value)
end
---@param realm_id realm_id valid realm id
---@return number budget_treasury 
function DATA.realm_get_budget_treasury(realm_id)
    return DCON.dcon_realm_get_budget_treasury(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_budget_treasury(realm_id, value)
    DCON.dcon_realm_set_budget_treasury(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_budget_treasury(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_budget_treasury(realm_id - 1)
    DCON.dcon_realm_set_budget_treasury(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number budget_treasury_target 
function DATA.realm_get_budget_treasury_target(realm_id)
    return DCON.dcon_realm_get_budget_treasury_target(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_budget_treasury_target(realm_id, value)
    DCON.dcon_realm_set_budget_treasury_target(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_budget_treasury_target(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_budget_treasury_target(realm_id - 1)
    DCON.dcon_realm_set_budget_treasury_target(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@param index BUDGET_CATEGORY valid
---@return number budget 
function DATA.realm_get_budget_ratio(realm_id, index)
    assert(index ~= 0)
    return DCON.dcon_realm_get_budget(realm_id - 1, index)[0].ratio
end
---@param realm_id realm_id valid realm id
---@param index BUDGET_CATEGORY valid
---@return number budget 
function DATA.realm_get_budget_budget(realm_id, index)
    assert(index ~= 0)
    return DCON.dcon_realm_get_budget(realm_id - 1, index)[0].budget
end
---@param realm_id realm_id valid realm id
---@param index BUDGET_CATEGORY valid
---@return number budget 
function DATA.realm_get_budget_to_be_invested(realm_id, index)
    assert(index ~= 0)
    return DCON.dcon_realm_get_budget(realm_id - 1, index)[0].to_be_invested
end
---@param realm_id realm_id valid realm id
---@param index BUDGET_CATEGORY valid
---@return number budget 
function DATA.realm_get_budget_target(realm_id, index)
    assert(index ~= 0)
    return DCON.dcon_realm_get_budget(realm_id - 1, index)[0].target
end
---@param realm_id realm_id valid realm id
---@param index BUDGET_CATEGORY valid index
---@param value number valid number
function DATA.realm_set_budget_ratio(realm_id, index, value)
    DCON.dcon_realm_get_budget(realm_id - 1, index)[0].ratio = value
end
---@param realm_id realm_id valid realm id
---@param index BUDGET_CATEGORY valid index
---@param value number valid number
function DATA.realm_inc_budget_ratio(realm_id, index, value)
    ---@type number
    local current = DCON.dcon_realm_get_budget(realm_id - 1, index)[0].ratio
    DCON.dcon_realm_get_budget(realm_id - 1, index)[0].ratio = current + value
end
---@param realm_id realm_id valid realm id
---@param index BUDGET_CATEGORY valid index
---@param value number valid number
function DATA.realm_set_budget_budget(realm_id, index, value)
    DCON.dcon_realm_get_budget(realm_id - 1, index)[0].budget = value
end
---@param realm_id realm_id valid realm id
---@param index BUDGET_CATEGORY valid index
---@param value number valid number
function DATA.realm_inc_budget_budget(realm_id, index, value)
    ---@type number
    local current = DCON.dcon_realm_get_budget(realm_id - 1, index)[0].budget
    DCON.dcon_realm_get_budget(realm_id - 1, index)[0].budget = current + value
end
---@param realm_id realm_id valid realm id
---@param index BUDGET_CATEGORY valid index
---@param value number valid number
function DATA.realm_set_budget_to_be_invested(realm_id, index, value)
    DCON.dcon_realm_get_budget(realm_id - 1, index)[0].to_be_invested = value
end
---@param realm_id realm_id valid realm id
---@param index BUDGET_CATEGORY valid index
---@param value number valid number
function DATA.realm_inc_budget_to_be_invested(realm_id, index, value)
    ---@type number
    local current = DCON.dcon_realm_get_budget(realm_id - 1, index)[0].to_be_invested
    DCON.dcon_realm_get_budget(realm_id - 1, index)[0].to_be_invested = current + value
end
---@param realm_id realm_id valid realm id
---@param index BUDGET_CATEGORY valid index
---@param value number valid number
function DATA.realm_set_budget_target(realm_id, index, value)
    DCON.dcon_realm_get_budget(realm_id - 1, index)[0].target = value
end
---@param realm_id realm_id valid realm id
---@param index BUDGET_CATEGORY valid index
---@param value number valid number
function DATA.realm_inc_budget_target(realm_id, index, value)
    ---@type number
    local current = DCON.dcon_realm_get_budget(realm_id - 1, index)[0].target
    DCON.dcon_realm_get_budget(realm_id - 1, index)[0].target = current + value
end
---@param realm_id realm_id valid realm id
---@return number budget_tax_target 
function DATA.realm_get_budget_tax_target(realm_id)
    return DCON.dcon_realm_get_budget_tax_target(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_budget_tax_target(realm_id, value)
    DCON.dcon_realm_set_budget_tax_target(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_budget_tax_target(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_budget_tax_target(realm_id - 1)
    DCON.dcon_realm_set_budget_tax_target(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number budget_tax_collected_this_year 
function DATA.realm_get_budget_tax_collected_this_year(realm_id)
    return DCON.dcon_realm_get_budget_tax_collected_this_year(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_budget_tax_collected_this_year(realm_id, value)
    DCON.dcon_realm_set_budget_tax_collected_this_year(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_budget_tax_collected_this_year(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_budget_tax_collected_this_year(realm_id - 1)
    DCON.dcon_realm_set_budget_tax_collected_this_year(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number r 
function DATA.realm_get_r(realm_id)
    return DCON.dcon_realm_get_r(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_r(realm_id, value)
    DCON.dcon_realm_set_r(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_r(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_r(realm_id - 1)
    DCON.dcon_realm_set_r(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number g 
function DATA.realm_get_g(realm_id)
    return DCON.dcon_realm_get_g(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_g(realm_id, value)
    DCON.dcon_realm_set_g(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_g(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_g(realm_id - 1)
    DCON.dcon_realm_set_g(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number b 
function DATA.realm_get_b(realm_id)
    return DCON.dcon_realm_get_b(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_b(realm_id, value)
    DCON.dcon_realm_set_b(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_b(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_b(realm_id - 1)
    DCON.dcon_realm_set_b(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return race_id primary_race 
function DATA.realm_get_primary_race(realm_id)
    return DCON.dcon_realm_get_primary_race(realm_id - 1) + 1
end
---@param realm_id realm_id valid realm id
---@param value race_id valid race_id
function DATA.realm_set_primary_race(realm_id, value)
    DCON.dcon_realm_set_primary_race(realm_id - 1, value - 1)
end
---@param realm_id realm_id valid realm id
---@return culture_id primary_culture 
function DATA.realm_get_primary_culture(realm_id)
    return DCON.dcon_realm_get_primary_culture(realm_id - 1) + 1
end
---@param realm_id realm_id valid realm id
---@param value culture_id valid culture_id
function DATA.realm_set_primary_culture(realm_id, value)
    DCON.dcon_realm_set_primary_culture(realm_id - 1, value - 1)
end
---@param realm_id realm_id valid realm id
---@return faith_id primary_faith 
function DATA.realm_get_primary_faith(realm_id)
    return DCON.dcon_realm_get_primary_faith(realm_id - 1) + 1
end
---@param realm_id realm_id valid realm id
---@param value faith_id valid faith_id
function DATA.realm_set_primary_faith(realm_id, value)
    DCON.dcon_realm_set_primary_faith(realm_id - 1, value - 1)
end
---@param realm_id realm_id valid realm id
---@return province_id capitol 
function DATA.realm_get_capitol(realm_id)
    return DCON.dcon_realm_get_capitol(realm_id - 1) + 1
end
---@param realm_id realm_id valid realm id
---@param value province_id valid province_id
function DATA.realm_set_capitol(realm_id, value)
    DCON.dcon_realm_set_capitol(realm_id - 1, value - 1)
end
---@param realm_id realm_id valid realm id
---@return number trading_right_cost 
function DATA.realm_get_trading_right_cost(realm_id)
    return DCON.dcon_realm_get_trading_right_cost(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_trading_right_cost(realm_id, value)
    DCON.dcon_realm_set_trading_right_cost(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_trading_right_cost(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_trading_right_cost(realm_id - 1)
    DCON.dcon_realm_set_trading_right_cost(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number building_right_cost 
function DATA.realm_get_building_right_cost(realm_id)
    return DCON.dcon_realm_get_building_right_cost(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_building_right_cost(realm_id, value)
    DCON.dcon_realm_set_building_right_cost(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_building_right_cost(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_building_right_cost(realm_id - 1)
    DCON.dcon_realm_set_building_right_cost(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return LAW_TRADE law_trade 
function DATA.realm_get_law_trade(realm_id)
    return DCON.dcon_realm_get_law_trade(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value LAW_TRADE valid LAW_TRADE
function DATA.realm_set_law_trade(realm_id, value)
    DCON.dcon_realm_set_law_trade(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@return LAW_BUILDING law_building 
function DATA.realm_get_law_building(realm_id)
    return DCON.dcon_realm_get_law_building(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value LAW_BUILDING valid LAW_BUILDING
function DATA.realm_set_law_building(realm_id, value)
    DCON.dcon_realm_set_law_building(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@return table<province_id,nil|number> quests_raid reward for raid
function DATA.realm_get_quests_raid(realm_id)
    return DATA.realm_quests_raid[realm_id]
end
---@param realm_id realm_id valid realm id
---@param value table<province_id,nil|number> valid table<province_id,nil|number>
function DATA.realm_set_quests_raid(realm_id, value)
    DATA.realm_quests_raid[realm_id] = value
end
---@param realm_id realm_id valid realm id
---@return table<province_id,nil|number> quests_explore reward for exploration
function DATA.realm_get_quests_explore(realm_id)
    return DATA.realm_quests_explore[realm_id]
end
---@param realm_id realm_id valid realm id
---@param value table<province_id,nil|number> valid table<province_id,nil|number>
function DATA.realm_set_quests_explore(realm_id, value)
    DATA.realm_quests_explore[realm_id] = value
end
---@param realm_id realm_id valid realm id
---@return table<province_id,nil|number> quests_patrol reward for patrol
function DATA.realm_get_quests_patrol(realm_id)
    return DATA.realm_quests_patrol[realm_id]
end
---@param realm_id realm_id valid realm id
---@param value table<province_id,nil|number> valid table<province_id,nil|number>
function DATA.realm_set_quests_patrol(realm_id, value)
    DATA.realm_quests_patrol[realm_id] = value
end
---@param realm_id realm_id valid realm id
---@return table<province_id,table<warband_id,warband_id>> patrols 
function DATA.realm_get_patrols(realm_id)
    return DATA.realm_patrols[realm_id]
end
---@param realm_id realm_id valid realm id
---@param value table<province_id,table<warband_id,warband_id>> valid table<province_id,table<warband_id,warband_id>>
function DATA.realm_set_patrols(realm_id, value)
    DATA.realm_patrols[realm_id] = value
end
---@param realm_id realm_id valid realm id
---@return boolean prepare_attack_flag 
function DATA.realm_get_prepare_attack_flag(realm_id)
    return DCON.dcon_realm_get_prepare_attack_flag(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value boolean valid boolean
function DATA.realm_set_prepare_attack_flag(realm_id, value)
    DCON.dcon_realm_set_prepare_attack_flag(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@return table<province_id,province_id> known_provinces For terra incognita.
function DATA.realm_get_known_provinces(realm_id)
    return DATA.realm_known_provinces[realm_id]
end
---@param realm_id realm_id valid realm id
---@param value table<province_id,province_id> valid table<province_id,province_id>
function DATA.realm_set_known_provinces(realm_id, value)
    DATA.realm_known_provinces[realm_id] = value
end
---@param realm_id realm_id valid realm id
---@return number coa_base_r 
function DATA.realm_get_coa_base_r(realm_id)
    return DCON.dcon_realm_get_coa_base_r(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_base_r(realm_id, value)
    DCON.dcon_realm_set_coa_base_r(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_base_r(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_base_r(realm_id - 1)
    DCON.dcon_realm_set_coa_base_r(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number coa_base_g 
function DATA.realm_get_coa_base_g(realm_id)
    return DCON.dcon_realm_get_coa_base_g(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_base_g(realm_id, value)
    DCON.dcon_realm_set_coa_base_g(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_base_g(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_base_g(realm_id - 1)
    DCON.dcon_realm_set_coa_base_g(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number coa_base_b 
function DATA.realm_get_coa_base_b(realm_id)
    return DCON.dcon_realm_get_coa_base_b(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_base_b(realm_id, value)
    DCON.dcon_realm_set_coa_base_b(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_base_b(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_base_b(realm_id - 1)
    DCON.dcon_realm_set_coa_base_b(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number coa_background_r 
function DATA.realm_get_coa_background_r(realm_id)
    return DCON.dcon_realm_get_coa_background_r(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_background_r(realm_id, value)
    DCON.dcon_realm_set_coa_background_r(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_background_r(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_background_r(realm_id - 1)
    DCON.dcon_realm_set_coa_background_r(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number coa_background_g 
function DATA.realm_get_coa_background_g(realm_id)
    return DCON.dcon_realm_get_coa_background_g(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_background_g(realm_id, value)
    DCON.dcon_realm_set_coa_background_g(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_background_g(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_background_g(realm_id - 1)
    DCON.dcon_realm_set_coa_background_g(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number coa_background_b 
function DATA.realm_get_coa_background_b(realm_id)
    return DCON.dcon_realm_get_coa_background_b(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_background_b(realm_id, value)
    DCON.dcon_realm_set_coa_background_b(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_background_b(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_background_b(realm_id - 1)
    DCON.dcon_realm_set_coa_background_b(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number coa_foreground_r 
function DATA.realm_get_coa_foreground_r(realm_id)
    return DCON.dcon_realm_get_coa_foreground_r(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_foreground_r(realm_id, value)
    DCON.dcon_realm_set_coa_foreground_r(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_foreground_r(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_foreground_r(realm_id - 1)
    DCON.dcon_realm_set_coa_foreground_r(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number coa_foreground_g 
function DATA.realm_get_coa_foreground_g(realm_id)
    return DCON.dcon_realm_get_coa_foreground_g(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_foreground_g(realm_id, value)
    DCON.dcon_realm_set_coa_foreground_g(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_foreground_g(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_foreground_g(realm_id - 1)
    DCON.dcon_realm_set_coa_foreground_g(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number coa_foreground_b 
function DATA.realm_get_coa_foreground_b(realm_id)
    return DCON.dcon_realm_get_coa_foreground_b(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_foreground_b(realm_id, value)
    DCON.dcon_realm_set_coa_foreground_b(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_foreground_b(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_foreground_b(realm_id - 1)
    DCON.dcon_realm_set_coa_foreground_b(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number coa_emblem_r 
function DATA.realm_get_coa_emblem_r(realm_id)
    return DCON.dcon_realm_get_coa_emblem_r(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_emblem_r(realm_id, value)
    DCON.dcon_realm_set_coa_emblem_r(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_emblem_r(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_emblem_r(realm_id - 1)
    DCON.dcon_realm_set_coa_emblem_r(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number coa_emblem_g 
function DATA.realm_get_coa_emblem_g(realm_id)
    return DCON.dcon_realm_get_coa_emblem_g(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_emblem_g(realm_id, value)
    DCON.dcon_realm_set_coa_emblem_g(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_emblem_g(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_emblem_g(realm_id - 1)
    DCON.dcon_realm_set_coa_emblem_g(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number coa_emblem_b 
function DATA.realm_get_coa_emblem_b(realm_id)
    return DCON.dcon_realm_get_coa_emblem_b(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_emblem_b(realm_id, value)
    DCON.dcon_realm_set_coa_emblem_b(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_emblem_b(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_emblem_b(realm_id - 1)
    DCON.dcon_realm_set_coa_emblem_b(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number coa_background_image 
function DATA.realm_get_coa_background_image(realm_id)
    return DCON.dcon_realm_get_coa_background_image(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_background_image(realm_id, value)
    DCON.dcon_realm_set_coa_background_image(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_background_image(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_background_image(realm_id - 1)
    DCON.dcon_realm_set_coa_background_image(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number coa_foreground_image 
function DATA.realm_get_coa_foreground_image(realm_id)
    return DCON.dcon_realm_get_coa_foreground_image(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_foreground_image(realm_id, value)
    DCON.dcon_realm_set_coa_foreground_image(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_foreground_image(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_foreground_image(realm_id - 1)
    DCON.dcon_realm_set_coa_foreground_image(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number coa_emblem_image 
function DATA.realm_get_coa_emblem_image(realm_id)
    return DCON.dcon_realm_get_coa_emblem_image(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_coa_emblem_image(realm_id, value)
    DCON.dcon_realm_set_coa_emblem_image(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_coa_emblem_image(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_coa_emblem_image(realm_id - 1)
    DCON.dcon_realm_set_coa_emblem_image(realm_id - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@param index trade_good_id valid
---@return number resources Currently stockpiled resources
function DATA.realm_get_resources(realm_id, index)
    assert(index ~= 0)
    return DCON.dcon_realm_get_resources(realm_id - 1, index - 1)
end
---@param realm_id realm_id valid realm id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.realm_set_resources(realm_id, index, value)
    DCON.dcon_realm_set_resources(realm_id - 1, index - 1, value)
end
---@param realm_id realm_id valid realm id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.realm_inc_resources(realm_id, index, value)
    ---@type number
    local current = DCON.dcon_realm_get_resources(realm_id - 1, index - 1)
    DCON.dcon_realm_set_resources(realm_id - 1, index - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@param index trade_good_id valid
---@return number production A "balance" of resource creation
function DATA.realm_get_production(realm_id, index)
    assert(index ~= 0)
    return DCON.dcon_realm_get_production(realm_id - 1, index - 1)
end
---@param realm_id realm_id valid realm id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.realm_set_production(realm_id, index, value)
    DCON.dcon_realm_set_production(realm_id - 1, index - 1, value)
end
---@param realm_id realm_id valid realm id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.realm_inc_production(realm_id, index, value)
    ---@type number
    local current = DCON.dcon_realm_get_production(realm_id - 1, index - 1)
    DCON.dcon_realm_set_production(realm_id - 1, index - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@param index trade_good_id valid
---@return number bought 
function DATA.realm_get_bought(realm_id, index)
    assert(index ~= 0)
    return DCON.dcon_realm_get_bought(realm_id - 1, index - 1)
end
---@param realm_id realm_id valid realm id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.realm_set_bought(realm_id, index, value)
    DCON.dcon_realm_set_bought(realm_id - 1, index - 1, value)
end
---@param realm_id realm_id valid realm id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.realm_inc_bought(realm_id, index, value)
    ---@type number
    local current = DCON.dcon_realm_get_bought(realm_id - 1, index - 1)
    DCON.dcon_realm_set_bought(realm_id - 1, index - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@param index trade_good_id valid
---@return number sold 
function DATA.realm_get_sold(realm_id, index)
    assert(index ~= 0)
    return DCON.dcon_realm_get_sold(realm_id - 1, index - 1)
end
---@param realm_id realm_id valid realm id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.realm_set_sold(realm_id, index, value)
    DCON.dcon_realm_set_sold(realm_id - 1, index - 1, value)
end
---@param realm_id realm_id valid realm id
---@param index trade_good_id valid index
---@param value number valid number
function DATA.realm_inc_sold(realm_id, index, value)
    ---@type number
    local current = DCON.dcon_realm_get_sold(realm_id - 1, index - 1)
    DCON.dcon_realm_set_sold(realm_id - 1, index - 1, current + value)
end
---@param realm_id realm_id valid realm id
---@return number expected_food_consumption 
function DATA.realm_get_expected_food_consumption(realm_id)
    return DCON.dcon_realm_get_expected_food_consumption(realm_id - 1)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_set_expected_food_consumption(realm_id, value)
    DCON.dcon_realm_set_expected_food_consumption(realm_id - 1, value)
end
---@param realm_id realm_id valid realm id
---@param value number valid number
function DATA.realm_inc_expected_food_consumption(realm_id, value)
    ---@type number
    local current = DCON.dcon_realm_get_expected_food_consumption(realm_id - 1)
    DCON.dcon_realm_set_expected_food_consumption(realm_id - 1, current + value)
end

local fat_realm_id_metatable = {
    __index = function (t,k)
        if (k == "exists") then return DATA.realm_get_exists(t.id) end
        if (k == "name") then return DATA.realm_get_name(t.id) end
        if (k == "budget_change") then return DATA.realm_get_budget_change(t.id) end
        if (k == "budget_saved_change") then return DATA.realm_get_budget_saved_change(t.id) end
        if (k == "budget_treasury") then return DATA.realm_get_budget_treasury(t.id) end
        if (k == "budget_treasury_target") then return DATA.realm_get_budget_treasury_target(t.id) end
        if (k == "budget_tax_target") then return DATA.realm_get_budget_tax_target(t.id) end
        if (k == "budget_tax_collected_this_year") then return DATA.realm_get_budget_tax_collected_this_year(t.id) end
        if (k == "r") then return DATA.realm_get_r(t.id) end
        if (k == "g") then return DATA.realm_get_g(t.id) end
        if (k == "b") then return DATA.realm_get_b(t.id) end
        if (k == "primary_race") then return DATA.realm_get_primary_race(t.id) end
        if (k == "primary_culture") then return DATA.realm_get_primary_culture(t.id) end
        if (k == "primary_faith") then return DATA.realm_get_primary_faith(t.id) end
        if (k == "capitol") then return DATA.realm_get_capitol(t.id) end
        if (k == "trading_right_cost") then return DATA.realm_get_trading_right_cost(t.id) end
        if (k == "building_right_cost") then return DATA.realm_get_building_right_cost(t.id) end
        if (k == "law_trade") then return DATA.realm_get_law_trade(t.id) end
        if (k == "law_building") then return DATA.realm_get_law_building(t.id) end
        if (k == "quests_raid") then return DATA.realm_get_quests_raid(t.id) end
        if (k == "quests_explore") then return DATA.realm_get_quests_explore(t.id) end
        if (k == "quests_patrol") then return DATA.realm_get_quests_patrol(t.id) end
        if (k == "patrols") then return DATA.realm_get_patrols(t.id) end
        if (k == "prepare_attack_flag") then return DATA.realm_get_prepare_attack_flag(t.id) end
        if (k == "known_provinces") then return DATA.realm_get_known_provinces(t.id) end
        if (k == "coa_base_r") then return DATA.realm_get_coa_base_r(t.id) end
        if (k == "coa_base_g") then return DATA.realm_get_coa_base_g(t.id) end
        if (k == "coa_base_b") then return DATA.realm_get_coa_base_b(t.id) end
        if (k == "coa_background_r") then return DATA.realm_get_coa_background_r(t.id) end
        if (k == "coa_background_g") then return DATA.realm_get_coa_background_g(t.id) end
        if (k == "coa_background_b") then return DATA.realm_get_coa_background_b(t.id) end
        if (k == "coa_foreground_r") then return DATA.realm_get_coa_foreground_r(t.id) end
        if (k == "coa_foreground_g") then return DATA.realm_get_coa_foreground_g(t.id) end
        if (k == "coa_foreground_b") then return DATA.realm_get_coa_foreground_b(t.id) end
        if (k == "coa_emblem_r") then return DATA.realm_get_coa_emblem_r(t.id) end
        if (k == "coa_emblem_g") then return DATA.realm_get_coa_emblem_g(t.id) end
        if (k == "coa_emblem_b") then return DATA.realm_get_coa_emblem_b(t.id) end
        if (k == "coa_background_image") then return DATA.realm_get_coa_background_image(t.id) end
        if (k == "coa_foreground_image") then return DATA.realm_get_coa_foreground_image(t.id) end
        if (k == "coa_emblem_image") then return DATA.realm_get_coa_emblem_image(t.id) end
        if (k == "expected_food_consumption") then return DATA.realm_get_expected_food_consumption(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "exists") then
            DATA.realm_set_exists(t.id, v)
            return
        end
        if (k == "name") then
            DATA.realm_set_name(t.id, v)
            return
        end
        if (k == "budget_change") then
            DATA.realm_set_budget_change(t.id, v)
            return
        end
        if (k == "budget_saved_change") then
            DATA.realm_set_budget_saved_change(t.id, v)
            return
        end
        if (k == "budget_treasury") then
            DATA.realm_set_budget_treasury(t.id, v)
            return
        end
        if (k == "budget_treasury_target") then
            DATA.realm_set_budget_treasury_target(t.id, v)
            return
        end
        if (k == "budget_tax_target") then
            DATA.realm_set_budget_tax_target(t.id, v)
            return
        end
        if (k == "budget_tax_collected_this_year") then
            DATA.realm_set_budget_tax_collected_this_year(t.id, v)
            return
        end
        if (k == "r") then
            DATA.realm_set_r(t.id, v)
            return
        end
        if (k == "g") then
            DATA.realm_set_g(t.id, v)
            return
        end
        if (k == "b") then
            DATA.realm_set_b(t.id, v)
            return
        end
        if (k == "primary_race") then
            DATA.realm_set_primary_race(t.id, v)
            return
        end
        if (k == "primary_culture") then
            DATA.realm_set_primary_culture(t.id, v)
            return
        end
        if (k == "primary_faith") then
            DATA.realm_set_primary_faith(t.id, v)
            return
        end
        if (k == "capitol") then
            DATA.realm_set_capitol(t.id, v)
            return
        end
        if (k == "trading_right_cost") then
            DATA.realm_set_trading_right_cost(t.id, v)
            return
        end
        if (k == "building_right_cost") then
            DATA.realm_set_building_right_cost(t.id, v)
            return
        end
        if (k == "law_trade") then
            DATA.realm_set_law_trade(t.id, v)
            return
        end
        if (k == "law_building") then
            DATA.realm_set_law_building(t.id, v)
            return
        end
        if (k == "quests_raid") then
            DATA.realm_set_quests_raid(t.id, v)
            return
        end
        if (k == "quests_explore") then
            DATA.realm_set_quests_explore(t.id, v)
            return
        end
        if (k == "quests_patrol") then
            DATA.realm_set_quests_patrol(t.id, v)
            return
        end
        if (k == "patrols") then
            DATA.realm_set_patrols(t.id, v)
            return
        end
        if (k == "prepare_attack_flag") then
            DATA.realm_set_prepare_attack_flag(t.id, v)
            return
        end
        if (k == "known_provinces") then
            DATA.realm_set_known_provinces(t.id, v)
            return
        end
        if (k == "coa_base_r") then
            DATA.realm_set_coa_base_r(t.id, v)
            return
        end
        if (k == "coa_base_g") then
            DATA.realm_set_coa_base_g(t.id, v)
            return
        end
        if (k == "coa_base_b") then
            DATA.realm_set_coa_base_b(t.id, v)
            return
        end
        if (k == "coa_background_r") then
            DATA.realm_set_coa_background_r(t.id, v)
            return
        end
        if (k == "coa_background_g") then
            DATA.realm_set_coa_background_g(t.id, v)
            return
        end
        if (k == "coa_background_b") then
            DATA.realm_set_coa_background_b(t.id, v)
            return
        end
        if (k == "coa_foreground_r") then
            DATA.realm_set_coa_foreground_r(t.id, v)
            return
        end
        if (k == "coa_foreground_g") then
            DATA.realm_set_coa_foreground_g(t.id, v)
            return
        end
        if (k == "coa_foreground_b") then
            DATA.realm_set_coa_foreground_b(t.id, v)
            return
        end
        if (k == "coa_emblem_r") then
            DATA.realm_set_coa_emblem_r(t.id, v)
            return
        end
        if (k == "coa_emblem_g") then
            DATA.realm_set_coa_emblem_g(t.id, v)
            return
        end
        if (k == "coa_emblem_b") then
            DATA.realm_set_coa_emblem_b(t.id, v)
            return
        end
        if (k == "coa_background_image") then
            DATA.realm_set_coa_background_image(t.id, v)
            return
        end
        if (k == "coa_foreground_image") then
            DATA.realm_set_coa_foreground_image(t.id, v)
            return
        end
        if (k == "coa_emblem_image") then
            DATA.realm_set_coa_emblem_image(t.id, v)
            return
        end
        if (k == "expected_food_consumption") then
            DATA.realm_set_expected_food_consumption(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id realm_id
---@return fat_realm_id fat_id
function DATA.fatten_realm(id)
    local result = {id = id}
    setmetatable(result, fat_realm_id_metatable)
    return result --[[@as fat_realm_id]]
end
