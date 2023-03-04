----------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------
local RitnPlayer = require(ritnlib.defines.core.class.player)
----------------------------------------------------------------







local function clean() --player_name, LuaPlayer


--[[     if player_name == nil then return end 

    -- vérification que personne est présent sur la map.
    if global.teleport.surfaces[player_name] then
        if game.surfaces[player_name] then

            local result = false
            for _,player in pairs(game.players) do 
                if global.teleport.players[player.name] then -- fix 2.0.9
                    if global.teleport.players[player.name].origine == player_name 
                    or player.surface.name == player_name then
                        if player.connected == true then
                            -- des joueurs sont connecté : annulation du clean.
                            result = true
                        end
                    end
                end
            end
            -- clean annulé
            if result == true then
                if LuaPlayer then LuaPlayer.print("Clean impossible") end
                log("[RITNTP] > Clean impossible")
                return 
            end

            -- Supression de la map d'origine
            for i,player in pairs(global.teleport.surfaces[player_name].origine) do 
                global.teleport.players[player] = nil
            end

            game.delete_surface(player_name) 
        end

        if game.forces[player_name] then game.merge_forces(game.forces[player_name], "player") end
        if game.forces[prefix_enemy .. player_name] then game.merge_forces(game.forces[prefix_enemy .. player_name], "enemy") end
        global.teleport.surfaces[player_name] = nil
        global.teleport.surface_value = global.teleport.surface_value - 1
        
        -- message de confirmation
        if LuaPlayer then 
            LuaPlayer.print("Clean OK for : " .. player_name) 
        end
        log("[RITNTP] > CLEAN OK for : " .. player_name)
    end ]]

end


local function restart() --LuaPlayer


--[[     local surface = LuaPlayer.surface.name
    if LuaPlayer.name ~= surface then return end
    if surface == nil then return end

    local tab_player = {}

    if global.teleport.surfaces[surface] then
        if game.surfaces[surface] then 
            local result = false 
            for _,player in pairs(game.players) do 
                if player.surface.name == surface then 
                    if global.teleport.players[player.name] then  -- fix 2.0.21
                        if global.teleport.players[player.name].origine ~= surface then
                            if player.connected == true then
                                result = true
                            end  
                        end
                    end
                end
            end
            if result == true then 
                LuaPlayer.print("Restart impossible")
                log("[RITNTP] > Restart impossible")
                return 
            end
            
            -- modif 1.8.0
            for i,player in pairs(global.teleport.surfaces[surface].origine) do 
                global.teleport.players[player] = nil

                -- modif 1.8.3
                game.players[player].teleport({i-1,i-1}, "nauvis")
                if game.players[player].character then 
                    game.players[player].character.active = false
                end
                table.insert(tab_player, player)
            end
            
            game.delete_surface(surface)
        end
        if game.forces[surface] then game.merge_forces(game.forces[surface], "player") end
        if game.forces[prefix_enemy .. surface] then game.merge_forces(game.forces[prefix_enemy .. surface], "enemy") end
        global.teleport.surfaces[surface] = nil
        global.teleport.surface_value = global.teleport.surface_value - 1
        log("[RITNTP] > RESTART OK for : " .. LuaPlayer.name)

        for i = 1, #tab_player do 
            local player = tab_player[i]
            game.players[player].teleport({0,0}, "lobby~" .. player)
            game.players[player].clear_items_inside()
        end
    end ]]
    
end


local function add_exception(player_name)
    local result = false
    if not game.players[player_name] then return result end
    if not game.surfaces[player_name] then return result end
    if not global.teleport.surfaces[player_name] then return result end
    if global.teleport.surfaces[player_name].exception == true then return result end
    global.teleport.surfaces[player_name].exception = true
    result = true
    return result
end

local function remove_exception(player_name)
    local result = false
    if not game.players[player_name] then return result end
    if game.players[player_name].admin == true then return result end
    if not game.surfaces[player_name] then return result end
    if not global.teleport.surfaces[player_name] then return result end
    if global.teleport.surfaces[player_name].exception == false then return result end
    global.teleport.surfaces[player_name].exception = false
    global.teleport.surfaces[player_name].last_use = game.tick
    result = true
    return result
end

local function view_exception(LuaPlayer)
    if LuaPlayer then LuaPlayer.print("Exceptions :") else print("Exceptions :") end
    for _,player in pairs(global.teleport.surfaces) do
        if player.name ~= "nauvis" then 
            if player.exception == true then
                if LuaPlayer then
                    LuaPlayer.print("> " .. player.name)
                else
                    print("> " .. player.name)
                end
            end
        end
    end
end

----------------------------------------------------------------
local flib = {
    exclure = exclure,
    clean = clean,
    restart = restart,
    add_exception = add_exception,
    remove_exception = remove_exception,
    view_exception = view_exception,
}
----------------------------------------------------------------
return flib