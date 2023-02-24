local wibox = require('wibox')
local icon_theme = require('utils.icon_theme')
local timer = require('gears.timer')
local spawn = require('awful.spawn')

local module = {}
local cairo = require('lgi').cairo
local Rsvg = require('lgi').Rsvg

local icons = {
    muted = '16x16/actions/audio-volume-muted.svg',
    low = '16x16/actions/audio-volume-low.svg',
    medium = '16x16/actions/audio-volume-medium.svg',
    high = '16x16/actions/audio-volume-high.svg'
}
module.registered_widgets = { }


local volume_data = {
    state = true,
    volume = 100,
}

local function create_volume_icon(type)
    local icon_width = 16
    local icon_height = 16
    local img = cairo.ImageSurface(cairo.Format.ARGB32, icon_width, icon_height)
    local cr = cairo.Context(img)
    local handle = assert(Rsvg.Handle.new_from_file(icon_theme.get_gtk_icon_theme_path() .. icons[type]))
    local dim = handle:get_dimensions()
    local aspect = math.min(icon_width/dim.width, icon_height/dim.height)
    cr:scale(aspect, aspect)
    handle:render_cairo(cr)
    return img
end

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

local function parse_mixer_output(out)
    out = split(out, '%\n')
    out = out[6]
    out = split(out, '%s')
    local volume = out[5]:sub(2, out[5]:len() - 2)
    local state = out[6]:sub(2, out[6]:len() - 1)
    volume_data.volume = tonumber(volume)
    if state == 'on' then
        volume_data.state = true
    elseif state == 'off' then
        volume_data.state = false
        volume_data.volume = 0
    else
        error('Wrong state name ' .. out)
        return
    end
end


local function fetch_volume_data(complete)
    spawn.easy_async_with_shell('amixer sget Master', function (out)
        parse_mixer_output(out)
        complete()
    end)
end

local function decide_icon()
    local volume = volume_data.volume
    local state = volume_data.state
    local type = ''
    if not state or volume == 0 then
        type = 'muted'
    elseif volume > 0 and volume < 33 then
        type = 'low'
    elseif volume >= 33 and volume < 66 then
        type = 'medium'
    else
        type = 'high'
    end
    return create_volume_icon(type)
end

local update_widgets = function (widgets)
    for _, widget in pairs(widgets) do
        widget.label.text = volume_data.volume .. '%'
        widget.icon.image = decide_icon()
    end
end

function module.new()
    local imagebox = wibox.widget {
        widget = wibox.widget.imagebox,
        image = decide_icon(),
        resize = false,
    }
    local textbox = wibox.widget.textbox("")
    local widget = wibox.widget {
        widget = wibox.container.place,
        {
            layout = wibox.layout.fixed.horizontal,
            imagebox,
        },
        valign = 'center',
        halign = 'center'
    }
    local out = wibox.layout.fixed.horizontal(widget, textbox)
    out.spacing = 5
    local registered_widget = {
        holder = out,
        icon = imagebox,
        label = textbox,
    }
    table.insert(module.registered_widgets, registered_widget)
    fetch_volume_data(function ()
        update_widgets { registered_widget }
    end)
    return out
end

function module.increase_volume()
    spawn.easy_async_with_shell('amixer -D pulse sset Master 5%+', function (out)
        parse_mixer_output(out)
        update_widgets(module.registered_widgets)
    end)
end


function module.decrease_volume()
    spawn.easy_async_with_shell('amixer -D pulse sset Master 5%-', function (out)
        parse_mixer_output(out)
        update_widgets(module.registered_widgets)
    end)
end


function module.mute()
    spawn.easy_async_with_shell('amixer -D pulse set Master 1+ toggle', function (out)
        parse_mixer_output(out)
        update_widgets(module.registered_widgets)
    end)
end

timer {
    timeout = 5,
    autostart = true,
    callback = function()
        fetch_volume_data(function ()
            update_widgets(module.registered_widgets)
        end)
    end
}


return setmetatable({}, {
    __index = module,
    __newindex = function ()
        error('Go to fuck')
    end
})
