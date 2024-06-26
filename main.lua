---@meta _
-- grabbing our dependencies,
-- I did not come up with this myself, i did take this from zanncdwbl's keepsake port mod, because it works in their mod and I wouldn't have known what to do.
-- these funky (---@) comments are just there to help VS Code find the definitions of things

---@diagnostic disable-next-line: undefined-global
local mods = rom.mods

---@diagnostic disable: lowercase-global
---@module 'SGG_Modding-ENVY-auto'
mods['SGG_Modding-ENVY'].auto()

---@diagnostic disable-next-line: undefined-global
rom = rom
---@diagnostic disable-next-line: undefined-global
_PLUGIN = PLUGIN

---@module 'SGG_Modding-Hades2GameDef-Globals'
game = rom.game

---@module 'SGG_Modding-SJSON'
sjson = mods['SGG_Modding-SJSON']

---@module 'SGG_Modding-ModUtil'
modutil = mods['SGG_Modding-ModUtil']

---@module 'SGG_Modding-Chalk'
chalk = mods["SGG_Modding-Chalk"]

---@module 'SGG_Modding-ReLoad'
reload = mods['SGG_Modding-ReLoad']

---@module 'Randomaster13-Firefly-config'
config = chalk.auto 'config.lua'
public.config = config

local function on_ready()
    import_as_fallback(rom.game)

    import 'sjson.lua'
    import 'ready.lua'

    if config.Enabled == true then
        import 'FireflyEffectData.lua'
        import 'TraitFirefly.lua'
    end
end

local function on_reload()
    import_as_fallback(rom.game)

    import 'reload.lua'
end

local loader = reload.auto_single()

--once_loaded.game is replacing on_ready_final here
modutil.once_loaded.game(function()
    loader.load(on_ready, on_reload)
end)
