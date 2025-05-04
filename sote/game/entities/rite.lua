-- game/entities/rite.lua
-- Low-level module to manage rites
local rite = {
    data = {},
    last_id = 0
}

---@class rite_id
---@field id number

---@return rite_id
function rite.create_rite()
    local new_id = rite.last_id + 1
    rite.last_id = new_id
    
    -- Initialize the rite data structure
    rite.data[new_id] = {
        id = new_id,
        name = "",
        faith = nil,
        spirits = {}  -- list of spirit_id
    }

    return { id = new_id }
end

---@param rite_id rite_id
function rite.delete_rite(rite_id)
    rite.data[rite_id.id] = nil
end

---@param rite_id rite_id
---@return string
function rite.get_name(rite_id)
    return rite.data[rite_id.id].name
end

---@param rite_id rite_id
---@param name string
function rite.set_name(rite_id, name)
    rite.data[rite_id.id].name = name
end

---@param rite_id rite_id
---@return faith_id
function rite.get_faith(rite_id)
    return rite.data[rite_id.id].faith
end

---@param rite_id rite_id
---@param faith faith_id
function rite.set_faith(rite_id, faith)
    rite.data[rite_id.id].faith = faith
end

---@param rite_id rite_id
---@return spirit_id[]
function rite.get_spirits(rite_id)
    return rite.data[rite_id.id].spirits
end

---@param rite_id rite_id
---@param spirit_id spirit_id
function rite.add_spirit(rite_id, spirit_id)
    table.insert(rite.data[rite_id.id].spirits, spirit_id)
end

---@param rite_id rite_id
---@param spirit_id spirit_id
function rite.remove_spirit(rite_id, spirit_id)
    local list = rite.data[rite_id.id].spirits
    for i, sp in ipairs(list) do
        if sp.id == spirit_id.id then
            table.remove(list, i)
            return
        end
    end
end

return rite
