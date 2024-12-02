-- MODULE : COMMANDS
---------------------------------------------------------------------------------
local util = require(ritnlib.defines.other)
local string = require(ritnlib.defines.string)
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
    for i,player in pairs(storage.teleport.surfaces[surface].origine) do 
        if player == playerExclure then 
            -- sauvegarde de l'inventaire avant exclusion
            ritnlib.inventory.save(game.players[playerExclure], storage.teleport.surfaces[surface].inventories[playerExclure])
            -- suppression du joueur dans origine de la map
            table.remove(storage.teleport.surfaces[surface].origine, i)
            storage.teleport.players[playerExclure] = nil

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
                if storage.teleport.players[playerExclure] then 
                    local surface = storage.teleport.players[playerExclure].origine
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
        if e.player_index then
            local LuaPlayer = game.players[e.player_index]
            if util.type(LuaPlayer) == "LuaPlayer" then
                local players = remote.call("RitnCoreGame", "get_players")

                if players[e.player_index] then 
                    local surface = players[e.player_index].origine
                    -- on vérifie qu'il soit bien sur sa s
                    if players[e.player_index].surface == surface then 
                        RitnCorePlayer(LuaPlayer):teleportLobby():setOrigine(string.TOKEN_EMPTY_STRING)
                    end
                end
            end 
        end
    end
)


-- Admin only
commands.add_command("clean", "<player>", function (e)
    local autorize = false
    local is_player = false

    if e.player_index then 
        local LuaPlayer = game.players[e.player_index]
        if LuaPlayer.admin or LuaPlayer.name == "Ritn" or LuaPlayer.name == "RitnDev" then
            autorize = true
            is_player = true
        end
    else 
        autorize = true
    end
    
    if e.parameter ~= nil then
        local surface_name = e.parameter
        local surfaces = remote.call("RitnCoreGame", "get_surfaces")

        if surfaces[surface_name] then 
            if autorize then 

                local rSurface = RitnLobbySurface(game.surfaces[surface_name])
                local result = false
                if (util.type(rSurface) == "RitnLibSurface") then 
                    result = rSurface:clean()
                end
                ----
                local message = " (clean) : "
                if result then 
                    message = message..surface_name
                else
                    message = message.."## FAIL ##"
                end

                if is_player then 
                    game.players[e.player_index].print(message)
                else
                    print(message)
                end
            end
        end
    end

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
