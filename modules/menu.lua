-- MODULE : MENU
---------------------------------------------------------------------------------------------
local RitnEvent = require(ritnlib.defines.core.class.event)
local RitnPlayer = require(ritnlib.defines.core.class.player)
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



local function on_rocket_launched(e)
    local rEvent = RitnEvent(e)
    local LuaEntity = rEvent.rocket
    local LuaSurface = LuaEntity.surface

    if not game.is_multiplayer() then return end

    -- TODO refaire pour adapter au mod et plus passer par les tuyaux de RitnTP
    
    -- Mise à true de l'info finish de la surface pour activer le bouton menu
    if global.teleport.surfaces[LuaSurface.name].finish == false then
      global.teleport.surfaces[LuaSurface.name].finish = true 

      -- Activer le bouton si un/des joueur(s) sont connectés au moment du lancé
      for _,player in pairs(game.players) do 
        if player.name == LuaSurface.name then 
          if player.surface.name == LuaSurface.name then 
            if player.connected then 
              local LuaPlayer = player
              local top = modGui.get_button_flow(LuaPlayer)
              if not top[ritnmods.teleport.defines.name.gui.menu.button_main] then
                ritnGui.menu.button_main_show(LuaPlayer)
              end
            end
          end
        end
      end

    end


end


---------------------------------------------------------------------------------------------
local module = {events = {}}
---------------------------------------------------------------------------------------------
module.events[defines.events.on_player_created] = on_player_created
module.events[defines.events.on_gui_click] = on_gui_click
module.events[defines.events.on_player_promoted] = on_player_promoted
module.events[defines.events.on_player_demoted] = on_player_demoted
----------------------
return module