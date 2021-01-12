
#!define DEBUG_MODE true

#!define VERSION "2.0"
#!define CREATION_DATE "08/12/2020"
#!define GAMEMODE_CODE "14WON"

#!define i18n() __script__("i18n.js")
i18n()
globalvar practiceRangeTranslations = [p"Practice Range", p"Campo de Treinamento"]
#globalvar practiceRangeTranslations = [p"Campo de Treinamento", p"Practice Range"]

#!define BASE_RADIUS 3.5
#!define STEALING_RISK_MULTIPLIER 1.5
#!define NB_PLAYERS_AUTO_START 4

#!obfuscate

enum Upgrade:
    GOLD_MINER,
    KILL_BOUNTY,
    GOLD_STORAGE,
    BASE_MOVE,
    SWITCH_HERO,
    STEAL_SPEED,
    ENTRY_TIME,

enum Score:
    NB_KILLS = 0,
    NB_DEATHS = 1,
    GOLD_EARNED = 2,
    GOLD_STOLEN = 3,
    START_TIME = 4,
    NB_ORBS_COLLECTED = 5,
    NB_UPGRADES = 6,
    NB_BASE_MOVES = 7,
    GOLD_STOLEN_FROM = 8,


#Global variables

globalvar powerLevelColors = [Color.WHITE, Color.WHITE, Color.WHITE, Color.WHITE, Color.AQUA, Color.AQUA, Color.AQUA, Color.BLUE, Color.PURPLE, Color.RED, Color.ORANGE, rgb(20, 20, 20)]
globalvar upgradeColors = [
    Color.BLUE,
    Color.RED,
    Color.YELLOW,
    Color.GREEN,
    Color.TURQUOISE,
    Color.PURPLE,
    Color.AQUA,
]
globalvar upgradeIcons = [
    iconString(Icon.DIAMOND),
    iconString(Icon.SKULL),
    iconString(Icon.CIRCLE),
    iconString(Icon.TRASHCAN),
    iconString(Icon.RECYCLE),
    iconString(Icon.STOP),
    iconString(Icon.WARNING),
]

globalvar waitingStartGameHud
globalvar waitingNavmeshHud

globalvar gameEndCamera
globalvar tmpTotalGoldCalc
globalvar hudIterator
globalvar antiCrashActivated
globalvar isGameInitialized
globalvar hasGameStarted
#globalvar gameRulesCurrentSelection
#globalvar gameRulesArray
#globalvar gameRulesHost
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
globalvar mapSize
globalvar stealingDistanceThreshold
globalvar stealingDistanceMultiplier
globalvar totalGoldToWin
globalvar sparkboltSpawnpointIndex
globalvar sparkboltPickupPos
globalvar tmpSparkboltClosestPlayer
globalvar sparkboltEffects
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
globalvar gameScorePositions
globalvar gameScoreTopPlayers
globalvar gameScoreTopPlayersValues
globalvar baseUpgradeSphereActualSize
globalvar tmpBaseOwners


#settings
#!define SETTINGS_TITLE "BASE WARS BY DURKHAZ#2629\nCONCEPT: PYROCREEP#2665\nTHANKS: CUDDLYFLOWER#2892, HuKuTa94#2589, Kevin#26140\nRemaster: Zezombye#2627"
globalvar enableStealing = createWorkshopSetting(bool, SETTINGS_TITLE, "Enable Stealing (default on)", true, 0)
globalvar enableOccupiedStealing = createWorkshopSetting(bool, SETTINGS_TITLE, "Enable stealing from occupied bases (default on)", true, 1)
globalvar enableSparkbolts = createWorkshopSetting(bool, SETTINGS_TITLE, "Spawn sparkbolts (default on)", true, 2)
globalvar enableGoldMinerUpgrade = createWorkshopSetting(bool, SETTINGS_TITLE, "Players can upgrade gold miner (default on)", true, 3)
globalvar enableLootOrbs = createWorkshopSetting(bool, SETTINGS_TITLE, "Spawn loot orbs (default on)", true, 4)
globalvar lootSpawnMax = createWorkshopSetting(int[5:16], SETTINGS_TITLE, "Maximum number of loot orbs (default 16)", 16, 5)
globalvar gameLootOrbAmount = createWorkshopSetting(int[5:30], SETTINGS_TITLE, "Gold given by loot orbs (default 10)", 10, 6)
globalvar enableInvisibleLootPickup = createWorkshopSetting(bool, SETTINGS_TITLE, "Sombra can pick up orbs while invisible (default off)", false, 7)
globalvar gameGoldVictory = createWorkshopSetting(int[500:5000], SETTINGS_TITLE, "Amount of gold to win (default 1000)", 1000, 8)
globalvar enableAlwaysFreeHeroSwitch = createWorkshopSetting(bool, SETTINGS_TITLE, "Hero switch is always free (default off)", false, 9)
globalvar enableAlwaysFreeBaseMove = createWorkshopSetting(bool, SETTINGS_TITLE, "Base move is always free (default off)", false, 10)
globalvar enableInefficientGoldMiner = createWorkshopSetting(bool, SETTINGS_TITLE, "Make gold miner less efficient (default off)", false, 11)


#Player variables

playervar storedMoney
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
playervar baseEffectOrb
playervar tmpMoneyDifference
playervar statsMoneySec
playervar playerObjectInBase
playervar statsMoneyKill
playervar isInBase
playervar isChangingHero
playervar oldHeroHealth
playervar isInitialized
playervar upgradeLeftArrow
playervar upgradeRightArrow
playervar upgradeCurrentSelection
playervar isUpgradeInputOnCooldown
playervar showUpgradeText
playervar regenID
playervar upgradeOffsetLeft
playervar upgradeOffsetRight
playervar isInFriendlyZone
playervar isCloaked
playervar stealingFrom
playervar stealingSoundEffect
playervar tmpStealingAmount
playervar stealingOnCooldown
playervar upgradeTextDescription
playervar statsUpgradeLevels
playervar baseEffectRing
playervar statsUpgradeHeroSwitchUsed
playervar statsUpgradeHeroSwitchShadowCost
playervar tmpStealingDistanceBonus
playervar tmpStealingRiskBonus
playervar statsBaseDelay
playervar isSparkboltOnCooldown
playervar tmpBaseSparkboltTarget
playervar nbSparkbolts
playervar sparkboltEffect
playervar scoreArray


#Subroutine names

subroutine settleBalance
subroutine setBaseLocation
subroutine playerBaseBuildEffects
subroutine baseUpgradeFail
subroutine checkUpgradeAvailability
subroutine protectedBaseEffect
subroutine gameStart
subroutine gameEndedScreenPos

#!include "settings.opy"
#!include "loot.opy"
#!include "debug.opy"
#!include "game_end.opy"


