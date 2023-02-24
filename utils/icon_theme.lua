local awful =  require('awful')
local io = require('io')
local module = {}


function module.get_gtk_icon_theme()
    local command = "gtk-query-settings | grep \"gtk-icon-theme-name\" | xargs | awk '{print $2}'"
    local out = io.popen(command, 'r'):read('a')
    out = out:gsub('\n', '')
    return out

end

function module.get_gtk_icon_theme_path()
    local theme = module.get_gtk_icon_theme()
    local global_storage = '/usr/share/icons/'
    return global_storage .. theme .. '/'
end

return setmetatable({}, {
    __index = module,
    __newindex = function ()
       error('Go to fuck') 
    end
})
