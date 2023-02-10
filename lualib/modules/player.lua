-- INIT
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
local flib = {}
flib.utils =       require(ritnmods.teleport.defines.functions.utils)
flib.portal =      require(ritnmods.teleport.defines.functions.portal)
flib.teleporter =  require(ritnmods.teleport.defines.functions.teleporter)
flib.inventory =   require(ritnmods.teleport.defines.functions.inventory)
flib.surface =     require(ritnmods.teleport.defines.functions.surface)
---------------------------------------------------------------------------------------------
local ritnGui = {}
ritnGui.menu =        require(ritnmods.teleport.defines.gui.menu.GuiElements)
ritnGui.remote =      require(ritnmods.teleport.defines.gui.remote.GuiElements)
ritnGui.teleporter =  require(ritnmods.teleport.defines.gui.teleporter.GuiElements)
ritnGui.portal =      require(ritnmods.teleport.defines.gui.portal.GuiElements)
--ritnGui.lobby =       require(ritnmods.teleport.defines.gui.lobby.GuiElements)
---------------------------------------------------------------------------------------------


-- Restitution de l'inventaire lors du changement de surface
local function on_player_changed_surface(e) 
    local LuaPlayer = game.players[e.player_index]
    local LuaSurface = LuaPlayer.surface
    local surface = LuaSurface.name
    local oldSurface = game.surfaces[e.surface_index]

    if script.level.level_name == "freeplay" then
        
        --version freeplay (normal game)
        if LuaPlayer.force.name ~= "guides" then
        if game.forces[surface] then
            LuaPlayer.force = surface 
        else
            -- prendre en charge le lobby ici
            if surface == "nauvis" then 
            LuaPlayer.force = "player" 
            end
        end
        end

    else
        if not global.teleport.surfaces[LuaSurface.name] then 
            flib.surface.generateSurface(game.surfaces[LuaSurface.name])
            global.teleport.surfaces[LuaSurface.name].exception = true
            global.teleport.surfaces[LuaSurface.name].map_used = true
            global.teleport.surfaces[LuaSurface.name].inventories[LuaPlayer.name] = flib.inventory.init()
        end
        if not global.teleport.surfaces[oldSurface.name] then 
            flib.surface.generateSurface(game.surfaces[oldSurface.name])
            global.teleport.surfaces[oldSurface.name].exception = true
            global.teleport.surfaces[oldSurface.name].map_used = true
            global.teleport.surfaces[oldSurface.name].inventories[LuaPlayer.name] = flib.inventory.init()
        end

    end


    if not global.teleport.surfaces[LuaSurface.name] then return end
    if global.teleport.surfaces[LuaSurface.name].name == nil then return end
    flib.surface.addPlayer(LuaPlayer)
    flib.inventory.get(LuaPlayer, global.teleport.surfaces[LuaSurface.name].inventories[LuaPlayer.name])
    
    if not global.teleport.surfaces[oldSurface.name] then return end
    if global.teleport.surfaces[oldSurface.name].name == nil then return end
    flib.surface.removePlayer(LuaPlayer, oldSurface)
end


local function on_pre_player_left_game(e)
  local LuaPlayer = game.players[e.player_index]
  local LuaSurface = LuaPlayer.surface
  local reason = e.reason -- defines.disconnect_reason
  
  if string.sub(LuaSurface.name, 1, 6) == "lobby~" then return end

  local statut, errorMsg = pcall(function() 
    if not global.teleport.surfaces[LuaSurface.name].inventories[LuaPlayer.name] then
      global.teleport.surfaces[LuaSurface.name].inventories[LuaPlayer.name] = flib.inventory.init()
    end
  end)
  if statut  == (false or nil) then 
    flib.utils.saveGameError("RitnTP/lualib/modules/players : on_pre_player_left_game > " .. errorMsg)
  end
  flib.inventory.save(LuaPlayer, global.teleport.surfaces[LuaSurface.name].inventories[LuaPlayer.name])

  ------------------
