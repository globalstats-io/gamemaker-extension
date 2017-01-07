/// @description get a stored setting
/// @param key of the setting we want to retrieve
/// @param default value if the setting is undefined
/*
    Gets the value of the setting identified by key.
    If it doesn't exist, it will return the default value.
    
    Examples: 
    
        var id = gs_getSetting("playerID");
        var nick = gs_getSetting("nickname", "Tomahawk");
        
        
*/

if (argument_count > 1) {
    if (!ds_map_exists(oGlobalStatsIOController.settings, argument[0])) {
        return argument[1];
    }
}
return ds_map_find_value(oGlobalStatsIOController.settings, argument[0]); 

