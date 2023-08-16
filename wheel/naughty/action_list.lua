local wibox = require "wibox"
local wheel = require "wheel"
local stream = require "utils.stream"
local abutton = require "awful.button"

---@class wheel.naughty.action_list
local M = {}

function M.button(action, style)
	local layout = wibox.layout.align.horizontal()
	layout.fill_space = true
	layout.spacing = style.spacing or 0

	if action.icon then
		layout.first = wheel.basic.image(action.icon, style.icon)
	end
	if not action.icon_only then
		layout.middle = wheel.basic.textbox(action.name, style.name)
	end

	local out = wheel.basic.box(layout, style)

	out.buttons = { abutton({}, 1, function()
		action:invoke()
	end) }
	return out
end

function M.list(actions, style)
	local layout = wibox.layout.flex.horizontal()
	layout.spacing = style.spacing or 0

	stream
		.of(actions)
		:map(function(action)
			return M.button(action, style.button)
		end)
		:for_each(function(widget)
			layout:add(widget)
		end)

	return wheel.basic.box(layout, style)
end

return M
