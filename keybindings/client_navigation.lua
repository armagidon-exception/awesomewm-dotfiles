local keybindings = require('keybindings')
local awful = require('awful')

local function move_focus(dir)
    awful.client.focus.bydirection(dir)
    if client.focus then
        client.focus:raise()
    end
end

keybindings:map_global_key({ MODKEY }, 'l', function ()
    move_focus('left')
end, { description = "Focus on left client", group = 'client'})

keybindings:map_global_key({ MODKEY }, 'h', function ()
   move_focus('right')
end, { description = "Focus on right client", group = 'client'})

keybindings:map_global_key({ MODKEY }, 'k', function ()
    move_focus('up')
end, { description = "Focus on upper client", group = 'client'})

keybindings:map_global_key({ MODKEY }, 'j', function ()
    move_focus('down')
end, { description = "Focus on lower client", group = 'client'})

