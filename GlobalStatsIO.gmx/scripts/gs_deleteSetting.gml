/// @description delete the setting with given key
/// @param key of the setting we want to delete
/*
    Removes key and its corresponding value from the settings and returns undefined.
    Example: 
    
     lastscore = gs_deleteSetting("lastscore");
        
*/

oGlobalStatsIOController.settingsChanged = true;
ds_map_delete(oGlobalStatsIOController.settings, argument0); 
return undefined;