end


local function on_player_left_game(e)
  local LuaPlayer = game.players[e.player_index]
  local LuaSurface = LuaPlayer.surface
  if string.sub(LuaSurface.name, 1, 6) == "lobby~" then return end
  flib.surface.removePlayer(LuaPlayer, LuaSurface)
end



-- Inscription à la liste des décès 
local function on_pre_player_died(e)
  local LuaPlayer = game.players[e.player_index]
  local guiTeleport = LuaPlayer.gui.screen[ritnmods.teleport.defines.name.gui.NamerMain]
  local guiPortal = LuaPlayer.gui.screen[ritnmods.teleport.defines.name.gui.main_portal]
  ritnGui.remote.close(LuaPlayer)
  ritnGui.teleporter.close(LuaPlayer.surface, LuaPlayer)
  ritnGui.portal.close(LuaPlayer.surface, LuaPlayer)
  ritnGui.menu.frame_menu_close(LuaPlayer)
  ritnGui.menu.frame_restart_close(LuaPlayer)
  table.insert(global.teleport.player_died, LuaPlayer.name)
end

-- Désinscription à la liste des décès 
local function on_player_respawned(e)
  local LuaPlayer = game.players[e.player_index]
  for i,player in pairs(global.teleport.player_died) do 
    if player == LuaPlayer.name then 
      table.remove(global.teleport.player_died, i)
    end
  end 
end


------------------------------------------------------------------------
-- Nouveau joueur arrivant
-- Créer une surface avec les paramètres enregistrés en map gen settings
local function NewPlayerSurface(LuaPlayer)
  if script.level.level_name == "freeplay" then
    flib.surface.createLobby(LuaPlayer)
  end
end


  
  
----------------------------------------------------------------------------------------
-- Quand un joueur arrive en jeu
local function on_player_joined_game(e)

    local LuaPlayer = game.players[e.player_index] --deprecated
    local LuaSurface = rPlayer.surface

    if script.level.campaign_name 
    or script.level.level_name ~= "wave-defense"
    or script.level.level_name ~= "pvp" then 
      -- Creation de la structure de map dans les données
      flib.surface.generateSurface(game.surfaces.nauvis)
      global.teleport.surfaces["nauvis"].exception = true
      global.teleport.surfaces["nauvis"].map_used = true
      global.teleport.surfaces["nauvis"].inventories[LuaPlayer.name] = flib.inventory.init()
    end

    -- le joueur n'existe pas dans la structure
    if not global.teleport.players[LuaPlayer.name] then 
      NewPlayerSurface(LuaPlayer)
      return
    -- le joueur n'est plus lié à une map d'origine
    elseif global.teleport.players[LuaPlayer.name].origine == "" then
      NewPlayerSurface(LuaPlayer)
      return
    end

    local surfaceOrigineName = global.teleport.players[LuaPlayer.name].origine

    -- player is home
    if  surfaceOrigineName == LuaSurface.name then
      flib.surface.addPlayer(LuaPlayer)
      flib.inventory.get(LuaPlayer, global.teleport.surfaces[surfaceOrigineName].inventories[LuaPlayer.name])
      if LuaPlayer.character then LuaPlayer.character.active = true end
    else -- player is no home
      LuaPlayer.teleport({0,0}, global.teleport.players[LuaPlayer.name].origine)
      if LuaPlayer.character then LuaPlayer.character.active = true end
    end
end
  
