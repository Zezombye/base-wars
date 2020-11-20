
#!define DEBUG_MODE true

#Global variables

globalvar lootArrayLocations 0
globalvar isGameInitialized 1
globalvar hasGameStarted 2
globalvar lootSpawnPoints 3
globalvar lootArrayLocationsStored 4
globalvar gameGoldVictory 5
globalvar lootSpawnMax 6
globalvar lootSpread 7
globalvar lootCollectIterator 8
globalvar lootArraySpawned 9
globalvar lootSpawnpointIterator 10
globalvar lootSpawnerIterator 11
globalvar lootSpawnerNumLoot 12
globalvar lootSpawnerEffectIterator 13
globalvar gameRulesCurrentSelection 14
globalvar gameRulesArray 15
globalvar gameRulesHost 16
globalvar tmpLootSpawnpointRandomPointWP 17
globalvar tmpLootCollectClosestPlayer 18
globalvar tmpLootSpawnpoint 19
globalvar tmpLootSpawnpointProximity 20
globalvar gameRulesGoldMinerInitialCost 21
globalvar debugDummyBot 23
globalvar mapNavMesh 24
globalvar leaderboard 25
globalvar mapOrigin 26
globalvar mapXYZ 27
globalvar mapRotationVector 28
globalvar gameRulesSelectionMarkerArray 29
globalvar mapInfo 30
globalvar debugMapRot 31
globalvar bountyArrayLocations 32
globalvar bountyArrayEffects 33
globalvar bountyArrayMoney 34
globalvar bountyArrayNum 35
globalvar bountyArrayIterator 36
globalvar tmpBountyClosestPlayer 37
globalvar tmpBountyLocation 38
globalvar stealingPlayerIterator 39
globalvar tmpStealingBaseOwner 40
globalvar tmpStealingAllPlayers 41
globalvar tmpStealingPlayer 42
globalvar tmpStealingAllPlayersFiltered 43
globalvar tmpStealingAllBaseOwners 44
globalvar stealingBaseOwnerIterator 45
globalvar gameHealingHeroes 46
globalvar tmpPlayerLeftBaseIterator 47
globalvar tmpPlayerLeftIterator 48
globalvar disconnectedPlayers 49
globalvar mapSize 50
globalvar stealingRiskThreshold 51
globalvar stealingRiskMultiplier 52
globalvar leaderboardMaxScore 53
globalvar sparkboltSpawnpointIndex 54
globalvar sparkboltPickupPos 55
globalvar tmpSparkboltClosestPlayer 56
globalvar sparkboltEffects 57
globalvar tmpLootSpawnpointRandomPoint 58
globalvar lootBlockerVolumePos 59
globalvar tmpPowerupSpawnpointRandomPoint 60
globalvar tmpPowerupSpawnpointRandomPointW 61
globalvar lootBlockerVolumeRadius 62
globalvar gameRulesMoveBaseInitialCost 63
globalvar gameRulesGoldMinerFrequency 64
globalvar gameRulesVisibleTo 65
globalvar gameRulesArraySaved 66
globalvar gameRulesCustomized 67
globalvar gameEnded 68
globalvar gameWinner 69
globalvar gameEndingScreenPos 70
globalvar gameLootOrbAmount 71
globalvar gameScorePositions 72
globalvar lootPossiblePlayers 73
globalvar gameScoreTopPlayers 74
globalvar gameScoreTopPlayersValues 75
globalvar baseUpgradeSphereActualSize 76


#Player variables

playervar statsMoney 0
playervar hasBase 1
playervar statsUpgradeCostArray 2
playervar statsMoneyStorage 3
playervar tmpUpgradeCurrentSelection 4
playervar canAutoHeal 5
playervar regenStartTime 6
playervar isStealingActive 7
playervar playerBaseProximityIterator 8
playervar statsStealingSpeed 9
playervar debugWalkablePosition 10
playervar playerBaseLocation 11
playervar statsMoneyBase 12
playervar debugWalkablePositionEffect 13
playervar debugEffectCountIterator 14
playervar debugFreecam 15
playervar tmpUpgradeMoneySecDiff 16
playervar debugEffectCountArray 17
playervar baseProtectionTimer 18
playervar isMovingBase 19
playervar hudBaseProtection 20
playervar hudStealing 21
playervar hudBuildingBase 23
playervar baseEffectOrb 24
playervar tmpMoneyDifference 25
playervar statsMoneySec 26
playervar playerObjectInBase 27
playervar statsMoneyKill 28
playervar isProtected 29
playervar isChangingHero 30
playervar oldHeroHealth 31
playervar isInitialized 32
playervar upgradeLeftArrow 33
playervar upgradeRightArrow 34
playervar upgradeCurrentSelection 35
playervar upgradeInputCooldown 36
playervar upgradeTextTitle 37
playervar upgradeTextUpdated 38
playervar upgradeSphere 39
playervar upgradeCostTextVisibility 40
playervar regenID 41
playervar upgradeOffsetLeft 42
playervar upgradeOffsetRight 43
playervar isInFriendlyZone 44
playervar isCloaked 45
playervar stealingFromPlayerObject 46
playervar stealingSoundEffect 47
playervar stealingText 48
playervar tmpStealingAmount 49
playervar stealingOnCooldown 50
playervar stealingEffect 51
playervar stealingEffectsVisibleTo 52
playervar stealingFromPlayerObjectBackup 53
playervar upgradeTextDescription 54
playervar statsUpgradeLevels 55
playervar hudGoldBase 56
playervar baseEffectRing 57
playervar statsUpgradeHeroSwitchUsed 58
playervar statsUpgradeHeroSwitchShadowCost 59
playervar tmpStealingRiskBonus 60
playervar statsBaseDelay 61
playervar baseSparkboltCooldown 62
playervar tmpBaseSparkboltTarget 63
playervar statsNumSparkbolts 64
playervar sparkboltEffect 65
playervar scoreArray 66


#Subroutine names

subroutine settleBalance 0
subroutine HUDCreateNoBase 1
subroutine playerBaseCheck 2
subroutine playerBaseBuildEffects 3
subroutine baseUpgradeFail 4
subroutine spawnBaseEffect 5
subroutine checkUpgradeAvailability 6
subroutine protectedBaseEffect 7
subroutine gameStart 8
subroutine gameEndedScreenPos 9


#!include "settings.opy"
#!include "debug.opy"

rule "BASEWARS 1.141 BY DURKHAZ#2629 || discord.gg/EEMjjFB || 01.04.2020 || CONCEPT BY PYROCREEP#2665":
    #BASEWARS BY DURKHAZ#2629 - discord.gg/EEMjjFB
    #disableInspector()


rule "SPECIAL THANKS: CUDDLYFLOWER#2892, HuKuTa94#2589, Kevin#26140":


def gameStart():
    @Name "GAME START"
    
    for gameRulesCurrentSelection in range(len(gameRulesArray)):
        if gameRulesArray[gameRulesCurrentSelection] != gameRulesArraySaved[gameRulesCurrentSelection]:
            gameRulesCustomized = true
            goto lbl_0
    lbl_0:
    gameRulesHost.setInvisibility(Invis.NONE)
    gameRulesHost.allowButton(Button.PRIMARY_FIRE)
    gameRulesHost.allowButton(Button.SECONDARY_FIRE)
    gameRulesHost.allowButton(Button.ABILITY_1)
    gameRulesHost.allowButton(Button.ABILITY_2)
    gameRulesHost.allowButton(Button.ULTIMATE)
    gameRulesHost.allowButton(Button.INTERACT)
    gameRulesHost.allowButton(Button.MELEE)
    gameRulesHost.stopCamera()
    gameRulesHost.setGravity(100)
    gameRulesHost.clearStatusEffect(Status.PHASED_OUT)
    destroyAllHudTexts()
    gameRulesHost.enableHeroHud()
    ([player for player in getAllPlayers() if player != gameRulesHost]).respawn()
    gameRulesSelectionMarkerArray = []
    gameRulesArraySaved = null
    gameRulesHost.stopForcingCurrentHero()
    gameRulesHost.setAllowedHeroes(getAllHeroes().exclude(gameRulesHost.getCurrentHero()))
    #BASEWARS BY DURKHAZ#2629 - discord.gg/EEMjjFB
    setMatchTime(819)
    disableGamemodeCompletion()
    disableAnnouncer()
    disableScoring()
    disconnectedPlayers = []
    lootArrayLocations = []
    lootSpawnPoints = []
    lootPossiblePlayers = []
    bountyArrayLocations[11] = null
    bountyArrayEffects[11] = null
    bountyArrayMoney[11] = null
    leaderboard = []
    stealingRiskMultiplier = 1.5
    stealingRiskThreshold = 0.75
    gameLootOrbAmount = 25
    lootSpread = 15
    baseUpgradeSphereActualSize = 0.4 * 0.985
    sparkboltPickupPos = null
    gameRulesGoldMinerInitialCost = 30
    if gameRulesArray[3]:
        goto lbl_1
    gameRulesGoldMinerInitialCost = 100000
    lbl_1:
    gameGoldVictory = 2500
    if not gameRulesArray[6]:
        goto lbl_2
    gameGoldVictory = 5000
    lbl_2:
    gameRulesMoveBaseInitialCost = 50
    if not gameRulesArray[7]:
        goto lbl_3
    gameRulesMoveBaseInitialCost = 0
    lbl_3:
    gameRulesGoldMinerFrequency = 1
    if not gameRulesArray[9]:
        goto lbl_4
    gameRulesGoldMinerFrequency = 2
    lbl_4:
    lootSpawnMax = 16
    leaderboardMaxScore = gameGoldVictory * 2
    gameHealingHeroes = ((((([i for i in getAllHeroes() if not i in getSupportHeroes()]).concat(Hero.ZENYATTA.concat(Hero.ANA).concat(Hero.BRIGITTE))).exclude(Hero.BASTION)).exclude(Hero.MEI)).exclude(Hero.ROADHOG)).exclude(Hero.SOLDIER)
    bigMessage(getAllPlayers(), "GAME STARTED")
    hasGameStarted = true
    wait(0.25)
    gameRulesHost.resetHeroAvailability()
    gameRulesHost = null
    wait(0.75)
    pauseMatchTime()


