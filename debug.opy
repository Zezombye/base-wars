#!mainFile "base_wars.opy"

/*
rule "DEBUG SPAWN DUMMY BOT BULK":
    @Event eachPlayer
    @Condition DEBUG_MODE
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition eventPlayer.isCrouching() == true
    
    if entityExists(debugDummyBot):
        destroyAllDummies()
    else:
        createDummy(Hero.ANA, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
        createDummy(Hero.ANA, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
        createDummy(Hero.ANA, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
        createDummy(Hero.ANA, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
        createDummy(Hero.ANA, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
        createDummy(Hero.ANA, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
        createDummy(Hero.ANA, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
        createDummy(Hero.ANA, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
        createDummy(Hero.ANA, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
        createDummy(Hero.ANA, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
        createDummy(Hero.ANA, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
        debugDummyBot = getLastCreatedEntity()
*/

rule "debug each player":
    @Condition DEBUG_MODE
    for I in range(12):
        print("{} stealing from {}".format(getAllPlayers()[evalOnce(I)], getAllPlayers()[evalOnce(I)].stealingFrom))

rule "DEBUG SPAWN DUMMY BOT AUTO":
    @Condition DEBUG_MODE
    @Condition isGameInProgress()
    wait(5)
    createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[0], vect(0, 0, 0))
    createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[1], vect(0, 0, 0))
    createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[2], vect(0, 0, 0))
    createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[3], vect(0, 0, 0))
    createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[4], vect(0, 0, 0))
    createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[5], vect(0, 0, 0))
    createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[6], vect(0, 0, 0))
    createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[7], vect(0, 0, 0))
    createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[8], vect(0, 0, 0))
    createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[9], vect(0, 0, 0))

rule "debug end position":
    @Condition DEBUG_MODE
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.RED, raycast(gameEndCamera+Vector.FORWARD*2, gameEndCamera+Vector.FORWARD*2 - vect(0, 10, 0), [], [], false).getHitPosition(), 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

rule "debug money":
    @Event eachPlayer
    @Condition DEBUG_MODE
    @Condition isGameInProgress()
    wait(5)
    eventPlayer.statsMoney = 110
    if eventPlayer == hostPlayer:
        eventPlayer.statsMoney = 9999

