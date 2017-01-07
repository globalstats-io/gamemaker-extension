/// @description upload a highscore to globalstats.io
/// @param newscore

var newscore = argument0;

var values = ds_map_create();
ds_map_add(values, oGlobalStatsIOController.highscoreGTD, newscore);

if (is_undefined(oGlobalStatsIOController.playerID))
    gs_share(noone, oGlobalStatsIOController.playerNickname, values);
else
    gs_share(oGlobalStatsIOController.playerID, oGlobalStatsIOController.playerNickname, values);

ds_map_destroy(values);

