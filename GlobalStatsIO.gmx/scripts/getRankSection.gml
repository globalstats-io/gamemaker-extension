/// @description get current rank of current player from globalstats.io plus 5 better players and 5 worse players

/*
    the result of the given player can be found in oGlobalStatsIOController.gsRank[] which
    is an array or 0 otherwise
    oGlobalStatsIOController.gsWorseRanks[] contains the score results of the (default 5) players
    with a worse score than the player
    oGlobalStatsIOController.gsBetterRanks[] contains the score results of the (default 5) players
    with a better score than the player
    oGlobalStatsIOController.gsWorseRanksSize and oGlobalStatsIOController.gsBetterRanksSize contain the size of the two
    arrays.
    In case of failure they will all be 0.
    
    use enum RankResult to index into gsRank array and also into gsWorseRanks[i] and gsBetterRanks[i]

*/
if (is_undefined(oGlobalStatsIOController.playerID))
    return false;
else {
    // delete old rank if it does exist
    oGlobalStatsIOController.gsRank = 0;
    oGlobalStatsIOController.gsWorseRanks = 0;
    oGlobalStatsIOController.gsWorseRanksSize = 0;
    oGlobalStatsIOController.gsBetterRanks = 0;
    oGlobalStatsIOController.gsBetterRanksSize = 0;
    gs_getRankSection(oGlobalStatsIOController.playerID, oGlobalStatsIOController.highscoreGTD);
}



