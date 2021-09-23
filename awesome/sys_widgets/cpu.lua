local wibox         = require("wibox")
local awful         = require("awful")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local gears         = require("gears")
local cairo         = require("lgi").cairo
local module_path = (...):match ("(.+/)[^/]+$") or ""

local theme = beautiful.get()

function dbg(message)
    naughty.notify({ preset = naughty.config.presets.normal,
                     title = "debug",
                     text = message })
end

local cpu = {}
local function worker(args)
    local args = args or {}

    widgets_table = {}
    local connected = false

    -- Settings
    local ICON_DIR      = awful.util.getdir("config").."/"..module_path.."/sys_widgets/icons/"
    local timeout       = args.timeout or 5
    local font          = args.font or beautiful.font
    local popup_signal  = args.popup_signal or false
    local popup_position = args.popup_position or naughty.config.defaults.position
    local onclick       = args.onclick
    local widget        = args.widget == nil and wibox.layout.fixed.horizontal() or args.widget == false and nil or args.widget
    local indent        = args.indent or 3
    local popup_metrics	= args.popup_metrics or false

	local cpumodel		= args.cpumodel
	local processes		= args.processes or 10


    local net_icon = wibox.widget.imagebox(ICON_DIR.."cpu.png")
    local net_text = wibox.widget.textbox()
    net_text.font = font
    net_text:set_text(" N/A ")
    local signal_level = "fuck"
    local function net_update()
        awful.spawn.easy_async("/home/izzy/.config/scripts/cpu.sh", function(stdout, stderr, reason, exit_code)
          signal_level = stdout
        end)
		net_text:set_text(" "..tostring(signal_level))
    end

    net_update()
    local timer = gears.timer.start_new( timeout, function () net_update()
      return true end )

    widgets_table["imagebox"]	= net_icon
    widgets_table["textbox"]	= net_text
    if widget then
            widget:add(net_icon)
            -- Hide the text when we want to popup the signal instead
            if not popup_signal then
                    widget:add(net_text)
            end
            cpu:attach(widget,{onclick = onclick})
    end

	i = 0


    local function text_grabber()
        local msg = ""
		local stat = {"USER	PID	CPU%	TIME	COMMAND"}
		local model_name = "N/A"

		-- Use iw/ip
		f = io.popen("cat /proc/cpuinfo")
		for line in f:lines() do
			model_name   = string.match(line, "model name	: (.+)") or model_name
		end
		f:close()

		f = io.popen("ps aux --sort %cpu | tac")
		for line in f:lines() do
			temp = {}
			for str in string.gmatch(line, "([^".."%s".."]+)") do
				table.insert(temp, str)
			end
			table.insert(stat, temp[1].."	"..temp[2].."	"..temp[3].."%	"..temp[10].."	"..temp[11])
		end
		f:close()

		msg =
			"┌["..model_name.."]\n"

		for i = 1,processes do
			if i == processes then
				msg = msg.."└"..stat[i].."\n"
			else
				msg = msg.."├"..stat[i].."\n"
			end
		end

        return msg
    end

    local notification = nil
    function cpu:hide()
            if notification ~= nil then
                    naughty.destroy(notification)
                    notification = nil
            end
    end

    function cpu:show(t_out)
            cpu:hide()

            notification = naughty.notify({
                    preset = fs_notification_preset,
                    text = text_grabber(),
                    timeout = t_out,
            screen = mouse.screen,
            position = popup_position
            })
    end
    return widget or widgets_table
end

function cpu:attach(widget, args)
    local args = args or {}
    local onclick = args.onclick
    -- Bind onclick event function
    if onclick then
            widget:buttons(awful.util.table.join(
            awful.button({}, 1, function() awful.util.spawn(onclick) end)
            ))
    end
    widget:connect_signal('mouse::enter', function () cpu:show(0) end)
    widget:connect_signal('mouse::leave', function () cpu:hide() end)
    return widget
end

return setmetatable(cpu, {__call = function(_,...) return worker(...) end})
