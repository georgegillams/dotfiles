#!/bin/bash

# Wrapper around switch-audio.swift that compiles the binary on first use.
# Usage: switch-audio.sh [args...]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SWIFT_SRC="$SCRIPT_DIR/switch-audio.swift"
BINARY="$SCRIPT_DIR/switch-audio"

if [ ! -f "$BINARY" ] || [ "$SWIFT_SRC" -nt "$BINARY" ]; then
    swiftc "$SWIFT_SRC" -o "$BINARY"
fi

"$BINARY" "$@"
