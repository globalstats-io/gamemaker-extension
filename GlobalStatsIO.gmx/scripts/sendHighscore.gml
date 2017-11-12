/// @description upload a highscore to globalstats.io
/// @param newscore

var newscore = argument0;

sendGTDValue(oGlobalStatsIOController.highscoreGTD, newscore);
