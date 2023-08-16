pcall(require, "luarocks.loader")

local gears = require "gears"
local awful = require "awful"
require "awful.autofocus"
local wibox = require "wibox"
local beautiful = require "beautiful"
local naughty = require "naughty"
local ruled = require "ruled"
local menubar = require "menubar"
local hotkeys_popup = require "awful.hotkeys_popup"

require "awful.hotkeys_popup.keys"

naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification {
		urgency = "critical",
		title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
		message = message,
	}
end)

SELECTED_THEME = "default"
TERMINAL = os.getenv "TERMINAL"
EDITOR = os.getenv "EDITOR"
EDITOR_CMD = TERMINAL .. " -e " .. EDITOR
MODKEY = "Mod4"
SELECTED_THEME_PATH = gears.filesystem.get_themes_dir() .. SELECTED_THEME

beautiful.init(SELECTED_THEME_PATH .. "/theme.lua")

require("utils.soundcontrols").setup_evenloop(4)

local wallpaper = require "wallpaper"
wallpaper.setup_wallpaper()

local tags = require "tags"
tags.setup_tags()

local topbar = require "topbar"
topbar:setup_bar()

local topbar_widgets = require "topbar_widgets"
table.insert(topbar.right_widgets, topbar_widgets.languagebox())
table.insert(topbar.right_widgets, topbar_widgets.packages())
table.insert(topbar.right_widgets, topbar_widgets.volume())
table.insert(topbar.right_widgets, topbar_widgets.calendar())
table.insert(topbar.right_widgets, topbar_widgets.clock())

table.insert(topbar.center_widgets, topbar_widgets.taglist)

require "naughty_config"