rule "init":
    @Condition isGameInProgress()
    
    setMatchTime(819)
    disableGamemodeCompletion()
    disableAnnouncer()
    disableScoring()
    destroyAllDummies()
    destroyHudText(waitingStartGameHud)

    hudHeader([player for player in getAllPlayers() if not player.hasBase], STR_NO_BASE_BUILT, HudPosition.TOP, -4, Color.RED, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)

    hudText([player.stealingFrom for player in getAllPlayers()], STR_ENEMY_IN_BASE, null, "              ", HudPosition.TOP, -2, Color.RED, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)

    #disconnectedPlayers = []
    bountyArrayLocations[11] = null
    bountyArrayEffects[11] = null
    bountyArrayMoney[11] = null
    leaderboard = []
    stealingDistanceMultiplier = 1.5
    stealingDistanceThreshold = 0.75
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

    tmpTotalGoldCalc = 100
    totalGoldToWin = 0
    while tmpTotalGoldCalc < gameGoldVictory:
        totalGoldToWin += tmpTotalGoldCalc
        tmpTotalGoldCalc = ceil(tmpTotalGoldCalc * 1.5 / 10) * 10
    totalGoldToWin += gameGoldVictory

    gameHealingHeroes = ((((([i for i in getAllHeroes() if not i in getSupportHeroes()]).concat(Hero.ZENYATTA.concat(Hero.ANA).concat(Hero.BRIGITTE))).exclude(Hero.BASTION)).exclude(Hero.MEI)).exclude(Hero.ROADHOG)).exclude(Hero.SOLDIER)
    hasGameStarted = true
    wait(1)
    pauseMatchTime()

rule "GAME INIT MAP":
    @Condition isGameInProgress()
    
    #destroyAllHudTexts()
    lootBlockerVolumePos = null
    mapNavMesh = null
    mapInfo = null
    mapRotationVector = angleToDirection(0, 0)
    lootBlockerVolumeRadius = 30
    if getCurrentMap() == Map.BLACK_FOREST or getCurrentMap() == Map.BLACK_FOREST_WINTER:
        mapInfo = vect(-64.026, 10.008, -63.027)
        gameEndCamera = vect(-21.45, 13.18, 2.03)

    elif getCurrentMap() == Map.BLIZZ_WORLD or getCurrentMap() == Map.BLIZZ_WORLD_WINTER:
        mapNavMesh = vect(-92.816, -1.3, 119.946)
        mapInfo = vect(-93.084, 7, 68.06)
        gameEndCamera = vect(-124.15, 1.20, 107.3)

    elif getCurrentMap() == Map.CASTILLO:
        mapInfo = vect(-60.13, 7.032, 52.027)
        gameEndCamera = vect(-82.63, 43.36, 16.35)

    elif getCurrentMap() == Map.CHATEAU_GUILLARD or getCurrentMap() == Map.CHATEAU_GUILLARD_HALLOWEEN:
        mapInfo = vect(66.17, 13.001, 65.046)
        gameEndCamera = vect(205.74, 1.28, 76.17)

    elif getCurrentMap() == Map.DORADO:
        mapInfo = vect(85.11, 14.007, -67.039)
        mapNavMesh = vect(69.636, 6.939, -13.709)
        mapRotationVector = angleToDirection(321, 0)
        gameEndCamera = vect(133.25, 57.86, 34.46)

    elif getCurrentMap() == Map.ECOPOINT_ANTARCTICA or getCurrentMap() == Map.ECOPOINT_ANTARCTICA_WINTER:
        mapInfo = vect(-110.027, 10.003, -56.06)
        gameEndCamera = vect(-5.46, 24.56, -55.57)

    elif getCurrentMap() == Map.EICHENWALDE or getCurrentMap() == Map.EICHENWALDE_HALLOWEEN:
        mapNavMesh = vect(21.479, 4.943, -61.208)
        mapInfo = vect(55.021, 18.004, -77.102)
        mapRotationVector = angleToDirection(15, 0)
        gameEndCamera = vect(122.30, 9.66, -29.30)

    elif getCurrentMap() == Map.HANAMURA or getCurrentMap() == Map.HANAMURA_WINTER:
        mapNavMesh = vect(41.188, 0.478, 24.839)
        mapInfo = vect(-138.015, -14.005, -65.105)
        mapRotationVector = angleToDirection(348, 0)
        gameEndCamera = vect(69.88, -2.14, 58.6)

    elif getCurrentMap() == Map.HAVANA:
        mapNavMesh = vect(-18.944, 6.062, -80.093)
        mapInfo = vect(44, 8.004, -61.103)
        gameEndCamera = vect(-35.31, 8.03, 64.56)

    elif getCurrentMap() == Map.HOLLYWOOD or getCurrentMap() == Map.HOLLYWOOD_HALLOWEEN:
        mapNavMesh = vect(-18.025, 1.777, 14.081)
        mapInfo = vect(-82.041, 6.002, -87.072)
        mapRotationVector = angleToDirection(16, 0)
        gameEndCamera = vect(-31.01, 7.16, -176.48)

    elif getCurrentMap() == Map.HORIZON_LUNAR_COLONY:
        mapNavMesh = vect(51.683, 6.129, -34.033)
        mapInfo = vect(-166.055, 11.003, -80.112)
        mapRotationVector = angleToDirection(48, 0)
        lootBlockerVolumePos = vect(73.442, 17.829, -98.474)
        lootBlockerVolumeRadius = 16
        gameEndCamera = vect(-109, 4.77, -118.15)

    elif getCurrentMap() == Map.ILIOS_LIGHTHOUSE:
        mapInfo = vect(176.245, -12.03, -100.103)
        mapRotationVector = angleToDirection(23, 0)
        gameEndCamera = vect(315.15, -23.06, 82.19)

    elif getCurrentMap() == Map.ILIOS_RUINS:
        mapInfo = vect(-45.081, 10.057, -219.184)
        gameEndCamera = vect(36.57, 102.09, -130)

    elif getCurrentMap() == Map.ILIOS_WELL:
        mapInfo = vect(-157.179, -10.005, -51.094)
        mapRotationVector = angleToDirection(315, 0)
        gameEndCamera = vect(-217.03, 1.35, -18.18)

    elif getCurrentMap() == Map.KANEZAKA:
        mapInfo = vect(-102.070, 10.004, -86.056)
        gameEndCamera = vect(-14.67, 68.99, -126.20)
        #gameEndCamera = vect(138.27, 63.72, -120.02)

    elif getCurrentMap() == Map.KINGS_ROW or getCurrentMap() == Map.KINGS_ROW_WINTER:
        mapNavMesh = vect(-122.712, -1.072, -1.493)
        mapInfo = vect(-74.12, -14.004, -102.068)
        mapRotationVector = angleToDirection(350, 0)
        lootBlockerVolumePos = vect(-127.119, 0.434, -57.126)
        gameEndCamera = vect(-33.72, 40.35, -61.41)

    elif getCurrentMap() == Map.LIJIANG_CONTROL_CENTER or getCurrentMap() == Map.LIJIANG_CONTROL_CENTER_LNY:
        mapInfo = vect(-123.089, 14.265, 127.335)
        mapRotationVector = angleToDirection(45, 0)
        gameEndCamera = vect(87.78, 265.71, 363.57)

    elif getCurrentMap() == Map.LIJIANG_GARDEN or getCurrentMap() == Map.LIJIANG_GARDEN_LNY:
        mapInfo = vect(-79.092, 4.094, 187.108)
        gameEndCamera = vect(-1.28, 95.34, 179.78)

    elif getCurrentMap() == Map.LIJIANG_NIGHT_MARKET or getCurrentMap() == Map.LIJIANG_NIGHT_MARKET_LNY:
        mapInfo = vect(-83.084, -8.002, -185.081)
        gameEndCamera = vect(-77.06, 245.24, 369.46)

    elif getCurrentMap() == Map.NECROPOLIS:
        mapInfo = vect(-65.048, -18.007, -80.036)
        gameEndCamera = vect(0.92, 12.58, -18.32)

    elif getCurrentMap() == Map.NEPAL_SANCTUM:
        mapInfo = vect(194.041, 6.128, -74.097)
        gameEndCamera = vect(81.96, 129.66, -2.54)

    elif getCurrentMap() == Map.NEPAL_SHRINE:
        mapInfo = vect(-183.073, 13.01, -54.09)
        gameEndCamera = vect(50.13, 130.99, -2.66)

    elif getCurrentMap() == Map.NEPAL_VILLAGE or getCurrentMap() == Map.NEPAL_VILLAGE_WINTER:
        mapInfo = vect(-185.223, -14.102, -90.096)
        gameEndCamera = vect(-63.38, 16, -63.21)

    elif getCurrentMap() == Map.OASIS_GARDENS:
        mapInfo = vect(163.047, 11.001, -79.268)
        mapRotationVector = angleToDirection(45, 0)
        gameEndCamera = vect(142.13, 46.81, -224.55)

    elif getCurrentMap() == Map.OASIS_UNIVERSITY:
        mapInfo = vect(-140.225, 11.008, -64.07)
        gameEndCamera = vect(-197.81, 59.98, 43.73)

    elif getCurrentMap() == Map.PARIS:
        mapNavMesh = vect(-46.367, 10.098, -0.162)
        mapInfo = vect(-86.143, 8.008, -82.084)
        mapRotationVector = angleToDirection(26, 0)
        gameEndCamera = vect(27.85, 12.88, -83.67)

    elif getCurrentMap() == Map.PETRA:
        mapInfo = vect(-83.044, -15.012, -83.015)
        gameEndCamera = vect(1.02, -8.96, 7.02)

    elif getCurrentMap() == Map.TEMPLE_OF_ANUBIS:
        mapNavMesh = vect(-4.694, -2.336, -6.513)
        mapInfo = vect(80.016, 10, -130.004)
        mapRotationVector = angleToDirection(275, 0)
        gameEndCamera = vect(15.08, 16.60, -18.58)

    elif getCurrentMap() == Map.VOLSKAYA:
        mapNavMesh = vect(14.482, -4.352, 44.386)
        mapInfo = vect(-73.094, -8.005, 145.01)
        mapRotationVector = angleToDirection(335, 0)
        lootBlockerVolumePos = vect(28.034, 27.621, 76.387)
        gameEndCamera = vect(-41, -1.32, -85.31)

    #elif getCurrentMap() == Map.WORKSHOP_EXPANSE or getCurrentMap() == Map.WORKSHOP_EXPANSE_NIGHT:
    #    mapInfo = vect(-200.1, 1, -200.1)

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
    destroyHudText(waitingNavmeshHud)
    setMatchTime(62)
    gameEndingScreenPos = vect(0, 0, 0)


