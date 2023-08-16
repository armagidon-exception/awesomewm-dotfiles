local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local textbuilder = require "utils.text_builder"
local wheel = require "wheel"

local exports = {}

exports.clock = function()
	return wheel.wibar.textclock(beautiful.text_clock_theme)
end

exports.calendar = function()
	return wheel.wibar.calendar(beautiful.calendar_theme)
end

function exports.volume()
	local theme = beautiful.volume_bar_theme
	local volume_widget = wheel.wibar.volumebar(theme)
	return volume_widget
end

function exports.languagebox()
	local widget = wibox.widget {
		widget = wibox.container.background,
		font = beautiful.topbar_font,
		bg = beautiful.background_color_shadow,
		shape = beautiful.rounded_rect,
		{
			widget = wibox.container.margin,
			margins = beautiful.margins,
			awful.widget.keyboardlayout(),
		},
	}
	return widget
end

function exports.packages()
	local widget = wheel.wibar.packages {
		cmd = "checkupdates-aur",
		fmt_builder = function(count)
			local package_logo = textbuilder
				.new()
				:append("󰏔")
				:set_rise(1.5)
				:set_fg_color(beautiful.icon_color_3)
				:set_font_size(10)
				:build()
			local count_format = textbuilder
				.new()
				:append(count)
				:set_font_family(beautiful.topbar_font)
				:set_font_size(10)
				:set_font_weight("500")
				:build()
			return textbuilder.new():append(package_logo):space():append(count_format):build()
		end,
	}
	return widget
end

function exports.taglist(scr)
	return wheel.wibar.taglist.setup(scr)
end

return exports
