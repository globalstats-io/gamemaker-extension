Readme for the GameMaker:Studio wrapper for globalstats.io Online highscores/services
=====================================================================================

Version 1.0, 2017/01/03, Thomas Haaks (https://www.rightanglegames.com, thomas@rightanglegames.com, Twitter: @RightAngleGames)

Hi there,
welcome to the readme for the GameMaker:Studio wrapper to the services of globalstats.io.
I am in no way affiliated with the nice guys behind globalstats.io, I just found their online backend services, liked them and
decided to create an API wrapper for GameMaker:Studio.

Here is the first version of this wrapper, I hope you'll find it useful.


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


