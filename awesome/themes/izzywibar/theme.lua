
local gears			= require("gears")
local lain  		= require("lain")
local awful 		= require("awful")
local wibox 		= require("wibox")
local net_widgets	= require("net_widgets")
local sys_widgets	= require("sys_widgets")

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
local terminal = "alacritty"

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/izzywibar"
theme.wallpaper                                 = theme.dir .. "/ramiel.png"
theme.font                                      = "Fira Code 12"
theme.iconfont									= "Fira Code 30"
theme.taglist_font                              = "Fira Code Italic 11"
theme.fg_normal                                 = "#ffffff"
theme.fg_focus                                  = color1
theme.fg_urgent                                 = "#b74822"
theme.bg_normal                                 = "#333232"
theme.bg_focus                                  = "#FF79C6"
theme.bg_urgent                                 = "#3F3F3F"
theme.taglist_fg_focus                          = "#282a36"
theme.tasklist_bg_focus                         = "#000000"
theme.tasklist_fg_focus                         = color1
theme.border_width                              = 2
theme.border_normal                             = "#282a36"
theme.border_focus                              = theme.bg_focus
theme.border_marked                             = "#CC9393"
theme.titlebar_bg_focus                         = "#3F3F3F"
theme.titlebar_bg_normal                        = "#3F3F3F"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_height                               = 50
theme.menu_width                                = 140
theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 3

local markup = lain.util.markup
local separators = lain.util.separators

-- Textclock
local clock = awful.widget.watch(
    "date +'%e, %b %Y - %R'", 60,
    function(widget, stdout)
        widget:set_markup("" .. markup.font(theme.font, stdout))
    end
)
-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { clock },
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

local battery = awful.widget.watch(
    os.getenv("HOME").."/.config/scripts/battery.rb", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

local batteryw = awful.widget.watch(
	os.getenv("HOME").."/.config/scripts/battery.rb", 60,
	function(widget, stdout)
		widget:set_markup(" " .. markup.font(theme.font, stdout))
	end
)

-- MEM
local mem = awful.widget.watch(
    os.getenv("HOME").."/.config/scripts/mem.sh", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout) .. "fuck")
    end
)

-- ALSA volume
theme.volume = lain.widget.alsabar({
    --togglechannel = "IEC958,3",
    notification_preset = { font = theme.font, fg = theme.fg_normal },
})

local net_wireless = net_widgets.wireless({
	interface		= "wlp4s0",
	popup_signal	= true,
	onclick			= os.getenv("HOME").."/.config/rofi/wifi/wifi.rb",
})

local cpu = sys_widgets.cpu({
	popup_signal	= false,
	timeout			= 2,
	processes		= 20,
  onclick       = terminal .. " -e htop"
})

local mem = sys_widgets.mem({
	popup_signal	= false,
	timeout			= 2,
	processes		= 20,
})

local batteryw = sys_widgets.bat({
	popup_signal	= false,
	timeout			= 2,
	processes		= 20,
})


--[[ Coretemp (lm_sensors, per core)
local tempwidget = awful.widget.watch({awful.util.shell, '-c', 'sensors | grep Core'}, 30,
function(widget, stdout)
    local temps = ""
    for line in stdout:gmatch("[^\r\n]+") do
        temps = temps .. line:match("+(%d+).*°C")  .. "° " -- in Celsius
    end
    widget:set_markup(markup.font(theme.font, " " .. temps))
end)
--]]
-- Coretemp (lain, average)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
    end
})
--]]
local tempicon = wibox.widget.imagebox(theme.widget_temp)

--[[ Weather
https://openweathermap.org/
Type in the name of your city
Copy/paste the city code in the URL to this file in city_id
--]]
local weathericon = wibox.widget.imagebox(theme.widget_weather)
theme.weather = lain.widget.weather({
    city_id = 2647793, -- guildford
    notification_preset = { font = "Mononoki Nerd Font 11", fg = theme.fg_normal },
    weather_na_markup = markup.fontfg(theme.font, "#ffffff", "N/A "),
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.fontfg(theme.font, "#ffffff", descr .. " @ " .. units .. "°C "))
    end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. volume_now.level .. "% "))
    end
})

-- Separators
local arrow = separators.arrow_left
function theme.powerline_rl(cr, width, height)
    local arrow_depth, offset = height/2, 0

    -- Avoid going out of the (potential) clip area
    if arrow_depth < 0 then
        width  =  width + 2*arrow_depth
        offset = -arrow_depth
    end

    cr:move_to(offset + arrow_depth         , 0        )
    cr:line_to(offset + width               , 0        )
    cr:line_to(offset + width - arrow_depth , height/2 )
    cr:line_to(offset + width               , height   )
    cr:line_to(offset + arrow_depth         , height   )
    cr:line_to(offset                       , height/2 )

    cr:close_path()
end

local function pl(widget, bgcolor, padding)
    return wibox.container.background(wibox.container.margin(widget, 16, 16), bgcolor, theme.powerline_rl)
end

function theme.at_screen_connect(s)
    -- Quake application
   -- s.quake = lain.util.quake({ app = awful.util.terminal })
   s.quake = lain.util.quake({ app = "termite", height = 0.50, argname = "--name %s" })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- All tags open with layout 1
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    --s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 30, bg = theme.bg_normal.."d5", fg = theme.fg_normal })

	local color1 = "#FF79C6"
	local color2 = "#9686C3"
	--beautiful.bg_systray = color2
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            s.mytaglist,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        {
            layout = wibox.layout.fixed.horizontal,
				arrow("alpha", color1),
				arrow(color1, color2),
				arrow(color2, color1),
				arrow(color1, color2),
				arrow(color2, color1),
            --wibox.container.background(wibox.container.margin(wibox.widget { volicon, theme.volume.widget, layout = wibox.layout.align.horizontal }, 2, 3), color1),
				arrow(color1, color2),
            wibox.container.background(wibox.container.margin(mem, 8, 12), color2),
				arrow(color2, color1),
            wibox.container.background(wibox.container.margin(cpu, 8, 12), color1),
				arrow(color1, color2),
            wibox.container.background(wibox.container.margin(battery, 4, 8), color2),
            wibox.container.background(wibox.container.margin(batteryw, 4, 8), color2),
				arrow(color2, color1),
            wibox.container.background(wibox.container.margin(clock, 8, 12), color1),
				arrow(color1, color2),
            wibox.container.background(wibox.container.margin(nil, 4, 8), color2),
            wibox.widget.systray(),
            wibox.container.background(wibox.container.margin(net_wireless, 4, 14), color2),
				arrow(color2, "alpha"),
            s.mylayoutbox,
        },
    }
end

return theme
