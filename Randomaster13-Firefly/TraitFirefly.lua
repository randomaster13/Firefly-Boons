function CreateFireflyBoon()
	-- This boon is the burn and speed attack boon.
    game.TraitData.FireflyWeaponBoon = {
    --adding this to hermes
        Icon = "FireflyIcon_1",
        InheritFrom = { "BaseTrait", "LegacyTrait", "FireBoon" },
        RarityLevels =
        {
            Common =
            {
                Multiplier = 1.0,
            },
            Rare =
            {
                Multiplier = 1.17,
            },
            Epic =
            {
                Multiplier = 1.33,
            },
            Heroic =
            {
                Multiplier = 1.50,
            },
        },
        OnEnemyDamagedAction = 
		{
			ValidWeapons = game.WeaponSets.HeroPrimaryWeapons,
			FunctionName = "BurnEffectApply",
			Args = 
			{
				EffectName = "BurnEffect",
				NumStacks = 
				{
					BaseValue = 10,
					MinValue = 1,
					AbsoluteStackValues =
					{
						[1] = 3,
						[2] = 2,
                        [3] = 1,
					},
					AsInt = true,
				},
				ReportValues = { ReportedDamage = "NumStacks" }
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
                BaseValue = 0.925,
                SourceIsMultiplier = true,
                SpeedPropertyChanges = true,
                IdenticalMultiplier =
				{
					Value = -0.75,
					DiminishingReturnsMultiplier = 0.5,
				},
            }
        },
        WeaponSpeedMultiplier =
        {
            WeaponNames = game.WeaponSets.HeroPrimaryWeapons,
            Value = 
            {
                BaseValue = 0.925,
                SourceIsMultiplier = true,
            },
            ReportValues = { ReportedWeaponMultiplier = "Value" }
        },
        AllyDataModifiers =
        {
            SpeedMultiplier = { BaseValue = 1.075, SourceIsMultiplier = true },
        },
        Name = "FireflyWeaponBoon", -- Added this as a name so it doesnt cry about it
        StatLines =
		{
			"AttackSpeedStatDisplay1",
            "BurnDamageStatDisplay1",
		},
        ExtractValues =
        {
            {
                Key = "ReportedDamage",
                ExtractAs = "TooltipDamage",
            },
            {
				ExtractAs = "BurnRate",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "BurnEffect",
				BaseProperty = "DamagePerSecond",
				DecimalPlaces = 1,
			},
            {
                Key = "ReportedWeaponMultiplier",
                ExtractAs = "TooltipDamageBonus",
                Format = "NegativePercentDelta",
            },
        }
    }

    -- game.TraitData.FireflyTestBoon =
	-- {
	-- 	Icon = "Boon_Hestia_01",
	-- 	InheritFrom = { "BaseTrait", "FireBoon" },
	-- 	Slot = "Melee",
	-- 	RarityLevels =
	-- 	{
	-- 		Common =
	-- 		{
	-- 			Multiplier = 1.00,
	-- 		},
	-- 		Rare =
	-- 		{
	-- 			Multiplier = 1.25,
	-- 		},
	-- 		Epic =
	-- 		{
	-- 			Multiplier = 1.50,
	-- 		},
	-- 		Heroic =
	-- 		{
	-- 			Multiplier = 1.75,
	-- 		},
	-- 	},
	-- 	OnEnemyDamagedAction = 
	-- 	{
	-- 		ValidWeapons = game.WeaponSets.HeroPrimaryWeapons,			
	-- 		FunctionName = "ApplyBurn",
	-- 		Args = 
	-- 		{
	-- 			EffectName = "BurnEffect",
	-- 			NumStacks = 
	-- 			{
	-- 				BaseValue = 20,
	-- 				MinValue = 1,
	-- 				AbsoluteStackValues =
	-- 				{
	-- 					[1] = 5,
	-- 					[2] = 4,
	-- 					[3] = 3,
	-- 					[4] = 2,
	-- 					[5] = 1,
	-- 				},
	-- 				AsInt = true,
	-- 			},
	-- 			ReportValues = {ReportedDamage = "NumStacks"}
	-- 		},			
	-- 	},
    --     StatLines =
	-- 	{
	-- 		"BurnDamageStatDisplay1",
	-- 	},
	-- 	ExtractValues =
	-- 	{
	-- 		{
	-- 				Key = "ReportedDamage",
	-- 				ExtractAs = "TooltipDamage",
	-- 		},
	-- 		{
	-- 			ExtractAs = "BurnRate",
	-- 			SkipAutoExtract = true,
	-- 			External = true,
	-- 			BaseType = "EffectLuaData",
	-- 			BaseName = "BurnEffect",
	-- 			BaseProperty = "DamagePerSecond",
	-- 			DecimalPlaces = 1,
	-- 		},
	-- 	}
	-- }

	-- #############################
	-- This is the hitch effect boon
	-- #############################
    game.TraitData.FireflyEffectBoon = {
        Icon = "Boon_Hermes_02",
        Name = "FireflyTestBoon", -- Added this as a name so it doesnt cry about it
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
			FunctionName = "ApplyDamageShare",
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
	game.TraitData.FireflySprintBoon = {
		Icon = "Boon_Apollo_03",
		InheritFrom = { "BaseTrait", "FireBoon"},
		Slot = "Rush",
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 4/3,
			},
			Epic =
			{
				Multiplier = 5/3,
			},
			Heroic =
			{
				Multiplier = 2,
			},
		},
		OnSprintAction = 
		{
			AddIncomingDamageModifiers =
			{
				ValidWeaponMultiplier = 0.7,
				ReportValues = 
				{
					ReportedMultiplier = "ValidWeaponMultiplier"
				},
			},
		},
	}
    
    table.insert(game.LootSetData.Hera.HeraUpgrade.Traits, "FireflyWeaponBoon")
    table.insert(game.LootSetData.Hera.HeraUpgrade.Traits, "FireflyEffectBoon")
    ---table.insert(game.LootSetData.Hera.HeraUpgrade.Traits, "FireflyTestBoon")
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
    DisplayName = "Ten Million FireFlies",
    Description = "Your {$Keywords.AttackSet} are faster and inflict {$Keywords.Burn}.",
}, Order) -- Don't forget the order, this is important

