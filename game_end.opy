#!mainFile "base_wars.opy"

globalvar displayScoreboard = false
globalvar tmpAllPlayers
globalvar scoreboardIterator
globalvar tmpPlayer

#!define createIwtScoreboardTitle(text) createInWorldText(getAllPlayers(), text, gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
#!define createIwtScoreboardDesc(text) createInWorldText(getAllPlayers(), text, gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)

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
    bigMessage(getAllPlayers(), "{}{}".format(eventPlayer, STR_HAS_WON_GAME))
    wait(0.8)
    getDeadPlayers(Team.ALL).respawn()
    
    tmpAllPlayers = getAllPlayers()
    for scoreboardIterator in range(len(tmpAllPlayers)):
        tmpPlayer = tmpAllPlayers[scoreboardIterator]
        tmpPlayer.scoreArray = [
            tmpPlayer.scoreArray[Score.NB_KILLS],
            #k/d ratio
            tmpPlayer.scoreArray[Score.NB_KILLS] / max(1, tmpPlayer.scoreArray[Score.NB_DEATHS]),
            tmpPlayer.scoreArray[Score.GOLD_STOLEN_FROM],
            tmpPlayer.scoreArray[Score.GOLD_EARNED],
            tmpPlayer.scoreArray[Score.GOLD_STOLEN],
            #gold/second (total)
            tmpPlayer.scoreArray[Score.GOLD_EARNED] / (getTotalTimeElapsed() - tmpPlayer.scoreArray[Score.START_TIME]),
            #gold/kills
            tmpPlayer.scoreArray[Score.GOLD_EARNED] / max(1, tmpPlayer.scoreArray[Score.NB_KILLS]),
            tmpPlayer.scoreArray[Score.NB_ORBS_COLLECTED],
            tmpPlayer.scoreArray[Score.NB_UPGRADES],
            tmpPlayer.scoreArray[Score.NB_BASE_MOVES]
        ]
        wait()
    gameScoreTopPlayers = []
    for scoreboardIterator in range(10):
        gameScoreTopPlayers.append(sorted(tmpAllPlayers, lambda player: player.scoreArray[scoreboardIterator]).last())
        wait()
    gameScoreTopPlayersValues = []
    for scoreboardIterator in range(10):
        gameScoreTopPlayersValues.append(gameScoreTopPlayers[scoreboardIterator].scoreArray[scoreboardIterator])

    #display scoreboard
    displayScoreboard = true
    setSlowMotion(100)
    
    destroyAllInWorldTexts()
    destroyAllHudTexts()
    destroyAllEffects()
    destroyAllIcons()
    destroyAllDummies()
    wait()
    gameScorePositions[0] = raycast(gameEndCamera+Vector.FORWARD*2, gameEndCamera+Vector.FORWARD*2 - vect(0, 10, 0), [], [], false).getHitPosition()
    #createDummy(random.choice(getAllHeroes()), Team.ALL, -1, gameScorePositions[0], Vector.BACKWARD)
    #gameWinner = getLastCreatedEntity()
    gameWinner.setFacing(Vector.BACKWARD, Relativity.TO_WORLD)
    gameWinner.teleport(gameScorePositions[0])
    gameWinner.startModifyingVoicelinePitch(random.uniform(0.5, 1.5), false)
    gameWinner.startScalingBarriers(0.1, false)
    gameWinner.startForcingPosition(gameScorePositions[0], false)
    #gameScorePositions[1] = ((gameWinner.getEyePosition() - gameWinner.getPosition()) * 0.75).y
    gameScorePositions[1] = (vect(0,2,0) * 0.75).y
    gameEndCamera = gameScorePositions[0] + vect(gameScorePositions[1] * -1, gameScorePositions[1], gameScorePositions[1] * -2)
    gameWinner.setFacing(directionTowards(gameWinner.getEyePosition(), gameEndCamera), Relativity.TO_WORLD)

    gameScorePositions[2] = gameScorePositions[0] + vect(gameScorePositions[1] * -1.5, gameScorePositions[1] * 0.06, gameScorePositions[1] * 0)
    gameScorePositions[3] = gameScorePositions[2] + vect(0, gameScorePositions[1] * 0.075, 0)

    createInWorldText(getAllPlayers(), "{}\n ".format(STR_WINNER), updateEveryTick(gameWinner.getEyePosition() + vect(0, gameScorePositions[1] * 0.55, 0)), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), " \n{}".format(gameWinner), updateEveryTick(gameWinner.getEyePosition() + vect(0, gameScorePositions[1] * 0.55, 0)), 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)

    createIwtScoreboardTitle( "{}{}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n                                                                  ".format(iconString(Icon.SKULL), STR_BOUNTY_HUNTER))
    createIwtScoreboardTitle(" \n\n{}{}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n                                                                  ".format(abilityIconString(Hero.MCCREE, Button.ULTIMATE), STR_ASSASSIN))
    createIwtScoreboardTitle(" \n\n\n\n{}{}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n                                                                  ".format(iconString(Icon.SAD), STR_VICTIM))
    createIwtScoreboardTitle(" \n\n\n\n\n\n{}{}\n\n\n\n\n\n\n\n\n\n\n\n\n                                                                  ".format(abilityIconString(Hero.SIGMA, Button.PRIMARY_FIRE), STR_GOLD_HOARDER))
    createIwtScoreboardTitle(" \n\n\n\n\n\n\n\n{}{}\n\n\n\n\n\n\n\n\n\n\n                                                                  ".format(abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE), STR_MASTER_THIEF))
    createIwtScoreboardTitle(" \n\n\n\n\n\n\n\n\n\n{}{}\n\n\n\n\n\n\n\n\n                                                                  ".format(abilityIconString(Hero.TRACER, Button.ABILITY_1), STR_FAST_EARNER))
    createIwtScoreboardTitle(" \n\n\n\n\n\n\n\n\n\n\n\n{}{}\n\n\n\n\n\n\n                                                                  ".format(iconString(Icon.HEART), STR_FRIENDLY_FARMER))
    createIwtScoreboardTitle(" \n\n\n\n\n\n\n\n\n\n\n\n\n\n{}{}\n\n\n\n\n                                                                  ".format(abilityIconString(Hero.SIGMA, Button.ABILITY_1), STR_COOKIE_CLICKER))
    createIwtScoreboardTitle(" \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n{}{}\n\n\n                                                                  ".format(abilityIconString(Hero.BASTION, Button.SECONDARY_FIRE), STR_ENGINEER))
    createIwtScoreboardTitle(" \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n{}{}\n                                                                  ".format(abilityIconString(Hero.SOLDIER, Button.ABILITY_1), STR_TRAVELER))

    createInWorldText(getAllPlayers(), b" \n\n\n\n\n\n\n\n\n\n\n\n\n{} \n\n{}\n\n{}\n\n{}\n\n{}\n\n{}\n\n{}\n\n{}\n\n{}\n\n{}\n\n\n".format(gameScoreTopPlayers[0], gameScoreTopPlayers[1], gameScoreTopPlayers[2], gameScoreTopPlayers[3], gameScoreTopPlayers[4], gameScoreTopPlayers[5], gameScoreTopPlayers[6], gameScoreTopPlayers[7], gameScoreTopPlayers[8], gameScoreTopPlayers[9]), gameScorePositions[2], 2.14, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)

    createIwtScoreboardDesc( "{}{}{}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ".format("　　　　　　　　　　　　　　　　　　　　　　　　　  " /*STR_BOUNTY_HUNTER_WHITESPACE*/, /*123456*/gameScoreTopPlayersValues[0], STR_BOUNTY_HUNTER_DESC))
    createIwtScoreboardDesc(" \n\n{}{}{}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ".format("　　　　　　　　　　　　　　　　　　　　　　　　　  " /*STR_ASSASSIN_WHITESPACE*/, /*123456*/gameScoreTopPlayersValues[1], STR_ASSASSIN_DESC))
    createIwtScoreboardDesc(" \n\n\n\n{}{}{}\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ".format("　　　　　　　　　　　　　　　　　　　　　　　　　  " /*STR_VICTIM_WHITESPACE*/, /*123456*/gameScoreTopPlayersValues[2], STR_VICTIM_DESC))
    createIwtScoreboardDesc(" \n\n\n\n\n\n{}{}{}\n\n\n\n\n\n\n\n\n\n\n\n\n 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ".format("　　　　　　　　　　　　　　　　　　　　　　　　　  " /*STR_GOLD_HOARDER_WHITESPACE*/, /*123456*/gameScoreTopPlayersValues[3], STR_GOLD_HOARDER_DESC))
    createIwtScoreboardDesc(" \n\n\n\n\n\n\n\n{}{}{}\n\n\n\n\n\n\n\n\n\n\n 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ".format("　　　　　　　　　　　　　　　　　　　　　　　　　  " /*STR_MASTER_THIEF_WHITESPACE*/, /*123456*/gameScoreTopPlayersValues[4], STR_MASTER_THIEF_DESC))
    createIwtScoreboardDesc(" \n\n\n\n\n\n\n\n\n\n{}{}{}\n\n\n\n\n\n\n\n\n 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ".format("　　　　　　　　　　　　　　　　　　　　　　　　　  " /*STR_FAST_EARNER_WHITESPACE*/, /*123456*/gameScoreTopPlayersValues[5], STR_FAST_EARNER_DESC))
    createIwtScoreboardDesc(" \n\n\n\n\n\n\n\n\n\n\n\n{}{}{}\n\n\n\n\n\n\n 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ".format("　　　　　　　　　　　　　　　　　　　　　　　　　  " /*STR_FRIENDLY_FARMER_WHITESPACE*/, /*123456*/gameScoreTopPlayersValues[6], STR_FRIENDLY_FARMER_DESC))
    createIwtScoreboardDesc(" \n\n\n\n\n\n\n\n\n\n\n\n\n\n{}{}{}\n\n\n\n\n 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ".format("　　　　　　　　　　　　　　　　　　　　　　　　　  " /*STR_COOKIE_CLICKER_WHITESPACE*/, /*123456*/gameScoreTopPlayersValues[7], STR_COOKIE_CLICKER_DESC))
    createIwtScoreboardDesc(" \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n{}{}{}\n\n\n 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ".format("　　　　　　　　　　　　　　　　　　　　　　　　　  " /*STR_ENGINEER_WHITESPACE*/, /*123456*/gameScoreTopPlayersValues[8], STR_ENGINEER_DESC))
    createIwtScoreboardDesc(" \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n{}{}{}\n 　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 ".format("　　　　　　　　　　　　　　　　　　　　　　　　　  " /*STR_TRAVELER_WHITESPACE*/, /*123456*/gameScoreTopPlayersValues[9], STR_TRAVELER_DESC))

    wait(0.1)
    gameWinner.stopForcingPosition()
    wait(0.1)
    gameWinner.communicate(Comms.EMOTE_UP)
    #print("freecam: {}".format(eventPlayer.debugFreecam))
    #print("facing dir: {}".format(eventPlayer.getFacingDirection()))


rule "game ended - resurrect players":
    @Event eachPlayer
    @Condition displayScoreboard
    @Condition eventPlayer.isDead()
    eventPlayer.respawn()

rule "game ended and host afk - finish game":
    @Event global
    @Condition displayScoreboard
    wait(30)
    declarePlayerVictory(gameWinner)
    wait(3)
    restartMatch()

rule "game ended - disable all buttons and HUDs":
    @Event eachPlayer
    @Condition displayScoreboard
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.isAlive()
    wait()
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
    eventPlayer.cancelPrimaryAction()
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.setDamageReceived(0)
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
    else:
        eventPlayer.startForcingPosition(gameScorePositions[0], false)
        wait(0.1)
        eventPlayer.stopForcingPosition()

