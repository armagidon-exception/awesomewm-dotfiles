local class = {}

function class.of(input)
    local monad = {
        object = input,
        map = function (self, mapper)
           return class.of(mapper(self.object))
        end,
        get = function (self)
            return self.object
        end,
        use = function (self, action)
            action(self.object)
            return class.of(self.object)
        end
    }
    return setmetatable({}, {
        __index = monad,
        __newindex = function ()
            error('Cannot change manad')
        end
    })
end


return setmetatable(class, {
    __newindex = function (_, key, value)
        error('Attempt to change utility class ' .. key .. ' ' .. value)
    end,
})
