local WarbandEffects = {}

---Sets character as a recruiter of warband
---@param character Character
---@param warband Warband
function WarbandEffects.set_recruiter(warband, character)
	local recruiter_warband = DATA.get_warband_recruiter_from_warband(warband)
	if recruiter_warband ~= INVALID_ID then
		DATA.warband_recruiter_set_recruiter(recruiter_warband, character)
	else
		DATA.force_create_warband_recruiter(character, warband)
	end
end

---unets character as a recruiter of warband
---@param character Character
---@param warband Warband
function WarbandEffects.unset_recruiter(warband, character)
	local recruiter_warband = DATA.get_warband_recruiter_from_warband(warband)
	if recruiter_warband ~= INVALID_ID then
		DATA.delete_warband_recruiter(recruiter_warband)
	end
end

return WarbandEffects