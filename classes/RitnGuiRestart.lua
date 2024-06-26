-- RitnLobbyGuiRestart
----------------------------------------------------------------
local modGui = require("mod-gui")
----------------------------------------------------------------
local fGui = require(ritnlib.defines.lobby.gui.restart)
----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
RitnLobbyGuiRestart = ritnlib.classFactory.newclass(RitnLibGui, function(base, event)
    RitnLibGui.init(base, event, ritnlib.defines.lobby.name, "frame-restart")
    base.object_name = "RitnLobbyGuiRestart"
    --------------------------------------------------
    base.gui_name = "restart"
    base.gui_action = {
        [base.gui_name] = {
            [ritnlib.defines.lobby.gui_actions.restart.open] = true,
            [ritnlib.defines.lobby.gui_actions.restart.close] = true,
            [ritnlib.defines.lobby.gui_actions.restart.back] = true,
            [ritnlib.defines.lobby.gui_actions.restart.valid] = true,
        }
    }
    --------------------------------------------------
    base.gui = { base.player.gui.center }
    --------------------------------------------------
    base.content = fGui.getContent()
    --------------------------------------------------
end)


-- create GUI
function RitnLobbyGuiRestart:create()
    if self.gui[1][self.gui_name.."-"..self.main_gui] then return self end

    local element = fGui.getElement(self.gui_name)

    -- assembly gui elements
    local content = {
        flow = {},
        frame = {},
        label = {},
        button = {},
    }

    -- frame restart
    content.frame.restart =    self.gui[1].add(element.frame.restart)
    -- flow main
    content.flow.main =         content.frame.restart.add(element.flow.main)
    -- label warning1
    content.label.warning1 =    content.flow.main.add(element.label.warning1)
    -- label warning2
    content.label.warning2 =    content.flow.main.add(element.label.warning2)
    -- flow dialog
    content.flow.dialog =       content.flow.main.add(element.flow.dialog)
    -- button back
    content.button.back =       content.flow.dialog.add(element.button.back)
    -- empty-widget
    content.empty =             content.flow.dialog.add(element.empty)
    -- button valid
    content.button.valid =      content.flow.dialog.add(element.button.valid)
    

    RitnLibStyle(content.frame.restart):frame():maxWidth(500)
    RitnLibStyle(content.flow.main):align("center", "center")
    RitnLibStyle(content.flow.dialog):stretchable():topPadding(4)
    RitnLibStyle(content.button.back):smallButton()
    RitnLibStyle(content.empty):width(250)
    RitnLibStyle(content.button.valid):smallButton()

end



----------------------------------------------------------------
-- ACTIONS --
----------------------------------------------------------------

function RitnLobbyGuiRestart:action_close()
    local frame_restart = self.gui[1][self.gui_name.."-"..self.main_gui]
    if frame_restart then frame_restart.destroy() end
    remote.call("RitnLobbyGame", "gui_action_menu", ritnlib.defines.lobby.gui_actions.menu.close, self.event)

    log('> '..self.object_name..':action_close()')
    return self
end


function RitnLobbyGuiRestart:action_open()
    self:action_close()
    self:create()
    log('> '..self.object_name..':action_open()')
    return self
end


function RitnLobbyGuiRestart:action_valid()
    local rSurface = RitnLobbySurface(self.surface)
    if rSurface then 
        rSurface:setException(rSurface.isNauvis):clean()
    end
    ----
    self:action_close()

    log('> '..self.object_name..':action_valid()')
    return self
end



----------------------------------------------------------------
--return RitnLobbyGuiRestart