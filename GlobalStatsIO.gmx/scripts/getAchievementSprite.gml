///@description returns the achievement image as a sprite for the given url, either from internal cache or loads it and stores it in cache
///@param url the target url from globalstats.io for the image
var url = argument0;
var sprite = ds_map_find_value(oGlobalStatsIOController.gsAchievementSprites, url);
if (is_undefined(sprite)) {
    // check if it is already in the pending list
    var pending = ds_map_find_value(oGlobalStatsIOController.gsPendingAchievementSprites, url);
    if (is_undefined(pending)) {
        // yep, this sprite is brand new. load it.
        with (oGlobalStatsIOController) {
            show_debug_message("Loading achievement sprite for url '"+string(url)+"'!");
            var spr = sprite_add(url, 0, false, false, 0, 0);
            ds_map_add(oGlobalStatsIOController.gsPendingAchievementSprites, url, spr);
        }
    }
    return sprite;  // return undefined for now as it is not yet loaded
} else {
    // already stored in cache, return it
    return sprite;
}

