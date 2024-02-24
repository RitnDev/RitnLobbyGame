---------------------------------------------------------------------------------------------
-- GLOBALS
---------------------------------------------------------------------------------------------
if global.lobby == nil then
    global.lobby = { 
        modules = {
            commands = true,
            restart = true,
            lobby = true,
            inventory = true,
            request = true,
            menu = true,
        }
    }
end

---------------------------------------------------------------------------------------------
-- REMOTE FUNCTIONS INTERFACE
---------------------------------------------------------------------------------------------
local RitnGuiLobby = require(ritnlib.defines.lobby.class.guiLobby)
local RitnGuiRestart = require(ritnlib.defines.lobby.class.guiRestart)
local RitnGuiRequest = require(ritnlib.defines.lobby.class.guiRequest)
local RitnGuiMenuButton = require(ritnlib.defines.lobby.class.guiButtonMenu)
local RitnGuiMenu = require(ritnlib.defines.lobby.class.guiMenu)
local RitnGuiSurfaces = require(ritnlib.defines.lobby.class.guiSurfaces)
local RitnSurface = require(ritnlib.defines.lobby.class.surface)
---------------------------------------------------------------------------------------------

local lobby_interface = {
    ["gui_action_lobby"] = function(action, event)
        if action == ritnlib.defines.lobby.gui_actions.lobby.open then 
            RitnGuiLobby(event):action_open()
        elseif action == ritnlib.defines.lobby.gui_actions.lobby.close then 
            RitnGuiLobby(event):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.lobby.create then 
            RitnGuiLobby(event):action_create()
        elseif action == ritnlib.defines.lobby.gui_actions.lobby.request then 
            RitnGuiLobby(event):action_request()
        end
    end,
    ["gui_action_restart"] = function(action, event)
        if action == ritnlib.defines.lobby.gui_actions.restart.open then 
            RitnGuiRestart(event):action_open()
        elseif action == ritnlib.defines.lobby.gui_actions.restart.close then 
            RitnGuiRestart(event):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.restart.back then 
            RitnGuiRestart(event):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.restart.valid then 
            RitnGuiRestart(event):action_valid()
        end
    end,
    ["gui_action_request"] = function(action, event, ...)
        local applicant = ...
        log('> interface : gui_action_request - applicant = ' .. applicant)
        if action == ritnlib.defines.lobby.gui_actions.request.open then 
            RitnGuiRequest(event, applicant):action_open()
        elseif action == ritnlib.defines.lobby.gui_actions.request.close then 
            RitnGuiRequest(event, applicant):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.request.accept then 
            RitnGuiRequest(event, applicant):action_accept()
        elseif action == ritnlib.defines.lobby.gui_actions.request.reject then 
            RitnGuiRequest(event, applicant):button_reject()
        elseif action == ritnlib.defines.lobby.gui_actions.request.rejectAll then 
            RitnGuiRequest(event, applicant):action_rejectAll()
        end
    end,
    ["gui_action_ritn"] = function(action, event)
        if action == ritnlib.defines.lobby.gui_actions.ritn.open then 
            RitnGuiMenuButton(event):action_open()
        elseif action == ritnlib.defines.lobby.gui_actions.ritn.close then 
            RitnGuiMenuButton(event):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.ritn.menu then 
            RitnGuiMenuButton(event):action_menu()
        end
    end,
    ["gui_action_menu"] = function(action, event)
        if action == ritnlib.defines.lobby.gui_actions.menu.open then 
            RitnGuiMenu(event):action_open()
        elseif action == ritnlib.defines.lobby.gui_actions.menu.close then 
            RitnGuiMenu(event):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.menu.toggle then 
            RitnGuiMenu(event):action_toggle_menu()
        elseif action == ritnlib.defines.lobby.gui_actions.menu.restart then 
            RitnGuiMenu(event):action_restart()
        elseif action == ritnlib.defines.lobby.gui_actions.menu.exclure then 
            RitnGuiMenu(event):action_exclure()
        elseif action == ritnlib.defines.lobby.gui_actions.menu.tp then 
            RitnGuiMenu(event):action_tp()
        elseif action == ritnlib.defines.lobby.gui_actions.menu.clean then 
            RitnGuiMenu(event):action_clean()
        end
    end,
    ["gui_action_surfaces"] = function(action, event)
        if action == ritnlib.defines.lobby.gui_actions.surfaces.open then 
            RitnGuiSurfaces(event):action_open()
        elseif action == ritnlib.defines.lobby.gui_actions.surfaces.close then 
            RitnGuiSurfaces(event):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.surfaces.back then 
            RitnGuiSurfaces(event):action_close()
        elseif action == ritnlib.defines.lobby.gui_actions.surfaces.valid then 
            RitnGuiSurfaces(event):action_valid()
        end
    end,
    --requests manager
    ["request.accept"] = function(player_name, applicant)
        log('> intefaces -> request.accept')
        RitnSurface(game.surfaces[player_name]):acceptRequest(applicant)
        log('> intefaces -> request.accept : ok !')
    end,
    ["request.reject"] = function()
        log('> intefaces -> request.reject')
        RitnSurface(game.surfaces[player_name]):rejectRequest(applicant)
        log('> intefaces -> request.reject : ok !')
    end,
    ["request.rejectAll"] = function()
        log('> intefaces -> request.rejectAll')
        RitnSurface(game.surfaces[player_name]):rejectAllRequest(applicant)
        log('> intefaces -> request.rejectAll : ok !')
    end,
    --disable modules
    ["disable.module.commands"] = function()
        global.lobby.modules.commands = false
    end,
    ["disable.module.restart"] = function()
        global.lobby.modules.restart = false
    end,
    ["disable.module.lobby"] = function()
        global.lobby.modules.lobby = false
    end,
    ["disable.module.inventory"] = function()
        global.lobby.modules.inventory = false
    end,
    ["disable.module.request"] = function()
        global.lobby.modules.request = false
    end,
    ["disable.module.menu"] = function()
        global.lobby.modules.menu = false
    end,
}
remote.add_interface("RitnLobbyGame", lobby_interface)
---------------------------------------------------------------------------------------------
return {}