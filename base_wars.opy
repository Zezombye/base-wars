
#!define DEBUG_MODE true

#!define VERSION "1.6"
#!define CREATION_DATE "21/11/2020"
#!define BASE_RADIUS 3.5

enum Upgrade:
    GOLD_MINER,
    KILL_BOUNTY,
    GOLD_STORAGE,
    BASE_MOVE,
    SWITCH_HERO,
    STEAL_SPEED,
    ENTRY_TIME,

#Global variables

globalvar powerLevelColors = [Color.WHITE, Color.AQUA, Color.BLUE, Color.PURPLE, Color.RED, Color.ROSE, Color.BLACK]

globalvar lootArrayLocations
globalvar isGameInitialized
globalvar hasGameStarted
globalvar lootSpawnPoints
globalvar lootArrayLocationsStored
globalvar lootSpread
globalvar lootCollectIterator
globalvar lootArraySpawned
globalvar lootSpawnpointIterator
globalvar lootSpawnerIterator
globalvar lootSpawnerNumLoot
globalvar lootSpawnerEffectIterator
#globalvar gameRulesCurrentSelection
#globalvar gameRulesArray
#globalvar gameRulesHost
globalvar tmpLootSpawnpointRandomPointWP
globalvar tmpLootCollectClosestPlayer
globalvar tmpLootSpawnpoint
globalvar tmpLootSpawnpointProximity
globalvar gameRulesGoldMinerInitialCost
globalvar debugDummyBot
globalvar mapNavMesh
globalvar leaderboard
globalvar mapOrigin
globalvar mapXYZ
globalvar mapRotationVector
globalvar gameRulesSelectionMarkerArray
globalvar mapInfo
globalvar debugMapRot
globalvar bountyArrayLocations
globalvar bountyArrayEffects
globalvar bountyArrayMoney
globalvar bountyArrayNum
globalvar bountyArrayIterator
globalvar tmpBountyClosestPlayer
globalvar tmpBountyLocation
globalvar stealingPlayerIterator
globalvar tmpStealingBaseOwner
globalvar tmpStealingAllPlayers
globalvar tmpStealingPlayer
globalvar tmpStealingAllPlayersFiltered
globalvar tmpStealingAllBaseOwners
globalvar stealingBaseOwnerIterator
globalvar gameHealingHeroes
globalvar tmpPlayerLeftBaseIterator
globalvar tmpPlayerLeftIterator
#globalvar disconnectedPlayers
globalvar mapSize
globalvar stealingRiskThreshold
globalvar stealingRiskMultiplier
globalvar leaderboardMaxScore
globalvar sparkboltSpawnpointIndex
globalvar sparkboltPickupPos
globalvar tmpSparkboltClosestPlayer
globalvar sparkboltEffects
globalvar tmpLootSpawnpointRandomPoint
globalvar lootBlockerVolumePos
globalvar tmpPowerupSpawnpointRandomPoint
globalvar tmpPowerupSpawnpointRandomPointW
globalvar lootBlockerVolumeRadius
globalvar gameRulesMoveBaseInitialCost
globalvar gameRulesGoldMinerFrequency
globalvar gameRulesVisibleTo
globalvar gameRulesArraySaved
#globalvar gameRulesCustomized
globalvar gameEnded
globalvar gameWinner
globalvar gameEndingScreenPos
globalvar gameLootOrbAmount
globalvar gameScorePositions
globalvar lootPossiblePlayers
globalvar gameScoreTopPlayers
globalvar gameScoreTopPlayersValues
globalvar baseUpgradeSphereActualSize
globalvar tmpBaseOwners


#settings
#!define SETTINGS_TITLE "BASE WARS BY DURKHAZ#2629\nCONCEPT: PYROCREEP#2665\nTHANKS: CUDDLYFLOWER#2892, HuKuTa94#2589, Kevin#26140\nRemaster: Zezombye#2627"
globalvar enableStealing = createWorkshopSetting(bool, SETTINGS_TITLE, "Enable Stealing", true, 0)
globalvar enableOccupiedStealing = createWorkshopSetting(bool, SETTINGS_TITLE, "Enable stealing from occupied bases", true, 1)
globalvar enableSparkbolts = createWorkshopSetting(bool, SETTINGS_TITLE, "Spawn sparkbolts", true, 2)
globalvar enableGoldMinerUpgrade = createWorkshopSetting(bool, SETTINGS_TITLE, "Players can upgrade gold miner", true, 3)
globalvar enableLootOrbs = createWorkshopSetting(bool, SETTINGS_TITLE, "Spawn loot orbs", true, 4)
globalvar lootOrbsGold = createWorkshopSetting(int[10:40], SETTINGS_TITLE, "Gold given by loot orbs", 25, 5)
globalvar enableInvisibleLootPickup = createWorkshopSetting(bool, SETTINGS_TITLE, "Sombra can pick up orbs while invisible", false, 6)
globalvar gameGoldVictory = createWorkshopSetting(int[1000:10000], SETTINGS_TITLE, "Amount of gold to win", 2500, 7)
globalvar enableAlwaysFreeHeroSwitch = createWorkshopSetting(bool, SETTINGS_TITLE, "Hero switch is always free", false, 8)
globalvar enableAlwaysFreeBaseMove = createWorkshopSetting(bool, SETTINGS_TITLE, "Base move is always free", false, 9)
globalvar enableInefficientGoldMiner = createWorkshopSetting(bool, SETTINGS_TITLE, "Make gold miner less efficient", false, 10)
globalvar lootSpawnMax = createWorkshopSetting(int[5:16], SETTINGS_TITLE, "Maximum number of loot orbs", 16, 11)


