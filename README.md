# gamemaker-extension
globalstats.io extension for GameMaker: Studio
Version 2.0, 2017/11/29, Thomas Haaks (https://www.rightanglegames.com, thomas@rightanglegames.com, Twitter: @RightAngleGames)

Hi there,
welcome to the readme for the GameMaker:Studio wrapper to the services of globalstats.io.

Here is the second version of this wrapper, containing some refactorings, bug fixes and the eagerly awaited achievements (at least eagerly awaited by me!).
I hope you'll find it useful.

This is still a work-in-progress. Please let us know any feedback you have or special use cases you have.

## Usage
Simply add the .gmez extension file to your project. You can remove all stuff that is in the Demo group (scripts, fonts, objects, rooms).
All you really need is the stuff in the groups named GlobalStatsIO.

You could also clone the repository, open the gmx project with GameMaker:Studio and create your own extension or just copy the appropriate scripts
and the oGlobalStatsIOController object.

### Preparations

#### On globalstats.io Website
1. Create an account at globalstats.io and go to the developers section.
2. Create an entry for your new game.
3. Create a GTD (highscore table) for your new game with a unique key for the table.

#### In your project
1. Add the GlobalStatsIO scripts and objects from the extension to your project.
2. Place the object oGlobalStatsIOController in the first room of your game.
3. Copy the Game ID and Game Secret into the proper variables (gameID and gameSecret) in the Create action of the oGlobalStatsIOController.
4. Copy the unique GTD key for your highscores into the proper variable (highscoreGTD) in the Create action of the oGlobalStatsIOController.
5. Call the script setPlayerNickname(yourNickname) before you try to upload any score.

### Submitting Scores
Just call the script sendHighscore(score) anywhere in your game.

```
setPlayerNickname("Player1");
sendHighscore(12345);
```

The sendHighscore call will store the player's nickname and the player ID it received back from globalstats.io.
Whenever you use the same nickname again the stored player ID will be used automatically for highscore updates.
You can read the player ID from the variable oGlobalStatsIOController.playerID. The nickname is stored in oGlobalStatsIOController.playerNickname.

After some milliseconds you can find the answer data in the oGlobalStatsIOController.gsLastGTDRank array.
For an example usage see the draw action of the oScoresController in the example game. Also after sending your first highscore the variable oGlobalStatsIOController.playerID is set. This is the unique player id for your nickname. You can link this player id with the nickname to your globalstats.io Account, allowing you to link multiple accounts for different games with your globalstats.io account.
	
### Linking Scores
Most of the time you want to allow the player to link his scores with his globalstats.io account.
In this case you can do this with following lines
```
linkAccount();
```
After the response is received you can find the link URL or link PIN in the following variables:
```
oGlobalStatsIOController.gsLinkAccountURL
oGlobalStatsIOController.gsLinkAccountPIN
```
and you could call
```
if (oGlobalStatsIOController.gsLinkAccountURL != noone)
    url_open(oGlobalStatsIOController.gsLinkAccountURL);
```
to open the link website.
Of course, this will use the data from the prior sendHighscore() call for linking.

### Retrieve highscores and rank
Call getRank() to retrieve the best rank of the current player. Again results will be stored in variable oGlobalStatsIOController.gsRank. See draw action of oScoresController in the demo game for proper usage.

Call getHighscoreList(nrOfEntries) to retrieve the top "nrOfEntries" elements to show your highscores. nrOfEntries must be between 1 and 100. Again see sample code in draw action of oScoresController.

Call getRankSection() to retrieve the player's score and the 5 better scores next to the player and the 5 worse scores following the player's score. See sample code in draw action of oSectionScoresController.

### Uploading values for other GTDs
Call sendGTDValue(key, value)
Initially all the code to modify a GTD was in sendHighscore(). But sendHighscore() is just a very specific use of sendGTDValue() with a very specific GTD that we use to store the player's score in.
But technically you can create many GTDs on the globalstats.io backend site for your game and of course you should be able to modify their values for any player.
This script allows you to do exactly that. And if you look at the implementation of sendHighscore() now you'll see that it only calls sendGTDValue() with the GTD you created in the setup part to keep your scores.
You will also use GTDs to implement some achievements.
	
### Achievements
Once you have an entry for your game on the globalstats.io website you can also add achievements, either with their own counter GTD or without a counter, so it's just a boolean achievement.
If you want you can also upload your own images to use for achievement states.
Matching the globalstats.io API description for achievements (https://globalstats.io/api#Achievements) you have a handful of scripts to use for achievements.
	
#### getAllAchievements()
returns a list of all achievements defined for the game. You can use it for an overview or for some checks, internal storage or whatever you want.
The result will be stored in oGlobalStatsIOController.gsAllAchievements[]. For each achievement you'll get a key, a name, a description and two URLs for the active (achievement accomplished) and inactive image (achievement not yet accomplished).
See the oAchievementsController in the demo for an example.

#### getAchievementSprite(URL)
downloads the sprite with the given URL. To avoid unneccessary network traffic downloaded sprites are cached and subsequent calls with the same URL will return the cached sprite instead of downloading it again.
But the cache is currently not persistent so the sprites will be downloaded again if you restart the game.
See the oAchievementsController in the demo for an example.

#### getPlayerAchievements()
returns a list of all achievements defined for the game but enhanced with player informations.
The result will be stored in oGlobalStatsIOController.gsPlayerAchievements[]. For each achievement you'll get a key, a name, a description and two URLs for the active (achievement accomplished) and inactive image (achievement not yet accomplished). You also get a boolean "accomplished" which is either true (achievement accomplished) or false (achievement not yet accomplished).
See the oAchievementsController in the demo for an example.

#### accomplishAchievement(achievementName)
Mark an achievement as accomplished.
The accomplished achievement will be returned and stored in oGlobalStatsIOController.gsAccomplishedAchievement[], again with key, name, description and the two image URLs.

#### Notification for accomplished achievements
Whenever you send a GTD value (either by calling sendHighscore() or sendGTDValue()) you might trigger an achievement. So accomplished achievements can always be returned in the result. These will be stored in oGlobalStatsIOController.gsLatestAchievements[] with key, name, description and the two sprite URLs.
You can also be notified by the wrapper by installing a callback script.
setCallbackScripts(errorScript, achievementsAccomplishedScript) allows you to do that. See the demo scripts demoErrorResponseCallback() and demoAchievementsAccomplishedCallback() how to do that. In the demo the callback scripts are installed in the oStartController.

## Android support
The asset should work on Android now. My extension contains an asset from "Customer Support", a user over at the GMC. He created an asset to fix the broken	Android HTTP requests (see this thread: https://forum.yoyogames.com/index.php?threads/fixing-the-http-requests.30588/).
Together with Lukas from globalstats.io I also managed to fix a specific Android 7.0 bug with elliptic curves, used for encryption.
If you want to use my globalstats.io wrapper on Android devices you need to copy the included file HttpRequester.gmez somewhere on your hard disk (right click on the extension, open in Explorer and copy to some other folder) and then import it from there as another extension to your game (right click on "Extensions" in the resource tree and then select "Import extension" and browse to your just saved HttpRequester.gmez file). After importing open the script in Group GlobalStatsIO/InternalStuff/httpRequest and uncomment the code lines above the last code line.
Also put the last line in comments. That should be it. You can now safely use globalstats.io services on Android.
YoYo Games are also fixing their bugs in this area so you might to finetune the scripts a bit to get it working. If in doubt feel free to contact me, Thomas.
	
## Feedback
If you encounter any issues you can create a issue here on github. You can also report any issues or questions and suggestions you have to us via email to feedback@globalstats.io or via the feedback form on our website https://globalstats.io.

## Credits for the GameMaker:Studio extension

To "Ciberman" for his free(!) playerprefs_gm asset on the Marketplace (https://marketplace.yoyogames.com/assets/4504/playerprefs_gm)
where I learned how to save something "automatically" while the game idles (see the step event action of oGlobalStatsIOController).
You should check out Ciberman's Tweenline asset - it's great! https://marketplace.yoyogames.com/assets/2909/tweenline-animation-engine

Once more to Ciberman and Zack Bell or the other people who came up with a solution how to implement singletons  within GameMaker:Studio.
You can find the Ciberman implementation in his PlayerPrefs and Tweenline asset, the solution from Zack is here:
https://zackbellgames.com/2016/11/13/loadworld-devlog-pt-2/

Also I need to credit Florian van Strien for his GameJolt API (http://gamejolt.com/games/gamejolt-achievement-api-for-gamemaker-studio/11689) which
gave me a good start on how to implement the globalstats.io binding.

The GMC user "Customer Support" earns many, many credits and thankyous for providing the HTTP asset for Android. Without him Android support would not be possible and working!

Thomas Haaks