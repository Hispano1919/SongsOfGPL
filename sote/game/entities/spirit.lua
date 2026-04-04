local language_utils = require "game.entities.language".Language

local spirit_module = {}

if DATA.spirit_name == nil then DATA.spirit_name = {} end
if DATA.spirit_domain == nil then DATA.spirit_domain = {} end
if DATA.spirit_rank == nil then DATA.spirit_rank = {} end
if DATA.faith_spirit_primary == nil then DATA.faith_spirit_primary = {} end
if DATA.faith_spirits == nil then DATA.faith_spirits = {} end
if DATA.spirit_next_id == nil then DATA.spirit_next_id = 1 end

---@return spirit_id
function spirit_module.create_spirit()
    local spirit_id = DATA.spirit_next_id
    DATA.spirit_next_id = DATA.spirit_next_id + 1

    DATA.spirit_name[spirit_id] = ""
    DATA.spirit_domain[spirit_id] = ""
    DATA.spirit_rank[spirit_id] = 1

    return spirit_id
end

---@param spirit spirit_id
---@param value string
function spirit_module.set_name(spirit, value)
    DATA.spirit_name[spirit] = value
end

---@param spirit spirit_id
---@return string
function spirit_module.get_name(spirit)
    return DATA.spirit_name[spirit] or ""
end

---@param spirit spirit_id
---@param value string
function spirit_module.set_domain(spirit, value)
    DATA.spirit_domain[spirit] = value
end

---@param spirit spirit_id
---@return string
function spirit_module.get_domain(spirit)
    return DATA.spirit_domain[spirit] or ""
end

---@param spirit spirit_id
---@param value number
function spirit_module.set_rank(spirit, value)
    DATA.spirit_rank[spirit] = value
end

---@param spirit spirit_id
---@return number
function spirit_module.get_rank(spirit)
    return DATA.spirit_rank[spirit] or 0
end

---@param faith faith_id
---@param spirit spirit_id
function spirit_module.add_spirit_to_faith(faith, spirit)
    if DATA.faith_spirits[faith] == nil then
        DATA.faith_spirits[faith] = {}
    end

    for _, current in ipairs(DATA.faith_spirits[faith]) do
        if current == spirit then
            return
        end
    end

    table.insert(DATA.faith_spirits[faith], spirit)
end

---@param faith faith_id
---@return spirit_id[]
function spirit_module.get_spirits_from_faith(faith)
    if DATA.faith_spirits[faith] == nil then
        DATA.faith_spirits[faith] = {}
    end

    return DATA.faith_spirits[faith]
end

---@param culture culture_id
---@return spirit_id
function spirit_module.create_random_spirit(culture)
    local spirit = spirit_module.create_spirit()
    spirit_module.set_name(spirit, language_utils.get_random_name(DATA.culture_get_language(culture)))
    spirit_module.set_rank(spirit, 1)
    return spirit
end

---@param faith faith_id
---@param spirit spirit_id
function DATA.faith_set_spirit(faith, spirit)
    DATA.faith_spirit_primary[faith] = spirit
    spirit_module.add_spirit_to_faith(faith, spirit)
end

---@param faith faith_id
---@return spirit_id
function DATA.faith_get_spirit(faith)
    return DATA.faith_spirit_primary[faith] or INVALID_ID
end

---@param faith faith_id
---@return spirit_id[]
function DATA.faith_get_spirits(faith)
    return spirit_module.get_spirits_from_faith(faith)
end

---@param spirit spirit_id
---@return string
function DATA.spirit_get_name(spirit)
    return spirit_module.get_name(spirit)
end

---@param spirit spirit_id
---@return string
function DATA.spirit_get_domain(spirit)
    return spirit_module.get_domain(spirit)
end

---@param spirit spirit_id
---@return number
function DATA.spirit_get_rank(spirit)
    return spirit_module.get_rank(spirit)
end

return spirit_module
