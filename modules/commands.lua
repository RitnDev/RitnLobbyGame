-- MODULE : COMMANDS
---------------------------------------------------------------------------------
-- add command for RitnTeleportation
---------------------------------------------------------------------------------


local function exclusion(playerExclure, surface)
    if playerExclure == surface then return end
    for i,player in pairs(global.teleport.surfaces[surface].origine) do 
        if player == playerExclure then 
            -- sauvegarde de l'inventaire avant exclusion
            ritnlib.inventory.save(game.players[playerExclure], global.teleport.surfaces[surface].inventories[playerExclure])
            -- suppression du joueur dans origine de la map
            table.remove(global.teleport.surfaces[surface].origine, i)
            global.teleport.players[playerExclure] = nil

            if game.players[playerExclure] 
            and game.players[playerExclure].valid 
            and game.players[playerExclure].connected then   
                -- retour lobby
                game.players[playerExclure].teleport({0,0}, "lobby~" .. playerExclure)
                game.players[playerExclure].clear_items_inside()
            end
            print("Exclusion/Quit : " .. playerExclure .. " - surface : " .. surface .. " OK !")
            log("Exclusion/Quit : " .. playerExclure .. " - surface : " .. surface .. " OK !")
        end
    end
end




-- Pour admin seulement : exclure un joueur de sa map.
commands.add_command("exclure", "/exclure <player>", 
function (e)

    local autorize = false
    local is_player = false

    if e.player_index then 
      local LuaPlayer = game.players[e.player_index]
      if LuaPlayer.admin or LuaPlayer.name == "Ritn" then
        autorize = true
        is_player = true
      end
    else 
      autorize = true
    end
    
    if e.parameter ~= nil then
        local playerExclure = e.parameter

        if game.players[playerExclure] then
            if autorize then 
                if global.teleport.players[playerExclure] then 
                    local surface = global.teleport.players[playerExclure].origine
                    exclusion(playerExclure, surface)
                    if is_player then 
                        if LuaPlayer then 
                            LuaPlayer.print("Exclusion/Quit : " .. playerExclure .. " - surface : " .. surface .. " OK !")
                        end
                    end
                end
            end
        end
    end
  end
)


-- Quitter par soit même la map.
commands.add_command("quit", "/quit", 
    function (e)
        local LuaPlayer = game.players[e.player_index]
        if LuaPlayer then 
            local playerExclure = LuaPlayer.name
            if global.teleport.players[playerExclure] then 
                local surface = global.teleport.players[playerExclure].origine
                exclusion(playerExclure, surface)
            end
        end
    end
)






-- Pour admin seulement : exclure un joueur de sa map.
commands.add_command("surfaces", "", 
function (e)

    local LuaPlayer = {}
    local autorize = false
    local is_player = false

    if e.player_index then 
      LuaPlayer = game.players[e.player_index]
      if LuaPlayer.admin or LuaPlayer.name == "Ritn" then
        autorize = true
        is_player = true
      end
    else 
      autorize = true
    end
    
    if autorize then 
        if is_player then
          -- by player : admin
          for _,surface in pairs(global.teleport.surfaces) do 
            LuaPlayer.print(surface.name)
          end
        else 
          -- by server
          for _,surface in pairs(global.teleport.surfaces) do 
            print(surface.name)
          end
        end
      end
  end
)

commands.add_command("clean", "<player>", function (e)

  local autorize = false
  local is_player = false

  if e.player_index then 
      local LuaPlayer = game.players[e.player_index]
      if LuaPlayer.admin or LuaPlayer.name == "Ritn" then
          autorize = true
          is_player = true
      end
  else 
      autorize = true
  end
  
  if e.parameter ~= nil then
      local parametre = e.parameter

      if global.tp.surfaces[parametre] then 
          if autorize then 
          if is_player then
              -- by player : admin
              events.utils.clean(parametre, game.players[e.player_index])
          else 
              -- by server
              events.utils.clean(parametre)
          end
          end
      end
  end

end)

commands.add_command("exception", "<add/remove/view> <player>", function(e)
  local LuaPlayer = game.players[e.player_index]
  if LuaPlayer.admin or LuaPlayer.name == "Ritn" then
      if e.parameter ~= nil then 

          local pattern = "([^ ]*) ?([^ ]*)"
          local param = {cmd,player}
          local result
          param.cmd, param.player = string.match(e.parameter, pattern)

          if param.cmd == "add" then 
              result = events.utils.exception.add(param.player)
              if result == true then 
                  LuaPlayer.print("add exception " .. param.player .. " OK !")
              else
                  LuaPlayer.print("-> /exception add <player>") 
              end
          elseif param.cmd == "remove" then
              result = events.utils.exception.remove(param.player)
              if result == true then 
                  LuaPlayer.print("Remove exception " .. param.player .. " OK !")
              else
                  LuaPlayer.print("-> /exception remove <player> ") 
              end
          elseif param.cmd == "view" then
              events.utils.exception.view(LuaPlayer)
          end
              
          else
              LuaPlayer.print("-> /exception <add/remove/view> <player>") 
          end 
  end 
end)




commands.add_command("reset_evo", nil, function(e)
  local LuaPlayer = game.players[e.player_index]
  if LuaPlayer.admin or LuaPlayer.name == "Ritn" then
      for _,surface in pairs(global.tp.surfaces) do 
          if e.parameter == nil then 
              surface.time = 0
              surface.current_time = 0
              surface.last_time = 0
              surface.pollution.last = 0
              surface.pollution.current = 0
              surface.pollution.count = 0
          elseif e.parameter == "time" then 
              surface.time = 0
              surface.current_time = 0
              surface.last_time = 0
          elseif e.parameter == "pollution" then
              surface.pollution.last = 0
              surface.pollution.current = 0
              surface.pollution.count = 0
          end
      end
  end 
end)

---------------------------------------------------------------------------------
local module = { events = {} } 
return module
