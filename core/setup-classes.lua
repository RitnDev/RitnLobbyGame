-- setup classes
--------------------------------------------------------------------------------
require(ritnlib.defines.menu.setup)
log('> imported : ' .. ritnlib.defines.menu.setup)
--------------------------------------------------------------------------------
require(ritnlib.defines.lobby.class.surface)                -- RitnLobbySurface
-- gui
require(ritnlib.defines.lobby.class.guiSurfaces)            -- RitnLobbyGuiSurface          extends: RitnLibGui
require(ritnlib.defines.lobby.class.guiRequest)             -- RitnLobbyGuiRequest          extends: RitnLibGui
require(ritnlib.defines.lobby.class.guiRestart)             -- RitnLobbyGuiRestart          extends: RitnLibGui
require(ritnlib.defines.lobby.class.guiMenu)                -- RitnLobbyGuiMenu             extends: RitnLibGui
require(ritnlib.defines.lobby.class.guiButtonMenu)          -- RitnLobbyGuiButtonMenu       extends: RitnGuiMenuButton
require(ritnlib.defines.lobby.class.guiLobby)               -- RitnLobbyGuiLobby            extends: RitnLibGui


