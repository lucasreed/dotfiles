local wezterm = require 'wezterm'
local config = {}

function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Dracula (Official)'
  else
    return 'Solarized Light (Gogh)'
  end
end

return {
  color_scheme = scheme_for_appearance(get_appearance()),
  font_size = 13.0,
  initial_rows = 30,
  initial_cols = 90,
}

