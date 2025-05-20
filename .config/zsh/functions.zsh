# Makes a directory and changes to it.
function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Changes to a directory and lists its contents.
function cdls {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

function d() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function yazi_zed() {
	local tmp="$(mktemp -t "yazi-chooser.XXXXX")"
	yazi "$@" --chooser-file="$tmp"

	local opened_file="$(cat -- "$tmp" | head -n 1)"
	zeditor -- "$opened_file"

	rm -f -- "$tmp"
	exit
}
