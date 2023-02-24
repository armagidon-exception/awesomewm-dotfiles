local awful = require('awful')

local M = {}


function M.new()
    local widget, timer = awful.widget.watch('checkupdates+aur', 15, function (widget, stdout)
        local out  =  0
        for _ in stdout:gmatch('[^\r\n]+') do
            out = out + 1
        end
        widget:set_text(tostring(out))
    end)
    timer:emit_signal('timeout')
    return widget
end

return setmetatable({}, {
    __index = M
})
