-------------------------------------------------------------------------------
                                -- FUNCTIONS
-------------------------------------------------------------------------------

-- return sprite for sprite button
local function sprite_button(name, file_name)
	return {
		type = "sprite",
		name = name,
		filename = file_name,
		width = 32,
		height = 32,
		flags = {"gui-icon"},
		mipmap_count = 1,
	}
end



-------------------------------------------------------------------------------

                                --------------
                                --  STYLES  --
                                --------------

-------------------------------------------------------------------------------

---
-- Style : BUTTON MAIN
---

local default_style = data.raw["gui-style"].default

default_style[ritnlib.defines.lobby.names.styles.ritn_normal_sprite_button] = {
	type = "button_style",
	parent = "button",
	padding = 0,
	size = {32,32},
}

default_style[ritnlib.defines.lobby.names.styles.ritn_red_sprite_button] = {
	type = "button_style",
	parent = "red_button",
	padding = 0,
	size = {32,32},
}

default_style[ritnlib.defines.lobby.names.styles.ritn_main_sprite_button] = {
	type = "button_style",
	parent = "button",
	padding = 0,
	size = {40,40},
}

-- SPRITES
data:extend({
	sprite_button(
		ritnlib.defines.lobby.names.sprite.close,
		ritnlib.defines.lobby.graphics.gui.close
	),
--[[ 	sprite_button(
		ritnlib.defines.lobby.names.sprite.link,
		ritnlib.defines.lobby.graphics.gui.link
	),
	sprite_button(
		ritnlib.defines.lobby.names.sprite.unlink,
		ritnlib.defines.lobby.graphics.gui.unlink
	),
	sprite_button(
		ritnlib.defines.lobby.names.sprite.portal,
		ritnlib.defines.lobby.graphics.gui.portal
	), ]]
	sprite_button(
		ritnlib.defines.lobby.names.sprite.rejectAll,
		ritnlib.defines.lobby.graphics.gui.rejectAll
	),

})