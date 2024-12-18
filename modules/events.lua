---------------------------------------------------------------------------------------------
-- EVENTS
---------------------------------------------------------------------------------------------
local flib = require(ritnlib.defines.other)
---------------------------------------------------------------------------------------------
local gui_common = require(ritnlib.defines.lobby.gui.common)
---------------------------------------------------------------------------------------------

-- initilisation du mod (au démarrage de la partie)
local function on_init_mod(event)
    log('RitnLobbyGame -> on_init')
    -----------------------------------------------------------
    flib.callRemoteFreeplay("no_finish")
    remote.call("RitnMenuButton", "set_gui_common", gui_common)
    ---------------------------------
    local options = remote.call("RitnCoreGame", "get_options")
    options.lobby = {
        surfaces_max = settings.global[ritnlib.defines.lobby.names.settings.surfaceMax].value,      restart = settings.startup[ritnlib.defines.lobby.names.settings.restart].value
    }
    -- On autorise pas l'accès à Nauvis
    options.go_nauvis = false
    options.requests = {}
    options.custom_map_settings = {
        new_seed = not settings.startup[ritnlib.defines.lobby.names.settings.generate_seed].value
    }
    remote.call("RitnCoreGame", "set_options", options)
    ---------------------------------
    local enemy = remote.call("RitnCoreGame", "get_enemy")
    enemy.active = false
    remote.call("RitnCoreGame", "set_enemy", enemy)
    ---------------------------------
    remote.call("RitnCoreGame", "init_data", "request", {
        name = "",
        state = 1,
        reject_all=false
    })
    remote.call("RitnCoreGame", "add_param_data", "surface", "requests", {})
    remote.call("RitnCoreGame", "add_param_data", "surface", "subscribers", {})
    remote.call("RitnCoreGame", "add_param_data", "surface", "last_use", 0)
    ------------------------------------------
    remote.call('RitnBaseGame', "disable.lobby.setup_lobby_surface")

    log('on_init : RitnLobbyGame -> finish !')
end

-- config du jeu à changé
local function on_configuration_changed(event)
    log('RitnLobbyGame -> on_configuration_changed')
    -----------------------------------------------------------
    -- Mise à jours des options du lobby
    local options = remote.call("RitnCoreGame", "get_options")
    if options.lobby then 
        options.lobby.restart = settings.startup[ritnlib.defines.lobby.names.settings.restart].value
        options.requests = {}
    else
        options.lobby = {
            surfaces_max = settings.global[ritnlib.defines.lobby.names.settings.surfaceMax].value,
            restart = settings.startup[ritnlib.defines.lobby.names.settings.restart].value
        }
        options.requests = {}
    end
    options.custom_map_settings = {
        new_seed = not settings.startup[ritnlib.defines.lobby.names.settings.generate_seed].value
    }
    remote.call("RitnCoreGame", "set_options", options)
    -----------------------------------------------------------
    remote.call("RitnCoreGame", "add_param_data", "surface", "last_use", 0)
    remote.call('RitnBaseGame', "disable.lobby.setup_lobby_surface")
    -----------------------------------------------------------
    log('on_configuration_changed : RitnLobbyGame -> finish !')
end

-- event lors de l'appuie sur la touche de raccourcis du mod
local function toggle_main_menu(event)
    remote.call("RitnLobbyGame", "gui_action_ritn", "button-menu", event)
end 


-------------------------------------------
local module = { events = {}}
-------------------------------------------
-- event : custom-input
module.events[ritnlib.defines.lobby.names.customInput.toggle_main_menu] = toggle_main_menu
-- event : on_init_mod
module.on_init = on_init_mod
module.on_configuration_changed = on_configuration_changed
-------------------------------------------
return module