---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = { "us", "ua" },
		kb_variant = "",
		kb_model = "",
		kb_options = "compose:caps, grp:alt_space_toggle",
		kb_rules = "",

		follow_mouse = 1,
		sensitivity = 0.3,
		accel_profile = "adaptive",

		touchpad = {
			natural_scroll = false,
			clickfinger_behavior = true,
			scroll_factor = 0.7,
			drag_3fg = 1,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "tpps/2-ibm-trackpoint",
	sensitivity = 0.5,
	accel_profile = "flat",
})

-- hl.cursor({
-- 	zoom_rigid = true,
-- 	zoom_detached_camera = false,
-- })

-- hl.window_rule({ match = { class = "kitty" }, scroll_touchpad = 1.5 })
