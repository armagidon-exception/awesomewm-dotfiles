local awful = require "awful"
local M = {}

function M.setup_tags()
    screen.connect_signal("request::desktop_decoration", function(s)
        awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
    end)
end

return M
