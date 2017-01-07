/// @description link your current local player account to a  globalstats.io account
/// @param playerID noone if unknown
/// @param email optional email address to use for linking instructions
var playerid = argument[0];
var email = noone;

if (argument_count == 2)
    email = argument[1];

oGlobalStatsIOController.gsLinkAccountURL = noone;
oGlobalStatsIOController.gsLinkAccountPIN = noone;

if (email == noone)
    gs_linkAccount(playerid);
else
    gs_linkAccount(playerid, email);