rule "GAME INIT MAP":
    @Condition isGameInProgress() == true
    
    #BASEWARS BY DURKHAZ#2629 - discord.gg/EEMjjFB
    destroyAllHudTexts()
    lootBlockerVolumePos = null
    mapNavMesh = null
    mapInfo = null
    mapRotationVector = angleToDirection(0, 0)
    lootBlockerVolumeRadius = 30
    if getCurrentMap() == Map.BLACK_FOREST or getCurrentMap() == Map.BLACK_FOREST_WINTER:
        mapInfo = vect(-64.026, 10.008, -63.027)
    elif getCurrentMap() == Map.BLIZZ_WORLD or getCurrentMap() == Map.BLIZZ_WORLD_WINTER:
        mapNavMesh = vect(-92.816, -1.3, 119.946)
        mapInfo = vect(-93.084, 7, 68.06)
    elif getCurrentMap() == Map.CASTILLO:
        mapInfo = vect(-60.13, 7.032, 52.027)
    elif getCurrentMap() == Map.CHATEAU_GUILLARD or getCurrentMap() == Map.CHATEAU_GUILLARD_HALLOWEEN:
        mapInfo = vect(66.17, 13.001, 65.046)
    elif getCurrentMap() == Map.DORADO:
        mapInfo = vect(85.11, 14.007, -67.039)
        mapNavMesh = vect(69.636, 6.939, -13.709)
        mapRotationVector = angleToDirection(321, 0)
    elif getCurrentMap() == Map.ECOPOINT_ANTARCTICA or getCurrentMap() == Map.ECOPOINT_ANTARCTICA_WINTER:
        mapInfo = vect(-110.027, 10.003, -56.06)
    elif getCurrentMap() == Map.EICHENWALDE or getCurrentMap() == Map.EICHENWALDE_HALLOWEEN:
        mapNavMesh = vect(21.479, 4.943, -61.208)
        mapInfo = vect(55.021, 18.004, -77.102)
        mapRotationVector = angleToDirection(15, 0)
    elif getCurrentMap() == Map.HANAMURA or getCurrentMap() == Map.HANAMURA_WINTER:
        mapNavMesh = vect(41.188, 0.478, 24.839)
        mapInfo = vect(-138.015, -14.005, -65.105)
        mapRotationVector = angleToDirection(348, 0)
    elif getCurrentMap() == Map.HAVANA:
        mapNavMesh = vect(-18.944, 6.062, -80.093)
        mapInfo = vect(44, 8.004, -61.103)
    elif getCurrentMap() == Map.HOLLYWOOD or getCurrentMap() == Map.HOLLYWOOD_HALLOWEEN:
        mapNavMesh = vect(-18.025, 1.777, 14.081)
        mapInfo = vect(-82.041, 6.002, -87.072)
        mapRotationVector = angleToDirection(16, 0)
    elif getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        mapNavMesh = vect(51.683, 6.129, -34.033)
        mapInfo = vect(-166.055, 11.003, -80.112)
        mapRotationVector = angleToDirection(48, 0)
        lootBlockerVolumePos = vect(73.442, 17.829, -98.474)
        lootBlockerVolumeRadius = 16
    elif getCurrentMap() == Map.ILIOS_LIGHTHOUSE:
        mapInfo = vect(176.245, -12.03, -100.103)
        mapRotationVector = angleToDirection(23, 0)
    elif getCurrentMap() == Map.ILIOS_RUINS:
        mapInfo = vect(-45.081, 10.057, -219.184)
    elif getCurrentMap() == Map.ILIOS_WELL:
        mapInfo = vect(-157.179, -10.005, -51.094)
        mapRotationVector = angleToDirection(315, 0)
    elif getCurrentMap() == Map.KINGS_ROW or getCurrentMap() == Map.KINGS_ROW_WINTER:
        mapNavMesh = vect(-122.712, -1.072, -1.493)
        mapInfo = vect(-74.12, -14.004, -102.068)
        mapRotationVector = angleToDirection(350, 0)
        lootBlockerVolumePos = vect(-127.119, 0.434, -57.126)
    elif getCurrentMap() == Map.LIJIANG_CONTROL_CENTER or getCurrentMap() == Map.LIJIANG_CONTROL_CENTER_LNY:
        mapInfo = vect(-123.089, 14.265, 127.335)
        mapRotationVector = angleToDirection(45, 0)
    elif getCurrentMap() == Map.LIJIANG_GARDEN or getCurrentMap() == Map.LIJIANG_GARDEN_LNY:
        mapInfo = vect(-79.092, 4.094, 187.108)
    elif getCurrentMap() == Map.LIJIANG_NIGHT_MARKET or getCurrentMap() == Map.LIJIANG_NIGHT_MARKET_LNY:
        mapInfo = vect(-83.084, -8.002, -185.081)
    elif getCurrentMap() == Map.NECROPOLIS:
        mapInfo = vect(-65.048, -18.007, -80.036)
    elif getCurrentMap() == Map.NEPAL_SANCTUM:
        mapInfo = vect(194.041, 6.128, -74.097)
    elif getCurrentMap() == Map.NEPAL_SHRINE:
        mapInfo = vect(-183.073, 13.01, -54.09)
    elif getCurrentMap() == Map.NEPAL_VILLAGE or getCurrentMap() == Map.NEPAL_VILLAGE_WINTER:
        mapInfo = vect(-185.223, -14.102, -90.096)
    elif getCurrentMap() == Map.OASIS_GARDENS:
        mapInfo = vect(163.047, 11.001, -79.268)
        mapRotationVector = angleToDirection(45, 0)
    elif getCurrentMap() == Map.OASIS_UNIVERSITY:
        mapInfo = vect(-140.225, 11.008, -64.07)
    elif getCurrentMap() == Map.PARIS:
        mapNavMesh = vect(-46.367, 10.098, -0.162)
        mapInfo = vect(-86.143, 8.008, -82.084)
        mapRotationVector = angleToDirection(26, 0)
    elif getCurrentMap() == Map.PETRA:
        mapInfo = vect(-83.044, -15.012, -83.015)
    elif getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        mapNavMesh = vect(-4.694, -2.336, -6.513)
        mapInfo = vect(80.016, 10, -130.004)
        mapRotationVector = angleToDirection(275, 0)
    elif getCurrentMap() == Map.VOLSKAYA:
        mapNavMesh = vect(14.482, -4.352, 44.386)
        mapInfo = vect(-73.094, -8.005, 145.01)
        mapRotationVector = angleToDirection(335, 0)
        lootBlockerVolumePos = vect(28.034, 27.621, 76.387)
    elif getCurrentMap() == Map.WORKSHOP_EXPANSE:
        mapInfo = vect(-200.1, 1, -200.1)
    if mapInfo == null:
        return
    mapXYZ = mapInfo / vect(abs(mapInfo.x), abs(mapInfo.y), abs(mapInfo.z))
    mapXYZ *= vect(floor(abs(mapInfo.x)), floor(abs(mapInfo.y)), floor(abs(mapInfo.z)))
    mapOrigin = 1000 * (mapInfo - mapXYZ)
    mapXYZ = vect(abs(mapXYZ.x), abs(mapXYZ.y), abs(mapXYZ.z))
    mapSize = sqrt(mapXYZ.x ** 2 + mapXYZ.z ** 2) - 20
    wait(1)
    if mapNavMesh == null:
        goto lbl_0
    while distance(nearestWalkablePosition(mapNavMesh), mapNavMesh) <= 2:
        wait(0.25)
    lbl_0:
    isGameInitialized = true
    setMatchTime(62)
    gameEndingScreenPos = vect(0, 0, 0)


/*
rule "GAME INIT":
    @Condition hasGameStarted == true
    
    #BASEWARS BY DURKHAZ#2629 - discord.gg/EEMjjFB
    setMatchTime(819)
    disableGamemodeCompletion()
    disableAnnouncer()
    disableScoring()
    disconnectedPlayers = []
    lootArrayLocations = []
    lootSpawnPoints = []
    lootPossiblePlayers = []
    bountyArrayLocations[11] = null
    bountyArrayEffects[11] = null
    bountyArrayMoney[11] = null
    leaderboard = []
    stealingRiskMultiplier = 1.5
    stealingRiskThreshold = 0.75
    gameLootOrbAmount = 25
    lootSpread = 15
    baseUpgradeSphereActualSize = 0.4 * 0.985
    sparkboltPickupPos = null
    gameRulesGoldMinerInitialCost = 30
    if gameRulesArray[3]:
        goto lbl_0
    gameRulesGoldMinerInitialCost = 100000
    lbl_0:
    gameGoldVictory = 2500
    if not gameRulesArray[6]:
        goto lbl_1
    gameGoldVictory = 5000
    lbl_1:
    gameRulesMoveBaseInitialCost = 50
    if not gameRulesArray[7]:
        goto lbl_2
    gameRulesMoveBaseInitialCost = 0
    lbl_2:
    gameRulesGoldMinerFrequency = 1
    if not gameRulesArray[9]:
        goto lbl_3
    gameRulesGoldMinerFrequency = 2
    lbl_3:
    leaderboardMaxScore = gameGoldVictory * 2
    gameHealingHeroes = ((((([i for i in getAllHeroes() if not i in getSupportHeroes()]).concat(Hero.ZENYATTA.concat(Hero.ANA).concat(Hero.BRIGITTE))).exclude(Hero.BASTION)).exclude(Hero.MEI)).exclude(Hero.ROADHOG)).exclude(Hero.SOLDIER)
    lootSpawnMax = 16
    wait(1)
    pauseMatchTime()
*/

rule "skip assembling heroes":
    @Condition isAssemblingHeroes() == true
    
    #BASEWARS BY DURKHAZ#2629 - discord.gg/EEMjjFB
    setMatchTime(0)


rule "GAME WIN CONDITION":
    @Event eachPlayer
    @Hero all
    @Condition gameGoldVictory != 0
    @Condition eventPlayer.statsMoneyBase >= gameGoldVictory
    @Condition gameEnded == false
    
    #BASEWARS BY DURKHAZ#2629 - discord.gg/EEMjjFB
    #declarePlayerVictory(eventPlayer)
    gameEnded = true
    gameWinner = eventPlayer
    setSlowMotion(33)
    wait(0.5)
    destroyAllHudTexts()
    bigMessage(getAllPlayers(), "{0} HAS WON THE GAME".format(eventPlayer))
    wait(0.8)
    getDeadPlayers(Team.ALL).respawn()
    getAllPlayers().setStatusEffect(null, Status.INVINCIBLE, 9999)
    getAllPlayers().setStatusEffect(null, Status.ROOTED, 9999)
    getAllPlayers().disallowButton(Button.PRIMARY_FIRE)
    getAllPlayers().disallowButton(Button.SECONDARY_FIRE)
    getAllPlayers().disallowButton(Button.ABILITY_1)
    getAllPlayers().disallowButton(Button.ABILITY_2)
    getAllPlayers().disallowButton(Button.ULTIMATE)
    getAllPlayers().disallowButton(Button.INTERACT)
    getAllPlayers().disallowButton(Button.JUMP)
    getAllPlayers().disallowButton(Button.CROUCH)
    getAllPlayers().disallowButton(Button.MELEE)
    getAllPlayers().disallowButton(Button.RELOAD)
    wait(0.1)
    destroyAllEffects()
    destroyAllIcons()
    destroyAllInWorldTexts()
    getAllPlayers().setInvisibility(Invis.ALL)
    getAllPlayers().playerBaseLocation = vect(0, -10000, 0)
    getAllPlayers().isProtected = true
    getAllPlayers().hasBase = false
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


rule "GAME MEDKIT NERF":
    @Event playerReceivedHealing
    @Hero all
    @Condition eventWasHealthPack == true
    
    eventPlayer.setStatusEffect(null, Status.HACKED, 5)
    eventPlayer.setMoveSpeed(75)
    wait(5)
    eventPlayer.setMoveSpeed(100)


rule "GAME RULES HUD SHOW":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isHoldingButton(Button.MELEE) == true
    @Condition eventPlayer.isHoldingButton(Button.CROUCH) == true
    @Condition hasGameStarted == true
    @Condition gameRulesCustomized == true
    
    if eventPlayer in gameRulesVisibleTo:
        gameRulesVisibleTo.remove(eventPlayer)
    else:
        gameRulesVisibleTo.append(eventPlayer)
    wait(1)



