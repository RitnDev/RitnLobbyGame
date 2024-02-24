local modules = {}
------------------------------------------------------------------------------

-- Inclus les events onInit et onLoad + les ajouts de commandes
modules.globals =               require(ritnlib.defines.lobby.modules.globals)
modules.events =                require(ritnlib.defines.lobby.modules.events)
modules.commands =              require(ritnlib.defines.lobby.modules.commands)

---- Modules désactivable

-- modules gui :
if global.lobby.modules.lobby then
    modules.lobby =             require(ritnlib.defines.lobby.modules.lobby) 
end
if global.lobby.modules.inventory then
    modules.inventory =         require(ritnlib.defines.lobby.modules.inventory) 
end
if global.lobby.modules.restart then
    modules.restart =           require(ritnlib.defines.lobby.modules.restart) 
end
if global.lobby.modules.request then
    modules.request =           require(ritnlib.defines.lobby.modules.request) 
end
if global.lobby.modules.menu then
    modules.menu =              require(ritnlib.defines.lobby.modules.menu) 
end
------------------------------------------------------------------------------
return modules