MPR = CreateFrame("frame","MPRFrame")
MPR.Version = "v2.96"
MPR.VersionNotes = {"Added Offensives and Other Spells setting", "Added some tooltips in the options", "Fixed some smaller issues"}
local ClassColors = {["DEATHKNIGHT"] = "C41F3B", ["DEATH KNIGHT"] = "C41F3B", ["DRUID"] = "FF7D0A", ["HUNTER"] = "ABD473", ["MAGE"] = "69CCF0", ["PALADIN"] = "F58CBA",
    ["PRIEST"] = "FFFFFF", ["ROGUE"] = "FFF569", ["SHAMAN"] = "0070DE", ["WARLOCK"] = "9482C9", ["WARRIOR"] = "C79C6E"}
local InstanceShortNames = {["Icecrown Citadel"] = "ICC", ["Vault of Archavon"] = "VOA", ["Trial of the Crusader"] = "TOC", ["Naxxramas"] = "NAXX", ["The Ruby Sanctum"] = "RS"}
local mprCommands = {"Commands - /MPR HELP, /MPR CMD, /MPR COMMANDS", "Options - /MPR", "Aura Info - /MPR AI, /MPR AI <bossnum>", "Ignore Dispels - /MPR D, /MPR DISPELS", "Timers - /MPR T, /MPR TIMERS", "Timer Options - /MPR TO", "DKP Penalties - /MPR DKP, /MPR PENALTIES", "Clear Combat Log - /MPR CCL, /MPR CLEAR", "Clear MPR Death Log - /MPR CDL"}
MPR.BossData = {
    -- Icecrown Citadel
    [0] = {["ENCOUNTER"] = "N/a", ["MSG_START"] = nil, ["MSG_FINISH"] = nil},
    [1] = {
        ["ENCOUNTER"] = "Lord Marrowgar",
        ["MSG_START"] = "The Scourge will wash over this world as a swarm of death and destruction!",
        ["MSG_FINISH"] = "I see... only darkness...",
        ["BERSERK"] = 600,
    },
    [2] = {
        ["ENCOUNTER"] = "Lady Deathwhisper",
        ["MSG_START"] = "What is this disturbance?! You dare trespass upon this hallowed ground? This shall be your final resting place.",
        ["MSG_FINISH"] = "All part of the masters plan! Your end is... inevitable!",
        ["BERSERK"] = 600,
    },
    [3] = {
        ["ENCOUNTER"] = "Gunship Battle",
        ["MSG_START"] = "Fire up the engines! We got a meetin' with destiny, lads!",
        ["MSG_START_2"] = "Rise up, sons and daughters of the Horde! Today we battle a hated enemy of the Horde! LOK'TAR OGAR! Kor'kron, take us out!",
        ["MSG_FINISH"] = "Damage control! Put those fires out! You haven't seen the last of the Horde!",
        ["MSG_FINISH_2"] = "The Alliance falter. Onward to the Lich King!",
    },
    [4] = {
        ["ENCOUNTER"] = "Deathbringer Saurfang",
        ["MSG_START"] = "BY THE MIGHT OF THE LICH KING!",
        ["MSG_FINISH"] = "I... Am... Released.",
        ["BERSERK"] = 480,
        ["BERSERK_HC"] = 360,
    },
    [5] = {
        ["ENCOUNTER"] = "Festergut",
        ["MSG_START"] = "Fun time!",
        ["MSG_FINISH"] = "Da ... Ddy...",
        ["BERSERK"] = 300,
    },
    [6] = {
        ["ENCOUNTER"] = "Rotface",
        ["MSG_START"] = "Great news, everyone! The slime is flowing again!",
        ["MSG_FINISH"] = "Bad news daddy...",
        ["START_DELAY"] = -3,
    },
    [7] = {
        ["ENCOUNTER"] = "Professor Putricide",
        ["MSG_START"] = "Good news, everyone! I think I perfected a plague that will destroy all life on Azeroth!",
        ["MSG_FINISH"] = "Bad news, everyone! I don't think I'm going to make it.",
        ["BERSERK"] = 600,
    },
    [8] = {
        ["ENCOUNTER"] = "Blood Prince Council",
        ["MSG_START"] = "Naxxanar was merely a setback! With the power of the orb, Valanar will have his vengeance!",
        ["MSG_FINISH"] = "...why...?",
        ["BERSERK"] = 600,
    },
    [9] = {
        ["ENCOUNTER"] = "Blood Queen Lana'thel",
        ["MSG_START"] = "Can you handle this?", -- "You have made an... unwise... decision." not used on Molten?
        ["MSG_FINISH"] = "But... we were getting along... so well...",
        ["START_DELAY"] = -15,
        ["BERSERK"] = 330,
    },
    [10] = {
        ["ENCOUNTER"] = "Valithria Dreamwalker",
        ["MSG_START"] = "Heroes, lend me your aid! I... I cannot hold them off much longer! You must heal my wounds!",
        ["BERSERK_HC"] = 420,
    },
    [11] = {
        ["ENCOUNTER"] = "Sindragosa",
        ["MSG_START"] = "You are fools to have come to this place! The icy winds of Northrend will consume your souls!",
        ["MSG_FINISH"] = "Free...at last...",
        ["BERSERK"] = 600,
    },
    [12] = {
        ["ENCOUNTER"] = "The Lich King",
        ["MSG_START"] = "I'll keep you alive to witness the end, Fordring. I would not want the Light's greatest champion to miss seeing this wretched world remade in my image.",
        ["MSG_FINISH"] = nil,
        ["BERSERK"] = 900,
    },
    -- Trial of the Crusader
    [13] = {
        ["ENCOUNTER"] = "Gormok the Impaler",
        ["MSG_START"] = "Hailing from the deepest, darkest carverns of the storm peaks, Gormok the Impaler! Battle on, heroes!",
        ["MSG_FINISH"] = "Steel yourselves, heroes, for the twin terrors Acidmaw and Dreadscale. Enter the arena!",
    },
    [14] = {
        ["ENCOUNTER"] = "Jormungar Twins",
        ["MSG_START"] = "Steel yourselves, heroes, for the twin terrors Acidmaw and Dreadscale. Enter the arena!",
        ["MSG_FINISH"] = "The air freezes with the introduction of our next combatant, Icehowl! Kill or be killed, champions!",
    },
    [15] = {
        ["ENCOUNTER"] = "Icehowl",
        ["MSG_START"] = "The air freezes with the introduction of our next combatant, Icehowl! Kill or be killed, champions!",
        ["MSG_FINISH"] = nil,
    },
    [16] = {
        ["ENCOUNTER"] = "Lord Jaraxxus",
        ["MSG_START"] = "You face Jaraxxus, eredar lord of the Burning Legion!", "Another will take my place. Your world is doomed.",
        ["MSG_FINISH"] = nil,
    },
    [17] = {
        ["ENCOUNTER"] = "Faction Champions",
        ["MSG_START"] = "GLORY OF THE ALLIANCE!",
        ["MSG_FINISH"] = "A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death.",
    },
    [18] = {
        ["ENCOUNTER"] = "Val'kyr Twins",
        ["MSG_START"] = "In the name of our dark master. For the Lich King. You. Will. Die.",
        ["MSG_FINISH"] = "The Scourge cannot be stopped...",
    },
    [19] = {
        ["ENCOUNTER"] = "Anub'arak",
        ["MSG_START"] = "Ahhh, our guests have arrived, just as the master promised.",
        ["MSG_FINISH"] = nil,
    },
    -- Ruby Sanctum
    [20] = {
        ["ENCOUNTER"] = "Saviana Ragefire",
        ["MSG_START"] = "You will sssuffer for this intrusion!",
        ["MSG_FINISH"] = nil,
    },
    [21] = {
        ["ENCOUNTER"] = "Baltharus the Warborn",
        ["MSG_START"] = "Ah, the entertainment has arrived.",
        ["MSG_FINISH"] = "I... Didn't see that coming...",
    },
    [22] = {
        ["ENCOUNTER"] = "General Zarithrian",
        ["MSG_START"] = "Alexstrasza has chosen capable allies... A pity that I must END YOU!",
        ["MSG_FINISH"] = "HALION! I...",
    },
    [23] = {
        ["ENCOUNTER"] = "Halion",
        ["MSG_START"] = "Your world teeters on the brink of annihilation. You will ALL bear witness to the coming of a new age of DESTRUCTION!",
        ["MSG_FINISH"] = "Relish this victory, mortals, for it will be your last. This world will burn with the master's return!",
        ["BERSERK"] = 480,
    },
}
local BossNames = {}
local ChestLoot = {
    ["Gunship Armory"] = {
        "Frost Giant's Cleaver", "Midnight Sun", "Muradin's Spyglass", "Neverending Winter", "Pauldrons of Lost Hope", "Bone Drake's Enameled Boots", "Icecrown Rampart Bracers", "Saronite Gargoyle Cloak", "Ice-Reinforced Vrykul Helm", "Bracers of Pale Illumination", "Abomination's Bloody Ring", "Cord of Dark Suffering",
        "Corpse Tongue Coin", "Ring of Rapid Ascent", "Amulet of the Silent Eulogy", "Althor's Abacus", "Ikfirus' Sack of Wonder", "Gunship Captain's Mittens", "Shadowvault Slayer's Cloak", "Boots of Unnatural Growth", "Scourgeborne Waraxe", "Skeleton Lord's Circle", "Shadowfrost Shard", "Polar Bear Claw Bracers", "Scourge Hunter's Vambraces", "Boneguard Commander's Pauldrons", "Corp'rethar Ceremonial Crown", "Waistband of Righteous Fury",
    },
    ["Deathbringer's Cache"] = {
        "Ramaladni's Blade of Culling", "Mag'hari Chieftain's Staff", "Soulcleave Pendant", "Saurfang's Cold-Forged Band", "Icecrown Spire Sandals", "Scourge Stranglers", "Hauberk of a Thousand Cuts", "Blade-Scored Carapace", "Deathforged Legplates", "Leggings of Unrelenting Blood", "Thaumaturge's Crackling Cowl", "Gargoyle Spit Bracers",
        "Deathbringer's Will", "Bloodvenom Blade", "Toskk's Maximized Wristguards", "Belt of the Blood Nova", "Greatcloak of the Turned Champion",
    },
    ["Cache of the Dreamwalker"] = {
        "Oxheart", "Lich Wrappings", "Sister Svalna's Aether Staff", "Skinned Whelp Shoulders", "Taiga Bindings", "Dreamhunter's Carbine", "Emerald Saint's Spaulders", "Legguards of the Twisted Dream", "Stormbringer Gloves", "Sister Svalna's Spangenhelm", "Leggings of the Refracted Mind", "Ironrope Belt of Ymirjar",
        "Frostbinder's Shredded Cape", "Scourge Reaver's Legplates", "Coldwraith Links", "Lungbreaker", "Noose of Malachite", "Frostbrood Sapphire Ring", "Primordial Saronite", "Robe of the Waking Nightmare", "Nightmare Ender", "Snowstorm Helm", "Grinning Skull Greatboots", "Shadowfrost Shard", "Anub'ar Stalker's Gloves", "Devium's Eternally Cold Ring", "Leggings of Dying Candles", "Boots of the Funeral March", "Bracers of Eternal Dreaming",
    },
}
local EncounterStartYells = {}
local EncounterDoneYells = {}
local EncounterNames = {}
local BossYells = {
    ["Watch as the world around you collapses!"]        = "Quake! Run inside!!",
    ["The heavens burn!"]                               = "Meteor Strike in 7 sec. Run to the other side!",
    ["Beware the shadow!"]                              = "Twilight Cutter in 5 sec. Watch orbs!",
    ["I think I made an angry poo-poo. It gonna blow!"] = "OOZE EXPLOSION! Run away!!",
    ["We're taking hull damage, get a battle-mage out here to shut down those cannons!"] = "MAGE SPAWNED!!",
    ["We're taking hull damage, get a sorcerer out here to shut down those cannons!"] = "MAGE SPAWNED!!",
    ["Enough! I see I must take matters into my own hands!"] = "PHASED! Hunter's MD!", -- Mana Shield LDW drops.
    ["You are weak, powerless to resist my will!"] = "MC! Druid's Cyclone!", -- MC's Lady DW
    ["Feast, my minions!"] = "Blood Beasts! Kill them!", -- Bloodbeast Spawn DBS
    ["Two oozes, one room! So many delightful possibilities..."] = "Transition! Stack and check Variable!", -- Transition PP
    ["I have opened a portal into the Dream. Your salvation lies within, heroes."] = "Portals!", -- Portals Open @ VDW
    ["Now feel my master's limitless power and despair!"] = "Phase 2! Watch your stacks!", -- P2 Sindragosa
    ["Suffer, mortals, as your pathetic magic betrays you!"] = "Unchained! Watch it!", -- Unchained Magic Sindragosa
    ["I am the light and the darkness! Cower, mortals, before the herald of Deathwing!"] = "Phase 3! Go out!", -- Halion P3
    ["Such wondrous power! The Darkfallen Orb has made me INVINCIBLE!"] = "Empowered Keleseth!! DPS him!!", -- Empowered Keleserth
    ["Tremble before Taldaram, mortals, for the power of the orb flows through me!"] = "Empowered Taldaram!! DPS him!!", -- Empowered Taldaram
    ["Naxxanar was merely a setback! With the power of the orb, Valanar will have his vengeance!"] = "Empowered Valanar!! DPS him!!", -- Empowered Valanar
    ["Val'kyr, your master calls!"] = "Val'Kyr's!! Stack!!", -- Val'Kyr's at LK
}
local BossRaidYells = {
    ["I think I made an angry poo-poo. It gonna blow!"]                                  = "Ooze Explosion in 4 sec. Run away!!",
    ["We're taking hull damage, get a battle-mage out here to shut down those cannons!"] = "MAGE SPAWNED on Horde ship! Kill him!!",
    ["We're taking hull damage, get a sorcerer out here to shut down those cannons!"]    = "MAGE SPAWNED on Alliance ship! Kill him!!",
}
local RaidDifficulty = {[1] = "10n",[2] = "25n",[3] = "10h",[4] = "25h"}

