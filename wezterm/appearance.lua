-- vim: tabstop=2 shiftwidth=2 expandtab

-- https://gist.github.com/alexpls/83d7af23426c8928402d6d79e72f9401

-- We almost always start by importing the wezterm module
local wezterm = require 'wezterm'
-- Define a lua table to hold _our_ module's functions
local module = {}

-- Returns a bool based on whether the host operating system's
-- appearance is light or dark.
function module.is_dark()
  -- wezterm.gui is not always available, depending on what
  -- environment wezterm is operating in. Just return true
  -- if it's not defined.
  if wezterm.gui then
    -- Some systems report appearance like "Dark High Contrast"
    -- so let's just look for the string "Dark" and if we find
    -- it assume appearance is dark.

    -- DISABLING DARK TOGGLE
    --return wezterm.gui.get_appearance():find("Dark")
    return true
  end
  return true
end

return module
