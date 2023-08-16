local wibox = require "wibox"
local wheel = require "wheel"

return function(style)
	style = style or {}
	style.squish = style.squish or {}

	local widget = wibox.widget {
		widget = wibox.widget.progressbar,
		max_value = style.max_value,
		shape = style.bar_shape,
		margins = {
			top = style.squish.top,
			bottom = style.squish.top,
		},
		color = style.bar_color,
		background_color = style.shadow_color,
	}

	return setmetatable({
		set_value = function(value)
			widget:set_value(value)
		end,
	}, { __index = wheel.basic.box(widget, style) })
end
