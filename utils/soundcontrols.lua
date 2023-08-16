local lhelpers = require "lain.helpers"
local future = require "utils.future"
local timers = require "utils.timers"

local M = {
	_event_loop_started = false,
	_volume = 0,
	_muted = false,
	_handlers = {},
}

local function handle_update(data)
	for _, handler in ipairs(M._handlers) do
		handler(data)
	end
end

function M.get_volume()
	local command_future = future.new()
	lhelpers.async("pamixer --get-volume-human", function(output)
		if output == "muted" then
			command_future:complete { volume = 0, muted = true }
		else
			local r = string.match(output, "([%d]+)%%.*")
			local vol = tonumber(r)
			command_future:complete { volume = vol, muted = false }
		end
	end)
	return command_future
end

function M.set_volume(value)
	lhelpers.async("pamixer --set-volume " .. tonumber(value), function()
		M._volume = value
		handle_update { volume = value, muted = M._muted }
	end)
end

function M.incr_volume(value)
	lhelpers.async("pamixer -i " .. tonumber(value), function()
		M._volume = M._volume + value
		handle_update { volume = M._volume, muted = M._muted }
	end)
end

function M.decr_volume(value)
	lhelpers.async("pamixer -d " .. tonumber(value), function()
		M._volume = M._volume - value
		handle_update { volume = M._volume, muted = M._muted }
	end)
end

function M.toggle_mute()
	lhelpers.async("pamixer -t", function()
		M._muted = not M._muted
		handle_update { volume = M._volume, muted = M._muted }
	end)
end

function M.register_handler(handler)
	table.insert(M._handlers, handler)
end

function M.setup_evenloop(timeout)
	if not M._event_loop_started then
		timers.new_timer("soundcontrols", timeout, function()
			M.get_volume():then_apply(function(data)
				if data.volume ~= M._volume or data.muted ~= M._muted then
					M._volume = data.volume
					M._muted = data.muted
					handle_update(data)
				end
			end)
		end, true)
	end
end

return M
