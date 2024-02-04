local libGuiElement = require(ritnlib.defines.class.gui.element)
local captions = ritnlib.defines.lobby.names.caption.frame_restart



local function getElement(gui_name)
    return {
        flow = {
            main = libGuiElement(gui_name,"flow","main"):vertical():get(),
            dialog = libGuiElement(gui_name,"flow","dialog"):horizontal():get(),
        },
        frame = {
            restart = libGuiElement(gui_name,"frame","restart"):caption(captions.titre):get(),
        },
        button = {
            back = libGuiElement(gui_name,"button","back"):caption(captions.button_back):style("red_back_button"):get(),
            valid = libGuiElement(gui_name,"button","valid"):caption(captions.button_valid):style("confirm_button"):get(),
        },
        label = {
            warning1 = libGuiElement(gui_name,"label","warning1"):caption(captions.label_warning1):get(),
            warning2 = libGuiElement(gui_name,"label","warning2"):caption(captions.label_warning2):get(),
        },
        empty = libGuiElement(gui_name,"empty-widget","empty"):get(),
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