#pragma once
#include <stdint.h>
#include "objs.hpp"

#ifdef DCON_LUADLL_EXPORTS
#ifdef _WIN32
#define DCON_LUADLL_API __declspec(dllexport)
#else
#define DCON_LUADLL_API __attribute__((visibility("default")))
#endif
#else
#ifdef _WIN32
#define DCON_LUADLL_API __declspec(dllimport)
#else
#define DCON_LUADLL_API
#endif
#endif

extern "C" {
	DCON_LUADLL_API void update_vegetation(float);
	DCON_LUADLL_API void apply_biome(int32_t);
	DCON_LUADLL_API void apply_resource(int32_t);
	DCON_LUADLL_API void update_economy();
	DCON_LUADLL_API float estimate_province_use_price(uint32_t, uint32_t);
	DCON_LUADLL_API float estimate_province_use_available(uint32_t, uint32_t);
	DCON_LUADLL_API float estimate_building_type_income(int32_t, int32_t, int32_t, bool);
	DCON_LUADLL_API int32_t roll_desired_building_type_for_pop(int32_t);
	DCON_LUADLL_API void update_foraging_data(
		int32_t province_raw_id,
		int32_t water_raw_id,
		int32_t berries_raw_id,
		int32_t grain_raw_id,
		int32_t bark_raw_id,
		int32_t timber_raw_id,
		int32_t meat_raw_id,
		int32_t hide_raw_id,
		int32_t mushroom_raw_id,
		int32_t shellfish_raw_id,
		int32_t seaweed_raw_id,
		int32_t fish_raw_id,
		int32_t world_size
	);

	DCON_LUADLL_API void load_state(char const*);
	DCON_LUADLL_API void update_map_mode_pointer(uint8_t* map, uint32_t world_size);
	DCON_LUADLL_API int32_t get_neighbor(int32_t tile_id, uint8_t neighbor_index, uint32_t world_size);

	DCON_LUADLL_API void ai_update_price_belief(int32_t trader_raw_id);
	DCON_LUADLL_API void ai_trade(int32_t trader_raw_id);

	// backend time tracking
	DCON_LUADLL_API void set_world_current_year(uint32_t year);
	DCON_LUADLL_API uint32_t get_world_current_year(void);
	DCON_LUADLL_API void set_world_current_tick(uint32_t tick);
	DCON_LUADLL_API uint32_t get_world_current_tick(void);
	DCON_LUADLL_API void set_world_tick_definitions(uint32_t minute, uint32_t hour, uint32_t day, uint32_t month);
	DCON_LUADLL_API uint32_t get_world_ticks_per_minute(void);
	DCON_LUADLL_API uint32_t get_world_ticks_per_hour(void);
	DCON_LUADLL_API uint32_t get_world_ticks_per_day(void);
	DCON_LUADLL_API uint32_t get_world_ticks_per_month(void);
	// birthdate values
	DCON_LUADLL_API uint32_t birth_month(dcon::pop_id);
	DCON_LUADLL_API uint32_t birth_day(dcon::pop_id);
	DCON_LUADLL_API uint32_t birth_hour(dcon::pop_id);
	DCON_LUADLL_API uint32_t birth_minute(dcon::pop_id);
	// age calculations
	DCON_LUADLL_API uint32_t age_months(dcon::pop_id);
	DCON_LUADLL_API uint32_t age_years(dcon::pop_id);
	DCON_LUADLL_API uint32_t age_ticks(dcon::pop_id);
	DCON_LUADLL_API float age_multiplier(dcon::pop_id);
}
