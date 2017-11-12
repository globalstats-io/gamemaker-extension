/// @description retrieve a list of all existing achievements for this game from globalstats.io but a flag is added for each achievement if the player has accomplished it
show_debug_message("getPlayerAchievements(): entered");
if (is_undefined(oGlobalStatsIOController.playerID)) {
    show_debug_message("getPlayerAchievements(): playerID is undefined! Returning false.");
    return false;
} else {
    // delete old rank if it does exist
    oGlobalStatsIOController.gsPlayerAchievements = 0;
    oGlobalStatsIOController.gsPlayerAchievementsSize = 0;
    gs_getPlayerAchievements(oGlobalStatsIOController.playerID);
}
