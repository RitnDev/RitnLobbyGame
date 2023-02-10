-- RitnGuiMenu
----------------------------------------------------------------
local class = require(ritnlib.defines.class.core)
local modGui = require("mod-gui")
local libStyle = require(ritnlib.defines.class.gui.style)
local libGui = require(ritnlib.defines.class.luaClass.gui)
local RitnSurface = require(ritnlib.defines.lobby.class.surface)
----------------------------------------------------------------
local font = ritnlib.defines.names.font
local fGui = require(ritnlib.defines.lobby.gui.request)
----------------------------------------------------------------




----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
local RitnGuiMenu = class.newclass(libGui, function(base, event, request_name)
    libGui.init(base, event, ritnlib.defines.lobby.name, "frame-main_"..request_name)
    base.object_name = "RitnGuiMenu"
    --------------------------------------------------
    base.gui_name = "request"
    base.gui_action = {
        [base.gui_name] = {
            [ritnlib.defines.lobby.gui_actions.menu.open] = true,
            [ritnlib.defines.lobby.gui_actions.menu.close] = true,
            [ritnlib.defines.lobby.gui_actions.menu.toggle] = true,
        }
    }    
    --------------------------------------------------
    local left = modGui.get_frame_flow(base.player)
    base.gui = { left["common-flow-main"]["common-flow-menu"] }
    --------------------------------------------------
    base.content = fGui.getContent()
    --------------------------------------------------
end)


----------------------------------------------------------------
-- ACTIONS --
----------------------------------------------------------------

function RitnGuiMenu:action_close()
    local frame_menu = self.gui[1][self.gui_name.."-"..self.main_gui]
    if frame_menu then frame_menu.destroy() end
    log('> '..self.object_name..':action_close()')
    return self
end

function RitnGuiMenu:action_open()
    self:action_close()
    self:create()
    log('> '..self.object_name..':action_open()')
    return self
end

function RitnGuiMenu:action_toggle_menu()
    local frame_menu = self.gui[1][self.gui_name.."-"..self.main_gui]
    if frame_menu then 
        self:action_close()
    else 
        self:action_open() 
    end
    log('> '..self.object_name..':action_toggle_menu()')
    return self
end



----------------------------------------------------------------
return RitnGuiMenu