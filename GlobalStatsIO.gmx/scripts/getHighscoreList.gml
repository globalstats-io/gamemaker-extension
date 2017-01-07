/// @description retrieve a number of highscore entries from globalstats.io
/// @param nrOfEntries

var nrOfEntries = argument0;

if (nrOfEntries < 1)
    nrOfEntries = 1;
if (nrOfEntries > 100)
    nrOfEntries = 100;
// delete old highscores if it does exist
oGlobalStatsIOController.gsHighscores = 0;

gs_getGTDList(oGlobalStatsIOController.highscoreGTD, nrOfEntries);


