-- vim: tabstop=2 shiftwidth=2 expandtab

local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local appearance = require 'appearance'

-- Set Colour Scheme
--
-- Other colour schemes - Solarized Dark (Patched)
--
if appearance.is_dark() then
  wezterm.log_info("Dark")
  config.color_scheme = 'Gruvbox dark, soft (base16)'
	local tab_bg = '#fff'
else
  wezterm.log_info("Light")
  config.color_scheme = 'Gruvbox light, soft (base16)'
	local tab_bg = '#fff'
end

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

-- Coming soon
-- config.tab_min_width=10

function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.tab_index+1 .. " - " .. tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
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

config.audible_bell = 'Disabled'

return config
