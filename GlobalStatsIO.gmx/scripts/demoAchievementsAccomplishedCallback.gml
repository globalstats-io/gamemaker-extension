///@description demoAchievementsAccomplishedCallback(): this script will be called when one or more achievements are accomplished
///@param accomplishedAchievements a list of the achievements that were just accomplished
///@param accomplishedAchievementsSize number of entries in the list of the achievements that were just accomplished
//
// this usually happens when a GTD is increased.
//

var nr, entries, i;

entries = argument[0];
nr = argument[1];

show_debug_message("demoAchievementsAccomplishedCallback() is called!");
for (i = 0; i < nr; i++) {
    var key, name, description;
    
    key = entries[i, AchievementResult.Key];
    name = entries[i, AchievementResult.Name];
    description = entries[i, AchievementResult.Description];
    
    show_debug_message("You just accomplished achievement '"+string(key)+"' with name '" + string(name) + "' and description '" + string(description) + "'! Congrats!");
}
