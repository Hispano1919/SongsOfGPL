local language_utils = require "game.entities.language".Language

local cl = {}


-- Módulo para manejar espíritus (Lua puro)
local spirit_module = require "game.entities.spirit"

cl.Spirit = {}
cl.Spirit.__index = cl.Spirit
---@param domain string
---@param culture culture_id
---@return spirit_id
function cl.Spirit:new(domain,culture)
    local spirit = spirit_module.create_spirit()
    
    spirit_module.set_name(spirit, language_utils.get_random_name(DATA.culture_get_language(culture)))
    spirit_module.set_domain(spirit, domain)
    spirit_module.set_rank(spirit, 1)
    
    return spirit
end


cl.Religion = {}
cl.Religion.__index = cl.Religion
---@param culture culture_id
---@return religion_id
function cl.Religion:new(culture)
	local religion = DATA.create_religion()

	DATA.religion_set_r(religion, love.math.random())
	DATA.religion_set_g(religion, love.math.random())
	DATA.religion_set_b(religion, love.math.random())

	DATA.religion_set_name(religion, language_utils.get_random_faith_name(DATA.culture_get_language(culture)))

	return religion
end

---@class Faith
cl.Faith = {}
cl.Faith.__index = cl.Faith

---@param religion religion_id
---@param culture culture_id
---@return faith_id
function cl.Faith:new(religion, culture)
	local faith = DATA.create_faith()

	DATA.faith_set_religion(faith, religion)  -- <- Línea añadida


	DATA.faith_set_r(faith, DATA.religion_get_r(religion))
	DATA.faith_set_g(faith, DATA.religion_get_g(religion))
	DATA.faith_set_b(faith, DATA.religion_get_b(religion))

	DATA.force_create_subreligion(religion, faith)
	DATA.faith_set_name(faith, language_utils.get_random_faith_name(DATA.culture_get_language(culture)))
	DATA.faith_set_burial_rites(faith, BURIAL_RIGHTS.BURIAL)

	DATA.faith_set_birth_rites(faith, BIRTH_RITES.BLESSING)
    DATA.faith_set_passage_rites(faith, PASSAGE_RITES.COMING_OF_AGE)
    DATA.faith_set_disease_rites(faith, DISEASE_RITES.HEALING_PRAYER)

	local spirit = cl.Spirit:new("Fuego",culture)  -- <-- Agregar local aquí
	DATA.faith_set_spirit(faith, spirit)  -- Necesitarías crear esta función en tu módulo DATA


	return faith
end

---@class Rite
cl.Rite = {}
cl.Rite.__index = cl.Rite
---@param faith faith_id
---@param culture culture_id
---@return rite_id
function cl.Rite:new(faith, culture)
    local rite = DATA.create_rite()  -- Necesitarías implementar esto
    
    DATA.rite_set_faith(rite, faith)
    DATA.rite_set_name(rite, language_utils.get_random_faith_name(DATA.culture_get_language(culture)))
    
    return rite
end

return cl
