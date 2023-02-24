local keybindings = require('keybindings')
local awful = require('awful')
local mousebindings = require'mousebindings'
local MOUSE_KEYS = mousebindings.KEYS

local function move_focus(dir)
    awful.client.focus.bydirection(dir)
    if client.focus then
        client.focus:raise()
    end
end

local function move_client(client, dir)
    local STEP = 10
    if client.floating then
        if dir == 'up' then
            client:relative_move(0, -STEP, 0, 0)
        elseif dir == 'down' then
            client:relative_move(0, STEP, 0, 0)
        elseif dir == 'left' then
            client:relative_move(-STEP, 0, 0, 0)
        elseif dir == 'right' then
            client:relative_move(STEP, 0, 0, 0)
        end
    else
        awful.client.swap.bydirection(dir, client)
    end
end

keybindings.map_global_key({ MODKEY }, 'l', function ()
    move_focus('right')
end, { description = "Focus on left client", group = 'client'})

keybindings.map_global_key({ MODKEY }, 'h', function ()
   move_focus('left')
end, { description = "Focus on right client", group = 'client'})

keybindings.map_global_key({ MODKEY }, 'k', function ()
    move_focus('up')
end, { description = "Focus on upper client", group = 'client'})

keybindings.map_global_key({ MODKEY }, 'j', function ()
    move_focus('down')
end, { description = "Focus on lower client", group = 'client'})

keybindings.map_client_key({MODKEY, "Shift"}, 'c',  function (c)
    c:kill()
end, {description = 'Close client', group = 'client'})

keybindings.map_client_key({MODKEY}, 'm', function (c)
    c.fullscreen = not c.fullscreen
    c:raise()
end, { description = 'Toggle fullscreen of the client', group = 'client'})

keybindings.map_client_key({MODKEY}, 'f', function (c)
    c.floating = not c.floating
    c:raise()
end, {description = 'Toggle floating of the client', group = 'client'})

keybindings.map_client_key({MODKEY}, 'n', function (c)
    c.minimized = true
end, {description = 'Toggle minimized state of the client', group = 'client'})

keybindings.map_client_key({MODKEY, "Shift"}, 'n', function (_)
    local c = awful.client.restore()
    if c then
        c:emit_signal( "request::activate", "key.unminimize", {raise = true})
    end
end, {description = 'Minimize client', group = 'client'})

keybindings.map_client_key_tbl {
    modifiers   = { MODKEY },
    keygroup    = "numrow",
    description = "only view tag",
    group       = "tag",
    on_press    = function (index)
        local screen = awful.screen.focused()
        local tag = screen.tags[index]
        if tag then
            tag:view_only()
        end
    end,
}
keybindings.map_client_key_tbl {
    modifiers   = { MODKEY, "Control" },
    keygroup    = "numrow",
    description = "toggle tag",
    group       = "tag",
    on_press    = function (index)
        local screen = awful.screen.focused()
        local tag = screen.tags[index]
        if tag then
            awful.tag.viewtoggle(tag)
        end
    end,
}
keybindings.map_client_key_tbl {
    modifiers = { MODKEY, "Shift" },
    keygroup    = "numrow",
    description = "move focused client to tag",
    group       = "tag",
    on_press    = function (index)
        if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end,
}
keybindings.map_client_key_tbl {
    modifiers   = { MODKEY, "Control", "Shift" },
    keygroup    = "numrow",
    description = "toggle focused client on tag",
    group       = "tag",
    on_press    = function (index)
        if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then
                client.focus:toggle_tag(tag)
            end
        end
    end,
}
keybindings.map_client_key_tbl {
    modifiers   = { MODKEY },
    keygroup    = "numpad",
    description = "select layout directly",
    group       = "layout",
    on_press    = function (index)
        local t = awful.screen.focused().selected_tag
        if t then
            t.layout = t.layouts[index] or t.layout
        end
    end,
}

keybindings.map_client_key({ MODKEY, "Shift" }, 'k', function (client)
    move_client(client, 'up')
end, {description = 'Move client up', group = 'client'})

keybindings.map_client_key({ MODKEY, "Shift" }, 'j', function (client)
    move_client(client, 'down')
end, {description = 'Move client down', group = 'client'})

keybindings.map_client_key({ MODKEY, "Shift" }, 'h', function (client)
    move_client(client, 'left')
end, {description = 'Move client left', group = 'client'})

keybindings.map_client_key({ MODKEY, "Shift" }, 'l', function (client)
    move_client(client, 'right')
end, {description = 'Move client right', group = 'client'})

mousebindings.client_mouse_key({ }, MOUSE_KEYS.LEFT, function (c)
    c:activate { context = "mouse_click" }
end)

mousebindings.client_mouse_key({ MODKEY }, MOUSE_KEYS.LEFT, function (c)
    c:activate { context = "mouse_click", action = "mouse_move"  }
end)

mousebindings.client_mouse_key({ MODKEY }, MOUSE_KEYS.RIGHT, function (c)
    c:activate { context = "mouse_click", action = "mouse_resize"}
end)