#Player variables

playervar powerLevel

playervar statsMoney
playervar hasBase
playervar statsUpgradeCost
playervar statsMoneyStorage
playervar tmpUpgradeCurrentSelection
playervar canAutoHeal
playervar regenStartTime
playervar isStealingActive
playervar playerBaseProximityIterator
playervar statsStealingSpeed
playervar debugWalkablePosition
playervar playerBaseLocation
playervar statsMoneyBase
playervar debugWalkablePositionEffect
playervar debugEffectCountIterator
playervar debugFreecam
playervar tmpUpgradeMoneySecDiff
playervar debugEffectCountArray
playervar baseProtectionTimer
playervar isMovingBase
playervar hudBaseProtection
playervar hudStealing
playervar hudBuildingBase
playervar baseEffectOrb
playervar tmpMoneyDifference
playervar statsMoneySec
playervar playerObjectInBase
playervar statsMoneyKill
playervar isProtected
playervar isChangingHero
playervar oldHeroHealth
playervar isInitialized
playervar upgradeLeftArrow
playervar upgradeRightArrow
playervar upgradeCurrentSelection
playervar upgradeInputCooldown
playervar upgradeTextTitle
playervar upgradeTextUpdated
playervar upgradeSphere
playervar upgradeCostTextVisibility
playervar regenID
playervar upgradeOffsetLeft
playervar upgradeOffsetRight
playervar isInFriendlyZone
playervar isCloaked
playervar stealingFrom
playervar stealingSoundEffect
playervar stealingText
playervar tmpStealingAmount
playervar stealingOnCooldown
playervar stealingEffect
playervar stealingEffectsVisibleTo
playervar stealingFromBackup
playervar upgradeTextDescription
playervar statsUpgradeLevels
playervar hudGoldBase
playervar baseEffectRing
playervar statsUpgradeHeroSwitchUsed
playervar statsUpgradeHeroSwitchShadowCost
playervar tmpStealingRiskBonus
playervar statsBaseDelay
playervar baseSparkboltCooldown
playervar tmpBaseSparkboltTarget
playervar statsNumSparkbolts
playervar sparkboltEffect
playervar scoreArray


#Subroutine names

subroutine settleBalance
subroutine hudCreateNoBase
subroutine setBaseLocation
subroutine playerBaseBuildEffects
subroutine baseUpgradeFail
subroutine spawnBaseEffect
subroutine checkUpgradeAvailability
subroutine protectedBaseEffect
subroutine gameStart
subroutine gameEndedScreenPos

#!include "settings.opy"
#!include "debug.opy"
#!include "game_end.opy"
#!include "loot.opy"


rule "init":
    @Condition isGameInProgress()
    
    setMatchTime(819)
    disableGamemodeCompletion()
    disableAnnouncer()
    disableScoring()

    #disconnectedPlayers = []
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

    if not enableGoldMinerUpgrade:
        gameRulesGoldMinerInitialCost = 100000

    gameRulesMoveBaseInitialCost = 50
    if enableAlwaysFreeBaseMove:
        gameRulesMoveBaseInitialCost = 0

    gameRulesGoldMinerFrequency = 1
    if enableInefficientGoldMiner:
        gameRulesGoldMinerFrequency = 2

    lootSpawnMax = 16
    leaderboardMaxScore = gameGoldVictory * 2
    gameHealingHeroes = ((((([i for i in getAllHeroes() if not i in getSupportHeroes()]).concat(Hero.ZENYATTA.concat(Hero.ANA).concat(Hero.BRIGITTE))).exclude(Hero.BASTION)).exclude(Hero.MEI)).exclude(Hero.ROADHOG)).exclude(Hero.SOLDIER)
    bigMessage(getAllPlayers(), "GAME STARTED")
    hasGameStarted = true
    wait(1)
    pauseMatchTime()


rule "GAME INIT MAP":
    @Condition isGameInProgress()
    
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


rule "skip assembling heroes":
    @Condition isAssemblingHeroes()
    setMatchTime(0)


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
    @Condition eventWasHealthPack
    
    eventPlayer.setStatusEffect(null, Status.HACKED, 5)
    eventPlayer.setMoveSpeed(75)
    wait(5)
    eventPlayer.setMoveSpeed(100)


rule "init player":
    @Event eachPlayer
    @Hero all
    @Condition hasGameStarted
    @Condition gameEnded == false
    
    eventPlayer.hasBase = false
    eventPlayer.isMovingBase = false
    eventPlayer.statsMoneySec = 0
    eventPlayer.statsMoney = 10000
    eventPlayer.statsMoneyStorage = 100
    eventPlayer.upgradeCurrentSelection = 2
    eventPlayer.statsUpgradeCost = [gameRulesGoldMinerInitialCost, 25, eventPlayer.statsMoneyStorage, gameRulesMoveBaseInitialCost, 0, 30, 80]
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

    eventPlayer.upgradeInputCooldown = false
    eventPlayer.upgradeOffsetLeft = 0.9
    eventPlayer.upgradeOffsetRight = eventPlayer.upgradeOffsetLeft * -1

    eventPlayer.disableGamemodeHud()
    eventPlayer.disableScoreboard()
    eventPlayer.scoreArray[4] = getTotalTimeElapsed()


