/// @description upload a new value for a given GTD to globalstats.io, used for your own GTDs or trigger GTDs for achievements
/// @param gtdkey
/// @param newgtdvalue

var gtdkey = argument0;
var newgtdvalue = argument1;

var values = ds_map_create();
ds_map_add(values, gtdkey, newgtdvalue);

if (is_undefined(oGlobalStatsIOController.playerID))
    gs_share(noone, oGlobalStatsIOController.playerNickname, values);
else
    gs_share(oGlobalStatsIOController.playerID, oGlobalStatsIOController.playerNickname, values);

ds_map_destroy(values);

