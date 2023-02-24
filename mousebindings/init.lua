local mouse = require('awful.mouse')
local button = require('awful').button

local M = {}

local global_mouse = {}
local client_mouse = {}

M.KEYS = {
    LEFT = 1,
    RIGHT = 3,
    UP = 4,
    CLICK = 2,
    DOWN = 5,
}

function M.global_mouse_key(opts, key, onpress)
    local btn = button(opts, key, onpress)
    table.insert(global_mouse, btn)
end

function M.export_global_mouse()
    mouse.append_global_mousebindings(global_mouse)
end

function M.client_mouse_key(opts, key, onpress)
    local btn = button(opts, key, onpress)
    table.insert(client_mouse, btn)
end

function M.export_client_mouse()
    client.connect_signal('request::default_mousebindings', function ()
        mouse.append_client_mousebindings(client_mouse)
    end)
end

return M