local ClassBIS = {
    --    ["Class"] = {
    --        ["Spec1"] = {ItemName1, ItemName2, ItemName3},
    --        ["Spec2"] = {...},
    --        ["Spec3"] = {...},
    --    },
    ["Paladin"] = {
        ["Retribution"] = {"Penumbra Pendant", "Shadowvault Slayer's Cloak", "Umbrage Armbands", "Fleshrending Gauntlets", "Astrylian's Sutured Cinch", "Apocalypse's Advance", "Signet of Twilight", "Sharpened Twilight Scale", "Tiny Abomination in a Jar", "Oathbinder, Charge of the Ranger-General"},
        ["Holy"] = {"Blood Queen's Crimson Choker", "Cloak of Burning Dusk", "Rot-Resistant Breastplate", "Bracers of Fiery Night", "Fallen Lord's Handguards", "Split Shape Belt", "Plaguebringer's Stained Pants", "Foreshadow Steps", "Ring of Rapid Ascent", "Ring of Phased Regeneration","Solace of the Fallen", "Solace of the Defeated", "Glowing Twilight Scale", "Bulwark of Smouldering Steel", "Bloodsurge, Kel'Thuzad's Blade of Agony"},
        ["Protection"] = {"Broken Ram Skull Helm", "Bile-Encrusted Medallion", "Boneguard Commander's Pauldrons", "Royal Crimson Cloak", "Bracers of Dark Reckoning", "Belt of Broken Bones", "Legguards of Lost Hope", "Treads of Impending Ressurection", "Juggernaut Band", "Devium's Eternally Cold Ring", "Satrina's Impeding Scarab", "Juggernaut's Vitality", "Sindragosa's Flawless Fang", "Mithrios, Bronzebeard's Legacy", "Icecrown Glacial Wall"},
        ["Protection Armor"] = {"Bile-Encrusted Medallion", "Gargoyle Spit Bracers", "Juggernaut Band", "Devium's Eternally Cold Ring", "Treads of Impending Ressurection", "Sindragosa's Flawless Fang", "Petrified Twilight Scale", "Mithrios, Bronzebeard's Legacy", "Icecrown Glacial Wall"}
    },
    ["Priest"] = {
        ["Shadow"] = {"Amulet of the Silent Eulogy", "Cloak of Burning Dusk", "Bracers of Fiery Night", "Crushing Coldwraith Belt", "Plaguebringer's Stained Pants", "Plague Scientist's Boots", "Ring of Rapid Ascent", "Charred Twilight Scale", "Phylactery of the Nameless Lich", "Royal Scepter of Terenas II", "Shadow Silk Spindle", "Corpse-Impaling Spike"},
        ["Holy"] = {"Sentinel's Amulet", "Greatcloak of the Turned Champion", "Sanguine Silk Robes", "Bracers of Fiery Night", "Crushing Coldwraith Belt", "Plague Scientist's Boots", "Memory of Malygos", "Ring of Phased Regeneration", "Solace of the Fallen", "Solace of the Defeated", "Althor's Abacus", "Glowing Twilight Scale", "Royal Scepter of Terenas II", "Sundial of Eternal Dusk", "Corpse-Impaling Spike"},
        ["Discipline"] = {"Holiday's Grace", "Cloak of Burning Dusk", "Bracers of Fiery Night", "San'layn Ritualist Gloves", "Lingering Illness", "Plague Scientist's Boots", "Ring of Maddening Whispers", "Incarnadine Band of Mending", "Solace of the Fallen", "Solace of the Defeated", "Althor's Abacus", "Glowing Twilight Scale", "Royal Scepter of Terenas II", "Shadow Silk Spindle", "Nightmare Ender"},
    },
    ["Rogue"] = {
        ["Assassination"] = {"Sindragosa's Cruel Claw", "Shadowvault Slayer's Cloak", "Ikfirus' Sack of Wonder", "Umbrage Armbands", "Astrylian's Sutured Cinch", "Frostbitten Fur Boots", "Signet of Twilight", "Sharpened Twilight Scale", "Heaven's Fall, Kryss of a Thousand Lies", "Lungbreaker", "Gluth's Fetching Knife"},
        ["Combat"] = {"Sindragosa's Cruel Claw", "Sylvanas' Cunning", "Vereesa's Dexterity", "Ikfirus' Sack of Wonder", "Toskk's Maximized Wristguards", "Aldriana's Gloves of Secrecy", "Astrylian's Sutured Cinch", "Gangrenous Leggings", "Frostbitten Fur Boots", "Frostbrood Sapphire Ring", "Deathbringer's Will", "Sharpened Twilight Scale", "Havoc's Call, Blade of Lordaeron Kings", "Scourgeborne Waraxe", "Fal'inrush, Defender of Quel'Thalas"},
    },
    ["Shaman"] = {
        ["Restoration"] = {"Blood Queen's Crimson Choker", "Cloak of Burning Dusk", "Phaseshifter's Bracers", "Changeling Gloves", "Split Shape Belt", "Plague Scientist's Boots", "Ring of Rapid Ascent", "Ring of Phased Regeneration", "Solace of the Fallen", "Solace of the Defeated", "Glowing Twilight Scale", "Royal Scepter of Terenas II", "Bulwark of Smouldering Steel"},
        ["Enhancement"] = {"Precious' Putrid Collar", "Shadowvault Slayer's Cloak", "Umbrage Armbands", "Anub'ar Stalker's Gloves", "Nerub'ar Stalker's Cord", "Returning Footfalls", "Band of the Bone Colossus", "Sharpened Twilight Scale", "Havoc's Call, Blade of Lordaeron Kings"},
        ["Elemental"] = {"Amulet of the Silent Eulogy", "Cloak of Burning Dusk", "Bracers of Fiery Night", "Split Shape Belt", "Plaguebringer's Stained Pants", "Plague Scientists Boots", "Ring of Rapid Ascent", "Phylactery of the Nameless Lich", "Charred Twilight Scale", "Royal Scepter of Terenas II", "Bulwark of Smouldering Steel"},
    },
    ["Druid"] = {
        ["Restoration"] = {"Bone Sentinel's Amulet", "Greatcloak of the Turned Champion", "Sanguine Silk Robes", "Phaseshifter's Bracers", "Professor's Bloodied Smock", "Plague Scientist's Boots", "Memory of Malygos", "Ring of Phased Regeneration", "Althor's Abacus", "Glowing Twilight Scale", "Royal Scepter of Terenas II", "Sundial of Eternal Dusk"},
        ["Feral-D."] = {"Sindragosa's Cruel Claw", "Shadowvault Slayer's Cloak", "Toskk's Maximized Wristguards", "Aldriana's Gloves of Secrecy", "Astrylian's Sutured Cinch", "Frostbitten Fur Boots", "Signet of Twilight", "Frostbrood Sapphire Ring", "Deathbringer's Will", "Sharpened Twilight Scale", "Oathbinder, Charge of the Ranger-General"},
        ["Feral-T."] = {"Bile-Encrusted Medallion", "Royal Crimson Cloak", "Ikfirus's Sack of Wonder", "Umbrage Armbands", "Astrylian's Sutured Cinch", "Frostbitten Fur Boots", "Devium's Eternally Cold Ring", "Abomination's Bloody Ring", "Satrina's Impeding Scarab", "Juggernaut's Vitality", "Sindragosa's Flawless Fang", "Oathbinder, Charge of the Ranger-General", "Cryptmaker"},
        ["Balance"] = {"Blood Queen's Crimson Choker", "Cloak of Burning Dusk", "Bracers of Fiery Night", "Crushing Coldwraith Belt", "Plaguebringer's Stained Pants", "Plague Scientist's Boots", "Valanar's Other Signet Ring", "Phylactery of the Nameless Lich", "Charred Twilight Scale", "Royal Scepter of Terenas II", "Shadow Silk Spindle"},
    },
    ["Death Knight"] = {
        ["Blood-T."] = {"Broken Ram Skull Helm", "Bile-Encrusted Medallion", "Royal Crimson Cloak", "Bracers of Dark Reckoning", "Belt of Broken Bones", "Treads of Impending Resurrection", "Devium's Eternally Cold Ring", "Juggernaut Band", "Satrina's Impeding Scarab", "Juggernaut's Vitality", "Sindragosa's Flawless Fang", "Glorenzelg, High-Blade of the Silver Hand"},
        ["Unholy-D."] = {"Penumbra Pendant", "Winding Sheet", "Umbrage Armbands", "Coldwraith Links", "Scourge Reaver's Legplates", "Apocalypse's Advance", "Might of Blight", "Deathbringer's Will", "Deathbringer's Will", "Glorenzelg, High-Blade of the Silver Hand"},
        ["Frost-D."] = {"Fleshrending Gauntlets", "Penumbra Pendant", "Garrosh's Rage", "Varian's Furor", "Toskk's Maximized Wristguards", "Coldwraith Links", "Apocalypse's Advance", "Might of Blight", "Deathbringer's Will", "Deathbringer's Will", "Havoc's Call, Blade of Lordaeron Kings"},
    },
    ["Hunter"] = {
        ["Marksmanship"] = {"Sindragosa's Cruel Claw", "Sylvanas' Cunning", "Vereesa's Dexterity", "Scourge Hunter's Vambraces", "Nerub'ar Stalker's Cord", "Leggings of Northern Lights", "Returning Footfalls", "Frostbrood Sapphire Ring", "Sharpened Twilight Scale", "Deathbringer's Will", "Oathbinder, Charge of the Ranger-General", "Fal'inrush, Defender of Quel'thalas"},
    },
    ["Mage"] = {
        ["Fire"] = {"Blood Queen's Crimson Choker", "Cloak of Burning Dusk", "Robe of the Waking Nightmare", "Bracers of Fiery Night", "Crushing Coldwraith Belt", "Plague Scientist's Boots", "Ring of Rapid Ascent", "Phylactery of the Nameless Lich", "Charred Twilight Scale", "Bloodsurge, Kel'Thuzad's Blade of Agony", "Shadow Silk Spindle", "Corpse-Impaling Spike"},
        ["Arcane"] = {"Blood Queen Crimson Choker", "Cloak of Burning Dusk", "Bracers of Fiery Night", "Crushing Coldwraith Belt", "Plaguebringer's Stained Pants", "Plague Scientist's Boots", "Ring of Rapid Ascent", "Charred Twilight Scale", "Dislodged Foreign Object", "Bloodsurge, Kel'Thuzad's Blade of Agony", "Shadow Silk Spindle", "Corpse-Impaling Spike"},
    },
    ["Warlock"] = {
        ["Affliction"] = {"Amulet of the Silent Eulogy", "Cloak of Burning Dust", "Bracers of Fiery Night", "Crushing Coldwraith Belt", "Plaguebringer's Stained Pants", "Plague Scientist's Boots", "Ring of Rapid Ascent", "Dislodged Foreign Object", "Charred Twilight Scale", "Bloodsurge, Kel'Thuzad's Blade of Agony", "Shadow Silk Spindle", "Corpse-Impaling Spike"},
        ["Demonology"] = {"Amulet of the Silent Eulogy", "Cloak of Burning Dust", "Bracers of Fiery Night", "Crushing Coldwraith Belt", "Plaguebringer's Stained Pants", "Plague Scientist's Boots", "Valanar's Other Signet Ring", "Phylactery of the Nameless Lich", "Charred Twilight Scale", "Bloodsurge, Kel'Thuzad's Blade of Agony", "Shadow Silk Spindle", "Corpse-Impaling Spike"},
        ["Destruction"] = {"Amulet of the Silent Eulogy", "Cloak of Burning Dusk", "Bracers of Fiery Night", "Crushing Coldwraith Belt", "Plaguebringer's Stained Pants", "Plague Scientist's Boots", "Valanar's Other Signet Ring", "Dislodged Foreign Object", "Charred Twilight Scale", "Bloodsurge, Kel'Thuzad's Blade of Agony", "Shadow Silk Spindle", "Corpse-Impaling Spike"},
    },
    ["Warrior"] = {
        ["Fury"] = {"Penumbra Pendant", "Sylvanas' Cunning", "Vereesa's Dexterity", "Toskk's Maximized Wristguards", "Aldriana's Gloves of Secrecy", "Coldwraith Links", "Apocalypse's Advance", "Frostbrood Saphire Ring", "Sharpened Twilight Scale", "Deathbringer's Will", "Glorenzelg, High-Blade of the Silver Hand", "Cryptmaker", "Fal'inrush, Defender of Quel'thalas"},
        ["Protection"] = {"Broken Ram Skull Helm", "Bile-Encrusted Medallion", "Royal Crimson Cloak", "Bracers of Dark Reckoning", "Belt of Broken Bones", "Treads of Impending Ressurection", "Juggernaut Band", "Devium's Eternally Cold Ring", "Satrina's Impeding Scarab", "Juggernaut's Vitality", "Sindragosa's Flawless Fang", "Mithrios, Bronzebeard's Legacy", "Icecrown Glacial Wall", "Dreamhunter's Carbine"},
    },
}

------ You can change these settings! ------
-- Created objects --
--| Output: Player prepares [Spell]. |--
local spellsCreate = {["Great Feast"] = 180, ["Fish Feast"] = 180, ["Soul Portal"] = 180, ["Summoning Portal"] = 300, ["Refreshment Portal"] = 180}

-- Damage & Healing --
--| Output: [Spell] hits Target for Amount [(Critical)]. |--
local spellsDamage = {}
local spellsPeriodicDamage = {"Necrotic Plague"}
--| Output: [Spell] heals Target for Amount [(Critical)]. |--
local spellsHeal = {"Rune of Blood"}
local spellsPeriodicHeal = {}
--| Output: [Spell] hits: Target1 (Amount3), Target2 (Amount3), Target3 (Amount3), ... |--
--| Filter: UnitIsPlayer(Target)
local spellsAOEDamage = {"Dark Martyrdom", "Deathchill Blast", "Vengeful Blast", "Unstable Ooze Explosion", "Malleable Goo", "Choking Gas Explosion", "Frost Bomb", "Blistering Cold", "Defile", "Shadow Trap", "Trample"}
--| Output: Player damages Target with [Spell]. |--
local reportDamageOnTarget = {}

-- Summons (SPELL_SUMMON) --
--| Output: Unit summons Target. [Spell] |--
local npcSpellSummon = {"Slime Pool"}
--| Output: Target summoned. [Spell] |--
local npcBossSpellSummon = {"Vengeful Shade"} -- Boss summons, destination is unknown. ("Dark Nucleus" summoned every second - spam)

-- Casts (SPELL_CAST_START and SPELL_CAST_SUCCESS) --
--| Output: Unit casts [Spell]. |--
local spellsCast = {"Blessing of Forgotten Kings", "Runescroll of Fortitude", "Drums of the Wild", "Aura Mastery", "Divine Sacrifice", "Mana Tide Totem", 69381}
-- [69381] = Drums: Gift of the Wilds
tankCooldownsCast = {"Divine Protection", "Icebound Fortitude", "Vampiric Blood", "Anti-Magic Shell", "Anti-Magic Zone", "Barkskin", "Survival Instincts", "Frenzied Regeneration", "Shield Wall", "Last Stand"}
otherSpellsCast = {"Soulshatter", "Invisibility", "Ice Block", "Hymn of Hope", "Divine Hymn", "Psychic Scream", "Dispersion", "Army of the Dead", "Cloak of Shadows", "Deterrence"}
local npcSpellsCast = {"Remorseless Winter", "Quake", "Dark Vortex", "Light Vortex"}
--| Output: Unit casts [Spell] on Target. |--
local spellsCastOnTarget = {"Innervate", "Tricks of the Trade", "Misdirection", "Hand of Protection", "Hand of Salvation", "Divine Intervention", "Hand of Sacrifice", "Hand of Freedom", "Lay on Hands", "Guardian Spirit", "Pain Suppression"}
--| Output: [Spell] on Target. |--
local spellsBossCastOnTarget = {"Rune of Blood", "Vile Gas", "Swarming Shadows", "Necrotic Plague", "Soul Reaper"} -- If sourceName isn't important (ex. Boss casting).
otherSpellsCastOnTarget = {"Power Infusion", "Hysteria", "Fear Ward", "Banish", "Bash", "Hammer of Justice", "Concussion Blow", "Tranquilizing Shot"}

