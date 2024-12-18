-- MODULE : LOBBY
---------------------------------------------------------------------------------------------


-- Event lors de la suppression d'une surface
local function on_surface_deleted(e)
    local rEvent = RitnCoreEvent(e)
    -- actualise TOUS les GUI lobby des joueurs sur les surfaces lobby
    for _, LuaPlayer in pairs(game.players) do 
        if LuaPlayer.surface.name == rEvent.prefix_lobby .. LuaPlayer.name  then 
            local event = {player_index = LuaPlayer.index}
            RitnLobbyGuiLobby(event):action_open()
        else
            local event = {player_index = LuaPlayer.index}
            RitnLobbyGuiLobby(event):action_close()
        end
    end
    ----
    log('on_pre_surface_deleted')
end



-- Event lorsqu'un joueur change de surface
local function on_player_changed_surface(e)
    local rEvent = RitnCoreEvent(e)

    -- actualise TOUS les GUI lobby des joueurs sur les surfaces lobby
    for _, LuaPlayer in pairs(game.players) do 
        if LuaPlayer.surface.name == rEvent.prefix_lobby .. LuaPlayer.name  then 
            local event = {player_index = LuaPlayer.index}
            RitnLobbyGuiLobby(event):action_open()
        else
            local event = {player_index = LuaPlayer.index}
            RitnLobbyGuiLobby(event):action_close()
        end
    end
    
    ----
    log('on_player_changed_surface')
end




local function on_gui_click(e)
    RitnLobbyGuiLobby(e):on_gui_click()
end



local function on_runtime_mod_setting_changed(e)
    local rEvent = RitnCoreEvent(e)

    if rEvent.setting_type == "runtime-global" then 
        if rEvent.setting_name == ritnlib.defines.lobby.names.settings.surfaceMax then
            local setting_value = settings.global[rEvent.setting_name].value
            -- surfaces max
            local options = remote.call('RitnCoreGame', 'get_options')
            options.lobby.surfaces_max = setting_value
            remote.call('RitnCoreGame', 'set_options', options)

            -- actualise TOUS les GUI lobby des joueurs sur les surfaces lobby
            for _, LuaPlayer in pairs(game.players) do 
                if LuaPlayer.surface.name == rEvent.prefix_lobby .. LuaPlayer.name  then 
                    local event = {player_index = LuaPlayer.index}
                    RitnLobbyGuiLobby(event):action_open()
                end
            end

        end
    end
end




----------------------
local module = {}
module.events = {}
----------------------
module.events[defines.events.on_surface_deleted] = on_surface_deleted
module.events[defines.events.on_player_changed_surface] = on_player_changed_surface
module.events[defines.events.on_gui_click] = on_gui_click
module.events[defines.events.on_runtime_mod_setting_changed] = on_runtime_mod_setting_changed
----------------------
return module