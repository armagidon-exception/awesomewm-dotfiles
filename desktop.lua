-- All widgets of desktop
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local menubar = require('menubar')
local gears = require('gears')
local desktop_widgets = require('desktop_widgets')



local place_widget =  function (type)
    return function (widget)
        return wibox.widget {
            widget = wibox.container.place,
            fill_vertical = true,
            content_fill_vertical = true,
            halign = type,
            widget,
        }
    end
end

local center_widget = place_widget('center')
local left_widget = place_widget('left')
local right_widget = place_widget('right')

local function setup_wibar(screen)
    local taglist = awful.widget.taglist {
        screen = screen,
        filter = awful.widget.taglist.filter.all,
    }

    local topbar = awful.wibar { position = 'top', screen = screen, shape = gears.shape.rounded_bar}
    topbar:setup {
        {
            widget = wibox.container.background,
            bg = beautiful.submenu_bg,
            {
                layout = wibox.layout.fixed.horizontal,
            }
        },
        center_widget(taglist),
        right_widget({
            widget = wibox.container.background,
            bg = beautiful.submenu_bg,
            gears.table.join({
                spacing = beautiful.widget_spacing,
                layout = wibox.layout.fixed.horizontal,
            }, desktop_widgets.left)
        }),
        expand = true,
        forced_num_cols = 3,
        homogeneous = true,
        forced_num_rows = 1,
        layout = wibox.layout.grid,
        opacity = 1,
    }
end


local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

local function setup_tags(screen)
    awful.tag({ "◯", "◯", "◯", "◯", "◯", "◯", "◯" }, screen, awful.layout.layouts[1])
end

return setmetatable({}, {
    __call = function (_, screen)
        set_wallpaper(screen)
        setup_tags(screen)
        setup_wibar(screen)
    end
})
