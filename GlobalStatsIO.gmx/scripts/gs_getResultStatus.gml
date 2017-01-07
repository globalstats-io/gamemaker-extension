/// @description Returns: true if the function is completed, false if there is an globalstats.io error, <0 if there is a GameMaker error (for example, if GM couldn't find the site).
//If returns 0, more info will be available when you call gs_error()
//Returns the status and makes the info available, so ALWAYS call this before you request any info.
var httpstatus=ds_map_find_value(async_load,"status");

var gsResult = "";

if(httpstatus < 0) {
    return httpstatus;
} else {
    gsResult = ds_map_find_value(async_load, "result");
    // get the response
    show_debug_message("gs_getResultStatus: response message is '" + string(gsResult)+ "'!");
    if (!is_undefined(gsResult)) {
        gsResponse = gsResult;
        gsResponseMap = json_decode(gsResponse);
        if (gsResponseMap == -1) {
            show_debug_message("gs_getResultStatus: failed to decode JSON '" + string(gsResponse)+ "'!");
            return false;
        }
        gsConnected = true;
        // let's see if we got a valid response or an error code
        if (ds_map_exists(gsResponseMap, "code")) {
            // an error happened. Store the result.
            gsLastError = gsResponse;
            return false;
        }
        return true;
    }
    show_debug_message("gs_getResultStatus: gsResult is undefined!");
    return false;
}

