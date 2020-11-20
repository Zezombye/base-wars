#!mainFile "base_wars.opy"


rule "GAME RULES PREPARE HOST JOIN":
    @Event playerJoined
    @Hero all
    @Condition eventPlayer == hostPlayer
    
    wait()
    eventPlayer.startForcingHero(Hero.ANA)


rule "GAME RULES PREPARE HOST":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer == hostPlayer
    @Condition isGameInitialized == true
    @Condition hasGameStarted == false
    
    gameRulesHost = eventPlayer
    eventPlayer.respawn()
    wait(0.16)
    gameRulesArray = [true, true, true, true, true, true, false, false, false, false]
    gameRulesArraySaved = gameRulesArray
    gameRulesSelectionMarkerArray[len(gameRulesArray) - 1] = 0
    gameRulesSelectionMarkerArray[0] = 1
    eventPlayer.teleport(vect(0, 10000, 0))
    eventPlayer.setGravity(0)
    eventPlayer.applyImpulse(vect(0, 1, 0), 70, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    wait()
    hudHeader(gameRulesHost, " \n{0}{1}{2}\n ".format("{0} {1}".format(iconString(Icon.ARROW_LEFT), buttonString(Button.PRIMARY_FIRE)), "                   [{0}]: toggle         [{1}]: finish                  ".format(buttonString(Button.INTERACT), buttonString(Button.ULTIMATE)), "{1} {0}".format(iconString(Icon.ARROW_RIGHT), buttonString(Button.SECONDARY_FIRE))), HudPosition.TOP, 4, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
    hudHeader(gameRulesHost, [" \n               Players can steal from bases              \n ", " \n         Occupied bases can be stolen from         \n ", "  \n                Enable Sparkbolts powerup                 \n ", "  \n           Base gold miner upgrade enabled          \n ", " \n      Randomly spawn loot orbs on the map     \n ", " \n    Sombra can pick up loot while invisible    \n ", " \n      Long Match (5000 gold win condition)      \n ", " \n                 Hero Switch is always free                   \n ", " \n                    Base Move is always free                    \n ", " \n        Base gold miner is half as efficient        \n "][gameRulesCurrentSelection], HudPosition.TOP, 6, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudHeader(gameRulesHost, [].concat("{0}".format(iconString(Icon.NO)).concat("{0}".format(iconString(Icon.CHECKMARK))))[gameRulesArray[gameRulesCurrentSelection]], HudPosition.TOP, 7, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
    tmpLootSpawnpointRandomPointWP = mapOrigin + mapRotationVector * mapXYZ.x * 0.5 + vect(mapRotationVector.z, 0, mapRotationVector.x * -1) * mapXYZ.z * 0.5 + (vect(0, mapXYZ.y + 100, 0))
    gameRulesHost.startCamera(tmpLootSpawnpointRandomPointWP, tmpLootSpawnpointRandomPointWP - vect(0, 50, 0), 0)
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.disallowButton(Button.INTERACT)
    eventPlayer.disallowButton(Button.MELEE)
    eventPlayer.disableHeroHUD()
    hudSubtext(gameRulesHost, "{0}{1}{2}".format("{0}{1}{2}".format("{0}{1}{2}".format(["○", "●"][gameRulesSelectionMarkerArray[0]], ["○", "●"][gameRulesSelectionMarkerArray[1]], ["○", "●"][gameRulesSelectionMarkerArray[2]]), ["○", "●"][gameRulesSelectionMarkerArray[3]], ["○", "●"][gameRulesSelectionMarkerArray[4]]), "{0}{1}{2}".format(["○", "●"][gameRulesSelectionMarkerArray[5]], ["○", "●"][gameRulesSelectionMarkerArray[6]], ["○", "●"][gameRulesSelectionMarkerArray[7]]), "{0}{1}{2}".format(["○", "●"][gameRulesSelectionMarkerArray[8]], ["○", "●"][gameRulesSelectionMarkerArray[9]], "")), HudPosition.TOP, 5, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)


rule "GAME RULES HOST CONTROLS":
    @Event eachPlayer
    @Hero all
    @Condition entityExists(gameRulesHost) == true
    @Condition isGameInitialized == true
    @Condition hasGameStarted == false
    @Condition eventPlayer == hostPlayer
    @Condition (eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or eventPlayer.isHoldingButton(Button.ULTIMATE) or eventPlayer.isHoldingButton(Button.INTERACT) or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)) == true
    
    if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE):
        gameRulesSelectionMarkerArray[gameRulesCurrentSelection] = 0
        if gameRulesCurrentSelection != 0:
            goto lbl_0
        gameRulesCurrentSelection = len(gameRulesArray) - 1
        goto lbl_1
        lbl_0:
        gameRulesCurrentSelection -= 1
        lbl_1:
        gameRulesSelectionMarkerArray[gameRulesCurrentSelection] = 1
        playEffect(gameRulesHost, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 15)
    elif eventPlayer.isHoldingButton(Button.SECONDARY_FIRE):
        gameRulesSelectionMarkerArray[gameRulesCurrentSelection] = 0
        gameRulesCurrentSelection = (gameRulesCurrentSelection + 1) % len(gameRulesArray)
        gameRulesSelectionMarkerArray[gameRulesCurrentSelection] = 1
        playEffect(gameRulesHost, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 15)
    elif eventPlayer.isHoldingButton(Button.INTERACT):
        gameRulesArray[gameRulesCurrentSelection] = not gameRulesArray[gameRulesCurrentSelection]
        playEffect(gameRulesHost, DynamicEffect.EXPLOSION_SOUND, Color.WHITE, eventPlayer, 15)
    elif eventPlayer.isHoldingButton(Button.ULTIMATE):
        gameStart()


rule "GAME RULES HOST QUIT":
    @Condition gameRulesHost != null
    @Condition gameRulesHost != hostPlayer
    @Condition isGameInitialized == true
    @Condition hasGameStarted == false
    
    gameStart()


rule "GAME RULES TIMEOUT":
    @Condition isGameInitialized == true
    @Condition hasGameStarted == false
    @Condition getMatchTime() <= 1
    
    gameStart()


rule "PLAYER HUD SETUP HOST":
    @Condition isGameInitialized == true
    @Condition hasGameStarted == false
    @Condition mapInfo != null
    
    hudHeader(getAllPlayers(), "WAITING FOR {0} TO SET GAME RULES".format(hostPlayer), HudPosition.TOP, 3, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
