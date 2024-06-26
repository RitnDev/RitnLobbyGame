-- MODULE : RESTART
---------------------------------------------------------------------------------------------


local function on_gui_click(e)
    RitnLobbyGuiRestart(e):on_gui_click()
end


local function on_pre_player_left_game(e) 
    RitnLobbyGuiRestart(e):action_close()
end


----------------------
local module = {}
module.events = {}
----------------------
module.events[defines.events.on_gui_click] = on_gui_click
module.events[defines.events.on_pre_player_left_game] = on_pre_player_left_game
----------------------
return module