rule "skip assembling heroes":
    @Condition isAssemblingHeroes()
    if DEBUG_MODE:
        setMatchTime(1)
    else:
        setMatchTime(10)



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
    eventPlayer.statsMoney = 0
    eventPlayer.statsMoneyStorage = 100
    eventPlayer.upgradeCurrentSelection = 2

    eventPlayer.statsUpgradeCost = []
    eventPlayer.statsUpgradeCost[Upgrade.GOLD_MINER] = gameRulesGoldMinerInitialCost
    eventPlayer.statsUpgradeCost[Upgrade.KILL_BOUNTY] = 25
    eventPlayer.statsUpgradeCost[Upgrade.GOLD_STORAGE] = 100
    eventPlayer.statsUpgradeCost[Upgrade.BASE_MOVE] = gameRulesMoveBaseInitialCost
    eventPlayer.statsUpgradeCost[Upgrade.SWITCH_HERO] = 0
    eventPlayer.statsUpgradeCost[Upgrade.STEAL_SPEED] = 30
    eventPlayer.statsUpgradeCost[Upgrade.ENTRY_TIME] = 80

    eventPlayer.statsUpgradeLevels = [1, 1, 1, 0, 0, 1, 1]
    eventPlayer.statsUpgradeHeroSwitchShadowCost = 75
    eventPlayer.statsMoneyKill = 5
    eventPlayer.statsStealingSpeed = 1
    if DEBUG_MODE:
        eventPlayer.statsBaseDelay = 1
    else:
        eventPlayer.statsBaseDelay = 4
    eventPlayer.isStealingActive = false
    eventPlayer.playerBaseLocation = vect(0, -1000, 0)
    eventPlayer.playerObjectInBase = null
    eventPlayer.isInFriendlyZone = false
    eventPlayer.debugEffectCountArray = []

    eventPlayer.isUpgradeInputOnCooldown = false
    eventPlayer.upgradeOffsetLeft = 0.9
    eventPlayer.upgradeOffsetRight = eventPlayer.upgradeOffsetLeft * -1

    eventPlayer.disableGamemodeHud()
    #eventPlayer.disableScoreboard()
    eventPlayer.scoreArray[Score.START_TIME] = getTotalTimeElapsed()


