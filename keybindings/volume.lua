local mapper = require('keybindings')
local volume = require('widgets.volume')
local awful = require('awful')


mapper.map_global_key({}, "XF86AudioLowerVolume", volume.decrease_volume)
mapper.map_global_key({}, "XF86AudioRaiseVolume", volume.increase_volume)
mapper.map_global_key({}, "XF86AudioMute", volume.mute)
-- Media Keys
mapper.map_global_key({}, "XF86AudioPlay", function() awful.spawn.with_shell("playerctl play-pause") end)
mapper.map_global_key({}, "XF86AudioNext", function() awful.spawn.with_shell("playerctl next") end)
mapper.map_global_key({}, "XF86AudioPrev", function() awful.spawn.with_shell("playerctl previous") end)
