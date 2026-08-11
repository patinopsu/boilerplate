#!/usr/bin/env bash

echo "Niri Screenshot Utility"

set -e

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILENAME="Screenshot $(date '+%Y-%m-%d %H%M%S').png"
FILEPATH="$DIR/$FILENAME"

MODE="$1"

notify() {
  notify-send -a "Screenshots" "Screenshot Taken" "$FILEPATH"
}

copy_clipboard() {
  wl-copy < "$FILEPATH"
}

case "$MODE" in
  full)
    # Uses grim to snapshot the currently focused output
    FOCUSED_OUTPUT=$(niri msg --json focused-output | jq -r '.name')
    grim -c -o "$FOCUSED_OUTPUT" "$FILEPATH"
    ;;

  region)
    # Let the user click and drag a bounding box
    grim -g "$(slurp)" "$FILEPATH"
    ;;

  window)
    # Let the user click a specific window to snapshot it
    # (slurp -0 tells it to select layout objects like windows)
    grim -g "$(slurp -0)" "$FILEPATH"
    ;;

  *)
    echo "Usage: screenshot.sh {full|region|window}"
    exit 1
    ;;
esac

copy_clipboard
notify
