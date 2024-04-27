--INITIALIZE
----------------------------------------------------------------------
require("core.defines")
----------------------------------------------------------------------
local RitnSetting = require(ritnlib.defines.class.ritnClass.setting)
----------------------------------------------------------------------
-- STARTUP SETTINGS
----------------------------------------------------------------------
local rSetting = RitnSetting(ritnlib.defines.lobby.names.settings.generate_seed)
rSetting:setOrder(ritnlib.defines.lobby.prefix.settings_prefix .. "01")
rSetting:setDefaultValueBool(ritnlib.defines.lobby.value.settings.generate_seed)
rSetting:new()
----------------------------------------------------------------------
local rSetting = RitnSetting(ritnlib.defines.lobby.names.settings.restart)
rSetting:setOrder(ritnlib.defines.lobby.prefix.settings_prefix .. "02")
rSetting:setDefaultValueBool(ritnlib.defines.lobby.value.settings.restart)
rSetting:new()
----------------------------------------------------------------------
-- INGAME SETTINGS
----------------------------------------------------------------------
data:extend {
	{
		-- Nombre de map max sur la partie.
		type = "int-setting",
		name = ritnlib.defines.lobby.names.settings.surfaceMax,
		setting_type = RitnSetting.SETTING_TYPE.runtime,
		default_value = ritnlib.defines.lobby.value.settings.surfaceMax.default_value,
		minimum_value = ritnlib.defines.lobby.value.settings.surfaceMax.minimum_value,
		maximum_value = ritnlib.defines.lobby.value.settings.surfaceMax.maximum_value,
		order = ritnlib.defines.lobby.prefix.settings_prefix .. "01"
	},
	{
		-- Time-out avant suppression de la map (en heure).
		type = "int-setting",
		name = ritnlib.defines.lobby.names.settings.clean,
		setting_type = RitnSetting.SETTING_TYPE.runtime,
		default_value = ritnlib.defines.lobby.value.settings.clean.default_value,
		minimum_value = ritnlib.defines.lobby.value.settings.clean.minimum_value,
		maximum_value = ritnlib.defines.lobby.value.settings.clean.maximum_value,
		order = ritnlib.defines.lobby.prefix.settings_prefix .. "02"
	},
}
----------------------------------------------------------------------
-- -- BY PLAYER SETTINGS
----------------------------------------------------------------------


----------------------------------------------------------------------


