-- Lib dependencies

local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local wutils = require "utils.widget_utils"
local stream = require "utils.stream"
local gears = require "gears"
local wheel = require "wheel"

-- Classes
local M = {}
local privates = {}

-- Exported widget lists
M.left_widgets = {}
M.center_widgets = {}
M.right_widgets = {}

-- PRIVATE METHODS
function privates.make_bar(s)
	local theme = beautiful.wibar_theme
	local bar = awful.wibar {
		screen = s,
		position = "top",
		type = "dock",
		ontop = true,
		bg = theme.bg,
		height = theme.height,
		shape = theme.shape,
		border_width = theme.border_width,
		border_color = theme.border_color,
	}

	local lefts = stream.of(M.left_widgets):map(privates.get_widgets(s)):map(privates.wrap):to_list()
	local centers = stream.of(M.center_widgets):map(privates.get_widgets(s)):map(privates.wrap):to_list()
	local rights = stream.of(M.right_widgets):map(privates.get_widgets(s)):map(privates.wrap):to_list()

	bar:setup {
		privates.sub_bar("left", lefts),
		privates.sub_bar("center", centers),
		privates.sub_bar("right", rights),
		layout = wibox.layout.flex.horizontal,
		spacing = 2,
		spacing_widget = {
			color = "#000",
			shape = gears.shape.rectangle,
			widget = wibox.widget.separator,
		},
	}
	return bar
end

function privates.wrap(widget)
	return wheel.basic.box(widget, beautiful.wibar_theme.wrapper)
end

function privates.sub_bar(alignment, widgets)
	local container = wibox.container.place(wutils.merge_widgets(table.unpack(widgets)))
	container.halign = alignment
	return container
end

function privates.get_widgets(s)
	return function(factory)
		if type(factory) == "function" then
			return factory(s)
		end
		return factory
	end
end

-- MAIN METHODS
function M.setup_bar()
	screen.connect_signal("request::desktop_decoration", function(s)
		s.topbar = privates.make_bar(s)
	end)
end

return M
