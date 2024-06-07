---@diagnostic disable: lowercase-global

local package = rom.path.combine(_PLUGIN.plugins_data_mod_folder_path, _PLUGIN.guid)
modutil.mod.Path.Wrap("SetupMap", function(base)
    LoadPackages({Name = package})
    base()
end)

mod = modutil.mod.Mod.Register(_PLUGIN.guid)

modutil.mod.Path.Wrap("DamageShareApply", function( base, triggerArgs )
    mod.FireflyDamageShareApply( base, triggerArgs )
    base(triggerArgs )
end)

modutil.mod.Path.Wrap("DamageShareClear", function( base, triggerArgs )
    mod.FireflyDamageShareClear( base, triggerArgs )
    base(triggerArgs )
end)

modutil.mod.Path.Wrap("ProcessDamageShare", function( base, victim, triggerArgs )
    mod.FfProcessDamageShare( base, victim, triggerArgs )
    base(victim, triggerArgs )
end)