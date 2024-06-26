local captions = ritnlib.defines.lobby.names.caption.frame_menu


local function getElement(gui_name)
    return {
        flow = {
            menu = RitnLibGuiElement(gui_name,"flow","menu"):horizontal():get(),
            restart = RitnLibGuiElement(gui_name,"flow","restart"):vertical():get(),
            admin = RitnLibGuiElement(gui_name,"flow","admin"):vertical():get(),
        },
        frame = {
            main = RitnLibGuiElement(gui_name,"frame","main"):vertical():caption(captions.titre):get(),
        },
        label = {
            admin = RitnLibGuiElement(gui_name,"label","admin"):caption(captions.label_admin):get(),
        },
        button = {
            restart = RitnLibGuiElement(gui_name,"button","restart"):caption(captions.button_restart):style("red_button"):visible(false):get(),
            exclure = RitnLibGuiElement(gui_name,"button","exclure"):caption(captions.button_exclure):enabled(false):get(),
            clean = RitnLibGuiElement(gui_name,"button","clean"):caption(captions.button_clean):get(),
            tp = RitnLibGuiElement(gui_name,"button","tp"):caption(captions.button_tp):get(),
        },
        line = RitnLibGuiElement(gui_name,"line","line"):horizontal():get(),
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
        },
        frame = {
            main = {
                "flow-menu",
                "frame-main",
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
            tp = {
                "flow-menu",
                "frame-main",
                "flow-admin",
                "button-tp"
            },
        },
    }
end


-----------------------------------------
return {
    getElement = getElement,
    getContent = getContent,
}