rule "PLAYER INIT":
    @Event eachPlayer
    @Hero all
    @Condition hasGameStarted == true
    @Condition gameEnded == false
    
    #BASEWARS BY DURKHAZ#2629 - discord.gg/EEMjjFB
    eventPlayer.hasBase = false
    eventPlayer.isMovingBase = false
    eventPlayer.statsMoneySec = 0
    eventPlayer.statsMoney = 10000
    eventPlayer.statsMoneyStorage = 100
    eventPlayer.upgradeCurrentSelection = 2
    eventPlayer.statsUpgradeCostArray = [gameRulesGoldMinerInitialCost, 25, eventPlayer.statsMoneyStorage, gameRulesMoveBaseInitialCost, 0, 30, 80]
    eventPlayer.statsUpgradeLevels = [1, 1, 1, 0, 0, 1, 1]
    eventPlayer.statsUpgradeHeroSwitchShadowCost = 75
    eventPlayer.statsMoneyKill = 5
    eventPlayer.statsStealingSpeed = 1
    eventPlayer.statsBaseDelay = 4
    eventPlayer.isStealingActive = false
    eventPlayer.playerBaseLocation = vect(0, -1000, 0)
    eventPlayer.playerObjectInBase = null
    eventPlayer.stealingEffectsVisibleTo = []
    eventPlayer.isInFriendlyZone = false
    eventPlayer.debugEffectCountArray = []
    W = [null, null, null]
    eventPlayer.upgradeInputCooldown = false
    eventPlayer.upgradeOffsetLeft = 0.9
    eventPlayer.upgradeOffsetRight = eventPlayer.upgradeOffsetLeft * -1


rule "PLAYER JOIN":
    @Event playerJoined
    @Hero all
    
    eventPlayer.disableGamemodeHud()
    eventPlayer.disableScoreboard()
    eventPlayer.scoreArray[4] = getTotalTimeElapsed()
    if gameRulesVisibleTo != 0:
        goto lbl_0
    gameRulesVisibleTo = []
    lbl_0:
    gameRulesVisibleTo.append(eventPlayer)


rule "PLAYER DISCONNECT QUEUE":
    @Event playerLeft
    @Hero all
    
    disconnectedPlayers.append(eventPlayer)
    gameRulesVisibleTo.remove(eventPlayer)


rule "PLAYER DISCONNECT CLEANUP":
    @Condition hasGameStarted
    
    if disconnectedPlayers != []:
        for tmpPlayerLeftIterator in range(len(disconnectedPlayers)):
            for tmpPlayerLeftBaseIterator in range(len(getAllPlayers())):
                getAllPlayers()[tmpPlayerLeftBaseIterator].stealingEffectsVisibleTo.remove(disconnectedPlayers[tmpPlayerLeftIterator])
        disconnectedPlayers = []
    wait(3)
    goto RULE_START


