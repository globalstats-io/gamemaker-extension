///@description install callback scripts for error handling and accomplishing achievements
///@param errorCallbackScript
///@param accomplishedCallbackScript

var errorCallback = argument0;
var accomplishedCallback = argument1;

oGlobalStatsIOController.gsErrorCallback = errorCallback;
oGlobalStatsIOController.gsAccomplishedCallback = accomplishedCallback;
