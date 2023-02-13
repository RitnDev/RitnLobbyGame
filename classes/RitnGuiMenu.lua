-- RitnGuiMenu
----------------------------------------------------------------
local class = require(ritnlib.defines.class.core)
local modGui = require("mod-gui")
local libStyle = require(ritnlib.defines.class.gui.style)
local libGui = require(ritnlib.defines.class.luaClass.gui)
----------------------------------------------------------------
local RitnGuiSurfaces = require(ritnlib.defines.lobby.class.guiSurfaces)
----------------------------------------------------------------
local fGui = require(ritnlib.defines.lobby.gui.menu)
----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
local RitnGuiMenu = class.newclass(libGui, function(base, event)
    libGui.init(base, event, ritnlib.defines.lobby.name, "flow-menu")
    base.object_name = "RitnGuiMenu"
    --------------------------------------------------
    base.gui_name = "menu"
    base.gui_action = {
        [base.gui_name] = {
            [ritnlib.defines.lobby.gui_actions.menu.open] = true,
            [ritnlib.defines.lobby.gui_actions.menu.close] = true,
            [ritnlib.defines.lobby.gui_actions.menu.toggle] = true,
            [ritnlib.defines.lobby.gui_actions.menu.restart] = true,
            [ritnlib.defines.lobby.gui_actions.menu.exclure] = true,
            [ritnlib.defines.lobby.gui_actions.menu.clean] = true,
        }
    }    
    --------------------------------------------------
    local left = modGui.get_frame_flow(base.player)
    base.gui = { left["common-flow-main"]["common-flow-menu"] }
    --------------------------------------------------
    base.content = fGui.getContent()
    --------------------------------------------------
end)


-- create GUI
function RitnGuiMenu:create()
    if self.gui[1][self.gui_name.."-"..self.main_gui] then return self end

    local element = fGui.getElement(self.gui_name, self.name)

    -- assembly gui elements
    local content = {
        flow = {},
        frame = {},
        label = {},
        button = {},
    }

    -- flow menu
    content.flow.menu =         self.gui[1].add(element.flow.menu)
    -- frame menu
    content.frame.main =        content.flow.menu.add(element.frame.main)
    -- flow restart
    content.flow.restart =      content.frame.main.add(element.flow.restart)
    -- button restart
    content.button.restart =    content.flow.restart.add(element.button.restart)
    -- button exclure
    content.button.exclure =    content.flow.restart.add(element.button.exclure)
    -- flow admin
    content.flow.admin =        content.frame.main.add(element.flow.admin)
    -- line
    content.line =              content.flow.admin.add(element.line)
    -- label admin
    content.label.admin =       content.flow.admin.add(element.label.admin)
    -- button clean
    content.button.clean =      content.flow.admin.add(element.button.clean)
    
    
    libStyle(content.frame.main):frame():maxWidth(125)
    libStyle(content.flow.admin):align()
    libStyle(content.label.admin):label()

    -- active flow admin
    content.flow.admin.visible = self.admin

    -- get informations surface & player :
    local surfaces = remote.call("RitnCoreGame", "get_surfaces")
    local players = remote.call("RitnCoreGame", "get_players")
    local player = players[self.index]

    -- player on lobby | disable flow restart (active admin only)
    if surfaces[player.surface] == nil then 
        content.flow.restart.visible = false 
        return
    end
    local surface = surfaces[player.surface]

    -- get finish game (rocket launch + satellite)
    local finish = false
    if surface.finish then 
        if surface.name == player.name then 
            finish = true
        end
    end
    content.button.restart.visible = finish

    -- active button exclude
    local exclude = false
    if surface.name == player.name then 
        if #surface.subscribers > 0 then 
            exclude = true
        end
    end
    content.button.exclure.enabled = exclude

end







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


function RitnGuiMenu:action_restart()

    log('> '..self.object_name..':action_restart()')
    return self
end


function RitnGuiMenu:action_exclure()
    RitnGuiSurfaces(self.event):action_open("exclure")
    log('> '..self.object_name..':action_exclure()')
    return self
end


function RitnGuiMenu:action_clean()
    RitnGuiSurfaces(self.event):action_open("clean")
    log('> '..self.object_name..':action_clean()')
    return self
end


----------------------------------------------------------------
return RitnGuiMenu