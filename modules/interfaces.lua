local RitnGuiLobby = require(ritnlib.defines.lobby.class.guiLobby)
local RitnGuiRequest = require(ritnlib.defines.lobby.class.guiRequest)
local RitnGuiMenuButton = require(ritnlib.defines.lobby.class.guiButtonMenu)
local RitnSurface = require(ritnlib.defines.lobby.class.surface)
------------------------------------------------------------------------------


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
            RitnGuiRequest(event, applicant):action_reject()
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
    --requests manager
    ["request.accept"] = function(player_name, applicant)
        RitnSurface(game.surfaces[player_name]):acceptRequest(applicant)
    end,
    ["request.reject"] = function()
        RitnSurface(game.surfaces[player_name]):rejectRequest(applicant)
    end,
    ["request.rejectAll"] = function()
        RitnSurface(game.surfaces[player_name]):rejectAllRequest(applicant)
    end,
    --disable modules
    ["disable.module.commands"] = function()
        global.lobby.modules.commands = false
    end,
    ["disable.module.lobby"] = function()
        global.lobby.modules.lobby = false
    end,
    ["disable.module.request"] = function()
        global.lobby.modules.request = false
    end,
    ["disable.module.menu"] = function()
        global.lobby.modules.menu = false
    end,
}


if not remote.interfaces["RitnLobbyGame"] then
    remote.add_interface("RitnLobbyGame", lobby_interface)
end


return {}