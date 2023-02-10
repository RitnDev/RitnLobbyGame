-- MODULE : REQUEST
---------------------------------------------------------------------------------------------
local RitnEvent = require(ritnlib.defines.core.class.event)
local RitnGuiRequest = require(ritnlib.defines.lobby.class.guiRequest)
---------------------------------------------------------------------------------------------



local function on_gui_click(e)
    if e.element.valid then 
        local request_name = string.sub(e.element.parent.name, 21)
        RitnGuiRequest(e, request_name):on_gui_click(request_name)
    end
    ----
    log('on_gui_click')
end




----------------------
local module = {}
module.events = {}
----------------------
--module.events[defines.events.on_player_changed_surface] = on_player_changed_surface
module.events[defines.events.on_gui_click] = on_gui_click
----------------------
return module