rule "game not started":
    @Condition isWaitingForPlayers()
    
    hudHeader(getAllPlayers(), STR_WAITING_FOR_PLAYERS if getNumberOfPlayers(Team.ALL) < NB_PLAYERS_AUTO_START else STR_STARTING_GAME, HudPosition.TOP, 3, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    waitingStartGameHud = getLastCreatedText()

rule "enough players - start game":
    @Condition isWaitingForPlayers()
    @Condition getNumberOfPlayers(Team.ALL) >= (NB_PLAYERS_AUTO_START if not DEBUG_MODE else 1)
    do:
        for I in range(12):
            createDummy(Hero.ANA, Team.ALL, -1, null, null)
        wait(1)
    while RULE_CONDITION
    destroyAllDummies()


rule "unsupported map":
    @Condition mapInfo == null
    @Condition isGameInProgress()
    
    hudHeader(getAllPlayers(), STR_MAP_NOT_SUPPORTED, HudPosition.TOP, 3, Color.RED, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)


rule "waiting for navmesh to generate":
    @Condition hasGameStarted == false
    @Condition isGameInitialized == false
    @Condition mapInfo != null
    
    hudHeader(getAllPlayers(), STR_BUILDING_NAVMESH, HudPosition.TOP, 3, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    waitingNavmeshHud = getLastCreatedText()


rule "init player hud":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.isInitialized == false
    @Condition hasGameStarted
    
    wait(0.25)
    eventPlayer.isInitialized = true
    
    #gold in base
    hudText(eventPlayer, iconString(Icon.CIRCLE), STR_GOLD_IN_BASE, "{0}/{1} ({2})".format(eventPlayer.statsMoneyBase, eventPlayer.statsMoneyStorage, STR_GOLD_PER_SEC if eventPlayer.statsMoneyBase < eventPlayer.statsMoneyStorage else STR_FULL), HudPosition.LEFT, 0, Color.ORANGE, Color.ORANGE, Color.WHITE if eventPlayer.statsMoneyBase < eventPlayer.statsMoneyStorage else Color.RED, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.DEFAULT)

    #gold on player
    hudText(eventPlayer, iconString(Icon.POISON), STR_GOLD_ON_PLAYER, eventPlayer.statsMoney, HudPosition.LEFT, 1, Color.ORANGE, Color.ORANGE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)

    #upgrade header
    createInWorldText(eventPlayer if eventPlayer.showUpgradeText else [], "{}{}\n{}\n\n\n\n".format([
        STR_AUTO_GOLD_MINER_WHITESPACE,
        STR_KILL_GOLD_BOUNTY_WHITESPACE,
        STR_BASE_GOLD_STORAGE_WHITESPACE,
        STR_MOVE_YOUR_BASE_WHITESPACE,
        STR_SWITCH_YOUR_HERO_WHITESPACE,
        STR_GOLD_STEAL_SPEED_WHITESPACE,
        STR_BASE_ENTRY_TIME_WHITESPACE,
    ][eventPlayer.upgradeCurrentSelection], upgradeIcons[eventPlayer.upgradeCurrentSelection], [
        STR_AUTO_GOLD_MINER,
        STR_KILL_GOLD_BOUNTY,
        STR_BASE_GOLD_STORAGE,
        STR_MOVE_YOUR_BASE,
        STR_SWITCH_YOUR_HERO,
        STR_GOLD_STEAL_SPEED,
        STR_BASE_ENTRY_TIME,
    ][eventPlayer.upgradeCurrentSelection]), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, upgradeColors[eventPlayer.upgradeCurrentSelection], SpecVisibility.DEFAULT)

    #upgrade description
    createInWorldText(eventPlayer if eventPlayer.showUpgradeText else [], [
        STR_AUTO_GOLD_MINER_DESCRIPTION,
        STR_KILL_GOLD_BOUNTY_DESCRIPTION,
        STR_BASE_GOLD_STORAGE_DESCRIPTION,
        STR_MOVE_YOUR_BASE_DESCRIPTION,
        STR_SWITCH_YOUR_HERO_DESCRIPTION,
        STR_GOLD_STEAL_SPEED_DESCRIPTION,
        STR_BASE_ENTRY_TIME_DESCRIPTION,
    ][eventPlayer.upgradeCurrentSelection], eventPlayer.playerBaseLocation, 1.1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)

    #base sphere
    createEffect([player for player in getAllPlayers() if not (player == eventPlayer and player.isInBase)], Effect.SPHERE, powerLevelColors[eventPlayer.statsUpgradeLevels[Upgrade.GOLD_STORAGE]], eventPlayer.playerBaseLocation, BASE_RADIUS, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)

    #base ring
    createEffect(eventPlayer if eventPlayer.isInBase else [], Effect.RING, powerLevelColors[eventPlayer.statsUpgradeLevels[Upgrade.GOLD_STORAGE]], eventPlayer.playerBaseLocation, 3.5, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)
    
    #upgrade sphere
    createEffect(eventPlayer if eventPlayer.isInBase else [], Effect.SPHERE, upgradeColors[eventPlayer.upgradeCurrentSelection] if eventPlayer.showUpgradeText else Color.WHITE, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_RADIUS_AND_COLOR)

    createIcon(eventPlayer if eventPlayer.showUpgradeText else [], updateEveryTick(normalize(vect(eventPlayer.getFacingDirection().z * -1, 0, eventPlayer.getFacingDirection().x)) * eventPlayer.upgradeOffsetRight + (eventPlayer.playerBaseLocation - vect(0, 0.3, 0))), Icon.ARROW_LEFT, IconReeval.VISIBILITY_AND_POSITION, Color.WHITE, false)
    createIcon(eventPlayer if eventPlayer.showUpgradeText else [], updateEveryTick(normalize(vect(eventPlayer.getFacingDirection().z * -1, 0, eventPlayer.getFacingDirection().x)) * eventPlayer.upgradeOffsetLeft + (eventPlayer.playerBaseLocation - vect(0, 0.3, 0))), Icon.ARROW_RIGHT, IconReeval.VISIBILITY_AND_POSITION, Color.WHITE, false)

    #stealing sphere
    createEffect([player for player in getAllPlayers() if player.stealingFrom == eventPlayer], Effect.SPHERE, Color.RED, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    #stealing hud
    createInWorldText([player for player in getAllPlayers() if player.stealingFrom == eventPlayer], STR_HOLD_TO_STEAL, eventPlayer.playerBaseLocation, 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.RED, SpecVisibility.NEVER)


rule "update outlines":
    @Event eachPlayer
    while true:
        eventPlayer.startForcingOutlineFor(getAllPlayers(), true, powerLevelColors[eventPlayer.statsUpgradeLevels[Upgrade.GOLD_STORAGE]], OutlineVisibility.DEFAULT)
        wait(1)


rule "display scoreboard":
    @Condition hasGameStarted
    
    wait()

    #title + 1st player
    hudText(getAllPlayers(), null, 
        STR_SCOREBOARD_TITLE, 
        STR_SCOREBOARD_SUBTITLE,
        HudPosition.RIGHT, 1, Color.WHITE, Color.ORANGE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
    
    for hudIterator in range(3):
        hudText(getAllPlayers(), null, STR_SCOREBOARD_TITLE_HIDDEN, " · {0}% {1} {2} ".format(
            floor(((leaderboard[evalOnce(hudIterator)].statsMoneyBase + leaderboard[evalOnce(hudIterator)].storedMoney) / totalGoldToWin) * 100),
            heroIcon(leaderboard[evalOnce(hudIterator)].getCurrentHero()), 
            leaderboard[evalOnce(hudIterator)]
        ), HudPosition.RIGHT, evalOnce(hudIterator)+2, null, null, powerLevelColors[leaderboard[evalOnce(hudIterator)].statsUpgradeLevels[Upgrade.GOLD_STORAGE]], HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.ALWAYS)

    #if gameRulesCustomized:
        #hudText(gameRulesVisibleTo, null, "Lobby Mods: {0}{1}{2}".format("{0}{1}{2}".format("{0}{1}{2}".format(["No Stealing, ", ""][enableStealing], ["Steal from empty base only, ", ""][enableOccupiedStealing], ["No Sparkbolt, ", ""][enableSparkbolts]), ["No Goldminer, ", ""][enableGoldMinerUpgrade], ["No Loot, ", ""][enableLootOrbs]), "{0}{1}{2}".format(["No Sombra Invis loot, ", ""][enableInvisibleLootPickup], ["", "5000 gold victory, "][enableAlwaysFreeHeroSwitch], ["", "Free Heroswitch, "][enableAlwaysFreeHeroSwitch]), "{0}{1}{2}".format(["", "Free Basemove, "][enableAlwaysFreeBaseMove], ["", "Slower Goldminer, "][enableInefficientGoldMiner], "")), "{0} + {1} to hide mods".format(buttonString(Button.CROUCH), buttonString(Button.MELEE)), HudPosition.LEFT, -1, Color.ORANGE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)



rule "update scoreboard":
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
    @Condition eventPlayer.isInBase == false
    
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
    #spawnBaseEffect()
    #createIcon(eventPlayer, eventPlayer.playerBaseLocation + vect(0, 2.8, 0), Icon.HALO, IconReeval.POSITION, Color.WHITE, false)
    createInWorldText([player for player in getAllPlayers() if player != eventPlayer], "{1} {0} {2}".format(eventPlayer, heroIcon(eventPlayer.getCurrentHero()), eventPlayer.statsMoneyBase), eventPlayer.playerBaseLocation + vect(0, 2, 0), 0.8, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.ALWAYS)
    createInWorldText(eventPlayer, "{}{}".format(heroIcon(eventPlayer.getCurrentHero()), STR_YOUR_BASE), eventPlayer.playerBaseLocation + vect(0, 2.5, 0), 1, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.NEVER)
    createInWorldText(eventPlayer if eventPlayer.showUpgradeText else [], " \n \n \n \n \n{}{}".format(eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection], STR_XXX_GOLD), eventPlayer.playerBaseLocation, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.ORANGE, SpecVisibility.DEFAULT)
    playerBaseBuildEffects()


rule "player enters base":
    @Event eachPlayer
    @Hero all
    @Condition hasGameStarted
    @Condition eventPlayer.playerObjectInBase == null
    @Condition eventPlayer.hasBase
    @Condition distance(eventPlayer.playerBaseLocation, eventPlayer) <= 3.5
    @Condition not eventPlayer.hasStatusEffect(Status.ASLEEP)
    @Condition not eventPlayer.hasStatusEffect(Status.FROZEN)
    @Condition not eventPlayer.hasStatusEffect(Status.UNKILLABLE)
    @Condition not eventPlayer.hasStatusEffect(Status.INVINCIBLE)
    @Condition not eventPlayer.hasStatusEffect(Status.PHASED_OUT)
    @Condition not eventPlayer.isUsingUltimate()
    @Condition not eventPlayer.isCloaked
    
    eventPlayer.playerObjectInBase = eventPlayer
    stopChasingVariable(eventPlayer.baseProtectionTimer)
    eventPlayer.baseProtectionTimer = eventPlayer.statsBaseDelay
    hudHeader(eventPlayer, STR_ENTERING_BASE, HudPosition.TOP, -3, Color.ORANGE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.hudBaseProtection = getLastCreatedText()
    chase(eventPlayer.baseProtectionTimer, 0, rate=1, ChaseReeval.NONE)


rule "BASE ENTER ABORT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.playerObjectInBase == eventPlayer
    @Condition eventPlayer.isInBase == false
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
    if not eventPlayer.isInBase:
        return
    eventPlayer.isInBase = false
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.setInvisibility(Invis.NONE)
    eventPlayer.stopAllHoT()
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.MELEE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.allowButton(Button.ULTIMATE)
    #destroyIcon(eventPlayer.upgradeLeftArrow)
    #destroyIcon(eventPlayer.upgradeRightArrow)
    #eventPlayer.upgradeLeftArrow = null
    #eventPlayer.upgradeRightArrow = null


rule "player finished entering base":
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
    hudText(eventPlayer, STR_PROTECTED_AND_INVISIBLE, STR_CONTROLS, "{0}\n{1}".format(STR_CONTROLS_CONTENT_1, STR_CONTROLS_CONTENT_2), HudPosition.TOP, -3, Color.GREEN, Color.GREEN, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.hudBaseProtection = getLastCreatedText()
    settleBalance()
    #createEffect(eventPlayer, Effect.SPHERE, Color.WHITE, eventPlayer.playerBaseLocation, 0.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

    #createIcon(eventPlayer.showUpgradeText, normalize(vect(eventPlayer.getFacingDirection().z * -1, 0, eventPlayer.getFacingDirection().x)) * eventPlayer.upgradeOffsetRight + (eventPlayer.playerBaseLocation - vect(0, 0.3, 0)), Icon.ARROW_LEFT, IconReeval.VISIBILITY_AND_POSITION, Color.WHITE, false)
    #eventPlayer.upgradeLeftArrow = getLastCreatedEntity()
    #createIcon(eventPlayer.showUpgradeText, normalize(vect(eventPlayer.getFacingDirection().z * -1, 0, eventPlayer.getFacingDirection().x)) * eventPlayer.upgradeOffsetLeft + (eventPlayer.playerBaseLocation - vect(0, 0.3, 0)), Icon.ARROW_RIGHT, IconReeval.VISIBILITY_AND_POSITION, Color.WHITE, false)
    #eventPlayer.upgradeRightArrow = getLastCreatedEntity()
    if not eventPlayer.isInBase:
        playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, powerLevelColors[eventPlayer.statsUpgradeLevels[Upgrade.GOLD_STORAGE]], eventPlayer.getPosition(), 4)

    eventPlayer.isInBase = true


rule "BASE RESPAWN":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isAlive()
    
    if not eventPlayer.hasBase or eventPlayer.isMovingBase:
        return
    eventPlayer.statsMoney = 0
    destroyHudText(eventPlayer.hudBaseProtection)
    eventPlayer.isInBase = true
    eventPlayer.baseProtectionTimer = 0
    eventPlayer.teleport(eventPlayer.playerBaseLocation)
    eventPlayer.playerObjectInBase = eventPlayer
    eventPlayer.setInvisibility(Invis.ALL)

rule "check if player is in someone else's base":
    @Event eachPlayer
    @Condition hasGameStarted
    @Condition enableStealing

    #TODO: optimize this shit by not constantly looping if stealingFrom != null
    while true:
        if eventPlayer.isAlive() and eventPlayer.hasSpawned() /*and eventPlayer.stealingFrom == null*/ and not eventPlayer.isCloaked:
            tmpBaseOwners = [player for player in getAllPlayers() if player != eventPlayer and player.hasBase and player.statsMoneyBase != 0 and not (player.isInBase and not enableOccupiedStealing)]
            for stealingBaseOwnerIterator in range(len(tmpBaseOwners)):
                if distance(eventPlayer.getPosition(), tmpBaseOwners[stealingBaseOwnerIterator].playerBaseLocation) <= BASE_RADIUS:
                    eventPlayer.stealingFrom = tmpBaseOwners[stealingBaseOwnerIterator]
                    goto found_steal

        
        eventPlayer.stealingFrom = null
        found_steal:
        wait(0.064)


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
        if eventPlayer.stealingFrom.isInBase:
            eventPlayer.tmpMoneyDifference += eventPlayer.stealingFrom.statsMoney
        

        eventPlayer.tmpStealingAmount = ceil(eventPlayer.stealingFrom.statsMoneySec / 2) + eventPlayer.statsStealingSpeed

        #Risk bonus (if player is in base)
        if eventPlayer.stealingFrom.isInBase or eventPlayer.stealingFrom.isDead():
            eventPlayer.tmpStealingRiskBonus = ceil(eventPlayer.tmpStealingAmount * (STEALING_RISK_MULTIPLIER-1))
            eventPlayer.tmpStealingAmount += eventPlayer.tmpStealingRiskBonus
        else:
            eventPlayer.tmpStealingRiskBonus = 0

        #Distance bonus
        eventPlayer.tmpStealingDistanceBonus = round(eventPlayer.statsStealingSpeed * ((stealingDistanceMultiplier + stealingDistanceThreshold) * (min(1, distance(eventPlayer.playerBaseLocation, eventPlayer.stealingFrom.playerBaseLocation) / mapSize)) - stealingDistanceThreshold))
        if not eventPlayer.hasBase:
            eventPlayer.tmpStealingDistanceBonus = 0

        if eventPlayer.tmpStealingDistanceBonus > 0:
            eventPlayer.tmpStealingAmount += eventPlayer.tmpStealingDistanceBonus

        eventPlayer.tmpStealingAmount = min(eventPlayer.tmpStealingAmount, eventPlayer.tmpMoneyDifference)

        if eventPlayer.tmpStealingDistanceBonus > 0:
            if eventPlayer.tmpStealingRiskBonus > 0:
                smallMessage(eventPlayer, STR_STEAL_RISK_DISTANCE_BONUS)
            else:
                smallMessage(eventPlayer, STR_STEAL_DISTANCE_BONUS)

        else:
            if eventPlayer.tmpStealingRiskBonus > 0:
                smallMessage(eventPlayer, STR_STEAL_RISK_BONUS)
            else:
                smallMessage(eventPlayer, "+{}{}".format(eventPlayer.tmpStealingAmount, STR_XXX_GOLD))

        eventPlayer.statsMoney += eventPlayer.tmpStealingAmount
        eventPlayer.scoreArray[Score.GOLD_EARNED] += eventPlayer.tmpStealingAmount
        eventPlayer.scoreArray[Score.GOLD_STOLEN] += eventPlayer.tmpStealingAmount
        eventPlayer.stealingFrom.scoreArray[Score.GOLD_STOLEN_FROM] += eventPlayer.tmpStealingAmount
        eventPlayer.stealingFrom.statsMoneyBase -= eventPlayer.tmpStealingAmount
        
        #If the player is in the base, take from his money instead of from his base
        if eventPlayer.stealingFrom.isInBase and eventPlayer.stealingFrom.statsMoneyStorage != eventPlayer.stealingFrom.statsMoneyBase and eventPlayer.stealingFrom.statsMoney > 0:
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


rule "upgrade gold miner":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isInBase
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.upgradeCurrentSelection == 0
    @Condition eventPlayer.showUpgradeText != null
    @Condition eventPlayer.hasBase
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[Score.NB_UPGRADES] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.BLUE, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] = ceil(eventPlayer.statsUpgradeCost * 1.5 / 10) * 10
        eventPlayer.statsUpgradeCost[Upgrade.STEAL_SPEED] = eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
        eventPlayer.statsMoneySec += 1
        eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection] += 1
        smallMessage(eventPlayer, "{0}{1}{0}".format(iconString(Icon.ARROW_UP), STR_MORE_GOLD_SEC))
        checkUpgradeAvailability()
        settleBalance()
    else:
        baseUpgradeFail()


rule "gold miner loop":
    @Event eachPlayer
    @Hero all
    @Condition hasGameStarted
    @Condition eventPlayer.statsMoneySec != 0
    
    while true:
        if eventPlayer.hasBase and not eventPlayer.isDead() and eventPlayer not in [player.stealingFrom for player in getAllPlayers()] and not eventPlayer.isMovingBase and not eventPlayer.isInBase:

            if eventPlayer.statsMoneyBase < eventPlayer.statsMoneyStorage:
                eventPlayer.scoreArray[Score.GOLD_EARNED] += eventPlayer.tmpMoneyDifference
                eventPlayer.statsMoneyBase += eventPlayer.statsMoneySec
                eventPlayer.statsMoneyBase min= eventPlayer.statsMoneyStorage

        wait(gameRulesGoldMinerFrequency)


rule "upgrade kill bounty":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isInBase
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.upgradeCurrentSelection == 1
    @Condition eventPlayer.showUpgradeText != null
    @Condition eventPlayer.hasBase
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[Score.NB_UPGRADES] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.RED, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] = round(eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] * 1.5 / 10) * 10
        eventPlayer.statsMoneyKill += 15
        eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection] += 1
        smallMessage(eventPlayer, "{0}{1}{0}".format(iconString(Icon.ARROW_UP), STR_MORE_KILL_BOUNTY))
        checkUpgradeAvailability()
        settleBalance()
    else:
        baseUpgradeFail()


