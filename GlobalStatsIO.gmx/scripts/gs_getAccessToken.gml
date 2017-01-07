/// @description retrieve an access token from globalstats.io. This is always the first call
/// @param gameid the game id for this game, autocreated when you add your game to globalstats.io
/// @param gamesecret the game secret for this game, also autocreated

var gameid = argument0;
var gamesecret = argument1;

var url ="https://api.globalstats.io/oauth/access_token";
var str = "grant_type=client_credentials";
str += "&scope=endpoint_client&client_id="+gameid+"&client_secret="+gamesecret;

var handle =http_post_string(url, str);
return handle;


