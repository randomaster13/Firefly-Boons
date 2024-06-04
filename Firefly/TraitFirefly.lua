function CreateFireflyBoon()
    game.TraitData.FireflyWeaponBoon = {
    --adding this to hermes
        Icon = "Boon_Hermes_01",
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
                Multiplier = 2.49,
            },
        },
	OnEnemyDamagedAction = 
	{
		ValidWeapons = game.WeaponSets.HeroPrimaryWeapons,			
		FunctionName = "ApplyDamageShare",
		Args = 
		{
			EffectName = "DamageShareEffect",
		},			
	},
        PropertyChanges = {
			{
				WeaponNames = game.WeaponSets.HeroPrimaryWeapons,
				WeaponProperty = "FireFx2",
				ChangeValue = "HermesSwipeLineC_Sword3",
				ChangeType = "Absolute",
			},
            {
                WeaponNames = game.WeaponSets.HeroPrimaryWeapons,
                BaseValue = 0.6,
                SourceIsMultiplier = true,
                SpeedPropertyChanges = true,
            }
        },
        WeaponSpeedMultiplier =
        {
            WeaponNames = game.WeaponSets.HeroPrimaryWeapons,
            Value = 
            {
                BaseValue = 0.6,
                SourceIsMultiplier = true,
            },
            ReportValues = { ReportedWeaponMultiplier = "Value" }
        },
        AllyDataModifiers =
        {
            SpeedMultiplier = { BaseValue = 1.40, SourceIsMultiplier = true },
        },
        Name = "FireflyWeaponBoon", -- Added this as a name so it doesnt cry about it
        StatLines =
		{
			"AttackSpeedStatDisplay1",
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
    
    game.TraitData.FireflyEffectBoon = {
        Icon = "Boon_Hermes_02",
        InheritFrom = { "BaseTrait", "EarthBoon" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.33,
			},
			Epic =
			{
				Multiplier = 1.67,
			},
			Heroic =
			{
				Multiplier = 2.00,
			},
		},
        BlockStacking = false,
		AddOutgoingDamageModifiers =
		{
			ValidWeaponMultiplier =
			{
				BaseValue = 1.50,
				SourceIsMultiplier = true,
				MinMultiplier = 0.125,
				IdenticalMultiplier =
				{
					Value = -0.75,
					DiminishingReturnsMultiplier = 0.5,
				},
			},
			ValidWeapons = game.WeaponSets.HeroPrimaryWeapons,
			ReportValues = { ReportedWeaponMultiplier = "ValidWeaponMultiplier"},
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = game.WeaponSets.HeroPrimaryWeapons,			
			FunctionName = "FireflyDamageShareApply",
			Args = 
			{
				EffectName = "FireflyShareDamageEffect",
			},			
		},

        StatLines =
        {
            "AttackDamageStatDisplay1",
        },

        ExtractValues =
        {
            {
                Key = "ReportedWeaponMultiplier",
                ExtractAs = "TooltipDamageBonus",
                Format = "PercentDelta",
            },
            {
                ExtractAs = "DamageShareDuration",
                SkipAutoExtract = true,
                External = true,
                BaseType = "EffectData",
                BaseName = "FireflyShareDamageEffect",
                BaseProperty = "Duration",
            },
            {
                ExtractAs = "DamageShareAmount",
                SkipAutoExtract = true,
                External = true,
                BaseType = "EffectData",
                BaseName = "FireflyShareDamageEffect",
                BaseProperty = "Amount",
                Format = "Percent",
                HideSigns = true,
            },
        },
    }
    
    table.insert(game.LootSetData.Hermes.HermesUpgrade.Traits, "FireflyWeaponBoon")
    table.insert(game.LootSetData.Hera.HeraUpgrade.Traits, "FireflyEffectBoon")
end

CreateFireflyBoon()

function printTable(tbl, indent)
    indent = indent or 0
    local formatting = string.rep("  ", indent)
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            print(formatting .. k .. ":")
            printTable(v, indent + 1)
        else
            print(formatting .. k .. ": " .. tostring(v))
        end
    end
end

-- Name and description
local TraitFirefly = sjson.to_object({
    Id = "FireflyWeaponBoon",
    InheritFrom = "BaseBoonMultiline",
    DisplayName = "A Million FireFlies",
    Description = "Your {$Keywords.AttackSet} are faster.",
}, Order) -- Don't forget the order, this is important

local TraitFirefly_02 = sjson.to_object({
    Id = "FireflyEffectBoon",
    InheritFrom = "BaseBoonMultiline",
    DisplayName = "Awake When I'm Asleep",
    Description = "Your {$Keywords.AttackSet} deal more damage and inflict {$Keywords.Link}.",
}, Order) -- Don't forget the order, this is important

-- Pass in the (Global) file name you defined in sjson.lua
sjson.hook(TraitTextFile, function(data)
    --data.texts is found at the top of the file, its the Texts table, it is different per file, second arguement is your local above
    table.insert(data.Texts, TraitFirefly)
    table.insert(data.Texts, TraitFirefly_02)
    print("Hermes Boon Hook completed")
end)

game.SetupRunData()
printTable(game.TraitData.HeraWeaponBoon)
print("\n\n##########\n##########\n\n")
printTable(game.TraitData.FireflyEffectBoon)
