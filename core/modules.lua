local modules = {}
------------------------------------------------------------------------------

-- Inclus les events onInit et onLoad + les ajouts de commandes
modules.events =                require(ritnlib.defines.lobby.modules.events)
modules.interfaces =            require(ritnlib.defines.lobby.modules.interfaces)
modules.commands =              require(ritnlib.defines.lobby.modules.commands)

---- Modules désactivable

-- modules gui :
if global.lobby.modules.lobby then
    modules.lobby =             require(ritnlib.defines.lobby.modules.lobby) 
end
if global.lobby.modules.request then
    modules.request =           require(ritnlib.defines.lobby.modules.request) 
end
if global.lobby.modules.menu then
    modules.menu =              require(ritnlib.defines.lobby.modules.menu) 
end
------------------------------------------------------------------------------
return modules