rule "PLAYER HUD NOT STARTED":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned()
    @Condition isGameInProgress() == false
    
    hudHeader(eventPlayer, "WAITING FOR HOST ({0}) TO START THE GAME".format(hostPlayer), HudPosition.TOP, 3, Color.RED, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "PLAYER HUD FAIL":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned()
    @Condition hasGameStarted == false
    @Condition mapInfo == null
    @Condition isGameInProgress()
    
    hudHeader(eventPlayer, "The map {0} IS NOT SUPPORTED".format(getCurrentMap()), HudPosition.TOP, 3, Color.RED, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "PLAYER HUD AWAITING NAV":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned()
    @Condition hasGameStarted == false
    @Condition isGameInitialized == false
    @Condition mapInfo != null
    
    hudHeader(eventPlayer, "WAITING FOR GAME TO START", HudPosition.TOP, 3, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "PLAYER HUD GAME INIT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.isInitialized == false
    @Condition hasGameStarted == true
    
    wait(0.25)
    eventPlayer.isInitialized = true
    destroyHudText(eventPlayer.hudGoldBase)
    hudText(eventPlayer, iconString(Icon.CIRCLE), "GOLD IN BASE", "{0}/{1} (+{2}/sec)".format(eventPlayer.statsMoneyBase, eventPlayer.statsMoneyStorage, eventPlayer.statsMoneySec), HudPosition.LEFT, 0, Color.ORANGE, Color.ORANGE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.hudGoldBase = getLastCreatedText()
    hudText(eventPlayer, iconString(Icon.POISON), "GOLD ON PLAYER", eventPlayer.statsMoney, HudPosition.LEFT, 1, Color.ORANGE, Color.ORANGE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    if eventPlayer.hasBase:
        goto lbl_0
    HUDCreateNoBase()
    lbl_0:


rule "PLAYER HUD GLOBAL":
    @Condition hasGameStarted == true
    
    wait()
    #hudSubtext(getAllPlayers(), " \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n ", HudPosition.TOP, -1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
    #hudSubtext(getAllPlayers(), " \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n ", HudPosition.TOP, -1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
    hudText(getAllPlayers(), null, "                                       discord.gg/YP544CH\nScoreboard    -    Base Wars 1.14 01/04/20", "FIRST TO {0} GOLD IN BASE WINS!\n \n{1}".format(gameGoldVictory, " · {0}\n · {1}\n · {2}".format("{0}% {1} {2} ".format(floor(((leaderboard.last().statsMoneyBase + leaderboard.last().statsMoneyStorage) / leaderboardMaxScore) * 100), heroIcon(leaderboard.last().getCurrentHero()), leaderboard.last()), "{0}% {1} {2}".format(floor((((leaderboard[len(leaderboard) - 2]).statsMoneyBase + ((leaderboard[len(leaderboard) - 2]).statsMoneyStorage)) / leaderboardMaxScore) * 100), heroIcon((leaderboard[len(leaderboard) - 2]).getCurrentHero()), leaderboard[len(leaderboard) - 2]), "{0}% {1} {2}".format(floor((((leaderboard[len(leaderboard) - 3]).statsMoneyBase + ((leaderboard[len(leaderboard) - 3]).statsMoneyStorage)) / leaderboardMaxScore) * 100), heroIcon((leaderboard[len(leaderboard) - 3]).getCurrentHero()), leaderboard[len(leaderboard) - 3]))), HudPosition.RIGHT, 1, Color.WHITE, Color.ORANGE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    if not gameRulesCustomized:
        goto lbl_0
    hudText(gameRulesVisibleTo, null, "Lobby Mods: {0}{1}{2}".format("{0}{1}{2}".format("{0}{1}{2}".format(["No Stealing, ", ""][gameRulesArray[0]], ["Steal from empty base only, ", ""][gameRulesArray[1]], ["No Sparkbolt, ", ""][gameRulesArray[2]]), ["No Goldminer, ", ""][gameRulesArray[3]], ["No Loot, ", ""][gameRulesArray[4]]), "{0}{1}{2}".format(["No Sombra Invis loot, ", ""][gameRulesArray[5]], ["", "5000 gold victory, "][gameRulesArray[6]], ["", "Free Heroswitch, "][gameRulesArray[7]]), "{0}{1}{2}".format(["", "Free Basemove, "][gameRulesArray[8]], ["", "Slower Goldminer, "][gameRulesArray[9]], "")), "{0} + {1} to hide mods".format(buttonString(Button.CROUCH), buttonString(Button.MELEE)), HudPosition.LEFT, -1, Color.ORANGE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
    lbl_0:


rule "PLAYER HUD BASE GOLD FULL":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.statsMoneyBase == eventPlayer.statsMoneyStorage
    
    destroyHudText(eventPlayer.hudGoldBase)
    hudText(eventPlayer, iconString(Icon.EXCLAMATION_MARK), "GOLD IN BASE", "{0}/{1} (FULL!)".format(eventPlayer.statsMoneyBase, eventPlayer.statsMoneyStorage), HudPosition.LEFT, 0, Color.ORANGE, Color.ORANGE, Color.RED, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.hudGoldBase = getLastCreatedText()


rule "PLAYER HUD BASE GOLD":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.statsMoneyBase < eventPlayer.statsMoneyStorage
    
    if not eventPlayer.isInitialized:
        return
    destroyHudText(eventPlayer.hudGoldBase)
    hudText(eventPlayer, iconString(Icon.CIRCLE), "GOLD IN BASE", "{0}/{1} (+{2}/sec)".format(eventPlayer.statsMoneyBase, eventPlayer.statsMoneyStorage, eventPlayer.statsMoneySec / gameRulesGoldMinerFrequency), HudPosition.LEFT, 0, Color.ORANGE, Color.ORANGE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.hudGoldBase = getLastCreatedText()


rule "PLAYER HUD LEADERBOARD LOOP":
    @Condition hasGameStarted == true
    
    leaderboard = sorted([player for player in getAllPlayers() if player.statsMoneyBase + player.statsMoneyStorage > 0], lambda i: i.statsMoneyBase + i.statsMoneyStorage * 10)
    wait(1)
    goto RULE_START


rule "PLAYER REGEN CONDITION":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned() == true
    
    eventPlayer.canAutoHeal = false
    if not eventPlayer.getCurrentHero() in gameHealingHeroes:
        return
    eventPlayer.canAutoHeal = true


rule "PLAYER REGEN TAKE DAMAGE":
    @Event playerTookDamage
    @Hero all
    @Condition eventPlayer.canAutoHeal == true
    
    eventPlayer.regenStartTime = getTotalTimeElapsed() + 5
    stopHoT(eventPlayer.regenID)
    eventPlayer.regenID = null


rule "PLAYER REGEN START":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.canAutoHeal == true
    @Condition eventPlayer.getHealth() != eventPlayer.getMaxHealth()
    @Condition eventPlayer.regenStartTime < getTotalTimeElapsed()
    @Condition eventPlayer.regenStartTime != 0
    @Condition eventPlayer.regenID == null
    @Condition eventPlayer.isProtected == false
    
    eventPlayer.startHoT(null, 9999, 33)
    eventPlayer.regenID = getLastHoT()


rule "PLAYER REGEN STOP":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.regenID != null
    @Condition eventPlayer.getHealth() == eventPlayer.getMaxHealth()
    
    stopHoT(eventPlayer.regenID)
    eventPlayer.regenID = null


rule "PLAYER SOMBRA CLOAK ON":
    @Event eachPlayer
    @Hero all
    @Condition hasGameStarted == true
    @Condition eventPlayer.getCurrentHero() == Hero.SOMBRA
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.isCloaked = true


rule "PLAYER SOMBRA CLOAK OFF":
    @Event eachPlayer
    @Hero all
    @Condition hasGameStarted == true
    @Condition eventPlayer.getCurrentHero() == Hero.SOMBRA
    @Condition eventPlayer.isUsingAbility1() == false
    
    eventPlayer.isCloaked = false


rule "BASE BUILD CHECK CONDITION":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasBase == false
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.playerBaseLocation.y == -1000
    @Condition eventPlayer.isOnGround() == true
    @Condition hasGameStarted == true
    @Condition eventPlayer.stealingFromPlayerObject == null
    
    playerBaseCheck()
    wait(0.75)


rule "BASE BUILD":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasBase == false
    @Condition eventPlayer.playerBaseLocation.y != -1000
    @Condition hasGameStarted == true
    
    eventPlayer.hasBase = true
    spawnBaseEffect()
    #createIcon(eventPlayer, eventPlayer.playerBaseLocation + vect(0, 2.8, 0), Icon.HALO, IconReeval.POSITION, Color.WHITE, false)
    createInWorldText([player for player in getAllPlayers() if player != eventPlayer], "{1} {0} {2}".format(eventPlayer, heroIcon(eventPlayer.getCurrentHero()), eventPlayer.statsMoneyBase), eventPlayer.playerBaseLocation + vect(0, 2, 0), 0.8, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    createInWorldText(eventPlayer, "{0} YOUR BASE".format(heroIcon(eventPlayer.getCurrentHero())), eventPlayer.playerBaseLocation + vect(0, 2.5, 0), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.NEVER)
    createInWorldText(eventPlayer.upgradeCostTextVisibility, " \n \n \n \n \n{0} GOLD".format(eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
    playerBaseBuildEffects()


rule "BASE ENTER":
    @Event eachPlayer
    @Hero all
    @Condition hasGameStarted == true
    @Condition eventPlayer.playerObjectInBase == null
    @Condition eventPlayer.hasBase == true
    @Condition distance(eventPlayer.playerBaseLocation, eventPlayer) <= 3.5
    @Condition eventPlayer.hasStatusEffect(Status.ASLEEP) == false
    @Condition eventPlayer.hasStatusEffect(Status.FROZEN) == false
    @Condition eventPlayer.hasStatusEffect(Status.UNKILLABLE) == false
    @Condition eventPlayer.hasStatusEffect(Status.INVINCIBLE) == false
    @Condition eventPlayer.hasStatusEffect(Status.PHASED_OUT) == false
    @Condition eventPlayer.isUsingUltimate() == false
    @Condition eventPlayer.isCloaked == false
    
    eventPlayer.playerObjectInBase = eventPlayer
    stopChasingVariable(eventPlayer.baseProtectionTimer)
    eventPlayer.baseProtectionTimer = eventPlayer.statsBaseDelay
    hudHeader(eventPlayer, "{0} ENTERING BASE {0} \n           IN {1} SEC".format(iconString(Icon.WARNING), eventPlayer.baseProtectionTimer), HudPosition.TOP, -3, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.hudBaseProtection = getLastCreatedText()
    chase(eventPlayer.baseProtectionTimer, 0, rate=1, ChaseReeval.NONE)


rule "BASE ENTER ABORT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.playerObjectInBase == eventPlayer
    @Condition eventPlayer.isProtected == false
    @Condition (eventPlayer.isCloaked or eventPlayer.hasStatusEffect(Status.ASLEEP) or eventPlayer.hasStatusEffect(Status.FROZEN) or eventPlayer.hasStatusEffect(Status.UNKILLABLE) or eventPlayer.hasStatusEffect(Status.INVINCIBLE) or eventPlayer.hasStatusEffect(Status.PHASED_OUT) or eventPlayer.isUsingUltimate()) == true
    
    stopChasingVariable(eventPlayer.baseProtectionTimer)
    destroyHudText(eventPlayer.hudBaseProtection)
    eventPlayer.playerObjectInBase = null


rule "BASE EXIT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.playerObjectInBase != null
    @Condition hasGameStarted == true
    @Condition eventPlayer.hasBase == true
    @Condition distance(eventPlayer.playerBaseLocation, eventPlayer) >= 3.5
    
    eventPlayer.playerObjectInBase = null
    eventPlayer.setDamageDealt(100)
    stopChasingVariable(eventPlayer.baseProtectionTimer)
    destroyHudText(eventPlayer.hudBaseProtection)
    if not eventPlayer.isProtected:
        return
    eventPlayer.isProtected = false
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.setInvisibility(Invis.NONE)
    eventPlayer.stopAllHoT()
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.MELEE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.allowButton(Button.ULTIMATE)
    destroyEffect(eventPlayer.upgradeSphere)
    destroyIcon(eventPlayer.upgradeLeftArrow)
    destroyIcon(eventPlayer.upgradeRightArrow)
    eventPlayer.upgradeLeftArrow = null
    eventPlayer.upgradeRightArrow = null


rule "BASE PROTECTED":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.playerObjectInBase != null
    @Condition eventPlayer.baseProtectionTimer == 0
    @Condition eventPlayer.isAlive() == true
    @Condition gameEnded == false
    
    eventPlayer.setDamageDealt(0)
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.startHoT(eventPlayer, 9999, 25)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.disallowButton(Button.MELEE)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.setMoveSpeed(100)
    stopHoT(eventPlayer.regenID)
    eventPlayer.regenID = null
    stopChasingVariable(eventPlayer.baseProtectionTimer)
    destroyHudText(eventPlayer.hudBaseProtection)
    hudText(eventPlayer, "           {0} PROTECTED AND INVISIBLE {0}\n\nTo upgrade, look at white center orb".format(iconString(Icon.CHECKMARK)), "Controls:", "{0}\n{1}".format("{0}{1} : navigate menu\n[{2}]    : buy upgrade".format(buttonString(Button.PRIMARY_FIRE), buttonString(Button.SECONDARY_FIRE), buttonString(Button.INTERACT)), "[{2}]   : use sparkbolt\n[{0} {1} remaining]".format(eventPlayer.statsNumSparkbolts, iconString(Icon.BOLT), buttonString(Button.ULTIMATE))), HudPosition.TOP, -3, Color.GREEN, Color.GREEN, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.hudBaseProtection = getLastCreatedText()
    settleBalance()
    createEffect(eventPlayer, Effect.SPHERE, Color.WHITE, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.upgradeSphere = getLastCreatedEntity()
    createIcon(eventPlayer.upgradeCostTextVisibility, normalize(vect(eventPlayer.getFacingDirection().z * -1, 0, eventPlayer.getFacingDirection().x)) * eventPlayer.upgradeOffsetRight + (eventPlayer.playerBaseLocation - vect(0, 0.3, 0)), Icon.ARROW_LEFT, IconReeval.VISIBILITY_AND_POSITION, Color.WHITE, false)
    eventPlayer.upgradeLeftArrow = getLastCreatedEntity()
    createIcon(eventPlayer.upgradeCostTextVisibility, normalize(vect(eventPlayer.getFacingDirection().z * -1, 0, eventPlayer.getFacingDirection().x)) * eventPlayer.upgradeOffsetLeft + (eventPlayer.playerBaseLocation - vect(0, 0.3, 0)), Icon.ARROW_RIGHT, IconReeval.VISIBILITY_AND_POSITION, Color.WHITE, false)
    eventPlayer.upgradeRightArrow = getLastCreatedEntity()
    if eventPlayer.isProtected:
        goto lbl_0
    protectedBaseEffect()
    lbl_0:
    eventPlayer.isProtected = true


rule "BASE RESPAWN":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isAlive() == true
    
    if not eventPlayer.hasBase or eventPlayer.isMovingBase:
        return
    eventPlayer.statsMoney = 0
    destroyHudText(eventPlayer.hudBaseProtection)
    eventPlayer.isProtected = true
    eventPlayer.baseProtectionTimer = 0
    eventPlayer.teleport(eventPlayer.playerBaseLocation)
    eventPlayer.playerObjectInBase = eventPlayer
    eventPlayer.setInvisibility(Invis.ALL)


rule "ENEMY BASE LOOP":
    @Condition hasGameStarted == true
    @Condition gameRulesArray[0] == true
    
    tmpStealingAllPlayers = getAllPlayers()
    tmpStealingAllPlayersFiltered = [player for player in getLivingPlayers(Team.ALL) if player.playerObjectInBase == null]
    tmpStealingAllBaseOwners = [player for player in getAllPlayers() if player.hasBase + (player.statsMoneyBase != 0)]
    for stealingPlayerIterator in range(len(tmpStealingAllPlayersFiltered)):
        tmpStealingPlayer = tmpStealingAllPlayersFiltered[stealingPlayerIterator]
        if tmpStealingPlayer.playerObjectInBase == null and tmpStealingPlayer.isAlive() and tmpStealingPlayer.hasSpawned() and tmpStealingPlayer.playerObjectInBase == null and not tmpStealingPlayer.isCloaked:
            for stealingBaseOwnerIterator in range(len(tmpStealingAllBaseOwners)):
                tmpStealingBaseOwner = tmpStealingAllBaseOwners[stealingBaseOwnerIterator]
                if tmpStealingPlayer != tmpStealingBaseOwner and distance(tmpStealingPlayer.getPosition(), tmpStealingBaseOwner.playerBaseLocation) <= 3.5:
                    if not gameRulesArray[1] and tmpStealingBaseOwner.isProtected:
                        goto lbl_0
                    tmpStealingPlayer.stealingFromPlayerObject = tmpStealingBaseOwner
                    tmpStealingAllPlayers.remove(tmpStealingPlayer)
                    lbl_0:
        wait()
    for stealingPlayerIterator in range(len(tmpStealingAllPlayers)):
        tmpStealingAllPlayers[stealingPlayerIterator].stealingFromPlayerObject = null
    wait(0.64)
    goto RULE_START


rule "ENEMY BASE STEAL LOOP":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.stealingFromPlayerObject != null
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.hasSpawned() == true
    @Condition eventPlayer.stealingOnCooldown == false
    @Condition eventPlayer.stealingFromPlayerObject.statsMoneyBase != 0
    @Condition dotProduct(directionTowards(eventPlayer.getEyePosition(), eventPlayer.stealingFromPlayerObject.playerBaseLocation), eventPlayer.getFacingDirection()) >= 0.99
    @Condition distance(eventPlayer.getPosition(), eventPlayer.stealingFromPlayerObject.playerBaseLocation) < 2
    @Condition eventPlayer.isCloaked == false
    
    if eventPlayer.isStealingActive:
        goto lbl_0
    createEffect(eventPlayer, Effect.PICKUP_SOUND, Color.WHITE, eventPlayer, 2000, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.stealingSoundEffect = getLastCreatedEntity()
    eventPlayer.isStealingActive = true
    lbl_0:
    eventPlayer.tmpMoneyDifference = eventPlayer.stealingFromPlayerObject.statsMoneyBase
    if not eventPlayer.stealingFromPlayerObject.isProtected:
        goto lbl_1
    eventPlayer.tmpMoneyDifference += eventPlayer.stealingFromPlayerObject.statsMoney
    lbl_1:
    eventPlayer.tmpStealingAmount = ceil(eventPlayer.stealingFromPlayerObject.statsMoneySec / 2) + eventPlayer.statsStealingSpeed
    eventPlayer.tmpStealingRiskBonus = round(eventPlayer.statsStealingSpeed * ((stealingRiskMultiplier + stealingRiskThreshold) * (min(1, distance(eventPlayer.playerBaseLocation, eventPlayer.stealingFromPlayerObject.playerBaseLocation) / mapSize)) - stealingRiskThreshold))
    if eventPlayer.tmpStealingRiskBonus <= 0:
        goto lbl_2
    eventPlayer.tmpStealingAmount += eventPlayer.tmpStealingRiskBonus
    eventPlayer.tmpStealingAmount = min(eventPlayer.tmpStealingAmount, eventPlayer.tmpMoneyDifference)
    smallMessage(eventPlayer, "+{0} GOLD [{1} RISK BONUS]".format(eventPlayer.tmpStealingAmount, eventPlayer.tmpStealingRiskBonus))
    goto lbl_3
    lbl_2:
    eventPlayer.tmpStealingAmount = min(eventPlayer.tmpStealingAmount, eventPlayer.tmpMoneyDifference)
    smallMessage(eventPlayer, "+{0} GOLD".format(eventPlayer.tmpStealingAmount))
    lbl_3:
    eventPlayer.statsMoney += eventPlayer.tmpStealingAmount
    eventPlayer.scoreArray[2] += eventPlayer.tmpStealingAmount
    eventPlayer.scoreArray[3] += eventPlayer.tmpStealingAmount
    eventPlayer.stealingFromPlayerObject.scoreArray[8] += eventPlayer.tmpStealingAmount
    eventPlayer.stealingFromPlayerObject.statsMoneyBase -= eventPlayer.tmpStealingAmount
    if eventPlayer.stealingFromPlayerObject.isProtected and eventPlayer.stealingFromPlayerObject.statsMoneyStorage != eventPlayer.stealingFromPlayerObject.statsMoneyBase and eventPlayer.stealingFromPlayerObject.statsMoney > 0:
        eventPlayer.stealingFromPlayerObject.tmpMoneyDifference = min(eventPlayer.stealingFromPlayerObject.statsMoneyStorage - eventPlayer.stealingFromPlayerObject.statsMoneyBase, eventPlayer.stealingFromPlayerObject.statsMoney)
        eventPlayer.stealingFromPlayerObject.statsMoney -= eventPlayer.stealingFromPlayerObject.tmpMoneyDifference
        eventPlayer.stealingFromPlayerObject.statsMoneyBase += eventPlayer.stealingFromPlayerObject.tmpMoneyDifference
    playEffect(eventPlayer, DynamicEffect.EXPLOSION_SOUND, Color.WHITE, eventPlayer.stealingFromPlayerObject.playerBaseLocation, 5)
    playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.RED, eventPlayer.stealingFromPlayerObject.playerBaseLocation, 2)
    wait(0.5)
    if RULE_CONDITION:
        goto RULE_START
    eventPlayer.stealingOnCooldown = true
    destroyEffect(eventPlayer.stealingSoundEffect)
    eventPlayer.isStealingActive = false
    wait(1)
    eventPlayer.stealingOnCooldown = false


rule "ENEMY BASE ENTER":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.stealingFromPlayerObject != null
    
    eventPlayer.stealingFromPlayerObjectBackup = eventPlayer.stealingFromPlayerObject
    eventPlayer.stealingFromPlayerObject.stealingEffectsVisibleTo.append(eventPlayer)


rule "ENEMY BASE LEAVE":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.stealingFromPlayerObject == null
    
    eventPlayer.stealingFromPlayerObjectBackup.stealingEffectsVisibleTo.remove(eventPlayer)


rule "ENEMY BASE EFFECT CREATE":
    @Event eachPlayer
    @Hero all
    @Condition len(eventPlayer.stealingEffectsVisibleTo) != 0
    
    if entityExists(eventPlayer.hudStealing):
        goto lbl_0
    hudText(eventPlayer, "{0} ENEMY IN YOUR BASE! {0}".format(iconString(Icon.WARNING)), null, "              ", HudPosition.TOP, -2, Color.RED, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)
    eventPlayer.hudStealing = getLastCreatedText()
    lbl_0:
    createEffect(eventPlayer.stealingEffectsVisibleTo, Effect.SPHERE, Color.RED, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.stealingEffect = getLastCreatedEntity()
    createInWorldText(eventPlayer.stealingEffectsVisibleTo, "HOLD F TO STEAL {1} GOLD: {0}".format(eventPlayer.statsMoneyBase, iconString(Icon.SKULL)), eventPlayer.playerBaseLocation, 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.RED, SpecVisibility.NEVER)
    eventPlayer.stealingText = getLastCreatedText()


rule "ENEMY BASE EFFECT DESTROY":
    @Event eachPlayer
    @Hero all
    @Condition len(eventPlayer.stealingEffectsVisibleTo) == 0
    
    destroyEffect(eventPlayer.stealingEffect)
    destroyInWorldText(eventPlayer.stealingText)
    destroyHudText(eventPlayer.hudStealing)


/*
rule "":
*/

rule "UPGRADE BUY MONEY/SEC":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isProtected == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.upgradeCurrentSelection == 0
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.hasBase == true
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[6] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.BLUE, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection] = ceil(eventPlayer.statsUpgradeCostArray * 1.5 / 10) * 10
        eventPlayer.statsUpgradeCostArray[5] = eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]
        eventPlayer.statsMoneySec += 1
        eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection] += 1
        smallMessage(eventPlayer, "{0} +1 GOLD/SEC {0}".format(iconString(Icon.ARROW_UP)))
        checkUpgradeAvailability()
        settleBalance()
    else:
        baseUpgradeFail()


rule "UPGRADE GET MONEY/SEC":
    @Event eachPlayer
    @Hero all
    @Condition hasGameStarted == true
    @Condition eventPlayer.statsMoneySec != 0
    
    if not eventPlayer.hasBase or eventPlayer.isDead() or eventPlayer.stealingEffectsVisibleTo != [] or eventPlayer.isMovingBase or eventPlayer.isProtected:
        goto lbl_0
    eventPlayer.tmpUpgradeMoneySecDiff = eventPlayer.statsMoneyBase + eventPlayer.statsMoneySec
    eventPlayer.tmpUpgradeMoneySecDiff = eventPlayer.tmpUpgradeMoneySecDiff - eventPlayer.statsMoneyStorage if eventPlayer.tmpUpgradeMoneySecDiff > eventPlayer.statsMoneyStorage else eventPlayer.statsMoneySec
    eventPlayer.scoreArray[2] += eventPlayer.tmpMoneyDifference
    eventPlayer.statsMoneyBase += eventPlayer.tmpUpgradeMoneySecDiff
    lbl_0:
    wait(gameRulesGoldMinerFrequency)
    goto RULE_START


rule "UPGRADE BUY MONEY/KILL":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isProtected == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.upgradeCurrentSelection == 1
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.hasBase == true
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[6] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.RED, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection] = round(eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection] * 1.5 / 10) * 10
        eventPlayer.statsMoneyKill += 15
        eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection] += 1
        smallMessage(eventPlayer, "{0} +15 KILL BOUNTY {0}".format(iconString(Icon.ARROW_UP)))
        checkUpgradeAvailability()
        settleBalance()
    else:
        baseUpgradeFail()


rule "UPGRADE GET MONEY/KILL":
    @Event playerDied
    @Hero all
    @Condition hasGameStarted == true
    
    eventPlayer.scoreArray[1] += 1
    if attacker == victim:
        goto lbl_0
    smallMessage(attacker, "+ {0} PLAYER GOLD [BOUNTY]".format(attacker.statsMoneyKill))
    attacker.statsMoney += attacker.statsMoneyKill
    attacker.scoreArray[2] += attacker.statsMoneyKill
    attacker.scoreArray[0] += 1
    lbl_0:
    if victim.statsMoney <= 0:
        return
    if bountyArrayEffects[victim.getSlot()] == null:
        goto lbl_1
    destroyEffect(bountyArrayEffects[victim.getSlot()])
    bountyArrayEffects[victim.getSlot()] = null
    bountyArrayNum -= 1
    lbl_1:
    bountyArrayLocations[victim.getSlot()] = raycast(victim.getEyePosition(), victim.getEyePosition() - vect(0, 15, 0), null, null, false).getHitPosition() + vect(0, 0.35, 0)
    bountyArrayMoney[victim.getSlot()] = victim.statsMoney
    if victim.statsMoney <= 25:
        createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, bountyArrayLocations[victim.getSlot()], 1, EffectReeval.NONE)
        playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.GREEN, victim.getPosition() - vect(0, 1, 0), 0.5)
    elif victim.statsMoney > 25 and victim.statsMoney <= 250:
        createEffect(getAllPlayers(), Effect.ORB, Color.TURQUOISE, bountyArrayLocations[victim.getSlot()], 1, EffectReeval.NONE)
        playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.TURQUOISE, victim.getPosition() - vect(0, 1, 0), 0.5)
    elif victim.statsMoney > 250 and victim.statsMoney <= 750:
        createEffect(getAllPlayers(), Effect.ORB, Color.BLUE, bountyArrayLocations[victim.getSlot()], 1, EffectReeval.NONE)
        playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.BLUE, victim.getPosition() - vect(0, 1, 0), 0.5)
    else:
        createEffect(getAllPlayers(), Effect.ORB, Color.PURPLE, bountyArrayLocations[victim.getSlot()], 1, EffectReeval.NONE)
        playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.PURPLE, victim.getPosition() - vect(0, 1, 0), 0.5)
    bountyArrayEffects[victim.getSlot()] = getLastCreatedEntity()
    victim.statsMoney = 0
    bountyArrayNum += 1


rule "UPGRADE BUY STORAGE":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isProtected == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.upgradeCurrentSelection == 2
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.hasBase == true
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[6] += 1
        eventPlayer.statsMoneyBase = 0
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.YELLOW, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsMoneyStorage = min(ceil(eventPlayer.statsMoneyStorage * 1.5 / 10) * 10, gameGoldVictory)
        eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection] = eventPlayer.statsMoneyStorage
        if gameRulesArray[7]:
            goto lbl_0
        if eventPlayer.statsUpgradeHeroSwitchUsed or eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection] >= 4:
            eventPlayer.statsUpgradeHeroSwitchUsed = true
            if eventPlayer.statsUpgradeCostArray[4] != 0:
                goto lbl_1
            eventPlayer.statsUpgradeCostArray[4] = eventPlayer.statsUpgradeHeroSwitchShadowCost
            lbl_1:
            eventPlayer.statsUpgradeCostArray[4] += ceil(eventPlayer.statsMoneyStorage / 5)
        else:
            eventPlayer.statsUpgradeHeroSwitchShadowCost += ceil(eventPlayer.statsMoneyStorage / 5)
        lbl_0:
        if gameRulesArray[8]:
            goto lbl_2
        eventPlayer.statsUpgradeCostArray[3] = max(ceil(eventPlayer.statsMoneyStorage / 5), 50)
        lbl_2:
        eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection] += 1
        smallMessage(eventPlayer, "{1} +{0} GOLD CAPACITY {1}".format(ceil(eventPlayer.statsMoneyStorage / 2), iconString(Icon.ARROW_UP)))
        checkUpgradeAvailability()
        settleBalance()
        spawnBaseEffect()
    else:
        baseUpgradeFail()


rule "UPGRADE BUY MOVE BASE":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isProtected == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.upgradeCurrentSelection == 3
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.hasBase == true
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[7] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.GREEN, eventPlayer.playerBaseLocation, 2)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.playerBaseLocation = vect(0, -10000, 0)
        smallMessage(eventPlayer, "{0} PACKED UP BASE {0}".format(iconString(Icon.TRASHCAN)))
        HUDCreateNoBase()
        wait(1)
        eventPlayer.isMovingBase = true
    else:
        baseUpgradeFail()


rule "UPGRADE END MOVE BASE":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isMovingBase == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.hasBase == true
    @Condition eventPlayer.isOnGround() == true
    @Condition eventPlayer.stealingFromPlayerObject == null
    
    playerBaseCheck()
    if eventPlayer.playerBaseLocation.y > -10000:
        eventPlayer.isMovingBase = false
        playerBaseBuildEffects()
    wait(0.75)


rule "UPGRADE BUY HERO":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isProtected == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.upgradeCurrentSelection == 4
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.hasBase == true
    @Condition eventPlayer.isChangingHero == false
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.isChangingHero = true
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]
        if gameRulesArray[7]:
            goto lbl_0
        if eventPlayer.statsUpgradeHeroSwitchUsed:
            goto lbl_1
        eventPlayer.statsUpgradeCostArray[4] = eventPlayer.statsUpgradeHeroSwitchShadowCost
        lbl_1:
        eventPlayer.statsUpgradeHeroSwitchUsed = true
        lbl_0:
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.oldHeroHealth = eventPlayer.getNormalizedHealth() * 100
        eventPlayer.setFacing(vect(0, 1, 0), Relativity.TO_PLAYER)
        eventPlayer.teleport(vect(0, 10000, 0))
        eventPlayer.setGravity(abs(0))
        wait(0.25)
        eventPlayer.setAllowedHeroes(getAllHeroes().exclude(eventPlayer.getCurrentHero()))
        settleBalance()
        wait(0.25)
        eventPlayer.resetHeroAvailability()
    else:
        baseUpgradeFail()


