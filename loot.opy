#!mainFile "base_wars.opy"

globalvar lootArrayLocations = []
globalvar lootSpawnPoints = []
globalvar lootArrayLocationsStored
globalvar lootSpread
globalvar lootCollectIterator
globalvar lootArraySpawned
globalvar lootSpawnpointIterator
globalvar lootSpawnerIterator
globalvar lootSpawnerNumLoot
globalvar lootSpawnerEffectIterator
globalvar tmpLootSpawnpointRandomPointWP
globalvar tmpLootCollectClosestPlayer
globalvar tmpLootSpawnpoint
globalvar tmpLootSpawnpointProximity
globalvar tmpLootSpawnpointRandomPoint
globalvar lootBlockerVolumePos
#globalvar lootPossiblePlayers

/*
rule "LOOT UPDATE PLAYERS ADD":
    @Event eachPlayer
    @Hero all
    @Condition hasGameStarted
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.isInBase == false
    @Condition eventPlayer.hasSpawned()
    @Condition (enableInvisibleLootPickup or not eventPlayer.isCloaked)
    
    if eventPlayer in lootPossiblePlayers:
        return
    lootPossiblePlayers.append(eventPlayer)


rule "LOOT UPDATE PLAYERS REMOVE":
    @Event eachPlayer
    @Hero all
    @Condition hasGameStarted
    @Condition (any([eventPlayer.isDead(), eventPlayer.isInBase, not eventPlayer.hasSpawned(), not (enableInvisibleLootPickup and eventPlayer.isCloaked)]))
    
    lootPossiblePlayers.remove(eventPlayer)
*/

rule "LOOT BOUNTY COLLECT LOOP":
    @Condition hasGameStarted
    @Condition bountyArrayNum != 0
    
    for bountyArrayIterator in range(len(bountyArrayLocations)):
        if bountyArrayEffects[bountyArrayIterator] != null:
            tmpBountyLocation = bountyArrayLocations[bountyArrayIterator]
            tmpBountyClosestPlayer = sorted([player for player in getAllPlayers() if player.isAlive() and player.hasSpawned() and not player.isInBase and (enableInvisibleLootPickup or not player.isCloaked)], lambda player: distance(player.getPosition(), tmpBountyLocation))[0]

            if entityExists(tmpBountyClosestPlayer) and distance(tmpBountyClosestPlayer.getPosition(), tmpBountyLocation) <= 2.5:
                tmpBountyClosestPlayer.statsMoney += bountyArrayMoney[bountyArrayIterator]
                tmpBountyClosestPlayer.scoreArray[Score.GOLD_EARNED] += bountyArrayMoney[bountyArrayIterator]
                tmpBountyClosestPlayer.scoreArray[Score.NB_ORBS_COLLECTED]++
                destroyEffect(bountyArrayEffects[bountyArrayIterator])
                bountyArrayNum -= 1
                bountyArrayEffects[bountyArrayIterator] = null
                playEffect(tmpBountyClosestPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, tmpBountyLocation, 50)
                smallMessage(tmpBountyClosestPlayer, "+{}{}".format(evalOnce(bountyArrayMoney[bountyArrayIterator]), STR_XXX_PLAYER_GOLD))

                if bountyArrayMoney[bountyArrayIterator] <= 25:
                    playEffect(tmpBountyClosestPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.GREEN, tmpBountyLocation, 1)
                elif bountyArrayMoney[bountyArrayIterator] > 25 and bountyArrayMoney[bountyArrayIterator] <= 250:
                    playEffect(tmpBountyClosestPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.TURQUOISE, tmpBountyLocation, 1)
                elif bountyArrayMoney[bountyArrayIterator] > 250 and bountyArrayMoney[bountyArrayIterator] <= 750:
                    playEffect(tmpBountyClosestPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.BLUE, tmpBountyLocation, 1)
                else:
                    playEffect(tmpBountyClosestPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.PURPLE, tmpBountyLocation, 1)
                wait(0.032)
            wait(0.032)
    wait(0.1)
    if RULE_CONDITION:
        goto RULE_START


