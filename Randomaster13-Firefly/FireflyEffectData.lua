function CreateFireflyEffects()
    game.EffectData.FireflyShareDamageEffect =
	{
		Name = "FireflyShareDamageEffect",
        DisplaySuffix = "DamageShare",
		EffectGroup = "FfDamageShare",
		Icon = "DamageShareSmall",
		Vfx = "HeraTwistStatus",
		DamageTextStartColor = { 245, 181, 31, 255 },
		DamageTextColor = { 196, 129, 41, 255 },
		OnDamagedFunctionName = game.ProcessDamageShare,
		Using = "HeraRope",
		OnApplyFunctionName = "DamageShareApply",
		OnClearFunctionName = "DamageShareClear",
		TriggerOnKillingBlow = true,
		DistanceCheckDamageNumbers = true,
		Range = 1200,
		EffectData = {
			Type = "DAMAGE_OUTPUT",
			Duration = 16,
			Cooldown = 2,
			Amount = 0.50,
			Modifier = 1,
			IsVulnerabilityEffect = true,
			IgnoreName = "_PlayerUnit"
		},
	}
    print("created effect")
    print(game.EffectData.FireflyShareDamageEffect.Range)
end

CreateFireflyEffects()

function mod.FireflyDamageShareApply( base, triggerArgs )
	local victim = triggerArgs.Victim
	if not victim.DamageShareAmount or victim.DamageShareAmount < triggerArgs.Amount then
		victim.DamageShareAmount = triggerArgs.Amount
	end
    print("Applied")
end

function mod.FireflyDamageShareClear( base, triggerArgs )
	local victim = triggerArgs.Victim
	victim.DamageShareAmount = nil
end

function mod.FfProcessDamageShare( base, victim, triggerArgs)

	if not victim.IsDead and victim.DamageShareAmount and game.HasEffectWithEffectGroup( victim, "FfDamageShare") and not triggerArgs.PureDamage and not game.IsEmpty(game.ActiveEnemies) and ( not victim.SkipModifiers or victim.BondAlwaysApplies) then
		local range = game.EffectData.FireflyShareDamageEffect.Range
		local damageAmount = triggerArgs.DamageAmount * victim.DamageShareAmount
		for id, enemy in pairs( game.ActiveEnemies ) do
			if enemy and victim and enemy ~= victim and not enemy.IsDead and game.IsEmpty( enemy.InvulnerableFlags )
				and game.HasEffectWithEffectGroup( enemy, "FfDamageShare") and game.GetDistance({ Id = victim.ObjectId, DestinationId = enemy.ObjectId}) <= range then
				game.CreateAnimationsBetween({ 
					Animation = "HeraRope", DestinationId = enemy.ObjectId, Id = victim.ObjectId, 
					Stretch = true, UseZLocation = false})
				game.thread( game.Damage, enemy, { EffectName = "FireflyShareDamageEffect", DamageAmount = damageAmount, AttackerTable = game.CurrentRun.Hero, AttackerId = game.CurrentRun.Hero.ObjectId, Silent = false, PureDamage = true } )
			end
		end
	end
    print("shared hopefully")
end

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

print("\n\n")
printTable(game.EffectData.DamageShareEffect)
print("\n\n")
printTable(game.EffectData.FireflyShareDamageEffect)