rule "UPGRADE BUY HERO TELEPORT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned() == true
    
    if not eventPlayer.isInitialized or not eventPlayer.hasBase:
        return
    eventPlayer.teleport(eventPlayer.playerBaseLocation)
    eventPlayer.isProtected = true
    eventPlayer.playerObjectInBase = eventPlayer
    eventPlayer.baseProtectionTimer = 0
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.setGravity(100)
    eventPlayer.setStatusEffect(null, Status.FROZEN, 1)
    eventPlayer.setMaxHealth(eventPlayer.oldHeroHealth)
    wait()
    eventPlayer.setMaxHealth(100)
    eventPlayer.isChangingHero = false


rule "UPGRADE BUY STEAL SPEED":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isProtected == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.upgradeCurrentSelection == 5
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.hasBase == true
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[6] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.PURPLE, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection] = ceil(eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection] * 1.5 / 10) * 10
        if not gameRulesArray[3]:
            goto lbl_0
        eventPlayer.statsUpgradeCostArray[0] = eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]
        lbl_0:
        eventPlayer.statsStealingSpeed += 1
        eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection] += 1
        smallMessage(eventPlayer, "{0} +2 GOLD STEAL/SEC  {0}".format(iconString(Icon.ARROW_UP)))
        checkUpgradeAvailability()
        settleBalance()
    else:
        baseUpgradeFail()


