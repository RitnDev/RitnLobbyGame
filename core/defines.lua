-----------------------------------------
--               DEFINES               --
-----------------------------------------
if not ritnlib then ritnlib = { defines={} } end
local name = "RitnLobbyGame"
local dir = "__".. name .."__"
local directory = dir .. "."


local defines = {}

-- Mod ID.
defines.name = name
-- Path to the mod's directory.
defines.directory = dir

-- classes
defines.class = {
    surface = dir .. ".classes.RitnSurface",
    ----
    guiLobby = dir .. ".classes.RitnGuiLobby",
    guiCommon = dir .. ".classes.RitnGuiCommon",
    guiRequest = dir .. ".classes.RitnGuiRequest",
}


-- Modules
defines.modules = {
    core = dir .. ".core.modules",
    events = dir .. ".modules.events",
    interfaces = dir .. ".modules.interfaces",
    commands = dir .. ".modules.commands",
    ----
    lobby = dir .. ".modules.lobby",
    common = dir .. ".modules.common",
    request = dir .. ".modules.request",
    ----
}


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

defines.gui_actions = {
    lobby = {
        open = "open",
        close = "close",
        create = "button-create",
        request = "button-request",
    },
    request = {
        open = "open",
        close = "close",
        accept = "button-accept",
        reject = "button-reject",
        rejectAll = "button-reject_all",
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

-- sprite
defines.names.sprite = {
    close = "sprite-close",
    link = "sprite-link",
    unlink = "sprite-unlink",
    portal = "sprite-portal",
    rejectAll = "sprite-close",
}


defines.names.styles = {

    open_button = "entity_open_button",
    button_main =  "style_button_main",

    ritn_normal_sprite_button = "ritn_normal_sprite_button",
    ritn_red_sprite_button = "ritn_red_sprite_button",
    ritn_main_sprite_button = "ritn_main_sprite_button",

}



-- GUI element captions.
defines.names.caption = {

    msg = {       
        not_link = {"msg.not-link"},
        no_surface = {"msg.no-surfaces"},
        no_select = {"msg.no-selected"},
        dest_not_find = {"msg.dest-not-find"},
        no_access = {"msg.no-access"},
        local_party = {"msg.local"},
        restart = {"msg.restart"},
        cursor = {"msg.cursor"},
        show_research = "msg.show-research",
    },

    frame_menu = {
        titre = {"frame-menu.titre"},
        button_restart = {"frame-menu.button-restart"},
        button_exclusion = {"frame-menu.button-exclusion"},
        label_admin = {"frame-menu.label-admin"},
        button_tp= {"frame-menu.button-tp"},
        button_clean = {"frame-menu.button-clean"},
    },

    frame_surfaces = {
        button_close = {"frame-surfaces.button-close"},
        button_valid = {"frame-surfaces.button-valid"},
    },

    frame_restart = {
        titre = {"frame-restart.titre"}, 
        label_warning1 = {"frame-restart.label-warning1"}, 
        label_warning2 = {"frame-restart.label-warning2"}, 
        button_cancel = {"frame-restart.button-cancel"}, 
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