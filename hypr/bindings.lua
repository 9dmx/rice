-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- ==== Easy hotkeys ====
-- SUPER+E        open terminal
-- SUPER+Q        close window
-- SUPER+SHIFT+Q  minimize (hide) window
-- SUPER+SHIFT+E  bring minimized windows back
-- SUPER+TAB      (default) cycle workspaces to pick a page
-- ALT+TAB        (default) cycle windows

-- Open terminal on SUPER+E (new key, was unbound)
o.bind("SUPER + E", "Terminal", { omarchy = "terminal" })

-- Close focused window on SUPER+Q (default SUPER+W still works too)
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

-- Minimize focused window into the scratchpad on SUPER+SHIFT+Q
o.bind("SUPER + SHIFT + Q", "Minimize window (scratchpad)", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

-- SUPER+SHIFT+E was: Email. Unbind, then use it to restore minimized windows.
hl.unbind("SUPER + SHIFT + E")
o.bind("SUPER + SHIFT + E", "Restore minimized windows (scratchpad)", hl.dsp.workspace.toggle_special("scratchpad"))
