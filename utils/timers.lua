local timer = require "gears.timer"

local timer_table = {}

local M = {}

function M.new_timer(name, timeout, fun, immediately)
    name = name or ""
    timeout = tonumber(timeout)
    timeout = timeout or error "You need to specify timeout"
    fun = fun or error "You need to specify a callback"
    immediately = immediately or false
    if #name == 0 then
        return
    end
    if not timer_table[name] then
        timer_table[name] = timer { timeout = timeout }
        timer_table[name]:start()
    end
    timer_table[name]:connect_signal("timeout", fun)
    if immediately then
        timer_table[name]:emit_signal("timeout")
    end
    return timer_table[name]
end

return M
