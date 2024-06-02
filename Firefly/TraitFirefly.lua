function CreateFireflyBoon()
    game.TraitData.FireflyWeaponBoon = {
    --adding this to hermes
        Name = "FireflyWeaponBoon", -- Added this as a name so it doesnt cry about it
        Icon = "Boon_Hermes_28",
        InheritFrom = { "BaseTrait", "LegacyTrait", "EarthBoon" },
        RarityLevels =
        {
            Common =
            {
                Multiplier = 1.0,
            },
            Rare =
            {
                Multiplier = 1.5,
            },
            Epic =
            {
                Multiplier = 2.0,
            },
            Heroic =
            {
                Multiplier = 2.5,
            },
        },
        PropertyChanges = {
            {
                WeaponNames = game.WeaponSets.HeroPrimaryWeapons,
                BaseValue = 0.9,
                SourceIsMultiplier = true,
                SpeedPropertyChanges = true,
            }
        },
        WeaponSpeedMultiplier =
        {
            WeaponNames = game.WeaponSets.HeroPrimaryWeapons,
            Value = 
            {
                BaseValue = 0.9,
                SourceIsMultiplier = true,
            },
            ReportValues = { ReportedWeaponMultiplier = "Value" }
        },
        AllyDataModifiers =
        {
            SpeedMultiplier = { BaseValue = 1.10, SourceIsMultiplier = true },
        },
        StatLines =
        {
            "FireflyWeaponBoon", -- Changed this to the correct name
        },
        ExtractValues =
        {
            {
                    Key = "ReportedWeaponMultiplier",
                    ExtractAs = "TooltipDamageBonus",
                    Format = "NegativePercentDelta",
            },
        }
    }
    
    table.insert(game.LootSetData.Hermes.HermesUpgrade.Traits, "FireflyWeaponBoon")
end

CreateFireflyBoon()

-- Name and description
local TraitFirefly = sjson.to_object({
    Id = "FireflyWeaponBoon",
    InheritFrom = "BaseBoonMultiline",
    DisplayName = "A Million Fire Flies",
    Description = "Your {$Keywords.AttackSet} are faster.",
}, Order) -- Don't forget the order, this is important

-- Pass in the (Global) file name you defined in sjson.lua
sjson.hook(TraitTextFile, function(data)
    --data.texts is found at the top of the file, its the Texts table, it is different per file, second arguement is your local above
    table.insert(data.Texts, TraitFirefly)
    print("Hermes Boon Hook completed")
end)