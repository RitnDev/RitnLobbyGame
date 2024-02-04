-- RitnSurface
----------------------------------------------------------------
local class = require(ritnlib.defines.class.core)
local RitnCoreSurface = require(ritnlib.defines.core.class.surface)
----------------------------------------------------------------
local RitnPlayer = require(ritnlib.defines.core.class.player)
----------------------------------------------------------------



----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
local RitnSurface = class.newclass(RitnCoreSurface, function(base, LuaSurface)
    if LuaSurface == nil then return end
    if LuaSurface.valid == false then return end
    if LuaSurface.object_name ~= "LuaSurface" then return end
    RitnCoreSurface.init(base, LuaSurface)
    log('> '..base.object_name..':init() -> RitnLobbyGame')
    --------------------------------------------------
    base.data_request = remote.call("RitnCoreGame", "get_data", "request")
    --------------------------------------------------
    log('> [RitnLobbyGame] > RitnSurface')
end)

----------------------------------------------------------------



-- creation de la requete : @applicant = demandeur
function RitnSurface:createRequest(applicant)
    if self.data[self.name] == nil then return error(self.name .. " not init !") end 
    
    if not self.data[self.name].requests[applicant] then 
        log('> '..self.object_name..':createRequest('..applicant..') -> for : '..self.name)
        local rPlayer = RitnPlayer(game.players[applicant])

        self.data[self.name].requests[applicant] = self.data_request
        self.data[self.name].requests[applicant].name = applicant

        local options = remote.call("RitnCoreGame", "get_options")
        if not options.requests[applicant] then options.requests[applicant] = {} end
        options.requests[applicant][self.name] = {name = self.name}
        remote.call("RitnCoreGame", "set_options", options)

        rPlayer.player.print({"msg.send-request", self.name}, {r = 1, g = 0, b = 0, a = 0.3})

        self:update()

        -- créer la fenetre "gui_request" à l'utilisateur ciblé
        local event = {player_index = game.players[self.data[self.name].origine].index}
        remote.call("RitnLobbyGame", "gui_action_request", "open", event, applicant)
    end

    return self
end




-- Accepter une demande en cours OU supprimer l'effet du rejectAll
function RitnSurface:acceptRequest(request_name)
    if self.data[self.name] == nil then return error(self.name .. " not init !") end 

    log('> '..self.object_name..':acceptRequest('..request_name..') -> accept by : '..self.name)

    if self.data[self.name].requests[request_name] then
        if self.data[self.name].requests[request_name].state == 1 then  
            log('> request.state = 1')
            local options = remote.call("RitnCoreGame", "get_options")
            
            if not options.requests[request_name] then 
                -- une requete a déjà été accepté ailleurs
                game.players[self.data[self.name].origine].print({"msg.timeout-request"})
                -- suppression de la request
                self.data[self.name].requests[request_name] = nil
            else

                if options.requests[request_name][self.name] then 
                    log('> options.requests.'..request_name..'.'..self.name)
                    table.insert(self.data[self.name].subscribers, request_name)

                    -- Enregistrement de la surface d'origine 
                    local rPlayer = RitnPlayer(game.players[request_name])                   
                    rPlayer:setOrigine(self.name)

                    -- Teleportation sur la surface du personnage.
                    rPlayer:teleport({0,0}, self.name, true)
                    
                    -- ajout du joueur à la surface (OVERRIDE : on_player_changed_surface)
                    self:addPlayer(rPlayer.player)

                    -- suppression de la request
                    self.data[self.name].requests[request_name] = nil
                    options.requests[request_name] = nil
                end 

            end

            remote.call("RitnCoreGame", "set_options", options)

        elseif self.data[self.name].requests[request_name].state == 0 then
            log('> request.state = 0')
            self.data[self.name].requests[request_name] = nil
        end
    end
 
    self:update()

    return self
end
  

