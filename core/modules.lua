local modules = {}
------------------------------------------------------------------------------

-- Inclus les events onInit et onLoad + les ajouts de commandes
modules.storage =               require(ritnlib.defines.lobby.modules.storage)
modules.events =                require(ritnlib.defines.lobby.modules.events)
modules.commands =              require(ritnlib.defines.lobby.modules.commands)

---- Modules désactivable

-- modules gui :
if storage.lobby.modules.lobby then
    modules.lobby =             require(ritnlib.defines.lobby.modules.lobby) 
end
if storage.lobby.modules.restart then
    modules.restart =           require(ritnlib.defines.lobby.modules.restart) 
end
if storage.lobby.modules.request then
    modules.request =           require(ritnlib.defines.lobby.modules.request) 
end
if storage.lobby.modules.menu then
    modules.menu =              require(ritnlib.defines.lobby.modules.menu) 
end
------------------------------------------------------------------------------
return modules