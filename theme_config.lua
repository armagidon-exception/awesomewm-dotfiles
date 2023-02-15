local beautiful = require('beautiful')
local gfs =  require('gears.filesystem')
local awful = require('awful')
local wibox = require('wibox')

local function set_theme(theme_name)
    beautiful.init(gfs.get_themes_dir() .. theme_name .. '/theme.lua')
end

THEME_NAME = 'default'

set_theme(THEME_NAME)


screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            {
                image     = beautiful.wallpaper,
                upscale   = true,
                downscale = true,
                widget    = wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled  = false,
            widget = wibox.container.tile,
        }
    }
end)
