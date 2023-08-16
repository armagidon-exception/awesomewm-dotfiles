---@class wheel.wibar
---@field packages wheel.wibar.packages
---@field volumebar wheel.wibar.volumebar
---@field textclock fun(table):any
---@field calendar fun(table):any
local M = require("utils.helpers").named_forwarding_module({}, "wheel.wibar")

return M
