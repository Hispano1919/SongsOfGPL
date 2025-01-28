local tabb = require "engine.table"

-- TODO: use an actual min heap

local movement_cost = require "game.world-gen.province-movement-cost".single_tile_cost
local tile_utils = require "game.entities.tile"

local pa = {}

---@alias pathfinding_cache table<province_id, table<province_id, tile_id[]>>

---@type (pathfinding_cache|nil)[]
local PATHFINDING_CACHE = {}

---@param tab table<tile_id, number>
---@return tile_id, number
local function get_min(tab)
	local cost = math.huge
	local ret = nil
	for prov, prov_cost in pairs(tab) do
		if prov_cost < cost then
			cost = prov_cost
			ret = prov
		end
	end

	assert(ret ~= nil)

	tab[ret] = nil
	return ret, cost
end

---@class speed
---@field base number
---@field river_fast boolean
---@field forest_fast boolean
---@field can_fly boolean

---@type speed
local dummy_speed = {
	base = 1, river_fast = false, can_fly = false, forest_fast = false
}

local root_of_two = math.sqrt(2)

---commenting
---@param tile tile_id
---@param speed speed
function pa.tile_speed(tile, speed)
	local forestation = DATA.tile_get_broadleaf(tile) + DATA.tile_get_conifer(tile) + DATA.tile_get_shrub(tile) * 0.1
	local waterflow = math.min(DATA.tile_get_july_waterflow(tile), DATA.tile_get_january_waterflow(tile))

	local speed_value = speed.base
	if speed.river_fast then
		---@type number
		speed_value = speed_value * (1 + waterflow / 10)
	end
	if not speed.forest_fast then
		---@type number
		speed_value = speed_value * (1 - forestation * 0.95)
	end

	return speed_value
end

---works only for neighbors
---@param A tile_id
---@param B tile_id
---@param speed speed
---@param is_corner boolean|nil
---@return number
function pa.tile_distance(A, B, speed, is_corner)
	if is_corner == nil then
		is_corner = true
		for neigh in tile_utils.iter_neighbors(A) do
			if neigh == B then
				is_corner = false
			end
		end
	end

	local move_cost_A = movement_cost(A)
	local move_cost_B = movement_cost(B)
	local movement_cost_mod = 100
	if not speed.can_fly then
		movement_cost_mod = movement_cost_mod * (1 + math.max(0, DATA.tile_get_elevation(A) - DATA.tile_get_elevation(B)) / 50)
	end
	if is_corner then
		movement_cost_mod = movement_cost_mod * root_of_two
	end
	return 0.5 * (move_cost_A / pa.tile_speed(A, speed) + move_cost_B / pa.tile_speed(B, speed)) * movement_cost_mod
end

