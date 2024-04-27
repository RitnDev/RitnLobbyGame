-- MODULE : INVENTORY
---------------------------------------------------------------------------------------------
local RitnEvent = require(ritnlib.defines.core.class.event)
local RitnForce = require(ritnlib.defines.core.class.force)
---------------------------------------------------------------------------------------------

local function on_player_changed_force(e) 
    local rEvent = RitnEvent(e)
    
    -- On sauvegarde l'inventaire de la force avant changement
    local rOldForce = rEvent:getForce()
    rOldForce:saveInventory(rEvent.player)

    -- On charge l'inventaire de la force d'arrivée
    local rNewForce = RitnForce(rEvent.player.force)
    rNewForce:loadInventory(rEvent.player)


    if ((rOldForce.name == rEvent.FORCE_DEFAULT) and (rNewForce.name == rEvent.player.name)) then 
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