/// @description get current rank of current player from globalstats.io

/*
    the result can be found in oGlobalStatsIOController.gsRank[] which
    is an array or 0 otherwise
    use enum RankResult to index into gsRank array

*/
if (is_undefined(oGlobalStatsIOController.playerID))
    return false;
else {
    // delete old rank if it does exist
    oGlobalStatsIOController.gsRank = 0;
    gs_getRank(oGlobalStatsIOController.playerID);
}



