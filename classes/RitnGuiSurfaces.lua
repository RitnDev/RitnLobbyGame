-- RitnGuiSurfaces
----------------------------------------------------------------
local class = require(ritnlib.defines.class.core)
local modGui = require("mod-gui")
local libStyle = require(ritnlib.defines.class.gui.style)
local libGui = require(ritnlib.defines.class.luaClass.gui)
----------------------------------------------------------------
local CorePlayer = require(ritnlib.defines.core.class.player)
local RitnSurface = require(ritnlib.defines.lobby.class.surface)
----------------------------------------------------------------
local fGui = require(ritnlib.defines.lobby.gui.surfaces)
----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
local RitnGuiSurfaces = class.newclass(libGui, function(base, event)
    libGui.init(base, event, ritnlib.defines.lobby.name, "frame-surfaces")
    base.object_name = "RitnGuiSurfaces"
    --------------------------------------------------
    base.gui_name = "surfaces"
    base.gui_action = {
        [base.gui_name] = {
            [ritnlib.defines.lobby.gui_actions.surfaces.open] = true,
            [ritnlib.defines.lobby.gui_actions.surfaces.close] = true,
            [ritnlib.defines.lobby.gui_actions.surfaces.valid] = true,
            [ritnlib.defines.lobby.gui_actions.surfaces.back] = true,
        }
    }
    --------------------------------------------------
    local left = modGui.get_frame_flow(base.player)
    base.gui = { left["common-flow-main"]["common-flow-menu"]["menu-flow-menu"] }
    --------------------------------------------------
    base.content = fGui.getContent()
    --------------------------------------------------
end)




-- create GUI
function RitnGuiSurfaces:create(action_surface)
    if self.gui[1][self.gui_name.."-"..self.main_gui] then return self end

    local element = fGui.getElement(self.gui_name)

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

    -- get caption
    if action_surface ~= "exclure" then
        content.frame.surfaces.caption = {"frame-surfaces.titre", "("..action_surface..")"}
    else 
        content.frame.surfaces.caption = {"frame-surfaces.titre-exclusion"}
    end
    content.label.info.caption = action_surface

    -- get informations surface & player :
    local players = remote.call("RitnCoreGame", "get_players")
    local player = players[self.index]
    local surfaces = remote.call("RitnCoreGame", "get_surfaces")

    if action_surface == "clean" then 
        for _,surface in pairs(surfaces) do 
            if surface.name ~= nil then
                if surface.name ~= self.name then
                    if game.players[surface.name] ~= nil then -- nauvis ou les lobby
                        if surface.map_used == false then
                            content.list.add_item(surface.name)
                        end
                    end
                end
            end
        end
    elseif action_surface == "tp" then 
        for _,surface in pairs(surfaces) do 
            if surface.name ~= nil then
                if surface.name ~= player.surface then
                    content.list.add_item(surface.name)
                end
            end
        end
    elseif action_surface == "exclure" then 
        local surface = surfaces[player.surface]

        for _,subscriber in pairs(surface.subscribers) do 
            content.list.add_item(subscriber)
        end
    end


end


----------------------------------------------------------------
-- ACTIONS --
----------------------------------------------------------------

function RitnGuiSurfaces:action_close()
    if self.gui[1] == nil then return self end
    if self.gui[1][self.gui_name.."-"..self.main_gui] == nil then return self end
    local frame_surfaces = self.gui[1][self.gui_name.."-"..self.main_gui]
    if frame_surfaces then frame_surfaces.destroy() end
    log('> '..self.object_name..':action_close()')
    return self
end


function RitnGuiSurfaces:action_open(action_surface)
    self:action_close()
    self:create(action_surface)
    log('> '..self.object_name..':action_open()')
    return self
end


function RitnGuiSurfaces:action_valid()
    local action_surfaces
    if self.element.parent[self.gui_name.."-label-info"] ~= nil then
        action_surfaces = self.element.parent[self.gui_name.."-label-info"].caption
    end
    
    local index = self:getElement("list").selected_index
    if index == nil or index == 0 then return self end
    local itemSelected = self:getElement("list").get_item(index)
    
    if action_surfaces == 'clean' then 
        self:clean(itemSelected)
    elseif action_surfaces == 'tp' then 
        self:teleport(itemSelected)
    elseif action_surfaces == 'exclure' then 
        self:exclude(itemSelected)
    end

    self:action_close()
    remote.call("RitnLobbyGame", "gui_action_menu", ritnlib.defines.lobby.gui_actions.menu.close, self.event)

    log('> '..self.object_name..':action_valid('..action_surfaces..')')
    return self
end



function RitnGuiSurfaces:exclude(player_name)
    RitnSurface(self.surface):exclude(player_name)
    ----
    return self
end



-- Action de téléportation sur une map dans la liste du menu
function RitnGuiSurfaces:teleport(surface_name)
    CorePlayer(self.player):teleport({0, 0}, surface_name, true)
    self:print(self.name .." (tp) : " .. self.surface.name .. " -> " .. surface_name)
    return self
end



-- Action de suppression d'une surface d'un autre joueur dans la liste du menu
function RitnGuiSurfaces:clean(surface_name)
    local rSurface = RitnSurface(game.surfaces[surface_name])
    if rSurface then 
        rSurface:clean()
    end
    ----
    self:print(self.name.." (clean) : "..surface_name)
    return self
end




----------------------------------------------------------------
return RitnGuiSurfaces
