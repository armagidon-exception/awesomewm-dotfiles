local M = {}

local Builder = {}

function M.new()
    local dt = {
        text = "",
        font_family = nil,
        font_size = 0,
        weight = nil,
        fgcolor = nil,
        rise = 0,
        underline_style = nil,
        underline_color = nil,
    }
    return setmetatable(dt, { __index = Builder })
end

local function require_string(str, msg)
    msg = msg or "Parameter cannot be null"
    str = str or error(msg)
    if type(str) ~= "string" then
        str = tostring(str)
    end
    return str
end

local function require_number(number, msg)
    msg = msg or "Parameter must be a number"
    if type(number) ~= "number" then
        error(msg)
    end
    return number
end

function Builder:append(text)
    text = text or error "Text cannot be null"
    if type(text) ~= "string" then
        text = tostring(text)
    end
    self.text = self.text .. text
    return self
end

function Builder:space()
    return self:append " "
end

function Builder:set_font_family(font_family)
    font_family = require_string(font_family, "Font Family cannot be null")
    self.font_family = font_family
    return self
end

function Builder:set_font_size(size)
    size = require_number(size, "Font size must be a number")
    self.font_size = size
    return self
end

function Builder:set_font_weight(weight)
    weight = require_string(weight, "Weight cannot be nil")
    self.weight = weight
    return self
end

function Builder:set_fg_color(color)
    color = require_string(color, "Foreground color cannot be null")
    self.fgcolor = color
    return self
end

function Builder:set_rise(rise)
    rise = require_number(rise, "Font rise must be a number")
    self.rise = rise
    return self
end

function Builder:set_underline_style(style)
    style = require_string(style, "Underline style cannot be nil")
    self.underline_style = style
    return self
end

function Builder:set_underline_color(color)
    color = require_string(color, "Underline color cannot be nil")
    self.underline_color = color
    return self
end

function Builder:build()
    local output = "<span "
    if self.font_family then
        output = output .. "font_family='" .. self.font_family .. "' "
    end
    if self.font_size > 0 then
        output = output .. "font_size='" .. self.font_size .. "pt' "
    end
    if self.weight then
        output = output .. "weight='" .. self.weight .. "' "
    end
    if self.fgcolor then
        output = output .. "color='" .. self.fgcolor .. "' "
    end
    if self.rise > 0 then
        output = output .. "rise='" .. self.rise .. "pt' "
    end
    if self.underline_color then
        output = output .. "underline_color='" .. self.underline_color .. "' "
    end 
    if self.underline_style then
        output = output .. "underline='" .. self.underline_style .. "' "
    end
    output = output .. ">" .. self.text .. "</span>"
    return output
end

return M
