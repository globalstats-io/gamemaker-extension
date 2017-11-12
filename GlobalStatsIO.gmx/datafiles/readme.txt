Readme for the GameMaker:Studio wrapper for globalstats.io Online highscores/services
=====================================================================================

Version 2.0, 2017/11/12, Thomas Haaks (https://www.rightanglegames.com, thomas@rightanglegames.com, Twitter: @RightAngleGames)

Hi there,
welcome to the readme for the GameMaker:Studio wrapper to the services of globalstats.io.

Here is the second version of this wrapper, containing some refactorings, bug fixes and the eagerly awaited achievements (at least eagerly awaited by me!).
I hope you'll find it useful.


Basically usage for your own game is pretty simple:

You only need the one object oGlobalStatsIOController and all scripts in the group "GlobalStatsIO". Place the object oGlobalStatsIOController in the first room of your game.

You will then need to call the scripts in the group "GlobalStatsIO/Public" to use the API correctly.

How to setup everything for your game:

1. Create an account at globalstats.io and go to the developers section.
2. Create an entry for your new game.
3. Create a GTD (highscore table) for your new game with a unique key for the table.
4. Copy the Game ID and Game Secret into the proper variables (gameID and gameSecret) in the Create action of the oGlobalStatsIOController.
5. Copy the unique GTD key into the proper variable (highscoreGTD) in the Create action of the oGlobalStatsIOController.

6. Place oGlobalStatsIOController in the first room of your game.

7. Call setPlayerNickname("YourNickname") somewhere at the beginning of the game. The wrapper will retrieve an access token on startup of the game
	and will also store your nickname. Every score you upload will be bound to this nickname (unless you change it).

8. Call sendHighscore(YourScore) to upload a new score to globalstats.io. After some milliseconds you can find the answer data in the 
	oGlobalStatsIOController.gsLastGTDRank array. For an example usage see the draw action of the oScoresController in the example game.
	Also after sending your first highscore the variable oGlobalStatsIOController.playerID is set. This is the unique player id for your nickname.
	You can link this player id with the nickname to your globalstats.io Account, allowing you to link multiple accounts for different games with your
	globalstats.io account.

9. Call getRank() to retrieve the best rank of the current player. Again results will be stored in variable oGlobalStatsIOController.gsRank. See draw action
	of oScoresController in the demo game for proper usage.

10. Call getHighscoreList(nrOfEntries) to retrieve the top "nrOfEntries" elements to show your highscores. nrOfEntries must be between 1 and 100.
	Again see sample code in draw action of oScoresController.

The oGlobalStatsIOController contains a load/save mechanism for your nicknames and playerids (see scripts in group GlobalStatsIO/Settings). Pretty self explaining.

What's new now?

1.	It should work on Android now. My extension contains an asset from "Customer Support", a user over at the GMC. He created an asset to fix the broken
	Android HTTP requests (see this thread: https://forum.yoyogames.com/index.php?threads/fixing-the-http-requests.30588/). Together with Lukas from globalstats.io
	I also managed to fix a specific Android 7.0 bug with elliptic curves, used for encryption.
	If you want to use my globalstats.io wrapper on Android devices you need to copy the included file HttpRequester.gmez somewhere on your hard disk (right click on the
	extension, open in Explorer and copy to some other folder) and then import it from there as another extension to your game (right click on "Extensions" in the resource tree and then select "Import extension" and browse to your just saved HttpRequester.gmez file). After importing open the script in Group GlobalStatsIO/InternalStuff/httpRequest and uncomment the code lines above the last code line.
	Also put the last line in comments. That should be it. You can now safely use globalstats.io services on Android.

2.	Callback scripts
	I added some callback mechanisms for error handling and achievement callbacks.

3.	sendGTDValue() is new.
	Initially all the code to modify a GTD was in sendHighscore(). But sendHighscore() is just a very specific use of sendGTDValue() with a very specific GTD that we use to store the player's score in.
	But technically you can create many GTDs on the globalstats.io backend site for your game and of course you should be able to modify their values for any player.
	This script allows you to do exactly that. And if you look at the implementation of sendHighscore() now you'll see that it only calls sendGTDValue() with the GTD you created in the setup part to keep your scores.
	
4.	Achievement functions are in.
	Once you have an entry for your game on the globalstats.io website you can also add achievements, either with their own counter GTD
	or without a counter, so it's just a boolean achievement.
	If you want you can also upload your own images to use for achievement states.
	Matching the globalstats.io API description for achievements (https://globalstats.io/api#Achievements) you have a handful of scripts to use for achievements.
	
	a)	getAllAchievements()
		returns a list of all achievements defined for the game. You can use it for an overview or for some checks, internal storage or whatever you want.
		The result will be stored in oGlobalStatsIOController.gsAllAchievements[]. For each achievement you'll get a key, a name, a description and two URLs for the active (achievement accomplished) and inactive image (achievement not yet accomplished).
		See the oAchievementsController in the demo for an example.
	b)	getAchievementSprite(URL)
		downloads the sprite with the given URL. To avoid unneccessary network traffic downloaded sprites are cached and subsequent calls with the same URL will return
		the cached sprite instead of downloading it again.
		But the cache is currently not persistent so the sprites will be downloaded again if you restart the game.
		See the oAchievementsController in the demo for an example.
	c)	getPlayerAchievements()
		returns a list of all achievements defined for the game but enhanced with player informations.
		The result will be stored in oGlobalStatsIOController.gsPlayerAchievements[]. For each achievement you'll get a key, a name, a description and two URLs for the active (achievement accomplished) and inactive image (achievement not yet accomplished). You also get a boolean "accomplished" which is either true (achievement accomplished) or false (achievement not yet accomplished).
		See the oAchievementsController in the demo for an example.
	d)	accomplishAchievement(achievementName)
		Mark an achievement as accomplished.
		The accomplished achievement will be returned and stored in oGlobalStatsIOController.gsAccomplishedAchievement[], again with key, name, description and the two
		image URLs.
	e)	Accomplished achievements
		Whenever you send a GTD value (either by calling sendHighscore() or sendGTDValue()) you might trigger an achievement. So accomplished achievements can always be
		returned in the result. These will be stored in oGlobalStatsIOController.gsLatestAchievements[] with key, name, description and the two sprite URLs.
		You can also be notified by the wrapper by installing a callback script.
		setCallbackScripts(errorScript, achievementsAccomplishedScript) allows you to do that. See the demo scripts demoErrorResponseCallback() and demoAchievementsAccomplishedCallback() how to do that. In the demo the callback scripts are installed in the oStartController.


If you have any questions feel free to contact me at thomas@rightanglegames.com and have a look at the API description over at globalstats.io.

Cheers, have fun with my wrapper and best regards,
Thomas Haaks
https://www.rightanglegames.com

Credits:
========
To "Ciberman" for his free(!) playerprefs_gm asset on the Marketplace (https://marketplace.yoyogames.com/assets/4504/playerprefs_gm)
where I learned how to save something "automatically" while the game idles (see the step event action of oGlobalStatsIOController).
You should check out Ciberman's Tweenline asset - it's great! https://marketplace.yoyogames.com/assets/2909/tweenline-animation-engine

Once more to Ciberman and Zack Bell or the other people who came up with a solution how to implement singletons  within GameMaker:Studio.
You can find the Ciberman implementation in his PlayerPrefs and Tweenline asset, the solution from Zack is here:
https://zackbellgames.com/2016/11/13/loadworld-devlog-pt-2/

Also I need to credit Florian van Strien for his GameJolt API (http://gamejolt.com/games/gamejolt-achievement-api-for-gamemaker-studio/11689) which
gave me a good start on how to implement the globalstats.io binding.


