-- RitnGuiLobby
----------------------------------------------------------------
local class = require(ritnlib.defines.class.core)
local libStyle = require(ritnlib.defines.class.gui.style)
local libGui = require(ritnlib.defines.class.luaClass.gui)
----------------------------------------------------------------
local RitnPlayer = require(ritnlib.defines.core.class.player)
local RitnSurface = require(ritnlib.defines.lobby.class.surface)
local RitnGuiMenuButton = require(ritnlib.defines.lobby.class.guiButtonMenu)
----------------------------------------------------------------
local font = ritnlib.defines.names.font
local fGui = require(ritnlib.defines.lobby.gui.lobby)
----------------------------------------------------------------




----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
local RitnGuiLobby = class.newclass(libGui, function(base, event)
    libGui.init(base, event, ritnlib.defines.lobby.name, "flow-common")
    base.object_name = "RitnGuiLobby"
    --------------------------------------------------
    base.gui_name = "lobby"
    base.gui_action = {
        [base.gui_name] = {
            [ritnlib.defines.lobby.gui_actions.lobby.open] = true,
            [ritnlib.defines.lobby.gui_actions.lobby.close] = true,
            [ritnlib.defines.lobby.gui_actions.lobby.create] = true,
            [ritnlib.defines.lobby.gui_actions.lobby.request] = true,
        }
    }    
    --------------------------------------------------
    base.gui = { base.player.gui.center }
    --------------------------------------------------
    base.content = fGui.getContent()
    --------------------------------------------------
    -- nb surfaces
    local nbMaps = remote.call('RitnCoreGame', 'get_values', 'surfaces') - 1
    if nbMaps < 0 then nbMaps = 0 end
    base.nb_maps = nbMaps
    -- surfaces_max
    local options = remote.call('RitnCoreGame', 'get_options')
    base.surfaces_max = options.lobby.surfaces_max
    --------------------------------------------------
end)

----------------------------------------------------------------


function RitnGuiLobby:create()
    if self.gui[1][self.gui_name.."-"..self.main_gui] then return self end

    local element = fGui.getElement(self.gui_name, self.name)

    -- assembly gui elements
    local content = {
        flow = {},
        frame = {},
        label = {},
        button = {},
        line = {},
    }

    
    -- flow commun (Menu/Surfaces)
    content.flow.common =       self.gui[1].add(element.flow.common)
    -- frame Menu
    content.frame.lobby =       content.flow.common.add(element.frame.lobby)
    -- Main Flow
    content.flow.main =         content.frame.lobby.add(element.flow.main)
    -- label welcome
    content.label.welcome =     content.flow.main.add(element.label.welcome)
    -- line 1
    content.line[1] =           content.flow.main.add(element.line[1])
    -- button creation de map
    content.button.create =     content.flow.main.add(element.button.create)
    -- line 2
    content.line[2] =           content.flow.main.add(element.line[2])
    -- flow surfaces
    content.flow.surfaces =     content.flow.main.add(element.flow.surfaces)
    -- label main surfaces
    content.label.mainSurface = content.flow.surfaces.add(element.label.mainSurface)
    -- pane
    content.pane =              content.flow.surfaces.add(element.pane)
    -- list surfaces
    content.list =              content.pane.add(element.list)
    -- flow dialog
    content.flow.dialog =       content.flow.main.add(element.flow.dialog)
    -- label : nb surfaces / surfaces max
    content.label.nbSurfaces =  content.flow.dialog.add(element.label.nbSurfaces)
    -- empty
    content.empty =             content.flow.dialog.add(element.empty)
    -- button request
    content.button.request =    content.flow.dialog.add(element.button.request)


    -- styles guiElement
    libStyle(content.frame.lobby):frame():maxHeight(450):maxWidth(260)
    libStyle(content.flow.main):align():stretchable()
    libStyle(content.label.welcome):label()
    libStyle(content.button.create):menuButton():font(font.bold18)
    libStyle(content.flow.surfaces):align("left")
    libStyle(content.label.mainSurface):label():font(font.bold14)
    libStyle(content.pane):scrollpane()
    libStyle(content.list):listbox()
    libStyle(content.flow.dialog):stretchable():topPadding(4):align("left")
    libStyle(content.label.nbSurfaces):label()
    libStyle(content.empty):size(30, 30)
    libStyle(content.button.request):maxWidth(120)


    local surfaces = remote.call('RitnCoreGame', 'get_surfaces')
    --> add maps on the list
    local nauvis = "nauvis"
    for _,surface in pairs(surfaces) do 
        if surface.name ~= nil then
            if nauvis ~= surface.name then
                content.list.add_item(surface.name)
            end
        end
    end

    return self
end

----------------------------------------------------------------





----------------------------------------------------------------
-- ACTIONS --
----------------------------------------------------------------

function RitnGuiLobby:action_close()
    local frame_lobby = self.gui[1][self.gui_name.."-"..self.main_gui]
    if frame_lobby then frame_lobby.destroy() end
    log('> '..self.object_name..':action_close()')
    return self
end

function RitnGuiLobby:action_open()
    self:action_close()
    self:create()
    log('> '..self.object_name..':action_open()')
    return self
end



function RitnGuiLobby:action_create()
    if self.nb_maps == self.surfaces_max then 
        self.player.print({"msg.server-full"})
        return self 
    end
    -- Creation de la surface joueur
    RitnPlayer(self.player):createSurface()
    RitnGuiMenuButton(self.event):action_open()

    log('> '..self.object_name..':action_create('.. self.player.name ..')')
    return self
end


function RitnGuiLobby:action_request()
    local index = self:getElement("list").selected_index
    if index == nil or index == 0 then return self end
    local surface = self:getElement("list").get_item(index)
    log('> '..self.object_name..':action_request() : '..self.name..' -> ' .. surface)
    
    RitnSurface(game.surfaces[surface]):createRequest(self.name)

    return self
end



----------------------------------------------------------------
return RitnGuiLobby