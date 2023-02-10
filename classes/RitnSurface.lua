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
    --------------------------------------------------
    base.data_request = remote.call("RitnCoreGame", "get_data", "request")
    --------------------------------------------------
end)

----------------------------------------------------------------



-- creation de la requete : @applicant = demandeur
function RitnSurface:createRequest(applicant)
    if self.data[self.name] == nil then return error(self.name .. " not init !") end 
    
    if not self.data[self.name].requests[applicant] then 
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
local function rejectRequest(LuaPlayer, reponse)
    local playerSend = reponse.name

    if not global.teleport.requests[playerSend] then 
        LuaPlayer.print({"msg.timeout-request"})
        -- suppression de la request
        global.teleport.surfaces[LuaPlayer.name].requests[playerSend] = nil
        return 
    end

    if global.teleport.requests[playerSend][LuaPlayer.name] then
        if global.teleport.surfaces[LuaPlayer.name] then 
            if global.teleport.surfaces[LuaPlayer.name].requests[playerSend] then
                if global.teleport.surfaces[LuaPlayer.name].requests[playerSend].state == 1 then 
                    -- suppression de la request
                    global.teleport.surfaces[LuaPlayer.name].requests[playerSend] = nil
                    global.teleport.requests[playerSend][LuaPlayer.name] = nil
                    -- envoie un message comme quoi la demande a été refusé !
                    if game.players[playerSend].valid and game.players[playerSend].connected then
                        game.players[playerSend].print({"msg.reject-request", LuaPlayer.name})
                    end
                end
            end
        end
    end
end
  
-- Rejeter toute demande de ce joueur
local function rejectAllRequest(LuaPlayer, reponse)
    local playerSend = reponse.name

    if not global.teleport.requests[playerSend] then 
        LuaPlayer.print({"msg.timeout-request"})
        -- suppression de la request
        global.teleport.surfaces[LuaPlayer.name].requests[playerSend] = nil
        return 
    end

    if global.teleport.requests[playerSend][LuaPlayer.name] then
        if global.teleport.surfaces[LuaPlayer.name] then 
            if global.teleport.surfaces[LuaPlayer.name].requests[playerSend] then
                if global.teleport.surfaces[LuaPlayer.name].requests[playerSend].state == 1 then 
                    -- suppression de la request
                    global.teleport.surfaces[LuaPlayer.name].requests[playerSend].state = 0
                    global.teleport.surfaces[LuaPlayer.name].requests[playerSend].reject_all=true
                    global.teleport.requests[playerSend][LuaPlayer.name] = nil
                    -- envoie un message comme quoi la demande a été refusé !
                    if game.players[playerSend].valid and game.players[playerSend].connected then
                        game.players[playerSend].print({"msg.reject-request", LuaPlayer.name})
                    end
                end
            end
        end
    end
end



----------------------------------------------------------------
return RitnSurface