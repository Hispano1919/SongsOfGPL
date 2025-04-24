local language_utils = require "game.entities.language".Language

local cl = {}


cl.Spirit = {}
cl.Spirit.__index = cl.Spirit
---@param domain string
---@param culture culture_id
---@return deity_id
function cl.Spirit:new(domain, culture)
    local deity = DATA.create_deity()  -- Asume función de creación
    
    DATA.deity_set_name(deity, language_utils.get_random_name(DATA.culture_get_language(culture)))
    DATA.deity_set_domain(deity, domain)
    DATA.deity_set_rank(deity, 1)
    
    return deity
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
