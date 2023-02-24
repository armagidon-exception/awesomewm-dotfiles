-- All widgets of desktop
local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local gears = require('gears')
local desktop_widgets = require('desktop_widgets')
local wutils = require('utils.widget_utils')


local center = wutils.align_center_horizontally
local left = wutils.align_left_horizontally
local right = wutils.align_right_horizontally

local function sub_bar(widgets)
    return wibox.widget {
        widget = wibox.container.background,
        bg = beautiful.submenu_bg,
        gears.table.join({
            spacing = beautiful.widget_spacing,
            layout = wibox.layout.fixed.horizontal,
        }, widgets)
    }
end


local function setup_wibar(screen)
    local taglist = require('widgets.tasklist')(screen)

    local topbar = awful.wibar { position = 'top', screen = screen, shape = gears.shape.rounded_bar, ontop = true }
    topbar : setup {
        left(sub_bar(desktop_widgets.left)),
        center(taglist),
        right(sub_bar(desktop_widgets.right)),
        expand = true,
        forced_num_cols = 3,
        homogeneous = true,
        forced_num_rows = 1,
        layout = wibox.layout.grid,
    }
end



local function setup_tags(screen)
    awful.tag({ "◯", "◯", "◯", "◯", "◯", "◯", "◯" }, screen, awful.layout.layouts[1])
end


-- Setup general keys
do
    require'keybindings.client_navigation'
    require'keybindings.tag_navigation'
    require'keybindings.launchers'
    require'keybindings.volume'
end



local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end


return setmetatable({}, {
    __call = function (_, screen)
        set_wallpaper(screen)
        setup_tags(screen)
        setup_wibar(screen)
    end
})
