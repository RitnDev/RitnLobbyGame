-- MODULE : MENU
---------------------------------------------------------------------------------------------


local function on_gui_click(e)
    -- On ne peut pas cliquer sur le menu si on est dans un lobby
    local surface_name = RitnCoreEvent(e):getPlayer().surface.name
    if string.sub(surface_name, 1, 6) == ritnlib.defines.lobby.prefix.lobby then return end

    RitnLobbyGuiMenuButton(e):on_gui_click()
    RitnLobbyGuiMenu(e):on_gui_click()
    RitnLobbyGuiSurface(e):on_gui_click()
end


local function on_player_created(e) 
    local rPlayer = RitnCoreEvent(e):getPlayer()
    if rPlayer.admin then
        RitnLobbyGuiMenuButton(e):create()
    end
end


local function on_player_promoted(e) 
    RitnLobbyGuiMenuButton(e):create()
end


local function on_player_demoted(e)
    RitnLobbyGuiMenu(e):action_close()
    local rPlayer = RitnCoreEvent(e):getPlayer()
    local surfaces = remote.call("RitnCoreGame", "get_surfaces")
    if surfaces[rPlayer.name] == nil then 
        RitnLobbyGuiMenuButton(e):destroy()
    end
end

local function on_pre_player_left_game(e) 
    RitnLobbyGuiMenu(e):action_close()
    RitnLobbyGuiSurface(e):action_close()
end



local function on_rocket_launched(e)
    local rEvent = RitnCoreEvent(e)
    local rSurface = RitnLobbySurface(rEvent.rocket.surface):setFinish(true)
    local rForce = RitnCoreForce(rEvent.rocket.force):setFinish(true)
end


---------------------------------------------------------------------------------------------
local module = {events = {}}
---------------------------------------------------------------------------------------------
module.events[defines.events.on_player_created] = on_player_created
module.events[defines.events.on_pre_player_left_game] = on_pre_player_left_game
module.events[defines.events.on_gui_click] = on_gui_click
module.events[defines.events.on_player_promoted] = on_player_promoted
module.events[defines.events.on_player_demoted] = on_player_demoted
module.events[defines.events.on_rocket_launched] = on_rocket_launched
----------------------
return module