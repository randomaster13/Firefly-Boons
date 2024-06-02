if config.Enabled == true then

	function CreateFireflyBoon()
		game.TraitData.HermesBoon.FireflyWeaponBoon {
		--adding this to hermes
		FireflyWeaponBoon =
			{
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
						Multiplier = 2.5,
					},
				},
				PropertyChanges = {
					{
						WeaponNames = WeaponSets.HeroPrimaryWeapons,
						BaseValue = 0.9,
						SourceIsMultiplier = true,
						SpeedPropertyChanges = true,
					}
				},
				WeaponSpeedMultiplier =
				{
					WeaponNames = WeaponSets.HeroPrimaryWeapons,
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
		}

		table.insert(game.LootSetData.Hermes.Traits, "FireflyWeaponBoon")
	end

	CreateFireflyBoon()

	-- Name and description
	local TraitFirefly = sjson.to_object({
		Id = "FireflyWeaponBoon",
		InheritFrom = "BaseBoonMultiline",
		DisplayName = "A Million Fire Flies",
      	Description = "Your {$Keywords.AttackSet} are faster.",
	})

end