local module_path = (...):match ("(.+/)[^/]+$") or ""

package.loaded.sys_widgets = nil

local sys_widgets = {
    cpu			= require(module_path .. "sys_widgets.cpu"),
    mem			= require(module_path .. "sys_widgets.mem"),
    bat			= require(module_path .. "sys_widgets.battery"),
}

return sys_widgets