-- Auras (SPELL_AURA_APPLIED, SPELL_AURA_APPLIED_DOSE, SPELL_AURA_STOLEN) --
local aurasApplied = {"Eyes of Twilight"}
tankAurasApplied = {"Aegis of Dalaran", "Ardent Defender", "Enraged Defense", "Blood Armor"}
--| Output: [Spell] applied on Target. |--
--| Filter: UnitIsPlayer(Target)
local aurasAppliedOnTarget = {"Volatile Ooze Adhesive", "Gaseous Bloat", "Unbound Plague", "Soul Consumption", "Fiery Combustion", "Soulstone Resurrection"}
--| Output: [Spell] applied on Target1, Target2, Target3 ... |--
local aurasAppliedOnTargets = {"Impaled", "Gas Spore", "Vile Gas", "Frost Beacon"}
-- MPR.DB.SayYells = true
local sayAuraOnMe = {
    ["Impaled"] = "Bone Spike on me! Kill it fast!!",
    ["Dominate Mind"] = "Dominate Mind on me! Don't kill me!!",
    ["Volatile Ooze Adhesive"] = "Green on me!",
    ["Gaseous Bloat"] = "Orange on me!",
    ["Essence of the Blood Queen"] = "I was biten!",
    ["Frenzied Bloodthirst"] = "I have to bite!!",
    ["Frost Beacon"] = "Frost Beacon on me!"
}
local paladinAuras = {
    "Devotion Aura",
    "Retribution Aura",
    "Concentration Aura",
    "Shadow Resistance Aura",
    "Frost Resistance Aura",
    "Fire Resistance Aura",
    "Crusader Aura"
}

local raidTargetIcons ={
    [1] = {"\124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:12\124t","{rt1}"}, -- Star
    [2] = {"\124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:12\124t","{rt2}"}, -- Circle
    [3] = {"\124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:12\124t","{rt3}"}, -- Diamond
    [4] = {"\124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:12\124t","{rt4}"}, -- Triangle
    [5] = {"\124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:12\124t","{rt5}"}, -- Moon
    [6] = {"\124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:12\124t","{rt6}"}, -- Square
    [7] = {"\124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:12\124t","{rt7}"}, -- Cross
    [8] = {"\124TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:12\124t","{rt8}"}  -- Skull
}

--| Output: Target has Amount stacks of [Spell]. |--
local stackAppliedOnTarget = {"Instability", "Cleave Armor"}
--| Output: Player steals [Spell] from Target. |--
-- MPR.DB.ReportAurasStolen = true

-- Dispeling --
--| Output: Player dispels Target. [extraSpell] |--
local ignoreDispels = {"Frost Fever", "Blood Plague", "Ebon Plague", "Corrupted Blood", "Leeching Rot", "Amplify Magic", "Curse of Agony", "Fireball", "Shield Bash", "Rejuvenation", "Frostfire Bolt", "Frost Breath", "Curse of Doom"}
-- MPR.DB.ReportDispels = true
--| Output: Player mass-dispels Target1 ([extraSpell1]), Target2 ([extraSpell2]), Target3 ([extraSpell3]) ... |--
-- MPR.DB.ReportMassDispels = true
--------------------------------------------

-- Addon Variables --
local AddonUsers = {}
local AskedWhatsNew
local RaidOptions
-- Combat Varriables --
local casterHeroism = {}
local targetsHeroism = {}
local nameSpellAOEDamage
local targetsAOEDamage = {}
local targetsSpellAOEDamage = {}
local targetsAura = {}
local casterMassDispel
local targetsMassDispel = {}
-- Boss Variables --
--Blood-Queen Lana'thel
local BS_TargetsName = {}
local BS_TargetsAmount = {}
--------------------------------------------

local Events = {
    "ZONE_CHANGED_NEW_AREA",
    "COMBAT_LOG_EVENT_UNFILTERED",
    "CHAT_MSG_MONSTER_YELL",
    "CHAT_MSG_ADDON",
    "CHAT_MSG_WHISPER",
    "RAID_ROSTER_UPDATE",
    "LOOT_OPENED",

    "CHAT_MSG_RAID_BOSS_EMOTE",
}

MPR:SetScript("OnEvent", function(self, event, ...)
    self[event](self, ...)
end)

------------------
--  Hyperlinks  --
------------------
do
    DEFAULT_CHAT_FRAME:HookScript("OnHyperlinkClick", function(self, link, string, button, ...)
        local linkType, arg1, arg2, arg3, arg4 = strsplit(":", link)
        if linkType ~= "MPR" then return end
        if arg1 == "Options" then
            if arg2 == "Show" then
                MPR_Options:Show()
            end
        elseif arg1 == "AuraInfo" then
            if arg2 == "Update" then
                MPR_AuraInfo:UpdateFrame(tonumber(arg3))
            else -- arg2 is ICC, TOC or RS
                MPR_AuraInfo:UpdateFrame(tonumber(arg3))
            end
        elseif arg1 == "IgnoreDispels" then
            MPR_Dispels:Toggle()
        elseif arg1 == "Timers" then
            MPR_Timers:Toggle()
        elseif arg1 == "ClearDeathLog" then
            MPR:ClearDeathLog(true)
        elseif arg1 == "DeductDKP" then
            arg2 = {strsplit("-",arg2)}
            arg4 = arg4:gsub("{(.-)}", function(a) return GetSpellLink(tonumber(a)) end)
            MPR:DKPDeductionHandler(arg2,tonumber(arg3),arg4)
        elseif arg1 == "DeathReport" then
            MPR:DeathReport(arg2, arg3)
        elseif arg1 == "VersionNotes" then
            if arg2 == "get" then
                if AskedWhatsNew then return end
                AskedWhatsNew = true
                SendAddonMessage("MPR", "VersionNotes:get", "WHISPER", arg3)
            else
                if #MPR.VersionNotes > 0 then
                    MPR:SelfReport("|r|cFFFFFFFFUpdate notes for |r|cFF00FF00"..MPR.Version.."|r|cFFFFFFFF:")
                    for _,line in pairs(MPR.VersionNotes) do
                        MPR:SelfReport("- "..line)
                    end
                else
                    MPR:SelfReport("No version notes given for |r|cFF00FF00"..MPR.Version.."|r|cFFBEBEBE.")
                end
            end
        elseif arg1 == "CopyUrl" then
            MPR_CopyURL.Address = arg2..":"..arg3
            MPR_CopyURL:Show()
        end
    end)
end

do
    local old = ItemRefTooltip.SetHyperlink -- we have to hook this function since the default ChatFrame code assumes that all links except for player and channel links are valid arguments for this function
    function ItemRefTooltip:SetHyperlink(link, ...)
        if link:match("^MPR") then return end
        return old(self, link, ...)
    end
end

--[[-------------------------------------------------------------------------
    Local Methods
---------------------------------------------------------------------------]]

function numformat(Number)
    -- Number formating
    if strlen(Number) > 3 then
        return string.sub(Number, 1, -4).."k"
    else
        return Number
    end
end

function contains(array, element, boolKey)
    if boolKey then
        for key, _ in pairs(array) do
            if key == element then
                return true
            end
        end
    else
        for _, value in pairs(array) do
            if value == element then
                return true
            end
        end
    end
end

function RemoveByKey(tbl,key)
    table.remove(tbl,key)
end

function RemoveByValue(tbl,key)
    for i,v in pairs(tbl) do
        if v == key then
            table.remove(tbl,i)
            return
        end
    end
end

function colorWhite(str)
    return string.format("|r|cFFffffff%s|r|cFF%s",str,MPR.Colors["TEXT"])
end

function report(TimerName, ...)
    if TimerName == "Report Users" then
        local Users = {}
        local NewestUser = nil
        local NewestVersion = ""
        local MyVersion = MPR.Version
        for User,Version in pairs(AddonUsers) do
            if Version > MyVersion then
                if Version > NewestVersion then
                    NewestUser, NewestVersion = User, Version
                end
                table.insert(Users,string.format("%s (|r|cFF00FF00%s|r|cFFBEBEBE)",unit(User),Version))
            else
                table.insert(Users,string.format("%s (%s)",unit(User),Version))
            end
        end
        table.wipe(AddonUsers)
        MPR:SelfReport(string.format("Online guild members using addon: %s",table.concat(Users, ", ")))
        if NewestUser then
            MPR:SelfReport("|r|cFF00FF00A newer version is available!|r |cFF00CCFF|HMPR:VersionNotes:get:"..NewestUser.."|h[Check what's new!]|h")
        end
    else
        MPR:SelfReport(...)
    end
end

function unit(name, class)
    if name then
        local class = class or select(2, UnitClass(name)) or select(6, MPR:GetGuildMemberInfo(name))
        if class then
            return string.format("|r|cFF%s|Hplayer:%s|h[%s]|h|r|cFF%s",ClassColors[strupper(class)],name,name,MPR.Colors["TEXT"])
            --return string.format("|Hplayer:%s|h[|r|cFF%s%s|r|cFF%s]|h",name,Class,self.Colors[select(2, UnitClass(name))],name,self.Colors["TEXT"])
        elseif contains(BossNames,name) then
            return "|r|cFFff8c00"..name.."|r|cFF"..MPR.Colors["TEXT"]
        else
            return colorWhite(name)
        end
    else
        return "unknown"
    end
end

function WarnLink(Target,String)
    return "|Hplayer:"..name.."|h[Warn Him]|h"
end

function spell(id, ...)
    local bRaid, ignoreSetting = ...
    if bRaid then return GetSpellLink(id) end
    if type(id) ~= "number" then return id end
    if (MPR.Settings["ICONS"] or ignoreSetting) and select(3, GetSpellInfo(id)) then
        return string.format("\124T%s:12:12:0:0:64:64:5:59:5:59\124t|r%s|cFF%s",select(3, GetSpellInfo(id)),GetSpellLink(id),MPR.Colors["TEXT"])
    else
        return string.format("|r%s|cFF%s",GetSpellLink(id),MPR.Colors["TEXT"])
    end
end

function item(id)
    if type(id) ~= "number" then return id end
    local itemLink = select(2, GetItemInfo(id))
    if itemLink then
        return itemLink
    end
end

function getStateColor(state)
    if state then
        return "|r|cFF00FF00enabled|r|cFF"..MPR.Colors["TEXT"]
    else
        return "|r|cFFFF0000disabled|r|cFF"..MPR.Colors["TEXT"]
    end
end

function GetGold(str)
    for l=1,5 do
        if str:sub(l+2,l+5) == "Gold" then return tonumber(str:sub(1,l)) end
    end
    return 0
end

--[[-------------------------------------------------------------------------
    Timer System
---------------------------------------------------------------------------]]

local lib = DongleStub("Dongle-1.2"):New("MP Reporter")

function MPR:ScheduleTimer(name, func, delay, ...)
    lib:ScheduleTimer(name, func, delay, ...)
end

function MPR:IsTimerScheduled(name)
    return lib:IsTimerScheduled(name)
end

function MPR:CancelTimer(name)
    lib:CancelTimer(name)
end

function MPR:CS(String,Color) -- ColorString
    if not Color then return String end
    return "|r|cFF"..Color..String.."|r|cFF"..self.Colors["TEXT"]
end

