-- Creating Firefly in LootData, allows for natural spawns etc
game.LootData.FireflyUpgrade = {
    -- Check all of these, unique or always static?
    SelectionSound = "/SFX/Menu Sounds/GeneralWhooshMENU",
    UseTextTalkAndSpecial = "UseLootAndSpecial",

    TextLinesIgnoreQuests = true,
    UseText = "UseLoot",
    NameplateSpeakerNameColor = {225, 225, 225, 255},
    UseTextTalkGiftAndSpecial = "UseLootGiftAndSpecial",
    NarrativeContextArtFlippable = false,
    NarrativeContextArt = "DialogueBackground_Olympus",
    NarrativeTextColor = {32, 32, 30, 255},
    NameplateDescriptionColor = {225, 135, 60, 255},
    BoxExitAnimation = "DialogueSpeechBubbleLightOut",
    BlockedLootInteractionText = "UseLootLocked",

    ColorGrade = "ZeusLightning",
    LootRejectionAnimation = "BoonDissipateA_Zeus",

    -- Might need these? check later
    UseTextTalkAndGift = "UseLootAndGift",
    BoonInfoTitleText = "Codex_BoonInfo_Artemis",

    -- Done Stuff 
    Name = "FireflyUpgrade",
    OffersElementalTrait = {"Fire", "Earth"},
    InheritFrom = {"BaseLoot", "BaseSoundPackage"},

    Gender = "Male",
    OnUsedFunctionName = "UseLoot",
    Weight = 10,
    GodLoot = true,
    DestroyOnPickup = true,

    GameStateRequirements = {{
        -- HasAny = {"PoseidonUpgrade", "DemeterUpgrade"},
        -- Path = {"GameState", "UseRecord"}
    }},
    Consumables = {},

    -- all stolen from hephestus
    SubtitleColor = { 255, 200, 40, 255 },
    Color = { 255, 100, 0, 255 },
	LightingColor = {255, 120, 0, 255},
	LootColor = {255, 90, 0, 255},

    SpeakerName = "OwlCity",
    SurfaceShopText = "FireflyUpgrade_Store",
    Portrait = "Portrait_Hermes_Default_01",
    Speaker = "NPC_Hermes_01",
    OverlayAnim = "HermesOverlay",
    UsePromptOffsetX = 80,
    UsePromptOffsetY = 48,
    AnimOffsetZ = 80,

    -- These might not be needed, or exist anywhere
    AlwaysShowDefaultUseText = true,
    LastRewardEligible = true,
    BanUnpickedBoonsEligible = true,
    ManualRecordUse = true,
    CanReceiveGift = true,

    Icon = "BoonSymbolArtemis",
    BoonInfoIcon = "BoonInfoSymbolArtemisIcon",
    SurfaceShopIcon = "BoonInfoSymbolArtemisIcon",
    MenuTitle = "UpgradeChoiceMenu_Artemis", -- in ScreenText.en line 199 for some reason
    ConfirmSound = "/SFX/Menu Sounds/GodBoonChoiceConfirm",
    LootRejectedText = "Player_GodDispleased_ArtemisUpgrade",
    SuperSacrificeCombatText = "SuperSacrifice_CombatText_ArtemisUpgrade",
    WrathPortrait = "Portrait_Artemis_Wrath_01",

    SpawnSound = "/SFX/ArtemisBoonArrow",
    UpgradeSelectedSound = "/SFX/ArtemisBoonChoice",
    PortraitEnterSound = "/EmptyCue",
    BoxAnimation = "DialogueSpeechBubble",
    FlavorTextIds = {"ArtemisUpgrade_FlavorText01", "ArtemisUpgrade_FlavorText02", "ArtemisUpgrade_FlavorText03"},

    DoorIcon = "BoonDropArtemisPreview",
    DoorUpgradedIcon = "BoonDropArtemisUpgradedPreview",
    EchoLastRewardId = "EchoLastRewardBoon_Artemis", -- This might need to have Upgrade at the end

    PriorityUpgrades = {"ArtemisWeaponBoon", "ArtemisSpecialBoon"},
    WeaponUpgrades = {"ArtemisWeaponBoon", "ArtemisSpecialBoon"},
    Traits = {"SupportingFireBoon", "CritBonusBoon", "DashOmegaBuffBoon", "HighHealthCritBoon", "InsideCastCritBoon",
              "OmegaCastVolleyBoon", "TimedCritVulnerabilityBoon", "ArtemisCriticalBoon"},

    TraitIndex = {},

    -- On First Spawn
    OnSpawnVoiceLines = {
        BreakIfPlayed = true,
        RandomRemaining = true,
        PlayOnceFromTableThisRun = true,
        PreLineWait = 0.85,
        SuccessiveChanceToPlay = 0.25,
        GameStateRequirements = {
            NamedRequirements = {"OlympianOnSpawnVoiceLinesAllowed"}
        },

        {
            Cue = "/VO/Melinoe_1472",
            Text = "It's her."
        }
    },

    UpgradeMenuOpenVoiceLines = {
        [1] = GlobalVoiceLines.HeraclesBoonReactionVoiceLines
    }

}

-- adding LootData Artemis to Codex, uses same as other artemis just without the enemy name
game.CodexData.OlympianGods.Entries.ArtemisUpgrade = {
    Entries = {{
        UnlockGameStateRequirements = {{
            Path = {"GameState", "UseRecord", "ArtemisUpgrade"},
            Comparison = ">=",
            Value = 2
        }},
        Text = "CodexData_Artemis_01"
    }},
    Image = "Codex_Portrait_Artemis"
}

-- Core Traits, aka Weapon Attack, Special, Cast etc
game.LinkedTraitData.ArtemisCoreTraits = {}

-- Need to add to boon info manually since this table is populated way before I do any inserts, plus it doesn't exist even if I have traitindex up in loot
local ArtemisTraitDictionary = {
    SupportingFireBoon = true,
    CritBonusBoon = true,
    DashOmegaBuffBoon = true,
    HighHealthCritBoon = true,
    InsideCastCritBoon = true,
    OmegaCastVolleyBoon = true,
    TimedCritVulnerabilityBoon = true,
    -- New Boons
    ArtemisWeaponBoon = true,
    ArtemisSpecialBoon = true,
    ArtemisCriticalBoon = true
}

game.ScreenData.BoonInfo.TraitDictionary.ArtemisUpgrade = ArtemisTraitDictionary
game.LootData.ArtemisUpgrade.TraitIndex = ArtemisTraitDictionary

-- This is to add Artemis to RunProgress in LootData so she can spawn as a boon room
local requirementName = {"MaxHealthDrop", "MaxManaDrop", "RoomMoneyDrop", "StackUpgrade", "Devotion"}

-- functions to Check names of the values in runprogress and tartarus rewards, and if name has a "count of", add artemis to it
local function requiredName(name)
    for _, reqname in ipairs(requirementName) do
        if name == reqname then
            return true
        end
    end
    return false
end

for _, entry in ipairs(game.RewardStoreData.RunProgress) do
    if requiredName(entry.Name) then
        for _, requirement in ipairs(entry.GameStateRequirements) do
            if requirement.CountOf then
                table.insert(requirement.CountOf, "ArtemisUpgrade")
            end
        end
    end
end

for _, entry in ipairs(game.RewardStoreData.TartarusRewards) do
    if requiredName(entry.Name) then
        for _, requirement in ipairs(entry.GameStateRequirements) do
            if requirement.CountOf then
                table.insert(requirement.CountOf, "ArtemisUpgrade")
            end
        end
    end
end
