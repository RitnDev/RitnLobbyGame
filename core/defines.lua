-----------------------------------------
--               DEFINES               --
-----------------------------------------
if not ritnlib then require("__RitnBaseGame__.core.defines") end
require("__RitnMenuButton__.core.defines")
-----------------------------------------
local name = "RitnLobbyGame"
local dir = "__".. name .."__"
local directory = dir .. "."
-----------------------------------------
local defines = {}

-- Mod ID.
defines.name = name
-- Path to the mod's directory.
defines.directory = dir

-- classes
defines.class = {
    surface = dir .. ".classes.RitnSurface",
    ----
    guiButtonMenu = dir .. ".classes.RitnGuiMenuButton",
    guiLobby = dir .. ".classes.RitnGuiLobby",
    guiCommon = dir .. ".classes.RitnGuiCommon",
    guiRestart = dir .. ".classes.RitnGuiRestart",
    guiRequest = dir .. ".classes.RitnGuiRequest",
    guiMenu = dir .. ".classes.RitnGuiMenu",
    guiSurfaces = dir .. ".classes.RitnGuiSurfaces",
    guiRestart = dir .. ".classes.RitnGuiRestart"
}


-- Modules
defines.modules = {
    core = dir .. ".core.modules",
    globals = dir .. ".modules.globals",
    events = dir .. ".modules.events",
    commands = dir .. ".modules.commands",
    ----
    restart = dir .. ".modules.restart",
    lobby = dir .. ".modules.lobby",
    common = dir .. ".modules.common",
    request = dir .. ".modules.request",
    menu = dir .. ".modules.menu",
    ----
}

-- Functions
defines.functions = dir .. ".core.functions"


-- graphics (gui)
local graphics = dir .. "/graphics/"
local gui = graphics .. "gui/"
defines.graphics = {
    gui = {
        main_menu = gui .. "button-main-menu.png",
        close = gui .. "close-white.png",
        rejectAll = gui .. "button-rejectAll.png",
    },
}

-- prototypes
local prototypes = dir .. ".prototypes."
defines.prototypes = {
    customInputs = prototypes .. "custom-inputs"
}


defines.gui_actions = {
    lobby = {
        open = "open",
        close = "close",
        create = "button-create",
        request = "button-request",
    },
    restart = {
        open = "open",
        close = "close",
        valid = "button-valid",
        back = "button-back",
    },
    request = {
        open = "open",
        close = "close",
        accept = "button-accept",
        reject = "button-reject",
        rejectAll = "button-reject_all",
    },
    ritn = {
        open = "open",
        close = "close",
        menu = "button-menu",
    },
    menu = {
        open = "open",
        close = "close",
        toggle = "toggle",
        restart = "button-restart",
        exclure = "button-exclure",
        tp = "button-tp",
        clean = "button-clean",
    },
    surfaces = {
        open = "open",
        close = "close",
        valid = "button-valid",
        back = "button-close",
    }
}




-- Gui
defines.gui = {}
defines.gui.styles = directory .. "prototypes.styles"
local dir_gui = directory .. "gui."
---------------------------
defines.gui.lobby = dir_gui .. "lobby"
defines.gui.common = dir_gui .. "common"
defines.gui.request = dir_gui .. "request"
defines.gui.menu = dir_gui .. "menu"
defines.gui.surfaces = dir_gui .. "surfaces"
defines.gui.restart = dir_gui .. "restart"
---------------------------

-- Prefix.
defines.name_prefix = "ritnmods-"
defines.prefix = {
    name = "ritnmods-",
    gui = "ritn-",
    enemy = "enemy~",
    lobby = "lobby~",
}

-- Name and value
defines.names = {}
defines.value = {}


defines.names.customInput = {
    toggle_main_menu = defines.name_prefix .. "toggle-main-menu",
}


-- settings
local settings_prefix = defines.name_prefix .. "lobby-"
defines.names.settings = {
    enable_main_button = settings_prefix .. "toggle-main-button",
    generate_seed = settings_prefix .. "generate-seed",
    restart = settings_prefix .. "restart",
    clean = settings_prefix .. "clean",
    surfaceMax = settings_prefix .. "surface-max",
    show_research = settings_prefix .. "show-research",
}

defines.value.settings = {
    enable_main_button = true,
    show_research = true,
    generate_seed = false,
    restart = false,
    clean = {
        default_value = 0,
        minimum_value = 0,
        maximum_value = 1500,
    },
    surfaceMax = {
        default_value = 1,
        minimum_value = 1,
        maximum_value = 30,
    },
}


defines.names.styles = {
    ritn_normal_sprite_button = "ritn_normal_sprite_button",
    ritn_red_sprite_button = "ritn_red_sprite_button",
}



-- GUI element captions.
defines.names.caption = {

    msg = {       
        not_link = {"msg.not-link"},
        no_surface = {"msg.no-surfaces"},
        no_select = {"msg.no-selected"},
        no_access = {"msg.no-access"},
        local_party = {"msg.local"},
        restart = {"msg.restart"},
        cursor = {"msg.cursor"},
        show_research = "msg.show-research",
    },

    frame_menu = {
        titre = {"frame-menu.titre"},
        button_restart = {"frame-menu.button-restart"},
        button_exclure = {"frame-menu.button-exclure"},
        label_admin = {"frame-menu.label-admin"},
        button_clean = {"frame-menu.button-clean"},
        button_tp = {"frame-menu.button-tp"},
    },

    frame_surfaces = {
        button_close = {"frame-surfaces.button-close"},
        button_valid = {"frame-surfaces.button-valid"},
    },

    frame_restart = {
        titre = {"frame-restart.titre"}, 
        label_warning1 = {"frame-restart.label-warning1"}, 
        label_warning2 = {"frame-restart.label-warning2"}, 
        button_back = {"frame-restart.button-back"}, 
        button_valid = {"frame-restart.button-valid"}, 
    },

    frame_lobby = {
        titre = {"frame-lobby.titre"},
        button_create = {"frame-lobby.button-create"},
        label_main_surfaces = {"frame-lobby.label-main-surfaces"},
        button_request = {"frame-lobby.button-valid"},
    },

    frame_request = {
        button_accept = {"frame-request.button-accept"},
        button_reject = {"frame-request.button-reject"},
        button_rejectAll = {"frame-request.button-reject_all"},
    }
}


----------------
ritnlib.defines.lobby = defines