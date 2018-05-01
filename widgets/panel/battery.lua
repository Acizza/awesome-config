local battery = {}

local awful = require("awful")
local beautiful = require("beautiful")
local config = require("config")
local file = require("util/file")
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")
local widget = require("widgets/value_monitor")

local string_format = string.format

local widget_config = config.widgets.battery
local battery_location = "/sys/class/power_supply/BAT0/"

local BatteryState = {
    Charged = {
        color = widget_config.charged_color,
    },
    Charging = {
        color = widget_config.charging_color,
    },
    Discharging = {
        color = beautiful.warning_color,
    },
    Error = {},
}

local value_monitor = ValueMonitor:new {
    label = "BAT"
}

function value_monitor:on_set(stats)
    local charge_pcnt = stats.cur_charge / stats.max_charge * 100
    local values = {}

    if stats.state == BatteryState.Charged then
        values.formatted = string_format("%d%%", charge_pcnt)
    else
        values.formatted = string_format("%0.01f%%", charge_pcnt)
    end

    if charge_pcnt < 10 then
        values.value_color = beautiful.critical_color
    else
        values.value_color = stats.state.color
    end

    return values
end

battery.widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    value_monitor.textbox,
}

local function set_error(msg)
    --value_monitor:set_value(BatteryState.Error)

    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Error In Battery Widget",
        text = msg,
    })
end

local function update()
    local status_str = file.read(battery_location .. "status")
    local state

    if status_str == "Charging\n" or status_str == "Unknown\n" then
        state = BatteryState.Charging
    elseif status_str == "Full\n" then
        state = BatteryState.Charged
    elseif status_str == "Discharging\n" then
        state = BatteryState.Discharging
    else
        set_error("unknown battery state: " .. status_str)
        return
    end

    local stats = {
        cur_charge = file.read(battery_location .. "charge_now"),
        max_charge = file.read(battery_location .. "charge_full"),
        state = state,
    }

    value_monitor:set_value(stats)
end

update()

gears.timer {
    timeout = widget_config.update_time_secs,
    autostart = true,
    callback = update,
}

return battery