rule "DEBUG VARIABLES":
    @Event eachPlayer
    @Hero all
    @Condition DEBUG_MODE
    @Condition hasGameStarted == true
    @Condition eventPlayer == hostPlayer
    
    hudSubheader(eventPlayer, " \nDebug Output:\n\n{0}\n{1}\n{2}".format("LOAD: {0} \nAVG: {1} \nPEAK: {2}".format(getServerLoad(), getAverageServerLoad(), getPeakServerLoad()), "Distance: {0}\nPlayer Pos: {1}\nPlayer Dir: {2}".format(distance(eventPlayer.getEyePosition(), eventPlayer.playerBaseLocation), eventPlayer.getPosition(), eventPlayer.getHorizontalFacingAngle()), "In Spawn: {0}\nFriendly: {1}\nIn Base of: {2}".format(eventPlayer.isInSpawnRoom(), eventPlayer.isInFriendlyZone, eventPlayer.stealingFrom)), HudPosition.LEFT, 100, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    #hudSubheader(getAllPlayers(), "TEST: {0}".format(dotProduct(directionTowards(eventPlayer.getEyePosition(), eventPlayer.playerBaseLocation), eventPlayer.getFacingDirection()) >= 1 - (1 / (distance(eventPlayer.getEyePosition(), eventPlayer.playerBaseLocation) / 10 + 1))), HudPosition.LEFT, 101, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)



rule "DEBUG COUNT EFFECTS":
    @Event eachPlayer
    @Hero all
    @Condition DEBUG_MODE
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    @Condition eventPlayer.isCrouching() == true
    @Condition len(eventPlayer.debugEffectCountArray) == 0
    @Condition eventPlayer == hostPlayer
    
    if eventPlayer.debugEffectCountArray.last() == 7:
        goto lbl_0
    createEffect([], Effect.SPHERE, Color.WHITE, eventPlayer, 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if getLastCreatedEntity() == null:
        goto lbl_1
    eventPlayer.debugEffectCountArray.append(getLastCreatedEntity())
    wait()
    goto RULE_START
    lbl_1:
    eventPlayer.debugEffectCountArray.append(7)
    smallMessage(eventPlayer, 129 - len(eventPlayer.debugEffectCountArray))
    lbl_0:
    destroyEffect(eventPlayer.debugEffectCountArray[eventPlayer.debugEffectCountIterator])
    eventPlayer.debugEffectCountIterator += 1
    wait()
    if eventPlayer.debugEffectCountIterator < len(eventPlayer.debugEffectCountArray):
        goto RULE_START
    eventPlayer.debugEffectCountArray = []
    eventPlayer.debugEffectCountIterator = 0


rule "debug win":
    @Condition hostPlayer.isHoldingButton(Button.INTERACT)
    declareTeamVictory(0[0])


rule "DEBUG FREECAM":
    @Event eachPlayer
    @Hero all
    @Condition DEBUG_MODE
    @Condition eventPlayer.isCommunicating(Comms.VOICE_LINE_UP) == true
    #@Condition eventPlayer == hostPlayer
    
    if eventPlayer.debugFreecam == null:
        goto lbl_0
    destroyEffect(eventPlayer.debugWalkablePositionEffect)
    eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.setUltEnabled(true)
    eventPlayer.setMoveSpeed(100)
    eventPlayer.teleport(eventPlayer.debugFreecam)
    eventPlayer.debugFreecam = null
    eventPlayer.stopCamera()
    eventPlayer.setInvisibility(Invis.NONE)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    return
    lbl_0:
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.setMoveSpeed(0.001)
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.debugFreecam = eventPlayer.getEyePosition()
    eventPlayer.setPrimaryFireEnabled(false)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.setUltEnabled(false)
    eventPlayer.startCamera(eventPlayer.debugFreecam, eventPlayer.debugFreecam + eventPlayer.getFacingDirection(), 125)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.GREEN, eventPlayer.debugWalkablePosition, 0.5, EffectReeval.POSITION_AND_RADIUS)
    eventPlayer.debugWalkablePositionEffect = getLastCreatedEntity()


rule "DEBUG FREECAM MOVEMENT":
    @Event eachPlayer
    @Hero all
    @Condition DEBUG_MODE
    @Condition eventPlayer.debugFreecam != null
    #@Condition eventPlayer == hostPlayer
    
    eventPlayer.debugFreecam += eventPlayer.getFacingDirection() * (eventPlayer.getThrottle().z / 2) + vect(eventPlayer.getFacingDirection().z * eventPlayer.getThrottle().x, 0, eventPlayer.getFacingDirection().x * eventPlayer.getThrottle().x * -1) / 2
    #eventPlayer.debugWalkablePosition = nearestWalkablePosition(raycast(eventPlayer.debugFreecam, eventPlayer.debugFreecam + eventPlayer.getFacingDirection() * 10, null, null, false).getHitPosition())
    wait()
    if RULE_CONDITION:
        goto RULE_START



rule "DEBUG DRAW MAP BOUNDARIES":
    @Condition DEBUG_MODE
    @Condition mapInfo != null
    
    wait(3)
    createIcon(getAllPlayers(), vect(-1000, 0, -1000), Icon.BOLT, IconReeval.NONE, Color.WHITE, false)
    createIcon(getAllPlayers(), mapOrigin, Icon.FLAG, IconReeval.POSITION, Color.WHITE, false)
    createBeam(getAllPlayers(), Beam.GOOD, mapOrigin, mapOrigin + mapRotationVector * mapXYZ.x, Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GOOD, mapOrigin, mapOrigin + vect(mapRotationVector.z, 0, mapRotationVector.x * -1) * mapXYZ.z, Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GOOD, mapOrigin, mapOrigin + vect(0, mapXYZ.y, 0), Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GOOD, mapOrigin + vect(0, mapXYZ.y, 0), mapOrigin + vect(0, mapXYZ.y, 0) + mapRotationVector * mapXYZ.x, Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GOOD, mapOrigin + vect(0, mapXYZ.y, 0), mapOrigin + vect(0, mapXYZ.y, 0) + vect(mapRotationVector.z, 0, mapRotationVector.x * -1) * mapXYZ.z, Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GOOD, mapOrigin + mapRotationVector * mapXYZ.x, mapOrigin + mapRotationVector * mapXYZ.x + vect(0, mapXYZ.y, 0), Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GOOD, mapOrigin + vect(mapRotationVector.z, 0, mapRotationVector.x * -1) * mapXYZ.z, mapOrigin + vect(mapRotationVector.z, 0, mapRotationVector.x * -1) * mapXYZ.z + vect(0, mapXYZ.y, 0), Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GOOD, mapOrigin + vect(mapRotationVector.z, 0, mapRotationVector.x * -1) * mapXYZ.z, mapOrigin + vect(mapRotationVector.z, 0, mapRotationVector.x * -1) * mapXYZ.z + mapRotationVector * mapXYZ.x, Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GOOD, mapOrigin + mapRotationVector * mapXYZ.x, mapOrigin + mapRotationVector * mapXYZ.x + vect(mapRotationVector.z, 0, mapRotationVector.x * -1) * mapXYZ.z, Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GOOD, mapOrigin + mapRotationVector * mapXYZ.x + vect(0, mapXYZ.y, 0), mapOrigin + mapRotationVector * mapXYZ.x + vect(mapRotationVector.z, 0, mapRotationVector.x * -1) * mapXYZ.z + vect(0, mapXYZ.y, 0), Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GOOD, mapOrigin + vect(0, mapXYZ.y, 0) + vect(mapRotationVector.z, 0, mapRotationVector.x * -1) * mapXYZ.z, mapOrigin + mapRotationVector * mapXYZ.x + vect(mapRotationVector.z, 0, mapRotationVector.x * -1) * mapXYZ.z + vect(0, mapXYZ.y, 0), Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createBeam(getAllPlayers(), Beam.GOOD, mapOrigin + mapRotationVector * mapXYZ.x + vect(mapRotationVector.z, 0, mapRotationVector.x * -1) * mapXYZ.z + vect(0, mapXYZ.y, 0), mapOrigin + mapRotationVector * mapXYZ.x + vect(mapRotationVector.z, 0, mapRotationVector.x * -1) * mapXYZ.z, Color.WHITE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)



rule "DEBUG MODIFY MAP BOUNDARIES":
    @Event eachPlayer
    @Hero all
    @Condition DEBUG_MODE
    @Condition eventPlayer == hostPlayer
    @Condition (eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) or eventPlayer.isHoldingButton(Button.RELOAD) or eventPlayer.isHoldingButton(Button.ULTIMATE)) == true
    @Condition eventPlayer.debugFreecam != null
    
    if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE):
        mapXYZ += vect(0.75, 0, 0)
    elif eventPlayer.isHoldingButton(Button.SECONDARY_FIRE):
        mapXYZ += vect(0, 0, 0.75)
    elif eventPlayer.isHoldingButton(Button.RELOAD):
        mapXYZ += vect(0, 0.5, 0)
    elif eventPlayer.isHoldingButton(Button.ULTIMATE):
        debugMapRot += 1
        mapRotationVector = angleToDirection(debugMapRot, 0)
    wait()
    if RULE_CONDITION:
        goto RULE_START

