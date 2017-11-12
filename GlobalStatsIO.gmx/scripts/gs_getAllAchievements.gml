/// @description retrieve a list of all available achievements of this game from globalstats.io

show_debug_message("gs_getAllAchievements: entered");

if (oGlobalStatsIOController.allAchievementsRequest != -1) {
    // there already is a pending request so don't start another one - wait for the response first
    show_debug_message("gs_getAllAchievements(): old request still pending! Exiting.");
    return false;
}

if (oGlobalStatsIOController.gsAccessToken == noone) {
    // request a new one but that will return asynchronously so we have to return false now
    with (oGlobalStatsIOController) {
        alarm[0] = 1;
    }
    return false;
}

var url = gs_getBaseURL() + "v1/achievements";

var headermap = ds_map_create();
ds_map_add(headermap, "Authorization", "Bearer " + oGlobalStatsIOController.gsAccessToken);
ds_map_add(headermap, "Content-Type", "application/json");
var headerstr = json_encode(headermap);
show_debug_message(headerstr);
oGlobalStatsIOController.allAchievementsRequest = httpRequest(url, "GET", headermap, "");

return true;

