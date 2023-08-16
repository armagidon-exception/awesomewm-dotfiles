local taglist = require "awful.widget.taglist"
local wheel = require "wheel"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"

local M = {}

function M.setup(screen)
	return taglist {
		screen = screen,
		filter = taglist.filter.all,
		layout = {
			layout = wibox.layout.fixed.horizontal,
			spacing = 2,
		},
		widget_template = {
			wheel.basic.textbox("1", {
				border_width = 1,
				border_color = "#fff",
				box_sizing = "border_box",
				shape = gears.shape.circle,
				size = 22,
			}),
			widget = wibox.container.background,
		},
	}
end

return M
