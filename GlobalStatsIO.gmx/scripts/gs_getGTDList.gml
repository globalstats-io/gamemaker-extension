/// @description retrieve your current rank from globalstats.io
/// @param gtdID the id of the gtd that contains the ranks, usually some score gtd
/// @param nrOfEntries number of entries to read, must be between 1 and 100


show_debug_message("gs_getGTDList: entered");

if (oGlobalStatsIOController.gsAccessToken == noone) {
    // request a new one but that will return asynchronously so we have to return false now
    with (oGlobalStatsIOController) {
        alarm[0] = 1;
    }
    return false;
}

var gtdID = argument[0];
var nrEntries = argument[1];

var jsonData = ds_map_create();
ds_map_add(jsonData, "limit", nrEntries);
var jsonStr = json_encode(jsonData);
show_debug_message("gs_getGTDList: jsonStr = '" + jsonStr + "'");

var url = "https://api.globalstats.io/v1/gtdleaderboard/" + gtdID;

var headermap = ds_map_create();
ds_map_add(headermap, "Authorization", "Bearer " + oGlobalStatsIOController.gsAccessToken);
ds_map_add(headermap, "Content-Type", "application/json");
ds_map_add(headermap, "Content-Length", string(string_length(jsonStr)));
var headerstr = json_encode(headermap);
show_debug_message(headerstr);
oGlobalStatsIOController.scoresRequest = http_request(url, "POST", headermap, jsonStr);

return true;


