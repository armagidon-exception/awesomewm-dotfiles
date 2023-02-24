local client_rules = require('ruled.client')

client_rules.connect_signal("request::rules", function ()
    require('rules.default')
    require('rules.default_dialog')
end)
