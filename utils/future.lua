---@class utils.future
---@field private _completed boolean
---@field private _value any
---@field private _callback function
---@field private _next utils.future
local Future = {
}

function Future.new()
	return setmetatable({
		_completed = false,
		_value = nil,
		_next = nil,
	}, {
		__index = Future,
	})
end

function Future:is_completed()
	return self._completed
end

function Future:complete(value)
	if self:is_completed() then
		return
	end
	self._value = value
	self._completed = true
    if self._callback then
	self._callback(value)
    end
end

function Future:then_apply(f)
	local out = Future.new()
	self._callback = function(value)
		out:complete(f(value))
	end
	return out
end

return Future