rule "UPGRADE BUY DELAY":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isProtected == true
    @Condition eventPlayer.isHoldingButton(Button.INTERACT) == true
    @Condition eventPlayer.upgradeCurrentSelection == 6
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.hasBase == true
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[6] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.SKY_BLUE, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsBaseDelay -= 0.5
        if eventPlayer.statsBaseDelay <= 0.5:
            eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection] += 10000
        else:
            eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection] *= 2
        eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection] += 1
        smallMessage(eventPlayer, "{0} -0.5 SEC DELAY {0}".format(iconString(Icon.ARROW_UP)))
        checkUpgradeAvailability()
        settleBalance()
    else:
        baseUpgradeFail()


rule "UPGRADE BUY SPARKBOLT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isProtected == true
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition eventPlayer.statsNumSparkbolts != 0
    @Condition eventPlayer.baseSparkboltCooldown == false
    
    eventPlayer.baseSparkboltCooldown = true
    eventPlayer.tmpBaseSparkboltTarget = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 10, getAllPlayers(), eventPlayer, true).getPlayerHit()
    if entityExists(eventPlayer.tmpBaseSparkboltTarget):
        if distance(eventPlayer.playerBaseLocation, eventPlayer.tmpBaseSparkboltTarget.getPosition()) < 8:
            eventPlayer.statsNumSparkbolts -= 1
            smallMessage(eventPlayer, "-1 {0}".format(iconString(Icon.BOLT)))
            eventPlayer.tmpBaseSparkboltTarget.setStatusEffect(eventPlayer, Status.HACKED, 2.5)
            eventPlayer.tmpBaseSparkboltTarget.setStatusEffect(eventPlayer, Status.STUNNED, 0.5)
            damage(eventPlayer.tmpBaseSparkboltTarget, eventPlayer.tmpBaseSparkboltTarget, 100)
            createBeam(getAllPlayers(), Beam.BAD, eventPlayer.playerBaseLocation + vect(0, 3.5, 0), eventPlayer.tmpBaseSparkboltTarget.getEyePosition(), Color.SKY_BLUE, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
            eventPlayer.sparkboltEffect = getLastCreatedEntity()
            playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, Color.WHITE, eventPlayer.playerBaseLocation, 200)
            playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.SKY_BLUE, eventPlayer.playerBaseLocation + vect(0, 3.5, 0), 1)
            playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.SKY_BLUE, eventPlayer.tmpBaseSparkboltTarget.getEyePosition(), 1)
            wait(0.64)
            destroyEffect(eventPlayer.sparkboltEffect)
        else:
            smallMessage(eventPlayer, "TOO FAR AWAY")
    else:
        smallMessage(eventPlayer, "AIM AT ENEMY")
    wait(0.5)
    eventPlayer.baseSparkboltCooldown = false


rule "UPGRADE SELECT LEFT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.upgradeInputCooldown == false
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.isProtected == true
    
    playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 20)
    eventPlayer.upgradeInputCooldown = true
    eventPlayer.tmpUpgradeCurrentSelection = eventPlayer.upgradeCurrentSelection - 1
    while true:
        if eventPlayer.tmpUpgradeCurrentSelection >= 0:
            goto lbl_0
        eventPlayer.tmpUpgradeCurrentSelection = len(eventPlayer.statsUpgradeCostArray) - 1
        lbl_0:
        if eventPlayer.statsUpgradeCostArray[eventPlayer.tmpUpgradeCurrentSelection] <= gameGoldVictory:
            goto lbl_1
        eventPlayer.tmpUpgradeCurrentSelection -= 1
    lbl_1:
    eventPlayer.upgradeCurrentSelection = eventPlayer.tmpUpgradeCurrentSelection
    eventPlayer.upgradeTextUpdated = true
    eventPlayer.upgradeOffsetRight = -1
    wait(0.25)
    eventPlayer.upgradeOffsetRight = -0.9
    wait(0.25)
    eventPlayer.upgradeInputCooldown = false


rule "UPGRADE SELECT RIGHT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.upgradeInputCooldown == false
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition eventPlayer.isProtected == true
    
    playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 20)
    eventPlayer.upgradeInputCooldown = true
    eventPlayer.tmpUpgradeCurrentSelection = (eventPlayer.upgradeCurrentSelection + 1) % len(eventPlayer.statsUpgradeCostArray)
    while true:
        if eventPlayer.statsUpgradeCostArray[eventPlayer.tmpUpgradeCurrentSelection] <= gameGoldVictory:
            goto lbl_0
        eventPlayer.tmpUpgradeCurrentSelection = (eventPlayer.tmpUpgradeCurrentSelection + 1) % len(eventPlayer.statsUpgradeCostArray)
    lbl_0:
    eventPlayer.upgradeCurrentSelection = eventPlayer.tmpUpgradeCurrentSelection
    eventPlayer.upgradeTextUpdated = true
    eventPlayer.upgradeOffsetLeft = 1
    wait(0.25)
    eventPlayer.upgradeOffsetLeft = 0.9
    wait(0.25)
    eventPlayer.upgradeInputCooldown = false


rule "UPGRADE SHOW MENU":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isProtected == true
    @Condition eventPlayer.upgradeCostTextVisibility == null
    #@Condition dotProduct(directionTowards(eventPlayer.getEyePosition(), eventPlayer.playerBaseLocation), eventPlayer.getFacingDirection()) >= 0.99
    @Condition distance(vect(0, 0, 0), eventPlayer.playerBaseLocation - (eventPlayer.getEyePosition() + ((abs(dotProduct(eventPlayer.playerBaseLocation - eventPlayer.getEyePosition(), eventPlayer.getFacingDirection()))) * eventPlayer.getFacingDirection()))) <= baseUpgradeSphereActualSize
    
    eventPlayer.upgradeInputCooldown = true
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    eventPlayer.upgradeCostTextVisibility = eventPlayer
    eventPlayer.upgradeTextUpdated = true
    wait(0.25)
    if eventPlayer.upgradeCostTextVisibility == null:
        goto lbl_0
    eventPlayer.upgradeInputCooldown = false
    lbl_0:


rule "UPGRADE HIDE MENU":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.upgradeCostTextVisibility != null
    #@Condition (dotProduct(directionTowards(eventPlayer.getEyePosition(), eventPlayer.playerBaseLocation), eventPlayer.getFacingDirection()) < 0.99 or not eventPlayer.isProtected) == true
    @Condition distance(vect(0, 0, 0), eventPlayer.playerBaseLocation - (eventPlayer.getEyePosition() + ((abs(dotProduct(eventPlayer.playerBaseLocation - eventPlayer.getEyePosition(), eventPlayer.getFacingDirection()))) * eventPlayer.getFacingDirection()))) > baseUpgradeSphereActualSize
    
    eventPlayer.upgradeCostTextVisibility = null
    destroyInWorldText(eventPlayer.upgradeTextTitle)
    eventPlayer.upgradeTextTitle = null
    destroyInWorldText(eventPlayer.upgradeTextDescription)
    eventPlayer.upgradeTextDescription = null


