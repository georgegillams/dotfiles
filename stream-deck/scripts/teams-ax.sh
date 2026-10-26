#!/bin/bash

# Wrapper around teams-ax.swift that compiles the binary on first use.
# Usage: teams-ax.sh <command> [args...]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SWIFT_SRC="$SCRIPT_DIR/teams-ax.swift"
BINARY="$SCRIPT_DIR/teams-ax"

if [ ! -f "$BINARY" ] || [ "$SWIFT_SRC" -nt "$BINARY" ]; then
    swiftc "$SWIFT_SRC" -o "$BINARY"
fi

"$BINARY" "$@"
