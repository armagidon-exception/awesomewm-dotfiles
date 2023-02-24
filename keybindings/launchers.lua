local awful = require('awful')
local mapper = require('keybindings')


mapper.map_global_key({MODKEY}, 'Return', function ()
    awful.spawn.with_shell(TERMNINAL)
end, { description = 'Launches new terminal', group = 'launchers' })

mapper.map_global_key({ MODKEY }, 'Q', function ()
    awful.spawn.with_shell(BROWSER)
end, {description = 'Launches browser', group = 'launchers'})

mapper.map_global_key({ MODKEY }, 'r', function ()
    awful.spawn.with_shell('rofi -show drun')
end)

mapper.map_global_key ({"Shift", "Control"}, "Print", function ()
    awful.spawn.with_shell("maim -s $XDG_PICTURES_DIR/$(date +%s).png")
end, {description = "Save screenshots", group = "launchers"})

mapper.map_global_key ({"Control"}, "Print", function ()
    awful.spawn.with_shell("maim -s | xclip -selection clipboard -t image/png")
end, {description = "Save screenshot in clipboard", group = "launchers"})