rule "player kill":
    @Event playerDied
    @Hero all
    @Condition hasGameStarted
    
    eventPlayer.scoreArray[Score.NB_DEATHS] += 1
    if attacker != victim:
        smallMessage(attacker, "+ {}{}".format(attacker.statsMoneyKill, STR_XXX_GOLD_KILL))
        attacker.statsMoney += attacker.statsMoneyKill
        attacker.scoreArray[Score.GOLD_EARNED] += attacker.statsMoneyKill
        attacker.scoreArray[Score.NB_KILLS] += 1

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


rule "upgrade storage capacity":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isInBase
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.upgradeCurrentSelection == 2
    @Condition eventPlayer.showUpgradeText != null
    @Condition eventPlayer.hasBase
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[Score.NB_UPGRADES] += 1
        eventPlayer.storedMoney += eventPlayer.statsMoneyStorage
        eventPlayer.statsMoneyBase = 0
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.YELLOW, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsMoneyStorage = min(ceil(eventPlayer.statsMoneyStorage * 1.5 / 10) * 10, gameGoldVictory)
        eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] = eventPlayer.statsMoneyStorage
        if enableAlwaysFreeHeroSwitch:
            goto lbl_0
        if eventPlayer.statsUpgradeHeroSwitchUsed or eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection] >= 4:
            eventPlayer.statsUpgradeHeroSwitchUsed = true
            if eventPlayer.statsUpgradeCost[Upgrade.SWITCH_HERO] != 0:
                goto lbl_1
            eventPlayer.statsUpgradeCost[Upgrade.SWITCH_HERO] = eventPlayer.statsUpgradeHeroSwitchShadowCost
            lbl_1:
            eventPlayer.statsUpgradeCost[Upgrade.SWITCH_HERO] += ceil(eventPlayer.statsMoneyStorage / 5)
        else:
            eventPlayer.statsUpgradeHeroSwitchShadowCost += ceil(eventPlayer.statsMoneyStorage / 5)
        lbl_0:
        if enableAlwaysFreeBaseMove:
            goto lbl_2
        eventPlayer.statsUpgradeCost[Upgrade.BASE_MOVE] = max(ceil(eventPlayer.statsMoneyStorage / 5), 50)
        lbl_2:
        eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection] += 1
        smallMessage(eventPlayer, "{1} +{0}{2}{1}".format(ceil(eventPlayer.statsMoneyStorage / 2), iconString(Icon.ARROW_UP), STR_XXX_GOLD_CAPACITY))
        checkUpgradeAvailability()
        settleBalance()
    else:
        baseUpgradeFail()


