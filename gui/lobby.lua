local libGuiElement = require(ritnlib.defines.class.gui.element)
local captions = ritnlib.defines.lobby.names.caption.frame_lobby
local font = ritnlib.defines.names.font

local function getElement(gui_name, player_name)
    
    -- nb surfaces
    local nb_maps = remote.call('RitnCoreGame', 'get_values', 'surfaces') - 1
    if nb_maps < 0 then nb_maps = 0 end
    
    -- surfaces max
    local options_lobby = remote.call('RitnCoreGame', 'get_option', 'lobby')
    local surfaces_max = options_lobby.surfaces_max


    return {
        flow = {
            common = libGuiElement(gui_name,"flow","common"):horizontal():get(),
            main = libGuiElement(gui_name,"flow","main"):vertical():get(),
            surfaces = libGuiElement(gui_name,"flow","surfaces"):vertical():get(),
            dialog = libGuiElement(gui_name,"flow","dialog"):horizontal():get(),
        },
        frame = {
            lobby = libGuiElement(gui_name,"frame","lobby"):vertical():caption(captions.titre):get(),
        },
        label = {
            welcome = libGuiElement(gui_name,"label","welcome"):caption({"frame-lobby.label-welcome", player_name}):get(),
            mainSurface = libGuiElement(gui_name,"label","main_surfaces"):caption(captions.label_main_surfaces):get(),
            nbSurfaces = libGuiElement(gui_name,"label","nb_surfaces"):caption({"frame-lobby.label-nb-surface", nb_maps, surfaces_max}):get(),
        },
        button = {
            create = libGuiElement(gui_name,"button","create"):caption(captions.button_create):get(),
            request = libGuiElement(gui_name,"button","request"):caption(captions.button_request):style("confirm_button"):tooltip({"tooltip.button-valid"}):get(),
        },
        line = {
            [1] = libGuiElement(gui_name,"line","line1"):horizontal():get(),
            [2] = libGuiElement(gui_name,"line","line2"):horizontal():get(),
        },
        pane = libGuiElement(gui_name,"scroll-pane","pane"):get(),
        list = libGuiElement(gui_name,"list-box","surfaces"):get(),
        empty = libGuiElement(gui_name,"empty-widget","empty"):get(),
    }
end


local function getContent()
    return {
        flow = {
            common = {"flow-common"},
            main = {
                "flow-common",
                "frame-lobby",
                "flow-main",
            },
            surfaces = {
                "flow-common",
                "frame-lobby",
                "flow-main",
                "flow-surfaces"
            },
            dialog = {
                "flow-common",
                "frame-lobby",
                "flow-main",
                "flow-dialog"
            }
        },
        frame = {
            lobby = {
                "flow-common",
                "frame-lobby",
            }
        },
        label = {
            welcome = {
                "flow-common",
                "frame-lobby",
                "flow-main",
                "label-welcome"
            },
            mainSurface = {
                "flow-common",
                "frame-lobby",
                "flow-main",
                "flow-surfaces",
                "label-main_surfaces"
            },
            nbSurfaces = {
                "flow-common",
                "frame-lobby",
                "flow-main",
                "flow-dialog",
                "label-nb_surfaces"
            }
        },
        button = {
            create = {
                "flow-common",
                "frame-lobby",
                "flow-main",
                "button-create"
            },
            request = {
                "flow-common",
                "frame-lobby",
                "flow-main",
                "flow-dialog",
                "button-request"
            },
        },
        line = {
            [1] = {
                "flow-common",
                "frame-lobby",
                "flow-main",
                "line-line1"
            },
            [2] = {
                "flow-common",
                "frame-lobby",
                "flow-main",
                "line-line2"
            }
        },
        pane = {
            "flow-common",
            "frame-lobby",
            "flow-main",
            "flow-surfaces",
            "pane-pane",
        },
        list = {
            "flow-common",
            "frame-lobby",
            "flow-main",
            "flow-surfaces",
            "pane-pane",
            "listbox-surfaces"
        },
        empty = {
            "flow-common",
            "frame-lobby",
            "flow-main",
            "flow-dialog",
            "empty-empty",
        }
    }
end

-----------------------------------------
return {
    getElement = getElement,
    getContent = getContent,
}
