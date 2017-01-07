/// @description set a setting to a given value
/// @param key of the setting
/// @param value of the setting
/*
    Sets the value of the setting identified by key.
    Examples: 
    
        gs_setSetting("nickname", "Tomahawk");
        gs_setSetting("playerID", "abcdefg");
        
        
*/

oGlobalStatsIOController.settingsChanged = true;
ds_map_set(oGlobalStatsIOController.settings, argument0, argument1); 

