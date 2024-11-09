---------------------------------------------------------------------------------------------
-- GLOBALS
---------------------------------------------------------------------------------------------
if storage.lobby == nil then
    storage.lobby = { 
        modules = {
            commands = true,
            restart = true,
            lobby = true,
            request = true,
            menu = true,
        }
    }
end

---------------------------------------------------------------------------------------------
-- REMOTE FUNCTIONS INTERFACE
---------------------------------------------------------------------------------------------
local lobby_interface = {
    ["gui_action_lobby"] = function(action, event)
        if action == ritnlib.defines.lobby.gui_actions.lobby.open then 
            RitnLobbyGuiLobby(event):action_open()
        elseif action == ritnlib.defines.lobby.gui_actions.lobby.close then 
            RitnLobbyGuiLobby(event):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.lobby.create then 
            RitnLobbyGuiLobby(event):action_create()
        elseif action == ritnlib.defines.lobby.gui_actions.lobby.request then 
            RitnLobbyGuiLobby(event):action_request()
        end
    end,
    ["gui_action_restart"] = function(action, event)
        if action == ritnlib.defines.lobby.gui_actions.restart.open then 
            RitnLobbyGuiRestart(event):action_open()
        elseif action == ritnlib.defines.lobby.gui_actions.restart.close then 
            RitnLobbyGuiRestart(event):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.restart.back then 
            RitnLobbyGuiRestart(event):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.restart.valid then 
            RitnLobbyGuiRestart(event):action_valid()
        end
    end,
    ["gui_action_request"] = function(action, event, ...)
        local applicant = ...
        log('> interface : gui_action_request - applicant = ' .. applicant)
        if action == ritnlib.defines.lobby.gui_actions.request.open then 
            RitnLobbyGuiRequest(event, applicant):action_open()
        elseif action == ritnlib.defines.lobby.gui_actions.request.close then 
            RitnLobbyGuiRequest(event, applicant):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.request.accept then 
            RitnLobbyGuiRequest(event, applicant):action_accept()
        elseif action == ritnlib.defines.lobby.gui_actions.request.reject then 
            RitnLobbyGuiRequest(event, applicant):button_reject()
        elseif action == ritnlib.defines.lobby.gui_actions.request.rejectAll then 
            RitnLobbyGuiRequest(event, applicant):action_rejectAll()
        end
    end,
    ["gui_action_ritn"] = function(action, event)
        if action == ritnlib.defines.lobby.gui_actions.ritn.open then 
            RitnLobbyGuiMenuButton(event):action_open()
        elseif action == ritnlib.defines.lobby.gui_actions.ritn.close then 
            RitnLobbyGuiMenuButton(event):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.ritn.menu then 
            RitnLobbyGuiMenuButton(event):action_menu()
        end
    end,
    ["gui_action_menu"] = function(action, event)
        if action == ritnlib.defines.lobby.gui_actions.menu.open then 
            RitnLobbyGuiMenu(event):action_open()
        elseif action == ritnlib.defines.lobby.gui_actions.menu.close then 
            RitnLobbyGuiMenu(event):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.menu.toggle then 
            RitnLobbyGuiMenu(event):action_toggle_menu()
        elseif action == ritnlib.defines.lobby.gui_actions.menu.restart then 
            RitnLobbyGuiMenu(event):action_restart()
        elseif action == ritnlib.defines.lobby.gui_actions.menu.exclure then 
            RitnLobbyGuiMenu(event):action_exclure()
        elseif action == ritnlib.defines.lobby.gui_actions.menu.tp then 
            RitnLobbyGuiMenu(event):action_tp()
        elseif action == ritnlib.defines.lobby.gui_actions.menu.clean then 
            RitnLobbyGuiMenu(event):action_clean()
        end
    end,
    ["gui_action_surfaces"] = function(action, event)
        if action == ritnlib.defines.lobby.gui_actions.surfaces.open then 
            RitnLobbyGuiSurface(event):action_open()
        elseif action == ritnlib.defines.lobby.gui_actions.surfaces.close then 
            RitnLobbyGuiSurface(event):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.surfaces.back then 
            RitnLobbyGuiSurface(event):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.surfaces.valid then 
            RitnLobbyGuiSurface(event):action_valid()
        end
    end,
    --requests manager
    ["request.accept"] = function(player_name, applicant)
        log('> intefaces -> request.accept')
        RitnLobbySurface(game.surfaces[player_name]):acceptRequest(applicant)
        log('> intefaces -> request.accept : ok !')
    end,
    ["request.reject"] = function()
        log('> intefaces -> request.reject')
        RitnLobbySurface(game.surfaces[player_name]):rejectRequest(applicant)
        log('> intefaces -> request.reject : ok !')
    end,
    ["request.rejectAll"] = function()
        log('> intefaces -> request.rejectAll')
        RitnLobbySurface(game.surfaces[player_name]):rejectAllRequest(applicant)
        log('> intefaces -> request.rejectAll : ok !')
    end,
    --disable modules
    ["disable.module.commands"] = function()
        storage.lobby.modules.commands = false
    end,
    ["disable.module.restart"] = function()
        storage.lobby.modules.restart = false
    end,
    ["disable.module.lobby"] = function()
        storage.lobby.modules.lobby = false
    end,
    ["disable.module.request"] = function()
        storage.lobby.modules.request = false
    end,
    ["disable.module.menu"] = function()
        storage.lobby.modules.menu = false
    end,
}
remote.add_interface("RitnLobbyGame", lobby_interface)
---------------------------------------------------------------------------------------------
return {}