local gtables = require('gears.table')
local map_key = require('awful.key')
local awful = require('awful')
local M = {}


local global_keys = {}
local client_keys = {}
local mouse_keys = {}

function M.map_global_key(modkeys, key, action, opts)
    modkeys = modkeys or {}
    key = key or ''
    action = action or function () end
    opts = opts or {}
    table.insert(global_keys, map_key(modkeys, key, action, opts))
end

function M.map_client_key(modkeys, key, action, opts)
    modkeys = modkeys or {}
    key = key or ''
    action = action or function () end
    opts = opts or {}
    table.insert(client_keys, gtables.join(client_keys, map_key(modkeys, key, action, opts)))
end

function M.map_client_key_tbl(opts)
    table.insert(client_keys, map_key(opts))
end


function M.export_global_keys()
    awful.keyboard.append_global_keybindings(global_keys)
end

function M.export_client_keys()
    client.connect_signal('request::default_keybindings', function ()
        awful.keyboard.append_client_keybindings(client_keys)
    end)
end

return setmetatable({}, {
    __index = M,
    __newindex = function ()
        error('Go to fuck')
    end
})
