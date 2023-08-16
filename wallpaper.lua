local beautiful = require "beautiful"
local awful = require "awful"
local wibox = require "wibox"

local function set_wallpaper(s)
    awful.wallpaper {
        screen = s,
        widget = {
            horizontal_fit_policy = "fit",
            vertical_fit_policy = "fit",
            image = beautiful.wallpaper,
            widget = wibox.widget.imagebox,
        },
    }
end
local M = {}

M.setup_wallpaper = function()
    screen.connect_signal("request::wallpaper", function(s)
        set_wallpaper(s)
    end)
end

return M