local TraitFirefly_02 = sjson.to_object({
    Id = "FireflyEffectBoon",
    InheritFrom = "BaseBoonMultiline",
    DisplayName = "Awake When I'm Asleep",
    Description = "Your {$Keywords.AttackSet} deal more damage and inflict {$Keywords.Link}.",
}, Order) -- Don't forget the order, this is important

local TraitFireflyTestBoon = sjson.to_object({

    Id = "FireflyTestBoon",
    InheritFrom = "BaseBoonMultiline",
    DisplayName = "Test",
    Description = "Your {$Keywords.AttackSet} inflict {$Keywords.Burn}.",

}, Order) -- Don't forget the order, this is important

-- Icon JSON data
local boon_FireflyIcon_1 = sjson.to_object({

		Name = "FireflyIcon_1",
		InheritFrom = "BoonIcon",
		FilePath = rom.path.combine(_PLUGIN.guid, 'boons\\Firefly_1'),

}, IconOrder)

-- Pass in the (Global) file name you defined in sjson.lua
sjson.hook(TraitTextFile, function(data)
    --data.texts is found at the top of the file, its the Texts table, it is different per file, second arguement is your local above
    table.insert(data.Texts, TraitFirefly)
    table.insert(data.Texts, TraitFirefly_02)
    table.insert(data.Texts, TraitFireflyTestBoon)
    print("Boon Hook completed")
end)

sjson.hook(GUIAnimationsFile, function (data)
    table.insert(data.Animations, boon_FireflyIcon_1)
end)

game.SetupRunData()
--printTable(game.TraitData.HeraWeaponBoon)
--print("\n\n##########\n##########\n\n")
--printTable(game.TraitData.FireflyEffectBoon)