rule "UPGRADE BUY MOVE BASE":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isInBase
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.upgradeCurrentSelection == 3
    @Condition eventPlayer.showUpgradeText != null
    @Condition eventPlayer.hasBase
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[Score.NB_BASE_MOVES] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.GREEN, eventPlayer.playerBaseLocation, 2)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.playerBaseLocation = vect(0, -10000, 0)
        smallMessage(eventPlayer, "{0}{1}{0}".format(iconString(Icon.TRASHCAN), STR_PACKED_UP_BASE))
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
    @Condition eventPlayer.isInBase
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.upgradeCurrentSelection == 4
    @Condition eventPlayer.showUpgradeText != null
    @Condition eventPlayer.hasBase
    @Condition eventPlayer.isChangingHero == false
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.isChangingHero = true
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
        if enableAlwaysFreeHeroSwitch:
            goto lbl_0
        if eventPlayer.statsUpgradeHeroSwitchUsed:
            goto lbl_1
        eventPlayer.statsUpgradeCost[Upgrade.SWITCH_HERO] = eventPlayer.statsUpgradeHeroSwitchShadowCost
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
    eventPlayer.isInBase = true
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
    @Condition eventPlayer.isInBase
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.upgradeCurrentSelection == 5
    @Condition eventPlayer.showUpgradeText != null
    @Condition eventPlayer.hasBase
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[Score.NB_UPGRADES] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.PURPLE, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] = ceil(eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] * 1.5 / 10) * 10
        if not enableGoldMinerUpgrade:
            goto lbl_0
        eventPlayer.statsUpgradeCost[Upgrade.GOLD_MINER] = eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
        lbl_0:
        eventPlayer.statsStealingSpeed += 1
        eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection] += 1
        smallMessage(eventPlayer, "{0}{1}{0}".format(iconString(Icon.ARROW_UP), STR_MORE_GOLD_STEAL_SEC))
        checkUpgradeAvailability()
        settleBalance()
    else:
        baseUpgradeFail()


