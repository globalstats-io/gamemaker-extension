/// @description Returns: true if the function is completed, false if there is an globalstats.io error, <0 if there is a GameMaker error (for example, if GM couldn't find the site).
//If returns false, more info will be available when you call gs_error()
//Returns the status and makes the info available, so ALWAYS call this before you request any info.
var httpstatus=ds_map_find_value(async_load,"status");

var gsResult = "";

var gsStatus, gsID, gsURL, gsHTTPStatus;

if(httpstatus < 0) {
    show_debug_message("gs_getResultStatus(): httpstatus is negative ("+string(httpstatus)+"), this is an error!");

    gsResult = ds_map_find_value(async_load, "result");
    // some additional debug info
    gsStatus = ds_map_find_value(async_load, "status");
    gsID = ds_map_find_value(async_load, "id");
    gsURL = ds_map_find_value(async_load, "url");
    gsHTTPStatus = ds_map_find_value(async_load, "http_status");
    /*
    show_debug_message("gs_getResultStatus(): id is '" + string(gsID)+ "'!");
    show_debug_message("gs_getResultStatus(): status is '" + string(gsStatus)+ "'!");
    show_debug_message("gs_getResultStatus(): result is '" + string(gsResult)+ "'!");
    show_debug_message("gs_getResultStatus(): url is '" + string(gsURL)+ "'!");
    show_debug_message("gs_getResultStatus(): http_status is '" + string(gsHTTPStatus)+ "'!");
    // get the response
    show_debug_message("gs_getResultStatus(): response message is '" + string(gsResult)+ "'!");
    */
    if (gsErrorCallback != noone)
        script_execute(gsErrorCallback, noone, gsResult);

    return httpstatus;
} else {
    if (is_undefined(async_load)) {
        show_debug_message("gs_getResultStatus(): async_load is undefined! This should never happen here!");
    }
    gsResult = ds_map_find_value(async_load, "result");
    // some additional debug info
    gsStatus = ds_map_find_value(async_load, "status");
    gsID = ds_map_find_value(async_load, "id");
    gsURL = ds_map_find_value(async_load, "url");
    gsHTTPStatus = ds_map_find_value(async_load, "http_status");
    /*
    show_debug_message("gs_getResultStatus(): id is '" + string(gsID)+ "'!");
    show_debug_message("gs_getResultStatus(): status is '" + string(gsStatus)+ "'!");
    show_debug_message("gs_getResultStatus(): result is '" + string(gsResult)+ "'!");
    show_debug_message("gs_getResultStatus(): url is '" + string(gsURL)+ "'!");
    show_debug_message("gs_getResultStatus(): http_status is '" + string(gsHTTPStatus)+ "'!");
    // get the response
    show_debug_message("gs_getResultStatus(): response message is '" + string(gsResult)+ "'!");
    */
    if (!is_undefined(gsResult)) {
        gsResponse = gsResult;
        gsResponseMap = json_decode(gsResponse);
        if (gsResponseMap == -1) {
            var msg = "gs_getResultStatus: failed to decode JSON '" + string(gsResponse)+ "'!"
            show_debug_message(msg);
            if (gsErrorCallback != noone)
                script_execute(gsErrorCallback, noone, msg);
            return false;
        }
        gsConnected = true;
        // let's see if we got a valid response or an error code
        if (ds_map_exists(gsResponseMap, "code")) {
            // an error happened. Store the result.
            gsLastError = gsResponse;
            if (gsErrorCallback != noone)
                script_execute(gsErrorCallback, gsLastError, noone);
            return false;
        }
        return true;
    }
    show_debug_message("gs_getResultStatus(): gsResult is undefined!");
    if (gsErrorCallback != noone)
        script_execute(gsErrorCallback, noone, "gs_getResultStatus(): gsResult is undefined!");
    return false;
}

