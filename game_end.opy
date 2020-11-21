#!mainFile "base_wars.opy"


rule "GAME ENDED LATE JOIN":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned()
    @Condition gameEnded
    
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.disallowButton(Button.INTERACT)
    eventPlayer.disallowButton(Button.JUMP)
    eventPlayer.disallowButton(Button.CROUCH)
    eventPlayer.disallowButton(Button.MELEE)
    eventPlayer.disallowButton(Button.RELOAD)
    eventPlayer.setStatusEffect(null, Status.FROZEN, 9999)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 9999)
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.isProtected = true


rule "display scoreboard":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.debugFreecam != null
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    
    destroyAllInWorldTexts()
    destroyAllHudTexts()
    destroyAllDummies()
    wait()
    getAllPlayers().disableHeroHUD()
    getAllPlayers().disableMessages()
    getAllPlayers().startForcingOutlineFor(getAllPlayers(), false, Color.WHITE, OutlineVisibility.DEFAULT)
    getAllPlayers().disableNameplatesFor(getAllPlayers())
    gameScorePositions[0] = raycast(eventPlayer.debugFreecam, eventPlayer.debugFreecam - vect(0, 10, 0), [], [], false).getHitPosition()
    createDummy(random.choice(getAllHeroes()), Team.ALL, -1, gameScorePositions[0], Vector.BACKWARD)
    debugDummyBot = getLastCreatedEntity()
    wait(0.5)
    eventPlayer.setFacing(Vector.FORWARD, Relativity.TO_WORLD)
    gameScorePositions[1] = ((debugDummyBot.getEyePosition() - debugDummyBot.getPosition()) * 0.75).y
    eventPlayer.debugFreecam = gameScorePositions[0] + vect(gameScorePositions[1] * -1, gameScorePositions[1], gameScorePositions[1] * -2)
    debugDummyBot.setFacing(directionTowards(debugDummyBot.getEyePosition(), eventPlayer.debugFreecam), Relativity.TO_WORLD)
    gameScorePositions[2] = gameScorePositions[0] + vect(gameScorePositions[1] * -1.5, gameScorePositions[1] * 0.06, gameScorePositions[1] * 0)
    gameScorePositions[3] = gameScorePositions[2] + vect(0, gameScorePositions[1] * 0.075, 0)
    gameScorePositions[4] = debugDummyBot.getEyePosition() + vect(0, gameScorePositions[1] * 0.55, 0)
    createInWorldText(getAllPlayers(), "Winner\n ", gameScorePositions[4], 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), " \n{0}".format(debugDummyBot), gameScorePositions[4], 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "{0} BOUNTY HUNTER \n\n{1} ASSASSIN\n\n{2} VICTIM\n\n \n\n \n\n \n\n \n\n \n\n \n\n \n".format(iconString(Icon.SKULL), abilityIconString(Hero.MCCREE, Button.ULTIMATE), iconString(Icon.SAD)), gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), " \n\n \n\n \n\n{0} GOLDHOARDER    \n\n{1} MASTERTHIEF\n\n{2} FAST EARNER\n\n \n\n \n\n \n\n \n ".format(abilityIconString(Hero.SIGMA, Button.PRIMARY_FIRE), abilityIconString(Hero.MOIRA, Button.SECONDARY_FIRE), abilityIconString(Hero.TRACER, Button.ABILITY_1)), gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), " \n\n \n\n \n\n \n\n \n\n \n\n{0} FRIENDLY FARMER\n\n{1} COOKIE CLICKER\n\n{2} ENGINEER\n\n \n ".format(iconString(Icon.HEART), abilityIconString(Hero.SIGMA, Button.ABILITY_1), abilityIconString(Hero.BASTION, Button.SECONDARY_FIRE)), gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), " \n\n \n\n \n\n \n\n \n\n \n\n \n\n \n\n \n\n{0} TRAVELER              \n ".format(abilityIconString(Hero.SOLDIER, Button.ABILITY_1)), gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "{0}{1}".format("{0}{1}{2}".format("  \n{0}\n\n{1}\n\n{2}\n".format(gameScoreTopPlayers[0], gameScoreTopPlayers[1], gameScoreTopPlayers[2]), "  \n{0}\n\n{1}\n\n{2}\n".format(gameScoreTopPlayers[3], gameScoreTopPlayers[4], gameScoreTopPlayers[5]), "  \n{0}\n\n{1}\n\n{2}\n".format(gameScoreTopPlayers[6], gameScoreTopPlayers[7], gameScoreTopPlayers[8])), "  \n{0}".format(gameScoreTopPlayers[10])), gameScorePositions[3], 2.14, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "{0}{1} \n\n \n\n \n\n \n".format("{0}\n\n{1}\n\n{2}\n\n".format("                                                                          {0} kills".format(gameScoreTopPlayersValues[0]), "                                                             {0} K/D".format(gameScoreTopPlayersValues[1]), "                                                        {0} gold stolen from".format(gameScoreTopPlayersValues[2])), "{0}\n\n{1}\n\n{2}\n\n".format("                                                                       {0} gold earned".format(gameScoreTopPlayersValues[3]), "                                                                  {0} gold stolen".format(gameScoreTopPlayersValues[4]), "                                                                  {0} gold/sec".format(gameScoreTopPlayersValues[5]))), gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), " \n\n \n\n \n\n \n\n \n\n \n\n{0}{1}".format("{0}\n\n{1}\n\n{2}\n\n".format("                                                                              {0} gold/kills".format(gameScoreTopPlayersValues[6]), "                                                                           {0} orbs collected".format(gameScoreTopPlayersValues[7]), "                                                                {0} upgrades".format(gameScoreTopPlayersValues[8])), "                                                                {0} bases moved\n ".format(gameScoreTopPlayersValues[9])), gameScorePositions[2], 1.9, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)


