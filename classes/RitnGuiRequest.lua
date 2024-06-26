-- RitnLobbyGuiRequest
----------------------------------------------------------------
local modGui = require("mod-gui")
----------------------------------------------------------------
local font = ritnlib.defines.names.font
local fGui = require(ritnlib.defines.lobby.gui.request)
----------------------------------------------------------------




----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
RitnLobbyGuiRequest = ritnlib.classFactory.newclass(RitnLibGui, function(base, event, request_name)
    RitnLibGui.init(base, event, ritnlib.defines.lobby.name, "frame-main_"..request_name)
    base.object_name = "RitnLobbyGuiRequest"
    --------------------------------------------------
    base.gui_name = "request"
    base.gui_action = {
        [base.gui_name] = {
            [ritnlib.defines.lobby.gui_actions.request.open] = true,
            [ritnlib.defines.lobby.gui_actions.request.close] = true,
            [ritnlib.defines.lobby.gui_actions.request.accept] = true,
            [ritnlib.defines.lobby.gui_actions.request.reject] = true,
            [ritnlib.defines.lobby.gui_actions.request.rejectAll] = true,
        }
    }    
    --------------------------------------------------
    local left = modGui.get_frame_flow(base.player)
    base.gui = { left["common-flow-main"]["common-flow-request"] }
    --------------------------------------------------
    base.request_name = request_name
    base.content = fGui.getContent(base.request_name)
    --------------------------------------------------
end)

----------------------------------------------------------------

function RitnLobbyGuiRequest:setRequestName(request_name)
    if type(request_name) ~= "string" then return self end

    self.request_name = request_name
    self.content = fGui.getContent(self.request_name)

    return self
end





function RitnLobbyGuiRequest:create()
    if self.gui[1][self.gui_name.."-"..self.main_gui] then return self end

    local element = fGui.getElement(self.gui_name, self.request_name)

    -- assembly gui elements
    local content = {
        flow = {},
        frame = {},
        label = {},
        button = {},
        empty = {},
    }

    
    -- frame request - request_name
    content.frame.main =        self.gui[1].add(element.frame.main)
    -- flow label
    content.flow.label =        content.frame.main.add(element.flow.label)
    -- label explain
    content.label.explain =     content.flow.label.add(element.label.explain)
    -- flow dialog
    content.flow.dialog =       content.flow.label.add(element.flow.dialog)
    -- button reject 
    content.button.reject =     content.flow.dialog.add(element.button.reject)
    -- empty 2px ecart
    content.empty[1] =          content.flow.dialog.add(element.empty[1])
    -- button reject all
    content.button.rejectAll =  content.flow.dialog.add(element.button.rejectAll)
    -- empty : espacement pour mettre le bouton "accept" à droite.
    content.empty[2] =          content.flow.dialog.add(element.empty[2])
    -- button accept
    content.button.accept =     content.flow.dialog.add(element.button.accept)


    -- styles guiElement
    RitnLibStyle(content.flow.label):align()
    RitnLibStyle(content.flow.dialog):stretchable():topPadding(4)
    RitnLibStyle(content.button.reject):smallButton()
    RitnLibStyle(content.empty[1]):width(2)
    RitnLibStyle(content.button.rejectAll):size(90, 30):font(font.default12)
    RitnLibStyle(content.empty[2]):width(95)
    RitnLibStyle(content.button.accept):smallButton()

    return self
end

----------------------------------------------------------------


function RitnLobbyGuiRequest:on_gui_click_request()
    log('> '..self.object_name..':on_gui_click_request('..self.request_name..')')
    self:on_gui_click(self.request_name)
end


----------------------------------------------------------------
-- ACTIONS --
----------------------------------------------------------------

function RitnLobbyGuiRequest:action_close()
    local frame_request = self.gui[1][self.gui_name.."-"..self.main_gui]
    if frame_request then frame_request.destroy() end
    log('> '..self.object_name..':action_close()')
    return self
end

function RitnLobbyGuiRequest:action_open()
    self:action_close()
    self:create()
    log('> '..self.object_name..':action_open()')
    return self
end


-- Bouton accept
function RitnLobbyGuiRequest:action_accept()
    log('> '..self.object_name..':action_accept()')
    RitnLobbySurface(game.surfaces[self.name]):acceptRequest(self.request_name)
    self:action_close()
    return self
end


-- Bouton reject
function RitnLobbyGuiRequest:button_reject()
    log('> '..self.object_name..':button_reject()')
    RitnLobbySurface(game.surfaces[self.name]):rejectRequest(self.request_name)
    self:action_close()
    return self
end

-- Bouton rejeter toute nouvelle demande
function RitnLobbyGuiRequest:action_rejectAll()
    log('> '..self.object_name..':action_rejectAll()')
    RitnLobbySurface(game.surfaces[self.name]):rejectAllRequest(self.request_name)
    self:action_close()
    return self
end


----------------------------------------------------------------
--return RitnLobbyGuiRequest