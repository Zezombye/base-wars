#!mainFile "base_wars.opy"

globalvar displayScoreboard = false

rule "GAME WIN CONDITION":
    @Event eachPlayer
    @Hero all
    @Condition gameGoldVictory != 0
    @Condition eventPlayer.statsMoneyBase >= gameGoldVictory
    @Condition gameEnded == false
    
    #declarePlayerVictory(eventPlayer)
    gameEnded = true
    gameWinner = eventPlayer
    setSlowMotion(33)
    wait(0.5)
    bigMessage(getAllPlayers(), "{0} HAS WON THE GAME".format(eventPlayer))
    wait(0.8)
    getDeadPlayers(Team.ALL).respawn()
    
    tmpLootSpawnpointRandomPointWP = getAllPlayers()
    for tmpLootSpawnpoint in range(len(tmpLootSpawnpointRandomPointWP)):
        tmpLootSpawnpointRandomPoint = tmpLootSpawnpointRandomPointWP[tmpLootSpawnpoint]
        tmpLootSpawnpointRandomPoint.scoreArray = [tmpLootSpawnpointRandomPoint.scoreArray[0], tmpLootSpawnpointRandomPoint.scoreArray[0] / max(1, tmpLootSpawnpointRandomPoint.scoreArray[1]), tmpLootSpawnpointRandomPoint.scoreArray[8], tmpLootSpawnpointRandomPoint.scoreArray[2], tmpLootSpawnpointRandomPoint.scoreArray[3], tmpLootSpawnpointRandomPoint.scoreArray[2] / (getTotalTimeElapsed() - tmpLootSpawnpointRandomPoint.scoreArray[4]), tmpLootSpawnpointRandomPoint.scoreArray[2] / max(1, tmpLootSpawnpointRandomPoint.scoreArray[0]), tmpLootSpawnpointRandomPoint.scoreArray[5], tmpLootSpawnpointRandomPoint.scoreArray[6], tmpLootSpawnpointRandomPoint.scoreArray[7]]
        wait()
    gameScoreTopPlayers = []
    for tmpLootSpawnpoint in range(10):
        gameScoreTopPlayers.append(sorted(tmpLootSpawnpointRandomPointWP, lambda player: player.scoreArray[tmpLootSpawnpoint]).last())
        wait()
    gameScoreTopPlayersValues = []
    for tmpLootSpawnpoint in range(10):
        gameScoreTopPlayersValues.append(gameScoreTopPlayers[tmpLootSpawnpoint].scoreArray[tmpLootSpawnpoint])

    #display scoreboard
    displayScoreboard = true
    setSlowMotion(100)
    
    destroyAllInWorldTexts()
    destroyAllHudTexts()
    destroyAllEffects()
    destroyAllIcons()
    destroyAllDummies()
    wait()
    gameScorePositions[0] = raycast(gameEndCamera, gameEndCamera - vect(0, 10, 0), [], [], false).getHitPosition()
    #createDummy(random.choice(getAllHeroes()), Team.ALL, -1, gameScorePositions[0], Vector.BACKWARD)
    #gameWinner = getLastCreatedEntity()
    gameWinner.setFacing(Vector.BACKWARD, Relativity.TO_WORLD)
    gameWinner.teleport(gameScorePositions[0])
    gameWinner.startModifyingVoicelinePitch(random.uniform(0.5, 1.5), false)
    gameWinner.startScalingBarriers(0.1, false)
    gameWinner.startForcingPosition(gameScorePositions[0], false)
    gameScorePositions[1] = ((gameWinner.getEyePosition() - gameWinner.getPosition()) * 0.75).y
    gameEndCamera = gameScorePositions[0] + vect(gameScorePositions[1] * -1, gameScorePositions[1], gameScorePositions[1] * -2)
    gameWinner.setFacing(directionTowards(gameWinner.getEyePosition(), gameEndCamera), Relativity.TO_WORLD)

    gameScorePositions[2] = gameScorePositions[0] + vect(gameScorePositions[1] * -1.5, gameScorePositions[1] * 0.06, gameScorePositions[1] * 0)
    gameScorePositions[3] = gameScorePositions[2] + vect(0, gameScorePositions[1] * 0.075, 0)

    createInWorldText(getAllPlayers(), "Winner\n ", gameWinner.getEyePosition() + vect(0, gameScorePositions[1] * 0.55, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), " \n{0}".format(gameWinner), gameWinner.getEyePosition() + vect(0, gameScorePositions[1] * 0.55, 0), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)

    createInWorldText(getAllPlayers(), "{0} BOUNTY HUNTER \n\n{1} ASSASSIN\n\n{2} VICTIM\n\n \n\n \n\n \n\n \n\n \n\n \n\n \n".format(iconString(Icon.SKULL), abilityIconString(Hero.MCCREE, Button.ULTIMATE), iconString(Icon.SAD)), gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), " \n\n \n\n \n\n{0} GOLD HOARDER    \n\n{1} MASTER THIEF\n\n{2} FAST EARNER\n\n \n\n \n\n \n\n \n ".format(abilityIconString(Hero.SIGMA, Button.PRIMARY_FIRE), abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE), abilityIconString(Hero.TRACER, Button.ABILITY_1)), gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), " \n\n \n\n \n\n \n\n \n\n \n\n{0} FRIENDLY FARMER\n\n{1} COOKIE CLICKER\n\n{2} ENGINEER\n\n \n ".format(iconString(Icon.HEART), abilityIconString(Hero.SIGMA, Button.ABILITY_1), abilityIconString(Hero.BASTION, Button.SECONDARY_FIRE)), gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), " \n\n \n\n \n\n \n\n \n\n \n\n \n\n \n\n \n\n{0} TRAVELER              \n ".format(abilityIconString(Hero.SOLDIER, Button.ABILITY_1)), gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)

    createInWorldText(getAllPlayers(), b" \n\n\n\n\n\n\n\n\n\n\n\n\n{} \n\n{}\n\n{}\n\n{}\n\n{}\n\n{}\n\n{}\n\n{}\n\n{}\n\n{}\n\n\n".format(gameScoreTopPlayers[0], gameScoreTopPlayers[1], gameScoreTopPlayers[2], gameScoreTopPlayers[3], gameScoreTopPlayers[4], gameScoreTopPlayers[5], gameScoreTopPlayers[6], gameScoreTopPlayers[7], gameScoreTopPlayers[8], gameScoreTopPlayers[10]), gameScorePositions[2], 2.14, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)

    createInWorldText(getAllPlayers(), p"{}\n\n\n\n\n\n\n\n\n\n\n\n\n".format(
        "{}{}{}{}{}{}".format(
            p"                                                                          ", "{} kills\n\n".format(gameScoreTopPlayersValues[0]),
            p"                                                             ", "{} K/D\n\n".format(gameScoreTopPlayersValues[1]),
            p"                                                        ", "{} gold stolen from\n\n".format(gameScoreTopPlayersValues[2])
        )
    ), gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), p" \n\n\n\n\n\n{}\n\n\n\n\n\n\n".format(
        "{}{}{}{}{}{}".format(
            p"                                                                       ", "{} gold earned\n\n".format(gameScoreTopPlayersValues[3]), p"                                                                  ", "{} gold stolen\n\n".format(gameScoreTopPlayersValues[4]), p"                                                                  ", "{} gold/sec\n\n".format(gameScoreTopPlayersValues[5])
        )
    ), gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), p" \n\n\n\n\n\n\n\n\n\n\n\n{}{}{}".format(
        "{}{}\n\n{}{}\n\n{}{}\n\n".format(
            p"                                                                              ", "{} gold/kills".format(gameScoreTopPlayersValues[6]), p"                                                                           ", "{} orbs collected".format(gameScoreTopPlayersValues[7]), p"                                                                ", "{} upgrades".format(gameScoreTopPlayersValues[8])
        ),
        p"                                                                ", "{} bases moved\n ".format(gameScoreTopPlayersValues[9])
    ), gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)

    wait()
    gameWinner.stopForcingPosition()
    gameWinner.communicate(Comms.EMOTE_UP)
    #print("freecam: {}".format(eventPlayer.debugFreecam))
    #print("facing dir: {}".format(eventPlayer.getFacingDirection()))



rule "game ended - disable all buttons and HUDs":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned()
    @Condition displayScoreboard
    
    #eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    #eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.disallowButton(Button.INTERACT)
    eventPlayer.disallowButton(Button.JUMP)
    eventPlayer.disallowButton(Button.CROUCH)
    #eventPlayer.disallowButton(Button.MELEE)
    eventPlayer.disallowButton(Button.RELOAD)
    #eventPlayer.setStatusEffect(null, Status.FROZEN, 9999)
    #eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 9999)
    eventPlayer.setMoveSpeed(0)
    #eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.isInBase = true
    eventPlayer.playerBaseLocation = vect(0, -10000, 0)
    eventPlayer.hasBase = false
    eventPlayer.disableHeroHUD()
    eventPlayer.disableMessages()
    eventPlayer.startForcingOutlineFor(getAllPlayers(), false, Color.WHITE, OutlineVisibility.DEFAULT)
    eventPlayer.disableNameplatesFor(getAllPlayers())
    eventPlayer.startCamera(gameEndCamera, gameEndCamera + Vector.FORWARD, 0)
    if eventPlayer != gameWinner:
        eventPlayer.startForcingPosition(vect(1000, 1000, 1000), false)

