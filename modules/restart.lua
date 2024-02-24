-- MODULE : RESTART
---------------------------------------------------------------------------------------------
local RitnGuiRestart = require(ritnlib.defines.lobby.class.guiRestart)
---------------------------------------------------------------------------------------------


local function on_gui_click(e)
    RitnGuiRestart(e):on_gui_click()
end


local function on_pre_player_left_game(e) 
    RitnGuiRestart(e):action_close()
end


----------------------
local module = {}
module.events = {}
----------------------
module.events[defines.events.on_gui_click] = on_gui_click
module.events[defines.events.on_pre_player_left_game] = on_pre_player_left_game
----------------------
return module