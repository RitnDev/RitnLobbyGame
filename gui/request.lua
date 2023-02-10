local libGuiElement = require(ritnlib.defines.class.gui.element)
local captions = ritnlib.defines.lobby.names.caption.frame_request
local font = ritnlib.defines.names.font

local function getElement(gui_name, request_name)

    return {
        flow = {
            label = libGuiElement(gui_name,"flow","label"):vertical():get(),
            dialog = libGuiElement(gui_name,"flow","dialog_"..request_name):horizontal():get(),
        },
        frame = {
            main = libGuiElement(gui_name,"frame","main_"..request_name):caption({"frame-request.titre", request_name}):get(),
        },
        label = {
            explain = libGuiElement(gui_name,"label","explain"):caption({"frame-request.label-explication", request_name}):get(),
        },
        button = {
            reject = libGuiElement(gui_name,"button","reject"):caption(captions.button_reject):style("red_back_button"):get(),
            rejectAll = libGuiElement(gui_name,"button","reject_all"):caption(captions.button_rejectAll):style("dialog_button"):tooltip({"tooltip.button-reject_all"}):get(),
            accept = libGuiElement(gui_name,"button","accept"):caption(captions.button_accept):style("confirm_button"):get(),
        },
        empty = {
            [1] = libGuiElement(gui_name,"empty-widget","empty1"):get(),
            [2] = libGuiElement(gui_name,"empty-widget","empty2"):get(),
        },
    }
end


local function getContent(request_name)
    return {
        flow = {
            label = {
                "frame-request_" .. request_name,
                "flow-label"
            },
            dialog = {
                "frame-request_" .. request_name,
                "flow-label",
                "flow-dialog_" .. request_name
            }
        },
        frame = {
            main = {
                "frame-request_" .. request_name,
            }
        },
        label = {
            explain = {
                "frame-request_" .. request_name,
                "flow-label",
                "label-explain"
            },
        },
        button = {
            reject = {
                "frame-request_" .. request_name,
                "flow-label",
                "flow-dialog_" .. request_name,
                "button-reject"
            },
            rejectAll = {
                "frame-request_" .. request_name,
                "flow-label",
                "flow-dialog_" .. request_name,
                "button-reject_all"
            },
            accept = {
                "frame-request_" .. request_name,
                "flow-label",
                "flow-dialog_" .. request_name,
                "button-accept"
            },
        },
        empty = {
            [1] = {
                "frame-request_" .. request_name,
                "flow-label",
                "flow-dialog_" .. request_name,
                "empty-empty1"
            },
            [2] = {
                "frame-request_" .. request_name,
                "flow-label",
                "flow-dialog_" .. request_name,
                "empty-empty2"
            }
        },
    }
end

-----------------------------------------
return {
    getElement = getElement,
    getContent = getContent,
}
