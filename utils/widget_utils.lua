local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local gears = require('gears')

local M = {}

local function align(type)
    return function (align_method)
        local halign = 'center'
        local valign = 'center'
        if align_method == 'all' then
            halign = type
            valign = type
        elseif align_method == 'horizontal' then
            halign = type
            valign = 'center'
        elseif align_method == 'vertical' then
            valign = type
            halign = 'center'
        else
            return function (_)
                error('Wrong align_method')
            end
        end
        return function (widget)

            return wibox.widget {
                widget = wibox.container.place,
                fill_vertical = true,
                content_fill_vertical = true,
                halign = halign,
                valign = valign,
                widget,
            }
        end
    end
end

M.align_right_horizontally = align('right')('horizontal')
M.align_center_horizontally = align('center')('horizontal')
M.align_left_horizontally = align('left')('horizontal')
M.align_absolutely = align('center')('all')


function M.textbox_from_text(text)
    return wibox.widget.textbox(text)
end

function M.clock_from_text(text)
    return wibox.widget.textclock(text)
end

function M.concat_right(text)
    return function (input)
        return input .. text
    end
end

return setmetatable({}, {__index = M})
