-- RitnLobbySurface
----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
RitnLobbySurface = ritnlib.classFactory.newclass(RitnCoreSurface, function(self, LuaSurface)
    RitnCoreSurface.init(self, LuaSurface)
    log('> '..self.object_name..':init() -> RitnLobbyGame')
    --------------------------------------------------
    self.data_request = remote.call("RitnCoreGame", "get_data", "request")
    --------------------------------------------------
    log('> [RitnLobbyGame] > RitnLobbySurface')
end)

----------------------------------------------------------------



-- Envoie d'une demande à un joueur de venir jouer sur la surface avec lui
-- @param applicant = demandeur
function RitnLobbySurface:createRequest(applicant)
    if self.data[self.name] == nil then return error(self.name .. " not init !") end 
    
    if not self.data[self.name].requests[applicant] then 
        log('> '..self.object_name..':createRequest('..applicant..') -> for : '..self.name)
        local rPlayer = RitnCorePlayer(game.players[applicant])

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
-- @param request_name = joueur à accepter
function RitnLobbySurface:acceptRequest(request_name)
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
                    local rPlayer = RitnCorePlayer(game.players[request_name])                   
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
  

-- Rejeter une demande en cours
-- @param request_name = joueur à refuser
function RitnLobbySurface:rejectRequest(request_name)
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


-- Rejeter toute demande de ce joueur (bloquer)
-- @param request_name = joueur à bloquer
function RitnLobbySurface:rejectAllRequest(request_name)
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


-- On supprime la surface et toutes les données liés dans global
function RitnLobbySurface:clean()   --TODO : gerer exception = true
    local force_name = self.name
    ----
    -- On supprime de l'origine des joueurs ayant comme origine la surface à supprimer
    local players = remote.call("RitnCoreGame", "get_players")
    for index, player in pairs(players) do 

        local rPlayer = RitnCorePlayer(game.players[player.name])

        -- si la surface à le meme nom que l'origine du joueur
        if rPlayer.data[rPlayer.index].origine == self.name then
            -- si le joueur à le meme nom que l'origine alors c'est le propriétaire de la surface
            if rPlayer:isOwner() then 
                -- on récupère le nom de la force de ce joueur
                force_name = rPlayer.force.name
            end
            -- reset de l'origine
            rPlayer:setOrigine("")
            rPlayer:teleportLobby()
        end
    end
    ----
    game.delete_surface(self.name)
    self:delete()
    ----
    if game.forces[force_name] then 
        game.merge_forces(game.forces[force_name], ritnlib.defines.core.names.force_default) 
    end
end


-- @player_name : nom du joueur à exclure
function RitnLobbySurface:exclude(player_name)
    if self.data[self.name] == nil then return error(self.name .. " not init !") end 

    -- On récupère le RitnCorePlayer pour le tp sur son lobby après le traitement sur la surface
    local rPlayer = RitnCorePlayer(game.players[player_name])
    if rPlayer == nil then return end
    -- On supprime le joueur de la liste des subscribers de la surface
    local subscribers = self.data[self.name].subscribers
    for index, subscriber in pairs(subscribers) do 
        if subscriber == player_name then 
            self.data[self.name].subscribers[index] = nil
        end
    end
    ----
    self:update()
    -- On téléporte le player dans son lobby
    rPlayer:teleportLobby()
end



----------------------------------------------------------------
--return RitnLobbySurface