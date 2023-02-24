local beautiful = require('beautiful')
local client_rules = require('ruled.client')
local awful = require('awful')

client_rules.append_rule({
    id = 'global',
    rule = { },
    properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
})

