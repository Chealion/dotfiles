-- vim: tabstop=2 shiftwidth=2 expandtab

local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action
local appearance = require 'appearance'

------------------
-- COLOUR SCHEME
------------------
if appearance.is_dark() then
  --config.color_scheme = 'Gruvbox dark, hard (base16)'
  config.color_scheme = 'GruvboxDarkHard'
	local tab_bg = '#fff'
else
  --config.color_scheme = 'Gruvbox light, hard (base16)'
  config.color_scheme = 'GruvboxLightHard'
	local tab_bg = '#fff'
end

---------
-- MISC
---------
config.audible_bell = 'Disabled'
--config.show_close_tab_button_in_tabs = false

--------------------
-- FONT AND WINDOW
--------------------
config.font = wezterm.font({ family='Monaspace Neon' })
config.font_size = 12

window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_frame = {
  active_titlebar_bg = tab_bg,
  font = wezterm.font({ family = 'Monaspace Neon', weight = 'Bold' }),
  font_size = 13,
}
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

------------------
-- TAB SETTINGS
------------------
config.use_fancy_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = true
-- Coming soon
-- config.tab_min_width=10
wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    --local direct = string.format(" %s  %s ~ %s  ", "❯", get_current_working_dir(tab))
    if tab.is_active then
			if appearance.is_dark() then
				return {
					{ Background = { Color = '#282828' } },
					{ Foreground = { Color = '#fabd2f' } },
					{ Text = ' ' .. title .. ' ' },
				}
			else
				return {
					{ Background = { Color = '#fbf1c7' } },
					{ Foreground = { Color = '#b57614' } },
					{ Text = ' ' .. title .. ' ' },
				}
			end
		else
			if appearance.is_dark() then
				return {
					{ Background = { Color = '#1d2021' } },
					{ Foreground = { Color = '#ebdbb2' } },
					{ Text = ' ' .. title .. ' ' },
				}
			else
				return {
					{ Background = { Color = '#f9f5d7' } },
					{ Foreground = { Color = '#3c3836' } },
					{ Text = ' ' .. title .. ' ' },
				}
			end
    end
    return title
  end
)

-----------------
-- KEY BINDINGS
-----------------

-- Defaults at https://wezfurlong.org/wezterm/config/default-keys.html

config.keys = {
  -- Manual config of tab title with Command - I
  -- NOTE: Does not update index because it's static
  {
    key = 'i',
    mods = 'CMD',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then

            -- Get Index
            local tab_index = 1
            for _, item in ipairs(window:mux_window():tabs_with_info()) do
              if item.is_active then
                tab_index = item.index+1
              end
            end
            window:active_tab():set_title(tab_index .. " - " .. line)
          end
        end
      ),
    }
  },

  {
    key = '.',
    mods = 'CMD',
    action = wezterm.action.ActivateCommandPalette,
  },

  -- Vertical split
  {
    -- |
    key = '|',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  -- Horizontal split
  -- Extra work to disable default font size changes
  { key = "+", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
  { key = "=", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
  { key = "-", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
  { key = "_", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
  {
    -- -
    key = '_',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    },
  },

  -- CTRL + (h,j,k,l) to move between panes
  {
    key = 'h',
    mods = 'CTRL',
    action = act({ EmitEvent = "move-left" }),
  },
  {
    key = 'j',
    mods = 'CTRL',
    action = act({ EmitEvent = "move-down" }),
  },
  {
    key = 'k',
    mods = 'CTRL',
    action = act({ EmitEvent = "move-up" }),
  },
  {
    key = 'l',
    mods = 'CTRL',
    action = act({ EmitEvent = "move-right" }),
  },
  -- ALT + (h,j,k,l) to resize panes
  {
    key = 'h',
    mods = 'ALT',
    action = act({ EmitEvent = "resize-left" }),
  },
  {
    key = 'j',
    mods = 'ALT',
    action = act({ EmitEvent = "resize-down" }),
  },
  {
    key = 'k',
    mods = 'ALT',
    action = act({ EmitEvent = "resize-up" }),
  },
  {
    key = 'l',
    mods = 'ALT',
    action = act({ EmitEvent = "resize-right" }),
  },

}

------------------
-- FUNCTIONS
------------------
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane in that tab
  return tab_info.tab_index+1 .. " - " .. tab_info.active_pane.title
end

function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	return current_dir == HOME_DIR and "." or string.gsub(current_dir, "(.*[/\\])(.*)", "%2")
end

return config