rule "UPGRADE BUY DELAY":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isInBase
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.upgradeCurrentSelection == 6
    @Condition eventPlayer.showUpgradeText != null
    @Condition eventPlayer.hasBase
    
    if eventPlayer.statsMoneyBase >= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]:
        eventPlayer.scoreArray[Score.NB_UPGRADES] += 1
        eventPlayer.statsMoneyBase -= eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection]
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.SKY_BLUE, eventPlayer.playerBaseLocation, 4)
        playEffect(eventPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 200)
        eventPlayer.statsBaseDelay -= 0.5
        if eventPlayer.statsBaseDelay <= 0.5:
            eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] += 10000
        else:
            eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] *= 2
        eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection] += 1
        smallMessage(eventPlayer, "{0}{1}{0}".format(iconString(Icon.ARROW_UP), STR_LESS_ENTER_DELAY))
        checkUpgradeAvailability()
        settleBalance()
    else:
        baseUpgradeFail()


rule "upgrade - use sparkbolt":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isInBase
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.nbSparkbolts != 0
    @Condition eventPlayer.isSparkboltOnCooldown == false
    
    eventPlayer.isSparkboltOnCooldown = true
    eventPlayer.tmpBaseSparkboltTarget = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 10, getAllPlayers(), eventPlayer, true).getPlayerHit()
    if entityExists(eventPlayer.tmpBaseSparkboltTarget):
        if distance(eventPlayer.playerBaseLocation, eventPlayer.tmpBaseSparkboltTarget.getPosition()) < 8:
            eventPlayer.nbSparkbolts -= 1
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
            smallMessage(eventPlayer, STR_TOO_FAR_AWAY)
    else:
        smallMessage(eventPlayer, STR_AIM_AT_ENEMY)
    wait(0.5)
    eventPlayer.isSparkboltOnCooldown = false


rule "UPGRADE SELECT LEFT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isUpgradeInputOnCooldown == false
    @Condition eventPlayer.showUpgradeText != null
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    @Condition eventPlayer.isInBase
    
    playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 20)
    eventPlayer.isUpgradeInputOnCooldown = true
    eventPlayer.tmpUpgradeCurrentSelection = eventPlayer.upgradeCurrentSelection - 1
    while true:
        if eventPlayer.tmpUpgradeCurrentSelection < 0:
            eventPlayer.tmpUpgradeCurrentSelection = len(eventPlayer.statsUpgradeCost) - 1

        if eventPlayer.statsUpgradeCost[eventPlayer.tmpUpgradeCurrentSelection] <= gameGoldVictory:
            break
        eventPlayer.tmpUpgradeCurrentSelection -= 1

    eventPlayer.upgradeCurrentSelection = eventPlayer.tmpUpgradeCurrentSelection
    eventPlayer.upgradeOffsetRight = -1
    wait(0.25)
    eventPlayer.upgradeOffsetRight = -0.9
    wait(0.25)
    eventPlayer.isUpgradeInputOnCooldown = false


rule "UPGRADE SELECT RIGHT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isUpgradeInputOnCooldown == false
    @Condition eventPlayer.showUpgradeText != null
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    @Condition eventPlayer.isInBase
    
    playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer, 20)
    eventPlayer.isUpgradeInputOnCooldown = true
    eventPlayer.tmpUpgradeCurrentSelection = (eventPlayer.upgradeCurrentSelection + 1) % len(eventPlayer.statsUpgradeCost)
    while true:
        if eventPlayer.statsUpgradeCost[eventPlayer.tmpUpgradeCurrentSelection] <= gameGoldVictory:
            break
        eventPlayer.tmpUpgradeCurrentSelection = (eventPlayer.tmpUpgradeCurrentSelection + 1) % len(eventPlayer.statsUpgradeCost)

    eventPlayer.upgradeCurrentSelection = eventPlayer.tmpUpgradeCurrentSelection
    eventPlayer.upgradeOffsetLeft = 1
    wait(0.25)
    eventPlayer.upgradeOffsetLeft = 0.9
    wait(0.25)
    eventPlayer.isUpgradeInputOnCooldown = false


