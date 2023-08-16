local wibox = require "wibox"

local function set_size(size, widget)
	if size then
		local width = (type(size) == "number" and size) or (type(size) == "table" and size.width)

		local height = (type(size) == "number" and size) or (type(size) == "table" and size.height)

		widget.forced_width = width
		widget.forced_height = height
	end
end

return function(widget, args)
	args = args or {}
	local box_sizing = args.box_sizing or "content_box"
	local out = widget

	if box_sizing == "content_box" then
		set_size(args.size, out)
	end

	if args.padding then
		local left = (type(args.padding) == "number" and args.padding)
			or (type(args.padding) == "table" and args.padding.left)
			or 0
		local right = (type(args.padding) == "number" and args.padding)
			or (type(args.padding) == "table" and args.padding.right)
			or 0
		local top = (type(args.padding) == "number" and args.padding)
			or (type(args.padding) == "table" and args.padding.top)
			or 0
		local bottom = (type(args.padding) == "number" and args.padding)
			or (type(args.padding) == "table" and args.padding.bottom)
			or 0

		out = wibox.container.margin(out, left, right, top, bottom)
	end

	if args.bg or args.shape or args.border_color or args.border_width then
		out = wibox.container.background(out, args.bg, args.shape)
        out.border_color = args.border_color
        out.border_width = args.border_width
	end

	if box_sizing == "border_box" then
		set_size(args.size, out)
	end

	if args.max_width or args.max_height then
		out = wibox.container.constraint(out, "max", args.max_width, args.max_height)
	end

	if args.margin then
		local left = (type(args.margin) == "number" and args.margin)
			or (type(args.margin) == "table" and args.margin.left)
			or 0
		local right = (type(args.margin) == "number" and args.margin)
			or (type(args.margin) == "table" and args.margin.right)
			or 0
		local top = (type(args.margin) == "number" and args.margin)
			or (type(args.margin) == "table" and args.margin.top)
			or 0
		local bottom = (type(args.margin) == "number" and args.margin)
			or (type(args.margin) == "table" and args.margin.bottom)
			or 0

		out = wibox.container.margin(out, left, right, top, bottom)
	end

	return out
end