rule "PLAYER HUD NOT STARTED":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned()
    @Condition isGameInProgress() == false
    
    hudHeader(eventPlayer, "WAITING FOR HOST ({0}) TO START THE GAME".format(hostPlayer), HudPosition.TOP, 3, Color.RED, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "unsupported map":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned()
    @Condition hasGameStarted == false
    @Condition mapInfo == null
    @Condition isGameInProgress()
    
    hudHeader(eventPlayer, "The map {0} IS NOT SUPPORTED".format(getCurrentMap()), HudPosition.TOP, 3, Color.RED, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "waiting for navmesh to generate":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned()
    @Condition hasGameStarted == false
    @Condition isGameInitialized == false
    @Condition mapInfo != null
    
    hudHeader(eventPlayer, "Building the navmesh, please wait", HudPosition.TOP, 3, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "init player hud":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.isInitialized == false
    @Condition hasGameStarted
    
    wait(0.25)
    eventPlayer.isInitialized = true
    
    destroyHudText(eventPlayer.hudGoldBase)
    hudText(eventPlayer, iconString(Icon.CIRCLE), "GOLD IN BASE", "{0}/{1} (+{2}/sec)".format(eventPlayer.statsMoneyBase, eventPlayer.statsMoneyStorage, eventPlayer.statsMoneySec), HudPosition.LEFT, 0, Color.ORANGE, Color.ORANGE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.hudGoldBase = getLastCreatedText()
    hudText(eventPlayer, iconString(Icon.POISON), "GOLD ON PLAYER", eventPlayer.statsMoney, HudPosition.LEFT, 1, Color.ORANGE, Color.ORANGE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    if eventPlayer.hasBase:
        goto lbl_0
    hudCreateNoBase()
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


rule "display scoreboard":
    @Condition hasGameStarted
    
    wait()

    #title + 1st player
    hudText(getAllPlayers(), null, 
        "                                       discord.gg/YP544CH\nScoreboard    -    Base Wars "VERSION" "CREATION_DATE, 
        "FIRST TO {0} GOLD IN BASE WINS!\n \n{1}".format(gameGoldVictory, 
            " · {0}% {1} {2} ".format(floor(((leaderboard[0].statsMoneyBase + leaderboard[0].statsMoneyStorage) / leaderboardMaxScore) * 100), heroIcon(leaderboard[0].getCurrentHero()), leaderboard[0])
        ),
        HudPosition.RIGHT, 1, Color.WHITE, Color.ORANGE, powerLevelColors[leaderboard[0].powerLevel], HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.ALWAYS)
    
    #2nd player
    hudSubtext(getAllPlayers(), " · {0}% {1} {2} ".format(floor(((leaderboard[1].statsMoneyBase + leaderboard[1].statsMoneyStorage) / leaderboardMaxScore) * 100), heroIcon(leaderboard[1].getCurrentHero()), leaderboard[1]), HudPosition.RIGHT, 2, powerLevelColors[leaderboard[1].powerLevel], HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.ALWAYS)

    #3rd player
    hudSubtext(getAllPlayers(), " · {0}% {1} {2} ".format(floor(((leaderboard[2].statsMoneyBase + leaderboard[2].statsMoneyStorage) / leaderboardMaxScore) * 100), heroIcon(leaderboard[2].getCurrentHero()), leaderboard[2]), HudPosition.RIGHT, 2, powerLevelColors[leaderboard[2].powerLevel], HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.ALWAYS)

    #if gameRulesCustomized:
        #hudText(gameRulesVisibleTo, null, "Lobby Mods: {0}{1}{2}".format("{0}{1}{2}".format("{0}{1}{2}".format(["No Stealing, ", ""][enableStealing], ["Steal from empty base only, ", ""][enableOccupiedStealing], ["No Sparkbolt, ", ""][enableSparkbolts]), ["No Goldminer, ", ""][enableGoldMinerUpgrade], ["No Loot, ", ""][enableLootOrbs]), "{0}{1}{2}".format(["No Sombra Invis loot, ", ""][enableInvisibleLootPickup], ["", "5000 gold victory, "][enableAlwaysFreeHeroSwitch], ["", "Free Heroswitch, "][enableAlwaysFreeHeroSwitch]), "{0}{1}{2}".format(["", "Free Basemove, "][enableAlwaysFreeBaseMove], ["", "Slower Goldminer, "][enableInefficientGoldMiner], "")), "{0} + {1} to hide mods".format(buttonString(Button.CROUCH), buttonString(Button.MELEE)), HudPosition.LEFT, -1, Color.ORANGE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)



rule "update leaderboard":
    @Condition hasGameStarted
    
    while true:
        leaderboard = sorted([player for player in getAllPlayers() if player.statsMoneyBase + player.statsMoneyStorage > 0], lambda i: -(i.statsMoneyBase + i.statsMoneyStorage * 10))
        wait(1)


rule "PLAYER REGEN CONDITION":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned()
    
    eventPlayer.canAutoHeal = false
    if not eventPlayer.getCurrentHero() in gameHealingHeroes:
        return
    eventPlayer.canAutoHeal = true


rule "PLAYER REGEN TAKE DAMAGE":
    @Event playerTookDamage
    @Hero all
    @Condition eventPlayer.canAutoHeal
    
    eventPlayer.regenStartTime = getTotalTimeElapsed() + 5
    stopHoT(eventPlayer.regenID)
    eventPlayer.regenID = null


rule "PLAYER REGEN START":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.canAutoHeal
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
    @Condition hasGameStarted
    @Condition eventPlayer.getCurrentHero() == Hero.SOMBRA
    @Condition eventPlayer.isUsingAbility1()
    
    eventPlayer.isCloaked = true


rule "PLAYER SOMBRA CLOAK OFF":
    @Event eachPlayer
    @Hero all
    @Condition hasGameStarted
    @Condition eventPlayer.getCurrentHero() != Hero.SOMBRA or eventPlayer.isUsingAbility1() == false
    
    eventPlayer.isCloaked = false


rule "BASE BUILD CHECK CONDITION":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasBase == false
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.playerBaseLocation.y == -1000
    @Condition eventPlayer.isOnGround()
    @Condition hasGameStarted
    @Condition eventPlayer.stealingFrom == null
    
    setBaseLocation()
    wait(0.75)


rule "BASE BUILD":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasBase == false
    @Condition eventPlayer.playerBaseLocation.y != -1000
    @Condition hasGameStarted
    
    eventPlayer.hasBase = true
    spawnBaseEffect()
    #createIcon(eventPlayer, eventPlayer.playerBaseLocation + vect(0, 2.8, 0), Icon.HALO, IconReeval.POSITION, Color.WHITE, false)
    createInWorldText([player for player in getAllPlayers() if player != eventPlayer], "{1} {0} {2}".format(eventPlayer, heroIcon(eventPlayer.getCurrentHero()), eventPlayer.statsMoneyBase), eventPlayer.playerBaseLocation + vect(0, 2, 0), 0.8, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    createInWorldText(eventPlayer, "{0} YOUR BASE".format(heroIcon(eventPlayer.getCurrentHero())), eventPlayer.playerBaseLocation + vect(0, 2.5, 0), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.NEVER)
    createInWorldText(eventPlayer.upgradeCostTextVisibility, " \n \n \n \n \n{0} GOLD".format(eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
    playerBaseBuildEffects()


rule "BASE ENTER":
    @Event eachPlayer
    @Hero all
    @Condition hasGameStarted
    @Condition eventPlayer.playerObjectInBase == null
    @Condition eventPlayer.hasBase
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
    @Condition (eventPlayer.isCloaked or eventPlayer.hasStatusEffect(Status.ASLEEP) or eventPlayer.hasStatusEffect(Status.FROZEN) or eventPlayer.hasStatusEffect(Status.UNKILLABLE) or eventPlayer.hasStatusEffect(Status.INVINCIBLE) or eventPlayer.hasStatusEffect(Status.PHASED_OUT) or eventPlayer.isUsingUltimate())
    
    stopChasingVariable(eventPlayer.baseProtectionTimer)
    destroyHudText(eventPlayer.hudBaseProtection)
    eventPlayer.playerObjectInBase = null


rule "BASE EXIT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.playerObjectInBase != null
    @Condition hasGameStarted
    @Condition eventPlayer.hasBase
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
    @Condition eventPlayer.isAlive()
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
    @Condition eventPlayer.isAlive()
    
    if not eventPlayer.hasBase or eventPlayer.isMovingBase:
        return
    eventPlayer.statsMoney = 0
    destroyHudText(eventPlayer.hudBaseProtection)
    eventPlayer.isProtected = true
    eventPlayer.baseProtectionTimer = 0
    eventPlayer.teleport(eventPlayer.playerBaseLocation)
    eventPlayer.playerObjectInBase = eventPlayer
    eventPlayer.setInvisibility(Invis.ALL)

rule "check if player is in someone else's base":
    @Event eachPlayer
    @Condition hasGameStarted
    @Condition enableStealing
    while true:
        if eventPlayer.isAlive() and eventPlayer.hasSpawned() and eventPlayer.stealingFrom == null and not eventPlayer.isCloaked and eventPlayer.playerObjectInBase:
            tmpBaseOwners = [player for player in getAllPlayers() if player != eventPlayer and player.hasBase and player.statsMoneyBase != 0 and not (player.isProtected and not enableOccupiedStealing)]
            for stealingBaseOwnerIterator in range(len(tmpBaseOwners)):
                if distance(eventPlayer.getPosition(), tmpBaseOwners[stealingBaseOwnerIterator]) <= BASE_RADIUS:
                    eventPlayer.stealingFrom = tmpBaseOwners[stealingBaseOwnerIterator]
                    break
        
        wait(0.64)
        
/*
rule "ENEMY BASE LOOP":
    @Condition hasGameStarted
    @Condition enableStealing
    
    tmpStealingAllPlayers = getAllPlayers()
    tmpStealingAllPlayersFiltered = [player for player in getLivingPlayers(Team.ALL) if player.playerObjectInBase == null]
    tmpStealingAllBaseOwners = [player for player in getAllPlayers() if player.hasBase + (player.statsMoneyBase != 0)]
    for stealingPlayerIterator in range(len(tmpStealingAllPlayersFiltered)):
        tmpStealingPlayer = tmpStealingAllPlayersFiltered[stealingPlayerIterator]
        if tmpStealingPlayer.playerObjectInBase == null and tmpStealingPlayer.isAlive() and tmpStealingPlayer.hasSpawned() and tmpStealingPlayer.playerObjectInBase == null and not tmpStealingPlayer.isCloaked:
            for stealingBaseOwnerIterator in range(len(tmpStealingAllBaseOwners)):
                tmpStealingBaseOwner = tmpStealingAllBaseOwners[stealingBaseOwnerIterator]
                if tmpStealingPlayer != tmpStealingBaseOwner and distance(tmpStealingPlayer.getPosition(), tmpStealingBaseOwner.playerBaseLocation) <= 3.5:
                    if not enableOccupiedStealing and tmpStealingBaseOwner.isProtected:
                        goto lbl_0
                    tmpStealingPlayer.stealingFrom = tmpStealingBaseOwner
                    tmpStealingAllPlayers.remove(tmpStealingPlayer)
                    lbl_0:
        wait()
    for stealingPlayerIterator in range(len(tmpStealingAllPlayers)):
        tmpStealingAllPlayers[stealingPlayerIterator].stealingFrom = null
    wait(0.64)
    goto RULE_START
*/

rule "ENEMY BASE STEAL LOOP":
    @Event eachPlayer
    @Hero all
    @Condition enableStealing
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.stealingFrom != null
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.stealingOnCooldown == false
    @Condition eventPlayer.isCloaked == false
    @Condition eventPlayer.stealingFrom.statsMoneyBase != 0
    @Condition dotProduct(directionTowards(eventPlayer.getEyePosition(), eventPlayer.stealingFrom.playerBaseLocation), eventPlayer.getFacingDirection()) >= 0.99
    @Condition distance(eventPlayer.getPosition(), eventPlayer.stealingFrom.playerBaseLocation) < 2
    
    do:
        if not eventPlayer.isStealingActive:
            createEffect(eventPlayer, Effect.PICKUP_SOUND, Color.WHITE, eventPlayer, 2000, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
            eventPlayer.stealingSoundEffect = getLastCreatedEntity()
            eventPlayer.isStealingActive = true

        eventPlayer.tmpMoneyDifference = eventPlayer.stealingFrom.statsMoneyBase
        if eventPlayer.stealingFrom.isProtected:
            eventPlayer.tmpMoneyDifference += eventPlayer.stealingFrom.statsMoney

        eventPlayer.tmpStealingAmount = ceil(eventPlayer.stealingFrom.statsMoneySec / 2) + eventPlayer.statsStealingSpeed
        eventPlayer.tmpStealingRiskBonus = round(eventPlayer.statsStealingSpeed * ((stealingRiskMultiplier + stealingRiskThreshold) * (min(1, distance(eventPlayer.playerBaseLocation, eventPlayer.stealingFrom.playerBaseLocation) / mapSize)) - stealingRiskThreshold))
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
        eventPlayer.stealingFrom.scoreArray[8] += eventPlayer.tmpStealingAmount
        eventPlayer.stealingFrom.statsMoneyBase -= eventPlayer.tmpStealingAmount
        if eventPlayer.stealingFrom.isProtected and eventPlayer.stealingFrom.statsMoneyStorage != eventPlayer.stealingFrom.statsMoneyBase and eventPlayer.stealingFrom.statsMoney > 0:
            eventPlayer.stealingFrom.tmpMoneyDifference = min(eventPlayer.stealingFrom.statsMoneyStorage - eventPlayer.stealingFrom.statsMoneyBase, eventPlayer.stealingFrom.statsMoney)
            eventPlayer.stealingFrom.statsMoney -= eventPlayer.stealingFrom.tmpMoneyDifference
            eventPlayer.stealingFrom.statsMoneyBase += eventPlayer.stealingFrom.tmpMoneyDifference
        playEffect(eventPlayer, DynamicEffect.EXPLOSION_SOUND, Color.WHITE, eventPlayer.stealingFrom.playerBaseLocation, 5)
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.RED, eventPlayer.stealingFrom.playerBaseLocation, 2)
        wait(0.5)
    while RULE_CONDITION

    eventPlayer.stealingOnCooldown = true
    destroyEffect(eventPlayer.stealingSoundEffect)
    eventPlayer.isStealingActive = false
    wait(1)
    eventPlayer.stealingOnCooldown = false

/*
rule "ENEMY BASE ENTER":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.stealingFrom != null
    
    eventPlayer.stealingFromBackup = eventPlayer.stealingFrom
    eventPlayer.stealingFrom.stealingEffectsVisibleTo.append(eventPlayer)


rule "check if player is not in someone else's base anymore":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.stealingFrom != null
    @Condition distance(eventPlayer.getPosition(), tmpBaseOwners[stealingBaseOwnerIterator]) <= BASE_RADIUS:
    
    eventPlayer.stealingFromBackup.stealingEffectsVisibleTo.remove(eventPlayer)
*/

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


rule "UPGRADE BUY MONEY/SEC":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isProtected
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.upgradeCurrentSelection == 0
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.hasBase
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[6] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.BLUE, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] = ceil(eventPlayer.statsUpgradeCost * 1.5 / 10) * 10
        eventPlayer.statsUpgradeCost[5] = eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
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
    @Condition hasGameStarted
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
    @Condition eventPlayer.isProtected
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.upgradeCurrentSelection == 1
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.hasBase
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[6] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.RED, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] = round(eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] * 1.5 / 10) * 10
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
    @Condition hasGameStarted
    
    eventPlayer.scoreArray[1] += 1
    if attacker != victim:
        smallMessage(attacker, "+ {0} PLAYER GOLD [BOUNTY]".format(attacker.statsMoneyKill))
        attacker.statsMoney += attacker.statsMoneyKill
        attacker.scoreArray[2] += attacker.statsMoneyKill
        attacker.scoreArray[0] += 1

    if victim.statsMoney <= 0:
        return
    if bountyArrayEffects[victim.getSlot()] != null:
        destroyEffect(bountyArrayEffects[victim.getSlot()])
        bountyArrayEffects[victim.getSlot()] = null
        bountyArrayNum -= 1
        
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
    @Condition eventPlayer.isProtected
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.upgradeCurrentSelection == 2
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.hasBase
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[6] += 1
        eventPlayer.statsMoneyBase = 0
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.YELLOW, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsMoneyStorage = min(ceil(eventPlayer.statsMoneyStorage * 1.5 / 10) * 10, gameGoldVictory)
        eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] = eventPlayer.statsMoneyStorage
        if enableAlwaysFreeHeroSwitch:
            goto lbl_0
        if eventPlayer.statsUpgradeHeroSwitchUsed or eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection] >= 4:
            eventPlayer.statsUpgradeHeroSwitchUsed = true
            if eventPlayer.statsUpgradeCost[4] != 0:
                goto lbl_1
            eventPlayer.statsUpgradeCost[4] = eventPlayer.statsUpgradeHeroSwitchShadowCost
            lbl_1:
            eventPlayer.statsUpgradeCost[4] += ceil(eventPlayer.statsMoneyStorage / 5)
        else:
            eventPlayer.statsUpgradeHeroSwitchShadowCost += ceil(eventPlayer.statsMoneyStorage / 5)
        lbl_0:
        if enableAlwaysFreeBaseMove:
            goto lbl_2
        eventPlayer.statsUpgradeCost[3] = max(ceil(eventPlayer.statsMoneyStorage / 5), 50)
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
    @Condition eventPlayer.isProtected
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.upgradeCurrentSelection == 3
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.hasBase
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[7] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.GREEN, eventPlayer.playerBaseLocation, 2)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.playerBaseLocation = vect(0, -10000, 0)
        smallMessage(eventPlayer, "{0} PACKED UP BASE {0}".format(iconString(Icon.TRASHCAN)))
        hudCreateNoBase()
        wait(1)
        eventPlayer.isMovingBase = true
    else:
        baseUpgradeFail()


rule "UPGRADE END MOVE BASE":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isMovingBase
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.hasBase
    @Condition eventPlayer.isOnGround()
    @Condition eventPlayer.stealingFrom == null
    
    setBaseLocation()
    if eventPlayer.playerBaseLocation.y > -10000:
        eventPlayer.isMovingBase = false
        playerBaseBuildEffects()
    wait(0.75)


rule "UPGRADE BUY HERO":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isProtected
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.upgradeCurrentSelection == 4
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.hasBase
    @Condition eventPlayer.isChangingHero == false
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.isChangingHero = true
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
        if enableAlwaysFreeHeroSwitch:
            goto lbl_0
        if eventPlayer.statsUpgradeHeroSwitchUsed:
            goto lbl_1
        eventPlayer.statsUpgradeCost[4] = eventPlayer.statsUpgradeHeroSwitchShadowCost
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
    @Condition eventPlayer.hasSpawned()
    
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
    @Condition eventPlayer.isProtected
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.upgradeCurrentSelection == 5
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.hasBase
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[6] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.PURPLE, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] = ceil(eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] * 1.5 / 10) * 10
        if not enableGoldMinerUpgrade:
            goto lbl_0
        eventPlayer.statsUpgradeCost[0] = eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
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
    @Condition eventPlayer.isProtected
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.upgradeCurrentSelection == 6
    @Condition eventPlayer.upgradeCostTextVisibility != null
    @Condition eventPlayer.hasBase
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[6] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.SKY_BLUE, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsBaseDelay -= 0.5
        if eventPlayer.statsBaseDelay <= 0.5:
            eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] += 10000
        else:
            eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] *= 2
        eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection] += 1
        smallMessage(eventPlayer, "{0} -0.5 SEC DELAY {0}".format(iconString(Icon.ARROW_UP)))
        checkUpgradeAvailability()
        settleBalance()
    else:
        baseUpgradeFail()


