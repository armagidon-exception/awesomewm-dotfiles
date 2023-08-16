local helpers = {}

function helpers.link_to_default(source, default)
	source = source or {}
	return setmetatable(source, {
		__index = function(table, key)
			return rawget(table, key) or default[key]
		end,
	})
end

function helpers.get_or_require(table, key)
	return rawget(table, key) or require(tostring(table) .. "." .. key)
end

function helpers.named_forwarding_module(module, name)
	return setmetatable(module, {
		__index = helpers.get_or_require,
		__tostring = function(_)
			return name
		end,
	})
end

function helpers.identity(...)
	return ...
end

return helpers
