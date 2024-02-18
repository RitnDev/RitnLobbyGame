local RitnInputCustom = require(ritnlib.defines.class.prototype.customInput)
------------------------------------------
-- TOUCHES DE RACCOURCIS CLAVIER DU MOD --
------------------------------------------


-- Ouverture/Fermeture du menu :
RitnInputCustom:extend(
    ritnlib.defines.lobby.names.customInput.toggle_main_menu,
    'CONTROL + ALT + M'
)
