local captions = ritnlib.defines.lobby.names.caption.frame_restart



local function getElement(gui_name)
    return {
        flow = {
            main = RitnLibGuiElement(gui_name,"flow","main"):vertical():get(),
            dialog = RitnLibGuiElement(gui_name,"flow","dialog"):horizontal():get(),
        },
        frame = {
            restart = RitnLibGuiElement(gui_name,"frame","restart"):caption(captions.titre):get(),
        },
        button = {
            back = RitnLibGuiElement(gui_name,"button","back"):caption(captions.button_back):style("red_back_button"):get(),
            valid = RitnLibGuiElement(gui_name,"button","valid"):caption(captions.button_valid):style("confirm_button"):get(),
        },
        label = {
            warning1 = RitnLibGuiElement(gui_name,"label","warning1"):caption(captions.label_warning1):get(),
            warning2 = RitnLibGuiElement(gui_name,"label","warning2"):caption(captions.label_warning2):get(),
        },
        empty = RitnLibGuiElement(gui_name,"empty-widget","empty"):get(),
    }
end


local function getContent()
    return {
        flow = {
            main = {
                "frame-restart",
                "flow-main",
            },
            dialog = {
                "frame-restart",
                "flow-main",
                "flow-dialog"
            },
        },
        frame = {
            restart = {
                "frame-restart",
            },
        },
        button = {
            back = {
                "frame-restart",
                "flow-main",
                "flow-dialog",
                "button-back"
            },
            valid = {
                "frame-restart",
                "flow-main",
                "flow-dialog",
                "button-valid"
            },
        },
        label = {
            warning1 = {
                "frame-restart",
                "flow-main",
                "label-warning1"
            },
            warning2 = {
                "frame-restart",
                "flow-main",
                "label-warning2"
            },
        },
        empty = {
            "frame-restart",
            "flow-main",
            "flow-dialog",
            "empty-empty"
        },
    }
end


-----------------------------------------
return {
    getElement = getElement,
    getContent = getContent,
}