#!/bin/bash

# Wrapper around play-on-device.swift that compiles the binary on first use.
# Usage: play-sound.sh <file> <device-name>

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SWIFT_SRC="$SCRIPT_DIR/play-on-device.swift"
BINARY="$SCRIPT_DIR/play-on-device"

if [ ! -f "$BINARY" ] || [ "$SWIFT_SRC" -nt "$BINARY" ]; then
    swiftc "$SWIFT_SRC" -o "$BINARY"
fi

"$BINARY" "$@"
