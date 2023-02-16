local keybindings = require('keybindings')
local awful = require('awful')

keybindings:map_global_key({ MODKEY }, 'Right', awful.tag.viewnext, { description = 'Moves to next tag', group = 'tag' })
keybindings:map_global_key({ MODKEY }, 'Left', awful.tag.viewprev, { description = 'Moves to previous tag', group = 'tag' })
