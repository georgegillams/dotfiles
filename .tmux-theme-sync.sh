#!/bin/bash
# Sync tmux status bar colours with macOS dark/light mode.
# Called at config load via run-shell, and periodically via #() in status-right.

if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -qi dark; then
    ACCENT="colour39"   # cyan
    MID="colour240"     # mid grey
    DIM="colour235"     # dark grey
    BG="colour233"      # near-black
    TEXT="colour252"    # light grey
else
    ACCENT="colour30"   # dark teal (visible on light bg)
    MID="colour247"     # medium grey
    DIM="colour252"     # light grey
    BG="colour255"      # white
    TEXT="colour235"    # dark grey
fi

CURRENT=$(tmux show-option -gqv @bg 2>/dev/null)
[ "$CURRENT" = "$BG" ] && exit 0

tmux set-option -g @accent "$ACCENT"
tmux set-option -g @mid    "$MID"
tmux set-option -g @dim    "$DIM"
tmux set-option -g @bg     "$BG"
tmux set-option -g @text   "$TEXT"

tmux set-option -g status-style                "fg=$TEXT,bg=$BG"
tmux set-option -g pane-border-style           "fg=$DIM"
tmux set-option -g pane-active-border-style    "fg=$ACCENT"
tmux set-option -g display-panes-colour        "$DIM"
tmux set-option -g display-panes-active-colour "$ACCENT"
tmux set-option -g clock-mode-colour           "$ACCENT"
tmux set-option -g message-style               "fg=$BG,bg=$ACCENT"
tmux set-option -g message-command-style       "fg=$TEXT,bg=$DIM"
tmux set-option -g mode-style                  "fg=$BG,bg=$ACCENT"