-- rejeter une demande en cours
function RitnSurface:rejectRequest(request_name)
    if self.data[self.name] == nil then return error(self.name .. " not init !") end 

    log('> '..self.object_name..':rejectRequest('..request_name..') -> reject by : '..self.name)
    
    if self.data[self.name].requests[request_name] then
        if self.data[self.name].requests[request_name].state == 1 then  
            log('> request.state = 1')
            local options = remote.call("RitnCoreGame", "get_options")
            
            if not options.requests[request_name] then 
                -- une requete a déjà été accepté ailleurs
                game.players[self.data[self.name].origine].print({"msg.timeout-request"})
                -- suppression de la request
                self.data[self.name].requests[request_name] = nil
            else

                if options.requests[request_name][self.name] then 
                    log('> options.requests.'..request_name..'.'..self.name)
                    -- suppression de la request
                    self.data[self.name].requests[request_name] = nil
                    options.requests[request_name] = nil
                    -- envoie un message comme quoi la demande a été refusé !
                    if game.players[request_name].valid and game.players[request_name].connected then
                        game.players[request_name].print({"msg.reject-request", self.name})
                    end
                end 

            end

            remote.call("RitnCoreGame", "set_options", options)

        elseif self.data[self.name].requests[request_name].state == 0 then
            log('> request.state = 0')
            self.data[self.name].requests[request_name] = nil
        end
    end

    self:update()

    return self

end


-- Rejeter toute demande de ce joueur
function RitnSurface:rejectAllRequest(request_name)
    if self.data[self.name] == nil then return error(self.name .. " not init !") end 

    log('> '..self.object_name..':rejectAllRequest('..request_name..') -> reject by : '..self.name)
    
    if self.data[self.name].requests[request_name] then
        if self.data[self.name].requests[request_name].state == 1 then  
            log('> request.state = 1')
            local options = remote.call("RitnCoreGame", "get_options")
            
            if not options.requests[request_name] then 
                -- une requete a déjà été accepté ailleurs
                game.players[self.data[self.name].origine].print({"msg.timeout-request"})
                -- suppression de la request
                self.data[self.name].requests[request_name] = nil
            else

                if options.requests[request_name][self.name] then 
                    log('> options.requests.'..request_name..'.'..self.name)
                    
                    -- suppression de la request
                    self.data[self.name].requests[request_name].state = 0
                    self.data[self.name].requests[request_name].reject_all=true
                    options.requests[request_name] = nil
                    -- envoie un message comme quoi la demande a été refusé !
                    if game.players[request_name].valid and game.players[request_name].connected then
                        game.players[request_name].print({"msg.reject-request", self.name})
                    end
                end 

            end
            remote.call("RitnCoreGame", "set_options", options)
        end
    end

    self:update()

    return self

end
  


function RitnSurface:clean()
    local force_name = self.name
    ----
    -- On supprime de l'origine des joueurs ayant comme origine la surface à supprimer
    local players = remote.call("RitnCoreGame", "get_players")
    for index, player in pairs(players) do 
        if player.origine == self.name then 
            player.origine = ""
            if player.name == player.origine then 
                force_name = player.force
            end
            local LuaPlayer = game.players[index]
            if LuaPlayer ~= nil then 
                local lobby_name = ritnlib.defines.core.names.prefix.lobby .. LuaPlayer.name
                LuaPlayer.teleport({0,0}, lobby_name)
            end
        end
    end
    remote.call("RitnCoreGame", "set_players", players)
    ----
    game.delete_surface(self.name)
    self:delete()
    ----
    if game.forces[force_name] then game.merge_forces(game.forces[force_name], "player") end
end








-- @player_name : nom du joueur à exclure
function RitnSurface:exclure(player_name)
    local rPlayer = RitnPlayer(game.players[player_name])
    if rPlayer == nil then return end

    -- get player
    local players = remote.call("RitnCoreGame", "get_players")
    local player = players[rPlayer.index]


--[[ 
    local surface = LuaPlayer.name
    if global.teleport.surfaces[surface] then
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
                    -- fix 2.0.23
                    if LuaPlayer.driving then 
                        -- on fait sortir le joueur du vehicule
                        LuaPlayer.driving = false
                    end
                    -- retour lobby
                    game.players[playerExclure].teleport({0,0}, "lobby~" .. playerExclure)
                    game.players[playerExclure].clear_items_inside()
                end
            end
        end
    end
 ]]

end



----------------------------------------------------------------
return RitnSurface