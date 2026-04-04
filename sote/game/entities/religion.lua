local language_utils = require "game.entities.language".Language

local cl = {}

local spirit_module = require "game.entities.spirit"

---@param faith faith_id
---@return religion_id
function DATA.faith_get_religion(faith)
	local subreligion = DATA.get_subreligion_from_faith(faith)
	if subreligion == INVALID_ID then
		return INVALID_ID
	end
	return DATA.subreligion_get_religion(subreligion)
end

---@param faith faith_id
---@param religion religion_id
function DATA.faith_set_religion(faith, religion)
	local subreligion = DATA.get_subreligion_from_faith(faith)
	if subreligion == INVALID_ID then
		DATA.force_create_subreligion(religion, faith)
		return
	end
	DATA.subreligion_set_religion(subreligion, religion)
end

cl.Spirit = {}
cl.Spirit.__index = cl.Spirit

---@param domain string
---@param culture culture_id
---@return number
function cl.Spirit:new(domain, culture)
	local spirit = spirit_module.create_random_spirit(culture)
	spirit_module.set_domain(spirit, domain)
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

	DATA.faith_set_religion(faith, religion)
	DATA.faith_set_r(faith, DATA.religion_get_r(religion))
	DATA.faith_set_g(faith, DATA.religion_get_g(religion))
	DATA.faith_set_b(faith, DATA.religion_get_b(religion))
	DATA.faith_set_name(faith, language_utils.get_random_faith_name(DATA.culture_get_language(culture)))
	DATA.faith_set_burial_rites(faith, BURIAL_RIGHTS.BURIAL)

	local spirit = cl.Spirit:new("Fuego", culture)
	DATA.faith_set_spirit(faith, spirit)

	return faith
end

return cl
