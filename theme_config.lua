local beautiful = require('beautiful')
local gfs =  require('gears.filesystem')
local awful = require('awful')
local wibox = require('wibox')

local function set_theme(theme_name)
    beautiful.init(gfs.get_themes_dir() .. theme_name .. '/theme.lua')
end

THEME_NAME = 'default'

set_theme(THEME_NAME)


client.connect_signal("focus", function (client)
    client.border_color = beautiful.border_focus
    client.border_width = beautiful.border_width
end)

client.connect_signal('unfocus', function (client)
    client.border_color = beautiful.border_normal
    client.border_width = beautiful.border_width
end)