rule "UPGRADE BUY SPARKBOLT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isProtected
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
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
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    @Condition eventPlayer.isProtected
    
    playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 20)
    eventPlayer.upgradeInputCooldown = true
    eventPlayer.tmpUpgradeCurrentSelection = eventPlayer.upgradeCurrentSelection - 1
    while true:
        if eventPlayer.tmpUpgradeCurrentSelection >= 0:
            goto lbl_0
        eventPlayer.tmpUpgradeCurrentSelection = len(eventPlayer.statsUpgradeCost) - 1
        lbl_0:
        if eventPlayer.statsUpgradeCost[eventPlayer.tmpUpgradeCurrentSelection] <= gameGoldVictory:
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
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    @Condition eventPlayer.isProtected
    
    playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 20)
    eventPlayer.upgradeInputCooldown = true
    eventPlayer.tmpUpgradeCurrentSelection = (eventPlayer.upgradeCurrentSelection + 1) % len(eventPlayer.statsUpgradeCost)
    while true:
        if eventPlayer.statsUpgradeCost[eventPlayer.tmpUpgradeCurrentSelection] <= gameGoldVictory:
            goto lbl_0
        eventPlayer.tmpUpgradeCurrentSelection = (eventPlayer.tmpUpgradeCurrentSelection + 1) % len(eventPlayer.statsUpgradeCost)
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
    @Condition eventPlayer.isProtected
    @Condition eventPlayer.upgradeCostTextVisibility == null
    #@Condition dotProduct(directionTowards(eventPlayer.getEyePosition(), eventPlayer.playerBaseLocation), eventPlayer.getFacingDirection()) >= 0.99
    @Condition distance(vect(0, 0, 0), eventPlayer.playerBaseLocation - (eventPlayer.getEyePosition() + ((abs(dotProduct(eventPlayer.playerBaseLocation - eventPlayer.getEyePosition(), eventPlayer.getFacingDirection()))) * eventPlayer.getFacingDirection()))) <= baseUpgradeSphereActualSize
    
    eventPlayer.upgradeInputCooldown = true
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    eventPlayer.upgradeCostTextVisibility = eventPlayer
    eventPlayer.upgradeTextUpdated = true
    wait(0.25)
    if eventPlayer.upgradeCostTextVisibility != null:
        eventPlayer.upgradeInputCooldown = false


