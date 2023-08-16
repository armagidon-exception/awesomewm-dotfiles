local helpers = require "utils.helpers"

---@class wheel
---@field basic wheel.basic
---@field wibar table
---@field naughty wheel.naughty
local M = helpers.named_forwarding_module({}, "wheel")

return M
