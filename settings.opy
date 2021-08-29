#!mainFile "base_wars.opy"

settings {
    "main": {
        "modeName": "Base Wars",
        "description": "Base Wars is a FFA in which you build your base, collect loot and raid your neighbors.\n\nFirst to 1000 gold wins - by any means necessary.\n\nv"+VERSION+" | Code: "+GAMEMODE_CODE+"\n\nFeedback: discord.gg/EEMjjFB\nMade by Durkhaz"
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
                "workshopExpanseNight",
                "workshopGreenScreen",
                "workshopIsland",
                "workshopIslandNight"
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
