local captions = ritnlib.defines.lobby.names.caption.frame_surfaces


local function getElement(gui_name)
    return {
        flow = {
            main = RitnLibGuiElement(gui_name,"flow","main"):vertical():get(),
            surfaces = RitnLibGuiElement(gui_name,"flow","surfaces"):vertical():get(),
            dialog = RitnLibGuiElement(gui_name,"flow","dialog"):horizontal():get(),
        },
        frame = {
            surfaces = RitnLibGuiElement(gui_name,"frame","surfaces"):vertical():get(),
        },
        button = {
            close = RitnLibGuiElement(gui_name,"button","close"):caption(captions.button_close):style("red_back_button"):get(),
            valid = RitnLibGuiElement(gui_name,"button","valid"):caption(captions.button_valid):style("confirm_button"):get(),
        },
        label = {
            info = RitnLibGuiElement(gui_name,"label","info"):visible(false):get(),
        },
        pane = RitnLibGuiElement(gui_name,"scroll-pane","pane"):get(),
        list = RitnLibGuiElement(gui_name,"list-box","surfaces"):get(),
    }
end


local function getContent()
    return {
        flow = {
            surfaces = {
                "frame-surfaces",
                "flow-surfaces"
            },
            dialog = {
                "frame-surfaces",
                "flow-surfaces",
                "flow-dialog"
            },
        },
        frame = {
            surfaces = {
                "frame-surfaces",
            },
        },
        button = {
            close = {
                "frame-surfaces",
                "flow-surfaces",
                "flow-dialog",
                "button-close"
            },
            valid = {
                "frame-surfaces",
                "flow-surfaces",
                "flow-dialog",
                "button-valid"
            },
        },
        label = {
            info = {
                "frame-surfaces",
                "flow-surfaces",
                "flow-dialog",
                "label-info"
            }
        },
        pane = {
            "frame-surfaces",
            "flow-surfaces",
            "pane-pane",
        },
        list = {
            "frame-surfaces",
            "flow-surfaces",
            "pane-pane",
            "listbox-surfaces"
        },
    }
end


-----------------------------------------
return {
    getElement = getElement,
    getContent = getContent,
}