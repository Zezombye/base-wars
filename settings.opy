#!mainFile "base_wars.opy"

settings {
    "main": {
        "description": "BaseWars is a FFA in which you build your base, collect loot and raid your neighbours. First to 2500 gold wins - by any means necessary. v"+VERSION+" Feedback: discord.gg/EEMjjFB"
    },
    "lobby": {
        "mapRotation": "afterGame",
        "enableMatchVoiceChat": true,
        "returnToLobby": "never",
        "swapTeamsAfterMatch": false
    },
    "gamemodes": {
        "ffa": {
            "enabledMaps": [
                "blackForest"
            ]
        },
        "general": {
            "enableHeroSwitching": false,
            "gameLengthInMn": 15,
            "gamemodeStartTrigger": "immediately",
            "heroLimit": "off",
            "enableKillCam": false,
            "enableKillFeed": false,
            "respawnTime%": 60,
            "scoreToWin": 50,
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