rule "UPGRADE UPDATE TEXT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.upgradeTextUpdated == true
    @Condition eventPlayer.isProtected == true
    @Condition eventPlayer.upgradeCostTextVisibility != null
    
    eventPlayer.upgradeTextUpdated = false
    destroyInWorldText(eventPlayer.upgradeTextTitle)
    destroyInWorldText(eventPlayer.upgradeTextDescription)
    destroyEffect(eventPlayer.upgradeSphere)
    if eventPlayer.upgradeCurrentSelection == 0:
        createInWorldText(eventPlayer, "             {0}\nAUTO GOLD MINER\n\n\n\n".format(iconString(Icon.DIAMOND)), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.BLUE, SpecVisibility.DEFAULT)
        eventPlayer.upgradeTextTitle = getLastCreatedText()
        createInWorldText(eventPlayer, "    [LVL {0}]\n\n  Upgrades your gold generation\n    to {1} per second. Can't generate\nwhen there are players in your base\n ".format(eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], eventPlayer.statsMoneySec + 1), eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(eventPlayer, Effect.SPHERE, Color.BLUE, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    elif eventPlayer.upgradeCurrentSelection == 1:
        createInWorldText(eventPlayer, "             {0}\nKILL GOLD BOUNTY\n\n\n\n".format(iconString(Icon.SKULL)), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.RED, SpecVisibility.DEFAULT)
        eventPlayer.upgradeTextTitle = getLastCreatedText()
        createInWorldText(eventPlayer, "     [LVL {0}]\n\n    Increases bounty from {2} to {1}\nAwarded by dealing finishing blow\n  Doesn't affect dropped loot orbs\n ".format(eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], eventPlayer.statsMoneyKill + 15, eventPlayer.statsMoneyKill), eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(eventPlayer, Effect.SPHERE, Color.RED, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    elif eventPlayer.upgradeCurrentSelection == 2:
        createInWorldText(eventPlayer, "               {0}\nBASE GOLD STORAGE\n\n\n\n".format(iconString(Icon.CIRCLE)), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.YELLOW, SpecVisibility.DEFAULT)
        eventPlayer.upgradeTextTitle = getLastCreatedText()
        createInWorldText(eventPlayer, "[LVL {0}]\n\nIncreases the maximum amount \n  of gold your base can store.\n  Upgraded storage: {1} gold\n ".format(eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], ceil(eventPlayer.statsMoneyStorage * 1.5)), eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(eventPlayer, Effect.SPHERE, Color.YELLOW, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    elif eventPlayer.upgradeCurrentSelection == 3:
        createInWorldText(eventPlayer, "            {0}\nMOVE YOUR BASE\n\n\n\n".format(iconString(Icon.TRASHCAN)), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.GREEN, SpecVisibility.DEFAULT)
        eventPlayer.upgradeTextTitle = getLastCreatedText()
        createInWorldText(eventPlayer, "   [NO LVL]\n \n           Packs up your base. \nYou keep your gold & upgrades. \nPrice depends on gold storage.\n ", eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(eventPlayer, Effect.SPHERE, Color.GREEN, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    elif eventPlayer.upgradeCurrentSelection == 4:
        createInWorldText(eventPlayer, "              {0}\nSWITCH YOUR HERO\n\n\n\n".format(iconString(Icon.RECYCLE)), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.TURQUOISE, SpecVisibility.DEFAULT)
        eventPlayer.upgradeTextTitle = getLastCreatedText()
        createInWorldText(eventPlayer, " [NO LVL]\n \n     Takes you to hero selection.\n  Bug: If only one hero shows up\nWait 5 seconds until they appear.\n ", eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(eventPlayer, Effect.SPHERE, Color.TURQUOISE, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    elif eventPlayer.upgradeCurrentSelection == 5:
        createInWorldText(eventPlayer, "            {0}\nGOLD STEAL SPEED\n\n\n\n".format(iconString(Icon.STOP)), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.PURPLE, SpecVisibility.DEFAULT)
        eventPlayer.upgradeTextTitle = getLastCreatedText()
        createInWorldText(eventPlayer, "     [LVL {0}]\n \n    Steal +2 gold/sec from bases.\nSame upgrade price as gold miner.\n  Total {1} + enemy gold miner/sec.\n ".format(eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], (eventPlayer.statsStealingSpeed + 1) * 2), eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(eventPlayer, Effect.SPHERE, Color.PURPLE, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    elif eventPlayer.upgradeCurrentSelection == 6:
        createInWorldText(eventPlayer, "           {0}\nBASE ENTRY TIME\n\n\n\n".format(iconString(Icon.WARNING)), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.AQUA, SpecVisibility.DEFAULT)
        eventPlayer.upgradeTextTitle = getLastCreatedText()
        createInWorldText(eventPlayer, "  [LVL {0}]\n \n      Reduces the time it takes\nto enter your base by 0.5 sec.\n    The current delay is {1} sec.\n ".format(eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], eventPlayer.statsBaseDelay), eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(eventPlayer, Effect.SPHERE, Color.AQUA, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.upgradeSphere = getLastCreatedEntity()
    eventPlayer.upgradeTextDescription = getLastCreatedText()


/*
rule "":
*/

rule "LOOT UPDATE PLAYERS ADD":
    @Event eachPlayer
    @Hero all
    @Condition hasGameStarted == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isProtected == false
    @Condition eventPlayer.hasSpawned() == true
    @Condition (gameRulesArray[5] or not eventPlayer.isCloaked) == true
    
    if eventPlayer in lootPossiblePlayers:
        return
    lootPossiblePlayers.append(eventPlayer)


rule "LOOT UPDATE PLAYERS REMOVE":
    @Event eachPlayer
    @Hero all
    @Condition hasGameStarted == true
    @Condition (any([eventPlayer.isDead(), eventPlayer.isProtected, not eventPlayer.hasSpawned(), not gameRulesArray[5] and eventPlayer.isCloaked])) == true
    
    lootPossiblePlayers.remove(eventPlayer)


rule "LOOT BOUNTY COLLECT LOOP":
    @Condition bountyArrayNum != 0
    
    for bountyArrayIterator in range(len(bountyArrayLocations)):
        if bountyArrayEffects[bountyArrayIterator] != null:
            tmpBountyLocation = bountyArrayLocations[bountyArrayIterator]
            tmpBountyClosestPlayer = sorted(lootPossiblePlayers, lambda player: distance(player.getPosition(), tmpBountyLocation))[0]
            if entityExists(tmpBountyClosestPlayer) and distance(tmpBountyClosestPlayer.getPosition(), tmpBountyLocation) <= 2.5:
                tmpBountyClosestPlayer.statsMoney += bountyArrayMoney[bountyArrayIterator]
                tmpBountyClosestPlayer.scoreArray[2] += bountyArrayMoney[bountyArrayIterator]
                tmpBountyClosestPlayer.scoreArray[5] += 1
                destroyEffect(bountyArrayEffects[bountyArrayIterator])
                bountyArrayNum -= 1
                bountyArrayEffects[bountyArrayIterator] = null
                playEffect(tmpBountyClosestPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, tmpBountyLocation, 50)
                smallMessage(tmpBountyClosestPlayer, "+{0} PLAYER GOLD [LOOT]".format(bountyArrayMoney[bountyArrayIterator]))
                if bountyArrayMoney[bountyArrayIterator] <= 25:
                    playEffect(tmpBountyClosestPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.GREEN, tmpBountyLocation, 1)
                elif bountyArrayMoney[bountyArrayIterator] > 25 and bountyArrayMoney[bountyArrayIterator] <= 250:
                    playEffect(tmpBountyClosestPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.TURQUOISE, tmpBountyLocation, 1)
                elif bountyArrayMoney[bountyArrayIterator] > 250 and bountyArrayMoney[bountyArrayIterator] <= 750:
                    playEffect(tmpBountyClosestPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.BLUE, tmpBountyLocation, 1)
                else:
                    playEffect(tmpBountyClosestPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.PURPLE, tmpBountyLocation, 1)
            wait()
    wait(0.1)
    if RULE_CONDITION:
        goto RULE_START


rule "LOOT FIND SPAWNPOINTS":
    @Condition hasGameStarted == true
    
    while lootSpawnpointIterator <= 200 and len(tmpLootSpawnpointProximity) < 128:
        tmpLootSpawnpointRandomPointWP = mapOrigin + mapRotationVector * random.uniform(0, mapXYZ.x) + vect(mapRotationVector.z, 0, mapRotationVector.x * -1) * random.uniform(0, mapXYZ.z) + vect(0, random.uniform(0, mapXYZ.y), 0)
        tmpLootSpawnpoint = nearestWalkablePosition(tmpLootSpawnpointRandomPointWP) + vect(0, 0.35, 0)
        if tmpLootSpawnpoint == 0 or lootBlockerVolumePos != 0 and distance(tmpLootSpawnpoint, lootBlockerVolumePos) <= lootBlockerVolumeRadius or distance(tmpLootSpawnpoint, tmpLootSpawnpointRandomPointWP) > 5:
            goto lbl_0
        tmpLootSpawnpointProximity = sorted([player for player in lootSpawnPoints if player != null], lambda i: distance(tmpLootSpawnpoint, i))
        if distance(tmpLootSpawnpoint, tmpLootSpawnpointProximity[0]) < lootSpread and len(tmpLootSpawnpointProximity) != 0:
            goto lbl_1
        goto lbl_2
        lbl_1:
        lootSpawnpointIterator += 1
        lbl_0:
        wait(0.001)
        goto RULE_START
        lbl_2:
        lootSpawnPoints.append(tmpLootSpawnpoint)
        lootSpawnpointIterator = 0
        wait(0.001)
    lootSpawnpointIterator = 0
    lootSpawnMax = min(lootSpawnMax, len(lootSpawnPoints))
    lootArrayLocations[lootSpawnMax - 1] = null
    lootArrayLocationsStored[lootSpawnMax - 1] = 0
    tmpLootSpawnpointProximity = null


rule "LOOT LOOT EFFECTS":
    @Condition hasGameStarted == true
    @Condition lootArrayLocations != []
    @Condition gameRulesArray[4] == true
    
    for lootCollectIterator in range(len(lootArrayLocations)):
        lootArrayLocations[lootCollectIterator] = vect(0, -9999, 0)
    #This is ugly, but this way loot effects stay persistent
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[0], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 1:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[1], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 2:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[2], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 3:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[3], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 4:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[4], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 5:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[5], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 6:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[6], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 7:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[7], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 8:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[8], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 9:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[9], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 10:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[10], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 11:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[11], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 12:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[12], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 13:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[13], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 14:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[14], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    if lootSpawnMax == 15:
        return
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, lootArrayLocations[15], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)


rule "LOOT SPAWN":
    @Condition hasGameStarted == true
    @Condition len(lootArrayLocations) != 0
    @Condition lootSpawnerNumLoot < lootSpawnMax
    @Condition gameRulesArray[4] == true
    @Condition gameEnded == false
    
    if not lootArraySpawned[lootSpawnerEffectIterator]:
        goto lbl_0
    lootSpawnerEffectIterator += 1
    if lootSpawnerEffectIterator < len(lootArrayLocations):
        goto lbl_1
    lootSpawnerEffectIterator = 0
    lbl_1:
    wait()
    goto RULE_START
    lbl_0:
    while true:
        tmpLootSpawnpointRandomPoint = normalize(vect(random.uniform(-1, 1), random.uniform(-1, 1), random.uniform(-1, 1))) * random.uniform(2, 10) + lootSpawnPoints[lootSpawnerIterator]
        tmpLootSpawnpointRandomPointWP = nearestWalkablePosition(tmpLootSpawnpointRandomPoint)
        if distance(tmpLootSpawnpointRandomPointWP, tmpLootSpawnpointRandomPoint) >= 1.5:
            goto lbl_2
        tmpLootSpawnpointRandomPointWP = raycast(tmpLootSpawnpointRandomPointWP + vect(0, 2, 0), tmpLootSpawnpointRandomPointWP - vect(0, 10, 0), null, null, false).getHitPosition() + vect(0, 0.35, 0)
        if distance(tmpLootSpawnpointRandomPointWP, nearestWalkablePosition(tmpLootSpawnpointRandomPointWP)) <= 0.1 and (lootBlockerVolumePos == null or lootBlockerVolumePos != null and distance(tmpLootSpawnpointRandomPointWP, lootBlockerVolumePos) > lootBlockerVolumeRadius):
            goto lbl_3
        lbl_2:
        wait(0.064)
    lbl_3:
    lootArrayLocations[lootSpawnerEffectIterator] = tmpLootSpawnpointRandomPointWP
    lootArraySpawned[lootSpawnerEffectIterator] = true
    lootSpawnerIterator += 1
    lootSpawnerNumLoot += 1
    if lootSpawnerIterator < len(lootSpawnPoints):
        goto lbl_4
    lootSpawnerIterator = 0
    lbl_4:
    wait(1.12)
    if RULE_CONDITION:
        goto RULE_START


rule "LOOT COLLECT LOOP":
    @Condition hasGameStarted == true
    @Condition gameRulesArray[4] == true
    
    for lootCollectIterator in range(len(lootArrayLocations)):
        if lootArraySpawned[lootCollectIterator]:
            tmpLootCollectClosestPlayer = sorted(lootPossiblePlayers, lambda player: distance(player.getPosition(), lootArrayLocations[lootCollectIterator]))[0]
            if entityExists(tmpLootCollectClosestPlayer) and distance(tmpLootCollectClosestPlayer, lootArrayLocations[lootCollectIterator]) <= 2.5:
                lootArrayLocationsStored[lootCollectIterator] = lootArrayLocations[lootCollectIterator]
                lootSpawnerNumLoot -= 1
                playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.GREEN, lootArrayLocationsStored[lootCollectIterator], 1)
                playEffect(tmpLootCollectClosestPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, lootArrayLocationsStored[lootCollectIterator], 50)
                lootArrayLocations[lootCollectIterator] = vect(0, -9999, 0)
                lootArraySpawned[lootCollectIterator] = false
                tmpLootCollectClosestPlayer.statsMoney += gameLootOrbAmount
                tmpLootCollectClosestPlayer.scoreArray[2] += gameLootOrbAmount
                tmpLootCollectClosestPlayer.scoreArray[5] += 1
                smallMessage(tmpLootCollectClosestPlayer, "+{0} PLAYER GOLD [LOOT]".format(gameLootOrbAmount))
        wait()
    wait(0.1)
    goto RULE_START


rule "LOOT LOSS1":
    @Event playerDied
    @Hero all
    @Condition attacker == victim
    @Condition hasGameStarted == true
    
    eventPlayer.statsMoney = 0


rule "LOOT LOSS2":
    @Event playerDied
    @Hero all
    @Condition hasGameStarted == true
    
    destroyHudText(eventPlayer.hudBaseProtection)


rule "LOOT POWERUP COLLECT LOOP":
    @Condition sparkboltPickupPos != null
    @Condition gameRulesArray[2] == true
    
    tmpSparkboltClosestPlayer = sorted(lootPossiblePlayers, lambda player: distance(player.getPosition(), sparkboltPickupPos))[0]
    if entityExists(tmpSparkboltClosestPlayer) and distance(tmpSparkboltClosestPlayer.getPosition(), sparkboltPickupPos) <= 2.5:
        tmpSparkboltClosestPlayer.statsNumSparkbolts += 1
        smallMessage(tmpSparkboltClosestPlayer, "+1 {0} SPARKBOLT".format(iconString(Icon.BOLT)))
        destroyEffect(sparkboltEffects[0])
        destroyEffect(sparkboltEffects[1])
        playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.WHITE, sparkboltPickupPos, 1)
        playEffect(tmpSparkboltClosestPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, sparkboltPickupPos, 50)
        sparkboltPickupPos = null
        sparkboltSpawnpointIndex = (sparkboltSpawnpointIndex + 1) % len(lootSpawnPoints)
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START


rule "LOOT POWERUP SPAWN":
    @Condition hasGameStarted == true
    @Condition sparkboltPickupPos == null
    @Condition gameRulesArray[2] == true
    
    wait(60 - getNumberOfPlayers(Team.ALL))
    while true:
        tmpPowerupSpawnpointRandomPoint = normalize(vect(random.uniform(-1, 1), random.uniform(-1, 1), random.uniform(-1, 1))) * random.uniform(2, 10) + lootSpawnPoints[sparkboltSpawnpointIndex]
        tmpPowerupSpawnpointRandomPointW = nearestWalkablePosition(tmpPowerupSpawnpointRandomPoint)
        if distance(tmpPowerupSpawnpointRandomPointW, tmpPowerupSpawnpointRandomPoint) >= 1.5:
            goto lbl_0
        tmpPowerupSpawnpointRandomPointW = raycast(tmpPowerupSpawnpointRandomPointW + vect(0, 2, 0), tmpPowerupSpawnpointRandomPointW - vect(0, 10, 0), null, null, false).getHitPosition() + vect(0, 0.35, 0)
        if distance(tmpPowerupSpawnpointRandomPointW, nearestWalkablePosition(tmpPowerupSpawnpointRandomPointW)) <= 0.1:
            goto lbl_1
        lbl_0:
        wait(0.064)
    lbl_1:
    sparkboltPickupPos = tmpPowerupSpawnpointRandomPointW
    createEffect(getAllPlayers(), Effect.SPARKLES, Color.WHITE, sparkboltPickupPos, 0.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    sparkboltEffects[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, sparkboltPickupPos.getPosition() + vect(0, getTotalTimeElapsed() % 0.2 / 3, 0), getTotalTimeElapsed() % 0.3 / 3 + 0.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    sparkboltEffects[1] = getLastCreatedEntity()


def settleBalance():
    @Name "SUB SETTLE BALANCE"
    
    if eventPlayer.statsMoneyStorage != eventPlayer.statsMoneyBase and eventPlayer.statsMoney > 0:
        eventPlayer.tmpMoneyDifference = min(eventPlayer.statsMoneyStorage - eventPlayer.statsMoneyBase, eventPlayer.statsMoney)
        eventPlayer.statsMoney -= eventPlayer.tmpMoneyDifference
        eventPlayer.statsMoneyBase += eventPlayer.tmpMoneyDifference
        smallMessage(eventPlayer, "STORED {0} GOLD IN BASE".format(eventPlayer.tmpMoneyDifference))


def HUDCreateNoBase():
    @Name "SUB CREATE HUD NO BASE"
    
    hudHeader(eventPlayer, "{0} NO BASE BUILT {0}\n  PRESS [{1}] TO BUILD".format(iconString(Icon.WARNING), buttonString(Button.INTERACT)), HudPosition.TOP, -4, Color.RED, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.hudBuildingBase = getLastCreatedText()


def playerBaseCheck():
    @Name "SUB BASE BUILD CHECK"
    
    if distance(eventPlayer.getPosition(), getAllPlayers()[eventPlayer.playerBaseProximityIterator].playerBaseLocation) < 14:
        goto lbl_0
    eventPlayer.playerBaseProximityIterator += 1
    if eventPlayer.playerBaseProximityIterator < len(getAllPlayers()):
        goto RULE_START
    eventPlayer.playerBaseProximityIterator = 0
    if distance(raycast(eventPlayer.getEyePosition(), eventPlayer.getPosition() + ((directionTowards(eventPlayer.getEyePosition(), eventPlayer.getPosition() + vect(2, 0, 0))) * 40), [], [], false).getHitPosition(), eventPlayer.getPosition() + vect(2, 0, 0)) > 0.6:
        goto lbl_1
    if distance(raycast(eventPlayer.getEyePosition(), eventPlayer.getPosition() + ((directionTowards(eventPlayer.getEyePosition(), eventPlayer.getPosition() + vect(-2, 0, 0))) * 40), [], [], false).getHitPosition(), eventPlayer.getPosition() + vect(-2, 0, 0)) > 0.6:
        goto lbl_2
    if distance(raycast(eventPlayer.getEyePosition(), eventPlayer.getPosition() + ((directionTowards(eventPlayer.getEyePosition(), eventPlayer.getPosition() + vect(0, 0, 2))) * 40), [], [], false).getHitPosition(), eventPlayer.getPosition() + vect(0, 0, 2)) > 0.6:
        goto lbl_3
    if distance(raycast(eventPlayer.getEyePosition(), eventPlayer.getPosition() + ((directionTowards(eventPlayer.getEyePosition(), eventPlayer.getPosition() + vect(0, 0, -2))) * 40), [], [], false).getHitPosition(), eventPlayer.getPosition() + vect(0, 0, -2)) > 0.6:
        goto lbl_4
    if eventPlayer.hasStatusEffect(Status.INVINCIBLE) or distance(eventPlayer.getPosition(), nearestWalkablePosition(eventPlayer.getPosition())) > 8:
        goto lbl_5
    eventPlayer.playerBaseLocation = eventPlayer.getPosition()
    return
    lbl_1:
    lbl_2:
    lbl_3:
    lbl_4:
    lbl_5:
    smallMessage(eventPlayer, "{0} BAD BASE LOCATION {0}".format(iconString(Icon.STOP)))
    return
    lbl_0:
    smallMessage(eventPlayer, "{0} ENEMY BASE TOO CLOSE {0}".format(iconString(Icon.STOP)))
    eventPlayer.playerBaseProximityIterator = 0


def playerBaseBuildEffects():
    @Name "SUB BASE BUILD EFFECTS"
    
    destroyHudText(eventPlayer.hudBuildingBase)
    playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.YELLOW, eventPlayer, 10000)
    playEffect(eventPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.WHITE, eventPlayer.getPosition() + eventPlayer.getFacingDirection() * 1, 30)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.WHITE, eventPlayer.playerBaseLocation + vect(0, 0.5, 0), 7.5)


def baseUpgradeFail():
    @Name "SUB UPGRADE FAIL"
    
    playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 20)
    smallMessage(eventPlayer, "{0} NOT ENOUGH GOLD IN BASE {0}".format(iconString(Icon.NO)))


def spawnBaseEffect():
    @Name "SUB SPAWN BASE EFFECT"
    
    if not entityExists(eventPlayer.baseEffectOrb):
        goto lbl_0
    destroyEffect(eventPlayer.baseEffectOrb)
    lbl_0:
    if not entityExists(eventPlayer.baseEffectRing):
        goto lbl_1
    destroyEffect(eventPlayer.baseEffectRing)
    lbl_1:
    if eventPlayer.statsUpgradeLevels[2] < 4:
        createEffect([player for player in getAllPlayers() if player != eventPlayer.playerObjectInBase], Effect.SPHERE, Color.WHITE, eventPlayer.playerBaseLocation, 3.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.baseEffectOrb = getLastCreatedEntity()
        createEffect(eventPlayer.playerObjectInBase, Effect.RING, Color.WHITE, eventPlayer.playerBaseLocation, 3.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    elif eventPlayer.statsUpgradeLevels[2] >= 4 and eventPlayer.statsUpgradeLevels[2] < 7:
        createEffect([player for player in getAllPlayers() if player != eventPlayer.playerObjectInBase], Effect.SPHERE, Color.AQUA, eventPlayer.playerBaseLocation, 3.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.baseEffectOrb = getLastCreatedEntity()
        createEffect(eventPlayer.playerObjectInBase, Effect.RING, Color.AQUA, eventPlayer.playerBaseLocation, 3.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    elif eventPlayer.statsUpgradeLevels[2] == 7:
        createEffect([player for player in getAllPlayers() if player != eventPlayer.playerObjectInBase], Effect.SPHERE, Color.BLUE, eventPlayer.playerBaseLocation, 3.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.baseEffectOrb = getLastCreatedEntity()
        createEffect(eventPlayer.playerObjectInBase, Effect.RING, Color.BLUE, eventPlayer.playerBaseLocation, 3.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    elif eventPlayer.statsUpgradeLevels[2] == 8:
        createEffect([player for player in getAllPlayers() if player != eventPlayer.playerObjectInBase], Effect.SPHERE, Color.PURPLE, eventPlayer.playerBaseLocation, 3.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.baseEffectOrb = getLastCreatedEntity()
        createEffect(eventPlayer.playerObjectInBase, Effect.RING, Color.PURPLE, eventPlayer.playerBaseLocation, 3.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    else:
        createEffect([player for player in getAllPlayers() if player != eventPlayer.playerObjectInBase], Effect.SPHERE, Color.RED, eventPlayer.playerBaseLocation, 3.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.baseEffectOrb = getLastCreatedEntity()
        createEffect(eventPlayer.playerObjectInBase, Effect.RING, Color.RED, eventPlayer.playerBaseLocation, 3.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.baseEffectRing = getLastCreatedEntity()


def protectedBaseEffect():
    @Name "SUB PROTECTED BASE EFFECT"
    
    if eventPlayer.statsUpgradeLevels[2] < 4:
        playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.WHITE, eventPlayer.getPosition(), 4)
    elif eventPlayer.statsUpgradeLevels[2] >= 4 and eventPlayer.statsUpgradeLevels[2] < 7:
        playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.TURQUOISE, eventPlayer.getPosition(), 4)
    elif eventPlayer.statsUpgradeLevels[2] == 7:
        playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.BLUE, eventPlayer.getPosition(), 4)
    elif eventPlayer.statsUpgradeLevels[2] == 8:
        playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.PURPLE, eventPlayer.getPosition(), 4)
    else:
        playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.RED, eventPlayer.getPosition(), 4)


def checkUpgradeAvailability():
    @Name "SUB SKIP TO AVAILABLE UPGRADE AFTER PURCHASE"
    
    if eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection] > gameGoldVictory:
        eventPlayer.upgradeInputCooldown = true
        while eventPlayer.statsUpgradeCostArray[eventPlayer.upgradeCurrentSelection] > gameGoldVictory:
            if eventPlayer.upgradeCurrentSelection < len(eventPlayer.statsUpgradeCostArray) - 1:
                goto lbl_0
            eventPlayer.upgradeCurrentSelection = 0
            goto lbl_1
            lbl_0:
            eventPlayer.upgradeCurrentSelection += 1
            lbl_1:
        eventPlayer.upgradeTextUpdated = true
        wait(0.25)
        eventPlayer.upgradeInputCooldown = false


rule "GAME ENDED LATE JOIN":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned() == true
    @Condition gameEnded == true
    
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


rule "Rule 94":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.debugFreecam != null
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    
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


