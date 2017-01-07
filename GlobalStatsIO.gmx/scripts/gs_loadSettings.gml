/// @description load settings from file
/// @param filename of the settings file
var settings;
var filename = argument0;

if (file_exists(filename)) {
    settings = ds_map_secure_load(filename);
} else {
    settings = ds_map_create();
}

return settings;