---Pathfinds from origin province to target province, returns the travel time in hours and the path itself (can only pathfind from land to land or from sea to sea)
---@param origin tile_id
---@param target tile_id
---@param speed nil|speed Adjusts movement costs of provinces
---@param allowed_provinces table<Province, Province> Provinces allowed for pathfinding
---@return number,tile_id[]|nil
function pa.pathfind(origin, target, speed, allowed_provinces)

	if speed == nil then
		speed = dummy_speed
	end

	if DATA.tile_get_pathfinding_index(origin) ~= DATA.tile_get_pathfinding_index(target) then
		return math.huge, nil
	end

	---@type table<tile_id, number>
	local qq = {} -- maps provinces to their distances
	---@type table<tile_id, number>
	local distance_cache = {}
	---@type table<tile_id, boolean>
	local visited = {}
	---@type table<tile_id, tile_id>
	local prev = {}

	--[[
15         u ← Q.extract_min()                    // Remove and return best vertex
16         for each neighbor v of u:              // only v that are still in Q
17             alt ← dist[u] + Graph.Edges(u, v)
18             if alt < dist[v]:
19                 dist[v] ← alt
20                 prev[v] ← u
21                 Q.decrease_priority(v, alt)
22
23     return dist, prev
	]]

	-- queue size
	---@type number
	local q_size = 1
	qq[origin] = 0
	distance_cache[origin] = 0

	---@type tile_id[]
	local path = nil

	--- check if there is a path between provinces in the cache
	local cache_index = 0
	if speed.can_fly then
		cache_index = cache_index + 1
	end
	if speed.forest_fast then
		cache_index = cache_index + 2
	end
	if speed.river_fast then
		cache_index = cache_index + 4
	end

	local starting_province = TILE_PROVINCE(origin)
	local ending_province = TILE_PROVINCE(target)

	local connects_centers = false

	if origin == DATA.province_get_center(starting_province) and target == DATA.province_get_center(ending_province) then
		connects_centers = true
		if PATHFINDING_CACHE[cache_index] then
			if PATHFINDING_CACHE[cache_index][starting_province] then
				if PATHFINDING_CACHE[cache_index][starting_province][ending_province] then
					path = PATHFINDING_CACHE[cache_index][starting_province][ending_province]
				end
			end
		end
	end

	if path == nil then
		-- Djikstra flood fill thing
		while q_size > 0 do
			local tile, dist = get_min(qq)
			q_size = q_size - 1
			visited[tile] = true

			if tile == target then
				break -- We found the path!
			end
			-- allow corners:

			local candidates = {}
			local candidates_corners = {}

			for neigh in tile_utils.iter_neighbors(tile) do
				local neigh_province_membership = DATA.get_tile_province_membership_from_tile(neigh)
				local neigh_province = DATA.tile_province_membership_get_province(neigh_province_membership)
				if DATA.tile_get_is_land(neigh) == DATA.tile_get_is_land(tile) and allowed_provinces[neigh_province] then
					table.insert(candidates, neigh)
					for neigh_of_neigh in tile_utils.iter_neighbors(neigh) do
						local neigh_of_neigh_province_membership = DATA.get_tile_province_membership_from_tile(neigh)
						local neigh_of_neigh_province = DATA.tile_province_membership_get_province(neigh_province_membership)
						if DATA.tile_get_is_land(neigh) == DATA.tile_get_is_land(neigh_of_neigh) and allowed_provinces[neigh_province] then
							if candidates_corners[neigh_of_neigh] then
								candidates_corners[neigh_of_neigh] = candidates_corners[neigh_of_neigh] + 1
							else
								candidates_corners[neigh_of_neigh] = 1
							end
						end
					end
				end
			end

			for _, neigh in pairs(candidates) do
				if visited[neigh] ~= true then
					local alt = dist + pa.tile_distance(tile, neigh, speed, false)
					local old_distance = distance_cache[neigh] or math.huge

					if alt < old_distance then
						distance_cache[neigh] = alt
						prev[neigh] = tile
						if qq[neigh] == nil then
							qq[neigh] = alt
							---@type number
							q_size = q_size + 1
						else
							qq[neigh] = alt
						end
					end
				end
			end

			for corner, count in pairs(candidates_corners) do
				if count < 2 then
					goto continue
				end

				local neigh = corner
				if visited[neigh] ~= true then
					local alt = dist + pa.tile_distance(tile, neigh, speed, true)
					local old_distance = distance_cache[neigh] or math.huge

					if alt < old_distance then
						distance_cache[neigh] = alt
						prev[neigh] = tile
						if qq[neigh] == nil then
							qq[neigh] = alt
							---@type number
							q_size = q_size + 1
						else
							qq[neigh] = alt
						end
					end
				end

				::continue::
			end
		end
		-- Get the path
		path = {}
		local u = target
		local total_cost = 0
		while prev[u] do
			path[#path + 1] = u
			---@type number
			total_cost = total_cost + pa.tile_distance(u, prev[u], speed)
			u = prev[u]
		end
		--total_cost = total_cost - 0.5 * (origin.movement_cost + target.movement_cost)

		if connects_centers then
			if PATHFINDING_CACHE[cache_index] == nil then
				PATHFINDING_CACHE[cache_index] = {}
			end

			if PATHFINDING_CACHE[cache_index][starting_province] == nil then
				PATHFINDING_CACHE[cache_index][starting_province] = {}
			end

			PATHFINDING_CACHE[cache_index][starting_province][ending_province] = path
		end

		return total_cost, path
	else
		local current = origin
		local next_index = #path
		local total_cost = 0
		while path[next_index] ~= nil do
			local next = path[next_index]
			total_cost = total_cost + pa.tile_distance(current, next, speed)
			next_index = next_index - 1
		end

		return total_cost, tabb.copy(path)
	end
end

---@param hours number
---@return number
function pa.hours_to_travel_days(hours)
	return hours / 12.0 -- Assume 12 hours of travel every day
end

return pa
