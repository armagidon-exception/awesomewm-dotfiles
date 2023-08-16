---@class wheel.basic
---@field box fun(any, table):any
---@field textbox fun(string, table):any
---@field image fun(string, table): any
---@field progressbar fun(table):any
local M = require("utils.helpers").named_forwarding_module({}, "wheel.basic")

return M