rule "LOOT FIND SPAWNPOINTS":
    @Condition hasGameStarted
    
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
    @Condition hasGameStarted
    @Condition lootArrayLocations != []
    @Condition enableLootOrbs
    
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
    @Condition hasGameStarted
    @Condition len(lootArrayLocations) != 0
    @Condition lootSpawnerNumLoot < lootSpawnMax
    @Condition enableLootOrbs
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
    if lootSpawnerIterator >= len(lootSpawnPoints):
        lootSpawnerIterator = 0
    wait(1.12)
    if RULE_CONDITION:
        goto RULE_START


rule "LOOT COLLECT LOOP":
    @Condition hasGameStarted
    @Condition enableLootOrbs
    
    do:
        for lootCollectIterator in range(len(lootArrayLocations)):
            if lootArraySpawned[lootCollectIterator]:
                tmpLootCollectClosestPlayer = sorted([player for player in getAllPlayers() if player.isAlive() and player.hasSpawned() and not player.isInBase and (enableInvisibleLootPickup or not player.isCloaked)], lambda player: distance(player.getPosition(), lootArrayLocations[lootCollectIterator]))[0]
                if entityExists(tmpLootCollectClosestPlayer) and distance(tmpLootCollectClosestPlayer, lootArrayLocations[lootCollectIterator]) <= 2.5:
                    lootArrayLocationsStored[lootCollectIterator] = lootArrayLocations[lootCollectIterator]
                    lootSpawnerNumLoot -= 1
                    playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.GREEN, lootArrayLocationsStored[lootCollectIterator], 1)
                    playEffect(tmpLootCollectClosestPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, lootArrayLocationsStored[lootCollectIterator], 50)
                    lootArrayLocations[lootCollectIterator] = vect(0, -9999, 0)
                    lootArraySpawned[lootCollectIterator] = false
                    tmpLootCollectClosestPlayer.statsMoney += gameLootOrbAmount
                    tmpLootCollectClosestPlayer.scoreArray[2] += gameLootOrbAmount
                    tmpLootCollectClosestPlayer.scoreArray[Score.NB_ORBS_COLLECTED] += 1
                    smallMessage(tmpLootCollectClosestPlayer, "+{}{}".format(gameLootOrbAmount, STR_XXX_GOLD))
            wait()
        wait(0.1)
    while true


rule "LOOT LOSS1":
    @Event playerDied
    @Hero all
    @Condition attacker == victim
    @Condition hasGameStarted
    
    eventPlayer.statsMoney = 0


rule "LOOT LOSS2":
    @Event playerDied
    @Hero all
    @Condition hasGameStarted
    
    destroyHudText(eventPlayer.hudBaseProtection)


rule "LOOT POWERUP COLLECT LOOP":
    @Condition sparkboltPickupPos != null
    @Condition enableSparkbolts
    
    do:
        tmpSparkboltClosestPlayer = sorted([player for player in getAllPlayers() if player.isAlive() and player.hasSpawned() and not player.isInBase and (enableInvisibleLootPickup or not player.isCloaked)], lambda player: distance(player.getPosition(), sparkboltPickupPos))[0]
        if entityExists(tmpSparkboltClosestPlayer) and distance(tmpSparkboltClosestPlayer.getPosition(), sparkboltPickupPos) <= 2.5:
            tmpSparkboltClosestPlayer.nbSparkbolts += 1
            smallMessage(tmpSparkboltClosestPlayer, "+1 {}{}".format(iconString(Icon.BOLT), STR_XXX_SPARKBOLT))
            destroyEffect(sparkboltEffects[0])
            destroyEffect(sparkboltEffects[1])
            playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.WHITE, sparkboltPickupPos, 1)
            playEffect(tmpSparkboltClosestPlayer, DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, sparkboltPickupPos, 50)
            sparkboltPickupPos = null
            sparkboltSpawnpointIndex = (sparkboltSpawnpointIndex + 1) % len(lootSpawnPoints)
        wait(0.25)
    while RULE_CONDITION


rule "LOOT POWERUP SPAWN":
    @Condition hasGameStarted
    @Condition sparkboltPickupPos == null
    @Condition enableSparkbolts
    
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

