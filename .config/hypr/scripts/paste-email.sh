#!/usr/bin/env bash
set -euo pipefail

email='tchirkov.petter@gmail.com'

# Copy the email and trigger Hyprland's universal paste shortcut.
printf '%s' "$email" | wl-copy
sleep 0.05
hyprctl dispatch sendshortcut SHIFT, Insert, activewindow
