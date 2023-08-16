local awful = require "awful"

---@class wheel.wibar.packages

---@param args table
local function new(_, args)
	args = args or {}
	local interval = args.interval or 15
	local cmd = args.cmd or "checkupdates"
	local fmt_builder = args.fmt_builder or function(packages)
		return packages
	end
	local widget, timer = awful.widget.watch(cmd, interval, function(widget, stdout)
		local out = 0
		for _ in stdout:gmatch "[^\r\n]+" do
			out = out + 1
		end
		local count = tostring(out)
		widget:set_markup(fmt_builder(count))
	end)
	timer:emit_signal "timeout"
	return widget
end

return setmetatable({}, {
	__call = new,
})
