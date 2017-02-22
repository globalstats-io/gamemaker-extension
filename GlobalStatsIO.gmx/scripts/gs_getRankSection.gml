/// @description retrieve your current rank and the next 5 better and worse player ranks from globalstats.io
/// @param playerid the player id. If playerid is noone try to retrieve from settings
/// @param gtdID the id of the gtd that contains the ranks, usually some score gtd

show_debug_message("gs_getRankSection: entered");

if (oGlobalStatsIOController.gsAccessToken == noone) {
    // request a new one but that will return asynchronously so we have to return false now
    with (oGlobalStatsIOController) {
        alarm[0] = 1;
    }
    return false;
}

var gsid = argument[0];
var gtdID = argument[1];

// if no id is supplied but we have one stored in oGlobalStatsIOController use that one
if (gsid == noone && !is_undefined(oGlobalStatsIOController.playerID)) {
    gsid = oGlobalStatsIOController.playerID;
}

if (gsid == noone) {
    show_debug_message("gs_getRankSection(): No playerid in settings found!");
    return false;
}

var url = "https://api.globalstats.io/v1/statistics/" + gsid + "/section/" +gtdID;

var headermap = ds_map_create();
ds_map_add(headermap, "Authorization", "Bearer " + oGlobalStatsIOController.gsAccessToken);
ds_map_add(headermap, "Content-Type", "application/json");
var headerstr = json_encode(headermap);
show_debug_message(headerstr);
oGlobalStatsIOController.rankSectionRequest = http_request(url, "GET", headermap, "");

return true;

