/// @description retrieve an access token from globalstats.io. This is always the first call
/// @param gameid the game id for this game, autocreated when you add your game to globalstats.io
/// @param gamesecret the game secret for this game, also autocreated

var gameid = argument0;
var gamesecret = argument1;

if (oGlobalStatsIOController.accessRequest != -1) {
    // there already is a pending request so don't start another one - wait for the response first
    show_debug_message("gs_getAccessToken(): old request still pending! Exiting.");
    return oGlobalStatsIOController.accessRequest;
}

var url = gs_getBaseURL() + "oauth/access_token";
var str = "grant_type=client_credentials";
str += "&scope=endpoint_client&client_id="+gameid+"&client_secret="+gamesecret;

var handle;
if (os_type == os_android) {
    var headermap = ds_map_create();
    ds_map_add(headermap, "Cache-Control", "no-cache");
    var headerstr = json_encode(headermap);
    show_debug_message(headerstr);
    handle = httpRequest(url, "POST", headermap, str);
} else {
    handle =http_post_string(url, str);
}
show_debug_message("gs_getAccessToken(): requested access token. url is '"+string(url)+"', post header is '"+string(str)+"', returned accessRequest handle is "+string(handle));
return handle;


