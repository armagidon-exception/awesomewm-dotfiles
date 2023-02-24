local gfs = require('gears.filesystem')
local io = require('io')
local module = {}

local function split (inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function module.list_dir(dir_path)
    if not gfs.is_dir(dir_path) then
        error('Directory is not a path')
        return {}
    end
    if not gfs.dir_readable(dir_path) then
        error('Directory is not accessible')
        return {}
    end
    local ls_cmd = ('ls -lA %s | grep "^d" | awk \'{print $9}\''):format(dir_path)

    local output = io.popen(ls_cmd, "r"):read('a')
    return split(output, '\n')
end



return setmetatable({}, {
    __index = module,
    __newindex = function ()
        error('Go to fuck')
    end
})
