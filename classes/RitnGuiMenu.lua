-- RitnLobbyGuiMenu
----------------------------------------------------------------
local modGui = require("mod-gui")
----------------------------------------------------------------
local fGui = require(ritnlib.defines.lobby.gui.menu)
----------------------------------------------------------------
--- CLASSE DEFINES
----------------------------------------------------------------
RitnLobbyGuiMenu = ritnlib.classFactory.newclass(RitnLibGui, function(base, event)
    RitnLibGui.init(base, event, ritnlib.defines.lobby.name, "flow-menu")
    base.object_name = "RitnLobbyGuiMenu"
    --------------------------------------------------
    base.gui_name = "menu"
    base.gui_action = {
        [base.gui_name] = {
            [ritnlib.defines.lobby.gui_actions.menu.open] = true,
            [ritnlib.defines.lobby.gui_actions.menu.close] = true,
            [ritnlib.defines.lobby.gui_actions.menu.toggle] = true,
            [ritnlib.defines.lobby.gui_actions.menu.restart] = true,
            [ritnlib.defines.lobby.gui_actions.menu.exclure] = true,
            [ritnlib.defines.lobby.gui_actions.menu.tp] = true,
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
function RitnLobbyGuiMenu:create()
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
    -- button tp
    content.button.tp =         content.flow.admin.add(element.button.tp)
    -- button clean
    content.button.clean =      content.flow.admin.add(element.button.clean)
    
    
    RitnLibStyle(content.frame.main):frame():maxWidth(125)
    RitnLibStyle(content.flow.admin):align()
    RitnLibStyle(content.label.admin):label()

    -- active flow admin
    content.flow.admin.visible = self.admin

    -- get informations surface & player :
    local surfaces = remote.call("RitnCoreGame", "get_surfaces")
    local players = remote.call("RitnCoreGame", "get_players")
    local player = players[self.index]
    local surface = surfaces[player.surface]

    local restart = false
    -- player on lobby | disable flow restart (active admin only)
    if surface ~= nil then 
        -- player on nauvis
        if player.surface ~= "nauvis" then 
            -- player est sur sa surface à lui
            if player.name == player.surface then
                restart = true
                local options = remote.call("RitnCoreGame", "get_options")
                local force_restart = options.lobby.restart
                -- le parametre de mod qui active en permanence le bouton n'est pas coché
                if not force_restart then 
                    -- get finish game (rocket launch + satellite)
                    if not surface.finish then 
                        -- le joueur n'a pas fini le jeu
                        restart = false
                    end
                end
            end
        end
    else return
    end
    content.button.restart.visible = restart

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

-- Fermeture du menu
function RitnLobbyGuiMenu:action_close()
    local frame_menu = self.gui[1][self.gui_name.."-"..self.main_gui]
    if frame_menu then frame_menu.destroy() end
    log('> '..self.object_name..':action_close()')
    return self
end

-- Ouverture du menu
function RitnLobbyGuiMenu:action_open()
    self:action_close()

    self:create()
    log('> '..self.object_name..':action_open()')
    return self
end

-- inverser l'action sur le bouton menu (fermer le menu s'il est ouvert et inversement)
function RitnLobbyGuiMenu:action_toggle_menu()
    local frame_menu = self.gui[1][self.gui_name.."-"..self.main_gui]
    if frame_menu then 
        self:action_close()
    else 
        self:action_open() 
    end
    log('> '..self.object_name..':action_toggle_menu()')
    return self
end

-- Action d'appuie sur le bouton restart
function RitnLobbyGuiMenu:action_restart()
    RitnLobbyGuiRestart(self.event):action_open()
    log('> '..self.object_name..':action_restart()')
    return self
end

-- Ouverture du GUI RitnGuiSurface pour exclure un joueur de sa carte
function RitnLobbyGuiMenu:action_exclure()
    RitnLobbyGuiSurface(self.event):action_open("exclure")
    log('> '..self.object_name..':action_exclure()')
    return self
end

-- [ADMIN] Ouverture du GUI RitnGuiSurface pour supprimer la map d'un autre joueur
function RitnLobbyGuiMenu:action_clean()
    RitnLobbyGuiSurface(self.event):action_open("clean")
    log('> '..self.object_name..':action_clean()')
    return self
end

-- [ADMIN] Ouverture du GUI RitnGuiSurface pour ce téléporter sur la map d'un autre joueur
function RitnLobbyGuiMenu:action_tp()
    RitnLobbyGuiSurface(self.event):action_open("tp")
    log('> '..self.object_name..':action_tp()')
    return self
end


----------------------------------------------------------------
--return RitnLobbyGuiMenu