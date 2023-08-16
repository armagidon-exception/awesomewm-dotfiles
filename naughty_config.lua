local naughty = require "naughty"
local ruled = require "ruled"
local awful = require "awful"
local beautiful = require "beautiful"
local wibox = require "wibox"
local helpers = require "utils.helpers"
local wheel = require "wheel"

ruled.notification.connect_signal("request::rules", function()
	ruled.notification.append_rule {
		rule = {},
		properties = {
			screen = awful.screen.preferred,
			implicit_timeout = 5,
		},
	}
end)

naughty.connect_signal("request::display", function(notif)
	local theme = beautiful.notifications
	local preset = helpers.link_to_default(theme[notif.urgency], theme.default)
	local general = preset.general

	local main_layout = wibox.widget {
		layout = wibox.layout.fixed.vertical,
		spacing = general.spacing,
	}

	local first_layer = wibox.layout.align.horizontal()
	local second_layer = wibox.layout.fixed.horizontal()
	local third_layer = wibox.layout.flex.horizontal()
	if notif.app_icon then
		first_layer.first = wheel.basic.image(notif.app_icon, preset.app_icon)
	end

	if notif.app_name and #notif.app_name > 0 then
		first_layer.middle = wheel.basic.textbox(notif.app_name, preset.app_name)
		second_layer:add(wheel.basic.textbox(notif.title, preset.title))
	else
		first_layer.middle = wheel.basic.textbox(notif.title, preset.app_name)
	end
	third_layer:add(wheel.basic.textbox(notif.message, preset.message))

	if notif.image then
		third_layer:add(wheel.basic.image(notif.image, preset.image))
	end

	main_layout:add(wheel.basic.box(first_layer, preset.header))
	main_layout:add(second_layer)
	main_layout:add(third_layer)

    if #notif.actions > 0 then
	main_layout:add(wheel.naughty.action_list.list(notif.actions, preset.action_list))
    end

	naughty.layout.box {
		notification = notif,
		border_width = general.box_border_width,
		border_color = general.box_border_color,
		position = general.position,
		bg = general.bg,
		shape = general.box_shape,
		maximum_width = general.max_width,
		widget_template = {
			main_layout,
			widget = wibox.container.background,
		},
	}
end)
