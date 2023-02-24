local beautiful = require('beautiful')
local client_rules = require('ruled.client')
local awful = require('awful')


client_rules.append_rule( {
    rule_any = {
        type = 'dialog'
    },
    properties = {
        floating = true,
        placement = awful.placement.centered
    }
})
