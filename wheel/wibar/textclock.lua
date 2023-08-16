local wibox = require "wibox"
local wheel = require "wheel"

---@param style table
return function(style)
	style = style or {}
	local fmt = style.fmt or function()
		return "%H:%M"
	end

	local text_clock = wibox.widget {
		widget = wibox.widget.textclock,
		format = fmt(),
	}

	return wheel.basic.box(text_clock, style)
end
