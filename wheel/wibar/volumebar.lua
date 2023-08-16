local wibox = require "wibox"
local wheel = require "wheel"
local soundcontrols = require "utils.soundcontrols"

---@class wheel.wibar.volumebar
---@field private new fun(table):any
local class = {}

---@param style table
function class.new(style)
	style = style or {}

	local pb = wheel.basic.progressbar(style.bar)
	local icon = wheel.basic.image(style.icon.variants[1], style.icon)

	local widget = wibox.widget {
		layout = wibox.layout.fixed.horizontal,
		spacing = style.spacing,
		icon,
		pb,
	}

	local function update_icon(volumebar)
		if #style.icon.variants == 1 then
			return
		elseif #style.icon.variants == 4 then
			if volumebar.muted or volumebar.volume == 0 then
				icon.set_image(style.icon.variants[1])
			elseif volumebar.volume > 0 and volumebar.volume <= 33 then
				icon.set_image(style.icon.variants[2])
			elseif volumebar.volume > 33 and volumebar.volume <= 66 then
				icon.set_image(style.icon.variants[3])
			else
				icon.set_image(style.icon.variants[4])
			end
		end
	end

	soundcontrols.register_handler(function(data)
		update_icon(data)
		pb.set_value(data.volume)
	end)

	return wheel.basic.box(widget, style)
end

return setmetatable(class, {
	__call = function(self, style)
		return self.new(style)
	end,
})
