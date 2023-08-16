local xresources = require "beautiful.xresources"
local dpi = xresources.apply_dpi

local theme_assets_path = SELECTED_THEME_PATH .. "/assets/"
local gshape = require "gears.shape"
local textbuilder = require "utils.text_builder"

local theme = {}

-- BASE COLORS
theme.background_color = "#121A24"
theme.em_background_color = "#1B2736"
theme.background_color_shadow = "#0E141C"
theme.border_color = "#606469"
theme.font_color = "#c5c3c6"
theme.transparency = "#00000000"

--BASE SHAPES
theme.rounded_rect = function(cr, w, h)
	gshape.rounded_rect(cr, w, h, 5)
end

-- BASE MARGINS
theme.margins = 3
--BASE FONTS
theme.topbar_font = "Rubik, Symbols Nerd Font Mono 10"
theme.font = "Tektur, Symbols Nerd Font Mono 9"

-- WIBAR CONFIG
theme.icon_color_1 = "#1985a1"
theme.icon_color_2 = "#6DFF96"
theme.icon_color_3 = "#E14F4F"

theme.wibar_theme = {
	bg = theme.background_color,
	height = 30,
	border_color = nil,
	border_width = 0,
	shape = theme.rounded_rect,
	wrapper = {
		padding = 5,
	},
}

theme.calendar_theme = {
	bar = {
		fmt = function()
			local calendar_icon = textbuilder
				.new()
				:append("")
				:set_fg_color(theme.icon_color_2)
				:set_font_weight("ultrabold")
				:set_rise(1.5)
				:build()

			local calendar_format =
				textbuilder.new():append("%d.%m.%Y"):set_fg_color(theme.font_color):set_font_weight("500"):build()
			return textbuilder
				.new()
				:append(calendar_icon)
				:space()
				:set_font_size(10)
				:set_font_family(theme.topbar_font)
				:append(calendar_format)
				:build()
		end,
	},
	popup = {
		header = {
			bg = theme.em_background_color,
			shape = theme.rounded_rect,
			padding = theme.margins,
		},
		focus = {
			border_color = "#00a511",
			border_width = 1,
			shape = theme.rounded_rect,
			padding = 3,
		},
		day = {
			border_color = theme.em_background_color,
			border_width = 1,
			shape = theme.rounded_rect,
			padding = 3,
		},
		bg = theme.background_color,
		shape = theme.rounded_rect,
		padding = 10,
		border_color = "#6DFF96",
		border_width = 1,
	},
	font = theme.topbar_font,
}

theme.volume_bar_theme = {
	timeout = 4,
	bar = {
		size = {
			width = 75,
		},
		squish = {
			top = 3,
			bottom = 3,
		},
		bar_shape = theme.rounded_rect,
		bar_color = theme.icon_color_2,
		shadow_color = theme.background_color_shadow,
		max_value = 100,
	},
	icon = {
		variants = {
			theme_assets_path .. "audio-volume-muted.svg",
			theme_assets_path .. "audio-volume-low.svg",
			theme_assets_path .. "audio-volume-medium.svg",
			theme_assets_path .. "audio-volume-high.svg",
		},
	},
	spacing = 5,
}

-- NOTIFICATIONS
theme.notifications = {
	default = {
		general = {
			box_shape = theme.rounded_rect,
			max_width = 300,
			position = "top_right",
			box_border_width = 2,
			box_border_color = theme.em_background_color,
			bg = theme.background_color_shadow,
		},
		header = {
			bg = theme.background_color,
		},
		title = {},
		action_list = {
			button = {
				name = {
					align = "center",
					fmt = function(text)
						return textbuilder.new():append(text):set_font_size(10):set_font_weight("500"):build()
					end,
				},
				icon = {
					box_sizing = "border_box",
					size = 16,
				},
				margin = 5,
				bg = theme.em_background_color,
				padding = 3,
				shape = theme.rounded_rect,
			},
			bg = theme.background_color,
		},
		app_icon = {
			size = 20,
			padding = 4,
		},
		app_name = {
			align = "center",
			fmt = function(text)
				return textbuilder.new():append(text):set_font_size(12):set_font_weight("500"):build()
			end,
		},
		message = {
			max_height = 100,
		},
		image = {
			max_width = 64,
			max_height = 64,
		},
	},
	-- CRITICAL BG  #F95858
	-- CRITICAL LIGHT #F97878
}

theme.text_clock_theme = {
	fmt = function()
		local clock_icon = textbuilder
			.new()
			:append("")
			:set_fg_color(theme.icon_color_1)
			:set_font_weight("ultrabold")
			:set_rise(1.5)
			:build()
		local clock_format =
			textbuilder.new():set_font_weight("500"):set_fg_color(theme.font_color):append("%H:%M"):build()

		return textbuilder
			.new()
			:append(clock_icon)
			:space()
			:append(clock_format)
			:set_font_family(theme.topbar_font)
			:set_font_size(10)
			:build()
	end,
}

theme.wallpaper = theme_assets_path .. "wallpaper.jpg"

-- MARGINS
theme.useless_gaps = dpi(5)
theme.wibar_margins = dpi(5)

return theme
