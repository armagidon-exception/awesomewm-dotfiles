local M = {}
local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local gs  = require('gears.shape')
local transformer = require('utils.transformer')



local place_widget = function (type)
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


local align_center = place_widget('center')
local align_left = place_widget('left')
local align_right = place_widget('right')

local mount = function(widget)
    return wibox.widget {
        widget = wibox.container.background,
        bg = beautiful.mount_bg,
        {
            layout = wibox.layout.fixed.horizontal,
            {
                {
                    widget,
                    layout = wibox.layout.fixed.horizontal,
                },
                left = 4,
                right = 4,
                widget = wibox.container.margin
            },
        },
        shape = function (cr, width, height)
            gs.rounded_bar(cr, width, height) 
        end
    }
end

local calendar = transformer.of(wibox.widget.textclock('%d.%m.%Y')):map(mount):map(align_right):get()
local clock = transformer.of(wibox.widget.textclock('<span foreground="#5c90bd" font_size="12.5pt" font="Terminus"></span> %H:%M')):map(mount):map(align_right):get()
local keyboardlayout = transformer.of(awful.widget.keyboardlayout()):map(mount):map(align_right):get()



M.left = {
    keyboardlayout,calendar,clock
}


return M
