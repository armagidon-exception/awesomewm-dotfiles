pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local naughty = require("naughty")


require("awful.hotkeys_popup.keys")

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end


TERMNINAL = "alacritty"
EDITOR = os.getenv("EDITOR") or "vim"
EDITOR_CMD = TERMNINAL .. " -e " .. EDITOR
MODKEY = "Mod4"
BROWSER = 'firefox'

tag.connect_signal("request::default_layouts",  function ()
    awful.layout.append_default_layouts {
        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        awful.layout.suit.tile.bottom,
        awful.layout.suit.tile.top,
        awful.layout.suit.floating,
    }
end)

require('rules')
require('theme_config')

awful.screen.connect_for_each_screen(function (screen)
    require('desktop')(screen)
end)

local keybindings = require('keybindings')
keybindings.export_global_keys()
keybindings.export_client_keys()

local mousebindings = require('mousebindings')
mousebindings.export_global_mouse()
mousebindings.export_client_mouse()



gears.timer {
       timeout = 30,
       autostart = true,
       callback = function() collectgarbage() end
}

awful.spawn.with_shell('sh ' .. gears.filesystem.get_configuration_dir() .. 'autostart.sh')
