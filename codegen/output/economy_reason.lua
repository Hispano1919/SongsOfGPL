local ffi = require("ffi")
----------economy_reason----------


---economy_reason: LSP types---

---Unique identificator for economy_reason entity
---@class (exact) economy_reason_id : table
---@field is_economy_reason number
---@class (exact) fat_economy_reason_id
---@field id economy_reason_id Unique economy_reason id
---@field name string 
---@field description string 

---@class struct_economy_reason

---@class (exact) economy_reason_id_data_blob_definition
---@field name string 
---@field description string 
---Sets values of economy_reason for given id
---@param id economy_reason_id
---@param data economy_reason_id_data_blob_definition
function DATA.setup_economy_reason(id, data)
    DATA.economy_reason_set_name(id, data.name)
    DATA.economy_reason_set_description(id, data.description)
end

ffi.cdef[[
int32_t dcon_create_economy_reason();
bool dcon_economy_reason_is_valid(int32_t);
void dcon_economy_reason_resize(uint32_t sz);
uint32_t dcon_economy_reason_size();
]]

---economy_reason: FFI arrays---
---@type (string)[]
DATA.economy_reason_name= {}
---@type (string)[]
DATA.economy_reason_description= {}

---economy_reason: LUA bindings---

DATA.economy_reason_size = 38
---@return economy_reason_id
function DATA.create_economy_reason()
    ---@type economy_reason_id
    local i  = DCON.dcon_create_economy_reason() + 1
    return i --[[@as economy_reason_id]] 
end
---@param func fun(item: economy_reason_id) 
function DATA.for_each_economy_reason(func)
    ---@type number
    local range = DCON.dcon_economy_reason_size()
    for i = 0, range - 1 do
        func(i + 1 --[[@as economy_reason_id]])
    end
end
---@param func fun(item: economy_reason_id):boolean 
---@return table<economy_reason_id, economy_reason_id> 
function DATA.filter_economy_reason(func)
    ---@type table<economy_reason_id, economy_reason_id> 
    local t = {}
    ---@type number
    local range = DCON.dcon_economy_reason_size()
    for i = 0, range - 1 do
        if func(i + 1 --[[@as economy_reason_id]]) then t[i + 1 --[[@as economy_reason_id]]] = t[i + 1 --[[@as economy_reason_id]]] end
    end
    return t
end

---@param economy_reason_id economy_reason_id valid economy_reason id
---@return string name 
function DATA.economy_reason_get_name(economy_reason_id)
    return DATA.economy_reason_name[economy_reason_id]
end
---@param economy_reason_id economy_reason_id valid economy_reason id
---@param value string valid string
function DATA.economy_reason_set_name(economy_reason_id, value)
    DATA.economy_reason_name[economy_reason_id] = value
end
---@param economy_reason_id economy_reason_id valid economy_reason id
---@return string description 
function DATA.economy_reason_get_description(economy_reason_id)
    return DATA.economy_reason_description[economy_reason_id]
end
---@param economy_reason_id economy_reason_id valid economy_reason id
---@param value string valid string
function DATA.economy_reason_set_description(economy_reason_id, value)
    DATA.economy_reason_description[economy_reason_id] = value
end

local fat_economy_reason_id_metatable = {
    __index = function (t,k)
        if (k == "name") then return DATA.economy_reason_get_name(t.id) end
        if (k == "description") then return DATA.economy_reason_get_description(t.id) end
        return rawget(t, k)
    end,
    __newindex = function (t,k,v)
        if (k == "name") then
            DATA.economy_reason_set_name(t.id, v)
            return
        end
        if (k == "description") then
            DATA.economy_reason_set_description(t.id, v)
            return
        end
        rawset(t, k, v)
    end
}
---@param id economy_reason_id
---@return fat_economy_reason_id fat_id
function DATA.fatten_economy_reason(id)
    local result = {id = id}
    setmetatable(result, fat_economy_reason_id_metatable)
    return result --[[@as fat_economy_reason_id]]
