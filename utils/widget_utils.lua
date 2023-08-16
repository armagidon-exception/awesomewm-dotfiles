local wibox = require "wibox"

local M = {}

function M.concat_right(text)
	return function(input)
		return input .. text
	end
end

function M.merge_widgets(...)
	return wibox.layout.fixed.horizontal(...)
end

return M

