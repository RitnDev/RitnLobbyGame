-- MODULE : MENU
---------------------------------------------------------------------------------------------
local RitnEvent = require(ritnlib.defines.core.class.event)
local RitnPlayer = require(ritnlib.defines.core.class.player)
local RitnGuiMenuButton = require(ritnlib.defines.lobby.class.guiButtonMenu)
---------------------------------------------------------------------------------------------


local function on_gui_click(e)
    RitnGuiMenuButton(e):on_gui_click()
end


----------------------
local module = {}
module.events = {}
----------------------
module.events[defines.events.on_gui_click] = on_gui_click
----------------------
return module