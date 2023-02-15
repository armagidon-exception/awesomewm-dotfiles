local awful = require('awful')
local table = require('gears.table')

awful.rules.rules = table.join(
    require('rules.default'),
    require('rules.default_dialog')
)
