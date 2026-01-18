#!/bin/bash

# Get the list of directories in ~/.config, excluding the trailing slash
# and then get just the directory name.
config_dirs=$(find -L ~/.config -maxdepth 1 -mindepth 1 -type d -printf '%f\n')

# Pipe the list of directories to Rofi
selected_dir=$(echo "$config_dirs" | rofi -dmenu -p "Config")

# If a directory is selected, open it in Neovim
if [ -n "$selected_dir" ]; then
    kitty nvim ~/.config/"$selected_dir"
fi
