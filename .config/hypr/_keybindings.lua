---------------------
---- KEYBINDINGS ----
---------------------

local terminal = "kitty"
local fileManager = "nautilus"

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("omarchy-launch-browser"))

hl.bind("SUPER + SHIFT + Y", hl.dsp.exec_cmd("omarchy-launch-webapp 'https://youtube.com/'"))

hl.unbind("SUPER + W")
hl.unbind("SUPER + K")
hl.unbind("SUPER + H")
hl.unbind("SUPER + L")
hl.unbind("SUPER + J")
hl.unbind("SUPER + F")
hl.unbind("SUPER + ALT + F")

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + K", hl.dsp.exec_cmd("omarchy-menu-keybindings"))

hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))

hl.bind("SUPER + SHIFT + SPACE", hl.dsp.exec_cmd("omarchy-menu"))

hl.bind("SUPER + SUPER_L", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + ALT_L", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("fullscreen, 0"))

hl.gesture({
	fingers = 2,
	direction = "pinch",
	action = "cursorZoom",
	zoom_level = 2,
	mode = "live",
	disable_inhibit = true,
})

hl.gesture({ fingers = 2, direction = "pinchin", action = "cursorZoom", zoom_level = 2.0, mode = "mult" })
hl.gesture({ fingers = 2, direction = "pinchout", action = "cursorZoom", zoom_level = 1, mode = "live" })
