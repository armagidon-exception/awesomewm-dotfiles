local wibox = require "wibox"
local wheel = require "wheel"

return function(image, args)
	args = args or {}
	local img = wibox.widget {
		widget = wibox.widget.imagebox,
		image = image,
	}
	return setmetatable({
		set_image = function(new_image)
			img.image = new_image
		end,
	}, { __index = wheel.basic.box(img, args) })
end
