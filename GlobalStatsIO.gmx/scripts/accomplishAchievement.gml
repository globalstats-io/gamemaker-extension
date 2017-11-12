/// @description manually accomplish an achievement.
/// @param achievementKey
var achievementKey = argument[0];
if (is_undefined(oGlobalStatsIOController.playerID))
    return false;
else {
    gs_accomplishAchievement(oGlobalStatsIOController.playerID, achievementKey);
}
