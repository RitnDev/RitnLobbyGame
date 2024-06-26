-- MODULE : REQUEST
---------------------------------------------------------------------------------------------


local function on_gui_click(e)
    if e.element.valid then 
        if e.element.parent ~= nil then 
            local request_name = string.sub(e.element.parent.name, 21)
            RitnLobbyGuiRequest(e, request_name):on_gui_click(request_name)
        end
    end
end




----------------------
local module = {}
module.events = {}
----------------------
--module.events[defines.events.on_player_changed_surface] = on_player_changed_surface
module.events[defines.events.on_gui_click] = on_gui_click
----------------------
return module