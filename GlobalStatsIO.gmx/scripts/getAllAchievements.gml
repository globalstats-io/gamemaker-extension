/// @description retrieve a list of all existing achievements for this game from globalstats.io
show_debug_message("getPlayerAchievements(): entered");

// delete old list of all achievements if it does exist
oGlobalStatsIOController.gsAllAchievements = 0;
oGlobalStatsIOController.gsAllAchievementsSize = 0;

gs_getAllAchievements();
