local M = {}
local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local gs  = require('gears.shape')
local transformer = require('utils.transformer')
local wutils = require('utils.widget_utils')

local align_right = wutils.align_right_horizontally
local align_left = wutils.align_left_horizontally



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
        shape = gs.rounded_bar,
    }
end

local calendar = transformer.of(''):map(beautiful.format_icon):map(wutils.concat_right(' %d.%m.%Y')):map(wutils.clock_from_text):map(mount):map(align_right):get()
local clock = transformer.of(''):map(beautiful.format_icon):map(wutils.concat_right(' %H:%M')):map(wutils.clock_from_text):map(mount):map(align_right):get()
local keyboardlayout = transformer.of(awful.widget.keyboardlayout()):map(mount):map(align_right):get()
local systray = transformer.of(wibox.widget.systray()):use(function (widget)
    widget:set_screen(awful.screen.focused())
end):map(mount):map(align_right):get()

local logo = transformer.of(wibox.widget.textbox('<span font_size="32pt"></span>')):map(function (widget)
   return wibox.container.margin(widget, 6)
end):get()
local layoutbox = transformer.of(awful.widget.layoutbox()):map(mount):map(align_left):get()
local volume = transformer.of(require('widgets.volume').new()):map(mount):map(align_right):get()
local packages  = transformer.of(require('widgets.packages').new()):map(mount):map(align_right):get()


M.right = {
    packages, keyboardlayout, volume, systray, calendar, clock
}

M.left = {
    logo, layoutbox
}

return M