-------------------------------------------------------------------------------------------------------------
-- Vérifie si le joueur est proche d'un portail lié quand il est en mouvement et le téléporte si c'est le cas
local function on_player_changed_position(e)
    local LuaPlayer = game.players[e.player_index]
    local LuaSurface = LuaPlayer.surface

    -- No characters
    if LuaPlayer.character == nil then return end
  
    if global.teleport.surfaces[LuaSurface.name] then  

      -- mise à jour de l'info tp sur deplacement du joueurs
      if global.teleport.surfaces[LuaSurface.name].players then 
        local player = global.teleport.surfaces[LuaSurface.name].players[LuaPlayer.name]
        if player then
          if player.tick then
            if (game.tick - player.tick) >= 180 then
              player.tp = false
            end
          end
        end
      end

      if global.teleport.surfaces[LuaSurface.name].portals then
        local nb_portal = flib.portal.getValue(LuaSurface)
        
        if nb_portal > 0 then
  
          for _,portal in pairs(global.teleport.surfaces[LuaSurface.name].portals) do
            if portal.teleport ~= 0 then
                  
                if (LuaPlayer.position.x >= (portal.position.x - 1) 
                  and LuaPlayer.position.x <= (portal.position.x + 1)) 
                  and (LuaPlayer.position.y >= (portal.position.y - 1) 
                  and LuaPlayer.position.y <= (portal.position.y + 1)) then
                      
                  local position = portal.position
                  local id = flib.portal.getId(LuaSurface, position)
                  local LuaGui = LuaPlayer.gui.screen[ritnmods.teleport.defines.name.gui.main_portal]
                      
                  -- Teleportation
                  flib.portal.teleport(LuaSurface, id, LuaPlayer)

                  -- Fermeture de tous les gui
                  ritnGui.remote.close(LuaPlayer)
                  ritnGui.teleporter.close(LuaSurface, LuaPlayer)
                  ritnGui.portal.close(LuaSurface, LuaPlayer)
                  ritnGui.menu.frame_menu_close(LuaPlayer)
                  ritnGui.menu.frame_restart_close(LuaPlayer)
                  
                end 
  
            end
          end
  
        end
  
      end

    end
end


local function on_runtime_mod_setting_changed(e)
  local LuaPlayer = game.players[e.player_index]
  local setting_name = e.setting
  local setting_type = e.setting_type

  if setting_type == "runtime-per-user" then 
    if setting_name == ritnmods.teleport.defines.name.settings.enable_main_button then 
      ritnGui.menu.button_main_open(LuaPlayer)
    end
  end

  if setting_type == "runtime-global" then 
    if setting_name == ritnmods.teleport.defines.name.settings.surfaceMax then
      local setting_value = settings.global[setting_name].value
      global.settings.surfaceMax = setting_value
    end
  end

end


-- Annonce les recherche terminée si le joueur n'est pas chez lui
local function on_research_finished(e)
  if e.by_script == true then return end 

  local LuaTechnology = e.research
  local LuaForce = LuaTechnology.force
  local LuaPlayer = game.players[LuaForce.name]
  
  if LuaPlayer then 
    local setting_name = ritnmods.teleport.defines.name.settings.show_research
    local setting_value = settings.get_player_settings(LuaPlayer)[setting_name].value
    if LuaPlayer.surface.name ~= LuaForce.name then 
      if setting_value then
        local richText = "[technology=" .. LuaTechnology.name .. "]"
        LuaPlayer.print({ritnmods.teleport.defines.name.caption.msg.show_research, richText}, {r=1,g=0,b=0,a=1})
      end
    end
  end
end



local module = {}
module.events = {}
-- Events Player
module.events[defines.events.on_player_changed_surface] = on_player_changed_surface
module.events[defines.events.on_player_joined_game] = on_player_joined_game
module.events[defines.events.on_pre_player_left_game] = on_pre_player_left_game
module.events[defines.events.on_player_left_game] = on_player_left_game
module.events[defines.events.on_player_changed_position] = on_player_changed_position
module.events[defines.events.on_pre_player_died] = on_pre_player_died
module.events[defines.events.on_player_respawned] = on_player_respawned
module.events[defines.events.on_runtime_mod_setting_changed] = on_runtime_mod_setting_changed
module.events[defines.events.on_research_finished] = on_research_finished

return module