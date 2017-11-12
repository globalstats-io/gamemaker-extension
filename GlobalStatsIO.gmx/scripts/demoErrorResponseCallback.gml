///@description this script is called whenever a HTTP error response is returned from globalstats.io
///@param errorResponseMap
///@param errorMessage

show_debug_message("demoErrorResponseCallback(): entered");

var error = argument[0];
var msg = argument[1];

if (error != noone) {
    var errorResponseMap = json_decode(error);
    
    var code, message, data;
    
    code = ds_map_find_value(errorResponseMap, "code");
    message = ds_map_find_value(errorResponseMap, "message");
    data = ds_map_find_value(errorResponseMap, "data");
    
    show_debug_message("globalstats.io server responded with error code "+string(code) + ", message '"+string(message)+ "', data '"+string(data)+"'!");
}
if (msg != noone) {
    show_debug_message("globalstats.io server responded with error message "+string(msg) +"'!");
}

