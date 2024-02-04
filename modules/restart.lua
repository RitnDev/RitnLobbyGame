-- MODULE : RESTART
---------------------------------------------------------------------------------------------
local RitnGuiRestart = require(ritnlib.defines.lobby.class.guiRestart)
---------------------------------------------------------------------------------------------


local function on_gui_click(e)
    RitnGuiRestart(e):on_gui_click()
end


----------------------
local module = {}
module.events = {}
----------------------
module.events[defines.events.on_gui_click] = on_gui_click
----------------------
return module