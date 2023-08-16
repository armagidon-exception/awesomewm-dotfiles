local wibox = require "wibox"
local identity = require("utils.helpers").identity
local wheel = require "wheel"

return function(text, args)
	args = args or {}
	local fmt = args.fmt or identity
    local align = args.align or "center"
	local textbox = wibox.widget {
		widget = wibox.widget.textbox,
		markup = fmt(text),
        halign = align
	}
	return wheel.basic.box(textbox, args)
end