end
---@enum ECONOMY_REASON
ECONOMY_REASON = {
    INVALID = 0,
    BASIC_NEEDS = 1,
    WELFARE = 2,
    RAID = 3,
    DONATION = 4,
    MONTHLY_CHANGE = 5,
    YEARLY_CHANGE = 6,
    INFRASTRUCTURE = 7,
    EDUCATION = 8,
    COURT = 9,
    MILITARY = 10,
    EXPLORATION = 11,
    UPKEEP = 12,
    NEW_MONTH = 13,
    LOYALTY_GIFT = 14,
    BUILDING = 15,
    BUILDING_INCOME = 16,
    TREASURY = 17,
    BUDGET = 18,
    WASTE = 19,
    TRIBUTE = 20,
    INHERITANCE = 21,
    TRADE = 22,
    WARBAND = 23,
    WATER = 24,
    FOOD = 25,
    OTHER_NEEDS = 26,
    FORAGE = 27,
    WORK = 28,
    OTHER = 29,
    SIPHON = 30,
    TRADE_SIPHON = 31,
    QUEST = 32,
    NEIGHBOR_SIPHON = 33,
    COLONISATION = 34,
    TAX = 35,
    NEGOTIATIONS = 36,
}
local index_economy_reason
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Basic_Needs")
DATA.economy_reason_set_description(index_economy_reason, "Basic needs")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Welfare")
DATA.economy_reason_set_description(index_economy_reason, "Welfare")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Raid")
DATA.economy_reason_set_description(index_economy_reason, "Raid")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Donation")
DATA.economy_reason_set_description(index_economy_reason, "Donation")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Monthly_Change")
DATA.economy_reason_set_description(index_economy_reason, "Monthly change")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Yearly_Change")
DATA.economy_reason_set_description(index_economy_reason, "Yearly change")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Infrastructure")
DATA.economy_reason_set_description(index_economy_reason, "Infrastructure")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Education")
DATA.economy_reason_set_description(index_economy_reason, "Education")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Court")
DATA.economy_reason_set_description(index_economy_reason, "Court")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Military")
DATA.economy_reason_set_description(index_economy_reason, "Military")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Exploration")
DATA.economy_reason_set_description(index_economy_reason, "Exploration")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Upkeep")
DATA.economy_reason_set_description(index_economy_reason, "Upkeep")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "New_Month")
DATA.economy_reason_set_description(index_economy_reason, "New month")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Loyalty_Gift")
DATA.economy_reason_set_description(index_economy_reason, "Loyalty gift")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Building")
DATA.economy_reason_set_description(index_economy_reason, "Building")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Building_Income")
DATA.economy_reason_set_description(index_economy_reason, "Building income")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Treasury")
DATA.economy_reason_set_description(index_economy_reason, "Treasury")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Budget")
DATA.economy_reason_set_description(index_economy_reason, "Budget")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Waste")
DATA.economy_reason_set_description(index_economy_reason, "Waste")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Tribute")
DATA.economy_reason_set_description(index_economy_reason, "Tribute")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Inheritance")
DATA.economy_reason_set_description(index_economy_reason, "Inheritance")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Trade")
DATA.economy_reason_set_description(index_economy_reason, "Trade")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Warband")
DATA.economy_reason_set_description(index_economy_reason, "Warband")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Water")
DATA.economy_reason_set_description(index_economy_reason, "Water")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Food")
DATA.economy_reason_set_description(index_economy_reason, "Food")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Other_Needs")
DATA.economy_reason_set_description(index_economy_reason, "Other needs")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Forage")
DATA.economy_reason_set_description(index_economy_reason, "Forage")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Work")
DATA.economy_reason_set_description(index_economy_reason, "Work")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Other")
DATA.economy_reason_set_description(index_economy_reason, "Other")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Siphon")
DATA.economy_reason_set_description(index_economy_reason, "Siphon")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Trade_Siphon")
DATA.economy_reason_set_description(index_economy_reason, "Trade siphon")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Quest")
DATA.economy_reason_set_description(index_economy_reason, "Quest")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Neighbor_Siphon")
DATA.economy_reason_set_description(index_economy_reason, "Neigbour siphon")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Colonisation")
DATA.economy_reason_set_description(index_economy_reason, "Colonisation")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Tax")
DATA.economy_reason_set_description(index_economy_reason, "Tax")
index_economy_reason = DATA.create_economy_reason()
DATA.economy_reason_set_name(index_economy_reason, "Negotiations")
DATA.economy_reason_set_description(index_economy_reason, "Negotiations")
