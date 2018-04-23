local awful = require("awful")
local config = require("config")
local gears = require("gears")

WidgetPopup = {}
WidgetPopup.__index = WidgetPopup

function WidgetPopup:new(options)
    local wibar = awful.wibar {
        width = options.width,
        height = options.height,
        opacity = config.panel_opacity,
        visible = false,
    }

    local widget_popup = {
        wibar = wibar,
        initialized = false,
    }

    setmetatable(widget_popup, WidgetPopup)
    return widget_popup
end

function WidgetPopup:setup(...)
    self.wibar:setup(...)
end

function WidgetPopup:on_open()

end

function WidgetPopup:on_close()

end

function WidgetPopup:toggle()
    if not self.initialized then
        self:initialize()
        self.initialized = true
    end

    self.wibar.visible = not self.wibar.visible

    if self.wibar.visible then
        awful.placement.under_mouse(self.wibar)
        awful.placement.no_offscreen(self.wibar)

        self:on_open()
    else
        self:on_close()
    end
end