///httpRequest(url, method, header_map, body)
//Fixes http_request for the Android export
// uncomment the code below and just put the last line of the script into comments

/*
if (os_type == os_android) {
    return jhttp_request(argument0, argument1, json_encode(argument2), argument3);
} else {
    return http_request(argument0, argument1, argument2, argument3);
}
*/

return http_request(argument0, argument1, argument2, argument3);

