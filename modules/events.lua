------------------------------------------------------------------------------------------------------------------------
-- EVENTS
---------------------------------------------------------------------------------------------
--local ritnGui = { menu = { action = require(ritnlib.defines.lobby.gui.menu.action) } }
---------------------------------------------------------------------------------------------
local events = {}
local gui_common = require(ritnlib.defines.lobby.gui.common)
  
function events.on_init(event)
    --[[ pcall(function() 
        remote.call("EvoGUI", "create_remote_sensor", { 
            mod_name = ritnlib.defines.lobby.name,
            name = "evolution_factor_ritnlobby", 
            text = "", 
            caption = {'sensor.evo_factor_name'}
        }) 
    end) ]]
    remote.call("RitnMenuButton", "set_gui_common", gui_common)
    local options = remote.call("RitnCoreGame", "get_options")
    options.lobby = {
        surfaces_max = settings.global[ritnlib.defines.lobby.names.settings.surfaceMax].value
    }
    options.requests = {}
    remote.call("RitnCoreGame", "set_options", options)
    remote.call("RitnCoreGame", "set_enemy", { active = false })
    remote.call("RitnCoreGame", "init_data", "request", {
        name = "",
        state = 1,
        reject_all=false
    })
    remote.call("RitnCoreGame", "add_param_data", "surface", "requests", {})
    remote.call("RitnCoreGame", "add_param_data", "surface", "subscribers", {})
    ----
    remote.call('RitnBaseGame', "disable.lobby.on_player_changed_surface")
end
 


-------------------------------------------
-- INIT GLOBAL MOD
-------------------------------------------
global.lobby = { 
    modules = {
        commands = true,
        lobby = true,
        request = true,
        menu = true,
    }
}
-------------------------------------------
return events