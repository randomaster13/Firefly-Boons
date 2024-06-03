function CreateFireflyEffects()
    game.EffectData.FireflyShareDamageEffect =
	{
		Name = "FireflyShareDamageEffect",
        DisplaySuffix = "DamageShare",
		EffectGroup = "DamageShare",
		Icon = "DamageShareSmall",
		Vfx = "HeraTwistStatus",
		DamageTextStartColor = { 245, 181, 31, 255 },
		DamageTextColor = { 196, 129, 41, 255 },
		OnDamagedFunctionName = "ProcessDamageShare",
		Using = "HeraRope",
		OnApplyFunctionName = "FireflyDamageShareApply",
		OnClearFunctionName = "FireflyDamageShareClear",
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
end

CreateFireflyEffects()

function FireflyDamageShareApply( triggerArgs )
	local victim = triggerArgs.Victim
	if not victim.DamageShareAmount or victim.DamageShareAmount < triggerArgs.Amount then
		victim.DamageShareAmount = triggerArgs.Amount
	end
end

function FireflyDamageShareClear( triggerArgs )
	local victim = triggerArgs.Victim
	victim.DamageShareAmount = nil
end

function ProcessDamageShare( victim, triggerArgs)

	if not victim.IsDead and victim.DamageShareAmount and HasEffectWithEffectGroup( victim, "DamageShare") and not triggerArgs.PureDamage and not IsEmpty(ActiveEnemies) and ( not victim.SkipModifiers or victim.BondAlwaysApplies) then
		local range = EffectData.DamageShareEffect.Range
		local damageAmount = triggerArgs.DamageAmount * victim.DamageShareAmount		
		for id, enemy in pairs( ActiveEnemies ) do
			if enemy and victim and enemy ~= victim and not enemy.IsDead and IsEmpty( enemy.InvulnerableFlags )
				and HasEffectWithEffectGroup( enemy, "DamageShare") and GetDistance({ Id = victim.ObjectId, DestinationId = enemy.ObjectId}) <= range then
				CreateAnimationsBetween({ 
					Animation = "HeraRope", DestinationId = enemy.ObjectId, Id = victim.ObjectId, 
					Stretch = true, UseZLocation = false})
				thread( Damage, enemy, { EffectName = "DamageShareEffect", DamageAmount = damageAmount, AttackerTable = CurrentRun.Hero, AttackerId = CurrentRun.Hero.ObjectId, Silent = false, PureDamage = true } )
			end
		end
	end
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