--INITIALIZE
require("core.defines")

data:extend {

	-- STARTUP SETTINGS
	{
		-- Même map pour tous ?
		type = "bool-setting",
		name = ritnlib.defines.lobby.names.settings.generate_seed,
		setting_type = "startup",
		default_value = ritnlib.defines.lobby.value.settings.generate_seed,
		order = ritnlib.defines.lobby.name_prefix .. "lobby-01"
	},
	{
		-- Activation des équipes ennemies
		type = "bool-setting",
		name = ritnlib.defines.lobby.names.settings.restart,
		setting_type = "startup",
		default_value = ritnlib.defines.lobby.value.settings.restart,
		order = ritnlib.defines.lobby.name_prefix .. "lobby-04"
	},


	-- INGAME SETTINGS	
	{
		-- Nombre de map max sur la partie.
		type = "int-setting",
		name = ritnlib.defines.lobby.names.settings.surfaceMax,
		setting_type = "runtime-global",
		default_value = ritnlib.defines.lobby.value.settings.surfaceMax.default_value,
		minimum_value = ritnlib.defines.lobby.value.settings.surfaceMax.minimum_value,
		maximum_value = ritnlib.defines.lobby.value.settings.surfaceMax.maximum_value,
		order = ritnlib.defines.lobby.name_prefix .. "lobby-02"
	},
	{
		-- Time-out avant suppression de la map (en heure).
		type = "int-setting",
		name = ritnlib.defines.lobby.names.settings.clean,
		setting_type = "runtime-global",
		default_value = ritnlib.defines.lobby.value.settings.clean.default_value,
		minimum_value = ritnlib.defines.lobby.value.settings.clean.minimum_value,
		maximum_value = ritnlib.defines.lobby.value.settings.clean.maximum_value,
		order = ritnlib.defines.lobby.name_prefix .. "lobby-05"
	},


	-- BY PLAYER SETTINGS
	{
		-- Activation du bouton menu
		type = "bool-setting",
		name = ritnlib.defines.lobby.names.settings.enable_main_button,
		setting_type = "runtime-per-user",
		default_value = ritnlib.defines.lobby.value.settings.enable_main_button,
		order = ritnlib.defines.lobby.name_prefix .. "lobby-01"
	},
	{
		-- Envoie d'un message lorsqu'une recherche est terminé et que nous sommes pas sur notre surface
		type = "bool-setting",
		name = ritnlib.defines.lobby.names.settings.show_research,
		setting_type = "runtime-per-user",
		default_value = ritnlib.defines.lobby.value.settings.show_research,
		order = ritnlib.defines.lobby.name_prefix .. "lobby-02"
	},






	--[[
	{
		-- Activation des téléporteurs
		type = "bool-setting",
		name = ritnlib.defines.lobby.names.settings.teleporter_enable,
		setting_type = "startup",
		default_value = ritnlib.defines.lobby.value.settings.teleporter_enable,
		order = ritnlib.defines.lobby.name_prefix .. "lobby-03"
	},
	]]
	--[[
	{
		-- Activation des équipes ennemies
		type = "bool-setting",
		name = ritnlib.defines.lobby.names.settings.enemy,
		setting_type = "startup",
		default_value = ritnlib.defines.lobby.value.settings.enemy,
		order = ritnlib.defines.lobby.name_prefix .. "lobby-06"
	},
	]]

}