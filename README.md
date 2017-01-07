# gamemaker-extension
globalstats.io extension for GameMaker: Studio

This is still a work-in-progress. Please let us know any feedback you have or special use cases you have.

## Usage

Simply add the .gmez extension file to your project. You can remove all stuff that is in the Demo group (scripts, fonts, objects, rooms).
All you really need is the stuff in the groups GlobalStatsIO.

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
4. Copy the unique GTD key into the proper variable (highscoreGTD) in the Create action of the oGlobalStatsIOController.
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

Thomas Haaks