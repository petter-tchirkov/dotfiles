require("smart-enter"):setup({
	open_multi = true,
})

require("no-status"):setup()

require("recycle-bin"):setup()

Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ""
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)

require("bunny"):setup({
	hops = {
		{ key = "/", path = "/" },
		{ key = "T", path = "/tmp" },
		{ key = "~", path = "~", desc = "Home" },
		{ key = { "p", "c" }, path = "~/Pictures", desc = "Pictures" },
		{ key = "d", path = "~/Downloads", desc = "Downloads" },
		{ key = { "d", "c" }, path = "~/Documents", desc = "Documents" },
		{ key = { "p", "r" }, path = "~/Projects", desc = "Projects" },
		{ key = "c", path = "~/.config", desc = "Config files" },
		{ key = { "l", "f" }, path = "~/dotfiles", desc = "" },
		{ key = { "l", "s" }, path = "~/.local/share", desc = "Local share" },
		{ key = { "o", "c" }, path = "~/.local/share/omarchy", desc = "Omarchy config" },
		{ key = { "l", "b" }, path = "~/.local/bin", desc = "Local bin" },
		{ key = { "l", "t" }, path = "~/.local/state", desc = "Local state" },
		{ key = { "t", "r" }, path = "~/.local/share/Trash/files", desc = "Trash" },
		-- key and path attributes are required, desc is optional
	},
	desc_strategy = "path", -- If desc isn't present, use "path" or "filename", default is "path"
	ephemeral = true, -- Enable ephemeral hops, default is true
	tabs = true, -- Enable tab hops, default is true
	notify = true, -- Notify after hopping, default is false
	fuzzy_cmd = "fzf", -- Fuzzy searching command, default is "fzf"
})