rule "show upgrade menu":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isInBase
    @Condition eventPlayer.showUpgradeText == null
    #@Condition dotProduct(directionTowards(eventPlayer.getEyePosition(), eventPlayer.playerBaseLocation), eventPlayer.getFacingDirection()) >= 0.99
    @Condition distance(vect(0, 0, 0), eventPlayer.playerBaseLocation - (eventPlayer.getEyePosition() + ((abs(dotProduct(eventPlayer.playerBaseLocation - eventPlayer.getEyePosition(), eventPlayer.getFacingDirection()))) * eventPlayer.getFacingDirection()))) <= baseUpgradeSphereActualSize
    
    eventPlayer.isUpgradeInputOnCooldown = true
    wait(0.25, Wait.ABORT_WHEN_FALSE)
    eventPlayer.showUpgradeText = true
    wait(0.25)
    if eventPlayer.showUpgradeText != null:
        eventPlayer.isUpgradeInputOnCooldown = false

    if RULE_CONDITION:
        goto RULE_START


rule "hide upgrade menu":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.showUpgradeText
    @Condition distance(vect(0, 0, 0), eventPlayer.playerBaseLocation - (eventPlayer.getEyePosition() + ((abs(dotProduct(eventPlayer.playerBaseLocation - eventPlayer.getEyePosition(), eventPlayer.getFacingDirection()))) * eventPlayer.getFacingDirection()))) > baseUpgradeSphereActualSize
    
    eventPlayer.showUpgradeText = false


def settleBalance():
    @Name "SUB SETTLE BALANCE"
    
    if eventPlayer.statsMoneyStorage != eventPlayer.statsMoneyBase and eventPlayer.statsMoney > 0:
        eventPlayer.tmpMoneyDifference = min(eventPlayer.statsMoneyStorage - eventPlayer.statsMoneyBase, eventPlayer.statsMoney)
        eventPlayer.statsMoney -= eventPlayer.tmpMoneyDifference
        eventPlayer.statsMoneyBase += eventPlayer.tmpMoneyDifference
        smallMessage(eventPlayer, STR_STORED_GOLD_IN_BASE)


def setBaseLocation():
    @Name "place player base if location is good"
    
    if distance(eventPlayer.getPosition(), getAllPlayers()[eventPlayer.playerBaseProximityIterator].playerBaseLocation) < 14:
        smallMessage(eventPlayer, "{0}{1}{0}".format(iconString(Icon.STOP), STR_ENEMY_BASE_TOO_CLOSE))
        eventPlayer.playerBaseProximityIterator = 0
        return

    eventPlayer.playerBaseProximityIterator += 1
    if eventPlayer.playerBaseProximityIterator < len(getAllPlayers()):
        goto RULE_START
    eventPlayer.playerBaseProximityIterator = 0
    if distance(raycast(eventPlayer.getEyePosition(), eventPlayer.getPosition() + ((directionTowards(eventPlayer.getEyePosition(), eventPlayer.getPosition() + vect(2, 0, 0))) * 40), [], [], false).getHitPosition(), eventPlayer.getPosition() + vect(2, 0, 0)) > 0.6:
        goto badLocation
    if distance(raycast(eventPlayer.getEyePosition(), eventPlayer.getPosition() + ((directionTowards(eventPlayer.getEyePosition(), eventPlayer.getPosition() + vect(-2, 0, 0))) * 40), [], [], false).getHitPosition(), eventPlayer.getPosition() + vect(-2, 0, 0)) > 0.6:
        goto badLocation
    if distance(raycast(eventPlayer.getEyePosition(), eventPlayer.getPosition() + ((directionTowards(eventPlayer.getEyePosition(), eventPlayer.getPosition() + vect(0, 0, 2))) * 40), [], [], false).getHitPosition(), eventPlayer.getPosition() + vect(0, 0, 2)) > 0.6:
        goto badLocation
    if distance(raycast(eventPlayer.getEyePosition(), eventPlayer.getPosition() + ((directionTowards(eventPlayer.getEyePosition(), eventPlayer.getPosition() + vect(0, 0, -2))) * 40), [], [], false).getHitPosition(), eventPlayer.getPosition() + vect(0, 0, -2)) > 0.6:
        goto badLocation
    if eventPlayer.hasStatusEffect(Status.INVINCIBLE) or distance(eventPlayer.getPosition(), nearestWalkablePosition(eventPlayer.getPosition())) > 8:
        goto badLocation

    #prevent placing base on cars
    if getCurrentMap() == Map.KANEZAKA and eventPlayer.getPosition().y > 13 and eventPlayer.getPosition().z > 24:
        goto badLocation

    eventPlayer.playerBaseLocation = eventPlayer.getPosition()
    return

    badLocation:
    smallMessage(eventPlayer, "{0}{1}{0}".format(iconString(Icon.STOP), STR_BAD_BASE_LOCATION))


def playerBaseBuildEffects():
    @Name "SUB BASE BUILD EFFECTS"
    
    playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Color.YELLOW, eventPlayer, 10000)
    playEffect(eventPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.WHITE, eventPlayer.getPosition() + eventPlayer.getFacingDirection() * 1, 30)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.WHITE, eventPlayer.playerBaseLocation + vect(0, 0.5, 0), 7.5)


def baseUpgradeFail():
    @Name "SUB UPGRADE FAIL"
    
    playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 20)
    smallMessage(eventPlayer, "{0}{1}{0}".format(iconString(Icon.NO), STR_NOT_ENOUGH_GOLD))


def checkUpgradeAvailability():
    @Name "SUB SKIP TO AVAILABLE UPGRADE AFTER PURCHASE"
    
    if eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] > gameGoldVictory:
        eventPlayer.isUpgradeInputOnCooldown = true
        while eventPlayer.statsUpgradeCost[eventPlayer.upgradeCurrentSelection] > gameGoldVictory:
            if eventPlayer.upgradeCurrentSelection < len(eventPlayer.statsUpgradeCost) - 1:
                goto lbl_0
            eventPlayer.upgradeCurrentSelection = 0
            goto lbl_1
            lbl_0:
            eventPlayer.upgradeCurrentSelection += 1
            lbl_1:
        wait(0.25)
        eventPlayer.isUpgradeInputOnCooldown = false


rule "anti crash":
	@Event global
	@Condition not antiCrashActivated and getServerLoad() > 230
    wait(1, Wait.ABORT_WHEN_FALSE)
    smallMessage(getAllPlayers(), STR_ANTI_CRASH_ACTIVATED)
    setSlowMotion(10)
    antiCrashActivated = true

rule "disable anti crash":
	@Event global
	@Condition antiCrashActivated and getServerLoad() < 210
    setSlowMotion(100)
    antiCrashActivated = false

rule "failsafe":
    if not DEBUG_MODE and "a" == p"a":
        print("Warning: obfuscation is disabled!")
