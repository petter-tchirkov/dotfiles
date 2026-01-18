#!/usr/bin/env bash
set -euo pipefail

# Ensure Hyprland is available before proceeding.
if ! command -v hyprctl >/dev/null 2>&1; then
    echo "hyprctl command not found. This script requires Hyprland." >&2
    exit 1
fi

current_workspace=""
if command -v jq >/dev/null 2>&1; then
    current_workspace="$(hyprctl activeworkspace -j 2>/dev/null | jq -r '.id' 2>/dev/null || echo "")"
fi

launch_on_workspace() {
    local workspace="$1"
    shift

    if [[ -z "${workspace}" || $# -eq 0 ]]; then
        echo "launch_on_workspace requires a workspace number and a command." >&2
        return 1
    fi

    # Move to the requested workspace, give Hyprland a brief moment to settle,
    # launch the command, then wait a beat so the window attaches to that workspace.
    hyprctl dispatch workspace "${workspace}"
    sleep 0.2
    hyprctl dispatch exec "$*"
    sleep 0.2
}

launch_on_workspace 1 gtk-launch dev.zed.Zed
launch_on_workspace 3 gtk-launch slack
launch_on_workspace 5 kitty --hold zsh -lc "$HOME/run_dev.sh"

if [[ -n "${current_workspace}" ]]; then
    sleep 0.2
    hyprctl dispatch workspace "${current_workspace}"
fi

echo "Requested applications have been launched."
