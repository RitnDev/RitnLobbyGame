local libGuiElement = require(ritnlib.defines.class.gui.element)
local captions = ritnlib.defines.lobby.names.caption.frame_menu
local font = ritnlib.defines.names.font

local function getElement(gui_name)
    return {
        flow = {
            menu = libGuiElement(gui_name,"flow","menu"):horizontal():get(),
            restart = libGuiElement(gui_name,"flow","restart"):vertical():get(),
            admin = libGuiElement(gui_name,"flow","admin"):vertical():get(),
            clean = libGuiElement(gui_name,"flow","clean"):vertical():visible(false):get(),
            exclusion = libGuiElement(gui_name,"flow","exclusion"):vertical():visible(false):get(),
            surfaces_clean = libGuiElement(gui_name,"flow","surfaces_clean"):vertical():get(),
            surfaces_exclusion = libGuiElement(gui_name,"flow","surfaces_exclusion"):vertical():get(),
            dialog = libGuiElement(gui_name,"flow","dialog"):horizontal():get(),
        },
        frame = {
            main = libGuiElement(gui_name,"frame","main"):caption(captions.titre):get(),
            surfaces = libGuiElement(gui_name,"frame","surfaces"):visible(false):get(),
        },
        label = {
            admin = libGuiElement(gui_name,"label","admin"):caption(captions.label_admin):get(),
        },
        button = {
            restart = libGuiElement(gui_name,"button","restart"):caption(captions.button_restart):visible(false):get(),
            exclure = libGuiElement(gui_name,"button","exclure"):caption(captions.button_exclure):enabled(false):get(),
            clean = libGuiElement(gui_name,"button","clean"):caption(captions.button_clean):get(),
            close = libGuiElement(gui_name,"button","close"):caption(captions.button_close):style("red_back_button"):get(),
            valid = libGuiElement(gui_name,"button","valid"):caption(captions.button_valid):style("confirm_button"):get(),
        },
        pane = libGuiElement(gui_name,"scroll-pane","pane"):get(),
        list = libGuiElement(gui_name,"list-box","surfaces"):get(),
    }
end


local function getContent()
    return {
        flow = {
            menu = {"flow-menu"},
            restart = {
                "flow-menu",
                "frame-main",
                "flow-restart"
            },
            admin = {
                "flow-menu",
                "frame-main",
                "flow-admin"
            },
            clean = {
                "flow-menu",
                "frame-surfaces",
                "flow-clean"
            },
            exclusion = {
                "flow-menu",
                "frame-surfaces",
                "flow-exclusion"
            },
            surfaces_clean = {
                "flow-menu",
                "frame-surfaces",
                "flow-clean",
                "flow-surfaces_clean"
            },
            surfaces_exclusion = {
                "flow-menu",
                "frame-surfaces",
                "flow-exclusion",
                "flow-surfaces_exclusion"
            },
            dialog = {},
        },
        frame = {
            main = {
                "flow-menu",
                "frame-main",
            },
            surfaces = {
                "flow-menu",
                "frame-surfaces",
            },
        },
        label = {
            admin = {
                "flow-menu",
                "frame-main",
                "flow-admin",
                "label-admin"
            },
        },
        button = {
            restart = {
                "flow-menu",
                "frame-main",
                "flow-restart",
                "button-restart"
            },
            exclure = {
                "flow-menu",
                "frame-main",
                "flow-restart",
                "button-exclure"
            },
            clean = {
                "flow-menu",
                "frame-main",
                "flow-admin",
                "button-clean"
            },
            close = {},
            valid = {},
        },
        pane = {},
        list = {},
    }
end


-----------------------------------------
return {
    getElement = getElement,
    getContent = getContent,
}