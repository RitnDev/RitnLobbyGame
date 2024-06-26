-- MODULE : INVENTORY
---------------------------------------------------------------------------------------------

local function on_player_changed_force(e) 
    local rEvent = RitnCoreEvent(e)
    
    -- On sauvegarde l'inventaire de la force avant changement
    local rOldForce = rEvent:getForce()
    rOldForce:saveInventory(rEvent.player)

    -- On charge l'inventaire de la force d'arrivée
    local rNewForce = RitnCoreForce(rEvent.player.force)
    rNewForce:loadInventory(rEvent.player)


    if ((rOldForce.name == rEvent.FORCE_DEFAULT_NAME) and (rNewForce.name == rEvent.player.name)) then 
        rNewForce:insertInventory(rEvent.player)
    end

    log('on_player_changed_force')
end

----------------------
local module = {}
module.events = {}
----------------------
module.events[defines.events.on_player_changed_force] = on_player_changed_force
----------------------
return module