/// @description link current player with his globalstats.io account
/// @param playerID if known or noone if stored playerid should be used
/// @param email optional if link instructions should be sent to given email adress


show_debug_message("gs_linkAccount(): entered");

if (oGlobalStatsIOController.linkRequest != -1) {
    // there already is a pending request so don't start another one - wait for the response first
    show_debug_message("gs_linkAccount(): old request still pending! Exiting.");
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
var email = noone;
var jsonData, jsonStr;

if (argument_count == 2) {
    email = argument[1];
}

// if no id is supplied but we have one stored in oGlobalStatsIOController use that one
if (gsid == noone && !is_undefined(oGlobalStatsIOController.playerID)) {
    gsid = oGlobalStatsIOController.playerID;
}

if (gsid == noone)
    return false;

jsonStr = "";
if (email != noone) {
    jsonData = ds_map_create();
    ds_map_add(jsonData, "email", email);
    jsonStr = json_encode(jsonData);
    show_debug_message("gs_linkAccount: jsonStr = '" + jsonStr + "'");
}

var url = gs_getBaseURL() + "v1/statisticlinks/" + gsid + "/request";

var headermap = ds_map_create();
ds_map_add(headermap, "Authorization", "Bearer " + oGlobalStatsIOController.gsAccessToken);
ds_map_add(headermap, "Content-Type", "application/json");
if (email != noone)
    ds_map_add(headermap, "Content-Length", string(string_length(jsonStr)));
var headerstr = json_encode(headermap);
show_debug_message(headerstr);
oGlobalStatsIOController.linkRequest = httpRequest(url, "POST", headermap, jsonStr);

return true;

