local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local wheel = require "wheel"

return function(style)
	local theme = beautiful.calendar_theme

	local calendar_month = wibox.widget {

		widget = wibox.widget.calendar.month,
		date = os.date "*t",
		font = theme.font,
		fn_embed = function(widget, type, _)
            widget.halign = "center"
			if type == "header" or type == "weekday" then
				return wheel.basic.box(widget, style.popup.header)
			elseif type == "focus" then
				return wheel.basic.box(widget, style.popup.focus)
			elseif type == "normal" then
				return wheel.basic.box(widget, style.popup.day)
			end
			return widget
		end,
	}

	local popup = awful.popup {
		widget = wheel.basic.box(calendar_month, style.popup),
		ontop = true,
		visible = false,
		hide_on_right_click = true,
	}

	local bar_calendar = wheel.wibar.textclock(style.bar)

	popup:bind_to_widget(bar_calendar)

	return bar_calendar
end
