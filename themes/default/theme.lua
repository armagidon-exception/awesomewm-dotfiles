---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local gears = require('gears')

local theme = {}

-- Color palette
theme.default_bg = '#1D242A'
theme.low_background = '#343F49'
theme.default_font_color = '#BBCDE5'
theme.widget_icons = '#639FAB'
theme.middle_background = '#4191DC'
theme.highlight_font_color = '#FFFFFF'
theme.highlight_background = '#5CFFD9'

theme.font          = "Source Code Pro Medium 10"

theme.bg_normal     = theme.default_bg
theme.bg_focus      = theme.low_background

theme.fg_normal     = theme.default_font_color
theme.fg_focus      = theme.highlight_font_color

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(2)
theme.border_normal = theme.default_bg
theme.border_focus  = theme.highlight_background
theme.submenu_bg = "#00000000"
theme.widget_spacing = dpi(13)
theme.systray_icon_spacing = dpi(13)

-- Wibar
theme.wibar_bg = '#ffffff00'
theme.mount_bg = theme.default_bg
theme.bg_systray = theme.mount_bg

theme.wallpaper = themes_path .. "default/wallpaper.jpg"
theme.icon_theme = nil

function theme.format_icon(input)
    return '<span foreground="' .. theme.middle_background .. '" font_size="12.5pt" font="Terminus">' .. input .. '</span>'
end

theme.taglist_shape = gears.shape.circle


return theme
