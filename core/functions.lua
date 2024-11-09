----------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------
local RitnPlayer = require(ritnlib.defines.core.class.player)
----------------------------------------------------------------


local function restart() --LuaPlayer


--[[     local surface = LuaPlayer.surface.name
    if LuaPlayer.name ~= surface then return end
    if surface == nil then return end

    local tab_player = {}

    if storage.teleport.surfaces[surface] then
        if game.surfaces[surface] then 
            local result = false 
            for _,player in pairs(game.players) do 
                if player.surface.name == surface then 
                    if storage.teleport.players[player.name] then  -- fix 2.0.21
                        if storage.teleport.players[player.name].origine ~= surface then
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
            for i,player in pairs(storage.teleport.surfaces[surface].origine) do 
                storage.teleport.players[player] = nil

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
        storage.teleport.surfaces[surface] = nil
        storage.teleport.surface_value = storage.teleport.surface_value - 1
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
    if not storage.teleport.surfaces[player_name] then return result end
    if storage.teleport.surfaces[player_name].exception == true then return result end
    storage.teleport.surfaces[player_name].exception = true
    result = true
    return result
end

local function remove_exception(player_name)
    local result = false
    if not game.players[player_name] then return result end
    if game.players[player_name].admin == true then return result end
    if not game.surfaces[player_name] then return result end
    if not storage.teleport.surfaces[player_name] then return result end
    if storage.teleport.surfaces[player_name].exception == false then return result end
    storage.teleport.surfaces[player_name].exception = false
    storage.teleport.surfaces[player_name].last_use = game.tick
    result = true
    return result
end

local function view_exception(LuaPlayer)
    if LuaPlayer then LuaPlayer.print("Exceptions :") else print("Exceptions :") end
    for _,player in pairs(storage.teleport.surfaces) do
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