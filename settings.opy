#!mainFile "base_wars.opy"

settings {
    "main": {
        "modeName": "<fg00ffffff>Base <fgff5e5eff>Wars <fgffff00ff>"+VERSION,
        "description": "<fg00ffffff>Base Wars <fgffa600ff>is a FFA in which you <fgff6fd0ff>build your base</fg>, <fgc752ffff>collect loot</fg> and <fgc8ff55ff>raid your neighbors</fg>.\n\nFirst to <fgffff00ff>1000 gold</fg> wins - <fgf40000ff>by any means necessary.</fg>\n\n<fgddddddff>v"+VERSION+"</fg> | Code: <fg00ff6eff>"+GAMEMODE_CODE+"</fg>\n\nFeedback: <fgff00ffff>discord.gg/EEMjjFB</fg>\nMade by </fg>Durkhaz"
    },
    "lobby": {
        "mapRotation": "afterGame",
        "enableMatchVoiceChat": true,
        "returnToLobby": "never",
        "swapTeamsAfterMatch": false
    },
    "gamemodes": {
        "ffa": {
            /*"enabledMaps": [
                "oasisCityCenter"
            ]*/
            "disabledMaps": [
                "workshopChamber",
                "workshopExpanse",
                /*"workshopExpanseNight",*/
                "workshopGreenScreen",
                "workshopIsland",
                /*"workshopIslandNight"*/
            ]
        },
        "general": {
            "enableHeroSwitching": false,
            "gameLengthInMn": 15,
            "gamemodeStartTrigger": "allSlotsFilled",
            "heroLimit": "off",
            "enableKillCam": false,
            "enableKillFeed": false,
            "respawnTime%": 60,
            #"scoreToWin": 50,
            "enableSelfInitiatedRespawn": false,
            "spawnHealthPacks": "disabled"
        }
    },
    "heroes": {
        "allTeams": {
            "ana": {
                "ultGen%": 150
            },
            "mercy": {
                "ultGen%": 150
            },
            "hammond": {
                "healingReceived%": 80
            },
            "zenyatta": {
                "ultGen%": 150
            }
        }
    },
}
