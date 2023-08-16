---@class utils.stream
local stream = {}

---@class utils.stream.node
---@field private collection table
---@field private mapper utils.stream.mapper
---@field private new fun(table, function):utils.stream.node
local Node = {}

---@class utils.stream.mapper
---@field private _instance_mt table
---@operator add(utils.stream.mapper): utils.stream.mapper
---@operator call(any):utils.stream.mapper
---@field private new fun(function):utils.stream.mapper
local Mapper = {}

function Mapper.apply(_)
	error "Function is not implemented"
end

Mapper._instance_mt = {
	__index = Mapper,
	__add = function(self, another)
		return Mapper.new(function(value)
			return self.apply(another.apply(value))
		end)
	end,
	__call = function(self, value)
		return self.apply(value)
	end,
}

---creates new mapper
---@param f function
---@return utils.stream.mapper
function Mapper.new(f)
	return setmetatable({
		apply = f,
	}, Mapper._instance_mt)
end

setmetatable(Mapper, {
	__call = function(self, f)
		return self.new(f)
	end,
})

---creates new stream node
---@param collection table
---@param mapper utils.stream.mapper
function Node.new(collection, mapper)
	collection = collection or error "Source cannot be null"
	mapper = mapper or error "Mapper cannot be null"

	return setmetatable({ collection = collection, mapper = mapper }, {
		__index = Node,
	})
end

setmetatable(Node, {
	__call = function(self, collection, mapper)
		return self.new(collection, mapper)
	end,
})

---Maps all elements of the stream
---@param f function
---@return utils.stream.node
function Node:map(f)
	return Node(self.collection, Mapper(f) + self.mapper)
end

function Node:to_list()
	local list = {}
	for _, value in ipairs(self.collection) do
		table.insert(list, self.mapper(value))
	end
	return list
end

---@alias action fun(any):nil
---@param action action
function Node:for_each(action)
	for _, value in ipairs(self.collection) do
		action(self.mapper(value))
	end
end

---Creates new stream
---@param collection  table
---@return utils.stream.node
stream.of = function(collection)
	local i = require("utils.helpers").identity
	local m = Mapper(i)
	return Node(collection, m)
end

return stream
