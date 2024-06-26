-- RitnLobbyGuiMenuButton
----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
RitnLobbyGuiMenuButton = ritnlib.classFactory.newclass(RitnGuiMenuButton, function(base, event)
    RitnGuiMenuButton.init(base, event)
    --------------------------------------------------
    base.mod_name = ritnlib.defines.lobby.name
    base.gui_action = {
        [base.gui_name] = {
            [ritnlib.defines.lobby.gui_actions.ritn.open] = true,
            [ritnlib.defines.lobby.gui_actions.ritn.close] = true,
            [ritnlib.defines.lobby.gui_actions.ritn.menu] = true,
        }
    }
    --------------------------------------------------
end)

----------------------------------------------------------------



----------------------------------------------------------------
-- ACTIONS --
----------------------------------------------------------------

function RitnLobbyGuiMenuButton:action_close()
    local button_menu = self.gui[1][self.gui_name.."-"..self.main_gui]
    if button_menu then button_menu.destroy() end
    log('> ('..self.mod_name..') -> '.. self.object_name..':action_close()')
    return self
end

function RitnLobbyGuiMenuButton:action_open()
    self:action_close()
    self:create()
    log('> ('..self.mod_name..') -> '.. self.object_name..':action_open()')
    return self
end


function RitnLobbyGuiMenuButton:action_menu()
    RitnLobbyGuiMenu(self.event):action_toggle_menu()
    log('> ('..self.mod_name..') -> '.. self.object_name..':action_menu('.. self.player.name ..')')
    return self
end


----------------------------------------------------------------
--return RitnLobbyGuiMenuButton