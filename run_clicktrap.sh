#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"

xdg-open "$DIR/assets/photo.jpg"
python3 "$DIR/awareness.py"
