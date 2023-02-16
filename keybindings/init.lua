local gtables = require('gears.table')
local map_key = require('awful.key')
local M = {}


M.global_keys = {}

function M:map_global_key(modkeys, key, action, opts)
    modkeys = modkeys or {}
    key = key or ''
    action = action or function () end
    opts = opts or {}
    self.global_keys = gtables.join(self.global_keys, map_key(modkeys, key, action, opts))
end



return M