local function TimerHandler(name, ...)
    if name == "Spell AOE Damage" then
        local SpellID = ...
        --local SpellName = GetSpellInfo(SpellID)

        local arraySelf = {}
        local arrayRaid = {}

        for Target,Data in pairs(targetsSpellAOEDamage) do
            table.insert(arraySelf,unit(Target).." ("..numformat(Data.Amount)..")")
            table.insert(arrayRaid,Target.." ("..numformat(Data.Amount)..")")
        end
        MPR:HandleReport(string.format("%s hits: %s",spell(SpellID,true),table.concat(arrayRaid,", ")), string.format("%s hits: %s",spell(SpellID),table.concat(arraySelf,", ")))

        if MPR_Penalties.PenaltySpells[nameSpellAOEDamage] then
            MPR_Penalties:HandleHits(targetsSpellAOEDamage,MPR_Penalties.PenaltySpells[nameSpellAOEDamage][1],SpellID)
        end
        nameSpellAOEDamage = nil
        table.wipe(targetsSpellAOEDamage)
    elseif name == "Aura Targets" then
        local SPELL = ...
        local array = {}
        local arrayRaid = {}
        for _,Target in pairs(targetsAura) do
            table.insert(array,unit(Target))
            table.insert(arrayRaid,Target)
        end
        table.wipe(targetsAura)
        MPR:HandleReport(string.format("%s on: %s",spell(SPELL,true),table.concat(arrayRaid,", ")), string.format("%s on: %s",spell(SPELL),table.concat(array,", ")))
    elseif name == "Heroism" or name == "Bloodlust" then
        local SPELL = ...
        if #targetsHeroism > 0 then
            MPR:HandleReport(string.format("%s casts %s (%i/%i players affected)",casterHeroism,spell(SPELL,true),#targetsHeroism,GetNumRaidMembers()), string.format("%s casts %s (%i/%i players affected)",unit(casterHeroism),spell(SPELL),#targetsHeroism,GetNumRaidMembers()))
        else
            MPR:ReportCast(casterHeroism,SPELL)
        end
        casterHeroism = nil
        table.wipe(targetsHeroism)
    elseif contains(spellsCreate,name,true) then
        local SPELL = ...
        MPR:HandleReport(string.format("%s expires in 30 seconds.",spell(SPELL,true)), string.format("%s expires in 30 seconds.",spell(SPELL)))
    elseif name == "Bloodbolt Splash" then
        local SPELL = ...
        local self = {}
        local raid = {}
        for i, TARGET in pairs(BS_TargetsName) do
            local AMOUNT = BS_TargetsAmount[i]
            table.insert(self,string.format("%s (%s)",unit(TARGET),numformat(AMOUNT)))
            table.insert(raid,string.format("%s (%s)",TARGET,numformat(AMOUNT)))
        end
        table.wipe(BS_TargetsName)
        table.wipe(BS_TargetsAmount)
        --MPR:HandleReport(string.format("Range fail (6 yd) - %s hits: %s",spell(SPELL,true),table.concat(raid,", ")), string.format("Range fail (6 yd) - %s hits: %s",spell(SPELL),table.concat(self,", ")))
    elseif name == "Halion:TwilightCutter" then
        MPR_Timers:TwilightCutter()
    end
end

--[[-------------------------------------------------------------------------
    Boss Methods
---------------------------------------------------------------------------]]

function BPC_ChangeTarget(Prince)
    MPR:RaidWarning(string.format("Switch target to: %s", Prince))
    MPR:HandleReport(string.format("Switch target to: %s", Prince), string.format("Switch target to: %s", unit(Prince)))
end

--[[-------------------------------------------------------------------------
    Class Methods
---------------------------------------------------------------------------]]

function MPR:RegisterEvents()
    for _,event in pairs(Events) do
        this:RegisterEvent(event)
    end
end

function MPR:CHAT_MSG_RAID_BOSS_EMOTE(message,npc)
    if npc == "Professor Putricide" and message:find("Malleable Goo") then
        MPR_Timers:MalleableGoo()
    end
end

function CheckRaidOptions(Var)
    RaidOptions = {}
    SendAddonMessage("MPR", "OptionCheck:"..Var, "RAID")
    MPR:ScheduleTimer(Var, PrintRaidOptions, 1)
end

function PrintRaidOptions(Var)
    local OptionName = Var:sub(1,3) == "PD_" and "Reporting deaths to "..Var:sub(4) or Var:sub(1,2) == "T_" and "Reporting timers to "..Var:sub(3) or Var == "KILLINGBLOW" and "Reporting killing blow to RAID" or "Reporting to "..Var
    local Players = {}
    for _,Player in pairs(RaidOptions) do
        table.insert(Players,unit(Player))
    end
    MPR:SelfReport(string.format("%s %s.%s", OptionName, getStateColor(true), (#Players > 0 and " Raid members having this option enabled: "..table.concat(Players," ") or "")))
    RaidOptions = {}
end

function MPR:ClearCombatLog(bAuto)
    CombatLogClearEntries()
    -- self:SelfReport("Combat log entries cleared.")
end

function MPR:ClearDeathLog(bConfirmed)
    if not bConfirmed then
        MPR:SelfReport("|r|cFFFF0000You are about to clear death log ("..#self.DataDeaths.." records)! Data cannot be recovered afterwards. |r|cFFFFFFFF|HMPR:ClearDeathLog|h[Clear death logs!]|h|r|cFFbebebe")
    else
        for i,_ in pairs(self.DataDeaths) do
            self.DataDeaths[i] = nil
        end
        MPR:SelfReport("|r|cFFFFFFFF Death log cleared.|r|cFFbebebe")
        -- Reload MPR_Options if it's vissible
        if MPR_Options:IsVisible() then
            MPR_Options:Hide()
            MPR_Options:Show()
        end
    end
end

function round(num, idp, up)
    if not num then return 0 end
    local mult = 10^(idp or 0)
    return math.floor(num * mult + (up and 0.99 or 0.5)) / mult
end

function SlashCmdList.MPR(msg, editbox)
    msg = strlower(msg)
    if type(tonumber(msg)) == "number" then
        MPR_AuraInfo:UpdateFrame(tonumber(msg))
    elseif msg == "d" or msg == "dispels" then
        MPR_Dispels:Toggle()
    elseif msg == "t" or msg == "timers" then
        MPR_Timers:Toggle()
    elseif msg == "to" then
        MPR_Timers_Options:Toggle()
    elseif msg == "ai" then
        MPR:SelfReport("Instance: |r|cFF00CCFF|HMPR:AuraInfo:ICC:1|h[Icecrown Citadel]|h|r "..
                "|cFF3CAA50|HMPR:AuraInfo:TOC:13|h[Trial of the Crusader]|h|r "..
                "|cFFFF9912|HMPR:AuraInfo:RS:20|h[Ruby Sanctum]|h|r|cFFbebebe")
    elseif msg == "dkp" or msg == "p" or msg == "penalties" then
        MPR_Penalties:Toggle()
    elseif msg == "ccl" or msg == "clear" then
        MPR:ClearCombatLog()
        self:SelfReport("Combat log entries cleared.")
    elseif msg == "cdl" then
        MPR:ClearDeathLog()
    elseif msg == "help" or msg == "cmd" or msg == "commands" then
        MPR:ReportCommands()
    elseif msg ~= "" then
        MPR:SelfReport("Unknown command.")
    else -- Options
        if not MPR_Options:IsVisible() then
            MPR_Options:Show()
        else
            MPR_Options:Hide()
        end
    end
end

function MPR:CHAT_MSG_WHISPER(...)
    local Message, Player = ...
    Message = strlower(Message)
    if Message == "raidlocks" or Message == "rl" then
        self:ReportLocks(Player)
    end
end

local rrInformed = false
function MPR:RAID_ROSTER_UPDATE(...)
    if UnitInRaid("player") then
        if not self.Settings["RAID"] or rrInformed then return end
        rrInformed = true
        self:SelfReport("Raid Reporting is "..getStateColor(self.Settings["RAID"])..". It is recommended that only one member is reporting to RAID channel to prevent spam.")
    else -- not in raid = left raid?
        rrInformed = false
    end
end

function MPR:GetLootName()
    for i=1,GetNumLootItems() do
        local _, Name, _, Rarity, _ = GetLootSlotInfo(i)
        if Name and Rarity == 4 then
            for CacheName,CacheLoot in pairs(ChestLoot) do
                if contains(CacheLoot,Name) then return CacheName end
            end
        end
    end
end

local LootedCreatures = {}
function MPR:LOOT_OPENED()
    if not UnitInRaid("player") or not self.Settings["REPORT_LOOT"] then return end
    local LootMethod, _, MasterLooterRaidID = GetLootMethod()
    if LootMethod == "master" and MasterLooterRaidID and UnitName("player") == UnitName("raid"..MasterLooterRaidID) then
        local LootName = not UnitPlayerOrPetInRaid("target") and UnitName("target") or nil
        local LootGUID = LootName and tonumber(string.sub(UnitGUID("target"),9,12),16).."-"..tonumber(string.sub(UnitGUID("target"),13),16) or nil
        LootName = LootName or GetLootName()
        if LootGUID or LootName then
            if LootedCreatures[LootGUID or LootName] then return end
            LootedCreatures[LootGUID or LootName] = true
        end

        local Gold = GetGold(select(2,GetLootSlotInfo(1)))
        local WorthGold    = Gold > 0 and "("..Gold.." Gold)" or ""
        local ItemLinks = {}
        --local BoPs = false
        for i=1,GetNumLootItems() do
            local _, Name, _, Rarity, _ = GetLootSlotInfo(i)
            local ItemLink = GetLootSlotLink(i)
            --local ItemBoP = select(5,GetLootRollItemInfo(i-1))
            if Name and ItemLink and Rarity >= 4 then -- Uncommon/green (2), Rare/blue (3), Epic/purple (4), ...
                -- make BiS list
                local bisClasses = {}
                if self.Settings["REPORT_LOOT_BIS_INFO"] then
                    for Class,Specs in pairs(ClassBIS) do
                        local bisSpecs = {}
                        for Spec,Items in pairs(Specs) do
                            if contains(Items,Name) then
                                table.insert(bisSpecs,Spec:sub(1,3).."."..(Spec:sub(1,5) == "Feral" and select(2,strsplit(Spec,"-")) or ""))
                            end
                        end
                        if #bisSpecs > 0 then table.insert(bisClasses,Class.." ("..table.concat(bisSpecs,", ")..")") end
                    end
                end
                table.insert(ItemLinks, ItemLink..(#bisClasses > 0 and " BiS: "..table.concat(bisClasses," ") or ""))
                --if ItemBoP and not BoPs then BoPs = true end
            end
        end
        local NotEligible = {}
        if #ItemLinks > 0 then -- Check who is not eligible to loot items.
            local Eligible = {}
            for i=1,40 do
                if GetMasterLootCandidate(i) then table.insert(Eligible, GetMasterLootCandidate(i)) end
            end
            for i=1,GetNumRaidMembers() do
                local Member = UnitName("raid"..i)
                if not contains(Eligible,Member) then table.insert(NotEligible,Member) end
            end
        end
        if #ItemLinks > 0 then
            self:RaidReport(string.format("%s - items in loot: %s",LootName,WorthGold),true)
            for _,item in pairs(ItemLinks) do
                self:RaidReport(item,true,true)
            end
            if #NotEligible > 0 then
                self:RaidReport("Not eligible: "..table.concat(NotEligible, ", "),true,true)
            end
        end
    end
end

MPR_GameTime = {
    Get = function(self)
        if(self.LastMinuteTimer == nil) then
            local h,m = GetGameTime()
            return h,m,0
        end
        local GameSecond = floor(GetTime() - self.LastMinuteTimer)
        GameSecond = (GameSecond <= 59 and GameSecond or 59)
        return self.LastGameHour, self.LastGameMinute, GameSecond
    end,

    OnUpdate = function(self)
        local h,m = GetGameTime()
        if(self.LastGameMinute == nil) then
            self.LastGameHour = h
            self.LastGameMinute = m
            return
        end
        if(self.LastGameMinute == m) then
            return
        end
        self.LastGameHour = h
        self.LastGameMinute = m
        self.LastMinuteTimer = GetTime()
    end,

    Initialize = function(self)
        self.Frame = CreateFrame("Frame")
        self.Frame:SetScript("OnUpdate", function() self:OnUpdate() end)
    end
}
MPR_GameTime:Initialize()

function MPR:ReportDeath(Unformatted, Formatted)
    if self.Settings["PD_RAID"] then
        if UnitInRaid("player") then
            self:RaidReport(Unformatted,true)
        elseif GetNumPartyMembers() > 0 then
            self:PartyReport(Unformatted,true)
        end
    elseif self.Settings["PD_SELF"] then
        self:SelfReport(Formatted)
    end
    if self.Settings["PD_WHISPER"] then
        self:Whisper(Unformatted,true)
    end
    if self.Settings["PD_GUILD"] then
        self:Guild(Unformatted)
    end
end

local Combat = false
function MPR:StartCombat(ID)
    if Combat then return end
    Combat = true

    local index = #self.DataDeaths+1
    self.DataDeaths[index] = {}
    self.DataDeaths[index].ID = ID
    self.DataDeaths[index].Name = self.BossData[ID]["ENCOUNTER"]
    local _, month, day, year = CalendarGetDate();
    local month_names = {[1] = "Jan", [2] = "Feb", [3] = "Mar", [4] = "Apr", [5] = "May", [6] = "Jun", [7] = "Jul", [8] = "Aug", [9] = "Sep", [10] = "Oct", [11] = "Nov", [12] = "Dec"}
    self.DataDeaths[index].Date = string.format("%s %i, %i",month_names[month],day,year)
    self.DataDeaths[index].TimeStart = GetTime() + (self.BossData[ID]["START_DELAY"] or 0)
    local hour, minute, second = MPR_GameTime:Get()
    self.DataDeaths[index].GameTimeStart = string.format("%i:%02d:%02d",hour,minute,second+(self.BossData[ID]["START_DELAY"] or 0))
    self.DataDeaths[index].GameTimeEnd = "unknown"
    self.DataDeaths[index].Deaths = {}
    local Color = ID <= 12 and "00CCFF" or ID <= 19 and "3CAA50" or ID <= 23 and "FF9912" or "FFFFFF"
    self.DataDeaths[index].Color = Color
    self:SelfReport("Encounter |r|cFF"..Color.."|HMPR:AuraInfo:Update:"..ID.."|h["..self.DataDeaths[index].Name.."]|h|r|cFFbebebe started. |cFF00CCFF|HMPR:Timers:nil:nil|h[Timers]|h|r")
    MPR:ScheduleTimer("Wipe Check", WipeCheck, 5)

    MPR_Timers:EncounterStart(ID)
end

function MPR:StopCombat()
    MPR:CancelTimer("Wipe Check")
    if not Combat then return end
    Combat = false

    local index = #self.DataDeaths
    self.DataDeaths[index].TimeEnd = GetTime() -- Not used
    local h,m,s = MPR_GameTime:Get()
    self.DataDeaths[index].GameTimeEnd = string.format("%i:%02d:%02d",h,m,s)
    local numDeaths = #self.DataDeaths[index].Deaths
    local ID = self.DataDeaths[index].ID
    local Color = ID <= 12 and "00CCFF" or ID <= 19 and  "3CAA50" or ID <= 23 and "FF9912" or "FFFFFF"
    self:SelfReport("Encounter |r|cFF"..Color..self.DataDeaths[index].Name.."|r|cFFbebebe finished."..(numDeaths > 0 and " ("..numDeaths.." deaths. Report to:|r |HMPR:DeathReport:Self:"..index..":nil|h|cff1E90FF[Self]|r|h |HMPR:DeathReport:Raid:"..index..":nil|h|cffEE7600[Raid]|r|h |HMPR:DeathReport:Guild:"..index..":nil|h|cff40FF40[Guild]|r|h|cFFbebebe)|r" or ""))

    MPR_Timers:EncounterEnd(ID)
end

local StartChecks = 0
function StartCheck(Event, ID)
    if Combat or not UnitInRaid("player") then return end
    if StartChecks == 0 then return end
    StartChecks = StartChecks - 1
    for i=0,GetNumRaidMembers() do
        local UnitID = (i == 0 and "player" or "raid"..i)
        if UnitAffectingCombat(UnitID) and not UnitIsDeadOrGhost(UnitID) then
            MPR:StartCombat(ID)
            return
        end
    end
    MPR:ScheduleTimer("Start Check", StartCheck, 1, ID)
end

function WipeCheck()
    if not Combat then return end -- StopCombat() was called already
    local Wipe = true
    if UnitInRaid("player") then
        for i=0,GetNumRaidMembers() do
            local UnitID = (i == 0 and "player" or "raid"..i)
            if UnitAffectingCombat(UnitID) and not UnitIsDeadOrGhost(UnitID) then
                Wipe = false
                break
            end
        end
    end
    -- Don't stop encounter if we're in Frostmourne at the Lich King...
    if Wipe and GetSubZoneText() ~= "Frostmourne" then
        MPR:StopCombat()
    else
        MPR:ScheduleTimer("Wipe Check", WipeCheck, 1)
    end
end

function MPR:DeathReport(channel, index)
    index = tonumber(index or #self.DataDeaths)
    local strEncounter = channel == "Self" and "|cFF"..(self.DataDeaths[index].Color or "FFFFFF")..self.DataDeaths[index].Name.."|r|cFFBEBEBE" or self.DataDeaths[index].Name
    local strReportTitle = "Death Report for "..strEncounter.." ("..(self.DataDeaths[index].GameTimeStart or "unknown").." - "..(self.DataDeaths[index].GameTimeEnd or "unknown")..")"
    if channel == "Raid" then
        self:RaidReport(strReportTitle,true)
    elseif channel == "Guild" then
        self:Guild(strReportTitle)
    elseif channel == "Self" then
        self:SelfReport(strReportTitle)
    end
    if #self.DataDeaths[index].Deaths > 0 then
        for i=1,#self.DataDeaths[index].Deaths do
            if not self.DataDeaths[index].Deaths[i].Player then
                local Player,Time,Source,Ability,Amount,Overkill = unpack(self.DataDeaths[index].Deaths[i])
                local tbl = {Player = Player, Time = Time, Source = Source, Ability = Ability, Amount = Amount, Overkill = Overkill}
                self.DataDeaths[index].Deaths[i] = tbl
            end

            local tbl = self.DataDeaths[index].Deaths[i]
            local strTime = string.format("%2d:%02d",floor(tbl.Time/60),(tbl.Time%60))
            if channel == "Raid" then
                self:RaidReport(string.format("%i. %s %s - %s: %s (A: %s%s)", i, strTime, tbl.Player, tbl.Source, tbl.Ability, tbl.Amount and numformat(tbl.Amount-tbl.Overkill) or "?", tbl.Overkill > 0 and " / O: "..numformat(tbl.Overkill) or ""),true,true)
            elseif channel == "Guild" then
                self:Guild(string.format("%i. %s %s - %s: %s (A: %s%s)", i, strTime, tbl.Player, tbl.Source, tbl.Ability, tbl.Amount and numformat(tbl.Amount-tbl.Overkill) or "?", tbl.Overkill > 0 and " / O: "..numformat(tbl.Overkill) or ""),true)
            else
                self:SelfReport(string.format("%i. %s %s - %s: %s|r|cFFBEBEBE (A: %s%s)", i, strTime, unit(tbl.Player,tbl.Class), tbl.Source, tbl.Ability, tbl.Amount and numformat(tbl.Amount-tbl.Overkill) or "?", tbl.Overkill > 0 and " / O: "..numformat(tbl.Overkill) or ""))
            end
        end
    else
        if channel == "Raid" then
            self:RaidReport("No death records.",true,true)
        elseif channel == "Guild" then
            self:Guild("No death records.",true)
        else
            self:SelfReport("No death records.")
        end
    end
end

function MPR:InsertDeath(Player,Source,Ability,Amount,Overkill)
    if not Combat then return end
    local Time = math.floor(GetTime()-self.DataDeaths[#self.DataDeaths].TimeStart)
    local tbl = {Player = Player, Class = select(2, UnitClass(Player)), Time = Time, Source = Source, Ability = Ability, Amount = Amount, Overkill = Overkill}
    table.insert(self.DataDeaths[#self.DataDeaths].Deaths,tbl)
end

local PotencialDeaths = {}
function MPR:COMBAT_LOG_EVENT_UNFILTERED(...)
    --if not self.Settings["SELF"] then return end
    local timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1, ...)

    if UnitIsPlayer(destName) and (self.Settings["PD_REPORT"] or self.Settings["PD_LOG"]) then --(UnitInParty(destName) or UnitInRaid(destName)) and
        if event == "SWING_DAMAGE" then
            if PotencialDeaths[destName] then PotencialDeaths[destName] = nil end
            local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(9, ...)
            PotencialDeaths[destName] = {timestamp, sourceName or "Unknown", "Melee", amount, overkill or 0}
        elseif event == "RANGED_DAMAGE" or event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" then
            if PotencialDeaths[destName] then PotencialDeaths[destName] = nil end
            local spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(9, ...)
            PotencialDeaths[destName] = {timestamp, sourceName, GetSpellLink(spellId), amount, overkill or 0}
        elseif event == "ENVIRONMENTAL_DAMAGE" then
            if PotencialDeaths[destName] then PotencialDeaths[destName] = nil end
            local environmentalType, amount, overkill = select(9, ...)
            PotencialDeaths[destName] = {timestamp, "Environment", environmentalType, amount, overkill or 0}
        elseif event == "UNIT_DIED" and not UnitIsFeignDeath(destName) then
            if PotencialDeaths[destName] then
                local pdTimestamp, source, type, amount, overkill = unpack(PotencialDeaths[destName])
                if (timestamp - pdTimestamp) < 2 then
                    if self.Settings["PD_REPORT"] then
                        local Unformatted = destName.." died. ("..(source and source..":" or "").." "..type.." - A: "..numformat(amount-overkill).." / O: "..numformat(overkill)..")"
                        local Formatted = unit(destName).." died. ("..(source and source..":" or "").." "..type.." - A: "..numformat(amount-overkill).." / O: "..numformat(overkill)..")"
                        self:ReportDeath(Unformatted, Formatted)
                    end
                    if self.Settings["PD_LOG"] then
                        self:InsertDeath(destName, source, type, amount, overkill)
                    end
                end
                PotencialDeaths[destName] = nil
            end
        end
    end

    local inInstance, instanceType = IsInInstance()
    if inInstance then
        if instanceType == "raid" and not self.Settings["REPORTIN_RAIDINSTANCE"] or
                instanceType == "party" and not self.Settings["REPORTIN_DUNGEON"] or
                instanceType == "pvp" and not self.Settings["REPORTIN_BATTLEGROUND"] or
                instanceType == "arena" and not self.Settings["REPORTIN_ARENA"] then
            return
        end
    else
        if not self.Settings["REPORTIN_OUTSIDE"] then
            return
        end
    end

    -- Check if Blood-Queen Lana'thel or Halion encounter started ...
    if destName == "Blood-Queen Lana'thel" and not Combat and event:find("DAMAGE") then
        MPR:StartCombat(9)
    elseif destName == "Halion" and not Combat and event:find("DAMAGE") then
        MPR:StartCombat(23)
    end

    -- taken from Blizzard_CombatLog.lua
    if event == "SWING_DAMAGE" then
        local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(9, ...)

        if sourceName == "Vengeful Shade" and UnitIsPlayer(destName) then
            self:SelfReport(string.format("%s failed to run from %s",unit(destName),unit(sourceName)))
            self:RaidReport(string.format("%s failed to run from %s",destName,sourceName))
        elseif contains(reportDamageOnTarget,destName) then
            self:ReportDamageOnTarget(sourceName,destName,spellId)
        end

        -- for fun!
        if overkill > 0 and #self.DataDeaths > 0 and destName == self.DataDeaths[#self.DataDeaths].Name and self.Settings["KILLINGBLOW"] then
            self:RaidReport(self:FormatKillingBlow(sourceName,destName,"a melee attack",amount,overkill,critical))
        end
    elseif event == "SWING_MISSED" then
        -- local spellName = ACTION_SWING
        local missType = select(9, ...)
        -- 39863 = UnitId of Halion in Normal Phase
        if missType == "PARRY" and destGUID == UnitGUID("target") and (destName == "Sindragosa" or tonumber((destGUID):sub(9,12),16)) == 39863 then
            if self.Settings["REPORT_PARRYHASTE"] then
                self:ReportParryHaste(sourceName,destName)
            end
        end
    elseif event == "SWING_LEECH" then
        local amount, powerType, extraAmount = select(12, ...)
        local valueType = 2
    elseif event:sub(1, 5) == "RANGE" then
        local spellId, spellName, spellSchool = select(9, ...)
        if event == "RANGE_DAMAGE" then
            local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(12, ...)

            if contains(reportDamageOnTarget,destName) then
                self:ReportDamageOnTarget(sourceName,destName,spellId)
            end

            -- for fun!
            if overkill > 0 and #self.DataDeaths > 0 and destName == self.DataDeaths[#self.DataDeaths].Name and self.Settings["KILLINGBLOW"] then
                self:RaidReport(self:FormatKillingBlow(sourceName,destName,spellId and GetSpellLink(spellId) or "a ranged attack",amount,overkill,critical))
            end
        elseif event == "RANGE_MISSED" then
            local missType = select(12, ...)
        end
    elseif event:sub(1, 5) == "SPELL" then
        local spellId, spellName, spellSchool = select(9, ...)

        if event == "SPELL_AURA_REMOVED" then
            if sourceName == "Lady Deathwhisper" then
                if spellName == "Mana Barrier" then
                    MPR_Timers:ManaBarrierRemoved()
                end
            end
        elseif event == "SPELL_CAST_START" or event == "SPELL_CAST_SUCCESS" then
            -- 1: Lord Marrowgar timers
            if sourceName == "Lord Marrowgar" then
                if spellName == "Bone Spike Graveyard" then
                    MPR_Timers:BoneSpikeGraveyard()
                    --self:RaidWarning(string.format("{rt8} Kill spikes!! {rt8}"))
                elseif spellName == "Bone Storm" then
                    MPR_Timers:BoneStorm()
                end
                -- 2: Lady Deathwhisper timers
                -- 3: Gunship Battle timers
            elseif sourceName == "Kor'kron Battle-Mage" or sourceName == "Skybreaker Sorcerer" then
                if spellName == "Below Zero" then --69705
                    MPR_Timers:BelowZero()
                end
                -- 4: Deathbringer Saurfang timers
            elseif sourceName == "Deathbringer Saurfang" then
                if spellName == "Rune of Blood" then --72410
                    MPR_Timers:RuneOfBlood()
                end
                -- 5: Festergut timers
                -- 6: Rotface timers
            elseif sourceName == "Rotface" then
                if spellName == "Slime Spray" then
                    MPR_Timers:SlimeSpray()
                elseif spellName == "Choking Gas Bomb" then
                    MPR_Timers:ChokingGasBomb()
                end
                -- 7: Professor Putricide timers
            elseif sourceName == "Professor Putricide" then
                if spellName == "Tear Gas" then
                    MPR_Timers:TearGas()
                elseif spellName == "Unstable Experiment" then
                    MPR_Timers:UnstableExperiment()
                elseif spellName == "Choking Gas Bomb" then
                    MPR_Timers:ChokingGasBomb()
                end
                -- 8: Blood Prince Council
            elseif sourceName == "Prince Keleseth" then
                if spellName == "Shadow Resonance" then
                    MPR_Timers:ShadowResonance()
                end
            elseif sourceName == "Prince Valanar" then
                if spellname == "Shock Vortex" then
                    MPR_Timers:ShockVortex()
                elseif spellName == "Empowered Shock Vortex" then
                    MPR_Timers:EmpoweredShockVortex()
                end
                -- 9: Blood-Queen Lana'thel
            elseif sourceName == "Blood-Queen Lana'thel" then
                if spellName == "Incite Terror" then
                    MPR_Timers:InciteTerror()
                elseif spellName == "Swarming Shadows" then
                    MPR_Timers:SwarmingShadows()
                end

                --[[
                -- 10: Valithria Dreamwalker timers
                elseif sourceName == "Valithria Dreamwalker" then
                    if spellName == "Summon Dream Portal" or spellName == "Summon Nightmare Portal" then
                        MPR_Timers:SummonPortal()
                    end
                ]]
                -- 11: Sindragosa
            elseif sourceName == "Sindragosa" then
                if spellName == "Icy Grip" then
                    MPR_Timers:BlisteringCold()
                elseif spellName == "Frost Beacon" then
                    MPR_Timers:FrostBeacon()
                end
                -- 12: The Lich King timers
            elseif sourceName == "The Lich King" then
                if spellId == 68981 or spellId == 74270 or spellId == 74271 or spellId == 74272 then -- Remorseless Winter
                    MPR_Timers:RemorselessWinter()
                elseif spellId == 69200 then -- Raging Spirit
                    MPR_Timers:RagingSpiritSummoned()
                elseif spellId == 72262 then -- Quake
                    MPR_Timers:Quake()
                elseif spellId == 72762 then -- Defile
                    MPR_Timers:Defile()
                elseif spellId == 73539 then -- Summon Shadow Trap (heroic only)
                    MPR_Timers:SummonShadowTrap()
                elseif spellId == 68980 or spellId == 74325 then --  Harvest Soul (normal only)
                    MPR_Timers:HarvestSoul()
                elseif spellId == 73654 or spellId == 74295 or spellId == 74296 or spellId == 74297 then -- Harvest Souls (heroic only)
                    MPR_Timers:HarvestSouls()
                elseif spellId == 72350 then -- Fury of Frostmourne
                    MPR_Timers:FuryOfFrostmourne()
                end
                -- 21: Baltharus the Warborn timers
            elseif sourceName == "Baltharus the Warborn" then
                if spellName == "Blade Tempest" then
                    MPR_Timers:BladeTempest(sourceGUID)
                end
                -- 22: General Zarithrian timers
            elseif sourceName == "General Zarithrian" then
                if spellName == "Cleave" then
                    MPR_Timers:ZarithrianCleave()
                elseif spellName == "Intimidating Roar" then
                    MPR_Timers:ZarithrianIntimidatingRoar()
                end
                -- 23: Halion timers
            elseif sourceName == "Halion" then
                if spellName == "Fiery Combustion" then
                    MPR_Timers:FieryCombustion()
                    self:Whisper(destName, GetSpellLink(spellId).." on you! Run to the wall!!")
                elseif spellName == "Soul Consumption" then
                    MPR_Timers:SoulConsumption()
                    self:Whisper(destName, GetSpellLink(spellId).." on you! Run to the wall!!")
                end
            end

            if spellName == "Necrotic Plague" then
                self:Whisper(destName, GetSpellLink(spellId).." on you! Run to a Shambling Horror!!")
            elseif sourceName == "Shadow Trap" and spellName == "Shadow Trap" then
                self:RaidReport(GetSpellLink(spellId)) --self:RaidReport("{rt8}{rt8}{rt8} "..GetSpellLink(spellId).." summoned! {rt8}{rt8}{rt8}")
            elseif spellName == "Swarming Shadows" then
                self:Whisper(destName, GetSpellLink(spellId).." on you! Run along walls!!")
            elseif spellId == 74502 then
                self:Whisper(destName, GetSpellLink(spellId).." on you! Run away!!")
            end

            if UnitInRaid(sourceName) or UnitInParty(sourceName) then
                if (spellName == "Heroism" or spellName == "Bloodlust") then
                    table.wipe(targetsHeroism)
                    casterHeroism = sourceName
                    self:ReportCast(sourceName,spellId)
                    self:ScheduleTimer("Heroism/BL", TimerHandler, 1, spellId)
                elseif contains(spellsCast,spellName) or contains(spellsCast,spellId) then
                    if(spellName == "Aura Mastery") then
                        for _,aura in ipairs(paladinAuras) do
                            if UnitInRaid(sourceName) then
                                for i=1,40 do
                                    if UnitBuff("raid"..i, aura) then
                                        local caster = select(8, UnitBuff("raid"..i, aura))
                                        if caster then
                                            local cName = UnitName(caster)
                                            local uName = UnitName("raid"..i)
                                            if cName == uName and cName == sourceName then
                                                self:ReportAuraMasteryCast(sourceName,spellId,aura)
                                            end
                                        end
                                    end
                                end
                            elseif UnitInParty(sourceName) then
                                if UnitBuff("player", aura) then
                                    local caster = select(8, UnitBuff("player", aura))
                                    if caster then
                                        local cName = UnitName(caster)
                                        if cName == pName and cName == sourceName then
                                            self:ReportAuraMasteryCast(sourceName,spellId,aura)
                                        end
                                    end
                                end
                                for i=1,4 do
                                    if UnitBuff("party"..i, aura) then
                                        local caster = select(8, UnitBuff("party"..i, aura))
                                        if caster then
                                            local cName = UnitName(caster)
                                            local uName = UnitName("party"..i)
                                            if cName == uName and cName == sourceName then
                                                self:ReportAuraMasteryCast(sourceName,spellId,aura)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        self:ReportCast(sourceName,spellId)
                    end
                elseif (self.Settings["REPORT_TANKCDS"] and contains(tankCooldownsCast,spellName)) or
                        (self.Settings["REPORT_OTHERSPELLS"] and contains(otherSpellsCast,spellName)) then
                    self:ReportCast(sourceName,spellId)
                elseif (contains(spellsCastOnTarget,spellName)) or
                        (self.Settings["REPORT_OTHERSPELLS"] and contains(otherSpellsCastOnTarget,spellName)) then
                    if UnitInRaid(sourceName) then
                        for i=1,40 do
                            local uName = UnitName("raid"..i)
                            local uTarName = UnitName("raid"..i.."target")
                            if uName and destName == uName then
                                local icon = GetRaidTargetIndex("raid"..i)
                                if icon and contains(raidTargetIcons,icon,true) then
                                    self:ReportPlayerCastOnTarget(sourceName,destName,spellId,raidTargetIcons[icon])
                                    break
                                else
                                    self:ReportPlayerCastOnTarget(sourceName,destName,spellId)
                                    break
                                end
                            elseif uTarName and destName == uTarName then
                                local icon = GetRaidTargetIndex("raid"..i.."target")
                                if icon and contains(raidTargetIcons,icon,true) then
                                    self:ReportPlayerCastOnTarget(sourceName,destName,spellId,raidTargetIcons[icon])
                                    break
                                else
                                    self:ReportPlayerCastOnTarget(sourceName,destName,spellId)
                                    break
                                end
                            end
                        end
                    elseif UnitInParty(sourceName) then
                        local tarName = UnitName("target")
                        if destName == pName then
                            local icon = GetRaidTargetIndex("player")
                            if icon and contains(raidTargetIcons,icon,true) then
                                self:ReportPlayerCastOnTarget(sourceName,destName,spellId,raidTargetIcons[icon])
                            else
                                self:ReportPlayerCastOnTarget(sourceName,destName,spellId)
                            end
                        elseif tarName and destName == tarName then
                            local icon = GetRaidTargetIndex("target")
                            if icon and contains(raidTargetIcons,icon,true) then
                                self:ReportPlayerCastOnTarget(sourceName,destName,spellId,raidTargetIcons[icon])
                            else
                                self:ReportPlayerCastOnTarget(sourceName,destName,spellId)
                            end
                        else
                            for i=1,4 do
                                local uName = UnitName("party"..i)
                                local uTarName = UnitName("party"..i.."target")
                                if uName and destName == uName then
                                    local icon = GetRaidTargetIndex("party"..i)
                                    if icon and contains(raidTargetIcons,icon,true) then
                                        self:ReportPlayerCastOnTarget(sourceName,destName,spellId,raidTargetIcons[icon])
                                    else
                                        self:ReportPlayerCastOnTarget(sourceName,destName,spellId)
                                    end
                                elseif uTarName and destName == uTarName then
                                    local icon = GetRaidTargetIndex("party"..i.."target")
                                    if icon and contains(raidTargetIcons,icon,true) then
                                        self:ReportPlayerCastOnTarget(sourceName,destName,spellId,raidTargetIcons[icon])
                                        break
                                    else
                                        self:ReportPlayerCastOnTarget(sourceName,destName,spellId)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            elseif contains(spellsBossCastOnTarget,spellName) then
                self:ReportBossCastOnTarget(spellId,destName)
            elseif contains(npcSpellsCast,spellName) then
                self:ReportCast(sourceName,spellId)
            end

        elseif event == "SPELL_CREATE" then
            if UnitInRaid(sourceName) or UnitInParty(sourceName) then
                if spellId ~= 61993 then  -- Filtering out the second 'Ritual of Summoning' event
                    if contains(spellsCreate,destName,true) then
                        self:ReportSpellCreate(sourceName,spellId)
                        self:CancelTimer(destName)
                        self:ScheduleTimer(destName, TimerHandler, spellsCreate[destName]-30, spellId)
                    end
                end
            end
        elseif event == "SPELL_SUMMON" then
            if spellId == 69037 or spellId == 71844 then -- Summon Val'kyr
                MPR_Timers:SummonValkyr(tonumber(string.sub(destGUID,9,12),16).."-"..tonumber(string.sub(destGUID,13),16))
            elseif sourceName == "Lady Deathwhisper" and spellName == "Summon Spirit" then
                MPR_Timers:SummonVengefulShade()
            end

            if contains(npcSpellSummon,destName) then
                self:ReportSummon(sourceName,destName,spellId)
            elseif contains(npcBossSpellSummon,destName) then
                self:ReportBossSummon(destName,spellId)
            end
        elseif event == "SPELL_DAMAGE" then
            local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(12, ...)

            if contains(spellsDamage,spellName) and UnitIsPlayer(destName) then
                self:ReportSpellDamage(spellId,destName,amount,critical)
            elseif contains(spellsAOEDamage,spellName) and UnitIsPlayer(destName) then
                if not nameSpellAOEDamage then
                    nameSpellAOEDamage = spellName
                elseif nameSpellAOEDamage ~= spellName then
                    return
                end

                self:CancelTimer("Spell AOE Damage")
                self:ScheduleTimer("Spell AOE Damage", TimerHandler, 0.5, spellId)

                targetsSpellAOEDamage[destName] = {Amount = amount, Overkill = overkill}
            elseif contains(reportDamageOnTarget,destName) then
                self:ReportDamageOnTarget(sourceName,destName,spellId)
                --elseif spellId == 71447 or spellId == 71481 then -- Blood-Queen Lana'thel: Bloodbolt Splash
                --    if not self:IsTimerScheduled("Bloodbolt Splash") then
                --        self:ScheduleTimer("Bloodbolt Splash", TimerHandler, 1, spellId)
                --    end
                --    table.insert(BS_TargetsName,destName)
                --    table.insert(BS_TargetsAmount,amount)
            end

            -- for fun!
            if overkill > 0 and #self.DataDeaths > 0 and destName == self.DataDeaths[#self.DataDeaths].Name and self.Settings["KILLINGBLOW"] then
                self:RaidReport(self:FormatKillingBlow(sourceName,destName,GetSpellLink(spellId),amount,overkill,critical))
            end
        elseif event == "SPELL_HEAL" then
            local amount, overheal, absorbed, critical = select(12, ...)
            local school = spellSchool

            if contains(spellsHeal,spellName) then
                self:ReportSpellHeal(spellId,destName,amount,critical)
            end
        elseif event:sub(1, 14) == "SPELL_PERIODIC" then
            if event == "SPELL_PERIODIC_DAMAGE" then
                local amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = select(12, ...)

                if spellName == "Pain and Suffering" and UnitInRaid(destName) then
                    local Debuff, _, _, Count = UnitDebuff(destName,"Pain and Suffering")
                    if Debuff and Count == 5 then
                        self:Whisper(destName, GetSpellLink(spellId).." (5 stacks) on you! Spread!! ("..amount.." damage)")
                    end
                end

                if contains(spellsPeriodicDamage,spellName) and UnitInRaid(destName) then
                    self:ReportSpellDamage(spellId,destName,amount,critical)
                end

                -- for fun!
                if overkill > 0 and #self.DataDeaths > 0 and destName == self.DataDeaths[#self.DataDeaths].Name and self.Settings["KILLINGBLOW"] then
                    self:RaidReport(self:FormatKillingBlow(sourceName,destName,"a periodic tick of "..GetSpellLink(spellId),amount,overkill,critical))
                end
            elseif event == "SPELL_PERIODIC_HEAL" then
                local amount, overheal, absorbed, critical = select(12, ...)
                local school = spellSchool

                if contains(spellsPeriodicHeal,spellName) then
                    self:ReportSpellHeal(spellId,destName,amount,critical)
                end
            end
        elseif event == "SPELL_DISPEL" then
            local extraSpellId, extraSpellName, extraSpellSchool, auraType = select(12, ...)

            if extraSpellName == "Necrotic Plague" and sourceName ~= destName then
                --self:Whisper(destName, GetSpellLink(extraSpellId).." dispeled from you!")
            end
            if UnitInRaid(sourceName) or UnitInParty(sourceName) then
                if self.Settings["REPORT_DISPELS"] and (spellName ~= "Mass Dispel" or self.Settings["REPORT_MASSDISPELS"]) then
                    if not contains(ignoreDispels,extraSpellName) then
                        self:ReportDispel(sourceName,destName,extraSpellId)
                    end
                end
            end
        elseif event == "SPELL_AURA_APPLIED" then
            local auraType = select(12, ...)

            if spellName == "Gas Spore" then
                MPR_Timers:GasSpore()
            elseif spellName == "Gastric Bloat" then
                MPR_Timers:GastricBloat()
            elseif sourceName == "Professor Putricide" then
                if spellName == "Vile Gas" then
                    MPR_Timers:VileGas()
                end
            elseif spellName == "Mutated Infection" then
                MPR_Timers:MutatedInfection()
            elseif spellName == "Invocation of Blood" then
                MPR_Timers:InvocationOfBlood(destName)
                BPC_ChangeTarget(destName)
            end

            if spellName == "Frost Beacon" then
                MPR_Timers:FrostBeacon()
                self:Whisper(destName, GetSpellLink(70126).." on you! Run away from others!!")
            elseif spellName == "Gaseous Bloat" and UnitIsPlayer(destName) then
                self:Whisper(destName, GetSpellLink(spellId).." on you! Kite it!!")
            elseif spellId == 33786 then -- Cyclone
                self:ReportPlayerCastOnTarget(sourceName,destName,spellId)
            end

            if sourceName == "Sindragosa" and spellName == "Instability" and UnitInRaid(destName) then
                local Debuff, _, _, Count = UnitDebuff(destName,"Instability")
                if Debuff == "Instability" and Count == 8 then
                    self:Whisper(destName, GetSpellLink(spellId).." (8 stacks) on you! Stop casting!!")
                end
            elseif sourceName == "Sindragosa" and spellName == "Chilled to the Bone" and UnitInRaid(destName) then
                local Debuff, _, _, Count = UnitDebuff(destName,"Chilled to the Bone")
                if Debuff and Count == 10 then
                    self:Whisper(destName, GetSpellLink(spellId).." (10 stacks) on you! Stop attacking!!")
                end
            end

            if UnitInRaid(sourceName) or UnitInParty(sourceName) then
                if contains(aurasApplied,spellName) then
                    if spellId == 75490 then -- [Eyes of Twilight]
                        local itemID = 54573 -- [Glowing Twilight Scale] (271)
                        self:ReportItemUsed(sourceName,itemID)
                    elseif spellId == 75495 then -- [Eyes of Twilight]
                        local itemID = 54589 -- [Glowing Twilight Scale] (284)
                        self:ReportItemUsed(sourceName,itemID)
                    else
                        self:ReportApplied(sourceName,spellId)
                    end
                elseif contains(tankAurasApplied,spellName) and self.Settings["REPORT_TANKCDS"] then
                    if spellId == 71635 then -- [Aegis of Dalaran]
                        local itemID = 50361 -- [Sindragosa's Flawless Fang] (264)
                        self:ReportItemUsed(sourceName,itemID)
                    elseif spellId == 71638 then -- [Aegis of Dalaran]
                        local itemID = 50364 -- [Sindragosa's Flawless Fang] (277)
                        self:ReportItemUsed(sourceName,itemID)
                    elseif spellName == "Ardent Defender" then
                        self:ReportProcced(sourceName,spellId)
                    else
                        self:ReportApplied(sourceName,spellId)
                    end
                end
            end

            if contains(aurasAppliedOnTarget,spellName) and UnitIsPlayer(sourceName) and UnitIsPlayer(destName) then
                self:ReportPlayerCastOnTarget(sourceName,destName,spellId)
            elseif contains(aurasAppliedOnTarget,spellName) and not UnitIsPlayer(sourceName) and UnitIsPlayer(destName) then
                if destName == UnitName("player") and contains(sayAuraOnMe,spellName) then
                    self:Say(sayAuraOnMe[spellName])
                end
                self:ReportAppliedOnTarget(spellId,destName)
            elseif contains(aurasAppliedOnTargets,spellName) then
                if destName == UnitName("player") and contains(sayAuraOnMe,spellName) then
                    self:Say(sayAuraOnMe[spellName])
                end
                table.insert(targetsAura,destName)
                self:CancelTimer("Aura Targets")
                self:ScheduleTimer("Aura Targets", TimerHandler, 0.5, spellId)
            elseif (spellName == "Heroism" or spellName == "Bloodlust") and sourceName == casterHeroism and UnitIsPlayer(destName) then
                table.insert(targetsHeroism,destName)
                -- 20: Saviana Ragefire timers
            elseif spellName == "Enrage" and destName == "Saviana Ragefire" then
                MPR_Timers:SavianaEnrage()
                self:ReportAppliedOnTarget(spellId,destName)
                --elseif contains({70952,70982,70981},spellId) then -- BPC: Target Switch
                --BPC_ChangeTarget(destName)
            elseif spellName == "Essence of the Blood Queen" and UnitIsPlayer(destName) then
                --self:Whisper(destName, "Bite on you! (+100% dmg)")
            elseif spellName == "Frenzied Bloodthirst" and UnitIsPlayer(destName) then
                self:Whisper(destName, "You have to bite!!")
            elseif spellName == "Uncontrollable Frenzy" and UnitIsPlayer(destName) then
                --self:Whisper(destName, "You failed to bite.")
                self:RaidReport(string.format("%s failed to bite.", destName))
            elseif spellName == "Touch of Jaraxxus" then -- Jaraxxus: Touch of Jaraxxus
                self:Whisper(destName, GetSpellLink(spellId).." on you! Run away till debuff is gone!!")
            elseif spellName == "Incinerate Flesh" then -- Jaraxxus: Incinerate Flesh
                self:ReportAppliedOnTarget(spellId,destName)
            end
        elseif event == "SPELL_AURA_APPLIED_DOSE" then
            local auraType, amount = select(12, ...)
            if contains(stackAppliedOnTarget,spellName) then
                self:ReportStacksOnTarget(destName,spellId,amount)
            end
        elseif event == "SPELL_RESURRECT" and spellId == 48477 then -- Rebirth (Druid)
            self:ReportCombatResurrect(sourceName,spellId,destName)
        end
    end
end

function MPR:CHAT_MSG_MONSTER_YELL(Message, Sender)
    for ID,Data in pairs(self.BossData) do
        if Data["MSG_FINISH"] and Data["MSG_FINISH"] == Message then
            self:StopCombat()
            -- No break, some Trial of the Crusader quotes end and start encounters at same time (Northrend Beasts)
        end
        if Data["MSG_START"] and Data["MSG_START"] == Message then
            local EncounterName = Data["ENCOUNTER"]
            StartChecks = 60
            StartCheck("nil", ID)
            break
        end
    end

    if BossRaidYells[Message] then
        self:RaidReport(BossRaidYells[Message])
    end

    if BossYells[Message] then
        self:Say(BossYells[Message])
    end

    -- for MPR_Timers
    if Sender == "Valithria Dreamwalker" and Message == "I have opened a portal into the Emerald Dream. Your salvation lies within, heroes." then
        MPR_Timers:SummonPortal()
    elseif Sender == "Sindragosa" then
        if Message == "Your incursion ends here! None shall survive!" then
            MPR_Timers:AirPhase()
        elseif Message == "Now feel my master's limitless power and despair!" then
            MPR_Timers:SecondPhase()
        end
    elseif Sender == "General Zarithrian" and Message == "Turn them to ash, minions!" then
        MPR_Timers:ZarithrianSummonAdds()
    elseif Sender == "Halion" then
        if Message == "The heavens burn!" then
            MPR_Timers:MeteorStrike()
        elseif Message == "You will find only suffering within the realm of twilight! Enter if you dare!" then
            MPR_Timers:PhaseTwo()
        elseif Message == "Beware the shadow!" then
            self:ScheduleTimer("Halion:TwilightCutter", TimerHandler, 5)
        end
    end
end

function MPR:FormatKillingBlow(Player,Target,Ability,Amount,Overkill,Critical)
    return string.format(Player.." finished off "..Target.."%s%s%s%s%s%s%s%s!",
        MPR.Settings["KILLINGBLOW_ABILITY"] and " with "..(Ability or "unk") or "",
        (MPR.Settings["KILLINGBLOW_AMOUNT"] or MPR.Settings["KILLINGBLOW_OVERKILL"] or (MPR.Settings["KILLINGBLOW_CRITICAL"] and Critical)) and " (" or "",
        MPR.Settings["KILLINGBLOW_AMOUNT"] and "A: "..(Amount or 0) or "",
        MPR.Settings["KILLINGBLOW_AMOUNT"] and MPR.Settings["KILLINGBLOW_OVERKILL"] and " / " or "",
        MPR.Settings["KILLINGBLOW_OVERKILL"] and "O: "..(Overkill or 0) or "",
        (MPR.Settings["KILLINGBLOW_AMOUNT"] or MPR.Settings["KILLINGBLOW_OVERKILL"]) and MPR.Settings["KILLINGBLOW_CRITICAL"] and Critical and ", " or "",
        MPR.Settings["KILLINGBLOW_CRITICAL"] and Critical and "Crit." or "",
        (MPR.Settings["KILLINGBLOW_AMOUNT"] or MPR.Settings["KILLINGBLOW_OVERKILL"] or (MPR.Settings["KILLINGBLOW_CRITICAL"] and Critical)) and ")" or "")
end

--[[ SWING_DAMAGE, SPELL_DAMAGE, SPELL_PERIODIC_DAMAGE, SPELL_HEAL, SPELL_PERIODIC_HEAL ]]--
function MPR:ReportSpellDamage(SPELL,TARGET,AMOUNT,CRIT) -- [Spell] hits Target for Amount [(Critical)]
    local CRIT = CRIT and " (Critical)" or ""
    self:HandleReport(nil, string.format("%s hits %s for %s%s",spell(SPELL),unit(TARGET),numformat(AMOUNT),CRIT))
end
function MPR:ReportSpellHeal(SPELL,TARGET,AMOUNT,CRIT) -- [Spell] heals Target for Amount [(Critical)]
    local CRIT = CRIT and " (Critical)" or ""
    self:HandleReport(string.format("%s heals %s for %s%s",spell(SPELL,true),TARGET,numformat(AMOUNT),CRIT), string.format("%s heals %s for %s%s",spell(SPELL),unit(TARGET),numformat(AMOUNT),CRIT))
end
function MPR:ReportDamageOnTarget(UNIT,TARGET,SPELL) -- Unit damages Target with [Spell]
    self:HandleReport(nil, self:SelfReport(string.format("%s damages %s with %s",unit(UNIT),unit(TARGET),spell(SPELL))))
    -- string.format("%s damages %s with %s",UNIT,TARGET,spell(SPELL,true))
end

--[[ SPELL_SUMMON ]]--
function MPR:ReportSummon(UNIT,TARGET,SPELL) -- Unit summons Target ([Spell])
    self:HandleReport(string.format("%s summons %s (%s)",UNIT,TARGET,spell(SPELL,true)), string.format("%s summons %s (%s)",unit(UNIT),unit(TARGET),spell(SPELL)))
end
function MPR:ReportBossSummon(TARGET,SPELL) -- Target summoned ([Spell])
    self:HandleReport(string.format("%s summoned (%s)",TARGET,spell(SPELL,true)), string.format("%s summoned (%s)",unit(TARGET),spell(SPELL)))
end

--[[ SPELL_CAST_START, SPELL_CAST_SUCCESS ]]--
function MPR:ReportCast(UNIT,SPELL) -- Unit casts [Spell]
    self:HandleReport(string.format("%s casts %s",UNIT,spell(SPELL,true)), string.format("%s casts %s",unit(UNIT),spell(SPELL)))
end
function MPR:ReportPlayerCastOnTarget(UNIT,TARGET,SPELL,ICON) -- Unit casts [Spell] on {RaidIcon} Target
    if ICON then
        self:HandleReport(string.format("%s casts %s on %s %s",UNIT,spell(SPELL,true),ICON[2],TARGET), string.format("%s casts %s on %s %s",unit(UNIT),spell(SPELL),ICON[1],unit(TARGET)))
    else
        self:HandleReport(string.format("%s casts %s on %s",UNIT,spell(SPELL,true),TARGET), string.format("%s casts %s on %s",unit(UNIT),spell(SPELL),unit(TARGET)))
    end
end
function MPR:ReportAuraMasteryCast(UNIT,SPELL,AURA) -- Unit casts [Spell] (Aura)
    self:HandleReport(string.format("%s casts %s (%s)",UNIT,spell(SPELL,true),spell(AURA)), string.format("%s casts %s (%s)",unit(UNIT),spell(SPELL),spell(AURA)))
end

--[[ SPELL_AURA_APPLIED ]]--
function MPR:ReportBossCastOnTarget(SPELL,TARGET) -- [Spell] on Target
    self:HandleReport(string.format("%s on %s",spell(SPELL,true),TARGET), string.format("%s on %s",spell(SPELL),unit(TARGET)))
end
function MPR:ReportAppliedOnTarget(SPELL,TARGET) -- [Spell] applied on Target
    self:HandleReport(string.format("%s applied on %s",spell(SPELL,true),TARGET), string.format("%s applied on %s",spell(SPELL),unit(TARGET)))
end
function MPR:ReportItemUsed(UNIT,ITEM)  -- Unit used [Item]
    self:HandleReport(string.format("%s used %s",UNIT,item(ITEM)), string.format("%s used %s",unit(UNIT),item(ITEM)))
end
function MPR:ReportApplied(UNIT,SPELL) -- Unit gains [Spell]
    self:HandleReport(string.format("%s gains %s",UNIT,spell(SPELL,true)), string.format("%s gains %s",unit(UNIT),spell(SPELL)))
end
function MPR:ReportProcced(UNIT,SPELL) -- [Spell] procced on Unit
    self:HandleReport(string.format("%s procced on %s",spell(SPELL,true),UNIT), string.format("%s procced on %s",spell(SPELL),unit(UNIT)))
end

--[[ SPELL_AURA_APPLIED_DOSE ]]--
function MPR:ReportStacksOnTarget(TARGET,SPELL,AMOUNT) -- Target has Amount stacks of [Spell]
    self:HandleReport(string.format("%s has %i stacks of %s",TARGET,AMOUNT,spell(SPELL,true)), string.format("%s has %i stacks of %s",unit(TARGET),AMOUNT,spell(SPELL)))
end

--[[ SPELL_DISPEL ]]--
function MPR:ReportDispel(UNIT,TARGET,SPELL) -- Unit dispels Target ([Spell])
    self:HandleReport(string.format("%s dispels %s (%s)",UNIT,TARGET,spell(SPELL,true)), string.format("%s dispels %s (%s)",unit(UNIT),unit(TARGET),spell(SPELL)))
end

--[[ PARRY_HASTE ]]--
function MPR:ReportParryHaste(UNIT,TARGET) -- Unit has caused a PARRY by Target
    self:HandleReport(string.format("%s has caused a PARRY by %s",UNIT,TARGET), string.format("%s has caused a PARRY by %s",unit(UNIT),TARGET))
end

--[[ SPELL_CREATE ]]--
function MPR:ReportSpellCreate(UNIT,SPELL) -- Unit prepares [Spell]
    self:HandleReport(string.format("%s prepares %s",UNIT,spell(SPELL,true)), string.format("%s prepares %s",unit(UNIT),spell(SPELL)))
end

--[[ SPELL_RESURRECT ]]-- only Druid Rebirth
function MPR:ReportCombatResurrect(UNIT,SPELL,TARGET) -- Unit resurrects Target ([Spell])
    self:HandleReport(string.format("%s resurrects %s (%s)",UNIT,TARGET,spell(SPELL,true)), string.format("%s resurrects %s (%s)",unit(UNIT),unit(TARGET),spell(SPELL)))
end

function MPR:ReportValkyrGrab(UNIT) -- X Unit grabbed! X
    self:HandleReport(string.format(raidTargetIcons[7][2] .. " %s grabbed! " .. raidTargetIcons[7][2],UNIT),string.format(raidTargetIcons[7][1] .. " %s grabbed! " .. raidTargetIcons[7][1],unit(UNIT)))
end

function MPR:CanReportToRaid()
    return true
end

-- REPORT HANDLER
-- Unformatted (string) - colors and images not allowed (unsupported)
-- Formatted (string) - string supporting colors and images
function MPR:HandleReport(Unformatted, Formatted, IgnoreRaidSettings, WithoutChannelPrefix)
    if Unformatted and (self.Settings["RAID"] or IgnoreRaidSettings) then
        if not self:CanReportToRaid() then return end
        if GetNumRaidMembers() > 0 then
            self:RaidReport(Unformatted, IgnoreRaidSettings, WithoutChannelPrefix)
        elseif GetNumPartyMembers() > 0 then
            self:PartyReport(Unformatted)
        end
    elseif Formatted and self.Settings["SELF"] then
        self:SelfReport(Formatted,true)
    end
end

-- Just adds MPR prefix.
function MPR:SelfReport(msg, short)
    DEFAULT_CHAT_FRAME:AddMessage("|cFF"..self.Colors["TITLE"].."|HMPR:Options:Show:nil|h["..(short and "MPR" or "MP Reporter").."]|h:|r "..msg, tonumber(self.Colors["TEXT"]:sub(1,2),16)/255, tonumber(self.Colors["TEXT"]:sub(3,4),16)/255, tonumber(self.Colors["TEXT"]:sub(5,6),16)/255)
end


-- Just adds MPR channel prefix
function MPR:RaidReport(msg, ...)
    local prefixText = MPR.Settings["PREFIX_VALUE"] .. " "
    local rrBypass, prefixBypass = ...
    if not (msg and (self.Settings["RAID"] or rrBypass)) then return end
    if not prefixBypass then
        SendChatMessage(prefixText .. msg, "RAID")
    else
        SendChatMessage(msg, "RAID")
    end
end

function MPR:PartyReport(msg, ...)
    local prefixText = MPR.Settings["PREFIX_VALUE"] .. " "
    local prBypass, prefixBypass = ...
    if not (msg and (self.Settings["RAID"] or prBypass)) then return end
    if not prefixBypass then
        SendChatMessage(prefixText .. msg, "PARTY")
    else
        SendChatMessage(msg, "PARTY")
    end
end

-- Raid Warning
function MPR:RaidWarning(MESSAGE, ...)
    local rwBypass = ...
    if not (MESSAGE and (self.Settings["RAID"] or rwBypass)) then return end
    SendChatMessage(MESSAGE, "RAID_WARNING")
end

-- Guild Message
function MPR:Guild(MESSAGE, ...)
    local prefixText = MPR.Settings["PREFIX_VALUE"] .. " "
    if not (MESSAGE) then return end
    local noPrefix = ...
    SendChatMessage((noPrefix and "" or prefixText)..MESSAGE, "GUILD")
end

-- Whisper Message
function MPR:Whisper(TARGET, MESSAGE, ...)
    local prefixText = MPR.Settings["PREFIX_VALUE"] .. " "
    local wBypass = ...
    if not (MESSAGE and (self.Settings["WHISPER"] or wBypass)) then return end
    if UnitName("player") ~= TARGET then
        SendChatMessage(prefixText .. MESSAGE, "WHISPER", nil, TARGET)
    else -- Don't whisper myself, print with :SelfReport()
        self:SelfReport(MESSAGE)
    end
end

-- Say Message
function MPR:Say(MESSAGE, ...)
    local smBypass = ...
    if not (MESSAGE and (self.Settings["SAY"] or smBypass)) then return end
    SendChatMessage(MESSAGE, "SAY")
end

--[[-------------------------------------------------------------------------
    Other Methods
---------------------------------------------------------------------------]]
function MPR:ReportLocks(Player)
    local Locks = {}
    for i=1,GetNumSavedInstances() do
        local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(i)
        if isRaid and InstanceShortNames[name] then
            table.insert(Locks, string.format("%s %s (%i)",InstanceShortNames[name],RaidDifficulty[difficulty],id))
        end
    end
    if #Locks > 0 then
        SendChatMessage(string.format("Raid Locks: %s",table.concat(Locks,", ")), "WHISPER", nil, Player)
    else
        SendChatMessage("No Raid Locks.", "WHISPER", nil, Player)
    end
end

function MPR:GetGuildMemberInfo(Name)
    local Searching, i = true, 0
    while Searching do
        i = i + 1
        local n = GetGuildRosterInfo(i)
        if not n then break end
        if Name == n then
            return i, GetGuildRosterInfo(i)
        end
    end
end

function MPR:ReportCommands()
    for _,line in pairs(mprCommands) do
        MPR:SelfReport(line,true)
    end
end

function MPR:UpdateBackdrop()
    local Backdrop, BackdropColor, BackdropBorderColor = MPR.Settings["BACKDROP"], MPR.Settings["BACKDROPCOLOR"], MPR.Settings["BACKDROPBORDERCOLOR"]
    -- MPR Frame
    MPR.Title:SetText("|cFF"..self.Colors["TITLE"].."MP Reporter|r - Frame")
    MPR:SetBackdrop(MPR.Settings["BACKDROP"])
    MPR:SetBackdropColor(unpack(MPR.Settings["BACKDROPCOLOR"]))
    MPR:SetBackdropBorderColor(MPR.Settings["BACKDROPBORDERCOLOR"].R/255, MPR.Settings["BACKDROPBORDERCOLOR"].G/255, MPR.Settings["BACKDROPBORDERCOLOR"].B/255)
    -- MPR Options
    MPR_Options.Title:SetText("|cFF"..self.Colors["TITLE"].."MP Reporter|r ("..MPR.Version..") - Options")
    MPR_Options:SetBackdrop(Backdrop)
    MPR_Options:SetBackdropColor(unpack(BackdropColor))
    MPR_Options:SetBackdropBorderColor(BackdropBorderColor.R/255, BackdropBorderColor.G/255, BackdropBorderColor.B/255)
    -- MPR Aura Info
    MPR_AuraInfo.Title:SetText("|cff"..self.Colors["TITLE"].."MP Reporter|r - Aura Info")
    MPR_AuraInfo:SetBackdrop(Backdrop)
    MPR_AuraInfo:SetBackdropColor(unpack(BackdropColor))
    MPR_AuraInfo:SetBackdropBorderColor(BackdropBorderColor.R/255, BackdropBorderColor.G/255, BackdropBorderColor.B/255)
    -- MPR Ignore Dispel List
    MPR_Dispels.Title:SetText("|cff"..self.Colors["TITLE"].."MP Reporter|r - Ignore Dispel List")
    MPR_Dispels:SetBackdrop(Backdrop)
    MPR_Dispels:SetBackdropColor(unpack(BackdropColor))
    MPR_Dispels:SetBackdropBorderColor(BackdropBorderColor.R/255, BackdropBorderColor.G/255, BackdropBorderColor.B/255)
    -- MPR Timers
    MPR_Timers.Title:SetText("|cff"..MPR.Colors["TITLE"].."MPR|r Timers:")
    MPR_Timers:SetBackdrop(Backdrop)
    MPR_Timers:SetBackdropColor(unpack(BackdropColor))
    MPR_Timers:SetBackdropBorderColor(BackdropBorderColor.R/255, BackdropBorderColor.G/255, BackdropBorderColor.B/255)
    -- MPR Timer options
    MPR_Timers_Options.Title:SetText("|cff"..MPR.Colors["TITLE"].."MP Reporter|r - Timer options")
    MPR_Timers_Options:SetBackdrop(Backdrop)
    MPR_Timers_Options:SetBackdropColor(unpack(BackdropColor))
    MPR_Timers_Options:SetBackdropBorderColor(BackdropBorderColor.R/255, BackdropBorderColor.G/255, BackdropBorderColor.B/255)
    -- MPR DKP Penalties
    MPR_Penalties.Title:SetText("|cff"..self.Colors["TITLE"].."MP Reporter|r - DKP Penalties (for QuickDKP)")
    MPR_Penalties:SetBackdrop(Backdrop)
    MPR_Penalties:SetBackdropColor(unpack(BackdropColor))
    MPR_Penalties:SetBackdropBorderColor(BackdropBorderColor.R/255, BackdropBorderColor.G/255, BackdropBorderColor.B/255)
end

function MPR:CHAT_MSG_ADDON(prefix, msg, channel, sender)
    if prefix ~= "MPR" or sender == UnitName("player") then return end
    local arg1, arg2, arg3, arg4, arg5, arg6, arg7 = strsplit(":",msg)

    if arg1 == "request-version" then
        SendAddonMessage("MPR", "version:"..self.Version, "WHISPER", sender)
    elseif arg1 == "version" then
        AddonUsers[sender] = arg2
        self:ScheduleTimer("Report Users",report,3,true)
    elseif arg1 == "OptionCheck" then
        SendAddonMessage("MPR", "OptionReply:"..arg2..":"..tostring(self.Settings[arg2]), "WHISPER", sender)
    elseif arg1 == "OptionReply" then
        if arg3 == "true" then
            table.insert(RaidOptions, sender)
        end
    elseif arg1 == "VersionNotes" then
        msg = msg:sub(10)
        if arg2 == "get" then
            SendAddonMessage("MPR", "VersionNotes:"..self.Version..":"..table.concat(MPR.VersionNotes,":"), "WHISPER", sender)
        else
            if arg3 then
                self:SelfReport("|r|cFFFFFFFFWhat's new in |r|cFF00FF00"..arg2.."|r|cFFFFFFFF:")
                for _,line in pairs({arg3,arg4,arg5,arg6,arg7}) do
                    self:SelfReport("- "..line)
                end

            else
                self:SelfReport("No version notes given in |r|cFF00FF00"..arg2.."|r|cFFBEBEBE.")
            end
            self:SelfReport("|r|cFFFFFF00|HMPR:CopyUrl:https://github.com/freix1/MP-Reporter|h[Click here to get the latest version!]|h|r|cFFBEBEBE")
        end
    end
end

function MPR:ZONE_CHANGED_NEW_AREA()
    if self.Settings["CCL_ONLOAD"] then
        self:ClearCombatLog(true)
    end
end

function MPR:DefineSetting(name,default)
    if self.Settings[name] == nil then
        self.Settings[name] = default
    end
end

function MPR:ADDON_LOADED(addon)
    if addon ~= "MPR" then return end
    -- define settings if not set
    MPR_Settings = MPR_Settings or {}
    self.Settings = MPR_Settings
    self:DefineSetting("AURAINFO", true)
    self:DefineSetting("IGNOREDISPELS", ignoreDispels)
    self:DefineSetting("TIMERS", true)
    self:DefineSetting("SELF", false)
    self:DefineSetting("SELF", false)
    self:DefineSetting("RAID", false)
    self:DefineSetting("SAY", false)
    self:DefineSetting("WHISPER", false)
    self:DefineSetting("REPORTIN_DUNGEON", false)
    self:DefineSetting("REPORTIN_RAIDINSTANCE", true)
    self:DefineSetting("REPORTIN_BATTLEGROUND", false)
    self:DefineSetting("REPORTIN_ARENA", false)
    self:DefineSetting("REPORTIN_OUTSIDE", false)
    self:DefineSetting("REPORT_DISPELS", false)
    self:DefineSetting("REPORT_MASSDISPELS", false)
    self:DefineSetting("REPORT_PARRYHASTE", false)
    self:DefineSetting("REPORT_TANKCDS", false)
    self:DefineSetting("REPORT_OTHERSPELLS", false)
    self:DefineSetting("PD_REPORT", true)
    self:DefineSetting("PD_SELF", true)
    self:DefineSetting("PD_RAID", false)
    self:DefineSetting("PD_GUILD", false)
    self:DefineSetting("PD_WHISPER", false)
    self:DefineSetting("PD_LOG", true)
    self:DefineSetting("PREFIX_VALUE", "<MPR>")
    self:DefineSetting("T_SELF", true)
    self:DefineSetting("T_RAID", true)
    self:DefineSetting("TIMER_ANNOUNCES", MPR_Timers.DefaultTimerAnnounces)
    self:DefineSetting("UPDATEFREQUENCY", 0.1)
    self:DefineSetting("CCL_ONLOAD", true)
    self:DefineSetting("ICONS", false)
    self:DefineSetting("REPORT_LOOT", false)
    self:DefineSetting("REPORT_LOOT_BOP_ONLY", false)
    self:DefineSetting("PENALTIES_SELF", false)
    self:DefineSetting("PENALTIES_WHISPER", true)
    self:DefineSetting("PENALTIES_RAID", false)
    self:DefineSetting("PENALTIES_GUILD", false)
    self:DefineSetting("KILLINGBLOW", true)
    self:DefineSetting("KILLINGBLOW_ABILITY", true)
    self:DefineSetting("KILLINGBLOW_AMOUNT", true)
    self:DefineSetting("KILLINGBLOW_OVERKILL", true)
    self:DefineSetting("KILLINGBLOW_CRITICAL", true)
    local tmp = {"UOE","CGB","MG","BC","FB","ST"}
    for _,SP in pairs(tmp) do
        self:DefineSetting("PENALTIES_"..SP.."_LIST", true)
        self:DefineSetting("PENALTIES_"..SP.."_AUTO", false)
        self:DefineSetting("PENALTIES_"..SP.."_AMOUNT", 20)
    end
    local tmp = {"RL","RA","MT","MA"}
    for _,ROLE in pairs(tmp) do
        self:DefineSetting("PENALTIES_IGNORE_"..ROLE, false)
    end
    self:DefineSetting("PENALTIES_LIST_SHOWMAIN", true)
    self:DefineSetting("PENALTIES_LIST_SHOWAMOUNTOVERKILL", true)
    self:DefineSetting("PENALTIES_LIST_SHOWDEDUCTED", false)
    self:DefineSetting("PENALTIES_LIST_SHOWPENDING", true)
    self:DefineSetting("PENALTIES_LIST_SHOWSKIPPED", false)
    self:DefineSetting("PENALTIES_LIST_SHOWIGNORED", false)

    self:DefineSetting("BACKDROP", {
        bgFile = "Interface\\TabardFrame\\TabardFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 25, insets = {left = 4, right = 4, top = 4, bottom = 4}
    })
    self:DefineSetting("BACKDROPCOLOR", {0, 0, 0, 0.7})
    self:DefineSetting("BACKDROPBORDERCOLOR", {R = 30, G = 144, B = 255})

    MPR_Colors = MPR_Colors or {["TITLE"] = "1e90ff", ["TEXT"] = "bebebe", ["DKPDEDUCTION_LINK"] = "ff4400", ["BOSS"] = "ffffff"}
    self.Colors = MPR_Colors
    MPR_DataDeaths = MPR_DataDeaths or {}
    self.DataDeaths = MPR_DataDeaths
    MPR_DataPenalties = MPR_DataPenalties or {}
    self.DataPenalties = MPR_DataPenalties

    self:Initialize()
    MPR_Options:Initialize()
    MPR_AuraInfo:Initialize()
    MPR_Dispels:Initialize()
    MPR_Timers:Initialize()
    MPR_Penalties:Initialize()
    self:MPR_CopyURL_Initialize()
    SLASH_MPR1 = '/mpr';

    MPR_Data = MPR_Data or {}
    self.AddonData = MPR_Data
    local FirstTimeLoaded
    if not self.AddonData["LastLoadVersion"] or self.Version > self.AddonData["LastLoadVersion"] then
        self.AddonData["LastLoadVersion"] = self.Version
        FirstTimeLoaded = true
    end
    self:SelfReport(string.format("Addon (%s) loaded! |r|HMPR:Options:Show:nil|h|cff3588ff[Options]|h%s",self.Version,FirstTimeLoaded and "|r |cFF00FF00|HMPR:VersionNotes|h[Check what's new in "..self.Version.."!]|h" or ""))
    if self.Settings["CCL_ONLOAD"] then
        self:ClearCombatLog(true)
    end
    self:RegisterEvents()
    if IsInGuild() then
        SendAddonMessage("MPR", "request-version", "GUILD")
    end
    pName = UnitName("player")
end

MPR:RegisterEvent("ADDON_LOADED")

MPR_CopyURL = CreateFrame("frame", "MPR_CopyURL", UIParent)
function MPR:MPR_CopyURL_Initialize()
    MPR_CopyURL:Hide()

    MPR_CopyURL:SetBackdrop(MPR.Settings["BACKDROP"])
    MPR_CopyURL:SetBackdropColor(unpack(MPR.Settings["BACKDROPCOLOR"]))
    MPR_CopyURL:SetBackdropBorderColor(MPR.Settings["BACKDROPBORDERCOLOR"].R/255, MPR.Settings["BACKDROPBORDERCOLOR"].G/255, MPR.Settings["BACKDROPBORDERCOLOR"].B/255)

    MPR_CopyURL:SetPoint("CENTER",UIParent)
    MPR_CopyURL:SetWidth(450)
    MPR_CopyURL:SetHeight(60)
    MPR_CopyURL:SetFrameStrata("FULLSCREEN_DIALOG")

    MPR_CopyURL.Title = MPR_CopyURL:CreateFontString("Title"..GetNewID(), "ARTWORK", "GameFontNormal")
    MPR_CopyURL.Title:SetPoint("TOP", 0, -12)
    MPR_CopyURL.Title:SetTextColor(1,1,1)
    MPR_CopyURL.Title:SetText("|cFF"..MPR.Colors["TITLE"].."MP Reporter|r - Copy URL |cFFBEBEBE(Ctrl + C to copy address)|r")
    MPR_CopyURL.Title:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    MPR_CopyURL.Title:SetShadowOffset(1, -1)

    MPR_CopyURL_BtnClose = CreateFrame("button","MPR_CopyURL_BtnClose", MPR_CopyURL, "UIPanelButtonTemplate")
    MPR_CopyURL_BtnClose:SetHeight(14)
    MPR_CopyURL_BtnClose:SetWidth(50)
    MPR_CopyURL_BtnClose:SetPoint("TOPRIGHT", -12, -11)
    MPR_CopyURL_BtnClose:SetText("Close")
    MPR_CopyURL_BtnClose:SetScript("OnClick", function(self) self:GetParent():Hide() end)

    MPR_CopyURL.EditBox = CreateFrame("EditBox","MPR_CopyURL_EditBox", MPR_CopyURL, "InputBoxTemplate")
    MPR_CopyURL.EditBox:SetHeight(20)
    MPR_CopyURL.EditBox:SetWidth(420)
    MPR_CopyURL.EditBox:SetPoint("TOP", 0, -30)
    MPR_CopyURL.EditBox:SetTextColor(1,1,1)
    MPR_CopyURL.EditBox:SetText("")
    MPR_CopyURL.EditBox:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")

    MPR_CopyURL:SetScript("OnShow", function(self) self.EditBox:SetText(self.Address); self.EditBox:HighlightText() end)
    MPR_CopyURL.EditBox:SetScript("OnEscapePressed", function(self) self:GetParent():Hide() end)
    tinsert(UISpecialFrames, "MPR_CopyURL")
end

function MPR:Initialize()
    MPR:Hide()

    MPR:SetBackdrop(MPR.Settings["BACKDROP"])
    MPR:SetBackdropColor(unpack(MPR.Settings["BACKDROPCOLOR"]))
    MPR:SetBackdropBorderColor(MPR.Settings["BACKDROPBORDERCOLOR"].R/255, MPR.Settings["BACKDROPBORDERCOLOR"].G/255, MPR.Settings["BACKDROPBORDERCOLOR"].B/255)

    MPR:SetPoint("CENTER",UIParent)
    MPR:SetWidth(350)
    MPR:SetHeight(100)
    MPR:EnableMouse(true)
    MPR:SetMovable(true)
    MPR:SetResizable(true)
    MPR:SetMinResize(240, 80)
    MPR:SetMaxResize(480, 160)
    MPR:RegisterForDrag("LeftButton","RightButton")
    MPR:SetUserPlaced(true)
    MPR:SetScript("OnDragStart", function(self, button)
        if button == "LeftButton" then
            MPR:StartMoving()
        elseif button == "RightButton" then
            MPR:StartSizing()
        end
    end)
    MPR:SetScript("OnDragStop", function(self) MPR:StopMovingOrSizing() end)
    MPR:SetFrameStrata("DIALOG")

    MPR.Title = MPR:CreateFontString("Title", "ARTWORK", "GameFontNormal")
    MPR.Title:SetPoint("TOPLEFT", 96, -8)
    MPR.Title:SetTextColor(1,1,1)
    MPR.Title:SetText("|cFF"..self.Colors["TITLE"].."MP Reporter|r - Frame")
    MPR.Title:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
    MPR.Title:SetShadowOffset(1, -1)

    MPR.CombatTime = MPR:CreateFontString("CombatTime", "ARTWORK", "GameFontNormal")
    MPR.CombatTime:SetPoint("TOPRIGHT", MPR, "TOPLEFT", 40, -8)
    MPR.CombatTime:SetTextColor(1,1,1)
    MPR.CombatTime:SetText("0:51")
    --MPR.CombatTime:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)

    MPR.BerserkTime = MPR:CreateFontString("BerserkTime", "ARTWORK", "GameFontNormal")
    MPR.BerserkTime:SetPoint("TOPLEFT", 48, -8)
    MPR.BerserkTime:SetTextColor(1,0,0)
    MPR.BerserkTime:SetText("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:8:8|t17:00")
    --MPR.BerserkTime:SetFont("Fonts\\FRIZQT__.TTF", 10, nil)

    --MPR:Show()
end
