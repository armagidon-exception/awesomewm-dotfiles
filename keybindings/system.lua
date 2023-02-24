local mapper = require('keybindings')
local awful = require('awful')

mapper.map_global_key({ MODKEY, 'Control' }, 'r', awesome.restart, {
    description = 'Restart window manager', group = 'system'
})

mapper.map_global_key({ MODKEY, 'Shift'}, 'q', awful.quit, {
    description = 'Quit window manager', group = 'system'
})
