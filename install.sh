#!/bin/bash

# Get full path of the project folder
DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing ClickTrap..."

# Replace placeholder with actual path and copy to Desktop
sed "s|CLICKTRAP_PATH|$DIR|g" linux/clicktrap.desktop > "$HOME/Desktop/holiday_photo.desktop"

# Make Desktop launcher executable
chmod +x "$HOME/Desktop/holiday_photo.desktop"

# Trust the Desktop file
gio set "$HOME/Desktop/holiday_photo.desktop" metadata::trusted true

echo "ClickTrap installed! Check your Desktop for 'Holiday Photo'."
