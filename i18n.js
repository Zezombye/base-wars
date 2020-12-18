
/*console.log(VERSION);
console.log(GAMEMODE_CODE);
console.log(CREATION_DATE);*/

const translations = {

    AUTO_GOLD_MINER: {
        "en-US": "AUTO GOLD MINER",
        "pt-BR": "Gerador de ouro",
    },
    KILL_GOLD_BOUNTY: {
        "en-US": "KILL GOLD BOUNTY",
        "pt-BR": "Ouro por abate",
    },
    BASE_GOLD_STORAGE: {
        "en-US": "BASE GOLD STORAGE",
        "pt-BR": "Armazenamento da base",
    },
    MOVE_YOUR_BASE: {
        "en-US": "MOVE YOUR BASE",
        "pt-BR": "Mover base",
    },
    SWITCH_YOUR_HERO: {
        "en-US": "SWITCH YOUR HERO",
        "pt-BR": "Trocar de herói",
    },
    GOLD_STEAL_SPEED: {
        "en-US": "GOLD STEAL SPEED",
        "pt-BR": "Taxa de roubo de ouro",
    },
    BASE_ENTRY_TIME: {
        "en-US": "BASE ENTRY TIME",
        "pt-BR": "Tempo de entrada na base",
    },
    AUTO_GOLD_MINER_DESCRIPTION: {
        "en-US": "    [LVL {}]\n\n  Upgrades your gold generation\n    to {} per second. Can't generate\nwhen there are players in your base\n ",
        "pt-BR": "    [NV {}]\n\n       MELHORA A GERAÇÃO DE OURO\nPARA {} POR SEGUNDO. NÃO FUNCIONA\n    QUANDO HÁ JOGADORES NA BASE.\n ",
        format: "eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], eventPlayer.statsMoneySec + 1",
    },
    KILL_GOLD_BOUNTY_DESCRIPTION: {
        "en-US": "     [LVL {}]\n\n    Increases bounty from {} to {}\nAwarded by dealing finishing blow\n  Doesn't affect dropped loot orbs\n ",
        "pt-BR": "       [NV {}]\n\nAUMENTA A RECOMPENSA DE {} PARA {}\n          OBTIDO AO EFETUAR UM ABATE\n           NÃO AFETA ORBES DEIXADOS\n ",
        format: "eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], eventPlayer.statsMoneyKill, eventPlayer.statsMoneyKill + 15",
    },
    BASE_GOLD_STORAGE_DESCRIPTION: {
        "en-US": "[LVL {0}]\n\nIncreases the maximum amount \n  of gold your base can store.\n  Upgraded storage: {1} gold\n ",
        "pt-BR": "[NV {}]\n\n　　　　 Aumenta o máximo de ouro\n　　　 que a sua base pode armazenar.　　　 \n　　　　 Após melhoria: {} de ouro\n ",
        format: "eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], ceil(eventPlayer.statsMoneyStorage * 1.5)",
    },
    MOVE_YOUR_BASE_DESCRIPTION: {
        "en-US": "   [NO LVL]\n \n           Packs up your base. \nYou keep your gold & upgrades. \nPrice depends on gold storage.\n ",
        "pt-BR": "　　　　[SEM NV]\n\n　　　　 Empacota a sua base.\n　 Ouro e melhorias são mantidos.\nO preço depende do armazenamento.\n ",
    },
    SWITCH_YOUR_HERO_DESCRIPTION: {
        "en-US": " [NO LVL]\n \n     Takes you to hero selection.\n  Bug: If only one hero shows up\nWait 5 seconds until they appear.\n ",
        "pt-BR": "　　   [sem nv]\n\n　　　   Leva à seleção de heróis.\n        Bug: se apenas um herói aparecer\naguarde 5 segundos até o resto surgir.\n ",
    },
    GOLD_STEAL_SPEED_DESCRIPTION: {
        "en-US": "     [LVL {}]\n \n    Steal +2 gold/sec from bases.\nSame upgrade price as gold miner.\n  Total {} + enemy gold miner/sec.\n ",
        "pt-BR": "[NV {}]\n\n　　　  Roube +2 ouro/seg de bases.\n  　 Mesmo preço do gerador de ouro.　   \n　　   Total {} + gerador inimigo/seg.\n ",
        format: "eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], (eventPlayer.statsStealingSpeed + 1) * 2",
    },
    BASE_ENTRY_TIME_DESCRIPTION: {
        "en-US": "  [LVL {}]\n \n      Reduces the time it takes\nto enter your base by 0.5 sec.\n    The current delay is {} sec.\n ",
        "pt-BR": "[NV {}]\n\n　　　　     Reduz o tempo necessário\n  　　　para entrar na base por 0,5 seg.　　　  \n　　　　　   O tempo atual é {} seg.\n ",
        format: "eventPlayer.statsUpgradeLevels[eventPlayer.upgradeCurrentSelection], eventPlayer.statsBaseDelay",
    },
    AUTO_GOLD_MINER_WHITESPACE: {
        "en-US": "             ",
        "pt-BR": "              ",
    },
    KILL_GOLD_BOUNTY_WHITESPACE: {
        "en-US": "             ",
        "pt-BR": "            ",
    },
    BASE_GOLD_STORAGE_WHITESPACE: {
        "en-US": "               ",
        "pt-BR": "                     ",
    },
    MOVE_YOUR_BASE_WHITESPACE: {
        "en-US": "            ",
        "pt-BR": "        ",
    },
    SWITCH_YOUR_HERO_WHITESPACE: {
        "en-US": "              ",
        "pt-BR": "            ",
    },
    GOLD_STEAL_SPEED_WHITESPACE: {
        "en-US": "            ",
        "pt-BR": "                      ",
    },
    BASE_ENTRY_TIME_WHITESPACE: {
        "en-US": "           ",
        "pt-BR": "　　　　　  ",
    },
    NO_BASE_BUILT: {
        "en-US": "{0} NO BASE BUILT {0}\n  PRESS [{1}] TO BUILD",
        "pt-BR": "   {0} Base não construída {0}\nPressione [{1}] para construir",
        format: "iconString(Icon.WARNING), buttonString(Button.INTERACT)",
    },
    ENEMY_IN_BASE: {
        "en-US": "{0} ENEMY IN YOUR BASE! {0}",
        "pt-BR": "{0} Inimigo na sua base! {0}",
        format: "iconString(Icon.WARNING)",
    },
    WAITING_FOR_PLAYERS: {
        "en-US": "Waiting for players to start ({}/{})",
        "pt-BR": "Esperando jogadores para iniciar ({}/{})",
        format: "getNumberOfPlayers(Team.ALL), NB_PLAYERS_AUTO_START",
    },
    STARTING_GAME: {
        "en-US": "Starting the game...",
        "pt-BR": "Iniciando jogo...",
    },
    MAP_NOT_SUPPORTED: {
        "en-US": "The map {} IS NOT SUPPORTED!",
        "pt-BR": "O mapa {} não é compatível!",
        format: "getCurrentMap()",
    },
    BUILDING_NAVMESH: {
        "en-US": "Building the navmesh, please wait",
        "pt-BR": "Construindo a navmesh, aguarde",
    },
    GOLD_IN_BASE: {
        "en-US": "GOLD IN BASE",
        "pt-BR": "Ouro na base",
    },
    GOLD_PER_SEC: {
        "en-US": "+{}/sec",
        "pt-BR": "+{}/seg",
        format: "eventPlayer.statsMoneySec",
    },
    GOLD_ON_PLAYER: {
        "en-US": "GOLD ON PLAYER",
        "pt-BR": "Ouro no jogador",
    },
    FULL: {
        "en-US": "Full!",
        "pt-BR": "Cheio!",
    },
    HOLD_TO_STEAL: {
        "en-US": "HOLD {} TO STEAL {} GOLD: {}",
        "pt-BR": "Segure {} para roubar {} ouro: {}",
        format: "buttonString(Button.INTERACT), iconString(Icon.SKULL), eventPlayer.statsMoneyBase",
    },
    SCOREBOARD_TITLE: {
        "en-US": "            discord.gg/YP544CH | code: ##GAMEMODE_CODE##\nScoreboard    -    Base Wars ##VERSION## ##CREATION_DATE##",
        "pt-BR": "　　　　　 discord.gg/YP544CH | código: ##GAMEMODE_CODE##\n　　　 Placar    -    Guerra de Bases ##VERSION## ##CREATION_DATE##",
    },
    SCOREBOARD_TITLE_HIDDEN: {
        "en-US": "Scoreboard    -    Base Wars ##VERSION## ##CREATION_DATE##",
        "pt-BR": "　　　 Placar    -    Guerra de Bases ##VERSION## ##CREATION_DATE##",
    },
    SCOREBOARD_SUBTITLE: {
        "en-US": "FIRST TO {0} GOLD IN BASE WINS!\n",
        "pt-BR": "Vença ao obter {} de ouro na base!\n",
        format: "gameGoldVictory",
    },
    XXX_GOLD: {
        "en-US": " GOLD",
        "pt-BR": " de ouro",
    },
    ENTERING_BASE: {
        "en-US": "{0} ENTERING BASE {0} \n           IN {1} SEC",
        "pt-BR": "{0} Entrando na base {0} \n              em {1} seg",
        format: "iconString(Icon.WARNING), eventPlayer.baseProtectionTimer",
    },
    PROTECTED_AND_INVISIBLE: {
        "en-US": "         {0} PROTECTED AND INVISIBLE {0}\n\nTo upgrade, look at white center orb",
        "pt-BR": "{0} PROTEGIDO(A) E INVISÍVEL {0}\n\n  PARA APRIMORAR, OLHE PARA\n       O ORBE BRANCO CENTRAL",
        format: "iconString(Icon.CHECKMARK)",
    },
    CONTROLS: {
        "en-US": "Controls:",
        "pt-BR": "Controles:",
    },
    CONTROLS_CONTENT_1: {
        "en-US": "{}{} : navigate menu\n[{}]    : buy upgrade",
        "pt-BR": "{}{} : navegar pelo menu\n[{}]    : comprar melhoria",
        format: "buttonString(Button.PRIMARY_FIRE), buttonString(Button.SECONDARY_FIRE), buttonString(Button.INTERACT)",
    },
    CONTROLS_CONTENT_2: {
        "en-US": "[{}]   : use sparkbolt\n[{} {} remaining]",
        "pt-BR": "[{}]   : usar faísca\n[{} {} restando]",
        format: " buttonString(Button.ULTIMATE), eventPlayer.nbSparkbolts, iconString(Icon.BOLT)",
    },
    STEAL_RISK_BONUS: {
        "en-US": "+{} GOLD ({} risk bonus)",
        "pt-BR": "+{} de ouro ({} bônus de risco)",
        format: "eventPlayer.tmpStealingAmount, eventPlayer.tmpStealingRiskBonus",
    },
    STEAL_DISTANCE_BONUS: {
        "en-US": "+{} GOLD ({} distance bonus)",
        "pt-BR": "+{} de ouro ({} bônus de distância)",
        format: "eventPlayer.tmpStealingAmount, eventPlayer.tmpStealingDistanceBonus",
    },
    STEAL_RISK_DISTANCE_BONUS: {
        "en-US": "+{} GOLD ({} distance bonus, {} risk bonus)",
        "pt-BR": "+{} de ouro ({} bônus de distância, {} bônus de risco)",
        format: "eventPlayer.tmpStealingAmount, eventPlayer.tmpStealingDistanceBonus, eventPlayer.tmpStealingRiskBonus",
    },
    MORE_GOLD_SEC: {
        "en-US": " +1 GOLD/SEC ",
        "pt-BR": " +1 ouro/seg ",
    },
    MORE_KILL_BOUNTY: {
        "en-US": " +15 KILL BOUNTY ",
        "pt-BR": " +15 recompensa de abate ",
    },
    XXX_GOLD_KILL: {
        "en-US": " GOLD (kill)",
        "pt-BR": " ouro (abate)",
    },
    XXX_GOLD_CAPACITY: {
        "en-US": " GOLD CAPACITY ",
        "pt-BR": " capacidade de ouro ",
    },
    PACKED_UP_BASE: {
        "en-US": " PACKED UP BASE ",
        "pt-BR": " Base empacotada ",
    },
    MORE_GOLD_STEAL_SEC: {
        "en-US": " +2 GOLD STEAL/SEC  ",
        "pt-BR": " +2 ouro roubado/seg ",
    },
    LESS_ENTER_DELAY: {
        "en-US": " -0.5 SEC DELAY ",
        "pt-BR": " -0,5 seg de intervalo ",
    },
    TOO_FAR_AWAY: {
        "en-US": "TOO FAR AWAY",
        "pt-BR": "Muito longe",
    },
    AIM_AT_ENEMY: {
        "en-US": "AIM AT ENEMY",
        "pt-BR": "Mire no inimigo",
    },
    STORED_GOLD_IN_BASE: {
        "en-US": "STORED {} GOLD IN BASE",
        "pt-BR": "{} de ouro armazenado",
        format: "eventPlayer.tmpMoneyDifference",
    },
    ENEMY_BASE_TOO_CLOSE: {
        "en-US": " ENEMY BASE TOO CLOSE ",
        "pt-BR": " Base inimiga muito próxima ",
    },
    BAD_BASE_LOCATION: {
        "en-US": " BAD BASE LOCATION ",
        "pt-BR": " Local de base inválido ",
    },
    NOT_ENOUGH_GOLD: {
        "en-US": " NOT ENOUGH GOLD IN BASE ",
        "pt-BR": " Ouro da base insuficiente ",
    },
    ANTI_CRASH_ACTIVATED: {
        "en-US": "Anti-crash system activated",
        "pt-BR": "Sistema anti-travamento ativado",
    },
    XXX_PLAYER_GOLD: {
        "en-US": " PLAYER GOLD",
        "pt-BR": " ouro do jogador",
    },
    XXX_SPARKBOLT: {
        "en-US": " SPARKBOLT",
        "pt-BR": " faísca",
    },
    HAS_WON_GAME: {
        "en-US": " has won the game",
        "pt-BR": " venceu o jogo",
    },
    WINNER: {
        "en-US": "Winner",
        "pt-BR": "Vencedor",
    },
    BOUNTY_HUNTER: {
        "en-US": " Bounty Hunter",
        "pt-BR": " Caçador de recompensas",
    },
    ASSASSIN: {
        "en-US": " Assassin",
        "pt-BR": " Assassino",
    },
    VICTIM: {
        "en-US": " Victim",
        "pt-BR": " Vítima",
    },
    GOLD_HOARDER: {
        "en-US": " Gold Hoarder",
        "pt-BR": " Acumulador de ouro",
    },
    MASTER_THIEF: {
        "en-US": " Master Thief",
        "pt-BR": " Ladrão mestre",
    },
    FAST_EARNER: {
        "en-US": " Fast Earner",
        "pt-BR": " Acumulador rápido",
    },
    FRIENDLY_FARMER: {
        "en-US": " Friendly Farmer",
        "pt-BR": " Acumulador amigável",
    },
    COOKIE_CLICKER: {
        "en-US": " Cookie Clicker",
        "pt-BR": " Cookie clicker",
    },
    ENGINEER: {
        "en-US": " Engineer",
        "pt-BR": " Engenheiro",
    },
    TRAVELER: {
        "en-US": " Traveler",
        "pt-BR": " Nômade",
    },
    BOUNTY_HUNTER_WHITESPACE: {
        "en-US": "                                                                          ",
        "pt-BR": "",
    },
    ASSASSIN_WHITESPACE: {
        "en-US": "                                                             ",
        "pt-BR": "",
    },
    VICTIM_WHITESPACE: {
        "en-US": "                                                        ",
        "pt-BR": "",
    },
    GOLD_HOARDER_WHITESPACE: {
        "en-US": "                                                                          ",
        "pt-BR": "",
    },
    MASTER_THIEF_WHITESPACE: {
        "en-US": "                                                                     ",
        "pt-BR": "",
    },
    FAST_EARNER_WHITESPACE: {
        "en-US": "                                                                     ",
        "pt-BR": "",
    },
    FRIENDLY_FARMER_WHITESPACE: {
        "en-US": "                                                                               ",
        "pt-BR": "",
    },
    COOKIE_CLICKER_WHITESPACE: {
        "en-US": "                                                                           ",
        "pt-BR": "",
    },
    ENGINEER_WHITESPACE: {
        "en-US": "                                                                ",
        "pt-BR": "",
    },
    TRAVELER_WHITESPACE: {
        "en-US": "                                                                ",
        "pt-BR": "",
    },
    BOUNTY_HUNTER_DESC: {
        "en-US": " kills",
        "pt-BR": " abates",
    },
    ASSASSIN_DESC: {
        "en-US": " K/D",
        "pt-BR": " A/M",
    },
    VICTIM_DESC: {
        "en-US": " gold stolen from",
        "pt-BR": " ouro roubado de",
    },
    GOLD_HOARDER_DESC: {
        "en-US": " gold earned",
        "pt-BR": " ouro obtido",
    },
    MASTER_THIEF_DESC: {
        "en-US": " gold stolen",
        "pt-BR": " ouro roubado",
    },
    FAST_EARNER_DESC: {
        "en-US": " gold/sec",
        "pt-BR": " ouro/seg",
    },
    FRIENDLY_FARMER_DESC: {
        "en-US": " gold/kills",
        "pt-BR": " ouro/abates",
    },
    COOKIE_CLICKER_DESC: {
        "en-US": " orbs collected",
        "pt-BR": " orbes coletados",
    },
    ENGINEER_DESC: {
        "en-US": " upgrades",
        "pt-BR": " melhorias",
    },
    TRAVELER_DESC: {
        "en-US": " bases moved",
        "pt-BR": " bases movidas",
    },
    YOUR_BASE: {
        "en-US": " Your base",
        "pt-BR": " Sua base",
    },
    /*XXXXX: {
        "en-US": "",
        "fr-FR": ""
    },*/

}

const availableLanguages = ["en-US", "pt-BR"]


//check if we put a language that isn't available
/*for (var key in translations) {
    if (!availableLanguages.includes(key)) {
        throw new Error("Language '"+key+"' is invalid");
    }
}*/

result = "";
for (var translation in translations) {

    //check if all languages are here
    for (var lang of availableLanguages) {
        if (translations[translation][lang] === undefined) {
            throw new Error("Missing language '"+lang+"' for translation '"+translation+"'");
        }
    }

    console.log(translations[translation].format)
    result += "#!define STR_"+translation+" ["+availableLanguages.map(x => JSON.stringify(translations[translation][x]).replace(/##(\w+)##/g, '"$1"') + (translations[translation].format ? ".format("+translations[translation].format+")" : ""))+'][max(false, practiceRangeTranslations.index("{0}".format(Map.PRACTICE_RANGE)))]\n';
}

result
