local config = {}
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local file = require("util/file")

config.home_path = os.getenv("HOME") .. "/"
config.awesome_config = gears.filesystem.get_configuration_dir()

config.theme_path = config.awesome_config .. "theme.lua"
config.wallpaper = file.get_random_in_dir(config.home_path .. "backgrounds/active/")

config.modkey = "Mod4"

config.program_shortcuts = {
    {
        modifier = { config.modkey },
        key = "Return",
        exec = "termite"
    },
    {
        modifier = { config.modkey },
        key = "backslash",
        exec = "firefox"
    },
    {
        modifier = { config.modkey },
        key = "bracketright",
        exec = "termite -e ranger"
    },
    {
        modifier = { config.modkey },
        key = "p",
        exec = "code"
    },
    {
        modifier = { config.modkey },
        key = "Next",
        exec = "gnome-system-monitor"
    },
    {
        modifier = { config.modkey },
        key = "bracketleft",
        exec = "spotify"
    },
}

config.tags = { "web", "dev", "term", "spotify", "steam", "misc" }

config.startup_programs = {
    "numlockx",
    "nm-applet",
    "ibus-daemon -d",
    "sh -c 'sleep 30; exec bcnotif'"
}

config.widgets = {
    cpu_usage = {
        update_time_secs = 1.5,
    },
    system_status = {
        startup_delay_secs = 30,
        update_time_hours = 2,
    },
    battery = {
        update_time_secs = 10,
        charged_color = "#009902",
        charging_color = "#00ff00",
    },
    volume = {
        update_time_secs = 15,
        spotify_update_time_secs = 5,
    },
    disk_usage = {
        partitions = { "/" },
        update_time_secs = 30,
        space_between_partitions = 20,
    },
    ram = {
        update_time_secs = 1.5,
    },
    separator = {
        left_text = "[ ",
        middle_text = " ][ ",
        right_text = " ]",
    },
}

config.clock_format = "%a %b %d, %H:%M:%S"
config.panel_opacity = 0.8

config.floating_windows = {
    class = {
        "steam",
    }
}

config.audio_source = "Master"

config.dev_environment = os.getenv("AWESOME_DEV") == "1"

return config