/*
rule "DEBUG SPAWN DUMMY BOT":
    @Event eachPlayer
    @Hero all
    @Condition DEBUG_MODE
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isCrouching()
    
    if entityExists(debugDummyBot):
        [player for player in getAllPlayers() if player.isDummy()].teleport(eventPlayer.getPosition())
    else:
        createDummy(Hero.ANA, Team.ALL, -1, eventPlayer.getPosition(), vect(0, 0, 0))
        createDummy(Hero.MCCREE, Team.ALL, -1, lootSpawnPoints[0], vect(0, 0, 0))
        debugDummyBot = getLastCreatedEntity()
        if false:
            createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[0], vect(0, 0, 0))
            createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[1], vect(0, 0, 0))
            createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[2], vect(0, 0, 0))
            createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[3], vect(0, 0, 0))
            createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[4], vect(0, 0, 0))
            createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[5], vect(0, 0, 0))
            createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[6], vect(0, 0, 0))
            createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[7], vect(0, 0, 0))
            createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[8], vect(0, 0, 0))
            createDummy(Hero.ANA, Team.ALL, -1, lootSpawnPoints[9], vect(0, 0, 0))
        wait(3)
        [player for player in getAllPlayers() if player.isDummy()].forceButtonPress(Button.INTERACT)
        wait(3)
        [player for player in getAllPlayers() if player.isDummy()].forceButtonPress(Button.INTERACT)
        wait(3)
        [player for player in getAllPlayers() if player.isDummy()].forceButtonPress(Button.INTERACT)
        wait(3)
        [player for player in getAllPlayers() if player.isDummy()].forceButtonPress(Button.INTERACT)
        wait(3)
        [player for player in getAllPlayers() if player.isDummy()].forceButtonPress(Button.INTERACT)
        wait(10)
        [player for player in getAllPlayers() if player.isDummy()].forceButtonPress(Button.INTERACT)
*/

rule "make all dummies press interact":
    @Event eachPlayer
    @Hero all
    @Condition DEBUG_MODE
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.isCrouching()
    
    [player for player in getAllPlayers() if player.isDummy()].forceButtonPress(Button.INTERACT)
