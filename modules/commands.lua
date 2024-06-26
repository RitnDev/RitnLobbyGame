-- MODULE : COMMANDS
---------------------------------------------------------------------------------


-- Débloquer les requêtes d'un joueur ou l'accepter
commands.add_command("accept", "/accept <player>", 
    function (e)
        local LuaPlayer = game.players[e.player_index]
        if LuaPlayer then 
            local players = remote.call("RitnCoreGame", "get_players")
            local player = players[LuaPlayer.index]

            if player.name == player.origine then 
                if e.parameter ~= nil then
                    local parametre = e.parameter
                    local player_request = game.players[parametre] -- (LuaPlayer)
                    
                    if player_request then  -- (LuaPlayer)
                        if players[player_request.index] then 
                            local surfaces = remote.call("RitnCoreGame", "get_surfaces")
                            local surface = surfaces[player.origine]

                            if surface.requests[player_request.name] then 
                                RitnLobbySurface(game.surfaces[surface.name]):acceptRequest(player_request.name)
                                RitnLobbyGuiRequest({player_index = LuaPlayer.index}, player_request.name):action_close()
                            end
                        end
                    end
                end
            end
        end 

    end
)




local function exclusion(playerExclure, surface)

    --[[ if playerExclure == surface then return end
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
    end ]]

end




-- Pour admin seulement : exclure un joueur de sa map.
commands.add_command("exclure", "/exclure <player>", 
function (e)
--[[ 
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
    ]]
  end
)


-- Quitter par soit même la map.
commands.add_command("quit", "/quit", 
    function (e)
        --[[ 
        local LuaPlayer = game.players[e.player_index]
        if LuaPlayer then 
            local playerExclure = LuaPlayer.name
            if global.teleport.players[playerExclure] then 
                local surface = global.teleport.players[playerExclure].origine
                exclusion(playerExclure, surface)
            end
        end 
        ]]
    end
)



commands.add_command("clean", "<player>", function (e)
--[[ 
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
 ]]
end)

commands.add_command("exception", "<add/remove/view> <player>", function(e)
 --[[ 
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
  end  ]]
end)


---------------------------------------------------------------------------------
local module = { events = {} } 
return module
