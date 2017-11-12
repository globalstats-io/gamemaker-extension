/// @description marks an achievement as accomplished for the given player.
/// @param playerid the player id. If playerid is noone try to retrieve from settings
/// @param achievementKey the player id. If playerid is noone try to retrieve from settings

show_debug_message("gs_accomplishAchievement(): entered");

if (oGlobalStatsIOController.accomplishAchievementRequest != -1) {
    // there already is a pending request so don't start another one - wait for the response first
    show_debug_message("gs_accomplishAchievement(): old request still pending! Exiting.");
    return false;
}

if (oGlobalStatsIOController.gsAccessToken == noone) {
    // request a new one but that will return asynchronously so we have to return false now
    with (oGlobalStatsIOController) {
        alarm[0] = 1;
    }
    return false;
}

var gsid = argument[0];
var achievementKey = argument[1];
// if no id is supplied but we have one stored in oGlobalStatsIOController use that one
if (gsid == noone && !is_undefined(oGlobalStatsIOController.playerID)) {
    gsid = oGlobalStatsIOController.playerID;
}

if (gsid == noone) {
    show_debug_message("gs_accomplishAchievement(): No playerid in settings found!");
    return false;
}
var url = gs_getBaseURL() + "v1/statistics/" + gsid + "/achievements/"+achievementKey+"/accomplish";

var headermap = ds_map_create();
ds_map_add(headermap, "Authorization", "Bearer " + oGlobalStatsIOController.gsAccessToken);
ds_map_add(headermap, "Content-Type", "application/json");
var headerstr = json_encode(headermap);
show_debug_message(headerstr);

oGlobalStatsIOController.accomplishAchievementRequest = httpRequest(url, "GET", headermap, "");

return true;