rule "UPGRADE HIDE MENU":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.upgradeCostTextVisibility != null
    #@Condition (dotProduct(directionTowards(eventPlayer.getEyePosition(), eventPlayer.playerBaseLocation), eventPlayer.getFacingDirection()) < 0.99 or not eventPlayer.isProtected)
    @Condition distance(vect(0, 0, 0), eventPlayer.playerBaseLocation - (eventPlayer.getEyePosition() + ((abs(dotProduct(eventPlayer.playerBaseLocation - eventPlayer.getEyePosition(), eventPlayer.getFacingDirection()))) * eventPlayer.getFacingDirection()))) > baseUpgradeSphereActualSize
    
    eventPlayer.upgradeCostTextVisibility = null
    destroyInWorldText(eventPlayer.upgradeTextTitle)
    eventPlayer.upgradeTextTitle = null
    destroyInWorldText(eventPlayer.upgradeTextDescription)
    eventPlayer.upgradeTextDescription = null


rule "UPGRADE UPDATE TEXT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.upgradeTextUpdated
    @Condition eventPlayer.isProtected
    @Condition eventPlayer.upgradeCostTextVisibility != null
    
    eventPlayer.upgradeTextUpdated = false
    destroyInWorldText(eventPlayer.upgradeTextTitle)
    destroyInWorldText(eventPlayer.upgradeTextDescription)
    destroyEffect(eventPlayer.upgradeSphere)
    if eventPlayer.upgradeCurrentSelection == Upgrade.GOLD_MINER:
        createInWorldText(eventPlayer, "             {0}\nAUTO GOLD MINER\n\n\n\n".format(iconString(Icon.DIAMOND)), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.BLUE, SpecVisibility.DEFAULT)
        eventPlayer.upgradeTextTitle = getLastCreatedText()
        createInWorldText(eventPlayer, "    [LVL {0}]\n\n  Upgrades your gold generation\n    to {1} per second. Can't generate\nwhen there are players in your base\n ".format(eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], eventPlayer.statsMoneySec + 1), eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(eventPlayer, Effect.SPHERE, Color.BLUE, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

    elif eventPlayer.upgradeCurrentSelection == Upgrade.KILL_BOUNTY:
        createInWorldText(eventPlayer, "             {0}\nKILL GOLD BOUNTY\n\n\n\n".format(iconString(Icon.SKULL)), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.RED, SpecVisibility.DEFAULT)
        eventPlayer.upgradeTextTitle = getLastCreatedText()
        createInWorldText(eventPlayer, "     [LVL {0}]\n\n    Increases bounty from {2} to {1}\nAwarded by dealing finishing blow\n  Doesn't affect dropped loot orbs\n ".format(eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], eventPlayer.statsMoneyKill + 15, eventPlayer.statsMoneyKill), eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(eventPlayer, Effect.SPHERE, Color.RED, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

    elif eventPlayer.upgradeCurrentSelection == Upgrade.GOLD_STORAGE:
        createInWorldText(eventPlayer, "               {0}\nBASE GOLD STORAGE\n\n\n\n".format(iconString(Icon.CIRCLE)), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.YELLOW, SpecVisibility.DEFAULT)
        eventPlayer.upgradeTextTitle = getLastCreatedText()
        createInWorldText(eventPlayer, "[LVL {0}]\n\nIncreases the maximum amount \n  of gold your base can store.\n  Upgraded storage: {1} gold\n ".format(eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], ceil(eventPlayer.statsMoneyStorage * 1.5)), eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(eventPlayer, Effect.SPHERE, Color.YELLOW, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

    elif eventPlayer.upgradeCurrentSelection == Upgrade.BASE_MOVE:
        createInWorldText(eventPlayer, "            {0}\nMOVE YOUR BASE\n\n\n\n".format(iconString(Icon.TRASHCAN)), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.GREEN, SpecVisibility.DEFAULT)
        eventPlayer.upgradeTextTitle = getLastCreatedText()
        createInWorldText(eventPlayer, "   [NO LVL]\n \n           Packs up your base. \nYou keep your gold & upgrades. \nPrice depends on gold storage.\n ", eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(eventPlayer, Effect.SPHERE, Color.GREEN, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

    elif eventPlayer.upgradeCurrentSelection == Upgrade.SWITCH_HERO:
        createInWorldText(eventPlayer, "              {0}\nSWITCH YOUR HERO\n\n\n\n".format(iconString(Icon.RECYCLE)), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.TURQUOISE, SpecVisibility.DEFAULT)
        eventPlayer.upgradeTextTitle = getLastCreatedText()
        createInWorldText(eventPlayer, " [NO LVL]\n \n     Takes you to hero selection.\n  Bug: If only one hero shows up\nWait 5 seconds until they appear.\n ", eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(eventPlayer, Effect.SPHERE, Color.TURQUOISE, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

    elif eventPlayer.upgradeCurrentSelection == Upgrade.STEAL_SPEED:
        createInWorldText(eventPlayer, "            {0}\nGOLD STEAL SPEED\n\n\n\n".format(iconString(Icon.STOP)), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.PURPLE, SpecVisibility.DEFAULT)
        eventPlayer.upgradeTextTitle = getLastCreatedText()
        createInWorldText(eventPlayer, "     [LVL {0}]\n \n    Steal +2 gold/sec from bases.\nSame upgrade price as gold miner.\n  Total {1} + enemy gold miner/sec.\n ".format(eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], (eventPlayer.statsStealingSpeed + 1) * 2), eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(eventPlayer, Effect.SPHERE, Color.PURPLE, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

    elif eventPlayer.upgradeCurrentSelection == Upgrade.ENTRY_TIME:
        createInWorldText(eventPlayer, "           {0}\nBASE ENTRY TIME\n\n\n\n".format(iconString(Icon.WARNING)), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.AQUA, SpecVisibility.DEFAULT)
        eventPlayer.upgradeTextTitle = getLastCreatedText()
        createInWorldText(eventPlayer, "  [LVL {0}]\n \n      Reduces the time it takes\nto enter your base by 0.5 sec.\n    The current delay is {1} sec.\n ".format(eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], eventPlayer.statsBaseDelay), eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
        createEffect(eventPlayer, Effect.SPHERE, Color.AQUA, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

    eventPlayer.upgradeSphere = getLastCreatedEntity()
    eventPlayer.upgradeTextDescription = getLastCreatedText()


def settleBalance():
    @Name "SUB SETTLE BALANCE"
    
    if eventPlayer.statsMoneyStorage != eventPlayer.statsMoneyBase and eventPlayer.statsMoney > 0:
        eventPlayer.tmpMoneyDifference = min(eventPlayer.statsMoneyStorage - eventPlayer.statsMoneyBase, eventPlayer.statsMoney)
        eventPlayer.statsMoney -= eventPlayer.tmpMoneyDifference
        eventPlayer.statsMoneyBase += eventPlayer.tmpMoneyDifference
        smallMessage(eventPlayer, "STORED {0} GOLD IN BASE".format(eventPlayer.tmpMoneyDifference))


def hudCreateNoBase():
    @Name "SUB CREATE HUD NO BASE"
    
    hudHeader(eventPlayer, "{0} NO BASE BUILT {0}\n  PRESS [{1}] TO BUILD".format(iconString(Icon.WARNING), buttonString(Button.INTERACT)), HudPosition.TOP, -4, Color.RED, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.hudBuildingBase = getLastCreatedText()


def setBaseLocation():
    @Name "place player base if location is good"
    
    if distance(eventPlayer.getPosition(), getAllPlayers()[eventPlayer.playerBaseProximityIterator].playerBaseLocation) < 14:
        smallMessage(eventPlayer, "{0} ENEMY BASE TOO CLOSE {0}".format(iconString(Icon.STOP)))
        eventPlayer.playerBaseProximityIterator = 0
        return

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
    
    if entityExists(eventPlayer.baseEffectOrb):
        destroyEffect(eventPlayer.baseEffectOrb)

    if entityExists(eventPlayer.baseEffectRing):
        destroyEffect(eventPlayer.baseEffectRing)

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
    
    if eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] > gameGoldVictory:
        eventPlayer.upgradeInputCooldown = true
        while eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] > gameGoldVictory:
            if eventPlayer.upgradeCurrentSelection < len(eventPlayer.statsUpgradeCost) - 1:
                goto lbl_0
            eventPlayer.upgradeCurrentSelection = 0
            goto lbl_1
            lbl_0:
            eventPlayer.upgradeCurrentSelection += 1
            lbl_1:
        eventPlayer.upgradeTextUpdated = true
        wait(0.25)
        eventPlayer.upgradeInputCooldown = false

