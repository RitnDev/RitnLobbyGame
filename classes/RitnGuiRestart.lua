-- RitnGuiRestart
----------------------------------------------------------------
local class = require(ritnlib.defines.class.core)
local modGui = require("mod-gui")
local libStyle = require(ritnlib.defines.class.gui.style)
local libGui = require(ritnlib.defines.class.luaClass.gui)
----------------------------------------------------------------
local fGui = require(ritnlib.defines.lobby.gui.restart)
----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
local RitnGuiRestart = class.newclass(libGui, function(base, event)
    libGui.init(base, event, ritnlib.defines.lobby.name, "frame-restart")
    base.object_name = "RitnGuiRestart"
    --------------------------------------------------
    base.gui_name = "restart"
    base.gui_action = {
        [base.gui_name] = {
            [ritnlib.defines.lobby.gui_actions.restart.open] = true,
            [ritnlib.defines.lobby.gui_actions.restart.close] = true,
            [ritnlib.defines.lobby.gui_actions.restart.valid] = true,
            [ritnlib.defines.lobby.gui_actions.restart.back] = true,
        }
    }
    --------------------------------------------------
    base.gui = { base.player.gui.screen }
    --------------------------------------------------
    base.content = fGui.getContent()
    --------------------------------------------------
end)


-- create GUI
function RitnGuiRestart:create()
    if self.gui[1][self.gui_name.."-"..self.main_gui] then return self end

    local element = fGui.getElement(self.gui_name)
--[[ 
    -- assembly gui elements
    local content = {
        flow = {},
        frame = {},
        label = {},
        button = {},
    }

    -- frame surfaces
    content.frame.surfaces =    self.gui[1].add(element.frame.surfaces)
    -- flow surfaces
    content.flow.surfaces =     content.frame.surfaces.add(element.flow.surfaces)
    -- scroll-pane
    content.pane =              content.flow.surfaces.add(element.pane)
    -- list
    content.list =              content.pane.add(element.list)
    -- flow dialog
    content.flow.dialog =       content.flow.surfaces.add(element.flow.dialog)
    -- button close
    content.button.close =      content.flow.dialog.add(element.button.close)
    -- label info
    content.label.info =        content.flow.dialog.add(element.label.info)
    -- button valid
    content.button.valid =      content.flow.dialog.add(element.button.valid)
    

    libStyle(content.frame.surfaces):frame()
    libStyle(content.flow.surfaces):noPadding():stretchable().vertical_spacing = 8
    libStyle(content.pane):horizontalStretch():minHeight(220)
    libStyle(content.flow.dialog):stretchable():topPadding(4)
    libStyle(content.button.close):smallButton()
    libStyle(content.button.valid):smallButton()
 ]]

end


----------------------------------------------------------------
-- ACTIONS --
----------------------------------------------------------------








----------------------------------------------------------------
return RitnGuiRestart