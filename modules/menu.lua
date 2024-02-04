-- MODULE : MENU
---------------------------------------------------------------------------------------------
local RitnEvent = require(ritnlib.defines.core.class.event)
local RitnPlayer = require(ritnlib.defines.core.class.player)
local RitnForce = require(ritnlib.defines.core.class.force)
---------------------------------------------------------------------------------------------
local RitnSurface = require(ritnlib.defines.lobby.class.surface)
local RitnGuiMenuButton = require(ritnlib.defines.lobby.class.guiButtonMenu)
local RitnGuiMenu = require(ritnlib.defines.lobby.class.guiMenu)
local RitnGuiSurfaces = require(ritnlib.defines.lobby.class.guiSurfaces)
---------------------------------------------------------------------------------------------


local function on_gui_click(e)
    -- On ne peut pas cliquer sur le menu si on est dans un lobby
    local surface_name = RitnEvent(e):getPlayer().surface.name
    if string.sub(surface_name, 1, 6) == ritnlib.defines.lobby.prefix.lobby then return end

    RitnGuiMenuButton(e):on_gui_click()
    RitnGuiMenu(e):on_gui_click()
    RitnGuiSurfaces(e):on_gui_click()
end


local function on_player_created(e) 
    local rPlayer = RitnEvent(e):getPlayer()
    if rPlayer.admin then
        RitnGuiMenuButton(e):create()
    end
end


local function on_player_promoted(e) 
    RitnGuiMenuButton(e):create()
end


local function on_player_demoted(e)
    RitnGuiMenu(e):action_close()
    local rPlayer = RitnEvent(e):getPlayer()
    local surfaces = remote.call("RitnCoreGame", "get_surfaces")
    if surfaces[rPlayer.name] == nil then 
        RitnGuiMenuButton(e):destroy()
    end
end

local function on_pre_player_left_game(e) 
    RitnGuiMenuButton(e):action_close()
end



local function on_rocket_launched(e)
    local rEvent = RitnEvent(e)
    local rSurface = RitnSurface(rEvent.rocket.surface):setFinish(true)
    local rForce = RitnForce(rEvent.rocket.force):setFinish(true)
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