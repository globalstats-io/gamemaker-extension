/// @description save settings to file
/// @param filename of the settings file
/// @param settings the ds_map to be saved to file

var filename = argument0;
var settings = argument1;

if (settingsChanged) {
show_debug_message("gs_saveSettings(): settings changed, saving them to file");
    ds_map_secure_save(settings, filename);
    settingsChanged = false;
}

