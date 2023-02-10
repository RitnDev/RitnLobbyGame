local libGuiElement = require(ritnlib.defines.class.gui.element)
-----------------------------------------

local element= {
    flow = {
        main = libGuiElement("common","flow","main"):vertical():get(),
        menu = libGuiElement("common","flow","menu"):horizontal():get(),
        request = libGuiElement("common","flow","request"):vertical():get(),
    }
}

local content = {
    flow = {
        main = {"flow-main"},
        menu = {
            "flow-main",
            "flow-menu"
        },
        request = {
            "flow-main",
            "flow-request"
        }
    }
}

local elements = {
    {
        parent = "start",
        name = "main",
        gui = element.flow.main
    },
    {
        parent = "main",
        name = "menu",
        gui = element.flow.menu
    },
    {
        parent = "main",
        name = "request",
        gui = element.flow.request
    }
}

-----------------------------------------
return {
    elements = elements,
    content = content,
}
