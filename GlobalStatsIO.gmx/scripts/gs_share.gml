/// @description upload a score to GlobalStats.io.
/// @param playerid the player id. Pass noone if not yet known. Will be returned in response then.
/// @param playername the player's nickname. Pass noone for anonymous. Will be shown in highscore list when the player is not linked to his GlobalStats.io account
/// @param values a map with key-value pairs to share.

show_debug_message("gs_share: entered");

if (oGlobalStatsIOController.gsAccessToken == noone) {
// request a new one but that will return asynchronously so we have to return false now
    with (oGlobalStatsIOController) {
        alarm[0] = 1;
    }
    return false;
}

var gsid = argument[0];
var gsname = argument[1];
var gsvalues = argument[2];
var host = "https://api.globalstats.io";
var url = "https://api.globalstats.io/v1/statistics";

// if no id is supplied but we have one stored in oGlobalStatsIOController use that one
if (gsid == noone && !is_undefined(oGlobalStatsIOController.playerID)) {
    gsid = oGlobalStatsIOController.playerID;
}

if (gsid != noone) {
    url = "https://api.globalstats.io/v1/statistics/" + gsid;
} else {
    // no id and no name given...
    if (gsname == noone)
        gsname = "anonymous";
}
    
    
var jsonData = ds_map_create();
ds_map_add(jsonData, "name", gsname);
if (gsvalues != noone)
    ds_map_add_map(jsonData, "values", gsvalues);

var jsonStr = json_encode(jsonData);
show_debug_message("gs_share: jsonStr = '" + jsonStr + "'");

// prepare the post request
if (gsid == noone) {
    var headermap = ds_map_create();
    ds_map_add(headermap, "Authorization", "Bearer " + oGlobalStatsIOController.gsAccessToken);
    ds_map_add(headermap, "Content-Type", "application/json");
    ds_map_add(headermap, "Content-Length", string(string_length(jsonStr)));
    var headerstr = json_encode(headermap);
    show_debug_message(headerstr);
    oGlobalStatsIOController.shareFirstTimeRequest = http_request(url, "POST", headermap, jsonStr);
} else {
    var headermap = ds_map_create();
    ds_map_add(headermap, "Authorization", "Bearer " + oGlobalStatsIOController.gsAccessToken);
    ds_map_add(headermap, "Content-Type", "application/json");
    ds_map_add(headermap, "Content-Length", string(string_length(jsonStr)));
    var headerstr = json_encode(headermap);
    show_debug_message(headerstr);
    oGlobalStatsIOController.shareRequest = http_request(url, "PUT", headermap, jsonStr);
}

return true;

