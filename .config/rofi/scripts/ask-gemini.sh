#!/bin/bash

# Rofi script to ask a question to Gemini with a thinking indicator and styling

# Path to the theme file, assuming it's in the same directory as the script
THEME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
THEME="$THEME_DIR/gemini-style.rasi"

# Get the question from the user using Rofi
question=$(rofi -dmenu -p "Ask Gemini:" -theme "$THEME")

# If the user entered a question, send it to Gemini
if [ -n "$question" ]; then
    # Show a "thinking" message in a background rofi process
    rofi -theme "$THEME" -e "🤔 Thinking..." &
    rofi_pid=$!

    # Ensure the "thinking" rofi process is killed when the script exits
    trap "kill $rofi_pid 2>/dev/null" EXIT

    # Run gemini and capture the output
    answer=$(/home/theonlyvoivod/.local/share/pnpm/gemini -p "$question")

    # Kill the "Thinking..." rofi window cleanly
    kill $rofi_pid 2>/dev/null
    wait $rofi_pid 2>/dev/null

    # Display the answer in a new rofi window
    rofi -theme "$THEME" -e "$answer"
fi
