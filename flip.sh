#!/usr/bin/env bash

# Switch between light and dark mode themes in Ghostty and Helix. 

SETTING="theme = "
GHOSTTY_CONFIG=$HOME/.config/ghostty/config
GHOSTTY_DARK="wilmersdorf"
GHOSTTY_LIGHT="Night Owlish Light"

HELIX_CONFIG=$HOME/.config/helix/config.toml
HELIX_DARK="\"carbonfox\""
HELIX_LIGHT="\"cyan_light\""

# Print usage.
usage() {
  echo "Switch between light and dark mode in Ghostty and Helix."
  echo
  echo "Usage: flip.sh [dark|light]"
  exit 1
}

# Replace first line in config file.
replace_first_line() {
    local file="$1"
    local newline="$2"
    local tmpfile
    tmpfile=$(mktemp)

    echo "$newline" > "$tmpfile"
    tail -n +2 "$file" >> "$tmpfile"

    # Overwrite target contents, keep symlink intact
    cat "$tmpfile" > "$file"
    rm "$tmpfile"
}

MODE="$1"
case "$MODE" in
    dark)
        GHOSTTY_THEME="$GHOSTTY_DARK"
        HELIX_THEME="$HELIX_DARK"
        ;;
    light)
        GHOSTTY_THEME="$GHOSTTY_LIGHT"
        HELIX_THEME="$HELIX_LIGHT"
        ;;
    *)
        usage
        ;;
esac

# Change themes.
replace_first_line "$GHOSTTY_CONFIG" "$SETTING$GHOSTTY_THEME"
replace_first_line "$HELIX_CONFIG"  "$SETTING$HELIX_THEME"

# Launch ghostty (detached from current shell).
nohup ghostty >/dev/null 2>&1 &
disown

exec exit
